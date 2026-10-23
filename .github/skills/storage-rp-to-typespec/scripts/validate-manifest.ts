import { readFileSync } from "node:fs";
import { pathToFileURL } from "node:url";
import { Ajv } from "ajv";
import { parseDocument } from "yaml";

interface PropertyState {
  wireName: string;
  required: boolean | Partial<Record<"read" | "create" | "update", boolean>>;
  visibility: ("read" | "create" | "update")[];
}

type Change = {
  target: string;
  apiVersions: string[];
} & (
  | { kind: "property"; before?: PropertyState; after?: PropertyState }
  | {
      kind: "model";
      before?: { properties: PropertyState[] };
      after?: { properties: PropertyState[] };
    }
  | { kind: "enum" | "operation" }
);

const ajv = new Ajv({ allErrors: true });
const schema: unknown = JSON.parse(
  readFileSync(new URL("../schemas/contract-changes.schema.json", import.meta.url), "utf8"),
);
if (typeof schema !== "object" || schema === null || Array.isArray(schema)) {
  throw new Error("The contract-change schema must be an object.");
}
const validate = ajv.compile<{ changes: Change[] }>(schema);

function validateProperties(properties: PropertyState[], target: string): void {
  const names = new Set<string>();
  for (const property of properties) {
    if (names.has(property.wireName)) {
      throw new Error(`Duplicate property ${property.wireName} in ${target}.`);
    }
    names.add(property.wireName);
    const { required, visibility } = property;
    if (
      typeof required === "object" &&
      (Object.keys(required).length !== visibility.length ||
        visibility.some((lifecycle) => required[lifecycle] === undefined))
    ) {
      throw new Error(`Requiredness must match visibility for ${property.wireName}.`);
    }
  }
}

export function validateManifestText(source: string): void {
  const document = parseDocument(source);
  const issues = [...document.errors, ...document.warnings];
  if (issues.length > 0) {
    throw new Error(issues.map((issue) => issue.message).join("\n"));
  }
  const manifest: unknown = document.toJS({ maxAliasCount: 100 });
  if (!validate(manifest)) {
    throw new Error(ajv.errorsText(validate.errors, { separator: "\n" }));
  }

  const targets = new Set<string>();
  for (const change of manifest.changes) {
    for (const version of change.apiVersions) {
      const key = JSON.stringify([change.target, version]);
      if (targets.has(key)) {
        throw new Error(`Duplicate change for ${change.target} in ${version}.`);
      }
      targets.add(key);
    }
    if (change.kind === "property") {
      for (const state of [change.before, change.after]) {
        if (state !== undefined) {
          validateProperties([state], change.target);
        }
      }
    } else if (change.kind === "model") {
      for (const state of [change.before, change.after]) {
        if (state !== undefined) {
          validateProperties(state.properties, change.target);
        }
      }
    }
  }
}

if (process.argv[1] && import.meta.url === pathToFileURL(process.argv[1]).href) {
  try {
    if (process.argv.length !== 3) {
      throw new Error("Usage: node validate-manifest.ts <manifest.yaml>");
    }
    const file = process.argv[2];
    validateManifestText(readFileSync(file, "utf8"));
    console.log(`Valid contract-change manifest: ${file}`);
  } catch (error) {
    console.error(error instanceof Error ? error.message : String(error));
    process.exitCode = 1;
  }
}
