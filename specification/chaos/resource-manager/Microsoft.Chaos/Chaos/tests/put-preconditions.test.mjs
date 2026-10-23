import assert from "node:assert/strict";
import { execFileSync } from "node:child_process";
import { readFileSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";
import test from "node:test";
import { LiveValidator } from "oav/dist/lib/liveValidation/liveValidator.js";

const root = fileURLToPath(new URL("../", import.meta.url));
const repo = execFileSync("git", ["rev-parse", "--show-toplevel"], {
  cwd: root,
  encoding: "utf8",
}).trim();
const readJson = (name) =>
  JSON.parse(readFileSync(path.join(root, name), "utf8"));
const spec = readJson("stable/2026-11-01/openapi.json");
const operationIds = [
  "Workspaces_CreateOrUpdate",
  "Scenarios_CreateOrUpdate",
  "ScenarioConfigurations_CreateOrUpdate",
];
const headerNames = ["If-None-Match", "If-Match"];
const parameters = (operation) =>
  operation.parameters.map((parameter) =>
    parameter.$ref?.startsWith("#/parameters/")
      ? spec.parameters[parameter.$ref.slice("#/parameters/".length)]
      : parameter,
  );
const operations = Object.values(spec.paths).flatMap((route) =>
  Object.entries(route).filter(([, operation]) => operation.operationId),
);
const scopedOperations = operations.filter(([, operation]) =>
  operationIds.includes(operation.operationId),
);

test("only the three selected PUT operations expose optional wildcard conditions with standard ARM errors", () => {
  assert.equal(scopedOperations.length, 3);
  for (const [method, operation] of operations) {
    const headers = parameters(operation).filter((parameter) =>
      headerNames.includes(parameter.name),
    );
    if (!operationIds.includes(operation.operationId)) {
      assert.deepEqual(headers, [], operation.operationId);
      assert.equal(
        operation.responses["412"],
        undefined,
        operation.operationId,
      );
      continue;
    }
    assert.equal(method, "put");
    assert.deepEqual(
      headers.map((header) => header.name),
      headerNames,
    );
    for (const header of headers) {
      assert.equal(header.in, "header");
      assert.equal(header.required, false);
      assert.equal(header.type, "string");
      assert.equal(header.default, undefined);
      assert.equal(header.enum, undefined);
      assert.match(header.description, /Use '\*'/);
      assert.match(header.description, /must not be silently ignored/);
      assert.match(
        header.description,
        /HTTP 412 and error code PreconditionFailed/,
      );
      assert.match(
        header.description,
        /A failed condition starts no resource change or asynchronous operation/,
      );
      assert.match(
        header.description,
        /does not introduce entity-tag matching/,
      );
    }
    assert.deepEqual(Object.keys(operation.responses), [
      "200",
      "201",
      "default",
    ]);
    const failure = operation.responses.default;
    assert.deepEqual(failure.schema, {
      $ref: "../../../../../../common-types/resource-management/v6/types.json#/definitions/ErrorResponse",
    });
    assert.equal(failure.headers, undefined);
    assert.equal(failure.description, "An unexpected error response.");
  }
});

test("create-only and update-only examples are wired, cover success and 412, and are emitted unchanged", () => {
  for (const [, operation] of scopedOperations) {
    for (const [suffix, header, status] of [
      ["CreateOnly", "If-None-Match", "201"],
      ["UpdateOnly", "If-Match", "200"],
    ]) {
      const name = `${operation.operationId}_${suffix}.json`;
      const source = readJson(`examples/2026-11-01/${name}`);
      assert.equal(source.operationId, operation.operationId);
      assert.equal(source.parameters["api-version"], "2026-11-01");
      assert.equal(source.parameters[header], "*");
      assert.equal(
        source.parameters[headerNames.find((name) => name !== header)],
        undefined,
      );
      assert.deepEqual(Object.keys(source.responses), [status, "default"]);
      assert.match(source.title, /return 412/);
      assert.equal(
        source.responses.default.body.error.code,
        "PreconditionFailed",
      );
      assert.equal(source.responses.default.body.error.target, header);
      assert.equal(source.responses.default.headers, undefined);
      assert.equal(operation.responses["412"], undefined);
      assert.ok(operation.responses.default.schema, "412 is modeled by default");
      assert.ok(
        Object.values(operation["x-ms-examples"]).some(
          (example) => example.$ref === `./examples/${name}`,
        ),
        name,
      );
      assert.deepEqual(
        readFileSync(path.join(root, `examples/2026-11-01/${name}`)),
        readFileSync(path.join(root, `stable/2026-11-01/examples/${name}`)),
      );
      if (
        status === "201" &&
        operation.operationId !== "Scenarios_CreateOrUpdate"
      ) {
        assert.ok(source.responses[status].headers["Azure-AsyncOperation"]);
      } else {
        assert.equal(source.responses[status].headers, undefined);
        assert.equal(
          source.responses[status].body.properties.provisioningState,
          "Succeeded",
        );
      }
    }
    const unconditional = readJson(
      `examples/2026-11-01/${operation.operationId}.json`,
    );
    for (const header of headerNames)
      assert.equal(unconditional.parameters[header], undefined);
  }
});

test("OAV validates actual HTTP 412 examples against the default error schema", async () => {
  const validator = new LiveValidator({
    swaggerPaths: [path.join(root, "stable/2026-11-01/openapi.json")],
    directory: repo,
    git: { shouldClone: false },
    loadValidatorInBackground: false,
    loadValidatorInInitialize: true,
    isArmCall: true,
  });
  await validator.initialize();
  let validated = 0;
  for (const [route, methods] of Object.entries(spec.paths)) {
    const operation = methods.put;
    if (!operationIds.includes(operation?.operationId)) continue;
    for (const suffix of ["CreateOnly", "UpdateOnly"]) {
      const example = readJson(
        `examples/2026-11-01/${operation.operationId}_${suffix}.json`,
      );
      const url =
        "https://management.azure.com" +
        route.replace(/\{([^}]+)\}/g, (_, name) =>
          encodeURIComponent(example.parameters[name]),
        ) +
        "?api-version=2026-11-01";
      const response = {
        statusCode: "412",
        headers: { "content-type": "application/json" },
        body: example.responses.default.body,
      };
      const result = await validator.validateLiveResponse(response, {
        url,
        method: "PUT",
      });
      assert.equal(result.runtimeException, undefined);
      assert.equal(result.operationInfo.operationId, operation.operationId);
      assert.equal(result.isSuccessful, true, JSON.stringify(result.errors));
      assert.deepEqual(result.errors, []);

      const invalid = structuredClone(response);
      invalid.body.error.code = 412;
      const rejected = await validator.validateLiveResponse(invalid, {
        url,
        method: "PUT",
      });
      assert.equal(rejected.runtimeException, undefined);
      assert.equal(rejected.isSuccessful, false);
      assert.ok(rejected.errors.length > 0, "invalid error body must be rejected");
      validated++;
    }
  }
  assert.equal(validated, 6);
});

test(
  "the GA contract differs from the baseline only by the authorized headers and example links",
  { skip: !process.env.CHAOS_PRECONDITION_BASE_REF },
  () => {
    const relative = path.relative(repo, root).split(path.sep).join("/");
    const baseline = JSON.parse(
      execFileSync(
        "git",
        [
          "show",
          `${process.env.CHAOS_PRECONDITION_BASE_REF}:${relative}/stable/2026-11-01/openapi.json`,
        ],
        { cwd: repo, maxBuffer: 20 * 1024 * 1024, encoding: "utf8" },
      ),
    );
    const actual = structuredClone(spec);
    for (const route of Object.values(actual.paths)) {
      for (const operation of Object.values(route)) {
        if (!operationIds.includes(operation.operationId)) continue;
        operation.parameters = operation.parameters.filter(
          (parameter) =>
            !parameter.$ref?.startsWith("#/parameters/PutPreconditionHeaders."),
        );
        for (const [title, example] of Object.entries(
          operation["x-ms-examples"],
        )) {
          if (/_(CreateOnly|UpdateOnly)\.json$/.test(example.$ref))
            delete operation["x-ms-examples"][title];
        }
      }
    }
    delete actual.parameters["PutPreconditionHeaders.ifNoneMatch"];
    delete actual.parameters["PutPreconditionHeaders.ifMatch"];
    assert.deepEqual(actual, baseline);
  },
);
