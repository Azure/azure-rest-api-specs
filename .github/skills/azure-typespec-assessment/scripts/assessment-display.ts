type AssessmentDimension = {
  status: string;
  findings?: unknown[];
};

export function dimensionStatus(
  blocked: boolean,
  findings: unknown[],
): "not-assessed" | "failed" | "passed" {
  if (blocked) return "not-assessed";
  return findings.length ? "failed" : "passed";
}

export function deriveSafety(
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
