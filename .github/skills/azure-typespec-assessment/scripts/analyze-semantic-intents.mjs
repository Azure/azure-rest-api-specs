import path from "node:path";
import {
  normalizeAutorestContract,
  sameAutorestContract,
} from "./autorest-contract.mjs";
import { parseArgs, isMain, readJson, runMain, writeJson } from "./cli.mjs";
import { semanticIntentType } from "./semantic-assessment-scope.mjs";
import { canonicalJson, stableId } from "./stable-id.mjs";
import { indexTcgcOperations, normalizeTcgcContract } from "./tcgc-contract.mjs";

function loadInputs(options) {
  const manifestPath = typeof options.manifest === "string"
    ? path.resolve(options.manifest)
    : options.manifestPath
      ? path.resolve(options.manifestPath)
      : undefined;
  const workRoot = path.resolve(options.workRoot ?? (manifestPath ? path.dirname(manifestPath) : process.cwd()));
  return {
    workRoot,
    manifest: typeof options.manifest === "object" ? options.manifest : readJson(manifestPath),
    sourceIndex: options.sourceIndex ?? readJson(path.join(workRoot, "source", "source-index.json")),
  };
}

function operationWireShape(operation, includeVersion = true) {
  return {
    apiVersion: includeVersion ? operation.apiVersion : undefined,
    operationId: operation.operationId,
    path: operation.path,
    method: operation.method,
    routeSource: operation.routeSource,
    parameters: operation.parameters,
    request: operation.request,
    responses: operation.responses,
    consumes: operation.consumes,
    produces: operation.produces,
    paging: operation.paging,
    lro: operation.lro,
  };
}

function same(left, right) {
  return sameAutorestContract(left, right);
}

function changedAspects(before, after) {
  if (!before || !after) return ["operation"];
  const fields = ["method", "path", "parameters", "request", "responses", "paging", "lro"];
  return fields.filter((field) => !same(before[field], after[field]));
}

function restChanged(before, after) {
  // x-ms-pageable describes SDK traversal, not a change to the HTTP payload.
  return changedAspects(before, after).some((field) => field !== "paging") ||
    !same(before?.consumes, after?.consumes) || !same(before?.produces, after?.produces);
}

function changedReferenceRoots(before, after, roots = new Set()) {
  if (same(before, after) || !before || !after ||
      typeof before !== "object" || typeof after !== "object") {
    return roots;
  }
  if (before.reference && before.reference === after.reference) {
    roots.add(before.reference.split("/").at(-1));
    return roots;
  }
  for (const key of new Set([...Object.keys(before), ...Object.keys(after)])) {
    if (key === "reference" || key === "references") continue;
    const left = before[key];
    const right = after[key];
    if (Array.isArray(left) && Array.isArray(right)) {
      for (let index = 0; index < Math.max(left.length, right.length); index += 1) {
        changedReferenceRoots(left[index], right[index], roots);
      }
    } else {
      changedReferenceRoots(left, right, roots);
    }
  }
  return roots;
}

function operationChangedRoots(before, after) {
  const beforeContract = before && {
    parameters: before.parameters,
    request: before.request,
    responses: before.responses,
    paging: before.paging,
    lro: before.lro,
  };
  const afterContract = after && {
    parameters: after.parameters,
    request: after.request,
    responses: after.responses,
    paging: after.paging,
    lro: after.lro,
  };
  return [...changedReferenceRoots(beforeContract, afterContract)].sort();
}

function resourceStem(value) {
  return comparableName(value)
    .replace(/^list/, "")
    .replace(/(?:list)?results?$/, "")
    .replace(/propertiesformat$/, "")
    .replace(/ies$/, "y")
    .replace(/s$/, "");
}

function publicationRootEligible(pair, sourceIndex, project) {
  const roots = operationChangedRoots(pair.before, pair.after);
  if (!roots.length) return true;
  const operation = pair.after ?? pair.before;
  const family = resourceStem(operation.operationId.split("_")[0]);
  const operationName = resourceStem(operation.operationId);
  const models = Object.values(sourceIndex.resourceModels ?? {})
    .filter((model) =>
      model.revision === "current" && model.project === project.path)
    .sort((left, right) => {
      const leftLocal = left.sourcePath.startsWith(`${project.path}/`) ? 0 : 1;
      const rightLocal = right.sourcePath.startsWith(`${project.path}/`) ? 0 : 1;
      return leftLocal - rightLocal;
    });
  return roots.some((root) => {
    const stem = resourceStem(root);
    const model = models.find((candidate) =>
      resourceStem(candidate.name) === stem);
    const related = family === stem || family.endsWith(stem) ||
      stem.endsWith(family) || operationName.includes(stem);
    if (!related) return false;
    if (!model) return family === stem || stem.endsWith(family);
    const changedModelSource = sourceIndex.sourceChanges.some((source) =>
      source.path === model.sourcePath &&
      !["main.tsp", "models.tsp", "client.tsp", "back-compatible.tsp"]
        .includes(path.basename(source.path)) &&
      (source.declarations ?? []).some((declaration) =>
        declaration.qualifiedName === model.name));
    if (changedModelSource) {
      return false;
    }
    if (family.endsWith(stem) && family !== stem &&
        model.decorators.includes("$parentResource")) {
      const parent = resourceStem(model.parentResource);
      return !parent || family.startsWith(parent);
    }
    return true;
  });
}

function artifactReady(artifact) {
  return artifact && (!artifact.status || artifact.status === "succeeded") && artifact.files?.length;
}

function compactSchema(schema, depth = 0) {
  if (!schema || typeof schema !== "object") return schema;
  const result = Object.fromEntries(
    ["kind", "type", "format", "nullable", "reference", "ref", "cycle", "unresolved"]
      .filter((key) => schema[key] !== undefined)
      .map((key) => [key, schema[key]]),
  );
  if (schema.references?.length) result.references = schema.references;
  if (depth < 2 && schema.properties?.length) {
    result.properties = schema.properties.map((property) => ({
      name: property.name,
      required: property.required,
      schema: compactSchema(property.schema, depth + 1),
    }));
  }
  if (depth < 2 && schema.items) result.items = compactSchema(schema.items, depth + 1);
  return result;
}

function compactOperation(operation) {
  return {
    apiVersion: operation.apiVersion,
    operationId: operation.operationId,
    path: operation.path,
    method: operation.method,
    routeSource: operation.routeSource,
    parameters: (operation.parameters ?? []).map((parameter) => ({
      name: parameter.name,
      in: parameter.in,
      required: parameter.required,
      schema: compactSchema(parameter.schema),
    })),
    request: operation.request
      ? { ...operation.request, schema: compactSchema(operation.request.schema) }
      : undefined,
    responses: (operation.responses ?? []).map((response) => ({
      status: response.status,
      schema: compactSchema(response.schema),
      headers: response.headers,
    })),
    consumes: operation.consumes,
    produces: operation.produces,
    paging: operation.paging,
    lro: operation.lro,
  };
}

function addFact(facts, project, comparisonRole, operation) {
  const selection = project.artifactComparison?.[comparisonRole];
  const value = {
    projectId: project.id,
    comparisonRole,
    sourceRevision: selection?.sourceRevision ?? (comparisonRole === "baseline" ? "base" : "current"),
    sourceCommit: selection?.commit,
    apiVersion: selection?.apiVersion ?? operation.apiVersion,
    ...compactOperation(operation),
  };
  const id = stableId("operation", value);
  facts[id] = { id, ...value };
  return id;
}

function operationPairs(base, current) {
  const baseById = new Map(base.operations.map((item) => [item.operationId, item]));
  const currentById = new Map(current.operations.map((item) => [item.operationId, item]));
  const currentByHttp = new Map();
  for (const operation of current.operations) {
    const key = `${operation.method}\u0000${operation.path}`;
    const values = currentByHttp.get(key) ?? [];
    values.push(operation);
    currentByHttp.set(key, values);
  }
  const used = new Set();
  const result = [];
  for (const before of base.operations) {
    let after = currentById.get(before.operationId);
    if (!after) {
      const matches = currentByHttp.get(`${before.method}\u0000${before.path}`) ?? [];
      if (matches.length === 1) after = matches[0];
    }
    if (after) used.add(after);
    result.push({ operationId: after?.operationId ?? before.operationId, before, after });
  }
  for (const after of current.operations) {
    if (!used.has(after)) result.push({ operationId: after.operationId, before: undefined, after });
  }
  return result.sort((left, right) => left.operationId.localeCompare(right.operationId));
}

function comparableName(value) {
  return String(value ?? "").replaceAll(/[^a-z0-9]/gi, "").toLowerCase();
}

function declarationsForHunk(source, hunkId) {
  return (source.declarations ?? []).filter((item) => item.hunkIds?.includes(hunkId));
}

function actionFor(source, declarations) {
  if (source.status === "added") return "add";
  if (source.status === "removed") return "remove";
  const baseNames = new Set(
    declarations.filter((item) => item.source?.revision === "base").map((item) => `${item.kind}:${item.qualifiedName}`),
  );
  const currentNames = new Set(
    declarations.filter((item) => item.source?.revision === "current").map((item) => `${item.kind}:${item.qualifiedName}`),
  );
  if (!baseNames.size && currentNames.size) return "add";
  if (baseNames.size && !currentNames.size) return "remove";
  return "modify";
}

const operationReferenceCache = new WeakMap();
const transitiveOperationReferenceCache = new WeakMap();
function operationReferences(operation, transitive = false) {
  const cache = transitive ? transitiveOperationReferenceCache : operationReferenceCache;
  if (cache.has(operation)) return cache.get(operation);
  const references = new Set();
  const schemas = [
    ...(operation.parameters ?? []).map((parameter) => parameter.schema),
    operation.request?.schema,
    ...(operation.responses ?? []).map((response) => response.schema),
  ].filter(Boolean);
  const visit = (schema) => {
    if (!schema || typeof schema !== "object") return;
    if (schema.reference) references.add(schema.reference);
    else if (schema.ref) references.add(schema.ref);
    else if (schema.references?.length === 1) references.add(schema.references[0]);
    if (!transitive) return;
    for (const value of Object.values(schema)) {
      if (Array.isArray(value)) value.forEach(visit);
      else visit(value);
    }
  };
  for (const schema of schemas) {
    visit(schema);
  }
  const result = [...references];
  cache.set(operation, result);
  return result;
}

function operationMatchesDeclarations(pair, declarations, transitive = false, resolveOperation) {
  const operation = pair.after ?? pair.before;
  const operationName = comparableName(operation.operationId);
  const specificOperations = declarations.filter((item) => item.kind === "operation");
  const candidates = specificOperations.length
    ? declarations.filter((item) => item.kind !== "interface")
    : declarations;
  for (const declaration of candidates) {
    const qualifiedName = declaration.qualifiedName;
    const [owner, member] = qualifiedName.split(".");
    if (declaration.kind === "operation") {
      const resolved = resolveOperation?.(declaration);
      if (resolved !== undefined) {
        if (resolved.has(pair.before) || resolved.has(pair.after)) {
          return "operation-identity";
        }
      } else if (operationName === comparableName(member ? `${owner}_${member}` : owner)) {
        return "operation-identity";
      }
    }
    const modelName = owner && declaration.kind === "property" ? owner : qualifiedName;
    if (["model", "property", "enum", "union", "alias"].includes(declaration.kind) &&
        operationReferences(operation, transitive).some((reference) =>
          reference.endsWith(`/definitions/${modelName}`) ||
          reference.endsWith(`/definitions~1${modelName}`) ||
          reference.endsWith(`/${modelName}`))) {
      return "compiled-contract-containment";
    }
  }
  return undefined;
}

function referencedOperationDeclarations(sourceIndex, declarations, project) {
  const names = new Set(declarations
    .map((item) => item.qualifiedName)
    .filter(Boolean));
  if (!names.size) return [];
  const references = [];
  const candidates = [
    ...sourceIndex.sourceChanges
      .filter((source) => project.sourceChangeIds?.includes(source.id))
      .flatMap((source) => source.declarations ?? []),
    ...Object.values(sourceIndex.referencedDeclarations ?? {}),
  ];
  for (const declaration of candidates) {
    if (declaration.kind !== "operation") continue;
    if (declaration.project && ![project.id, project.path].includes(declaration.project)) continue;
    const referencedNames = declaration.compilerEvidence?.referencedNames ?? [];
    if (referencedNames.some((name) => names.has(name))) {
      references.push(declaration);
    }
  }
  return references;
}

function unique(values) {
  return [...new Set(values.filter(Boolean))].sort();
}

function hunkText(sourceIndex, hunkId) {
  for (const source of sourceIndex.sourceChanges) {
    const hunk = source.hunks?.find((item) => item.id === hunkId);
    if (hunk) return (hunk.lines ?? []).filter((line) => /^[+-]/.test(line)).join("\n");
  }
  return "";
}

function groupingTags(unit, sourceIndex) {
  const text = hunkText(sourceIndex, unit.hunkIds[0]);
  const tags = [];
  if (/\barmResourceIdentifier\b/.test(text)) tags.push("transform:arm-resource-identifier");
  if (/@clientName\b/.test(text)) tags.push("transform:client-name");
  if (/\b(?:useFinalStateVia|ArmResourceActionAsync|ArmResourceActionSync|LongRunning|Location)\b|@extension/.test(text)) {
    tags.push("behavior:lro");
  }
  if (unit.declarationNames.some((name) => name === "Versions" || name.endsWith(".Versions"))) {
    tags.push("governance:api-version");
  }
  return unique(tags);
}

function mergeUnits(project, units, sourceIndex) {
  if (units.length < 2) return units;
  const totalHunks = units.reduce((count, unit) => count + unit.hunkIds.length, 0);
  if (project.artifactComparison?.mode === "new-api-version" &&
      sourceIndex.sourceChanges.filter((item) => project.sourceChangeIds?.includes(item.id)).length <= 2 &&
      totalHunks <= 5) {
    return [mergeUnitGroup(units, sourceIndex, ["small-new-version-change"])];
  }
  if (project.artifactComparison?.mode === "new-api-version") {
    const sourceById = new Map(sourceIndex.sourceChanges.map((source) => [source.id, source]));
    const featureNames = unique(
      units
        .map((unit) => sourceById.get(unit.sourceChangeIds[0])?.path)
        .filter(Boolean)
        .map((file) => path.basename(file, ".tsp"))
        .filter((name) => !["main", "models", "client", "back-compatible"].includes(name)),
    );
    const grouped = new Map();
    for (const unit of units) {
      const tags = groupingTags(unit, sourceIndex);
      const source = sourceById.get(unit.sourceChangeIds[0]);
      const baseName = source ? path.basename(source.path, ".tsp") : "unknown";
      const text = hunkText(sourceIndex, unit.hunkIds[0]);
      const referencedFeature = featureNames.find((name) =>
        new RegExp(`\\b${name.replaceAll(/[.*+?^${}()|[\]\\]/g, "\\$&")}\\b`).test(text));
      const key = tags.includes("governance:api-version")
        ? "publication"
        : ["client", "back-compatible"].includes(baseName) ||
            /Azure\.ClientGenerator\.Core\.Legacy|@@(?:alternateType|clientName)\b/.test(text)
          ? "sdk-compatibility"
        : !["main", "models", "client", "back-compatible"].includes(baseName)
          ? `feature:${baseName}`
          : referencedFeature
            ? `feature:${referencedFeature}`
            : "publication";
      const group = grouped.get(key) ?? [];
      group.push(unit);
      grouped.set(key, group);
    }
    return [...grouped.entries()].map(([key, group]) =>
      mergeUnitGroup(
        group,
        sourceIndex,
        unique([key, ...group.flatMap((unit) => groupingTags(unit, sourceIndex))]),
      ),
    );
  }
  const parents = units.map((_, index) => index);
  const find = (index) => parents[index] === index ? index : (parents[index] = find(parents[index]));
  const join = (left, right) => {
    const leftRoot = find(left);
    const rightRoot = find(right);
    if (leftRoot !== rightRoot) parents[rightRoot] = leftRoot;
  };
  const tags = units.map((unit) => groupingTags(unit, sourceIndex));
  for (let left = 0; left < units.length; left += 1) {
    for (let right = left + 1; right < units.length; right += 1) {
      const sharedOperations = units[left].operations.some((operation) =>
        units[right].operations.some((candidate) => candidate.operationId === operation.operationId));
      const sharedTags = tags[left].some((tag) =>
        tags[right].includes(tag) &&
        (tag.startsWith("transform:") || tag.startsWith("behavior:")));
      const sameSource = units[left].sourceChangeIds.some((id) =>
        units[right].sourceChangeIds.includes(id));
      const supportForBehavior = sameSource &&
        (tags[left].length === 0 || tags[right].length === 0) &&
        [...tags[left], ...tags[right]].some((tag) =>
          tag.startsWith("transform:") || tag.startsWith("behavior:"));
      const compatibleOperationOverlap = sharedOperations &&
        (!tags[left].length || !tags[right].length || sharedTags);
      if (compatibleOperationOverlap || sharedTags || supportForBehavior) join(left, right);
    }
  }
  const groups = new Map();
  for (let index = 0; index < units.length; index += 1) {
    const root = find(index);
    const group = groups.get(root) ?? [];
    group.push(units[index]);
    groups.set(root, group);
  }
  return [...groups.values()].map((group) =>
    mergeUnitGroup(group, sourceIndex, unique(group.flatMap((unit) => groupingTags(unit, sourceIndex)))),
  );
}

function stableOperationIdentity(operation) {
  const {
    sourceChangeIds: _sourceChangeIds,
    hunkIds: _hunkIds,
    declarationIds: _declarationIds,
    ...stableOperation
  } = operation;
  return stableOperation;
}

export function dedupePublicationHunks(reviewUnits, sourceChanges) {
  const specificallyOwnedHunks = new Set(
    reviewUnits
      .filter((unit) =>
        !(unit.groupingEvidence?.reasons ?? [])
          .includes("cross-project:api-version-publication"))
      .flatMap((unit) => unit.hunkIds),
  );
  const sourceById = new Map(sourceChanges.map((source) => [source.id, source]));

  return reviewUnits.map((unit) => {
    if (!(unit.groupingEvidence?.reasons ?? [])
      .includes("cross-project:api-version-publication")) {
      return unit;
    }
    const hunkIds = unit.hunkIds.filter((id) => !specificallyOwnedHunks.has(id));
    if (hunkIds.length === unit.hunkIds.length) return unit;

    const retainedHunks = new Set(hunkIds);
    const sourceChangeIds = unit.sourceChangeIds.filter((id) =>
      sourceById.get(id)?.hunks?.some((hunk) => retainedHunks.has(hunk.id)),
    );
    const declarationIds = unit.declarationIds.filter((id) =>
      sourceChangeIds.some((sourceId) =>
        sourceById.get(sourceId)?.declarations?.some((declaration) =>
          declaration.id === id &&
          declaration.hunkIds?.some((hunkId) => retainedHunks.has(hunkId))),
      ),
    );
    const updated = {
      ...unit,
      sourceChangeIds,
      hunkIds,
      declarationIds,
      groupingEvidence: {
        ...unit.groupingEvidence,
        memberHunkIds: unit.groupingEvidence.memberHunkIds
          .filter((id) => retainedHunks.has(id)),
      },
    };
    const { id: _id, ...identity } = updated;
    return {
      id: stableId("semantic", {
        ...identity,
        operations: identity.operations.map(stableOperationIdentity),
      }),
      ...identity,
    };
  });
}

function mergeUnitGroup(units, sourceIndex, groupingEvidence) {
  const action = units.some((unit) => unit.action === "modify")
    ? "modify"
    : units.some((unit) => unit.action === "add") && units.some((unit) => unit.action === "remove")
      ? "modify"
      : units[0].action;
  const legacyOperations = [...new Map(
    units.flatMap((unit) => unit.operations).map((operation) => [operation.operationId, operation]),
  ).values()]
    .map(stableOperationIdentity)
    .sort((left, right) => left.operationId.localeCompare(right.operationId));
  const publication = groupingEvidence.some((reason) =>
    reason === "publication" || reason.includes("api-version-publication"));
  const rank = (operation) => {
    const versionMapping = ["direct-version-governance", "version-transition-change"]
      .includes(operation.matchBasis);
    if (publication && versionMapping) return 0;
    if (operation.matchBasis === "operation-identity") return publication ? 1 : 0;
    if (operation.matchBasis === "compiled-contract-containment") return publication ? 2 : 1;
    if (operation.matchBasis === "compiler-reference") return publication ? 3 : 2;
    return versionMapping ? 3 : 4;
  };
  const byOperation = new Map();
  for (const operation of units.flatMap((unit) => unit.operations)) {
    const values = byOperation.get(operation.operationId) ?? [];
    values.push(operation);
    byOperation.set(operation.operationId, values);
  }
  const allOperations = [...byOperation.values()].map((values) => {
    const bestRank = Math.min(...values.map(rank));
    const selected = values.filter((operation) => rank(operation) === bestRank);
    const representative = [...selected].sort((left, right) =>
      canonicalJson(left).localeCompare(canonicalJson(right)))[0];
    return {
      ...representative,
      sourceChangeIds: unique(selected.flatMap((operation) => operation.sourceChangeIds ?? [])),
      hunkIds: unique(selected.flatMap((operation) => operation.hunkIds ?? [])),
      declarationIds: unique(selected.flatMap((operation) => operation.declarationIds ?? [])),
    };
  }).sort((left, right) => left.operationId.localeCompare(right.operationId));
  const directOperations = allOperations.filter((operation) =>
    operation.matchBasis === "operation-identity");
  const changedOperations = allOperations.filter((operation) =>
    operation.beforeFactId && operation.afterFactId && operation.restChanged);
  const addedOperations = allOperations.filter((operation) =>
    !operation.beforeFactId && operation.afterFactId);
  const removedOperations = allOperations.filter((operation) =>
    operation.beforeFactId && !operation.afterFactId);
  const directChangedOperations = directOperations.filter((operation) =>
    operation.beforeFactId && operation.afterFactId && operation.restChanged);
  const directRemovedOperations = directOperations.filter((operation) =>
    operation.beforeFactId && !operation.afterFactId);
  const featureAdded = groupingEvidence
    .filter((reason) => reason.startsWith("feature:"))
    .some((reason) => {
      const feature = reason.slice("feature:".length);
      return units.flatMap((unit) => unit.sourceChangeIds)
        .map((id) => sourceIndex.sourceChanges.find((source) => source.id === id))
        .some((source) =>
          source?.status === "added" && path.basename(source.path, ".tsp") === feature);
    });
  const additionsWithDirectChanges = [
    ...addedOperations,
    ...directChangedOperations,
    ...directRemovedOperations,
  ].sort((left, right) => left.operationId.localeCompare(right.operationId));
  const operations = publication
    ? allOperations
    : featureAdded && addedOperations.length
      ? additionsWithDirectChanges
      : groupingEvidence.includes("behavior:lro") && directChangedOperations.length
      ? directChangedOperations
      : addedOperations.length
        ? additionsWithDirectChanges
        : removedOperations.length
          ? removedOperations
        : directOperations.length
          ? directOperations
          : allOperations;
  const semanticAction = operations.length &&
      operations.every((operation) => !operation.beforeFactId && operation.afterFactId)
    ? "add"
    : operations.length &&
        operations.every((operation) => operation.beforeFactId && !operation.afterFactId)
      ? "remove"
      : operations.length
        ? "modify"
        : action;
  const merged = {
    projectId: units[0].projectId,
    projectIds: unique(units.flatMap((unit) => unit.projectIds ?? [unit.projectId])),
    action: semanticAction,
    changeKind: semanticAction,
    sourceChangeIds: unique(units.flatMap((unit) => unit.sourceChangeIds)),
    hunkIds: unique(units.flatMap((unit) => unit.hunkIds)),
    declarationIds: unique(units.flatMap((unit) => unit.declarationIds)),
    declarationNames: unique(units.flatMap((unit) => unit.declarationNames)),
    ownedOperationIds: unique(units.flatMap((unit) =>
      unit.ownedOperationIds ?? unit.operations.map((operation) => operation.operationId))),
    versionTransitionOperationIds: unique(
      units.flatMap((unit) =>
        unit.versionTransitionOperationIds ??
        unit.operations
          .filter((operation) =>
            ["direct-version-governance", "version-transition-change"].includes(operation.matchBasis))
          .map((operation) => operation.operationId)),
    ),
    sourceMappedOperationIds: unique(
      units.flatMap((unit) =>
        unit.sourceMappedOperationIds ??
        unit.operations
          .filter((operation) =>
            !["direct-version-governance", "version-transition-change"].includes(operation.matchBasis))
          .map((operation) => operation.operationId)),
    ),
    publicationEligibleOperationIds: unique(
      units.flatMap((unit) =>
        unit.publicationEligibleOperationIds ??
        unit.operations
          .filter((operation) => operation.publicationEligible)
          .map((operation) => operation.operationId)),
    ),
    operations,
    operationIds: unique(operations.map((item) => item.afterFactId ?? item.beforeFactId)),
    beforeFactIds: unique(operations.map((item) => item.beforeFactId)),
    afterFactIds: unique(operations.map((item) => item.afterFactId)),
    changedAspects: unique(units.flatMap((unit) => unit.changedAspects)),
    groupingEvidence: {
      kind: "deterministic-coherent-change",
      reasons: groupingEvidence,
      memberHunkIds: unique(units.flatMap((unit) => unit.hunkIds)),
    },
  };
  // Presentation evidence can improve without invalidating an existing Agent judgment.
  const identity = { ...merged, operations: legacyOperations };
  return { id: stableId("semantic", identity), ...merged };
}

function operationResolver(project, base, current, sourceIndex, workRoot, blockers) {
  const changedOperations = new Set(sourceIndex.sourceChanges
    .filter((source) => project.sourceChangeIds?.includes(source.id))
    .flatMap((source) => source.declarations ?? [])
    .filter((declaration) => declaration.kind === "operation"));
  const roles = [
    ["baseline", "base", base], ["target", "current", current],
  ].map(([role, legacyRole, contract]) => {
    const artifact = project.artifacts?.[role]?.tcgc ?? project.artifacts?.[legacyRole]?.tcgc;
    const selection = project.artifactComparison?.[role];
    const revision = selection?.sourceRevision ?? (role === "baseline" ? "base" : "current");
    const scope = { projectId: project.id, comparisonRole: role, sourceRevision: revision };
    return { artifact, selection, revision, scope, contract };
  });
  const directOperations = (entry, name) => {
    if (!entry.names) {
      entry.names = new Map();
      for (const operation of entry.contract.operations) {
        const key = comparableName(operation.operationId);
        const matches = entry.names.get(key) ?? [];
        matches.push(operation);
        entry.names.set(key, matches);
      }
    }
    return entry.names.get(name) ?? [];
  };
  const loadBridge = (entry) => {
    if (entry.loaded) return;
    entry.loaded = true;
    const { artifact, selection, scope, contract } = entry;
    if (!artifactReady(artifact) || !contract.operations.length) return;
    try {
      const sdk = normalizeTcgcContract({ workRoot, artifact });
      const versions = unique(contract.operations.map((operation) => operation.apiVersion));
      const apiVersion = selection?.apiVersion ?? (versions.length === 1 ? versions[0] : undefined);
      const sdkVersions = sdk.package.apiVersions.map((value) =>
        typeof value === "string" ? value : value.version);
      if (!apiVersion || sdkVersions.length && !sdkVersions.includes(apiVersion)) {
        blockers.push({ code: "tcgc-operation-version-mismatch", ...scope, apiVersion,
          message: "TCGC operation mapping requires the selected REST API version." });
        return;
      }
      entry.index = indexTcgcOperations(sdk, apiVersion);
      entry.routes = new Map();
      entry.scope = { ...scope, apiVersion };
      for (const operation of contract.operations) {
        if (operation.apiVersion !== apiVersion) continue;
        const key = `${operation.method.toLowerCase()}\0${operation.path}`;
        const matches = entry.routes.get(key) ?? [];
        matches.push(operation);
        entry.routes.set(key, matches);
      }
    } catch (error) {
      // SDK artifacts enrich REST semantics; an unavailable SDK must not block them.
      blockers.push({ code: "tcgc-operation-mapping-unavailable", ...scope, message: error.message });
    }
  };
  const cache = new WeakMap();
  return (declaration) => {
    if (cache.has(declaration)) return cache.get(declaration);
    const matches = new Set();
    cache.set(declaration, matches);
    const revision = declaration.source?.revision ?? declaration.revision;
    if (declaration.project && ![project.id, project.path].includes(declaration.project)) return matches;
    const selectedRoles = roles.filter((entry) => !revision || entry.revision === revision);
    const [owner, member] = declaration.qualifiedName.split(".");
    const name = comparableName(member ? `${owner}_${member}` : owner);
    for (const entry of selectedRoles) {
      for (const operation of directOperations(entry, name)) matches.add(operation);
    }
    // SDK projection is optional evidence, not an authority that can erase an
    // existing REST identity (for example AutoRest-only overload query markers).
    if (matches.size || !changedOperations.has(declaration)) return matches;
    for (const entry of selectedRoles) {
      loadBridge(entry);
      const identities = entry.index?.get(declaration.qualifiedName);
      if (!identities) continue;
      const routes = identities.size === 1 ? [...identities.values()][0] : undefined;
      const operations = routes?.size === 1 ? entry.routes.get([...routes][0]) ?? [] : [];
      if (identities.size !== 1 || routes.size !== 1 || operations.length !== 1) {
        blockers.push({
          code: identities.size > 1 || routes?.size > 1 || operations.length > 1
            ? "tcgc-operation-mapping-ambiguous" : "tcgc-operation-route-unresolved",
          ...entry.scope,
          declarationId: declaration.id,
          message: `Cannot uniquely map ${declaration.qualifiedName} by compiler identity and HTTP verb/path.`,
          identities: [...identities.keys()].sort(),
        });
        continue;
      }
      matches.add(operations[0]);
    }
    return matches;
  };
}

function buildProjectUnits(project, base, current, sourceIndex, facts, resolveOperation) {
  const projectSources = sourceIndex.sourceChanges.filter(
    (source) => project.sourceChangeIds?.includes(source.id),
  );
  const pairs = operationPairs(base, current);
  const smallNewVersion = project.artifactComparison?.mode === "new-api-version" &&
    projectSources.length <= 2 &&
    projectSources.reduce((count, source) => count + (source.hunks?.length ?? 0), 0) <= 5;
  const units = [];
  const resolvedOperations = new WeakMap();
  const resolvedOperation = (declaration) => resolvedOperations.get(declaration);
  for (const source of projectSources) {
    for (const hunk of source.hunks ?? []) {
      const declarations = declarationsForHunk(source, hunk.id);
      const referencedOperations = referencedOperationDeclarations(sourceIndex, declarations, project);
      for (const declaration of [...declarations, ...referencedOperations]) {
        if (declaration.kind === "operation" && !resolvedOperations.has(declaration)) {
          resolvedOperations.set(declaration, resolveOperation(declaration));
        }
      }
      const versionGovernance = declarations.some((item) =>
        item.qualifiedName === "Versions" || item.qualifiedName.endsWith(".Versions"));
      const operations = [];
      const ownedOperationIds = [];
      for (const pair of pairs) {
        const versionTransitionMatch = versionGovernance && (
          smallNewVersion ||
          pair.before?.operationId === pair.after?.operationId &&
          changedAspects(pair.before, pair.after).length > 0
        );
        const directMatch = versionTransitionMatch
          ? smallNewVersion
            ? "direct-version-governance"
            : "version-transition-change"
          : operationMatchesDeclarations(pair, declarations, false, resolvedOperation);
        const matchBasis = directMatch ??
          (operationMatchesDeclarations(pair, referencedOperations, false, resolvedOperation)
            ? "compiler-reference"
            : undefined);
        if (operationMatchesDeclarations(pair, declarations, true, resolvedOperation) ||
            operationMatchesDeclarations(pair, referencedOperations, true, resolvedOperation)) {
          ownedOperationIds.push(pair.operationId);
        }
        if (!matchBasis) continue;
        const beforeFactId = pair.before ? addFact(facts, project, "baseline", pair.before) : undefined;
        const afterFactId = pair.after ? addFact(facts, project, "target", pair.after) : undefined;
        operations.push({
          operationId: pair.operationId,
          beforeFactId,
          afterFactId,
          restChanged: restChanged(pair.before, pair.after),
          matchBasis,
          sourceChangeIds: [source.id],
          hunkIds: [hunk.id],
          declarationIds: declarations.map((item) => item.id).sort(),
          publicationEligible: versionTransitionMatch
            ? publicationRootEligible(pair, sourceIndex, project)
            : undefined,
        });
      }
      const action = actionFor(source, declarations);
      const unit = {
        projectId: project.id,
        action,
        changeKind: action,
        sourceChangeIds: [source.id],
        hunkIds: [hunk.id],
        declarationIds: declarations.map((item) => item.id).sort(),
        declarationNames: [...new Set(declarations.map((item) => item.qualifiedName))].sort(),
        ownedOperationIds: unique(ownedOperationIds),
        operations: operations.sort((left, right) => left.operationId.localeCompare(right.operationId)),
        operationIds: operations.map((item) => item.afterFactId ?? item.beforeFactId).filter(Boolean).sort(),
        beforeFactIds: operations.map((item) => item.beforeFactId).filter(Boolean).sort(),
        afterFactIds: operations.map((item) => item.afterFactId).filter(Boolean).sort(),
        changedAspects: [...new Set(operations.flatMap((item) =>
          changedAspects(facts[item.beforeFactId], facts[item.afterFactId]),
        ))].sort(),
      };
      const identity = {
        ...unit,
        operations: unit.operations.map(stableOperationIdentity),
      };
      units.push({ id: stableId("semantic", identity), ...unit });
    }
  }
  return mergeUnits(project, units, sourceIndex);
}

export function analyzeSemanticIntents(options) {
  const { workRoot, manifest, sourceIndex } = loadInputs(options);
  const facts = {};
  const reviewUnits = [];
  const blockers = [];
  let analyzedProjects = 0;
  if (sourceIndex.analysis && sourceIndex.analysis.status !== "ready") {
    return {
      schemaVersion: 1,
      status: "blocked",
      facts,
      reviewUnits,
      blockers: [{
        code: "typespec-compiler-source-index-unavailable",
        message: "Semantic assessment requires successful TypeSpec compiler source indexing.",
        details: sourceIndex.analysis.blockers ?? [],
      }],
    };
  }
  for (const project of [...(manifest.projects ?? [])].sort((left, right) => left.id.localeCompare(right.id))) {
    const baseArtifact = project.artifacts?.baseline?.autorest ?? project.artifacts?.base?.autorest;
    const currentArtifact = project.artifacts?.target?.autorest ?? project.artifacts?.current?.autorest;
    if (!artifactReady(baseArtifact) || !artifactReady(currentArtifact)) {
      blockers.push({
        code: "autorest-artifacts-unavailable",
        projectId: project.id,
        message: `Baseline and target AutoRest artifacts are required for ${project.id}.`,
      });
      continue;
    }
    try {
      const selectedContract = (artifact, role) => {
        const contract = normalizeAutorestContract({ workRoot, artifact });
        const version = project.artifactComparison?.[role]?.apiVersion;
        return version
          ? { ...contract, operations: contract.operations.filter((operation) => operation.apiVersion === version) }
          : contract;
      };
      const base = selectedContract(baseArtifact, "baseline");
      const current = selectedContract(currentArtifact, "target");
      const resolveOperation = operationResolver(project, base, current, sourceIndex, workRoot, blockers);
      reviewUnits.push(...buildProjectUnits(project, base, current, sourceIndex, facts, resolveOperation));
      analyzedProjects += 1;
    } catch (error) {
      blockers.push({
        code: "autorest-contract-unsupported",
        projectId: project.id,
        message: error.message,
      });
    }
  }
  const hasNewVersionProject = (manifest.projects ?? []).some((project) =>
    project.artifactComparison?.mode === "new-api-version");
  const publicationUnits = reviewUnits.filter((unit) => {
    const reasons = unit.groupingEvidence?.reasons ?? [];
    return reasons.includes("publication") ||
      (hasNewVersionProject &&
        (!reasons.length ||
          reasons.includes("governance:api-version") ||
          (reasons.length === 1 && reasons[0] === "transform:arm-resource-identifier")));
  });
  if (publicationUnits.length > 1) {
    const publicationIds = new Set(publicationUnits.map((unit) => unit.id));
    const mergedPublication = mergeUnitGroup(
      publicationUnits,
      sourceIndex,
      ["cross-project:api-version-publication"],
    );
    const newVersionProjectIds = new Set((manifest.projects ?? [])
      .filter((project) => project.artifactComparison?.mode === "new-api-version")
      .map((project) => project.id));
    const otherOperationIds = new Set(
      reviewUnits
        .filter((unit) => !publicationIds.has(unit.id))
        .flatMap((unit) => unit.operations)
        .map((operation) => operation.operationId),
    );
    const versionTransitionOperationIds = new Set(mergedPublication.versionTransitionOperationIds);
    const publicationEligibleOperationIds = new Set(
      mergedPublication.publicationEligibleOperationIds,
    );
    mergedPublication.operations = mergedPublication.operations.filter((operation) => {
      const fact = facts[operation.afterFactId ?? operation.beforeFactId];
      return versionTransitionOperationIds.has(operation.operationId) &&
        publicationEligibleOperationIds.has(operation.operationId) &&
        newVersionProjectIds.has(fact?.projectId) &&
        !otherOperationIds.has(operation.operationId);
    });
    mergedPublication.operationIds = unique(
      mergedPublication.operations.map((operation) =>
        operation.afterFactId ?? operation.beforeFactId),
    );
    mergedPublication.beforeFactIds = unique(
      mergedPublication.operations.map((operation) => operation.beforeFactId),
    );
    mergedPublication.afterFactIds = unique(
      mergedPublication.operations.map((operation) => operation.afterFactId),
    );
    reviewUnits.splice(
      0,
      reviewUnits.length,
      ...reviewUnits.filter((unit) => !publicationIds.has(unit.id)),
      mergedPublication,
    );
  }
  reviewUnits.splice(
    0,
    reviewUnits.length,
    ...dedupePublicationHunks(reviewUnits, sourceIndex.sourceChanges),
  );
  for (const unit of reviewUnits) {
    unit.intentType = semanticIntentType(unit);
  }
  reviewUnits.sort((left, right) => left.id.localeCompare(right.id));
  const result = {
    schemaVersion: 1,
    status: analyzedProjects ? "ready" : "blocked",
    facts: Object.fromEntries(Object.entries(facts).sort(([left], [right]) => left.localeCompare(right))),
    reviewUnits,
    blockers,
  };
  if (options.output) writeJson(path.resolve(options.output), result);
  return result;
}

if (isMain(import.meta.url)) {
  runMain(async () => {
    const args = parseArgs(process.argv.slice(2), { required: ["manifest", "output"] });
    const result = analyzeSemanticIntents(args);
    console.log(path.resolve(args.output));
    if (result.status === "blocked") process.exitCode = 1;
  });
}
