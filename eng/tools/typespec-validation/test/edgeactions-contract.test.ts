import { readFileSync, readdirSync } from "node:fs";
import { resolve } from "node:path";
import { describe, expect, it } from "vitest";
import { parse } from "yaml";
import {
  mutabilityConflicts,
  readSwagger,
  requestBody,
  resolveSchema,
  schemaProperties,
  writablePaths,
  type Operation,
  type Schema,
} from "./openapi-contracts.ts";

const root = resolve(
  import.meta.dirname,
  "../../../../specification/cdn/resource-manager/Microsoft.Cdn/EdgeActions",
);
const version = "2027-01-01-preview";
const file = resolve(root, "preview", version, "openapi.json");
const swagger = readSwagger(file);
const operations = Object.values(swagger.paths).flatMap((route) => Object.values(route));
const operation = (id: string): Operation => {
  const found = operations.find((candidate) => candidate.operationId === id);
  if (!found) throw new Error(`Missing operation ${id}`);
  return found;
};

describe("generic request path analysis", () => {
  const nested: Schema = {
    properties: {
      properties: {
        "x-ms-mutability": ["read", "create"],
        allOf: [
          {
            properties: {
              header: { type: "string", "x-ms-mutability": ["read", "create", "update"] },
              status: { type: "string", readOnly: true },
            },
          },
        ],
      },
    },
  };

  it("reproduces fields present in definitions but excluded from PUT update by a parent", () => {
    expect(writablePaths(nested, file, "create")).toContain("properties.header");
    expect(writablePaths(nested, file, "update")).not.toContain("properties.header");
    expect(mutabilityConflicts(nested, file)).toEqual([
      "properties.header: update blocked by ancestor",
    ]);
  });

  it("permits consistent wrappers and excludes read-only fields", () => {
    const fixed = structuredClone(nested);
    fixed.properties!.properties["x-ms-mutability"] = ["read", "create", "update"];
    expect(mutabilityConflicts(fixed, file)).toEqual([]);
    expect(writablePaths(fixed, file, "update")).toEqual(["properties", "properties.header"]);
  });

  it("resolves real references and inherited common resource fields", () => {
    const schema = { $ref: "#/definitions/EdgeActionExecutionFilter" };
    expect(writablePaths(schema, file, "create")).toContain("location");
    expect(writablePaths(schema, file, "update")).not.toContain("id");
    expect(writablePaths(schema, file, "update")).not.toContain("properties.provisioningState");
  });
});

describe("EdgeActions preview contracts", () => {
  it("checks every PUT resource for consistent ancestor and child mutability", () => {
    for (const route of Object.values(swagger.paths)) {
      if (!route.put) continue;
      const body = requestBody(route.put);
      expect(mutabilityConflicts(body, file), route.put.operationId).toEqual([]);
      const properties = schemaProperties(body, file).properties;
      expect(properties, route.put.operationId).toBeDefined();
      expect(resolveSchema(properties.schema, properties.file).schema["x-ms-mutability"]).toEqual(
        expect.arrayContaining(["read", "create", "update"]),
      );
    }
  });

  it("keeps every PATCH field optional and reachable in the matching PUT update path", () => {
    for (const route of Object.values(swagger.paths)) {
      if (!route.patch || !route.put) continue;
      const patch = requestBody(route.patch);
      const putPaths = writablePaths(requestBody(route.put), file, "update");
      for (const field of writablePaths(patch, file, "update")) {
        expect(putPaths, `${route.patch.operationId}: ${field}`).toContain(field);
      }
      const assertOptional = (schema: Schema, source: string) => {
        const located = resolveSchema(schema, source);
        expect(located.schema.required ?? []).toEqual([]);
        for (const child of Object.values(schemaProperties(schema, source))) {
          assertOptional(child.schema, child.file);
        }
      };
      assertOptional(patch, file);
    }
  });

  it("exposes all three filter fields to both create and GET/modify/PUT update", () => {
    const put = requestBody(operation("EdgeActionExecutionFilters_Create"));
    for (const lifecycle of ["create", "update"] as const) {
      expect(writablePaths(put, file, lifecycle)).toEqual(
        expect.arrayContaining([
          "properties.versionId",
          "properties.executionFilterIdentifierHeaderName",
          "properties.executionFilterIdentifierHeaderValue",
        ]),
      );
    }
  });

  it("keeps parent and version PATCH tags-only and version state response-only", () => {
    expect(operation("EdgeActions_Update").parameters?.[4].in).toBe("body");
    for (const id of ["EdgeActions_Update", "EdgeActionVersions_Update"]) {
      expect(Object.keys(schemaProperties(requestBody(operation(id)), file))).toEqual(["tags"]);
    }
    const body = requestBody(operation("EdgeActionVersions_Create"));
    const paths = writablePaths(body, file, "create");
    for (const name of ["isDefaultVersion", "versionExecutionState", "deploymentStatus"]) {
      expect(paths).not.toContain(`properties.${name}`);
    }
    const properties = swagger.definitions.EdgeActionVersionProperties;
    expect(properties.required).toEqual(
      expect.arrayContaining(["versionExecutionState", "deploymentStatus"]),
    );
    expect(properties.properties).not.toHaveProperty("isDefaultVersion");
  });

  it("keeps LRO headers and logical deployment result aligned with merged fixes", () => {
    for (const route of Object.values(swagger.paths)) {
      for (const [method, op] of Object.entries(route)) {
        if (!op["x-ms-long-running-operation"]) continue;
        const codes = method === "put" ? ["200", "201"] : ["202"];
        for (const code of codes) {
          const headers = op.responses[code].headers ?? {};
          expect(headers, `${op.operationId} ${code}`).toHaveProperty("Azure-AsyncOperation");
          expect(headers).toHaveProperty("Retry-After");
          expect(headers["Retry-After"]).toMatchObject({ minimum: 10, maximum: 600 });
          expect(headers).toHaveProperty(method === "put" ? "Azure-AsyncOperation" : "Location");
          if (method === "put") expect(headers).not.toHaveProperty("Location");
        }
        expect(op["x-ms-long-running-operation-options"]?.["final-state-via"]).toBe(
          method === "put" ? "azure-async-operation" : "location",
        );
      }
    }
    expect(operation("EdgeActionVersions_DeployVersionCode").responses["200"].schema?.$ref).toBe(
      "#/definitions/EdgeActionVersion",
    );
    const getCode = operation("EdgeActionVersions_GetVersionCode");
    expect(getCode["x-ms-long-running-operation"]).toBeUndefined();
    expect(Object.keys(getCode.responses)).toEqual(["200", "default"]);
    expect(
      getCode.parameters?.some(
        (parameter) => parameter.in === "body" || parameter.name?.toLowerCase() === "content-type",
      ),
    ).toBe(false);
    expect(Object.keys(swagger.definitions.VersionCode.properties ?? {})).toEqual(["content"]);
    const result = operation("EdgeActionOperationResults_Get");
    expect(result.responses["200"].schema?.$ref).toBe(
      "#/definitions/EdgeActionOperationResultPayload",
    );
    expect(resolveSchema(result.responses["200"].schema!, file).schema).toMatchObject({
      type: "object",
      additionalProperties: {},
    });
    expect(result.responses["202"].schema).toBeUndefined();
    expect(result.responses["202"].headers).toHaveProperty("Location");
    expect(result.responses["204"].schema).toBeUndefined();
  });

  it("uses the same preview version and example contents in source and emitted files", () => {
    expect(swagger.info.version).toBe(version);
    const sources = resolve(root, "examples", version);
    const generated = resolve(root, "preview", version, "examples");
    const names = readdirSync(sources)
      .filter((name) => name.endsWith(".json"))
      .sort();
    expect(
      readdirSync(generated)
        .filter((name) => name.endsWith(".json"))
        .sort(),
    ).toEqual(names);
    for (const name of names) {
      const example = JSON.parse(readFileSync(resolve(sources, name), "utf8")) as {
        operationId: string;
        parameters: Record<string, unknown>;
        responses: Record<string, { headers?: Record<string, unknown> }>;
      };
      expect(JSON.parse(readFileSync(resolve(generated, name), "utf8"))).toEqual(example);
      expect(example.parameters["api-version"], name).toBe(version);
      expect(
        Object.values(operation(example.operationId)["x-ms-examples"] ?? {}).some((reference) =>
          reference.$ref.endsWith(name),
        ),
        name,
      ).toBe(true);
      for (const response of Object.values(example.responses)) {
        for (const [header, value] of Object.entries(response.headers ?? {})) {
          if (["Location", "Azure-AsyncOperation"].includes(header)) {
            const url = new URL(String(value));
            expect(url.searchParams.get("api-version"), name).toBe(version);
            const segments = url.pathname.split("/");
            const route = Object.entries(swagger.paths).find(([path]) => {
              const template = path.split("/");
              return (
                template.length === segments.length &&
                template.every(
                  (segment, index) => /^\{[^}]+\}$/.test(segment) || segment === segments[index],
                )
              );
            });
            expect(route?.[1].get?.operationId, `${name}: ${header}`).toBe(
              header === "Azure-AsyncOperation"
                ? "EdgeActionOperations_Get"
                : "EdgeActionOperationResults_Get",
            );
          }
        }
      }
    }
  });

  it("keeps stable SDK selection and resolves the opt-in preview through service.yaml", () => {
    const readme = readFileSync(resolve(root, "readme.md"), "utf8");
    const blocks = [...readme.matchAll(/``` ?yaml([^\n]*)\n([\s\S]*?)```/g)];
    const basic = blocks.find((block) => !block[1].trim());
    const basicConfig = parse(basic![2]) as { tag?: string };
    expect(basicConfig.tag).toBe("package-2026-10-01");
    const selected = blocks.find((block) => block[1].includes(`'package-${version}'`));
    const previewConfig = parse(selected![2]) as { "input-file"?: string[] };
    expect(previewConfig["input-file"]).toEqual([`preview/${version}/openapi.json`]);
    const manifest = parse(readFileSync(resolve(root, "service.yaml"), "utf8")) as {
      versions: { version: string; "swagger-files": string[] }[];
    };
    expect(manifest.versions.find((entry) => entry.version === version)?.["swagger-files"]).toEqual(
      [`preview/${version}/openapi.json`],
    );
  });
});
