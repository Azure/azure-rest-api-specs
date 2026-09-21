import path from "node:path";
import { normalizeAutorestContract } from "./autorest-contract.mjs";
import { parseArgs, isMain, readJson, runMain, writeJson } from "./cli.mjs";
import { canonicalJson, stableId } from "./stable-id.mjs";

const WIRE_CONSTRAINT_FIELDS = [
  "maximum",
  "exclusiveMaximum",
  "minimum",
  "exclusiveMinimum",
  "maxLength",
  "minLength",
  "pattern",
  "maxItems",
  "minItems",
  "uniqueItems",
  "maxProperties",
  "minProperties",
  "multipleOf",
];

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
  return {
    sourceChangeIds,
    declarationIds: sourceChangeIds
      .flatMap((id) => sourceById.get(id).declarations ?? [])
      .map((item) => item.id)
      .filter(Boolean)
      .sort(),
  };
}

function logicalKey(operation) {
  return operation.operationId;
}

function operationFact(facts, project, comparisonRole, operation) {
  const selection = project.artifactComparison?.[comparisonRole];
  const value = {
    projectId: project.id,
    comparisonRole,
    sourceRevision: selection?.sourceRevision ?? (comparisonRole === "baseline" ? "base" : "current"),
    sourceCommit: selection?.commit,
    apiVersion: selection?.apiVersion ?? operation.apiVersion,
    ...operation,
  };
  const id = stableId("rest-fact", value);
  facts[id] = { id, ...value };
  return id;
}

function same(left, right) {
  return left === undefined || right === undefined
    ? left === right
    : canonicalJson(left) === canonicalJson(right);
}

function pairs(base, current) {
  const currentByKey = new Map(current.map((item) => [logicalKey(item), item]));
  const used = new Set();
  const result = [];
  for (const before of base) {
    const after = currentByKey.get(logicalKey(before));
    if (after) used.add(after);
    result.push({ before, after });
  }
  for (const after of current) if (!used.has(after)) result.push({ before: undefined, after });
  return result;
}

function schemaChanges(before, after, location = "body") {
  if (same(before, after)) return [];
  if (!before || !after) return [{ rule: "wire-schema-changed", location }];
  const changes = [];
  if (before.kind !== after.kind || before.type !== after.type) {
    return [{ rule: "wire-type-changed", location }];
  }
  if (before.nullable && !after.nullable) changes.push({ rule: "nullable-restricted", location });
  const constraints = (schema) => Object.fromEntries(
    WIRE_CONSTRAINT_FIELDS
      .filter((field) => schema[field] !== undefined)
      .map((field) => [field, schema[field]]),
  );
  if (!same(constraints(before), constraints(after))) {
    changes.push({ rule: "wire-schema-changed", location });
  }
  if (before.kind === "object" || before.kind === "intersection") {
    const beforeProperties = new Map((before.properties ?? []).map((item) => [item.name, item]));
    const afterProperties = new Map((after.properties ?? []).map((item) => [item.name, item]));
    for (const property of before.properties ?? []) {
      const current = afterProperties.get(property.name);
      if (!current) {
        changes.push({ rule: "serialized-property-removed", location: `${location}.${property.name}` });
        continue;
      }
      if (!property.required && current.required) {
        changes.push({ rule: "property-required", location: `${location}.${property.name}` });
      }
      changes.push(...schemaChanges(property.schema, current.schema, `${location}.${property.name}`));
    }
    for (const property of after.properties ?? []) {
      if (!beforeProperties.has(property.name) && property.required) {
        changes.push({ rule: "required-property-added", location: `${location}.${property.name}` });
      }
    }
    if (!same(before.additionalProperties, after.additionalProperties)) {
      changes.push({ rule: "additional-properties-changed", location });
    }
    if (before.kind === "intersection") {
      const beforeParts = before.allOf ?? [];
      const afterParts = after.allOf ?? [];
      if (beforeParts.length !== afterParts.length) {
        changes.push({ rule: "wire-schema-changed", location });
      } else {
        for (let index = 0; index < beforeParts.length; index += 1) {
          changes.push(...schemaChanges(beforeParts[index], afterParts[index], location));
        }
      }
    }
  } else if (before.kind === "array") {
    changes.push(...schemaChanges(before.items, after.items, `${location}[]`));
  } else if (before.kind === "enum") {
    const currentValues = new Set(after.values ?? []);
    const removed = (before.values ?? []).filter((item) => !currentValues.has(item));
    if (removed.length) changes.push({ rule: "enum-values-removed", location, removed });
    if (before.enumMetadata?.modelAsString && !after.enumMetadata?.modelAsString) {
      changes.push({ rule: "enum-closed", location });
    }
  } else if (!["scalar", "any"].includes(before.kind)) {
    changes.push({ rule: "wire-schema-changed", location });
  }
  return changes;
}

function severity(rule) {
  return ["paging-behavior-changed", "lro-behavior-changed", "enum-closed"].includes(rule)
    ? "medium"
    : "high";
}

function description(change, operationId) {
  const subject = change.location ? ` ${change.location}` : "";
  const removed = change.removed?.length ? ` Removed values: ${change.removed.join(", ")}.` : "";
  const messages = {
    "operation-removed": [`Operation ${operationId} is no longer emitted.`, `Existing ${operationId} requests remain available.`],
    "method-changed": [`Operation ${operationId} uses a different HTTP method.`, `Operation ${operationId} keeps its existing HTTP method.`],
    "path-changed": [`Operation ${operationId} uses a different route.`, `Operation ${operationId} keeps its existing route.`],
    "parameter-removed": [`Operation ${operationId} no longer accepts parameter${subject}.`, `Existing callers can continue sending parameter${subject}.`],
    "required-parameter-added": [`Operation ${operationId} now requires parameter${subject}.`, `Existing calls remain valid without parameter${subject}.`],
    "parameter-required": [`Parameter${subject} is now required by ${operationId}.`, `Parameter${subject} remains optional.`],
    "parameter-location-changed": [`Parameter${subject} moved to another wire location.`, `Parameter${subject} remains at its existing wire location.`],
    "parameter-wire-type-changed": [`Parameter${subject} has a different wire type.`, `Parameter${subject} keeps its existing wire type.`],
    "request-body-required": [`Operation ${operationId} now requires a request body.`, `Existing body-less requests remain valid.`],
    "response-status-removed": [`Operation ${operationId} no longer defines response${subject}.`, `Operation ${operationId} preserves response${subject}.`],
    "response-header-removed": [`Operation ${operationId} no longer returns header${subject}.`, `Operation ${operationId} preserves header${subject}.`],
    "response-header-changed": [`Operation ${operationId} changed header${subject}.`, `Operation ${operationId} preserves header${subject}.`],
    "paging-behavior-changed": [`Operation ${operationId} changed paging wire behavior.`, `Existing paging wire behavior is preserved.`],
    "lro-behavior-changed": [`Operation ${operationId} changed long-running HTTP behavior.`, `Existing long-running HTTP behavior is preserved.`],
  };
  if (messages[change.rule]) return { actual: messages[change.rule][0], expected: messages[change.rule][1] };
  return {
    actual: `Operation ${operationId} changed${subject}.${removed}`.trim(),
    expected: `Operation ${operationId} preserves the existing wire contract for${subject || " the affected schema"}.`,
  };
}

function compareOperation(before, after) {
  if (!after) return [{ rule: "operation-removed" }];
  const changes = [];
  if (before.method !== after.method) changes.push({ rule: "method-changed" });
  if (before.path !== after.path || before.routeSource !== after.routeSource) changes.push({ rule: "path-changed" });

  const afterParameters = new Map(after.parameters.map((item) => [`${item.in}:${item.name}`, item]));
  const afterByName = new Map(after.parameters.map((item) => [item.name, item]));
  const beforeKeys = new Set(before.parameters.map((item) => `${item.in}:${item.name}`));
  for (const parameter of before.parameters) {
    const key = `${parameter.in}:${parameter.name}`;
    const current = afterParameters.get(key);
    if (!current) {
      const moved = afterByName.get(parameter.name);
      changes.push({
        rule: moved ? "parameter-location-changed" : "parameter-removed",
        location: parameter.name,
      });
      continue;
    }
    if (!parameter.required && current.required) {
      changes.push({ rule: "parameter-required", location: parameter.name });
    }
    if (schemaChanges(parameter.schema, current.schema, parameter.name).length ||
        parameter.collectionFormat !== current.collectionFormat) {
      changes.push({ rule: "parameter-wire-type-changed", location: parameter.name });
    }
  }
  for (const parameter of after.parameters) {
    if (!beforeKeys.has(`${parameter.in}:${parameter.name}`) && parameter.required && !before.parameters.some((item) => item.name === parameter.name)) {
      changes.push({ rule: "required-parameter-added", location: parameter.name });
    }
  }

  if (!before.request && after.request?.required) changes.push({ rule: "request-body-required" });
  if (before.request && after.request) {
    if (!before.request.required && after.request.required) changes.push({ rule: "request-body-required" });
    if (before.request.kind !== after.request.kind) changes.push({ rule: "wire-schema-changed", location: "request body" });
    else if (before.request.kind === "body") {
      changes.push(...schemaChanges(before.request.schema, after.request.schema, "request body"));
    } else {
      const beforeMembers = { kind: "object", properties: before.request.members.map((item) => ({
        name: item.name,
        required: item.required,
        schema: item.schema,
      })) };
      const afterMembers = { kind: "object", properties: after.request.members.map((item) => ({
        name: item.name,
        required: item.required,
        schema: item.schema,
      })) };
      changes.push(...schemaChanges(beforeMembers, afterMembers, "multipart request"));
    }
  }

  const afterResponses = new Map(after.responses.map((item) => [item.status, item]));
  const matchingResponse = (status) => {
    const exact = afterResponses.get(status);
    if (exact) return exact;
    if (/^\d{3}$/.test(status)) return afterResponses.get(`${status[0]}XX`);
    return undefined;
  };
  for (const response of before.responses) {
    const current = matchingResponse(response.status);
    if (!current) {
      changes.push({ rule: "response-status-removed", location: response.status });
      continue;
    }
    if (response.statusKind !== current.statusKind) {
      changes.push({ rule: "response-classification-changed", location: response.status });
    }
    changes.push(...schemaChanges(response.schema, current.schema, `response ${response.status}`));
    const currentHeaders = new Map(current.headers.map((item) => [item.name.toLowerCase(), item]));
    for (const header of response.headers) {
      const currentHeader = currentHeaders.get(header.name.toLowerCase());
      if (!currentHeader) changes.push({ rule: "response-header-removed", location: header.name });
      else if (schemaChanges(header.schema, currentHeader.schema, header.name).length) {
        changes.push({ rule: "response-header-changed", location: header.name });
      }
    }
  }
  if (!same(before.paging, after.paging)) {
    changes.push({ rule: "paging-behavior-changed" });
  }
  if (!same(before.lro, after.lro)) {
    changes.push({ rule: "lro-behavior-changed" });
  }
  const seen = new Set();
  return changes.filter((item) => {
    const key = canonicalJson(item);
    return seen.has(key) ? false : (seen.add(key), true);
  });
}

export function analyzeRestBreaking(options) {
  const { workRoot, manifest, sourceIndex } = loadInputs(options);
  const facts = {};
  const candidates = [];
  const blockers = [];
  let analyzedProjects = 0;
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
      const base = normalizeAutorestContract({ workRoot, artifact: baseArtifact });
      const current = normalizeAutorestContract({ workRoot, artifact: currentArtifact });
      const source = evidence(project, sourceIndex);
      for (const { before, after } of pairs(base.operations, current.operations)) {
        if (!before) continue;
        const changes = compareOperation(before, after);
        if (!changes.length) continue;
        if (project.artifactComparison?.mode === "new-api-version") continue;
        const beforeFactId = operationFact(facts, project, "baseline", before);
        const afterFactId = after ? operationFact(facts, project, "target", after) : undefined;
        for (const change of changes) {
          const text = description(change, before.operationId);
          const candidate = {
            rule: change.rule,
            defaultSeverity: severity(change.rule),
            actual: text.actual,
            expected: text.expected,
            operationIds: [before.operationId],
            sourceChangeIds: source.sourceChangeIds,
            declarationIds: source.declarationIds,
            evidenceFactIds: [beforeFactId, afterFactId].filter(Boolean),
            reviewRequired: true,
          };
          const id = stableId("rest", candidate);
          candidates.push({ id, ...candidate, contractChange: change });
        }
      }
      analyzedProjects += 1;
    } catch (error) {
      blockers.push({ code: "autorest-contract-unsupported", projectId: project.id, message: error.message });
    }
  }
  candidates.sort((left, right) => left.id.localeCompare(right.id));
  const result = {
    schemaVersion: 1,
    status: analyzedProjects ? "ready" : "blocked",
    facts: Object.fromEntries(Object.entries(facts).sort(([left], [right]) => left.localeCompare(right))),
    candidates,
    blockers,
  };
  if (options.output) writeJson(path.resolve(options.output), result);
  return result;
}

if (isMain(import.meta.url)) {
  runMain(async () => {
    const args = parseArgs(process.argv.slice(2), { required: ["manifest", "output"] });
    const result = analyzeRestBreaking(args);
    console.log(path.resolve(args.output));
    if (result.status === "blocked") process.exitCode = 1;
  });
}
