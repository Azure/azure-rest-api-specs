import assert from "node:assert/strict";
import fs from "node:fs";
import path from "node:path";
import test from "node:test";
import { analyzeRestBreaking } from "./analyze-rest-breaking.mjs";

function writeJson(file, value) {
  fs.mkdirSync(path.dirname(file), { recursive: true });
  fs.writeFileSync(file, JSON.stringify(value));
}

test("emits explicit REST candidates for parameters, required properties, enums, statuses, paging, and LRO", (context) => {
  const work = fs.mkdtempSync(path.join(process.cwd(), ".rest-analyzer-test-"));
  context.after(() => fs.rmSync(work, { recursive: true, force: true }));
  const document = (current) => ({
    swagger: "2.0",
    info: { title: "Widgets", version: "v1" },
    paths: {
      "/widgets/{id}": {
        post: {
          operationId: "Widgets_Create",
          parameters: [
            { name: "id", in: "path", required: true, type: current ? "integer" : "string" },
            {
              name: "body",
              in: "body",
              required: current,
              schema: {
                type: "object",
                required: current ? ["mode"] : [],
                properties: {
                  mode: {
                    type: "string",
                    enum: current ? ["Fast"] : ["Fast", "Safe"],
                    "x-ms-enum": { name: "Mode", modelAsString: !current },
                  },
                },
              },
            },
          ],
          responses: current ? { 202: { description: "accepted" } } : {
            200: { description: "ok" },
            202: { description: "accepted" },
          },
          "x-ms-pageable": current ? { nextLinkName: "next" } : undefined,
          "x-ms-long-running-operation": current,
        },
      },
    },
  });
  writeJson(path.join(work, "base.json"), document(false));
  writeJson(path.join(work, "current.json"), document(true));
  const artifact = (file) => ({
    status: "succeeded",
    format: "swagger-2.0",
    files: [{ path: file, documentRole: "primary" }],
  });
  const result = analyzeRestBreaking({
    workRoot: work,
    manifest: {
      projects: [{
        id: "project-1",
        sourceChangeIds: ["source-authoritative"],
        artifacts: {
          base: { autorest: artifact("base.json") },
          current: { autorest: artifact("current.json") },
        },
      }],
    },
    sourceIndex: {
      sourceChanges: [{
        id: "source-authoritative",
        declarations: [{ id: "declaration-authoritative" }],
      }],
    },
  });
  const rules = new Set(result.candidates.map((item) => item.rule));
  for (const rule of [
    "parameter-wire-type-changed",
    "request-body-required",
    "property-required",
    "enum-values-removed",
    "enum-closed",
    "response-status-removed",
    "paging-behavior-changed",
    "lro-behavior-changed",
  ]) {
    assert.ok(rules.has(rule), `missing ${rule}`);
  }
  assert.ok(result.candidates.every((item) => item.sourceChangeIds[0] === "source-authoritative"));
  assert.ok(result.candidates.every((item) => item.contractChange?.rule === item.rule));
  assert.deepEqual(result.candidates.map((item) => item.id), result.candidates.map((item) => item.id).sort());
});

test("ignores PR 43308-style string format annotations across intersected response models", (context) => {
  const work = fs.mkdtempSync(path.join(process.cwd(), ".rest-format-test-"));
  context.after(() => fs.rmSync(work, { recursive: true, force: true }));
  const document = (revision) => ({
    swagger: "2.0",
    info: { title: "Chaos", version: "2026-05-01-preview" },
    definitions: {
      ScenarioRun: {
        allOf: [{
          $ref: `../../worktrees/${revision}/specification/common-types/resource-management/v5/types.json#/definitions/ProxyResource`,
        }],
        properties: {
          resourceId: {
            type: "string",
            ...(revision === "current" ? { format: "arm-id" } : {}),
          },
        },
      },
      ScenarioRunListResult: {
        type: "object",
        properties: {
          value: {
            type: "array",
            items: { $ref: "#/definitions/ScenarioRun" },
          },
        },
      },
    },
    paths: {
      "/runs": {
        get: {
          operationId: "ScenarioRuns_ListAll",
          responses: { 200: { schema: { $ref: "#/definitions/ScenarioRunListResult" } } },
        },
      },
      "/runs/{runId}": {
        get: {
          operationId: "ScenarioRuns_Get",
          responses: {
            200: { schema: { $ref: "#/definitions/ScenarioRun" } },
            202: {
              schema: { $ref: "#/definitions/ScenarioRun" },
              headers: {
                Location: {
                  type: "string",
                  ...(revision === "current" ? { format: "uri" } : {}),
                },
              },
            },
          },
        },
      },
    },
  });
  writeJson(path.join(work, "base", "autorest", "openapi.json"), document("base"));
  writeJson(path.join(work, "current", "autorest", "openapi.json"), document("current"));
  const artifact = (revision) => ({
    status: "succeeded",
    format: "swagger-2.0",
    files: [{ path: `${revision}/autorest/openapi.json`, documentRole: "primary" }],
  });
  const result = analyzeRestBreaking({
    workRoot: work,
    manifest: {
      projects: [{
        id: "project-1",
        sourceChangeIds: ["source-authoritative"],
        artifacts: {
          base: { autorest: artifact("base") },
          current: { autorest: artifact("current") },
        },
      }],
    },
    sourceIndex: {
      sourceChanges: [{
        id: "source-authoritative",
        declarations: [{ id: "declaration-authoritative" }],
      }],
    },
  });

  assert.deepEqual(result.candidates, []);
});
