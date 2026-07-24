import type { SuppressionChange, SuppressionRecord } from "./types.ts";

const ANNOTATION_TITLE = "New/changed TypeSpec Suppression - REVIEW REQUIRED";

const SUPPRESSION_GUIDANCE =
  "Authors should avoid adding new suppressions and prefer fixing the underlying issue; " +
  "reviewers should approve only when there is a clear, compelling justification and no reasonable alternative.";

/**
 * Escapes a value for use in the message portion of a GitHub Actions workflow command.
 * See: https://docs.github.com/actions/using-workflows/workflow-commands-for-github-actions
 */
function escapeAnnotationMessage(value: string): string {
  return value.replaceAll("%", "%25").replaceAll("\r", "%0D").replaceAll("\n", "%0A");
}

/**
 * Escapes a value for use in a property (e.g. `file`, `title`) of a GitHub Actions workflow
 * command. Properties additionally escape `,` and `:`.
 */
function escapeAnnotationProperty(value: string): string {
  return escapeAnnotationMessage(value).replaceAll(",", "%2C").replaceAll(":", "%3A");
}

function buildAnnotationMessage(suppression: SuppressionRecord): string {
  // GitHub renders `%0A`-encoded newlines in the annotation message body (but not in the
  // `title` property), so lay the details out one per line for readability. Newline
  // encoding is handled by escapeAnnotationMessage in formatSuppressionAnnotation.
  const lines: string[] = [];

  // Only call out the justification when it is missing; a present justification is already
  // visible in the suppression comment the annotation is anchored to.
  if (!suppression.justification?.trim()) {
    lines.push("NO JUSTIFICATION PROVIDED — a justification is required.");
  }

  lines.push(SUPPRESSION_GUIDANCE);

  const documentationUrl = suppression.ruleMetadata?.documentationUrl;
  if (documentationUrl) {
    lines.push(`**Rule docs**: ${documentationUrl}`);
  }

  return lines.join("\n");
}

/**
 * Formats a single GitHub Actions `::warning` annotation for a suppression, anchored to its
 * source file and location so it renders inline on the pull request diff.
 */
export function formatSuppressionAnnotation(suppression: SuppressionRecord): string {
  const properties = [
    `file=${escapeAnnotationProperty(suppression.sourceFile)}`,
    `line=${suppression.location.line}`,
    `col=${suppression.location.column}`,
    `title=${escapeAnnotationProperty(ANNOTATION_TITLE)}`,
  ].join(",");
  return `::warning ${properties}::${escapeAnnotationMessage(buildAnnotationMessage(suppression))}`;
}

/**
 * Emits GitHub Actions `::warning` annotations (via {@link console.log}) for the reported new and
 * changed suppressions, so they surface as inline warnings on the pull request diff. Changed
 * suppressions are anchored to their head-side (`after`) location.
 */
export function emitSuppressionAnnotations(reported: {
  newSuppressions: SuppressionRecord[];
  changedSuppressions: SuppressionChange[];
}): void {
  const records = [
    ...reported.newSuppressions,
    ...reported.changedSuppressions.map((change) => change.after),
  ];

  for (const record of records) {
    console.log(formatSuppressionAnnotation(record));
  }
}
