/**
 * Validates agent-generated review output against the trusted reconstruction
 * context before the workflow publishes the result artifact.
 */
type ReviewContext = {
  source: {
    specPrNumber: number;
    specHeadSha: string;
  };
  canonicalSkill: {
    skillRevision: string;
  };
  workspaces: Array<{
    baselineCommitSha: string;
    packages: Array<{ packageName: string; changedFiles: string[] }>;
  }>;
};

type ValidatedFinding = {
  severity: string;
  file: string;
  line: number;
  title: string;
  description: string;
};

function isRecord(value: unknown): value is Record<string, unknown> {
  return typeof value === "object" && value !== null && !Array.isArray(value);
}

function requireNonEmptyString(value: unknown, fieldName: string): string {
  if (typeof value !== "string" || value.trim().length === 0) {
    throw new Error(`SDK review result has an invalid ${fieldName}`);
  }
  return value;
}

function requireStringArray(value: unknown, fieldName: string): string[] {
  if (!Array.isArray(value)) {
    throw new Error(`SDK review result has an invalid ${fieldName}`);
  }
  const strings: string[] = [];
  for (const item of value) {
    if (typeof item !== "string" || item.length === 0) {
      throw new Error(`SDK review result has an invalid ${fieldName}`);
    }
    strings.push(item);
  }
  return strings;
}

function validateFinding(
  value: unknown,
  reviewIndex: number,
  findingIndex: number,
  allowedFindingFiles: Set<string>,
): ValidatedFinding {
  if (!isRecord(value)) {
    throw new Error(`SDK review finding #${reviewIndex + 1}.${findingIndex + 1} must be an object`);
  }
  if (!["high", "medium", "low"].includes(String(value.severity))) {
    throw new Error(
      `SDK review finding #${reviewIndex + 1}.${findingIndex + 1} has invalid severity`,
    );
  }
  const file = requireNonEmptyString(value.file, "finding file");
  if (!allowedFindingFiles.has(file)) {
    throw new Error(
      `SDK review finding #${reviewIndex + 1}.${findingIndex + 1} targets '${file}', which is outside the declared changed files`,
    );
  }
  if (!Number.isInteger(value.line) || Number(value.line) < 1) {
    throw new Error(`SDK review finding #${reviewIndex + 1}.${findingIndex + 1} has invalid line`);
  }
  return {
    severity: String(value.severity),
    file,
    line: Number(value.line),
    title: requireNonEmptyString(value.title, "finding title"),
    description: requireNonEmptyString(value.description, "finding description"),
  };
}

function markdownText(value: string): string {
  return value
    .replace(/\p{Cc}/gu, " ")
    .replace(/([\\`*_#[\]<>|])/g, "\\$1")
    .trim();
}

function inlineCode(value: string): string {
  return value
    .replace(/\p{Cc}/gu, " ")
    .replaceAll("`", "'")
    .trim();
}

function buildValidatedMarkdown(
  context: ReviewContext,
  reviews: Array<{ baselineCommitSha: string; findings: ValidatedFinding[] }>,
): string {
  const findings = reviews.flatMap((review) =>
    review.findings.map((finding) => ({ ...finding, baselineCommitSha: review.baselineCommitSha })),
  );
  const lines = [
    "# Generated .NET SDK review",
    "",
    `Reviewed specification PR #${context.source.specPrNumber} at \`${inlineCode(context.source.specHeadSha)}\`.`,
    "",
  ];
  if (findings.length === 0) {
    lines.push("No high-confidence findings were found.", "");
    return lines.join("\n");
  }

  lines.push(`## Findings (${findings.length})`, "");
  for (const finding of findings) {
    lines.push(
      `- **${finding.severity.toUpperCase()}** \`${inlineCode(finding.file)}:${finding.line}\` ${markdownText(finding.title)}`,
      `  ${markdownText(finding.description)}`,
      `  Baseline: \`${inlineCode(finding.baselineCommitSha)}\``,
      "",
    );
  }
  return lines.join("\n");
}

/**
 * Requires a complete result for every reconstructed SDK baseline, verifies
 * source and skill identity, and validates every structured finding.
 *
 * @throws When the result or Markdown report is missing, malformed, incomplete,
 * or inconsistent with the reconstruction context.
 */
export function validateSdkReviewResult(
  contextValue: unknown,
  resultValue: unknown,
  reportMarkdown: string,
): string {
  if (!isRecord(contextValue) || !isRecord(contextValue.source)) {
    throw new Error("SDK review context is missing source identity");
  }
  if (
    !isRecord(contextValue.canonicalSkill) ||
    !Array.isArray(contextValue.workspaces) ||
    contextValue.workspaces.length === 0
  ) {
    throw new Error("SDK review context is missing reconstructed workspaces");
  }
  const context = contextValue as ReviewContext;

  if (!isRecord(resultValue)) {
    throw new Error("SDK review result must be an object");
  }
  if (resultValue.schemaVersion !== 1 || resultValue.status !== "completed") {
    throw new Error("SDK review result must use schemaVersion 1 and completed status");
  }
  if (resultValue.skillRevision !== context.canonicalSkill.skillRevision) {
    throw new Error("SDK review result does not identify the executed canonical skill revision");
  }
  if (
    !isRecord(resultValue.source) ||
    resultValue.source.specPrNumber !== context.source.specPrNumber ||
    resultValue.source.specHeadSha !== context.source.specHeadSha
  ) {
    throw new Error("SDK review result source identity does not match the reviewed spec PR");
  }
  if (
    !Array.isArray(resultValue.reviews) ||
    resultValue.reviews.length !== context.workspaces.length
  ) {
    throw new Error("SDK review result must contain one review per reconstructed baseline");
  }

  const reviews = resultValue.reviews;
  const expectedBaselines = context.workspaces
    .map((workspace) => workspace.baselineCommitSha)
    .sort();
  const actualBaselines = reviews
    .map((review, index) => {
      if (!isRecord(review)) {
        throw new Error(`SDK review #${index + 1} must be an object`);
      }
      return requireNonEmptyString(review.baselineCommitSha, "baselineCommitSha");
    })
    .sort();
  if (
    new Set(actualBaselines).size !== actualBaselines.length ||
    JSON.stringify(actualBaselines) !== JSON.stringify(expectedBaselines)
  ) {
    throw new Error("SDK review result baseline set does not match reconstructed workspaces");
  }

  const validatedReviews: Array<{
    baselineCommitSha: string;
    findings: ValidatedFinding[];
  }> = [];
  for (const [reviewIndex, reviewValue] of reviews.entries()) {
    const review = reviewValue as Record<string, unknown>;
    const workspace = context.workspaces.find(
      (candidate) => candidate.baselineCommitSha === review.baselineCommitSha,
    )!;
    const expectedPackages = workspace.packages.map((sdkPackage) => sdkPackage.packageName).sort();
    const actualPackages = requireStringArray(review.packages, "packages").sort();
    if (
      new Set(actualPackages).size !== actualPackages.length ||
      JSON.stringify(actualPackages) !== JSON.stringify(expectedPackages)
    ) {
      throw new Error(
        `SDK review result package set does not match baseline ${workspace.baselineCommitSha}`,
      );
    }
    if (!Array.isArray(review.findings)) {
      throw new Error(
        `SDK review result findings must be an array for baseline ${workspace.baselineCommitSha}`,
      );
    }
    const allowedFindingFiles = new Set(
      workspace.packages.flatMap((sdkPackage) =>
        requireStringArray(sdkPackage.changedFiles, "changedFiles"),
      ),
    );
    validatedReviews.push({
      baselineCommitSha: String(review.baselineCommitSha),
      findings: review.findings.map((finding, findingIndex) =>
        validateFinding(finding, reviewIndex, findingIndex, allowedFindingFiles),
      ),
    });
  }

  if (reportMarkdown.trim().length === 0) {
    throw new Error("SDK review Markdown report must not be empty");
  }
  return buildValidatedMarkdown(context, validatedReviews);
}
