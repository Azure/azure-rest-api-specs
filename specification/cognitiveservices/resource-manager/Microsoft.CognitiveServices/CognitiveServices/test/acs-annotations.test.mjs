import assert from "node:assert/strict";
import { execFileSync } from "node:child_process";
import { readFileSync, readdirSync } from "node:fs";
import path from "node:path";
import { test } from "node:test";
import { fileURLToPath } from "node:url";

const project = fileURLToPath(new URL("../", import.meta.url));
const root = path.resolve(project, "../../../../..");
const relativeProject = path.relative(root, project).replaceAll("\\", "/");
const version = "2026-11-15-preview";
const baseline = process.env.ACS_ANNOTATIONS_BASE_REF;
const load = (relative) =>
  JSON.parse(readFileSync(path.join(project, relative), "utf8"));
const spec = load(`preview/${version}/cognitiveservices.json`);
const names = [
  "PutRaiPolicyAcsWithAnnotationsAndEgress.json",
  "GetRaiPolicyAcsWithAnnotationsAndEgress.json",
  "ListRaiPoliciesAcsWithAnnotationsAndEgress.json",
];
const [put, get, list] = names.map((name) =>
  load(`examples/${version}/${name}`),
);
const request = put.parameters.raiPolicy.properties;
const pointModels = [
  "RaiAcsInterventionPoint",
  "RaiAcsToolInterventionPoint",
  "RaiAcsAgentStartupInterventionPoint",
  "RaiAcsPreModelCallInterventionPoint",
  "RaiAcsPostModelCallInterventionPoint",
  "RaiAcsAgentShutdownInterventionPoint",
];
const points = [
  "agent_startup",
  "input",
  "pre_model_call",
  "post_model_call",
  "pre_tool_call",
  "post_tool_call",
  "output",
  "agent_shutdown",
];
const git = (...args) =>
  execFileSync("git", ["-C", root, ...args], {
    encoding: "utf8",
    maxBuffer: 32 * 1024 * 1024,
  });

test("November annotators and bindings remain optional typed open maps", () => {
  const manifest = spec.definitions.RaiAcsManifest;
  assert(!manifest.required.includes("annotators"));
  assert(!Object.hasOwn(manifest.properties, "legacyAnnotators"));
  assert.deepEqual(manifest.properties.annotators.additionalProperties, {
    $ref: "#/definitions/RaiAcsAnnotatorDefinition",
  });
  assert.deepEqual(spec.definitions.RaiAcsAnnotatorDefinition.required, [
    "type",
  ]);
  assert.deepEqual(spec.definitions.RaiAcsAnnotationBinding.required, ["from"]);
  assert.deepEqual(
    spec.definitions.RaiAcsAnnotatorDefinition.additionalProperties,
    {},
  );
  assert.deepEqual(
    spec.definitions.RaiAcsAnnotationBinding.additionalProperties,
    {},
  );
  assert.equal(
    spec.definitions.RaiAcsAnnotatorType["x-ms-enum"].modelAsString,
    true,
  );
  assert.deepEqual(spec.definitions.RaiAcsAnnotatorType.enum, [
    "classifier",
    "llm",
    "endpoint",
  ]);
  for (const name of pointModels) {
    const model = spec.definitions[name];
    assert(!model.required.includes("annotations"), name);
    assert(!Object.hasOwn(model.properties, "legacyAnnotations"), name);
    assert.deepEqual(
      model.properties.annotations.additionalProperties,
      {
        $ref: "#/definitions/RaiAcsAnnotationBinding",
      },
      name,
    );
  }
});

test("the eight inherited points keep their optional properties and point-specific models", () => {
  const model = spec.definitions.RaiAcsInterventionPoints;
  assert.deepEqual(Object.keys(model.properties), points);
  assert.deepEqual(model.required ?? [], []);
  assert.equal(
    model.properties.pre_model_call.$ref,
    "#/definitions/RaiAcsPreModelCallInterventionPoint",
  );
  assert.equal(
    model.properties.post_model_call.$ref,
    "#/definitions/RaiAcsPostModelCallInterventionPoint",
  );
  assert.deepEqual(Object.keys(request.acs.intervention_points), points);
  assert(
    !Object.hasOwn(
      spec.definitions.RaiAcsInterventionPoint.properties,
      "tool_name_from",
    ),
  );
  assert(
    Object.hasOwn(
      spec.definitions.RaiAcsToolInterventionPoint.properties,
      "tool_name_from",
    ),
  );
});

test("the combined example uses the existing optional egress sibling without changing ACS", () => {
  assert.equal(request.format, "ACS");
  assert.equal(request.acs.annotators.risk.type, "llm");
  assert.equal(request.acs.annotators.risk.provider, "azure_openai");
  assert.equal(
    request.acs.intervention_points.input.annotations.risk.from,
    "$target.content",
  );
  assert.equal(request.egressPolicy.mode, "Audit");
  assert.equal(request.egressPolicy.defaultAction, "Deny");
  assert.equal(
    request.egressPolicy.rules[1].action.headers[0].value,
    "public-demo",
  );
  assert(
    !spec.definitions.RaiPolicyProperties.required?.includes("egressPolicy"),
  );
  assert(
    !Object.hasOwn(spec.definitions.RaiAcsManifest.properties, "egressPolicy"),
  );
});

test("PUT GET and LIST preserve the authored manifest and redact write-only egress literals", () => {
  const expected = structuredClone(request);
  expected.type = "UserManaged";
  delete expected.egressPolicy.rules[1].action.headers[0].value;
  const responses = [
    put.responses[200].body,
    put.responses[201].body,
    get.responses[200].body,
    list.responses[200].body.value[0],
  ];
  for (const resource of responses) {
    assert.deepEqual(resource.properties, expected);
    assert.equal(resource.name, put.parameters.raiPolicyName);
    assert.equal(resource.id, responses[0].id);
    assert(
      !JSON.stringify(resource.properties.egressPolicy).includes("public-demo"),
    );
  }
  for (const response of Object.values(put.responses))
    assert.equal(response.headers.ETag, response.body.etag);
  const literal = spec.definitions.RaiEgressHeaderTransform.properties.value;
  assert.equal(literal["x-ms-secret"], true);
  assert.deepEqual([...literal["x-ms-mutability"]].sort(), [
    "create",
    "update",
  ]);
});

test("an unannotated policy without egress remains in the LIST example", () => {
  const minimal = list.responses[200].body.value[1].properties;
  assert.equal(minimal.format, "ACS");
  assert(!Object.hasOwn(minimal, "egressPolicy"));
  assert(!Object.hasOwn(minimal.acs, "annotators"));
  assert(!Object.hasOwn(minimal.acs.intervention_points.input, "annotations"));
});

test("all three combined examples are registered and generated copies match", () => {
  for (const name of names) {
    const fixture = load(`examples/${version}/${name}`);
    assert.equal(fixture.parameters["api-version"], version);
    const operation = Object.values(spec.paths)
      .flatMap((route) => Object.values(route))
      .find((candidate) => candidate.operationId === fixture.operationId);
    assert(operation, fixture.operationId);
    assert.deepEqual(operation["x-ms-examples"][fixture.title], {
      $ref: `./examples/${name}`,
    });
    assert.deepEqual(
      readFileSync(path.join(project, `examples/${version}/${name}`)),
      readFileSync(path.join(project, `preview/${version}/examples/${name}`)),
    );
  }
});

test(
  "all twelve earlier API versions retain their exact schemas",
  { skip: !baseline },
  () => {
    let count = 0;
    for (const state of ["preview", "stable"]) {
      for (const entry of readdirSync(path.join(project, state), {
        withFileTypes: true,
      })) {
        if (
          !entry.isDirectory() ||
          entry.name >= version ||
          entry.name < "2025-10-01-preview"
        )
          continue;
        const relative = `${state}/${entry.name}/cognitiveservices.json`;
        const prior = JSON.parse(
          git("show", `${baseline}:${relativeProject}/${relative}`),
        );
        assert.deepEqual(load(relative), prior, entry.name);
        count += 1;
      }
    }
    assert.equal(count, 12);
  },
);

test(
  "all existing operations and non-annotation schemas are unchanged",
  { skip: !baseline },
  () => {
    const previous = JSON.parse(
      git(
        "show",
        `${baseline}:${relativeProject}/preview/${version}/cognitiveservices.json`,
      ),
    );
    const permitted = new Set([
      "RaiAcsEmptyObject",
      "RaiAcsManifest",
      ...pointModels,
      "RaiAcsAnnotatorType",
      "RaiAcsAnnotatorDefinition",
      "RaiAcsAnnotationBinding",
    ]);
    for (const name of new Set([
      ...Object.keys(previous.definitions),
      ...Object.keys(spec.definitions),
    ])) {
      if (!permitted.has(name))
        assert.deepEqual(
          spec.definitions[name],
          previous.definitions[name],
          name,
        );
    }
    const removeExamples = (paths) => {
      const result = structuredClone(paths);
      for (const route of Object.values(result))
        for (const operation of Object.values(route)) {
          if (operation && typeof operation === "object")
            delete operation["x-ms-examples"];
        }
      return result;
    };
    assert.deepEqual(
      removeExamples(spec.paths),
      removeExamples(previous.paths),
    );
    for (const name of Object.keys(previous).filter(
      (name) => !["paths", "definitions"].includes(name),
    )) {
      assert.deepEqual(spec[name], previous[name], name);
    }
  },
);

test(
  "the contribution changes only ten intended files",
  { skip: !baseline },
  () => {
    const expected = [
      "models.tsp",
      "readme.md",
      "test/acs-annotations.test.mjs",
      `preview/${version}/cognitiveservices.json`,
      ...names.map((name) => `examples/${version}/${name}`),
      ...names.map((name) => `preview/${version}/examples/${name}`),
    ]
      .map((name) => `${relativeProject}/${name}`)
      .sort();
    const changed = git("diff", "--name-only", baseline)
      .trim()
      .split("\n")
      .filter(Boolean);
    const untracked = git("ls-files", "--others", "--exclude-standard")
      .trim()
      .split("\n")
      .filter(Boolean);
    assert.deepEqual([...new Set([...changed, ...untracked])].sort(), expected);
  },
);
