/**
 * @typedef {{status: string, findings?: unknown[]}} AssessmentDimension
 */

/**
 * @param {boolean} blocked
 * @param {unknown[]} findings
 * @returns {"not-assessed" | "failed" | "passed"}
 */
export function dimensionStatus(blocked, findings) {
  if (blocked) return "not-assessed";
  return findings.length ? "failed" : "passed";
}

/**
 * @param {AssessmentDimension} rest
 * @param {AssessmentDimension} downstream
 * @returns {{scope: "rest-and-downstream-only", status: "not-assessed" | "failed" | "passed"}}
 */
export function deriveSafety(rest, downstream) {
  if (rest.status === "not-assessed" || downstream.status === "not-assessed") {
    return { scope: "rest-and-downstream-only", status: "not-assessed" };
  }
  return {
    scope: "rest-and-downstream-only",
    status:
      (rest.findings ?? []).length || (downstream.findings ?? []).length ? "failed" : "passed",
  };
}

/**
 * @param {string} value
 * @returns {string}
 */
export function capitalize(value) {
  return value ? `${value[0].toUpperCase()}${value.slice(1)}` : "";
}
