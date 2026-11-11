type ReviewContext = {
  source: { specPrNumber: number; specHeadSha: string };
  remediationSkill: { skillRevision: string };
};

type RawFinding = {
  severity: string;
  file: string;
  line: number;
  title: string;
  description: string;
};

type RawReviewResult = {
  reviews: Array<{ findings: RawFinding[] }>;
};

type TypeSpecContext = {
  source: { specPrNumber: number; specHeadSha: string };
  files: Array<{
    path: string;
    roles: string[];
    content?: string;
    patch?: string;
  }>;
};

type SourceLocation = { file: string; line: number };

type NormalizedFinding = {
  reviewIndex: number;
  findingIndex: number;
  severity: string;
  generatedLocation: { file: string; line: number };
  title: string;
  evidence: string;
  remediation: {
    target: string;
    languageScopes: ["csharp"];
    specSymbol?: string;
    suggestion: string;
    confidence: string;
    sourceLocation?: SourceLocation;
  };
};

const MAX_COMBINED_SAFE_OUTPUT_BYTES = 64 * 1024;

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

function requireString(value: unknown, fieldName: string): string {
  if (typeof value !== "string" || value.trim().length === 0) {
    throw new Error(`TypeSpec remediation result has an invalid ${fieldName}`);
  }
  return value;
}

function getChangedRightSideLines(patch: string): Set<number> {
  const changedLines = new Set<number>();
  let newLine = 0;
  for (const line of patch.split(/\r?\n/)) {
    const hunk = /^@@ -\d+(?:,\d+)? \+(\d+)(?:,\d+)? @@/.exec(line);
    if (hunk) {
      newLine = Number.parseInt(hunk[1], 10);
    } else if (newLine > 0 && line.startsWith("+") && !line.startsWith("+++")) {
      changedLines.add(newLine++);
    } else if (newLine > 0 && !line.startsWith("-") && !line.startsWith("\\ ")) {
      newLine++;
    }
  }
  return changedLines;
}

function validateSourceLocation(
  value: unknown,
  context: TypeSpecContext,
  findingLabel: string,
): SourceLocation {
  if (!isRecord(value)) {
    throw new Error(`${findingLabel} has an invalid sourceLocation`);
  }
  const file = requireString(value.file, "sourceLocation.file");
  if (!Number.isInteger(value.line) || Number(value.line) < 1) {
    throw new Error(`${findingLabel} has an invalid sourceLocation.line`);
  }
  const line = Number(value.line);
  const contextFile = context.files.find((candidate) => candidate.path === file);
  if (!contextFile?.roles.includes("changed")) {
    throw new Error(`${findingLabel} sourceLocation must reference a changed TypeSpec file`);
  }
  if (typeof contextFile.content !== "string" || typeof contextFile.patch !== "string") {
    throw new Error(`${findingLabel} sourceLocation requires current file content and diff`);
  }
  if (line > contextFile.content.split(/\r?\n/).length) {
    throw new Error(`${findingLabel} sourceLocation.line is outside the TypeSpec file`);
  }
  if (!getChangedRightSideLines(contextFile.patch).has(line)) {
    throw new Error(`${findingLabel} sourceLocation.line is not changed by the spec PR`);
  }
  return { file, line };
}

export function parseTypeSpecRemediationSafeOutput(outputValue: unknown): unknown {
  if (!isRecord(outputValue) || !Array.isArray(outputValue.items)) {
    throw new Error("Invalid TypeSpec remediation safe output");
  }
  const calls = outputValue.items.filter(
    (item) => isRecord(item) && item.type === "publish_sdk_review",
  );
  if (
    calls.length !== 1 ||
    !isRecord(calls[0]) ||
    typeof calls[0].result !== "string" ||
    typeof calls[0].remediation_result !== "string"
  ) {
    throw new Error("Expected exactly one complete TypeSpec remediation safe output");
  }
  const combinedBytes = new TextEncoder().encode(
    calls[0].result + calls[0].remediation_result,
  ).byteLength;
  if (combinedBytes > MAX_COMBINED_SAFE_OUTPUT_BYTES) {
    throw new Error(
      `Combined SDK review safe output exceeds ${MAX_COMBINED_SAFE_OUTPUT_BYTES} bytes`,
    );
  }
  try {
    return JSON.parse(calls[0].remediation_result);
  } catch (error) {
    throw new Error("TypeSpec remediation safe output must be valid JSON", { cause: error });
  }
}

/**
 * The skill decides only how each finding maps to TypeSpec. This trusted
 * boundary restores canonical SDK identity, validates exact TypeSpec lines,
 * and emits the stable artifact consumed by the write-enabled publisher.
 */
export function validateTypeSpecRemediationResult(
  reviewContextValue: unknown,
  rawReviewResultValue: unknown,
  typeSpecContextValue: unknown,
  remediationResultValue: unknown,
  _existingReportMarkdown?: string,
): {
  result: {
    schemaVersion: 1;
    status: "completed";
    skillRevision: string;
    source: ReviewContext["source"];
    findings: NormalizedFinding[];
  };
  report: string;
} {
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
  if (
    !isRecord(remediationResultValue) ||
    remediationResultValue.schemaVersion !== 1 ||
    remediationResultValue.status !== "completed"
  ) {
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
    })),
  );
  if (remediationResultValue.findings.length !== expectedFindings.length) {
    throw new Error("TypeSpec remediation result must classify every SDK review finding");
  }

  const actualKeys = new Set<string>();
  const findings = remediationResultValue.findings.map((value, index): NormalizedFinding => {
    const findingLabel = `TypeSpec remediation finding #${index + 1}`;
    if (
      !isRecord(value) ||
      !Number.isInteger(value.reviewIndex) ||
      !Number.isInteger(value.findingIndex)
    ) {
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
    // Raw skill output omits canonical fields. A normalized artifact reaching
    // the publisher includes them, so revalidation must reject any tampering.
    if (
      (value.severity !== undefined && value.severity !== expected.finding.severity) ||
      (value.title !== undefined && value.title !== expected.finding.title) ||
      (value.evidence !== undefined && value.evidence !== expected.finding.description) ||
      (value.generatedLocation !== undefined &&
        (!isRecord(value.generatedLocation) ||
          value.generatedLocation.file !== expected.finding.file ||
          value.generatedLocation.line !== expected.finding.line))
    ) {
      throw new Error(`${findingLabel} does not match its canonical SDK finding`);
    }
    if (!isRecord(value.remediation)) {
      throw new Error(`${findingLabel} has an invalid remediation`);
    }
    const target = String(value.remediation.target);
    const confidence = String(value.remediation.confidence);
    if (!REMEDIATION_TARGETS.includes(target)) {
      throw new Error(`${findingLabel} has an invalid remediation target`);
    }
    if (!CONFIDENCE_LEVELS.includes(confidence)) {
      throw new Error(`${findingLabel} has an invalid remediation confidence`);
    }
    if (
      value.remediation.languageScopes !== undefined &&
      (!Array.isArray(value.remediation.languageScopes) ||
        value.remediation.languageScopes.length !== 1 ||
        value.remediation.languageScopes[0] !== "csharp")
    ) {
      throw new Error(`${findingLabel} remediation.languageScopes must contain only csharp`);
    }
    const sourceLocation =
      value.remediation.sourceLocation === undefined
        ? undefined
        : validateSourceLocation(value.remediation.sourceLocation, typeSpecContext, findingLabel);
    const specSymbol =
      value.remediation.specSymbol === undefined
        ? undefined
        : requireString(value.remediation.specSymbol, "remediation.specSymbol");

    return {
      reviewIndex,
      findingIndex,
      severity: expected.finding.severity,
      generatedLocation: { file: expected.finding.file, line: expected.finding.line },
      title: expected.finding.title,
      evidence: expected.finding.description,
      remediation: {
        target,
        languageScopes: ["csharp"],
        ...(specSymbol ? { specSymbol } : {}),
        suggestion: requireString(value.remediation.suggestion, "remediation.suggestion"),
        confidence,
        ...(sourceLocation ? { sourceLocation } : {}),
      },
    };
  });

  return {
    result: {
      schemaVersion: 1,
      status: "completed",
      skillRevision: reviewContext.remediationSkill.skillRevision,
      source: reviewContext.source,
      findings,
    },
    report: `# TypeSpec remediation\n\nValidated ${findings.length} remediation mapping${findings.length === 1 ? "" : "s"} for specification PR #${reviewContext.source.specPrNumber}.\n`,
  };
}
