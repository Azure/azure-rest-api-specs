import path from "node:path";
import { normalizeTcgcContract } from "./tcgc-contract.mjs";
import { parseArgs, isMain, readJson, runMain, writeJson } from "./cli.mjs";
import { canonicalJson, stableId } from "./stable-id.mjs";
import {
  publicParameterContract,
  semanticLroContract,
  typeIdentity,
} from "./sdk-method-delta.mjs";

function loadInputs(options) {
  const manifestPath = typeof options.manifest === "string" ? path.resolve(options.manifest) : undefined;
  const workRoot = path.resolve(options.workRoot ?? (manifestPath ? path.dirname(manifestPath) : process.cwd()));
  return {
    workRoot,
    manifest: typeof options.manifest === "object" ? options.manifest : readJson(manifestPath),
    sourceIndex: options.sourceIndex ?? readJson(path.join(workRoot, "source", "source-index.json")),
  };
}

function artifactReady(artifact) {
  return artifact && (!artifact.status || artifact.status === "succeeded") && artifact.files?.length;
}

function evidence(project, sourceIndex) {
  const sourceById = new Map(sourceIndex.sourceChanges.map((item) => [item.id, item]));
  const sourceChangeIds = (project.sourceChangeIds ?? []).filter((id) => sourceById.has(id)).sort();
  const sources = sourceChangeIds.map((id) => sourceById.get(id));
  const declarations = sources.flatMap((item) => item.declarations ?? []);
  return {
    sourceChangeIds,
    declarationIds: declarations.map((item) => item.id).filter(Boolean).sort(),
    declarations,
    sources,
  };
}

function candidateEvidence(source, symbol, before, after, kind, detail) {
  const names = new Set();
  const memberNames = new Set();
  const addName = (value) => {
    if (typeof value === "string" && value.trim()) names.add(value.trim());
  };
  for (const value of [symbol, before, after]) {
    if (typeof value === "string") {
      addName(value);
      continue;
    }
    addName(value?.identity);
    addName(value?.crossLanguageDefinitionId);
    addName(value?.name);
    if (kind === "method" && value?.clientName && value?.name) {
      addName(`${value.clientName}.${value.name}`);
    }
  }
  if (detail?.name) {
    for (const value of [symbol, before?.identity, before?.name, after?.identity, after?.name]) {
      if (value) memberNames.add(`${value}.${detail.name}`);
    }
  }
  const matchesName = (qualifiedName, expectedNames) => {
    if (!qualifiedName) return false;
    return [...expectedNames].some((name) =>
      qualifiedName === name ||
      qualifiedName.endsWith(`.${name}`) ||
      name.endsWith(`.${qualifiedName}`));
  };
  let declarations = source.declarations.filter((item) =>
    matchesName(item.qualifiedName, memberNames.size ? memberNames : names));
  if (!declarations.length && memberNames.size) {
    declarations = source.declarations.filter((item) =>
      matchesName(item.qualifiedName, names));
  }
  if (!declarations.length) {
    return {
      sourceChangeIds: source.sources.length === 1 ? [source.sources[0].id] : [],
      declarationIds: [],
      hunkIds: [],
    };
  }
  const declarationIds = new Set(declarations.map((item) => item.id).filter(Boolean));
  return {
    sourceChangeIds: source.sources
      .filter((item) => (item.declarations ?? []).some((declaration) =>
        declarationIds.has(declaration.id)))
      .map((item) => item.id)
      .sort(),
    declarationIds: [...declarationIds].sort(),
    hunkIds: [...new Set(declarations.flatMap((item) => item.hunkIds ?? []))].sort(),
  };
}

function addFact(facts, projectId, comparisonRole, kind, value, artifactComparison) {
  const selection = artifactComparison?.[comparisonRole];
  const fact = {
    projectId,
    comparisonRole,
    sourceRevision: selection?.sourceRevision ?? (comparisonRole === "baseline" ? "base" : "current"),
    sourceCommit: selection?.commit,
    apiVersion: selection?.apiVersion,
    factKind: kind,
    ...value,
  };
  // Response headers are new graph evidence, not part of the established fact identity.
  const identityFact =
    kind === "method" && fact.operation
      ? {
          ...fact,
          operation: {
            ...fact.operation,
            responses: (fact.operation.responses ?? []).map(
              ({ headers: _headers, ...response }) => response,
            ),
            exceptions: (fact.operation.exceptions ?? []).map(
              ({ headers: _headers, ...response }) => response,
            ),
          },
        }
      : fact;
  const id = stableId("sdk-fact", identityFact);
  facts[id] = { ...fact, id };
  return id;
}

function same(left, right) {
  return left === undefined || right === undefined
    ? left === right
    : canonicalJson(left) === canonicalJson(right);
}

function unique(values) {
  return [...new Set(values.filter(Boolean))].sort();
}

function severity(rule) {
  return ["method-paging-changed", "method-lro-changed", "customization-changed"].includes(rule)
    ? "medium"
    : "high";
}

function candidateText(rule, symbol, detail) {
  let actual;
  switch (rule) {
    case "method-removed": actual = `${symbol} is no longer generated.`; break;
    case "method-identity-changed": actual = `${symbol} changed its generated SDK method name or identity.`; break;
    case "method-location-changed": actual = `${symbol} moved to a different client.`; break;
    case "method-kind-changed":
      actual = `${symbol} changed method kind${detail ? ` from ${detail.before} to ${detail.after}` : ""}.`;
      break;
    case "method-parameters-changed": actual = `${symbol} has a different ordered public parameter list.`; break;
    case "method-response-changed": actual = `${symbol} has a different response type.`; break;
    case "method-access-changed": actual = `${symbol} is no longer public.`; break;
    case "method-paging-changed": actual = `${symbol} changed paging behavior.`; break;
    case "method-lro-changed": actual = `${symbol} changed long-running behavior.`; break;
    case "model-property-removed": actual = `${symbol} no longer exposes property ${detail.name}.`; break;
    case "model-property-changed":
      actual = `${symbol}.${detail.name} changed type, optionality, flattening, or access.`;
      break;
    case "model-property-added-required": actual = `${symbol} added required property ${detail.name}.`; break;
    case "model-hierarchy-changed": actual = `${symbol} changed its base model or discriminator hierarchy.`; break;
    case "enum-values-removed": actual = `${symbol} removed enum values: ${detail.values.join(", ")}.`; break;
    case "enum-extensibility-changed": actual = `${symbol} changed enum extensibility.`; break;
    case "public-surface-changed": actual = `${symbol} changed public access, usage, or reachability.`; break;
    case "client-location-changed": actual = `${symbol} changed client ownership or name.`; break;
    case "customization-changed": actual = `${symbol} changed SDK customization decorators.`; break;
    default: throw new Error(`Unsupported downstream rule: ${rule}`);
  }
  return {
    actual,
    expected: `${symbol} preserves its existing language-neutral generated SDK contract.`,
  };
}

function pushCandidate(candidates, facts, source, projectId, rule, symbol, before, after, kind, detail) {
  const beforeFactId = before
    ? addFact(facts, projectId, "baseline", kind, before, source.artifactComparison)
    : undefined;
  const afterFactId = after
    ? addFact(facts, projectId, "target", kind, after, source.artifactComparison)
    : undefined;
  const text = candidateText(rule, symbol, detail);
  const ownership = candidateEvidence(source, symbol, before, after, kind, detail);
  const candidate = {
    rule,
    defaultSeverity: severity(rule),
    actual: text.actual,
    expected: text.expected,
    crossLanguageDefinitionId: symbol,
    sourceChangeIds: ownership.sourceChangeIds,
    declarationIds: ownership.declarationIds,
    hunkIds: ownership.hunkIds,
    evidenceFactIds: [beforeFactId, afterFactId].filter(Boolean),
    reviewRequired: true,
  };
  candidates.push({ id: stableId("downstream", candidate), ...candidate });
}

function compareMethods(projectId, base, current, source, facts, candidates) {
  const currentMethods = new Map(current.methods.map((item) => [item.identity, item]));
  const currentByHttp = new Map();
  for (const method of current.methods) {
    const protocol = method.operation;
    if (!protocol?.verb || !protocol?.path) continue;
    const key = `${protocol.verb}\u0000${protocol.path}`;
    const values = currentByHttp.get(key) ?? [];
    values.push(method);
    currentByHttp.set(key, values);
  }
  for (const before of base.methods) {
    let after = currentMethods.get(before.identity);
    if (!after && before.operation?.verb && before.operation?.path) {
      const matches = currentByHttp.get(`${before.operation.verb}\u0000${before.operation.path}`) ?? [];
      if (matches.length === 1) after = matches[0];
    }
    const symbol = before.crossLanguageDefinitionId ?? before.identity;
    if (!after) {
      pushCandidate(candidates, facts, source, projectId, "method-removed", symbol, before, undefined, "method");
      continue;
    }
    if (
      before.identity !== after.identity ||
      before.name !== after.name
    ) {
      pushCandidate(candidates, facts, source, projectId, "method-identity-changed", symbol, before, after, "method");
    }
    if (before.client !== after.client) {
      pushCandidate(candidates, facts, source, projectId, "method-location-changed", symbol, before, after, "method");
    }
    if (before.kind !== after.kind) {
      pushCandidate(
        candidates,
        facts,
        source,
        projectId,
        "method-kind-changed",
        symbol,
        before,
        after,
        "method",
        { before: before.kind, after: after.kind },
      );
    }
    if (!same(
      publicParameterContract(before.parameters),
      publicParameterContract(after.parameters),
    )) {
      pushCandidate(candidates, facts, source, projectId, "method-parameters-changed", symbol, before, after, "method");
    }
    if (!same(before.responseType, after.responseType)) {
      pushCandidate(candidates, facts, source, projectId, "method-response-changed", symbol, before, after, "method");
    }
    if (before.access === "public" && after.access !== "public") {
      pushCandidate(candidates, facts, source, projectId, "method-access-changed", symbol, before, after, "method");
    }
    if (!same(before.paging, after.paging)) {
      pushCandidate(candidates, facts, source, projectId, "method-paging-changed", symbol, before, after, "method");
    }
    if (!same(semanticLroContract(before.lro), semanticLroContract(after.lro))) {
      pushCandidate(candidates, facts, source, projectId, "method-lro-changed", symbol, before, after, "method");
    }
  }
}

function compareModels(projectId, base, current, source, facts, candidates) {
  const currentModels = new Map(current.models.map((item) => [item.identity, item]));
  for (const before of base.models.filter((item) => item.reachable)) {
    const after = currentModels.get(before.identity);
    const symbol = before.crossLanguageDefinitionId ?? before.identity;
    if (!after) {
      pushCandidate(candidates, facts, source, projectId, "public-surface-changed", symbol, before, undefined, "model");
      continue;
    }
    if (
      before.access !== after.access ||
      before.usage !== after.usage ||
      before.reachable !== after.reachable
    ) {
      pushCandidate(candidates, facts, source, projectId, "public-surface-changed", symbol, before, after, "model");
    }
    if (
      !same(before.baseModel, after.baseModel) ||
      !same(before.discriminatorProperty, after.discriminatorProperty) ||
      !same(before.discriminatorValue, after.discriminatorValue) ||
      !same(before.discriminatedSubtypes, after.discriminatedSubtypes)
    ) {
      pushCandidate(candidates, facts, source, projectId, "model-hierarchy-changed", symbol, before, after, "model");
    }
    const afterProperties = new Map(after.properties.map((item) => [item.name, item]));
    const beforeProperties = new Set(before.properties.map((item) => item.name));
    for (const property of before.properties) {
      const currentProperty = afterProperties.get(property.name);
      if (!currentProperty) {
        pushCandidate(
          candidates,
          facts,
          source,
          projectId,
          "model-property-removed",
          symbol,
          before,
          after,
          "model",
          { name: property.name },
        );
      } else if (canonicalJson(property) !== canonicalJson(currentProperty)) {
        pushCandidate(
          candidates,
          facts,
          source,
          projectId,
          "model-property-changed",
          symbol,
          before,
          after,
          "model",
          { name: property.name },
        );
      }
    }
    for (const property of after.properties) {
      if (!beforeProperties.has(property.name) && !property.optional) {
        pushCandidate(
          candidates,
          facts,
          source,
          projectId,
          "model-property-added-required",
          symbol,
          before,
          after,
          "model",
          { name: property.name },
        );
      }
    }
  }
}

function compareEnums(projectId, base, current, source, facts, candidates) {
  const currentEnums = new Map(current.enums.map((item) => [item.identity, item]));
  for (const before of base.enums.filter((item) => item.reachable)) {
    if (before.name === "Versions" || before.identity.endsWith(".Versions")) continue;
    const after = currentEnums.get(before.identity);
    const symbol = before.crossLanguageDefinitionId ?? before.identity;
    if (!after) {
      pushCandidate(candidates, facts, source, projectId, "public-surface-changed", symbol, before, undefined, "enum");
      continue;
    }
    const currentValues = new Set(after.values.map((item) => canonicalJson(item)));
    const removed = before.values.filter((item) => !currentValues.has(canonicalJson(item)));
    if (removed.length) {
      pushCandidate(
        candidates,
        facts,
        source,
        projectId,
        "enum-values-removed",
        symbol,
        before,
        after,
        "enum",
        { values: removed.map((item) => item.name ?? item.value) },
      );
    }
    if (before.isFixed !== after.isFixed || before.isUnionAsEnum !== after.isUnionAsEnum) {
      pushCandidate(candidates, facts, source, projectId, "enum-extensibility-changed", symbol, before, after, "enum");
    }
    if (before.access !== after.access || before.usage !== after.usage || before.reachable !== after.reachable) {
      pushCandidate(candidates, facts, source, projectId, "public-surface-changed", symbol, before, after, "enum");
    }
  }
}

function compareUnions(projectId, base, current, source, facts, candidates) {
  const currentUnions = new Map(current.unions.map((item) => [item.identity, item]));
  for (const before of base.unions.filter((item) => item.reachable)) {
    const after = currentUnions.get(before.identity);
    const symbol = before.crossLanguageDefinitionId ?? before.identity;
    if (!after || canonicalJson(before) !== canonicalJson(after)) {
      pushCandidate(
        candidates,
        facts,
        source,
        projectId,
        "public-surface-changed",
        symbol,
        before,
        after,
        "union",
      );
    }
  }
}

function compareClients(projectId, base, current, source, facts, candidates) {
  const currentClients = new Map(current.clients.map((item) => [item.identity, item]));
  for (const before of base.clients) {
    const after = currentClients.get(before.identity);
    if (!after) continue;
    if (before.name !== after.name || before.owner !== after.owner || before.parent !== after.parent) {
      const symbol = before.crossLanguageDefinitionId ?? before.identity;
      pushCandidate(candidates, facts, source, projectId, "client-location-changed", symbol, before, after, "client");
    }
  }
}

function compareCustomizations(projectId, source, facts, candidates) {
  const relevant =
    /^@@?(?:(?:Azure\.)?ClientGenerator\.Core(?:\.Legacy)?\.)?(clientName|flattenProperty|clientLocation|override)\b/;
  const byDeclaration = new Map();
  for (const declaration of source.declarations) {
    const selected = (declaration.decorators ?? []).filter((item) => relevant.test(item)).sort();
    if (!selected.length) continue;
    const record = byDeclaration.get(declaration.qualifiedName) ?? {};
    record[declaration.source?.revision ?? "current"] = selected;
    record.declaration = declaration;
    byDeclaration.set(declaration.qualifiedName, record);
  }
  for (const [name, record] of byDeclaration) {
    if (canonicalJson(record.base ?? []) === canonicalJson(record.current ?? [])) continue;
    const before = { symbol: name, decorators: record.base ?? [] };
    const after = { symbol: name, decorators: record.current ?? [] };
    pushCandidate(
      candidates,
      facts,
      source,
      projectId,
      "customization-changed",
      name,
      before,
      after,
      "customization",
    );
  }
}

function factRole(fact) {
  return fact?.comparisonRole ??
    (fact?.revision === "base" ? "baseline" : fact?.revision === "current" ? "target" : undefined);
}

function referencedTypeNames(value, names = new Set(), seen = new WeakSet()) {
  if (!value || typeof value !== "object" || seen.has(value)) return names;
  seen.add(value);
  const identity = typeIdentity(value);
  if (identity) names.add(identity);
  for (const [key, child] of Object.entries(value)) {
    if (["id", "projectId", "sourceCommit", "operation", "httpOperation"].includes(key)) continue;
    if (Array.isArray(child)) child.forEach((item) => referencedTypeNames(item, names, seen));
    else referencedTypeNames(child, names, seen);
  }
  return names;
}

function parameterLocation(method, parameter) {
  const protocolParameters = [
    ...(method.operation?.parameters ?? []),
    ...(method.operation?.bodyParam ? [method.operation.bodyParam] : []),
  ];
  const matches = protocolParameters.filter((item) => {
    const segments = (item.methodParameterSegments ?? []).flat(Infinity).map(String);
    return item.name === parameter.name ||
      item.crossLanguageDefinitionId === parameter.crossLanguageDefinitionId ||
      segments.includes(parameter.name) ||
      (parameter.crossLanguageDefinitionId &&
        segments.includes(parameter.crossLanguageDefinitionId));
  });
  const kinds = new Set(matches.map((item) => item.kind));
  if (kinds.size !== 1) return undefined;
  const [kind] = kinds;
  return ["path", "query", "header", "body"].includes(kind)
    ? `request-${kind}`
    : undefined;
}

function buildReferenceGraph(projectId, comparisonRole, contract, source, facts) {
  const nodes = new Map();
  const reverse = new Map();
  const reverseKeys = new Map();
  const addNode = (key, factKind, value) => {
    nodes.set(key, { key, factKind, value, factId: undefined });
  };
  for (const method of contract.methods.filter((item) => item.access === "public")) {
    addNode(`method:${method.identity}`, "method", method);
  }
  for (const [factKind, values] of [
    ["model", contract.models],
    ["enum", contract.enums],
    ["union", contract.unions],
  ]) {
    for (const value of values) addNode(`type:${value.identity}`, factKind, value);
  }
  const addEdge = (from, targetIdentity, detail) => {
    const to = `type:${targetIdentity}`;
    if (!nodes.has(from) || !nodes.has(to)) return;
    const edge = { from, to, ...detail };
    const values = reverse.get(to) ?? [];
    const keys = reverseKeys.get(to) ?? new Set();
    const edgeKey = canonicalJson(edge);
    if (!keys.has(edgeKey)) {
      keys.add(edgeKey);
      values.push(edge);
      reverse.set(to, values);
      reverseKeys.set(to, keys);
    }
  };
  const addTypeEdges = (from, value, detail) => {
    for (const identity of referencedTypeNames(value)) {
      addEdge(from, identity, detail);
    }
  };
  for (const method of contract.methods.filter((item) => item.access === "public")) {
    const from = `method:${method.identity}`;
    for (const parameter of method.parameters) {
      addTypeEdges(from, parameter.type, {
        kind: "parameter",
        memberName: parameter.name,
        location: parameterLocation(method, parameter),
      });
    }
    addTypeEdges(from, method.responseType, {
      kind: "response",
      location: "response-body",
    });
    addTypeEdges(from, method.paging, {
      kind: "paging-item",
      location: "response-body",
    });
    addTypeEdges(from, method.lro, {
      kind: "lro-result",
      location: "response-body",
    });
    for (const response of method.operation?.responses ?? []) {
      for (const header of response.headers ?? []) {
        addTypeEdges(from, header.type, {
          kind: "response-header",
          memberName: header.serializedName ?? header.name,
          location: "response-header",
        });
      }
    }
  }
  for (const model of contract.models) {
    const from = `type:${model.identity}`;
    for (const property of model.properties) {
      addTypeEdges(from, property.type, {
        kind: "property",
        memberName: property.name,
      });
    }
    if (model.baseModel) addEdge(from, model.baseModel, { kind: "base-model" });
    addTypeEdges(from, model.additionalProperties, {
      kind: "additional-properties",
    });
    for (const subtype of model.discriminatedSubtypes ?? []) {
      addEdge(from, subtype.type, {
        kind: "discriminated-subtype",
        memberName: subtype.name,
      });
    }
  }
  for (const item of contract.enums) {
    addTypeEdges(`type:${item.identity}`, item.valueType, {
      kind: "enum-value-type",
    });
  }
  for (const item of contract.unions) {
    const from = `type:${item.identity}`;
    addTypeEdges(from, item.type, { kind: "union-value" });
    addTypeEdges(from, item.variantTypes, { kind: "union-variant" });
    addTypeEdges(from, item.discriminatedOptions, {
      kind: "union-variant",
    });
  }
  const ensureFact = (key) => {
    const node = nodes.get(key);
    if (!node) return undefined;
    node.factId ??= addFact(
      facts,
      projectId,
      comparisonRole,
      node.factKind,
      node.value,
      source.artifactComparison,
    );
    return node.factId;
  };
  return { projectId, comparisonRole, nodes, reverse, ensureFact };
}

function shortestMethodPaths(graph, typeName) {
  const start = `type:${typeName}`;
  if (!graph.nodes.has(start)) return [];
  const queue = [{ key: start, path: [] }];
  const visited = new Set([start]);
  const results = [];
  for (let index = 0; index < queue.length; index += 1) {
    const current = queue[index];
    for (const edge of graph.reverse.get(current.key) ?? []) {
      const path = [edge, ...current.path];
      if (edge.from.startsWith("method:")) {
        const location = path.find((item) => item.location)?.location;
        results.push({
          methodKey: edge.from,
          location,
          path: path.map((item) => ({
            ...item,
            location: item.location ?? location,
          })),
        });
        continue;
      }
      if (visited.has(edge.from)) continue;
      visited.add(edge.from);
      queue.push({ key: edge.from, path });
    }
  }
  return results;
}

function buildRootCauses(candidates, facts, graphs) {
  const candidateFact = (candidate, role) => candidate.evidenceFactIds
    .map((id) => facts[id])
    .find((fact) => factRole(fact) === role);
  const methodCandidates = candidates.filter((candidate) =>
    ["method", "client", "customization"].includes(
      (candidateFact(candidate, "target") ?? candidateFact(candidate, "baseline"))?.factKind,
    ));
  const typeCandidates = candidates.filter((candidate) =>
    ["model", "enum", "union"].includes(
      (candidateFact(candidate, "target") ?? candidateFact(candidate, "baseline"))?.factKind,
    ));
  const roots = [];
  const byMethod = new Map();
  for (const candidate of methodCandidates) {
    const fact = candidateFact(candidate, "target") ?? candidateFact(candidate, "baseline");
    const key = `${fact?.projectId ?? ""}:${candidate.crossLanguageDefinitionId}`;
    const values = byMethod.get(key) ?? [];
    values.push(candidate);
    byMethod.set(key, values);
  }
  for (const [rootKey, direct] of byMethod) {
    const root = {
      kind: "method-return-propagation",
      directCandidateIds: unique(direct.map((item) => item.id)),
      propagatedCandidateIds: [],
      methodFactIds: unique(direct.flatMap((item) => item.evidenceFactIds)),
      typeFactIds: [],
      referenceEvidence: [],
      rootKey,
    };
    roots.push({ id: stableId("downstream-root-cause", root), ...root });
  }
  const byType = new Map();
  for (const candidate of typeCandidates) {
    const fact = candidateFact(candidate, "target") ?? candidateFact(candidate, "baseline");
    const identity = typeIdentity(fact);
    const key = `${fact?.projectId ?? ""}:${identity}`;
    const values = byType.get(key) ?? [];
    values.push(candidate);
    byType.set(key, values);
  }
  for (const [rootKey, direct] of byType) {
    const fact = candidateFact(direct[0], "target") ?? candidateFact(direct[0], "baseline");
    const identity = typeIdentity(fact);
    const projectGraphs = graphs.filter((graph) => graph.projectId === fact?.projectId);
    const pathsByMethod = new Map();
    for (const graph of projectGraphs.sort((left, right) =>
      right.comparisonRole.localeCompare(left.comparisonRole))) {
      for (const result of shortestMethodPaths(graph, identity)) {
        const method = graph.nodes.get(result.methodKey)?.value;
        const methodIdentity = method?.crossLanguageDefinitionId ?? method?.identity;
        const key = `${methodIdentity}:${result.location ?? ""}`;
        if (!pathsByMethod.has(key)) pathsByMethod.set(key, { graph, result, methodIdentity });
      }
    }
    const methodFactIds = [];
    const typeFactIds = direct.flatMap((item) => item.evidenceFactIds);
    const referenceEvidence = [];
    for (const { graph, result } of pathsByMethod.values()) {
      const methodFactId = graph.ensureFact(result.methodKey);
      methodFactIds.push(methodFactId);
      for (const edge of result.path) {
        const fromFactId = graph.ensureFact(edge.from);
        const toFactId = graph.ensureFact(edge.to);
        if (edge.to.startsWith("type:")) typeFactIds.push(toFactId);
        referenceEvidence.push({
          fromFactId,
          toFactId,
          kind: edge.kind,
          ...(edge.memberName ? { memberName: edge.memberName } : {}),
          ...(edge.location ? { location: edge.location } : {}),
        });
      }
    }
    const kind = fact?.factKind === "model"
      ? "type-contract-propagation"
      : "enum-union-propagation";
    const root = {
      kind: methodFactIds.length ? kind : "unresolved",
      directCandidateIds: unique(direct.map((item) => item.id)),
      propagatedCandidateIds: [],
      methodFactIds: unique(methodFactIds),
      typeFactIds: unique(typeFactIds),
      referenceEvidence: [
        ...new Map(
          referenceEvidence.map((item) => [canonicalJson(item), item]),
        ).values(),
      ],
      rootKey,
    };
    roots.push({ id: stableId("downstream-root-cause", root), ...root });
  }
  for (const candidate of candidates) {
    candidate.rootCauseIds = roots
      .filter((root) =>
        root.directCandidateIds.includes(candidate.id) ||
        root.propagatedCandidateIds.includes(candidate.id))
      .map((root) => root.id);
  }
  return roots.sort((left, right) => left.id.localeCompare(right.id));
}

export function analyzeDownstreamBreaking(options) {
  const { workRoot, manifest, sourceIndex } = loadInputs(options);
  const facts = {};
  const candidates = [];
  const graphs = [];
  const blockers = [];
  let analyzedProjects = 0;
  for (const project of [...(manifest.projects ?? [])].sort((left, right) => left.id.localeCompare(right.id))) {
    const baseArtifact = project.artifacts?.baseline?.tcgc ?? project.artifacts?.base?.tcgc;
    const currentArtifact = project.artifacts?.target?.tcgc ?? project.artifacts?.current?.tcgc;
    if (!artifactReady(baseArtifact) || !artifactReady(currentArtifact)) {
      blockers.push({
        code: "tcgc-artifacts-unavailable",
        projectId: project.id,
        message: `Baseline and target TCGC artifacts are required for ${project.id}.`,
      });
      continue;
    }
    try {
      const base = normalizeTcgcContract({ workRoot, artifact: baseArtifact });
      const current = normalizeTcgcContract({ workRoot, artifact: currentArtifact });
      const source = evidence(project, sourceIndex);
      source.artifactComparison = project.artifactComparison;
      const candidateStart = candidates.length;
      compareMethods(project.id, base, current, source, facts, candidates);
      compareModels(project.id, base, current, source, facts, candidates);
      compareEnums(project.id, base, current, source, facts, candidates);
      compareUnions(project.id, base, current, source, facts, candidates);
      compareClients(project.id, base, current, source, facts, candidates);
      compareCustomizations(project.id, source, facts, candidates);
      const requiresTypeReachability = candidates
        .slice(candidateStart)
        .some((candidate) =>
          candidate.evidenceFactIds.some((id) =>
            ["model", "enum", "union"].includes(facts[id]?.factKind),
          ),
        );
      if (requiresTypeReachability) {
        graphs.push(
          buildReferenceGraph(project.id, "baseline", base, source, facts),
          buildReferenceGraph(project.id, "target", current, source, facts),
        );
      }
      analyzedProjects += 1;
    } catch (error) {
      blockers.push({ code: "tcgc-contract-unsupported", projectId: project.id, message: error.message });
    }
  }
  const uniqueCandidates = new Map(candidates.map((item) => [item.id, item]));
  const normalizedCandidates = [...uniqueCandidates.values()]
    .sort((left, right) => left.id.localeCompare(right.id));
  const rootCauses = buildRootCauses(normalizedCandidates, facts, graphs);
  const result = {
    schemaVersion: 1,
    status: analyzedProjects ? "ready" : "blocked",
    facts: Object.fromEntries(Object.entries(facts).sort(([left], [right]) => left.localeCompare(right))),
    rootCauses,
    candidates: normalizedCandidates,
    blockers,
  };
  if (options.output) writeJson(path.resolve(options.output), result);
  return result;
}

if (isMain(import.meta.url)) {
  runMain(async () => {
    const args = parseArgs(process.argv.slice(2), { required: ["manifest", "output"] });
    const result = analyzeDownstreamBreaking(args);
    console.log(path.resolve(args.output));
    if (result.status === "blocked") process.exitCode = 1;
  });
}
