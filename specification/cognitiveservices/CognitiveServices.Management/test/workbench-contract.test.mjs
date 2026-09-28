// Run after tsp compile: node --test specification/cognitiveservices/CognitiveServices.Management/test/workbench-contract.test.mjs
// Set WORKBENCH_BASE_REF explicitly to enable Git history and unrelated-diff checks.
import assert from "node:assert/strict";
import { execFileSync } from "node:child_process";
import { createHash } from "node:crypto";
import { readFileSync, readdirSync } from "node:fs";
import path from "node:path";
import { test } from "node:test";
import { fileURLToPath } from "node:url";
import { compile, NodeHost } from "@typespec/compiler";
import { createSdkContext } from "@azure-tools/typespec-client-generator-core";

const project = fileURLToPath(new URL("../", import.meta.url));
const root = path.resolve(project, "../../..");
const version = "2026-09-15-preview";
const baselineRef = process.env.WORKBENCH_BASE_REF;
const specFile = path.resolve(
  project,
  `../resource-manager/Microsoft.CognitiveServices/preview/${version}/cognitiveservices.json`,
);
const examples = path.join(project, "examples", version);
const spec = JSON.parse(readFileSync(specFile, "utf8"));
const git = (...args) =>
  execFileSync("git", args, { cwd: root, maxBuffer: 32 * 1024 * 1024 });
const workbenchPath = Object.keys(spec.paths).find(
  (key) => spec.paths[key].patch?.operationId === "Workbenches_Update",
);
assert(workbenchPath, "Workbench operation path must exist");
const operations = spec.paths[workbenchPath];
const definitions = spec.definitions;
const documents = new Map([[specFile, spec]]);
const identityDescription =
  "Identity for the resource. May be changed while the workbench is running only when properties is omitted or null; the change takes effect after restart. If a properties object is supplied, including an empty object or timeout-only update, changing identity requires the workbench to be stopped.";

function resolve(schema, file) {
  if (!schema.$ref) return [schema, file];
  const [relativeFile, fragment] = schema.$ref.split("#");
  const target = relativeFile
    ? path.resolve(path.dirname(file), relativeFile)
    : file;
  if (!documents.has(target)) {
    documents.set(target, JSON.parse(readFileSync(target, "utf8")));
  }
  const resolved = (fragment ?? "")
    .split("/")
    .slice(1)
    .reduce(
      (value, key) => value[key.replaceAll("~1", "/").replaceAll("~0", "~")],
      documents.get(target),
    );
  assert(resolved, `Unresolved schema reference: ${schema.$ref}`);
  return [resolved, target];
}

function envelope(schema, file = specFile) {
  [schema, file] = resolve(schema, file);
  const properties = { ...schema.properties };
  for (const base of schema.allOf ?? []) {
    Object.assign(properties, envelope(base, file));
  }
  return properties;
}

function assertNullableCount(property) {
  assert.equal(property.type, "integer");
  assert.equal(property.format, "int32");
  assert.equal(property.minimum, 1);
  assert.equal(property["x-nullable"], true);
  assert.equal(
    property.enum,
    undefined,
    "Counts such as 128 must remain valid",
  );
  assert.equal(property.maximum, undefined);
  assert.equal(
    property.default,
    undefined,
    "Defaults are selected by the service",
  );
}

test("Workbench stays proxy-only, including inherited envelope fields", () => {
  assert.deepEqual(Object.keys(envelope(definitions.Workbench)).sort(), [
    "etag",
    "id",
    "identity",
    "name",
    "properties",
    "systemData",
    "type",
  ]);
  assert.deepEqual(definitions.Workbench.required, ["properties"]);
});

test("create keeps required fields and exposes read/create-only image and mount settings", () => {
  const properties = definitions.WorkbenchProperties.properties;
  assert.deepEqual(definitions.WorkbenchProperties.required, [
    "targetClusterId",
    "imageLink",
  ]);
  for (const name of ["imageLink", "datasetId", "sshSettings"]) {
    assert.deepEqual(properties[name]["x-ms-mutability"], ["read", "create"]);
  }
  assert.equal(Object.hasOwn(properties, "runtimeImage"), false);
  assert.equal(properties.instanceType.type, "string");
  assert.equal(properties.instanceType["x-nullable"], true);
  assertNullableCount(properties.gpuCount);
});

test("PATCH is independently optional and contains only supported mutable fields", () => {
  const body = operations.patch.parameters.find((p) => p.in === "body");
  assert.deepEqual(body.schema, { $ref: "#/definitions/WorkbenchUpdate" });
  const update = definitions.WorkbenchUpdate;
  const properties = definitions.WorkbenchUpdateProperties;
  for (const model of [update, properties]) {
    assert.equal(model.required, undefined);
    assert.equal(model.allOf, undefined);
  }
  assert.deepEqual(Object.keys(update.properties).sort(), [
    "identity",
    "properties",
  ]);
  assert.deepEqual(Object.keys(properties.properties).sort(), [
    "gpuCount",
    "idleTimeBeforeShutdown",
    "instanceType",
    "targetClusterId",
  ]);
  for (const property of Object.values(properties.properties)) {
    assert.equal(property.readOnly, undefined);
  }
  assert.equal(properties.properties.instanceType["x-nullable"], true);
  assertNullableCount(properties.properties.gpuCount);
  assert.doesNotMatch(properties.properties.gpuCount.description, /stopped/i);
  assert.equal(update.properties.identity.description, identityDescription);
  assert.deepEqual(Object.keys(operations.patch.responses), ["200", "default"]);
  assert.deepEqual(operations.patch.responses["200"].schema, {
    $ref: "#/definitions/Workbench",
  });
  assert(
    !Object.keys(operations.patch).some((k) =>
      k.startsWith("x-ms-long-running-operation"),
    ),
  );
});

test("runtime status is extensible, read-only and distinct from provisioning", () => {
  const properties = definitions.WorkbenchProperties.properties;
  assert.equal(properties.status.readOnly, true);
  assert.equal(properties.provisioningState.readOnly, true);
  assert.deepEqual(properties.status.$ref, "#/definitions/WorkbenchStatus");
  assert.deepEqual(definitions.WorkbenchStatus.enum, [
    "Unknown",
    "Creating",
    "Starting",
    "Running",
    "Stopping",
    "Stopped",
    "Restarting",
    "Updating",
    "Deleting",
    "Failed",
  ]);
  assert.equal(definitions.WorkbenchStatus["x-ms-enum"].modelAsString, true);
  assert.deepEqual(definitions.WorkbenchProvisioningState.enum, [
    "Creating",
    "Succeeded",
    "Failed",
    "Canceled",
  ]);
});

test("PUT returns a resource with 200/201 and documents polling for pending repetitions", () => {
  const put = operations.put;
  assert.deepEqual(Object.keys(put.responses), ["200", "201", "default"]);
  for (const status of ["200", "201"]) {
    assert.deepEqual(put.responses[status].schema, {
      $ref: "#/definitions/Workbench",
    });
    assert(put.responses[status].headers["Azure-AsyncOperation"]);
    assert(
      Object.keys(put.responses[status].headers).some(
        (name) => name.toLowerCase() === "location",
      ),
    );
    assert(put.responses[status].headers["Retry-After"]);
  }
  assert.equal(put["x-ms-long-running-operation"], true);
  const source = readFileSync(path.join(project, "Workbench.tsp"), "utf8");
  assert.doesNotMatch(source, /useFinalStateVia|@extension/);
});

if (baselineRef) {
  const baseline = JSON.parse(
    git(
      "show",
      `${baselineRef}:${path.relative(root, specFile).split(path.sep).join("/")}`,
    ),
  );
  test("unrelated target operations and definitions are unchanged", () => {
    for (const [route, methods] of Object.entries(baseline.paths)) {
      for (const [method, operation] of Object.entries(methods)) {
        if (route === workbenchPath && ["put", "patch"].includes(method))
          continue;
        assert.deepEqual(
          spec.paths[route][method],
          operation,
          `${method} ${route}`,
        );
      }
    }
    for (const [name, model] of Object.entries(baseline.definitions)) {
      if (
        [
          "Workbench",
          "WorkbenchProperties",
          "WorkbenchUpdateProperties",
        ].includes(name)
      )
        continue;
      const expected = structuredClone(model);
      if (name === "WorkbenchUpdate")
        expected.properties.identity.description = identityDescription;
      assert.deepEqual(definitions[name], expected, name);
    }
  });

  test("all 4255 historical contracts/examples retain their original Git blob hashes", () => {
    const files = git(
      "ls-tree",
      "-r",
      "-z",
      baselineRef,
      "--",
      "specification/cognitiveservices",
    )
      .toString()
      .split("\0")
      .filter(Boolean);
    let checked = 0;
    for (const entry of files) {
      const [metadata, file] = entry.split("\t");
      if (!file.endsWith(".json") || file.includes(version)) continue;
      if (
        !file.includes("/resource-manager/") &&
        !file.includes("/CognitiveServices.Management/examples/")
      )
        continue;
      const content = readFileSync(path.resolve(root, file));
      const hash = createHash("sha1")
        .update(Buffer.from(`blob ${content.length}\0`))
        .update(content)
        .digest("hex");
      assert.equal(hash, metadata.split(" ")[2], file);
      checked++;
    }
    assert.equal(checked, 4255);
  });
}

test("Workbench examples match generation and omit runtimeImage and forbidden envelope properties", () => {
  const files = readdirSync(examples).filter(
    (f) => f.includes("Workbench") && f.endsWith(".json"),
  );
  assert.equal(files.length, 11);
  const operationIds = new Set();
  for (const file of files) {
    const content = readFileSync(path.join(examples, file));
    assert.deepEqual(
      content,
      readFileSync(path.join(path.dirname(specFile), "examples", file)),
    );
    assert.doesNotMatch(content.toString("utf8"), /"runtimeImage"\s*:/, file);
    const example = JSON.parse(content);
    operationIds.add(example.operationId);
    assert.equal(example.parameters["api-version"], version);
    const bodies = [example.parameters.resource, example.parameters.properties];
    for (const response of Object.values(example.responses)) {
      bodies.push(...(response.body?.value ?? [response.body]));
      if (
        example.operationId === "Workbenches_CreateOrUpdate" &&
        response.headers
      ) {
        const monitor = new URL(response.headers["Azure-AsyncOperation"]);
        assert.match(monitor.pathname, /\/computeoperations\/[^/]+$/);
        assert.equal(
          monitor.searchParams.get("api-version"),
          "2026-01-15-preview",
        );
        assert.equal(monitor.searchParams.get("type"), "async");
        const location = new URL(response.headers.Location);
        assert.equal(location.origin, monitor.origin);
        assert.equal(location.pathname, monitor.pathname);
        assert.equal(
          location.searchParams.get("api-version"),
          "2026-01-15-preview",
        );
        assert.equal(location.searchParams.get("type"), "location");
        assert.equal(Number(response.headers["Retry-After"]), 5);
      }
    }
    for (const body of bodies.filter(Boolean)) {
      assert(
        !Object.hasOwn(body, "tags") && !Object.hasOwn(body, "location"),
        file,
      );
    }
  }
  assert.equal(operationIds.size, 8);
  const minimal = JSON.parse(
    readFileSync(path.join(examples, "UpdateWorkbench.json")),
  );
  assert.deepEqual(minimal.parameters.properties, {
    properties: { idleTimeBeforeShutdown: "PT1H" },
  });
  const create = JSON.parse(
    readFileSync(path.join(examples, "PutWorkbench.json")),
  );
  assert.equal(
    create.responses["201"].body.properties.provisioningState,
    "Creating",
  );
  assert.equal(
    create.responses["200"].body.properties.provisioningState,
    "Succeeded",
  );
  assert(create.responses["201"].headers["Azure-AsyncOperation"]);
  const updateCompute = JSON.parse(
    readFileSync(path.join(examples, "UpdateWorkbenchComputeProperties.json")),
  );
  const virtualClusterId =
    "/subscriptions/11111111-1111-1111-1111-111111111111/resourceGroups/vc-rg/providers/Microsoft.MachineLearningServices/virtualClusters/test-vc";
  for (const properties of [
    create.parameters.resource.properties,
    updateCompute.parameters.properties.properties,
  ]) {
    assert.equal(properties.targetClusterId, virtualClusterId);
    assert.equal(properties.instanceType, "Singularity.ND12_H100_v5-n1");
    assert.equal(properties.gpuCount, 1);
  }
  const reset = JSON.parse(
    readFileSync(
      path.join(examples, "UpdateWorkbenchResetComputeProperties.json"),
    ),
  );
  assert.deepEqual(reset.parameters.properties, {
    properties: { instanceType: null, gpuCount: null },
  });
  assert.deepEqual(Object.keys(reset.responses), ["200"]);
  assert.equal(
    reset.responses["200"].body.properties.targetClusterId,
    virtualClusterId,
  );
  assert.equal(reset.responses["200"].body.properties.instanceType, null);
  assert.equal(reset.responses["200"].body.properties.gpuCount, null);
  const pending = JSON.parse(
    readFileSync(path.join(examples, "PutWorkbenchPending.json")),
  );
  assert.deepEqual(Object.keys(pending.responses), ["200", "201"]);
  assert.equal(
    pending.responses["200"].body.properties.provisioningState,
    "Creating",
  );
  assert(pending.responses["200"].headers["Azure-AsyncOperation"]);
});

let sdkContext;
async function getSdkContext() {
  if (sdkContext) return sdkContext;
  const program = await compile(NodeHost, path.join(project, "main.tsp"), {
    noEmit: true,
  });
  assert(
    !program.hasError(),
    "TypeSpec must compile before inspecting SDK models",
  );
  sdkContext = await createSdkContext(
    { program, emitterOutputDir: project, options: { "api-version": version } },
    "@azure-tools/typespec-csharp",
  );
  return sdkContext;
}

test("public Workbench Swagger and SDK models omit runtimeImage", async () => {
  for (const [name, model] of Object.entries(definitions)) {
    if (name.startsWith("Workbench")) {
      assert.equal(Object.hasOwn(envelope(model), "runtimeImage"), false, name);
    }
  }
  const context = await getSdkContext();
  const models = context.sdkPackage.models.filter((model) =>
    model.__raw?.name.startsWith("Workbench"),
  );
  assert(
    models.some((model) => model.__raw.name === "WorkbenchProperties"),
    "SDK resource properties model must exist",
  );
  for (const model of models) {
    assert.equal(
      model.properties.some(
        (property) =>
          property.name === "runtimeImage" ||
          property.serializedName === "runtimeImage",
      ),
      false,
      model.name,
    );
  }
});

test("SDK input models preserve optional-plus-nullable reset values", async () => {
  const context = await getSdkContext();
  const update = context.sdkPackage.models.find(
    (model) => model.__raw?.name === "WorkbenchUpdateProperties",
  );
  assert(update, "SDK PATCH properties model must exist");
  for (const name of ["instanceType", "gpuCount"]) {
    const property = update.properties.find((p) => p.serializedName === name);
    assert(property, name);
    assert.equal(property.optional, true, name);
    assert.equal(property.type.kind, "nullable", name);
  }
});

test("PUT SDK and Swagger retrieve the final resource from its original URI", async () => {
  const context = await getSdkContext();
  function* allClients(clients) {
    for (const client of clients) {
      yield client;
      yield* allClients(client.children ?? []);
    }
  }
  const method = [...allClients(context.sdkPackage.clients)]
    .flatMap((client) => client.methods)
    .find(
      (candidate) =>
        candidate.crossLanguageDefinitionId ===
        "Microsoft.CognitiveServices.Workbenches.createOrUpdate",
    );
  assert(method, "SDK PUT method must exist");
  assert.equal(method.kind, "lro");
  const metadata = method.lroMetadata;
  assert.equal(metadata.finalResponse.result.__raw.name, "Workbench");
  assert.equal(metadata.finalResponse.envelopeResult.__raw.name, "Workbench");
  assert.equal(metadata.__raw.logicalResult.name, "Workbench");
  assert.equal(metadata.__raw.finalResult.name, "Workbench");
  assert.equal(
    metadata.pollingStep.responseBody.__raw.name,
    "ArmOperationStatus",
  );
  assert.equal(metadata.__raw.pollingInfo.kind, "pollingOperationStep");
  assert.equal(
    metadata.__raw.pollingInfo.responseModel.name,
    "ArmOperationStatus",
  );
  for (const monitor of [
    metadata.statusMonitorStep,
    metadata.__raw.statusMonitorStep,
  ]) {
    assert.equal(monitor.kind, "nextOperationLink");
    assert.equal(monitor.target.location, "ResponseHeader");
    assert.equal(monitor.target.property.name, "azureAsyncOperation");
  }
  assert.equal(
    metadata.__raw.statusMonitorStep.responseModel.name,
    "ArmOperationStatus",
  );
  for (const finalStep of [metadata.finalStep, metadata.__raw.finalStep]) {
    assert.equal(
      finalStep,
      undefined,
      "The status URL must not be a final result link",
    );
  }
  assert.deepEqual(
    {
      swagger:
        operations.put["x-ms-long-running-operation-options"][
          "final-state-via"
        ],
      sdk: metadata.finalStateVia,
      raw: metadata.__raw.finalStateVia,
    },
    { swagger: "original-uri", sdk: "original-uri", raw: "original-uri" },
  );
});
