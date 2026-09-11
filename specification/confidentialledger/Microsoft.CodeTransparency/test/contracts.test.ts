import {
  getAllServicesAtAllVersions,
  resolveAutorestOptions,
} from "@azure-tools/typespec-autorest";
import { createSdkContext, getAccessOverride } from "@azure-tools/typespec-client-generator-core";
import {
  compile,
  getDeprecationDetails,
  getDoc,
  getMaxLength,
  listServices,
  NodeHost,
  resolveCompilerOptions,
  resolveEncodedName,
  type Namespace,
  type Program,
  type Type,
} from "@typespec/compiler";
import { unsafe_mutateSubgraphWithNamespace } from "@typespec/compiler/experimental";
import { createPerfReporter } from "@typespec/compiler/utils";
import {
  getHttpService,
  isSharedRoute,
  type HttpOperation,
  type HttpService,
} from "@typespec/http";
import { getVersioningMutators } from "@typespec/versioning";
import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import { resolve } from "node:path";
import { beforeAll, describe, expect, it } from "vitest";

const project = resolve(import.meta.dirname, "..");
const versions = ["2025-01-31-preview", "2026-03-26"] as const;
const originalNames = [
  "getTransparencyConfigCbor",
  "getPublicKeys",
  "createEntry",
  "getOperation",
  "getEntry",
  "getEntryStatement",
];
const scittNames = ["listScittKeys", "getScittKey"];
let program: Program;
let namespace: Namespace;
const httpServices = new Map<string, HttpService>();

type Json = string | number | boolean | Json[] | { [key: string]: Json };

function typeShape(type: Type, seen = new Set<Type>()): Json {
  if (type.kind === "String" || type.kind === "Number" || type.kind === "Boolean") {
    return type.value;
  }
  if (type.kind === "Union") {
    return [...type.variants.values()].map((variant) => typeShape(variant.type, seen));
  }
  if (type.kind !== "Model") {
    return "name" in type && typeof type.name === "string" ? type.name : type.kind;
  }
  if (seen.has(type)) return { ref: type.name };
  const next = new Set([...seen, type]);
  return {
    name: type.name,
    ...(type.indexer ? { indexer: typeShape(type.indexer.value, next) } : {}),
    properties: [...type.properties.values()].map((property) => ({
      name: property.name,
      wire: resolveEncodedName(program, property, "application/json"),
      optional: property.optional,
      type: typeShape(property.type, next),
    })),
    ...(type.baseModel ? { base: typeShape(type.baseModel, next) } : {}),
  };
}

function httpContract(operations: HttpOperation[]) {
  return operations
    .map((operation) => ({
      path: operation.path,
      verb: operation.verb,
      parameters: operation.parameters.parameters.map((parameter) => ({
        name: parameter.name,
        location: parameter.type,
        optional: parameter.param.optional,
        type: typeShape(parameter.param.type),
      })),
      body: operation.parameters.body && {
        contentTypes: operation.parameters.body.contentTypes,
        type: typeShape(operation.parameters.body.type),
      },
      responses: operation.responses
        .map((response) => ({
          status: response.statusCodes,
          type: typeShape(response.type),
          content: response.responses.map((content) => ({
            headers: Object.entries(content.headers ?? {}).map(([name, property]) => ({
              name,
              optional: property.optional,
              type: typeShape(property.type),
            })),
            body: content.body && {
              contentTypes: content.body.contentTypes,
              type: typeShape(content.body.type),
            },
          })),
        }))
        .sort((a, b) => Number(a.status) - Number(b.status)),
      name: operation.operation.name,
    }))
    .sort((a, b) => a.path.localeCompare(b.path));
}

function service(version: string) {
  const result = httpServices.get(version);
  assert.ok(result, `Missing HTTP projection for ${version}`);
  return result;
}

function operation(version: string, name: string) {
  const result = service(version).operations.find((op) => op.operation.name === name);
  assert.ok(result, `Missing ${name} in ${version}`);
  return result;
}

function response(version: string, name: string, status: number) {
  const result = operation(version, name).responses.find((r) => r.statusCodes === status);
  assert.ok(result, `Missing ${status} response for ${name} in ${version}`);
  expect(result.responses).toHaveLength(1);
  return result.responses[0];
}

beforeAll(async () => {
  const [options, diagnostics] = await resolveCompilerOptions(NodeHost, {
    entrypoint: resolve(project, "main.tsp"),
    cwd: project,
  });
  expect(diagnostics).toEqual([]);
  program = await compile(NodeHost, resolve(project, "main.tsp"), {
    ...options,
    noEmit: true,
  });
  expect(program.diagnostics).toEqual([]);
  namespace = listServices(program)[0].type;
  const mutations = getVersioningMutators(program, namespace);
  assert.equal(mutations?.kind, "versioned");
  expect(mutations.snapshots.map((snapshot) => snapshot.version.value)).toEqual(versions);
  for (const snapshot of mutations.snapshots) {
    const { type } = unsafe_mutateSubgraphWithNamespace(program, [snapshot.mutator], namespace);
    assert.equal(type.kind, "Namespace");
    const [http, httpDiagnostics] = getHttpService(program, type);
    expect(httpDiagnostics).toEqual([]);
    httpServices.set(snapshot.version.value, http);
  }
}, 30_000);

it("declares one stable operation per endpoint without shared-route aliases", () => {
  expect([...namespace.operations.keys()].sort()).toEqual([...originalNames, ...scittNames].sort());
  for (const op of namespace.operations.values()) {
    expect(isSharedRoute(program, op)).toBe(false);
  }
});

it("keeps both checked-in OpenAPI projections synchronized with the TypeSpec config", async () => {
  const [options] = await resolveCompilerOptions(NodeHost, {
    entrypoint: resolve(project, "main.tsp"),
    cwd: project,
  });
  const autorest = options.options?.["@azure-tools/typespec-autorest"];
  assert.ok(autorest, "AutoRest configuration must exist");
  assert.ok(typeof autorest["output-file"] === "string");
  const records = await getAllServicesAtAllVersions(
    program,
    resolveAutorestOptions(program, resolve(project, ".."), {
      ...autorest,
      "output-file": autorest["output-file"],
    }),
  );
  expect(program.diagnostics).toEqual([]);
  expect(records).toHaveLength(1);
  assert.ok(records[0].versioned);
  for (const record of records[0].versions) {
    const checkedIn: unknown = JSON.parse(await readFile(record.outputFile, "utf8"));
    expect(JSON.parse(JSON.stringify(record.document))).toEqual(checkedIn);
  }
});

describe.each(versions)("%s REST contract", (version) => {
  const latest = version === "2026-03-26";

  it("matches the pre-consolidation HTTP and model baseline", async () => {
    // Only baseline operation names were normalized. Documentation/deprecation are
    // asserted separately; wire names, optionality, types, media and headers are not.
    await expect(
      JSON.stringify(httpContract(service(version).operations), null, 2) + "\n",
    ).toMatchFileSnapshot(resolve(import.meta.dirname, `${version}.snap`));
  });

  it("retains the correct endpoint set and bearer authentication", () => {
    const http = service(version);
    expect(http.operations.map((op) => op.operation.name).sort()).toEqual(
      [...originalNames, ...(latest ? scittNames : [])].sort(),
    );
    expect(http.authentication).toMatchObject({
      options: [{ schemes: [{ type: "http", scheme: "Bearer" }] }],
    });
  });

  it("versions the spread waitForCommit property, not just its container", () => {
    const create = operation(version, "createEntry");
    const wait = create.parameters.parameters.find(
      (parameter) => parameter.name === "waitForCommit",
    );
    if (latest) {
      expect(wait).toMatchObject({
        type: "query",
        param: { optional: true, type: { kind: "Scalar", name: "boolean" } },
      });
    } else {
      expect(wait).toBeUndefined();
      expect(create.operation.parameters.properties.has("waitForCommit")).toBe(false);
    }
    expect(create.parameters.body).toMatchObject({
      contentTypes: ["application/cose"],
      type: { kind: "Scalar", name: "bytes" },
    });
  });

  it.each([
    ["getEntry", "application/scitt-receipt+cose"],
    ["getEntryStatement", "application/scitt-statement+cose"],
  ])("versions %s request and response media", (name, currentMedia) => {
    const accept = operation(version, name).parameters.parameters.find((p) => p.name === "accept");
    expect(accept).toMatchObject({
      type: "header",
      param: {
        optional: false,
        type: { kind: "String", value: latest ? currentMedia : "application/cose" },
      },
    });
    expect(response(version, name, 200).body?.contentTypes).toEqual([
      latest ? currentMedia : "application/cose",
    ]);
  });

  it("retains entry submission statuses, body shape and header requiredness", () => {
    const created = response(version, "createEntry", 201);
    expect(created.body?.contentTypes).toEqual([
      latest ? "application/scitt-receipt+cose" : "application/cose",
    ]);
    expect(created.headers?.Location?.optional).toBe(true);
    expect(created.headers?.["x-ms-ccf-transaction-id"]?.optional).toBe(latest ? true : undefined);
    const pending = response(version, "createEntry", latest ? 303 : 202);
    expect(pending.headers?.Location?.optional).toBe(!latest);
    if (latest) {
      expect(pending.body).toBeUndefined();
      expect(pending.headers?.["x-ms-ccf-transaction-id"]?.optional).toBe(false);
    } else {
      expect(pending.body).toMatchObject({
        contentTypes: ["application/cbor"],
        type: { name: "bytes" },
      });
      expect(pending.headers?.["Retry-After"]?.optional).toBe(true);
    }
  });

  it("keeps the legacy JWKS and public-only current JWKS distinct", () => {
    const body = response(version, "getPublicKeys", 200).body;
    assert.ok(body);
    expect(body.contentTypes).toEqual(["application/json"]);
    assert.equal(body.type.kind, "Model");
    const keys = body.type.properties.get("keys");
    assert.ok(keys);
    expect(keys.optional).toBe(false);
    assert.equal(keys.type.kind, "Model");
    const key = keys.type.indexer?.value;
    assert.equal(key?.kind, "Model");
    const properties = [...key.properties.values()];
    const wireNames = properties.map((p) => resolveEncodedName(program, p, "application/json"));
    expect(wireNames.sort()).toEqual(
      (latest
        ? ["kty", "kid", "alg", "use", "crv", "x", "y", "n", "e", "x5c"]
        : [
            "alg",
            "crv",
            "d",
            "dp",
            "dq",
            "e",
            "k",
            "kid",
            "kty",
            "n",
            "p",
            "q",
            "qi",
            "use",
            "x",
            "x5c",
            "y",
          ]
      ).sort(),
    );
    expect(
      properties
        .filter((p) => !p.optional)
        .map((p) => resolveEncodedName(program, p, "application/json"))
        .sort(),
    ).toEqual(latest ? ["kid", "kty"] : ["kty"]);
  });

  it("only adds the receipt polling redirect in the current version", () => {
    const op = operation(version, "getEntry");
    expect(op.responses.some((r) => r.statusCodes === 302)).toBe(latest);
    if (latest) {
      const pending = response(version, "getEntry", 302);
      expect(pending.body).toBeUndefined();
      expect(pending.headers?.Location?.optional).toBe(false);
      expect(pending.headers?.["Retry-After"]?.optional).toBe(true);
    }
  });

  it("keeps the operations endpoint and version-qualified deprecation guidance", () => {
    const op = operation(version, "getOperation");
    expect(op.path).toBe("/operations/{operationId}");
    expect(getDoc(program, op.operation)).toContain("starting with api-version=2026-03-26");
    expect(getDeprecationDetails(program, op.operation)?.message).toContain(
      "api-version=2026-03-26",
    );
    expect(response(version, "getOperation", 200).body?.contentTypes).toEqual(["application/cbor"]);
    expect(response(version, "getOperation", 202).body).toBeUndefined();
  });

  it("only adds 401 to entry operations, never to JWKS", () => {
    for (const name of [
      "createEntry",
      "getOperation",
      "getEntry",
      "getEntryStatement",
      "getPublicKeys",
    ]) {
      const codes = operation(version, name).responses.map((r) => r.statusCodes);
      expect(codes.includes(401)).toBe(latest && name !== "getPublicKeys");
      for (const code of [400, 404, 429, 500, 503]) {
        expect(response(version, name, code).body?.contentTypes).toEqual([
          "application/concise-problem-details+cbor",
        ]);
      }
      const unavailable = response(version, name, 503);
      expect(unavailable.headers?.["Retry-After"]?.optional).toBe(true);
      expect(unavailable.headers?.["x-ms-ccf-transaction-id"]?.optional).toBe(
        latest ? true : undefined,
      );
    }
  });

  it("keeps path identifier constraints and required API-version parameters", () => {
    for (const op of service(version).operations) {
      const apiVersion = op.parameters.parameters.find((p) => p.name === "api-version");
      expect(apiVersion).toMatchObject({ type: "query", param: { optional: false } });
      for (const parameter of op.parameters.parameters) {
        if (["entryId", "operationId"].includes(parameter.name)) {
          expect(parameter.param.optional).toBe(false);
          expect(getMaxLength(program, parameter.param)).toBe(100);
        }
      }
    }
  });

  it.each(["csharp", "java", "python", "javascript"])(
    "uses stable %s SDK names and customizations",
    async (language) => {
      const context = await createSdkContext(
        {
          program,
          emitterOutputDir: project,
          options: { "api-version": version },
          perf: createPerfReporter(),
        },
        `@azure-tools/typespec-${language}`,
        { exportTCGCoutput: false },
      );
      expect(context.diagnostics.filter((diagnostic) => diagnostic.severity === "error")).toEqual(
        [],
      );
      const methods = context.sdkPackage.clients.flatMap((client) => client.methods);
      expect(methods.map((method) => method.name).sort()).toEqual(
        [...originalNames, ...(latest ? scittNames : [])].sort(),
      );
      expect(methods.every((method) => method.kind === "basic")).toBe(true);
      expect(methods.every((method) => method.apiVersions.includes(version))).toBe(true);
      expect(methods.find((method) => method.name === "getPublicKeys")?.generateConvenient).toBe(
        language !== "csharp",
      );
      if (latest && language === "csharp") {
        for (const name of scittNames) {
          expect(methods.find((method) => method.name === name)?.generateConvenient).toBe(false);
        }
        for (const name of ["GetPublicKeysResponse", "JsonWebKeySet", "PublicJsonWebKey"]) {
          const model = namespace.models.get(name);
          assert.ok(model);
          expect(getAccessOverride(context, model)).toBe("internal");
        }
      }
      const create = methods.find((method) => method.name === "createEntry");
      assert.ok(create);
      expect(create.operation.bodyParam?.type.kind).toBe(
        language === "javascript" ? "string" : "bytes",
      );
    },
    30_000,
  );
});
