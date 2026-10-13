import assert from "node:assert/strict";
import { createHash } from "node:crypto";
import { readFileSync } from "node:fs";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import contract from "./october-contract.mjs";

export const project = resolve(dirname(fileURLToPath(import.meta.url)), "..");
export const versions = ["2026-10-01-preview"];
export const readJson = (file) => JSON.parse(readFileSync(file, "utf8"));
export const counters = [
  "protectedCount",
  "scannedProtectedCount",
  "activeFindings",
  "criticalFindings",
  "highFindings",
  "mediumFindings",
  "lowFindings",
  "unreachableFindings",
  "awaitingApprovalMitigations",
  "queuedMitigations",
  "inProgressMitigations",
  "succeededMitigations",
  "failedMitigations",
  "rollbackInProgressMitigations",
];
export const summaryCollection =
  "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetworkSecurity/neuroShields/{neuroShieldName}/summary";

export const hashBytes = (value) =>
  createHash("sha256").update(value).digest("hex");

export function hashJson(value) {
  function ordered(item) {
    if (Array.isArray(item)) return item.map(ordered);
    if (item && typeof item === "object") {
      return Object.fromEntries(
        Object.keys(item)
          .sort()
          .map((key) => [key, ordered(item[key])]),
      );
    }
    return item;
  }
  return hashBytes(JSON.stringify(ordered(value)));
}

export function sourceContractSwagger(swagger) {
  const result = structuredClone(swagger);
  const examples =
    result.paths["/providers/Microsoft.NetworkSecurity/operations"].get[
      "x-ms-examples"
    ];
  const extra = contract.publicOperationsExample;
  assert.deepEqual(examples[extra.key], extra.binding);
  delete examples[extra.key];
  return result;
}

export function loadVersion(version) {
  const generated = resolve(project, "preview", version);
  const swaggerFile = resolve(generated, "neuroShield.json");
  const swagger = readJson(swaggerFile);

  function dereference(schema, file = swaggerFile) {
    if (!schema.$ref) return { schema, file };
    const [relative, pointer] = schema.$ref.split("#");
    const targetFile = relative ? resolve(dirname(file), relative) : file;
    const target = pointer
      .split("/")
      .slice(1)
      .reduce(
        (value, key) =>
          value?.[key.replaceAll("~1", "/").replaceAll("~0", "~")],
        readJson(targetFile),
      );
    assert.ok(target, `Unresolved reference: ${schema.$ref}`);
    const resolved = dereference(target, targetFile);
    const { $ref, ...siblings } = schema;
    return { ...resolved, schema: { ...resolved.schema, ...siblings } };
  }

  function property(schema, name, file = swaggerFile) {
    const resolved = dereference(schema, file);
    if (resolved.schema.properties?.[name]) {
      return dereference(resolved.schema.properties[name], resolved.file);
    }
    for (const base of resolved.schema.allOf ?? []) {
      const found = property(base, name, resolved.file);
      if (found) return found;
    }
  }

  const operations = Object.values(swagger.paths).flatMap((path) =>
    Object.values(path).filter((operation) => operation.operationId),
  );
  return {
    version,
    generated,
    swaggerFile,
    swagger,
    operations,
    dereference,
    property,
    example: (name) =>
      readJson(resolve(project, "examples", version, `${name}.json`)),
  };
}
