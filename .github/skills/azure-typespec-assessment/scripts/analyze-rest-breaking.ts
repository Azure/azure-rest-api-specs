import path from "node:path";
import { normalizeAutorestContract } from "./autorest-contract.ts";
import { isMain, parseArgs, readJsonObject, runMain, writeJson } from "./cli.ts";
import { canonicalJson, stableId } from "./stable-id.ts";

type AssessmentFact = import("./runtime-types.ts").AssessmentFact;

type AutorestArtifact = import("./runtime-types.ts").AutorestArtifact;

type BreakingAnalysis = import("./runtime-types.ts").BreakingAnalysis;

type BreakingCandidate = import("./runtime-types.ts").BreakingCandidate;

type BreakingChange = import("./runtime-types.ts").BreakingChange;

type NormalizedAutorestOperation = import("./runtime-types.ts").NormalizedAutorestOperation;

type NormalizedSchema = import("./runtime-types.ts").NormalizedSchema;

type PreparationBlocker = import("./runtime-types.ts").PreparationBlocker;

type PreparationManifest = import("./runtime-types.ts").PreparationManifest;

type PreparationProject = import("./runtime-types.ts").PreparationProject;

type SourceIndex = import("./runtime-types.ts").SourceIndex;

type SchemaDirection = "request" | "response";

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

function loadInputs(options: {
  manifest: string | PreparationManifest;
  manifestPath?: string;
  workRoot?: string;
  sourceIndex?: SourceIndex;
  output?: string;
}) {
  const manifestPath =
    typeof options.manifest === "string" ? path.resolve(options.manifest) : undefined;
  const workRoot = path.resolve(
    options.workRoot ?? (manifestPath ? path.dirname(manifestPath) : process.cwd()),
  );
  return {
    workRoot,
    manifest:
      typeof options.manifest === "object"
        ? options.manifest
        : (readJsonObject(path.resolve(options.manifest)) as unknown as PreparationManifest),
    sourceIndex:
      options.sourceIndex ??
      (readJsonObject(
        path.join(workRoot, "source", "source-index.json"),
      ) as unknown as SourceIndex),
  };
}

function artifactReady(
  artifact:
    | (AutorestArtifact & {
        status?: string;
      })
    | undefined,
) {
  return (
    artifact && (!artifact.status || artifact.status === "succeeded") && artifact.files?.length
  );
}

function evidence(project: PreparationProject, sourceIndex: SourceIndex) {
  const sourceById = new Map(sourceIndex.sourceChanges.map((item) => [item.id, item]));
  const sourceChangeIds = (project.sourceChangeIds ?? []).filter((id) => sourceById.has(id)).sort();
  return {
    sourceChangeIds,
    declarationIds: sourceChangeIds
      .flatMap((id) => sourceById.get(id)?.declarations ?? [])
      .map((item) => item.id)
      .filter(Boolean)
      .sort(),
  };
}

function logicalKey(operation: NormalizedAutorestOperation) {
  return operation.operationId;
}

function operationFact(
  facts: Record<string, AssessmentFact>,
  project: PreparationProject,
  comparisonRole: "baseline" | "target",
  operation: NormalizedAutorestOperation,
) {
  const selection = project.artifactComparison?.[comparisonRole];
  const value = {
    projectId: project.id,
    comparisonRole,
    sourceRevision:
      selection?.sourceRevision ?? (comparisonRole === "baseline" ? "base" : "current"),
    sourceCommit: selection?.commit,
    apiVersion: selection?.apiVersion ?? operation.apiVersion,
    ...operation,
  };
  const id = stableId("rest-fact", value);
  facts[id] = { id, ...value } as unknown as AssessmentFact;
  return id;
}

function same(left: unknown, right: unknown) {
  return left === undefined || right === undefined
    ? left === right
    : canonicalJson(left) === canonicalJson(right);
}

function unresolvedReferenceIdentity(value: unknown): string | undefined {
  if (value === null || typeof value !== "object" || Array.isArray(value)) return undefined;
  const record = value as Record<string, unknown>;
  if (record.unresolved !== true && typeof record.unresolvedReference !== "string") {
    return undefined;
  }
  for (const field of ["ref", "reference", "unresolvedReference"]) {
    if (typeof record[field] === "string") return record[field];
  }
  return "<unresolved>";
}

function isArmCommonTypeReference(identity: string): boolean {
  const normalized = identity.replaceAll("\\", "/");
  return (
    /(?:^|\/)specification\/common-types\//i.test(normalized) ||
    /^(?:\.\.\/|\.\/)*common-types\//i.test(normalized)
  );
}

function unresolvedArrayKey(value: unknown, index: number): string {
  if (value !== null && typeof value === "object" && !Array.isArray(value)) {
    const record = value as Record<string, unknown>;
    if (typeof record.operationId === "string") return `operation:${record.operationId}`;
    if (typeof record.status === "string") return `status:${record.status}`;
    if (typeof record.name === "string" && typeof record.in === "string") {
      return `parameter:${record.in}:${record.name}`;
    }
    if (typeof record.name === "string") return `name:${record.name}`;
  }
  return `index:${index}`;
}

function collectBlockingUnresolvedEvidence(
  value: unknown,
  location: string,
  result: Map<string, string>,
) {
  if (value === null || typeof value !== "object") return;
  const identity = unresolvedReferenceIdentity(value);
  if (identity !== undefined) {
    if (!isArmCommonTypeReference(identity)) result.set(location, identity);
    return;
  }
  if (Array.isArray(value)) {
    value.forEach((item, index) =>
      collectBlockingUnresolvedEvidence(
        item,
        `${location}[${unresolvedArrayKey(item, index)}]`,
        result,
      ),
    );
    return;
  }
  for (const [key, nested] of Object.entries(value)) {
    collectBlockingUnresolvedEvidence(nested, `${location}.${key}`, result);
  }
}

function changedUnresolvedEvidence(before: unknown, after: unknown): boolean {
  if (same(before, after)) return false;
  const baseline = new Map<string, string>();
  const target = new Map<string, string>();
  collectBlockingUnresolvedEvidence(before, "$", baseline);
  collectBlockingUnresolvedEvidence(after, "$", target);
  return [...new Set([...baseline.keys(), ...target.keys()])].some(
    (key) => baseline.get(key) !== target.get(key),
  );
}

function ambiguousVisibilityEvidence(value: unknown): boolean {
  if (value === null || typeof value !== "object") return false;
  if (Array.isArray(value)) return value.some(ambiguousVisibilityEvidence);
  const record = value as Record<string, unknown>;
  if ("readOnly" in record && typeof record.readOnly !== "boolean") return true;
  if (
    "mutability" in record &&
    (!Array.isArray(record.mutability) ||
      !record.mutability.length ||
      record.mutability.some(
        (item) =>
          typeof item !== "string" || !["create", "read", "update"].includes(item.toLowerCase()),
      ))
  ) {
    return true;
  }
  return Object.values(record).some(ambiguousVisibilityEvidence);
}

function visibleIn(schema: NormalizedSchema, direction: SchemaDirection): boolean {
  const mutability = Array.isArray(schema.mutability)
    ? schema.mutability
        .filter((item): item is string => typeof item === "string")
        .map((item) => item.toLowerCase())
    : undefined;
  if (direction === "request") {
    if (schema.readOnly === true) return false;
    return !mutability?.length || mutability.includes("create") || mutability.includes("update");
  }
  return !mutability?.length || mutability.includes("read");
}

type ObjectContract = {
  properties: NonNullable<NormalizedSchema["properties"]>;
  constraints: Record<string, unknown[]>;
  additionalProperties: unknown;
};

function effectiveObjectContract(schema: NormalizedSchema): ObjectContract | undefined {
  if (schema.kind !== "object" && schema.kind !== "intersection") return undefined;
  const properties = new Map<string, NonNullable<NormalizedSchema["properties"]>[number]>();
  const constraints = new Map<string, unknown[]>();
  const additionalProperties: unknown[] = [];

  const visit = (current: NormalizedSchema): boolean => {
    const unresolved = unresolvedReferenceIdentity(current);
    if (unresolved !== undefined) return isArmCommonTypeReference(unresolved);
    if (current.kind !== "object" && current.kind !== "intersection" && current.kind !== "any") {
      return false;
    }
    if (current.allOf?.length) return current.allOf.every(visit);

    for (const field of WIRE_CONSTRAINT_FIELDS) {
      if (current[field] === undefined) continue;
      const values = constraints.get(field) ?? [];
      values.push(current[field]);
      constraints.set(field, values);
    }
    if (current.additionalProperties !== undefined) {
      additionalProperties.push(current.additionalProperties);
    }
    for (const property of current.properties ?? []) {
      const existing = properties.get(property.name);
      if (!existing) {
        properties.set(property.name, property);
      } else {
        properties.set(property.name, {
          name: property.name,
          required: existing.required || property.required,
          schema: same(existing.schema, property.schema)
            ? existing.schema
            : {
                kind: "intersection",
                allOf: [existing.schema, property.schema],
              },
        });
      }
    }
    return true;
  };

  if (!visit(schema)) return undefined;
  return {
    properties: [...properties.values()].sort((left, right) => left.name.localeCompare(right.name)),
    constraints: Object.fromEntries(
      [...constraints.entries()].map(([field, values]) => [
        field,
        [...new Map(values.map((value) => [canonicalJson(value), value])).values()].sort(
          (left, right) => canonicalJson(left).localeCompare(canonicalJson(right)),
        ),
      ]),
    ),
    additionalProperties: additionalProperties.includes(false)
      ? false
      : (() => {
          const schemas = [
            ...new Map(
              additionalProperties
                .filter((value) => value !== true)
                .map((value) => [canonicalJson(value), value]),
            ).values(),
          ].sort((left, right) => canonicalJson(left).localeCompare(canonicalJson(right)));
          if (!schemas.length) return true;
          return schemas.length === 1 ? schemas[0] : schemas;
        })(),
  };
}

function pairs(base: NormalizedAutorestOperation[], current: NormalizedAutorestOperation[]) {
  const currentByKey = new Map(current.map((item) => [logicalKey(item), item]));
  const used = new Set();

  const result: {
    before?: NormalizedAutorestOperation;
    after?: NormalizedAutorestOperation;
  }[] = [];
  for (const before of base) {
    const after = currentByKey.get(logicalKey(before));
    if (after) used.add(after);
    result.push({ before, after });
  }
  for (const after of current) if (!used.has(after)) result.push({ before: undefined, after });
  return result;
}

function schemaChanges(
  before: NormalizedSchema | undefined,
  after: NormalizedSchema | undefined,
  location: string = "body",
  direction: SchemaDirection = "request",
): BreakingChange[] {
  if (same(before, after)) return [];
  if (!before || !after) return [{ rule: "wire-schema-changed", location }];
  const beforeUnresolved = unresolvedReferenceIdentity(before);
  const afterUnresolved = unresolvedReferenceIdentity(after);
  if (
    beforeUnresolved !== undefined &&
    afterUnresolved !== undefined &&
    isArmCommonTypeReference(beforeUnresolved) &&
    isArmCommonTypeReference(afterUnresolved)
  ) {
    return [];
  }

  const beforeObject = effectiveObjectContract(before);
  const afterObject = effectiveObjectContract(after);
  const objectContracts = beforeObject && afterObject;
  const changes: BreakingChange[] = [];
  if (!objectContracts && (before.kind !== after.kind || before.type !== after.type)) {
    return [{ rule: "wire-type-changed", location }];
  }
  if (before.nullable && !after.nullable) changes.push({ rule: "nullable-restricted", location });

  const constraints = (schema: NormalizedSchema) =>
    Object.fromEntries(
      WIRE_CONSTRAINT_FIELDS.filter((field) => schema[field] !== undefined).map((field) => [
        field,
        schema[field],
      ]),
    );
  if (
    !same(
      objectContracts ? beforeObject.constraints : constraints(before),
      objectContracts ? afterObject.constraints : constraints(after),
    )
  ) {
    changes.push({ rule: "wire-schema-changed", location });
  }
  if (objectContracts) {
    const beforeVisibleProperties = beforeObject.properties.filter((item) =>
      visibleIn(item.schema, direction),
    );
    const afterVisibleProperties = afterObject.properties.filter((item) =>
      visibleIn(item.schema, direction),
    );
    const beforeProperties = new Map(beforeVisibleProperties.map((item) => [item.name, item]));
    const afterProperties = new Map(afterVisibleProperties.map((item) => [item.name, item]));
    for (const property of beforeVisibleProperties) {
      const current = afterProperties.get(property.name);
      if (!current) {
        changes.push({
          rule: "serialized-property-removed",
          location: `${location}.${property.name}`,
        });
        continue;
      }
      if (!property.required && current.required) {
        changes.push({ rule: "property-required", location: `${location}.${property.name}` });
      }
      changes.push(
        ...schemaChanges(
          property.schema,
          current.schema,
          `${location}.${property.name}`,
          direction,
        ),
      );
    }
    for (const property of afterVisibleProperties) {
      if (!beforeProperties.has(property.name) && property.required) {
        changes.push({ rule: "required-property-added", location: `${location}.${property.name}` });
      }
    }
    if (!same(beforeObject.additionalProperties, afterObject.additionalProperties)) {
      changes.push({ rule: "additional-properties-changed", location });
    }
  } else if (before.kind === "object" || before.kind === "intersection") {
    if (before.kind === "intersection") {
      const beforeParts = before.allOf ?? [];
      const afterParts = after.allOf ?? [];
      if (beforeParts.length !== afterParts.length) {
        changes.push({ rule: "wire-schema-changed", location });
      } else {
        for (let index = 0; index < beforeParts.length; index += 1) {
          changes.push(
            ...schemaChanges(beforeParts[index], afterParts[index], location, direction),
          );
        }
      }
    }
  } else if (before.kind === "array") {
    changes.push(...schemaChanges(before.items, after.items, `${location}[]`, direction));
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

function severity(rule: string): "high" | "medium" {
  return ["paging-behavior-changed", "lro-behavior-changed", "enum-closed"].includes(rule)
    ? "medium"
    : "high";
}

function description(change: BreakingChange, operationId: string) {
  const subject = change.location ? ` ${change.location}` : "";
  const removed = change.removed?.length ? ` Removed values: ${change.removed.join(", ")}.` : "";

  const messages: Record<string, [string, string]> = {
    "operation-removed": [
      `Operation ${operationId} is no longer emitted.`,
      `Existing ${operationId} requests remain available.`,
    ],
    "method-changed": [
      `Operation ${operationId} uses a different HTTP method.`,
      `Operation ${operationId} keeps its existing HTTP method.`,
    ],
    "path-changed": [
      `Operation ${operationId} uses a different route.`,
      `Operation ${operationId} keeps its existing route.`,
    ],
    "parameter-removed": [
      `Operation ${operationId} no longer accepts parameter${subject}.`,
      `Existing callers can continue sending parameter${subject}.`,
    ],
    "required-parameter-added": [
      `Operation ${operationId} now requires parameter${subject}.`,
      `Existing calls remain valid without parameter${subject}.`,
    ],
    "parameter-required": [
      `Parameter${subject} is now required by ${operationId}.`,
      `Parameter${subject} remains optional.`,
    ],
    "parameter-location-changed": [
      `Parameter${subject} moved to another wire location.`,
      `Parameter${subject} remains at its existing wire location.`,
    ],
    "parameter-wire-type-changed": [
      `Parameter${subject} has a different wire type.`,
      `Parameter${subject} keeps its existing wire type.`,
    ],
    "request-body-required": [
      `Operation ${operationId} now requires a request body.`,
      `Existing body-less requests remain valid.`,
    ],
    "response-status-removed": [
      `Operation ${operationId} no longer defines response${subject}.`,
      `Operation ${operationId} preserves response${subject}.`,
    ],
    "response-header-removed": [
      `Operation ${operationId} no longer returns header${subject}.`,
      `Operation ${operationId} preserves header${subject}.`,
    ],
    "response-header-changed": [
      `Operation ${operationId} changed header${subject}.`,
      `Operation ${operationId} preserves header${subject}.`,
    ],
    "paging-behavior-changed": [
      `Operation ${operationId} changed paging wire behavior.`,
      `Existing paging wire behavior is preserved.`,
    ],
    "lro-behavior-changed": [
      `Operation ${operationId} changed long-running HTTP behavior.`,
      `Existing long-running HTTP behavior is preserved.`,
    ],
  };
  if (messages[change.rule])
    return { actual: messages[change.rule][0], expected: messages[change.rule][1] };
  return {
    actual: `Operation ${operationId} changed${subject}.${removed}`.trim(),
    expected: `Operation ${operationId} preserves the existing wire contract for${subject || " the affected schema"}.`,
  };
}

function compareOperation(
  before: NormalizedAutorestOperation,
  after: NormalizedAutorestOperation | undefined,
  newApiVersion: boolean = false,
): BreakingChange[] {
  if (!after) return [{ rule: "operation-removed" }];

  const changes: BreakingChange[] = [];
  if (before.method !== after.method) changes.push({ rule: "method-changed" });
  if (before.path !== after.path || before.routeSource !== after.routeSource)
    changes.push({ rule: "path-changed" });

  const afterParameters = new Map(
    after.parameters.map((item) => [`${item.in}:${item.name}`, item]),
  );
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
    if (
      newApiVersion &&
      parameter.in === "query" &&
      parameter.name === "api-version" &&
      before.apiVersion &&
      after.apiVersion &&
      before.apiVersion !== after.apiVersion &&
      parameter.required === current.required &&
      parameter.collectionFormat === current.collectionFormat &&
      selectorSchemaOnly(parameter.schema, current.schema, before.apiVersion, after.apiVersion)
    ) {
      continue;
    }
    if (!parameter.required && current.required) {
      changes.push({ rule: "parameter-required", location: parameter.name });
    }
    if (
      schemaChanges(parameter.schema, current.schema, parameter.name, "request").length ||
      parameter.collectionFormat !== current.collectionFormat
    ) {
      changes.push({ rule: "parameter-wire-type-changed", location: parameter.name });
    }
  }
  for (const parameter of after.parameters) {
    if (
      !beforeKeys.has(`${parameter.in}:${parameter.name}`) &&
      parameter.required &&
      !before.parameters.some((item) => item.name === parameter.name)
    ) {
      changes.push({ rule: "required-parameter-added", location: parameter.name });
    }
  }

  if (!before.request && after.request?.required) changes.push({ rule: "request-body-required" });
  if (before.request && after.request) {
    if (!before.request.required && after.request.required)
      changes.push({ rule: "request-body-required" });
    if (before.request.kind !== after.request.kind)
      changes.push({ rule: "wire-schema-changed", location: "request body" });
    else if (before.request.kind === "body") {
      changes.push(
        ...schemaChanges(before.request.schema, after.request.schema, "request body", "request"),
      );
    } else {
      const beforeRequestMembers = before.request.members;
      const afterRequestMembers = after.request.members;
      if (!beforeRequestMembers || !afterRequestMembers) {
        throw new TypeError("Multipart requests must define members.");
      }
      const beforeMembers = {
        kind: "object",
        properties: beforeRequestMembers.map((item) => ({
          name: item.name,
          required: item.required,
          schema: item.schema,
        })),
      } as unknown as NormalizedSchema;
      const afterMembers = {
        kind: "object",
        properties: afterRequestMembers.map((item) => ({
          name: item.name,
          required: item.required,
          schema: item.schema,
        })),
      } as unknown as NormalizedSchema;
      changes.push(...schemaChanges(beforeMembers, afterMembers, "multipart request", "request"));
    }
  }

  const afterResponses = new Map(after.responses.map((item) => [item.status, item]));

  const matchingResponse = (status: string) => {
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
    changes.push(
      ...schemaChanges(response.schema, current.schema, `response ${response.status}`, "response"),
    );
    const currentHeaders = new Map(current.headers.map((item) => [item.name.toLowerCase(), item]));
    for (const header of response.headers) {
      const currentHeader = currentHeaders.get(header.name.toLowerCase());
      if (!currentHeader) changes.push({ rule: "response-header-removed", location: header.name });
      else if (schemaChanges(header.schema, currentHeader.schema, header.name, "response").length) {
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

function selectorSchemaOnly(
  before: NormalizedSchema | undefined,
  after: NormalizedSchema | undefined,
  baselineVersion: string,
  targetVersion: string,
): boolean {
  const normalize = (schema: NormalizedSchema | undefined, version: string) => {
    if (
      schema?.kind !== "enum" ||
      schema.values?.length !== 1 ||
      schema.values[0] !== version ||
      (schema.default !== undefined && schema.default !== version)
    ) {
      return undefined;
    }
    return {
      ...schema,
      values: ["<api-version>"],
      ...(schema.default !== undefined ? { default: "<api-version>" } : {}),
    };
  };
  const baseline = normalize(before, baselineVersion);
  const target = normalize(after, targetVersion);
  return baseline !== undefined && target !== undefined && same(baseline, target);
}

export function analyzeRestBreaking(options: {
  manifest: string | PreparationManifest;
  manifestPath?: string;
  workRoot?: string;
  sourceIndex?: SourceIndex;
  output?: string;
}): BreakingAnalysis {
  const { workRoot, manifest, sourceIndex } = loadInputs(options);

  const facts: Record<string, AssessmentFact> = {};

  const candidates: BreakingCandidate[] = [];

  const blockers: PreparationBlocker[] = [];
  let analyzedProjects = 0;
  for (const project of [...(manifest.projects ?? [])].sort((left, right) =>
    left.id.localeCompare(right.id),
  )) {
    if (project.classification === "new" || project.artifactComparison?.mode === "new-project") {
      analyzedProjects += 1;
      continue;
    }
    const baseArtifact = project.artifacts?.baseline?.autorest ?? project.artifacts?.base?.autorest;
    const currentArtifact =
      project.artifacts?.target?.autorest ?? project.artifacts?.current?.autorest;
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
      const unresolvedOperations: string[] = [];
      for (const { before, after } of pairs(base.operations, current.operations)) {
        if (!before) continue;
        const changes = compareOperation(
          before,
          after,
          project.artifactComparison?.mode === "new-api-version",
        );
        if (
          after &&
          (changedUnresolvedEvidence(before, after) ||
            (!same(before, after) &&
              (ambiguousVisibilityEvidence(before) || ambiguousVisibilityEvidence(after))))
        ) {
          unresolvedOperations.push(before.operationId);
        }
        if (!changes.length) continue;
        const beforeFactId = operationFact(facts, project, "baseline", before);
        const afterFactId = after ? operationFact(facts, project, "target", after) : undefined;
        for (const change of changes) {
          const text = description(change, before.operationId);

          const candidate: Omit<BreakingCandidate, "id" | "contractChange"> = {
            rule: change.rule,
            defaultSeverity: severity(change.rule),
            actual: text.actual,
            expected: text.expected,
            operationIds: [before.operationId],
            sourceChangeIds: source.sourceChangeIds,
            declarationIds: source.declarationIds,
            evidenceFactIds: [beforeFactId, afterFactId].filter((id) => id !== undefined),
            reviewRequired: true,
          };
          const id = stableId("rest", candidate);
          candidates.push({ id, ...candidate, contractChange: change });
        }
      }
      if (unresolvedOperations.length) {
        blockers.push({
          code: "autorest-contract-unresolved",
          projectId: project.id,
          message:
            `Changed AutoRest contracts for ${unresolvedOperations.length} operations in ${project.id} ` +
            `contain unresolved references or ambiguous visibility metadata (${unresolvedOperations.slice(0, 3).join(", ")}). ` +
            "Their effective compatibility cannot be established from incomplete contract evidence.",
        });
      }
      analyzedProjects += 1;
    } catch (error) {
      blockers.push({
        code: "autorest-contract-unsupported",
        projectId: project.id,
        message: error instanceof Error ? error.message : String(error),
      });
    }
  }
  candidates.sort((left, right) => left.id.localeCompare(right.id));

  const result: BreakingAnalysis = {
    schemaVersion: 1,
    status: analyzedProjects ? "ready" : "blocked",
    facts: Object.fromEntries(
      Object.entries(facts).sort(([left], [right]) => left.localeCompare(right)),
    ),
    candidates,
    blockers,
  };
  if (options.output) writeJson(path.resolve(options.output), result);
  return result;
}

if (isMain(import.meta.url)) {
  void runMain(() => {
    const args = parseArgs(process.argv.slice(2), { required: ["manifest", "output"] });
    const manifest = args.manifest;
    const output = args.output;
    if (typeof manifest !== "string" || typeof output !== "string") {
      throw new TypeError("--manifest and --output must be strings.");
    }
    const result = analyzeRestBreaking({ manifest, output });
    console.log(path.resolve(output));
    if (result.status === "blocked") process.exitCode = 1;
  });
}
