import { createHash } from "node:crypto";
import { readFile, realpath } from "node:fs/promises";
import { dirname, isAbsolute, join, posix, relative, sep } from "node:path";
import { parseDocument } from "yaml";
import { z } from "zod";
import { labelCatalogSchema, labelDefinitionSchema } from "./label-catalog.ts";

export const LABEL_CATALOG_PATH = ".github/labels.yaml";
export const catalogSourcesSchema = z
  .array(
    z.strictObject({
      path: z.string(),
      hash: z.string().regex(/^[a-f0-9]{64}$/),
    }),
  )
  .min(1);

const entrySchema = labelDefinitionSchema.partial().required({ name: true });
const documentSchema = z.strictObject({
  extends: z.array(z.string().min(1)).default([]),
  labels: z.array(entrySchema).default([]),
  unconfiguredLabels: z.enum(["preserve", "archive"]).optional(),
});
type Entry = z.infer<typeof entrySchema>;

export function hashCatalogSource(content: string): string {
  return createHash("sha256").update(content).digest("hex");
}

function resolveReference(from: string, reference: string): string {
  if (reference.startsWith("/") || /[:\\?#\0]/.test(reference)) {
    throw new Error(`Invalid label catalog reference in ${from}: ${reference}`);
  }
  const path = posix.normalize(posix.join(posix.dirname(from), reference));
  if (
    (path !== LABEL_CATALOG_PATH && !path.startsWith(".github/labels/")) ||
    !/\.ya?ml$/.test(path)
  ) {
    throw new Error(`Label catalog references must stay under .github/labels/: ${reference}`);
  }
  return path;
}

export async function resolveLabelCatalog(readSource: (path: string) => Promise<string>) {
  const cache = new Map<string, Map<string, Entry>>();
  const sources = new Map<string, string>();
  let policy: "preserve" | "archive" | undefined;

  async function load(path: string, chain: string[]): Promise<Map<string, Entry>> {
    if (chain.includes(path)) {
      throw new Error(`Label catalog inheritance cycle: ${[...chain, path].join(" -> ")}`);
    }
    const cached = cache.get(path);
    if (cached) return cached;
    const content = await readSource(path);
    const yaml = parseDocument(content);
    if (yaml.errors.length) {
      throw new Error(
        `Invalid label YAML in ${path}: ${yaml.errors.map((e) => e.message).join("\n")}`,
      );
    }
    const document = documentSchema.parse(yaml.toJS());
    sources.set(path, hashCatalogSource(content));
    if (path === LABEL_CATALOG_PATH) {
      if (!document.unconfiguredLabels)
        throw new Error("The root label catalog must define unconfiguredLabels");
      policy = document.unconfiguredLabels;
    } else if (document.unconfiguredLabels !== undefined) {
      throw new Error(`Only the root label catalog can define unconfiguredLabels: ${path}`);
    }

    const own = new Map(document.labels.map((entry) => [entry.name.toLowerCase(), entry]));
    if (own.size !== document.labels.length) throw new Error(`Duplicate label name in ${path}`);
    const merged = new Map<string, Entry>();
    const conflicts = new Map<string, Set<"color" | "description" | "aliases">>();
    for (const reference of document.extends) {
      const base = await load(resolveReference(path, reference), [...chain, path]);
      for (const [key, entry] of base) {
        const previous = merged.get(key);
        if (previous) {
          for (const field of ["color", "description", "aliases"] as const) {
            const left =
              field === "color" ? previous.color?.toLowerCase() : JSON.stringify(previous[field]);
            const right =
              field === "color" ? entry.color?.toLowerCase() : JSON.stringify(entry[field]);
            if (left !== undefined && right !== undefined && left !== right) {
              const fields = conflicts.get(key) ?? new Set();
              fields.add(field);
              conflicts.set(key, fields);
            }
          }
        }
        merged.set(key, { ...previous, ...entry });
      }
    }
    for (const [name, fields] of conflicts) {
      for (const field of fields) {
        if (own.get(name)?.[field] === undefined) {
          throw new Error(
            `Conflicting inherited ${field} for label ${name} in ${path}; override it explicitly`,
          );
        }
      }
    }
    for (const [key, entry] of own) merged.set(key, { ...merged.get(key), ...entry });
    cache.set(path, merged);
    return merged;
  }

  const labels = await load(LABEL_CATALOG_PATH, []);
  const catalog = labelCatalogSchema.parse({
    unconfiguredLabels: policy,
    labels: [...labels.values()],
  });
  const files = [...sources]
    .sort(([a], [b]) => a.localeCompare(b, "en"))
    .map(([path, hash]) => ({ path, hash }));
  return { catalog, sources: files, hash: hashCatalogSource(JSON.stringify(files)) };
}

export async function loadLabelCatalog(catalogPath: string) {
  const root = await realpath(join(dirname(catalogPath), ".."));
  return resolveLabelCatalog(async (path) => {
    const fullPath = await realpath(path === LABEL_CATALOG_PATH ? catalogPath : join(root, path));
    const relativePath = relative(root, fullPath);
    if (relativePath === ".." || relativePath.startsWith(`..${sep}`) || isAbsolute(relativePath)) {
      throw new Error(`Label catalog path escapes the repository: ${path}`);
    }
    return readFile(fullPath, "utf8");
  });
}
