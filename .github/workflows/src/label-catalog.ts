import { parseDocument } from "yaml";
import { z } from "zod";

export const DELETED_LABEL = "label-deleted";

export const labelDefinitionSchema = z.strictObject({
  name: z
    .string()
    .min(1)
    .max(50)
    .regex(/^[^\r\n]+$/),
  color: z.string().regex(/^[0-9a-fA-F]{6}$/),
  description: z.string().max(100),
});

export const labelCatalogSchema = z
  .strictObject({
    unconfiguredLabels: z.enum(["preserve", "replace"]),
    labels: z.array(labelDefinitionSchema).min(1),
  })
  .superRefine((catalog, ctx) => {
    const names = new Set<string>();
    for (const [index, label] of catalog.labels.entries()) {
      const name = label.name.toLowerCase();
      if (names.has(name)) {
        ctx.addIssue({
          code: "custom",
          path: ["labels", index, "name"],
          message: `Duplicate label name: ${label.name}`,
        });
      }
      names.add(name);
    }
    if (!catalog.labels.some((label) => label.name === DELETED_LABEL)) {
      ctx.addIssue({
        code: "custom",
        path: ["labels"],
        message: `The ${DELETED_LABEL} marker must be defined`,
      });
    }
  });

export const existingLabelSchema = labelDefinitionSchema
  .extend({
    id: z.number().int().positive(),
    node_id: z.string().min(1),
    description: z.string().nullable(),
  })
  .strip();

export const labelPlanSchema = z.strictObject({
  create: z.array(labelDefinitionSchema),
  update: z.array(z.strictObject({ before: existingLabelSchema, after: labelDefinitionSchema })),
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

export function planLabels(catalog: LabelCatalog, existing: ExistingLabel[]): LabelPlan {
  const remaining = new Map(existing.map((label) => [label.name.toLowerCase(), label]));
  if (remaining.size !== existing.length) {
    throw new Error("GitHub returned duplicate label names");
  }
  const plan: LabelPlan = { create: [], update: [], unconfigured: [], unchanged: 0 };
  for (const label of catalog.labels.toSorted((a, b) => a.name.localeCompare(b.name, "en"))) {
    const before = remaining.get(label.name.toLowerCase());
    if (!before) {
      plan.create.push(label);
    } else if (!sameLabel(before, label)) {
      plan.update.push({ before, after: label });
    } else {
      plan.unchanged++;
    }
    remaining.delete(label.name.toLowerCase());
  }
  plan.unconfigured = [...remaining.values()].sort((a, b) => a.name.localeCompare(b.name, "en"));
  return plan;
}
