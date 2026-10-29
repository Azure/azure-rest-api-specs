// Run after tsp compile: node --test test/cost-control-contract.test.mjs
// Set COST_CONTROL_BASE_REF to verify that earlier generated API versions are unchanged.
import assert from "node:assert/strict";
import { execFileSync } from "node:child_process";
import { readFileSync, readdirSync } from "node:fs";
import path from "node:path";
import { test } from "node:test";
import { fileURLToPath } from "node:url";

const project = fileURLToPath(new URL("../", import.meta.url));
const root = path.resolve(project, "../../../../..");
const version = "2026-11-15-preview";
const specFile = path.join(
  project,
  "preview",
  version,
  "cognitiveservices.json",
);
const spec = readJson(specFile);
const definitions = spec.definitions;
const baseline = process.env.COST_CONTROL_BASE_REF;
const groupingNames = ["project", "agent", "identityObjectId", "sessionId"];
const filterNames = [...groupingNames, "deployment", "tokenType"];
const resourceNames = new Set(["project", "agent", "deployment"]);
const operations = Object.values(spec.paths).flatMap((route) =>
  Object.values(route).filter((operation) =>
    /^(Project)?CostControls_/.test(operation.operationId),
  ),
);

function readJson(file) {
  return JSON.parse(readFileSync(file, "utf8"));
}

function resolve(value) {
  if (!value.$ref) return value;
  const [file, fragment] = value.$ref.split("#");
  const document = file
    ? readJson(path.resolve(path.dirname(specFile), file))
    : spec;
  return fragment
    .slice(1)
    .split("/")
    .reduce(
      (current, key) =>
        current[key.replaceAll("~1", "/").replaceAll("~0", "~")],
      document,
    );
}

function tags(filter) {
  if (!filter) return [];
  assert.equal(Boolean(filter.tags), !filter.and);
  if (filter.tags) return [filter.tags];
  assert(filter.and.length >= 2);
  return filter.and.flatMap(tags);
}

function inspectExample(value, projectName) {
  if (!value || typeof value !== "object") return;
  if (value.costControlConnections) {
    assert.deepEqual(Object.keys(value.costControlConnections), [
      "appInsightsConnectionId",
    ]);
  }
  if (value.grouping) {
    for (const grouping of value.grouping) {
      assert(groupingNames.includes(grouping.name));
      assert.equal(grouping.type, "TagKey");
      if (projectName) assert.notEqual(grouping.name, "project");
    }
  }
  if (Object.hasOwn(value, "filter") && value.filter) {
    const conditions = tags(value.filter);
    assert.equal(
      new Set(conditions.map((tag) => tag.name)).size,
      conditions.length,
    );
    for (const tag of conditions) {
      assert(filterNames.includes(tag.name), `Unsupported filter: ${tag.name}`);
      assert.equal(tag.operator, "In");
      assert(tag.values.length > 0);
      for (const item of tag.values) {
        assert.equal(typeof item, "string");
        assert(item.trim().length > 0);
        if (resourceNames.has(tag.name)) {
          assert(item.length <= 64);
          assert.equal(item, item.trim());
          assert(!/[/\\?#%\p{Cc}]/u.test(item));
          assert(![".", ".."].includes(item));
        }
      }
    }
    const selectedProject = conditions.find((tag) => tag.name === "project");
    if (conditions.some((tag) => tag.name === "agent")) {
      assert(
        selectedProject,
        "Agent filters require an explicit project filter",
      );
      assert.equal(selectedProject.values.length, 1);
    }
    if (projectName && selectedProject) {
      assert.deepEqual(selectedProject.values, [projectName]);
    }
  }
  for (const action of Object.values(value.providerProperties?.actions ?? {})) {
    if (action?.type) assert.equal(action.type, "Block");
  }
  for (const notification of Object.values(value.notifications ?? {})) {
    if (notification?.eventGridConnectionId) {
      assert.match(
        notification.eventGridConnectionId,
        /^\/subscriptions\/.+\/connections\/.+/,
      );
    }
  }
  for (const child of Object.values(value)) inspectExample(child, projectName);
}

test("grouping and filtering expose canonical name selectors, not resource-ID selectors", () => {
  assert.deepEqual(definitions.CostControlGroupingName.enum, groupingNames);
  assert.deepEqual(
    [...definitions.CostControlFilterName.enum].sort(),
    [...filterNames].sort(),
  );
  assert.match(
    definitions.CostControlFilter.description,
    /explicit project filter selecting exactly one project/,
  );
  const agent = definitions.CostControlGroupingName["x-ms-enum"].values.find(
    (value) => value.value === "agent",
  );
  assert.match(agent.description, /qualified by its Foundry project/);
});

test("filter values remain nonempty but allow more than twenty values", () => {
  const values = definitions.CostControlTagFilter.properties.values;
  assert.equal(values.minItems, 1);
  assert.equal(values.maxItems, undefined);
  assert.equal(resolve(values.items).type, "string");
  assert.equal(resolve(values.items).minLength, 1);
  assert.match(values.description, /32 KiB/);
  assert.equal(definitions.CostControlFilter.properties.and.minItems, 2);
});

test("full and partial action models emit the canonical Block spelling", () => {
  for (const name of ["CostControlAction", "CostControlActionPatch"]) {
    assert.deepEqual(definitions[name].properties.type.enum, ["Block"]);
  }
  assert.deepEqual(definitions.CostControlAction.required, [
    "type",
    "thresholdType",
    "threshold",
    "operator",
  ]);
  assert.equal(definitions.CostControlActionPatch.required, undefined);
});

test("account telemetry exposes only Application Insights while notifications retain Event Grid", () => {
  assert.deepEqual(Object.keys(definitions.CostControlConnections.properties), [
    "appInsightsConnectionId",
  ]);
  assert.equal(
    definitions.CostControlConnections.properties.appInsightsConnectionId[
      "x-nullable"
    ],
    true,
  );
  assert(
    definitions.CostControlNotification.required.includes(
      "eventGridConnectionId",
    ),
  );
  assert(definitions.CostControlNotification.properties.eventGridConnectionId);
  assert(
    definitions.CostControlNotificationPatch.properties.eventGridConnectionId,
  );
});

test("both resource scopes retain CRUD, conditional requests and grandfathered names", () => {
  assert.equal(operations.length, 12);
  for (const prefix of ["CostControls", "ProjectCostControls"]) {
    const scoped = operations.filter((operation) =>
      operation.operationId.startsWith(`${prefix}_`),
    );
    assert.deepEqual(
      scoped
        .map((operation) => operation.operationId.slice(prefix.length + 1))
        .sort(),
      ["CheckExistence", "CreateOrUpdate", "Delete", "Get", "List", "Update"],
    );
    for (const operation of scoped) {
      const name = operation.parameters
        .map(resolve)
        .find((parameter) => parameter.name === "costControlName");
      if (!name) {
        assert.equal(operation.operationId, `${prefix}_List`);
        continue;
      }
      assert.equal(name.minLength, 1);
      assert.equal(name.maxLength, 64);
      const pattern = new RegExp(name.pattern);
      for (const valid of [
        "_budget",
        "-budget",
        "budget",
        "legacy.budget",
        "a".repeat(64),
      ]) {
        assert(pattern.test(valid), `Expected addressable name: ${valid}`);
      }
      for (const invalid of [
        "",
        ".budget",
        "a/b",
        "a b",
        "a".repeat(65),
        "_".repeat(64),
      ]) {
        assert(
          !pattern.test(invalid),
          `Unexpected addressable name: ${invalid}`,
        );
      }
      assert.match(name.description, /New names contain 1-63/);
      assert.match(name.description, /cannot be recreated/);
    }
    const get = scoped.find(
      (operation) => operation.operationId === `${prefix}_Get`,
    );
    assert(
      get.parameters
        .map(resolve)
        .some((parameter) => parameter.name === "If-None-Match"),
    );
    assert(get.responses["304"]);
    assert(get.responses["200"].headers.ETag);
    const create = scoped.find(
      (operation) => operation.operationId === `${prefix}_CreateOrUpdate`,
    );
    assert.match(create.description, /New names must contain 1-63/);
  }
});

test("source examples follow the November contract and match generated copies", () => {
  const source = path.join(project, "examples", version);
  const files = ["GetAccount.json", "UpdateAccount.json"];
  for (const folder of ["CostControl", "ProjectCostControl"]) {
    files.push(
      ...readdirSync(path.join(source, folder)).map((file) =>
        path.join(folder, file),
      ),
    );
  }
  assert.equal(files.length, 16);
  for (const file of files) {
    const example = readJson(path.join(source, file));
    assert.equal(example.parameters["api-version"], version);
    inspectExample(example, example.parameters.projectName);
    assert.deepEqual(
      readJson(path.join(project, "preview", version, "examples", file)),
      example,
      `Generated example is stale: ${file}`,
    );
  }
});

test(
  "earlier generated API versions are unchanged",
  { skip: !baseline },
  () => {
    const prefix = path.relative(root, project).split(path.sep).join("/");
    const git = (...args) =>
      execFileSync("git", args, { cwd: root, maxBuffer: 32 * 1024 * 1024 });
    const changed = git(
      "diff",
      "--name-only",
      baseline,
      "--",
      `${prefix}/preview`,
      `${prefix}/stable`,
    )
      .toString()
      .trim()
      .split("\n")
      .filter(
        (file) => file.endsWith(".json") && !file.includes(`/${version}/`),
      );
    assert.deepEqual(changed, [], "Earlier API output must remain unchanged");
  },
);
