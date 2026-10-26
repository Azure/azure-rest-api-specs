import assert from "node:assert/strict";
import { execFileSync } from "node:child_process";
import { readFileSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import { test } from "node:test";

const project = fileURLToPath(new URL("../", import.meta.url));
const root = path.resolve(project, "../../../../..");
const version = "2026-09-15-preview";
const load = (relative) =>
  JSON.parse(readFileSync(path.join(project, relative), "utf8"));
const filenames = [
  "PutRaiPolicyAcsWithEgress.json",
  "GetRaiPolicyAcsWithEgress.json",
  "ListRaiPoliciesAcsWithEgress.json",
];
const [put, get, list] = filenames.map((name) =>
  load(`examples/${version}/${name}`),
);
const spec = load(`preview/${version}/cognitiveservices.json`);
const request = put.parameters.raiPolicy.properties;
const responses = [
  put.responses[200].body,
  put.responses[201].body,
  get.responses[200].body,
  list.responses[200].body.value[0],
];

test("source fixture has a minimal pure-Rego ACS input policy and independent egress", () => {
  assert.deepEqual(Object.keys(request).sort(), [
    "acs",
    "acsRegos",
    "egressPolicy",
    "format",
  ]);
  assert.equal(request.format, "ACS");
  assert.equal(
    request.acs.agent_control_specification_version,
    "0.4.0-alpha.1",
  );
  assert.deepEqual(request.acs.policies, {
    "input-guard": { type: "rego", query: "data.input_guard.verdict" },
  });
  assert.deepEqual(request.acs.intervention_points, {
    input: {
      policy_target: "$snap.input",
      policy_target_kind: "user_input",
      policy: { id: "input-guard" },
    },
  });
  assert.deepEqual(request.acsRegos, [{ regoName: "input-guard" }]);
  assert.equal(request.egressPolicy.mode, "Audit");
  assert.equal(request.egressPolicy.defaultAction, "Deny");
  const [allow, transform] = request.egressPolicy.rules;
  assert.equal(allow.action.actionType, "Allow");
  assert.deepEqual(allow.match, {
    host: "learn.microsoft.com",
    path: "/azure/*",
  });
  assert.equal(transform.action.actionType, "Transform");
  assert.deepEqual(transform.match, {
    host: "api.contoso.com",
    path: "/v1/*",
  });
  assert.deepEqual(transform.action.headers, [
    { operation: "Set", name: "X-Workload-Class", value: "public-demo" },
  ]);
});

test("response fixtures preserve resource and destination identity without write-only literals", () => {
  const expected = structuredClone(request);
  delete expected.egressPolicy.rules[1].action.headers[0].value;
  expected.type = "UserManaged";
  for (const resource of responses) {
    assert.deepEqual(resource.properties, expected);
    assert.equal(resource.name, put.parameters.raiPolicyName);
    assert.equal(resource.id, responses[0].id);
    assert.equal(
      resource.type,
      "Microsoft.CognitiveServices/accounts/raiPolicies",
    );
    assert.equal(resource.etag, responses[0].etag);
    assert.doesNotMatch(JSON.stringify(resource), /public-demo|@secret/);
  }
  for (const response of Object.values(put.responses)) {
    assert.equal(response.headers.ETag, response.body.etag);
  }
  assert.equal(get.responses[200].headers.ETag, responses[0].etag);
});

test("generated Swagger registers all three examples on the correct operations", () => {
  for (const filename of filenames) {
    const source = load(`examples/${version}/${filename}`);
    const operation = Object.values(spec.paths)
      .flatMap((route) => Object.values(route))
      .find((value) => value.operationId === source.operationId);
    assert(operation, source.operationId);
    assert.deepEqual(operation["x-ms-examples"][source.title], {
      $ref: `./examples/${filename}`,
    });
    assert.deepEqual(load(`preview/${version}/examples/${filename}`), source);
    assert.equal(source.parameters["api-version"], version);
  }
});

test("generated contract keeps egress optional and literals write-only", () => {
  const properties = spec.definitions.RaiPolicyProperties;
  assert.deepEqual(
    properties.properties.egressPolicy.$ref,
    "#/definitions/RaiEgressPolicyConfig",
  );
  assert(!properties.required?.includes("egressPolicy"));
  for (const name of ["format", "acs", "acsRegos", "contentFilters"]) {
    assert(properties.properties[name], name);
  }
  assert.match(
    properties.properties.egressPolicy.description,
    /independent of the\s+ContentFilters or ACS representation/,
  );
  const literal = spec.definitions.RaiEgressHeaderTransform.properties.value;
  assert.equal(literal["x-ms-secret"], true);
  assert.deepEqual([...literal["x-ms-mutability"]].sort(), [
    "create",
    "update",
  ]);
});

test("existing minimal ACS and ContentFilters fixtures remain valid sibling shapes", () => {
  const minimal = load(`examples/${version}/PutRaiPolicyAcsWithoutTools.json`);
  assert.deepEqual(request.acs, minimal.parameters.raiPolicy.properties.acs);
  assert.deepEqual(
    request.acsRegos,
    minimal.parameters.raiPolicy.properties.acsRegos,
  );
  const filters = load(`examples/${version}/PutRaiPolicyWithEgress.json`);
  assert(Array.isArray(filters.parameters.raiPolicy.properties.contentFilters));
  assert(filters.parameters.raiPolicy.properties.egressPolicy);
});

test(
  "baseline differs only in the egress description and three example references",
  {
    skip: !process.env.ACS_EGRESS_BASE_REF,
  },
  () => {
    const relative = path
      .relative(
        root,
        path.join(project, `preview/${version}/cognitiveservices.json`),
      )
      .replaceAll("\\", "/");
    const baseline = JSON.parse(
      execFileSync(
        "git",
        ["show", `${process.env.ACS_EGRESS_BASE_REF}:${relative}`],
        { cwd: root, encoding: "utf8", maxBuffer: 32 * 1024 * 1024 },
      ),
    );
    const normalized = structuredClone(spec);
    normalized.definitions.RaiPolicyProperties.properties.egressPolicy.description =
      baseline.definitions.RaiPolicyProperties.properties.egressPolicy.description;
    for (const filename of filenames) {
      const source = load(`examples/${version}/${filename}`);
      const operation = Object.values(normalized.paths)
        .flatMap((route) => Object.values(route))
        .find((value) => value.operationId === source.operationId);
      delete operation["x-ms-examples"][source.title];
    }
    assert.deepEqual(normalized, baseline);
  },
);
