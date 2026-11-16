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
