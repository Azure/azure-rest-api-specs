export function dimensionStatus(blocked, findings) {
  if (blocked) return "not-assessed";
  return findings.length ? "failed" : "passed";
}

export function deriveSafety(rest, downstream) {
  if (rest.status === "not-assessed" || downstream.status === "not-assessed") {
    return { scope: "rest-and-downstream-only", status: "not-assessed" };
  }
  return {
    scope: "rest-and-downstream-only",
    status: (rest.findings ?? []).length || (downstream.findings ?? []).length ? "failed" : "passed",
  };
}

export function capitalize(value) {
  return value ? `${value[0].toUpperCase()}${value.slice(1)}` : "";
}
