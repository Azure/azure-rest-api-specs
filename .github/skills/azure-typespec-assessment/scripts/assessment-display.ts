import type { AssessmentFact, NormalizedSchema } from "./runtime-types.ts";

export function schemaIdentity(schema: NormalizedSchema | undefined): string | undefined {
  return schema?.enumMetadata?.name ?? schema?.reference?.split("/").at(-1);
}

export function schemaPath(schema: NormalizedSchema | undefined, segments: string[]) {
  let current = schema;
  let identity = schemaIdentity(current);
  let ownerIdentity = identity;
  let memberName: string | undefined;
  for (const raw of segments) {
    const name = raw.replace(/\[\]$/, "");
    ownerIdentity = identity;
    memberName = name;
    const property = current?.properties?.find((property) => property.name === name);
    if (!property) return { schema: undefined, identity, ownerIdentity, memberName };
    current = property.schema;
    identity = schemaIdentity(current) ?? identity;
    if (raw.endsWith("[]")) {
      current = current?.items;
      identity = schemaIdentity(current) ?? identity;
    }
  }
  return { schema: current, identity, ownerIdentity, memberName };
}

export function restContractIdentity(finding: {
  contractChange?: { location?: string };
  operationIds?: string[];
  evidence?: AssessmentFact[];
  rule?: string;
}) {
  const facts = finding.evidence ?? [];
  const before = facts.find((fact) => fact.comparisonRole === "baseline") ?? facts[0];
  const after = facts.find((fact) => fact.comparisonRole === "target") ?? facts[1];
  const location = finding.contractChange?.location ?? finding.rule ?? "";
  const memberChange = new Set([
    "serialized-property-removed",
    "property-required",
    "required-property-added",
    "wire-type-changed",
    "nullable-restricted",
  ]).has(finding.rule ?? "");
  const pathIdentity = (schema: NormalizedSchema | undefined, segments: string[]) => {
    const resolved = schemaPath(schema, segments);
    return memberChange && segments.length ? resolved.ownerIdentity : resolved.identity;
  };
  const identity = (fact: AssessmentFact | undefined) => {
    const request = location.match(/^request body(?:\.(.*))?$/);
    if (request) return pathIdentity(fact?.request?.schema, request[1]?.split(".") ?? []);
    const response = location.match(/^response ([^.]+)(?:\.(.*))?$/);
    if (response) {
      return pathIdentity(
        fact?.responses?.find((item) => item.status === response[1])?.schema,
        response[2]?.split(".") ?? [],
      );
    }
    if (finding.rule?.startsWith("parameter-") || finding.rule === "required-parameter-added") {
      return schemaIdentity(
        fact?.parameters?.find((parameter) => parameter.name === location)?.schema,
      );
    }
    if (finding.rule?.startsWith("response-header-")) {
      for (const response of fact?.responses ?? []) {
        const header = response.headers?.find(
          (header) => header.name?.toLowerCase() === location.toLowerCase(),
        );
        if (header) return schemaIdentity(header.schema);
      }
    }
    return undefined;
  };
  return (
    identity(before) ??
    identity(after) ??
    finding.operationIds?.[0] ??
    "Unmapped REST contract change"
  );
}

type AssessmentDimension = {
  status: string;
  verdict?: CompatibilityVerdict;
  coverage?: AssessmentCoverage;
  findings?: unknown[];
  blockers?: unknown[];
  rejectedCandidateCount?: number;
};

export type CompatibilityVerdict = "passed" | "failed" | "unknown";

export type AssessmentCoverage = "complete" | "partial" | "blocked";

export type CompatibilityAssessment = {
  status: "not-assessed" | "failed" | "passed";
  verdict: CompatibilityVerdict;
  coverage: AssessmentCoverage;
};

function statusFromVerdict(verdict: CompatibilityVerdict): CompatibilityAssessment["status"] {
  return verdict === "unknown" ? "not-assessed" : verdict;
}

export function legacyDimensionStatus(
  blocked: boolean,
  findings: unknown[],
): "not-assessed" | "failed" | "passed" {
  if (blocked) return "not-assessed";
  return findings.length ? "failed" : "passed";
}

export function dimensionCompatibility(
  blocked: boolean,
  findings: unknown[],
  assessedCandidateCount: number = findings.length,
): CompatibilityAssessment {
  const verdict: CompatibilityVerdict = findings.length ? "failed" : blocked ? "unknown" : "passed";
  const coverage: AssessmentCoverage = !blocked
    ? "complete"
    : assessedCandidateCount > 0
      ? "partial"
      : "blocked";
  return {
    status: statusFromVerdict(verdict),
    verdict,
    coverage,
  };
}

function dimensionCompatibilityFromOutput(dimension: AssessmentDimension): CompatibilityAssessment {
  if (dimension.verdict && dimension.coverage) {
    return {
      status: statusFromVerdict(dimension.verdict),
      verdict: dimension.verdict,
      coverage: dimension.coverage,
    };
  }
  const findings = dimension.findings ?? [];
  return dimensionCompatibility(
    (dimension.blockers ?? []).length > 0,
    findings,
    findings.length + (dimension.rejectedCandidateCount ?? 0),
  );
}

export function deriveSafety(
  rest: AssessmentDimension,
  downstream: AssessmentDimension,
): {
  scope: "rest-and-downstream-only";
  status: "not-assessed" | "failed" | "passed";
  verdict: CompatibilityVerdict;
  coverage: AssessmentCoverage;
} {
  const restCompatibility = dimensionCompatibilityFromOutput(rest);
  const downstreamCompatibility = dimensionCompatibilityFromOutput(downstream);
  const verdict: CompatibilityVerdict =
    restCompatibility.verdict === "failed" || downstreamCompatibility.verdict === "failed"
      ? "failed"
      : restCompatibility.verdict === "unknown" || downstreamCompatibility.verdict === "unknown"
        ? "unknown"
        : "passed";
  const coverage: AssessmentCoverage =
    restCompatibility.coverage === "complete" && downstreamCompatibility.coverage === "complete"
      ? "complete"
      : restCompatibility.coverage === "blocked" && downstreamCompatibility.coverage === "blocked"
        ? "blocked"
        : "partial";
  return {
    scope: "rest-and-downstream-only",
    status: statusFromVerdict(verdict),
    verdict,
    coverage,
  };
}

export function deriveLegacySafety(
  rest: AssessmentDimension,
  downstream: AssessmentDimension,
): {
  scope: "rest-and-downstream-only";
  status: "not-assessed" | "failed" | "passed";
} {
  if (rest.status === "not-assessed" || downstream.status === "not-assessed") {
    return { scope: "rest-and-downstream-only", status: "not-assessed" };
  }
  return {
    scope: "rest-and-downstream-only",
    status:
      (rest.findings ?? []).length || (downstream.findings ?? []).length ? "failed" : "passed",
  };
}

export function capitalize(value: string): string {
  return value ? `${value[0].toUpperCase()}${value.slice(1)}` : "";
}
