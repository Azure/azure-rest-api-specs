import assert from "node:assert/strict";
import { readFileSync } from "node:fs";
import path from "node:path";
import { test } from "node:test";
import { fileURLToPath } from "node:url";

const root = fileURLToPath(new URL("../../", import.meta.url));
const project = path.join(
  root,
  "specification",
  "cognitiveservices",
  "resource-manager",
  "Microsoft.CognitiveServices",
  "CognitiveServices",
);
const version = "2026-11-15-preview";

for (const apiVersion of [
  "2026-09-01",
  "2026-09-15-preview",
  "2026-11-01",
  version,
]) {
  test(`${apiVersion}: project PUT preserves its versioned responses and LRO contract`, () => {
    const status = apiVersion.endsWith("-preview") ? "preview" : "stable";
    const spec = JSON.parse(
      readFileSync(
        path.join(project, status, apiVersion, "cognitiveservices.json"),
        "utf8",
      ),
    );
    const operation = Object.values(spec.paths)
      .map((item) => item.put)
      .find((item) => item?.operationId === "Projects_Create");
    assert(operation, "Projects_Create must exist");
    assert(spec.definitions.Project, "Project must remain a resource model");
    assert.deepEqual(
      Object.keys(operation.responses),
      apiVersion === version
        ? ["200", "202", "default"]
        : ["200", "201", "202", "default"],
    );
    for (const [code, response] of Object.entries(operation.responses)) {
      if (code === "default") continue;
      assert.deepEqual(response.schema, { $ref: "#/definitions/Project" });
    }
    assert.equal(operation["x-ms-long-running-operation"], true);
    assert.deepEqual(operation["x-ms-long-running-operation-options"], {
      "final-state-via": "location",
      "final-state-schema": "#/definitions/Project",
    });
    assert.deepEqual(
      Object.keys(operation.responses["202"].headers)
        .map((header) => header.toLowerCase())
        .sort(),
      apiVersion === "2026-09-01"
        ? ["location", "retry-after"]
        : ["azure-asyncoperation", "location", "retry-after"],
    );
  });
}

for (const [file, provisioningState] of [
  ["CreateProject.json", "Creating"],
  ["CreateProjectMin.json", "Creating"],
  ["CreateProjectWithToolControls.json", "Accepted"],
]) {
  test(`${file}: November examples retain 200/202 and the async project body`, () => {
    const source = readFileSync(path.join(project, "examples", version, file));
    const generated = readFileSync(
      path.join(project, "preview", version, "examples", file),
    );
    assert.deepEqual(generated, source);
    const example = JSON.parse(source);
    assert.equal(example.operationId, "Projects_Create");
    assert.equal(example.parameters["api-version"], version);
    assert.deepEqual(Object.keys(example.responses), ["200", "202"]);
    assert.equal(
      example.responses["200"].body.properties.provisioningState,
      "Succeeded",
    );
    assert.equal(
      example.responses["202"].body.properties.provisioningState,
      provisioningState,
    );
    assert.deepEqual(Object.keys(example.responses["202"].headers).sort(), [
      "Azure-AsyncOperation",
      "Location",
      "Retry-After",
    ]);
  });
}
