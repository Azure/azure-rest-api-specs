type ReviewContext = {
  source: {
    specPrNumber: number;
    specHeadSha: string;
  };
  remediationSkill: {
    skillRevision: string;
  };
};

type RawFinding = {
  severity: string;
  file: string;
  line: number;
  title: string;
};

type RawReviewResult = {
  reviews: Array<{
    findings: RawFinding[];
  }>;
};

type TypeSpecContext = {
  source: {
    specPrNumber: number;
    specHeadSha: string;
  };
  files: Array<{
    path: string;
    roles: string[];
    content?: string;
    patch?: string;
  }>;
};

const REMEDIATION_TARGETS = [
  "typespec",
  "client.tsp",
  "sdk-repository",
  "duplicate",
  "manual-investigation",
];
const CONFIDENCE_LEVELS = ["high", "medium", "low"];

function isRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === "object" && value !== null && !Array.isArray(value);
}

function requireNonEmptyString(value: unknown, fieldName: string): string {
  if (typeof value !== "string" || value.trim().length === 0) {
    throw new Error(`TypeSpec remediation result has an invalid ${fieldName}`);
  }
  return value;
}

function requireStringArray(value: unknown, fieldName: string): string[] {
  if (!Array.isArray(value) || value.length === 0) {
    throw new Error(`TypeSpec remediation result has an invalid ${fieldName}`);
  }
  const strings: string[] = [];
  for (const item of value) {
    if (typeof item !== "string" || item.trim().length === 0) {
      throw new Error(`TypeSpec remediation result has an invalid ${fieldName}`);
    }
    strings.push(item);
  }
  return strings;
}

function getChangedRightSideLines(patch: string): Set<number> {
  const changedLines = new Set<number>();
  let newLine = 0;
  for (const line of patch.split(/\r?\n/)) {
    const hunk = /^@@ -\d+(?:,\d+)? \+(\d+)(?:,\d+)? @@/.exec(line);
    if (hunk) {
      newLine = Number.parseInt(hunk[1], 10);
      continue;
    }
    if (newLine === 0 || line.startsWith("\\ ")) {
      continue;
    }
    if (line.startsWith("+") && !line.startsWith("+++")) {
      changedLines.add(newLine);
      newLine += 1;
      continue;
    }
    if (!line.startsWith("-")) {
      newLine += 1;
    }
  }
  return changedLines;
}

function validateSourceLocation(
  value: unknown,
  typeSpecContext: TypeSpecContext,
  findingLabel: string,
): void {
  if (!isRecord(value)) {
    throw new Error(`${findingLabel} has an invalid sourceLocation`);
  }
  const file = requireNonEmptyString(value.file, "sourceLocation.file");
  if (!Number.isInteger(value.line) || Number(value.line) < 1) {
    throw new Error(`${findingLabel} has an invalid sourceLocation.line`);
  }
  const contextFile = typeSpecContext.files.find((candidate) => candidate.path === file);
  if (!contextFile || !contextFile.roles.includes("changed")) {
    throw new Error(`${findingLabel} sourceLocation must reference a changed TypeSpec file`);
  }
  if (typeof contextFile.content !== "string" || typeof contextFile.patch !== "string") {
    throw new Error(`${findingLabel} sourceLocation requires current file content and diff`);
  }
  if (Number(value.line) > contextFile.content.split(/\r?\n/).length) {
    throw new Error(`${findingLabel} sourceLocation.line is outside the TypeSpec file`);
  }
  if (!getChangedRightSideLines(contextFile.patch).has(Number(value.line))) {
    throw new Error(`${findingLabel} sourceLocation.line is not changed by the spec PR`);
  }
}

/**
 * Validates that translation produced exactly one remediation classification
 * for each canonical SDK review finding.
 */
export function validateTypeSpecRemediationResult(
  reviewContextValue: unknown,
  rawReviewResultValue: unknown,
  typeSpecContextValue: unknown,
  remediationResultValue: unknown,
  reportMarkdown: string,
): void {
  if (
    !isRecord(reviewContextValue) ||
    !isRecord(reviewContextValue.source) ||
    !isRecord(reviewContextValue.remediationSkill)
  ) {
    throw new Error("SDK review context is missing remediation skill identity");
  }
  if (
    !isRecord(rawReviewResultValue) ||
    !Array.isArray(rawReviewResultValue.reviews) ||
    !rawReviewResultValue.reviews.every(
      (review) => isRecord(review) && Array.isArray(review.findings),
    )
  ) {
    throw new Error("SDK review result is missing findings for remediation");
  }
  if (
    !isRecord(typeSpecContextValue) ||
    !isRecord(typeSpecContextValue.source) ||
    !Array.isArray(typeSpecContextValue.files) ||
    !typeSpecContextValue.files.every(
      (file) =>
        isRecord(file) &&
        typeof file.path === "string" &&
        Array.isArray(file.roles) &&
        file.roles.every((role) => typeof role === "string"),
    )
  ) {
    throw new Error("TypeSpec review context is malformed");
  }

  const reviewContext = reviewContextValue as ReviewContext;
  const rawReviewResult = rawReviewResultValue as RawReviewResult;
  const typeSpecContext = typeSpecContextValue as TypeSpecContext;
  if (
    typeSpecContext.source.specPrNumber !== reviewContext.source.specPrNumber ||
    typeSpecContext.source.specHeadSha !== reviewContext.source.specHeadSha
  ) {
    throw new Error("TypeSpec review context source identity does not match the SDK review");
  }

  if (!isRecord(remediationResultValue)) {
    throw new Error("TypeSpec remediation result must be an object");
  }
  if (remediationResultValue.schemaVersion !== 1 || remediationResultValue.status !== "completed") {
    throw new Error("TypeSpec remediation result must use schemaVersion 1 and completed status");
  }
  if (
    remediationResultValue.skillRevision !== reviewContext.remediationSkill.skillRevision ||
    !isRecord(remediationResultValue.source) ||
    remediationResultValue.source.specPrNumber !== reviewContext.source.specPrNumber ||
    remediationResultValue.source.specHeadSha !== reviewContext.source.specHeadSha
  ) {
    throw new Error("TypeSpec remediation result identity does not match the reviewed input");
  }
  if (!Array.isArray(remediationResultValue.findings)) {
    throw new Error("TypeSpec remediation result findings must be an array");
  }

  const expectedFindings = rawReviewResult.reviews.flatMap((review, reviewIndex) =>
    review.findings.map((finding, findingIndex) => ({
      finding,
      key: `${reviewIndex}:${findingIndex}`,
      reviewIndex,
      findingIndex,
    })),
  );
  if (remediationResultValue.findings.length !== expectedFindings.length) {
    throw new Error("TypeSpec remediation result must classify every SDK review finding");
  }

  const actualKeys = new Set<string>();
  for (const [index, value] of remediationResultValue.findings.entries()) {
    const findingLabel = `TypeSpec remediation finding #${index + 1}`;
    if (!isRecord(value)) {
      throw new Error(`${findingLabel} must be an object`);
    }
    if (!Number.isInteger(value.reviewIndex) || !Number.isInteger(value.findingIndex)) {
      throw new Error(`${findingLabel} has an invalid SDK finding reference`);
    }
    const reviewIndex = Number(value.reviewIndex);
    const findingIndex = Number(value.findingIndex);
    const key = `${reviewIndex}:${findingIndex}`;
    const expected = expectedFindings.find((candidate) => candidate.key === key);
    if (!expected || actualKeys.has(key)) {
      throw new Error(`${findingLabel} has an unknown or duplicate SDK finding reference`);
    }
    actualKeys.add(key);

    if (
      value.severity !== expected.finding.severity ||
      value.title !== expected.finding.title ||
      !isRecord(value.generatedLocation) ||
      value.generatedLocation.file !== expected.finding.file ||
      value.generatedLocation.line !== expected.finding.line
    ) {
      throw new Error(`${findingLabel} does not match its SDK review finding`);
    }
    requireNonEmptyString(value.category, "category");
    requireNonEmptyString(value.evidence, "evidence");
    if (!isRecord(value.remediation)) {
      throw new Error(`${findingLabel} has an invalid remediation`);
    }
    if (!REMEDIATION_TARGETS.includes(String(value.remediation.target))) {
      throw new Error(`${findingLabel} has an invalid remediation target`);
    }
    if (!CONFIDENCE_LEVELS.includes(String(value.remediation.confidence))) {
      throw new Error(`${findingLabel} has an invalid remediation confidence`);
    }
    requireStringArray(value.remediation.languageScopes, "remediation.languageScopes");
    requireNonEmptyString(value.remediation.suggestion, "remediation.suggestion");
    if (value.remediation.sourceLocation !== undefined) {
      validateSourceLocation(value.remediation.sourceLocation, typeSpecContext, findingLabel);
    }
  }

  if (reportMarkdown.trim().length === 0) {
    throw new Error("TypeSpec remediation Markdown report must not be empty");
  }
}
