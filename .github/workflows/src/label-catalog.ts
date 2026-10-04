import { parseDocument } from "yaml";
import { z } from "zod";

export const ARCHIVE_PREFIX = "archived: ";
export const ARCHIVE_RETENTION_DAYS = 14;
export const ARCHIVE_DESCRIPTION = `Archived by label sync: absent from .github/labels.yaml. Eligible for deletion after ${ARCHIVE_RETENTION_DAYS} days.`;

export const labelDefinitionSchema = z.strictObject({
  name: z
    .string()
    .min(1)
    .max(50)
    .regex(/^[^\r\n]+$/),
  color: z.string().regex(/^[0-9a-fA-F]{6}$/),
  description: z.string().max(100),
  aliases: z
    .array(
      z
        .string()
        .min(1)
        .max(50)
        .regex(/^[^\r\n]+$/),
    )
    .optional(),
});

export const labelCatalogSchema = z
  .strictObject({
    unconfiguredLabels: z.enum(["preserve", "archive"]),
    labels: z.array(labelDefinitionSchema).min(1),
  })
  .superRefine((catalog, ctx) => {
    const names = new Set<string>();
    for (const [index, label] of catalog.labels.entries()) {
      const name = label.name.toLowerCase();
      if (name.startsWith(ARCHIVE_PREFIX)) {
        ctx.addIssue({
          code: "custom",
          path: ["labels", index, "name"],
          message: `The ${ARCHIVE_PREFIX} prefix is reserved for archived labels`,
        });
      }
      if (names.has(name)) {
        ctx.addIssue({
          code: "custom",
          path: ["labels", index, "name"],
          message: `Duplicate label name: ${label.name}`,
        });
      }
      names.add(name);
    }
    const aliases = new Set<string>();
    for (const [index, label] of catalog.labels.entries()) {
      for (const alias of label.aliases ?? []) {
        const key = alias.toLowerCase();
        if (names.has(key) || aliases.has(key) || key.startsWith(ARCHIVE_PREFIX)) {
          ctx.addIssue({
            code: "custom",
            path: ["labels", index, "aliases"],
            message: `Alias must be unique, unconfigured, and not archived: ${alias}`,
          });
        }
        aliases.add(key);
      }
    }
  });

export const existingLabelSchema = labelDefinitionSchema
  .omit({ aliases: true })
  .extend({
    id: z.number().int().positive(),
    node_id: z.string().min(1),
    description: z.string().nullable(),
    archived_at: z.iso.datetime({ offset: true }).nullable(),
  })
  .strip();

export const labelPlanSchema = z.strictObject({
  create: z.array(labelDefinitionSchema),
  update: z.array(z.strictObject({ before: existingLabelSchema, after: labelDefinitionSchema })),
  archive: z.array(
    z.strictObject({ before: existingLabelSchema, name: labelDefinitionSchema.shape.name }),
  ),
  delete: z.array(existingLabelSchema),
  migrate: z.array(z.strictObject({ before: existingLabelSchema, target: z.string() })),
  unconfigured: z.array(existingLabelSchema),
  unchanged: z.number().int().nonnegative(),
});

export type LabelCatalog = z.infer<typeof labelCatalogSchema>;
export type LabelDefinition = z.infer<typeof labelDefinitionSchema>;
export type ExistingLabel = z.infer<typeof existingLabelSchema>;
export type LabelPlan = z.infer<typeof labelPlanSchema>;

export function parseLabelCatalog(content: string): LabelCatalog {
  const document = parseDocument(content);
  if (document.errors.length > 0) {
    throw new Error(
      `Invalid label YAML: ${document.errors.map((error) => error.message).join("\n")}`,
    );
  }
  return labelCatalogSchema.parse(document.toJS());
}

export function sameLabel(
  left: Pick<ExistingLabel, "name" | "color" | "description">,
  right: Pick<ExistingLabel, "name" | "color" | "description">,
): boolean {
  return (
    left.name.toLowerCase() === right.name.toLowerCase() &&
    left.color.toLowerCase() === right.color.toLowerCase() &&
    (left.description ?? "") === (right.description ?? "")
  );
}

export function isArchivedLabelExpired(label: ExistingLabel, now = new Date()): boolean {
  return (
    label.archived_at !== null &&
    label.description === ARCHIVE_DESCRIPTION &&
    Date.parse(label.archived_at) <= now.getTime() - ARCHIVE_RETENTION_DAYS * 24 * 60 * 60 * 1000
  );
}

export function originalLabelName(label: ExistingLabel): string {
  if (
    label.description === ARCHIVE_DESCRIPTION &&
    label.name.toLowerCase().startsWith(ARCHIVE_PREFIX)
  ) {
    return labelDefinitionSchema.shape.name.parse(label.name.slice(ARCHIVE_PREFIX.length));
  }
  return label.name;
}

function archivedLabelName(label: ExistingLabel): string {
  if (label.name.toLowerCase().startsWith(ARCHIVE_PREFIX)) {
    if (label.description !== ARCHIVE_DESCRIPTION) {
      throw new Error(
        `Cannot archive ${JSON.stringify(label.name)}: the ${ARCHIVE_PREFIX} prefix is reserved`,
      );
    }
    return label.name;
  }
  const name = ARCHIVE_PREFIX + label.name;
  if (name.length > 50) {
    throw new Error(
      `Cannot archive ${JSON.stringify(label.name)}: its prefixed name exceeds 50 characters. Rename it explicitly first.`,
    );
  }
  return name;
}

export function planLabels(
  catalog: LabelCatalog,
  existing: ExistingLabel[],
  now = new Date(),
): LabelPlan {
  const byName = new Map(existing.map((label) => [label.name.toLowerCase(), label]));
  if (byName.size !== existing.length) {
    throw new Error("GitHub returned duplicate label names");
  }
  const remaining = new Map<string, ExistingLabel>();
  for (const label of existing) {
    const key = originalLabelName(label).toLowerCase();
    const other = remaining.get(key);
    if (other) {
      throw new Error(
        `Label name collision: ${JSON.stringify(label.name)} and ${JSON.stringify(other.name)}. Resolve it before syncing.`,
      );
    }
    remaining.set(key, label);
  }
  const plan: LabelPlan = {
    create: [],
    update: [],
    archive: [],
    delete: [],
    migrate: [],
    unconfigured: [],
    unchanged: 0,
  };
  for (const label of catalog.labels.toSorted((a, b) => a.name.localeCompare(b.name, "en"))) {
    const before = remaining.get(label.name.toLowerCase());
    if (!before) {
      plan.create.push(label);
    } else if (!sameLabel(before, label) || before.archived_at !== null) {
      plan.update.push({ before, after: label });
    } else {
      plan.unchanged++;
    }
    remaining.delete(label.name.toLowerCase());
  }
  plan.unconfigured = [...remaining.values()].sort((a, b) => a.name.localeCompare(b.name, "en"));
  if (catalog.unconfiguredLabels === "archive") {
    const targets = new Map(
      catalog.labels.flatMap((label) =>
        (label.aliases ?? []).map((alias) => [alias.toLowerCase(), label.name] as const),
      ),
    );
    for (const before of plan.unconfigured) {
      const target = targets.get(originalLabelName(before).toLowerCase());
      if (target && (before.archived_at === null || before.description === ARCHIVE_DESCRIPTION)) {
        plan.migrate.push({ before, target });
      }
    }
    plan.delete = plan.unconfigured.filter((label) => isArchivedLabelExpired(label, now));
    for (const before of plan.unconfigured) {
      if (
        before.archived_at !== null &&
        (before.description !== ARCHIVE_DESCRIPTION ||
          before.name.toLowerCase().startsWith(ARCHIVE_PREFIX) ||
          isArchivedLabelExpired(before, now))
      )
        continue;
      const name = archivedLabelName(before);
      const occupant = byName.get(name.toLowerCase());
      if (occupant && occupant.id !== before.id) {
        throw new Error(
          `Label name collision: ${JSON.stringify(name)} already exists. Resolve it before syncing.`,
        );
      }
      plan.archive.push({ before, name });
    }
  }
  return plan;
}
