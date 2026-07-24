import type { SuppressionChange, SuppressionRecord } from "./types.ts";

/**
 * The origin of a suppression within the diff: newly added in the PR, or an existing
 * suppression whose justification changed.
 */
export type SuppressionOrigin = "new" | "changed";

/**
 * A category of inline suppression annotation. Each category maps to a distinct
 * icon-led title and a short, plain-text body. Add a new entry here (plus a branch
 * in {@link classifySuppression}) to support future categories such as
 * `required-fix`, `auto-generated`, or `policy-violation`.
 */
export type SuppressionAnnotationCategoryId =
  | "missing-justification"
  | "new-suppression"
  | "changed-justification";

interface SuppressionAnnotationCategory {
  /** GitHub Actions workflow-command annotation level. */
  level: "warning" | "error";
  /** Emoji rendered directly in the annotation title so the type is scannable. */
  icon: string;
  /** Short, recognizable title (icon is prepended when formatting). */
  title: string;
  /** Concise, actionable body sentence(s). */
  body: string;
}

const SUPPRESSION_ANNOTATION_CATEGORIES: Record<
  SuppressionAnnotationCategoryId,
  SuppressionAnnotationCategory
> = {
  "missing-justification": {
    level: "error",
    icon: "❌",
    title: "Missing Justification",
    body:
      "This suppression is missing a justification and requires author action before review can be " +
      "completed. Review stays pending until a justification is added.",
  },
  "new-suppression": {
    level: "warning",
    icon: "⚠️",
    title: "New Suppression",
    body:
      "Authors should avoid adding new suppressions and prefer fixing the underlying issue; " +
      "reviewers should approve only when there is a clear, compelling justification and no reasonable alternative.",
  },
  "changed-justification": {
    level: "warning",
    icon: "⚠️",
    title: "Changed Justification",
    body:
      "The justification for an existing suppression changed and needs review to confirm the updated " +
      "rationale is still appropriate or if the suppression should be addressed.",
  },
};

/**
 * Classifies a suppression into an annotation category. A missing (blank/whitespace)
 * justification always wins — it is a blocking author error regardless of whether the
 * suppression is new or merely changed.
 */
export function classifySuppression(
  suppression: SuppressionRecord,
  origin: SuppressionOrigin,
): SuppressionAnnotationCategoryId {
  if (!suppression.justification?.trim()) {
    return "missing-justification";
  }

  return origin === "changed" ? "changed-justification" : "new-suppression";
}

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

function buildAnnotationMessage(
  suppression: SuppressionRecord,
  category: SuppressionAnnotationCategory,
): string {
  // GitHub renders `%0A`-encoded newlines in the annotation message body (but not in the
  // `title` property), so lay the details out one per line for readability. Newline
  // encoding is handled by escapeAnnotationMessage in formatSuppressionAnnotation.
  const lines: string[] = [category.body];

  const documentationUrl = suppression.ruleMetadata?.documentationUrl;
  if (documentationUrl) {
    lines.push(`**Rule docs**: ${documentationUrl}`);
  }

  return lines.join("\n");
}

/**
 * Formats a single GitHub Actions annotation for a suppression, anchored to its source
 * file and location so it renders inline on the pull request diff. The annotation level
 * (`::warning` vs `::error`) and icon-led title depend on the suppression's
 * {@link classifySuppression category}.
 */
export function formatSuppressionAnnotation(
  suppression: SuppressionRecord,
  origin: SuppressionOrigin,
): string {
  const category = SUPPRESSION_ANNOTATION_CATEGORIES[classifySuppression(suppression, origin)];
  const title = `${category.icon} ${category.title}`;
  const properties = [
    `file=${escapeAnnotationProperty(suppression.sourceFile)}`,
    `line=${suppression.location.line}`,
    `col=${suppression.location.column}`,
    `title=${escapeAnnotationProperty(title)}`,
  ].join(",");
  return `::${category.level} ${properties}::${escapeAnnotationMessage(
    buildAnnotationMessage(suppression, category),
  )}`;
}

/**
 * Emits GitHub Actions annotations (via {@link console.log}) for the reported new and
 * changed suppressions, so they surface as inline comments on the pull request diff. New
 * suppressions are classified with origin `"new"`; changed suppressions are anchored to
 * their head-side (`after`) location and classified with origin `"changed"`.
 */
export function emitSuppressionAnnotations(reported: {
  newSuppressions: SuppressionRecord[];
  changedSuppressions: SuppressionChange[];
}): void {
  const records: { record: SuppressionRecord; origin: SuppressionOrigin }[] = [
    ...reported.newSuppressions.map((record) => ({ record, origin: "new" as const })),
    ...reported.changedSuppressions.map((change) => ({
      record: change.after,
      origin: "changed" as const,
    })),
  ];

  for (const { record, origin } of records) {
    console.log(formatSuppressionAnnotation(record, origin));
  }
}
