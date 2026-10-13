import assert from "node:assert/strict";
import { readFileSync } from "node:fs";
import { resolve } from "node:path";
import test from "node:test";
import {
  counters,
  loadVersion,
  project,
  summaryCollection,
  versions,
} from "./helpers.mjs";

const api = loadVersion(versions[0]);
const summary = api.swagger.definitions.NeuroShieldSummary;
const properties = api.swagger.definitions.NeuroShieldSummaryProperties;

test("summary has singleton point GET and pageable collection GET, without write operations", () => {
  const collection = api.swagger.paths[summaryCollection];
  const point = api.swagger.paths[summaryCollection + "/default"];
  assert.deepEqual(Object.keys(collection), ["get"]);
  assert.deepEqual(Object.keys(point), ["get"]);
  assert.equal(collection.get.operationId, "NeuroShieldSummaries_List");
  assert.equal(point.get.operationId, "NeuroShieldSummaries_Get");
  assert.deepEqual(collection.get["x-ms-pageable"], {
    nextLinkName: "nextLink",
  });
  assert.equal(
    point.get.responses["200"].schema.$ref,
    "#/definitions/NeuroShieldSummary",
  );
  const list = api.dereference(collection.get.responses["200"].schema).schema;
  assert.deepEqual(list.required, ["value"]);
  assert.equal(
    list.properties.value.items.$ref,
    point.get.responses["200"].schema.$ref,
  );
  assert.equal(list.properties.nextLink.type, "string");
  assert.equal(point.get["x-ms-long-running-operation"], undefined);
  assert.ok(
    api.operations.every((op) => op.operationId !== "NeuroShields_GetSummary"),
  );
  assert.equal(api.swagger.definitions.NeuroShieldFleetSummary, undefined);
});

test("singleton has standard read-only ARM envelope and all fourteen required nonnegative counters", () => {
  assert.deepEqual(summary.required, ["properties"]);
  for (const name of ["id", "name", "type", "systemData"]) {
    const field = api.property(summary, name);
    assert.ok(field, name);
    assert.equal(field.schema.readOnly, true, name);
  }
  assert.deepEqual(properties.required, counters);
  assert.deepEqual(Object.keys(properties.properties), counters);
  for (const name of counters) {
    const field = properties.properties[name];
    assert.equal(field.type, "integer");
    assert.equal(field.format, "int32");
    assert.equal(field.minimum, 0);
    assert.equal(field.default, undefined);
  }
  assert.equal(properties.properties.resourceId, undefined);
  assert.equal(properties.properties.provisioningState, undefined);
  assert.match(
    readFileSync(resolve(project, "models.tsp"), "utf8"),
    /@singleton\("default"\)\s+@parentResource\(NeuroShieldResource\)\s+model NeuroShieldSummary/,
  );
});

test("summary list accepts only optional top 1-50 and API version, with no skipToken/default", () => {
  const parameters = api.swagger.paths[summaryCollection].get.parameters.map(
    (p) => api.dereference(p).schema,
  );
  const query = parameters.filter((p) => p.in === "query");
  assert.deepEqual(query.map((p) => p.name).sort(), ["api-version", "top"]);
  const top = query.find((p) => p.name === "top");
  assert.equal(top.required, false);
  assert.equal(top.type, "integer");
  assert.equal(top.format, "int32");
  assert.equal(top.minimum, 1);
  assert.equal(top.maximum, 50);
  assert.equal(top.default, undefined);
});

test("summary examples use the same singleton envelope and projection", () => {
  const point = api.example("NeuroShieldSummaries_Get").responses["200"].body;
  const list = api.example("NeuroShieldSummaries_List").responses["200"].body;
  assert.equal(list.value.length, 1);
  for (const value of [point, ...list.value]) {
    assert.equal(value.name, "default");
    assert.ok(value.id.endsWith("/summary/default"));
    assert.equal(value.type, "Microsoft.NetworkSecurity/neuroShields/summary");
    assert.deepEqual(Object.keys(value.properties), counters);
    assert.equal(value.properties.resourceId, undefined);
    assert.equal(value.properties.provisioningState, undefined);
  }
});
