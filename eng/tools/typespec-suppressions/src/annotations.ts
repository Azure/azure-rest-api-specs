import type { SuppressionChange, SuppressionRecord } from "./types.ts";

const ANNOTATION_TITLE = "TypeSpec suppression requires review";

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
  const justification = suppression.justification?.trim()
    ? `"${suppression.justification.trim()}"`
    : "NO JUSTIFICATION PROVIDED";
  const base = `${ANNOTATION_TITLE} — ${suppression.ruleName}: ${justification}.`;
  const documentationUrl = suppression.ruleMetadata?.documentationUrl;
  return documentationUrl ? `${base} Rule docs: ${documentationUrl}` : base;
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
