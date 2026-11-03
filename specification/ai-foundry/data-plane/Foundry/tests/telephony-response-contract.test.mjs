import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { test } from "node:test";

const project = resolve(dirname(fileURLToPath(import.meta.url)), "..");
const prefix = "/agents/{agent_name}/telephony_campaigns";
const item = `${prefix}/{campaign_name}`;

test("CallJob responses document their existing entity, location and retry headers", async () => {
  for (const version of ["v1", "virtual-public-preview"]) {
    const document = JSON.parse(
      await readFile(
        resolve(project, `openapi3/${version}/microsoft-foundry-openapi3.json`),
        "utf8",
      ),
    );
    const job = "/agents/{agent_name}/telephony_call_jobs";
    for (const [path, verb, status, headers] of [
      [job, "post", "202", ["ETag", "Location", "Retry-After"]],
      [`${job}/{call_job_id}`, "get", "200", ["ETag"]],
      [`${job}/{call_job_id}:cancel`, "post", "200", ["ETag"]],
      [
        `${job}/{call_job_id}:cancel`,
        "post",
        "202",
        ["ETag", "Location", "Retry-After"],
      ],
    ]) {
      for (const name of headers)
        assert(
          document.paths[path][verb].responses[status].headers[
            name
          ].description?.trim(),
          `${version}: ${verb} ${path} ${status} ${name}`,
        );
    }
  }
});

function schema(document, value) {
  if (!value.$ref) return value;
  const resolved = value.$ref
    .slice(2)
    .split("/")
    .reduce((object, key) => object[key], document);
  return { ...schema(document, resolved), ...value };
}

for (const version of ["v1", "virtual-public-preview"]) {
  test(`${version}: Campaign name comes from the route and deletion has no tombstone body`, async () => {
    const document = JSON.parse(
      await readFile(
        resolve(project, `openapi3/${version}/microsoft-foundry-openapi3.json`),
        "utf8",
      ),
    );
    const operations = document.paths[item];
    const name = operations.put.parameters.find(
      (parameter) => parameter.name === "campaign_name",
    );
    assert.equal(name.in, "path");
    assert.equal(name.required, true);
    const input = schema(
      document,
      operations.put.requestBody.content["application/json"].schema,
    );
    assert.equal(input.properties.name, undefined);
    assert.equal(input.properties.status, undefined);
    assert.equal(input.properties.progress, undefined);
    const output = schema(
      document,
      operations.get.responses["200"].content["application/json"].schema,
    );
    assert(output.required.includes("name"));
    assert.equal(output.properties.name.readOnly, true);
    assert.equal(operations.patch, undefined);
    for (const status of ["202", "204"])
      assert.equal(operations.delete.responses[status].content, undefined);
  });

  test(`${version}: every CallJob response requires its normalized retry policy`, async () => {
    const document = JSON.parse(
      await readFile(
        resolve(project, `openapi3/${version}/microsoft-foundry-openapi3.json`),
        "utf8",
      ),
    );
    const jobs = "/agents/{agent_name}/telephony_call_jobs";
    for (const [path, verb, status] of [
      [jobs, "post", "202"],
      [`${jobs}/{call_job_id}`, "get", "200"],
      [`${jobs}/{call_job_id}:cancel`, "post", "200"],
      [`${jobs}/{call_job_id}:cancel`, "post", "202"],
      [jobs, "get", "200"],
    ]) {
      let body = schema(
        document,
        document.paths[path][verb].responses[status].content["application/json"]
          .schema,
      );
      if (path === jobs && verb === "get")
        body = schema(document, body.properties.data.items);
      assert(
        body.required.includes("retry_policy"),
        `${verb} ${path} ${status}`,
      );
      assert.equal(
        body.properties.retry_policy.$ref,
        "#/components/schemas/TelephonyOutboundRetryPolicy",
      );
    }
  });

  test(`${version}: creation accepts an omitted or explicit retry policy without requiring response fields`, async () => {
    const document = JSON.parse(
      await readFile(
        resolve(project, `openapi3/${version}/microsoft-foundry-openapi3.json`),
        "utf8",
      ),
    );
    const jobs = "/agents/{agent_name}/telephony_call_jobs";
    for (const [path, verb] of [
      [jobs, "post"],
      [item, "put"],
    ]) {
      const body = schema(
        document,
        document.paths[path][verb].requestBody.content["application/json"]
          .schema,
      );
      assert.equal(body.required.includes("retry_policy"), false);
      assert.equal(
        body.properties.retry_policy.$ref,
        "#/components/schemas/TelephonyOutboundRetryPolicy",
      );
      assert.notEqual(body.properties.retry_policy.readOnly, true);
      if (path !== jobs) continue;
      assert.deepEqual(body.required, [
        "destination",
        "connection_name",
        "source",
      ]);
      for (const field of [
        "id",
        "agent_name",
        "status",
        "attempt_count",
        "revision",
        "created_at",
        "updated_at",
        "campaign_name",
      ])
        assert.equal(body.properties[field], undefined, field);
    }
    assert.equal(
      document.components.schemas.TelephonyOutboundRetryPolicy.properties
        .max_attempts.default,
      1,
    );
    assert.deepEqual(
      document.components.schemas.FixedIntervalRetryPolicy.properties.type.enum,
      ["fixed_interval"],
    );
    assert.match(
      document.components.schemas.FixedIntervalRetryPolicy.description,
      /max_attempts=1 and interval=0 seconds/,
    );
  });

  test(`${version}: Campaign LRO and diagnostic responses retain actual cache and polling headers`, async () => {
    const document = JSON.parse(
      await readFile(
        resolve(project, `openapi3/${version}/microsoft-foundry-openapi3.json`),
        "utf8",
      ),
    );
    for (const [path, verb, status] of [
      [item, "put", "200"],
      [item, "put", "201"],
      [`${item}:cancel`, "post", "202"],
      [item, "delete", "202"],
      [item, "get", "200"],
      [prefix, "get", "200"],
      [`${item}/operations/{operation_id}`, "get", "200"],
      [`${item}/validation_errors`, "get", "200"],
    ]) {
      const response = document.paths[path][verb].responses[status];
      assert.deepEqual(
        schema(document, response.headers["Cache-Control"].schema).enum,
        ["no-store"],
        `${verb} ${path} ${status}`,
      );
    }
    for (const status of ["200", "201"]) {
      const retryAfter =
        document.paths[item].put.responses[status].headers["Retry-After"];
      assert.equal(schema(document, retryAfter.schema).type, "integer");
    }
    assert.equal(
      document.paths[item].delete.responses["204"].headers?.["Cache-Control"],
      undefined,
    );
  });

  test(`${version}: Campaign operation identities retain source limits without imposing UUIDs`, async () => {
    const document = JSON.parse(
      await readFile(
        resolve(project, `openapi3/${version}/microsoft-foundry-openapi3.json`),
        "utf8",
      ),
    );
    for (const [path, verb, parameterName] of [
      [item, "put", "Operation-Id"],
      [`${item}:cancel`, "post", "Operation-Id"],
      [item, "delete", "Operation-Id"],
      [item, "get", "operation_id"],
      [`${item}/operations/{operation_id}`, "get", "operation_id"],
    ]) {
      const parameter = document.paths[path][verb].parameters.find(
        (parameter) => parameter.name === parameterName,
      );
      assert(parameter, `${verb} ${path} ${parameterName}`);
      const value = schema(document, parameter.schema);
      assert.equal(value.type, "string");
      assert.equal(value.minLength, 1);
      assert.equal(value.maxLength, 256);
      assert.equal(value.format, undefined);
    }
  });
}

test("acceptance examples do not claim a resolved Agent version and include polling guidance", async () => {
  for (const name of [
    "CreateImmediate",
    "CreateScheduled",
    "CreateRecipientScheduled",
    "ReplaceFailedCampaign",
  ]) {
    const example = JSON.parse(
      await readFile(
        resolve(project, `examples/campaigns/${name}.json`),
        "utf8",
      ),
    );
    const response =
      example.responses[name === "ReplaceFailedCampaign" ? "200" : "201"];
    assert.equal(response.body.status, "validating");
    assert.equal(
      Object.hasOwn(response.body, "locked_agent_version"),
      false,
      name,
    );
    assert.equal(response.headers["Retry-After"], 5);
    assert.equal(response.headers["Cache-Control"], "no-store");
  }
  for (const name of ["CancelCampaign", "DeleteTerminalCampaign"]) {
    const example = JSON.parse(
      await readFile(
        resolve(project, `examples/campaigns/${name}.json`),
        "utf8",
      ),
    );
    assert.equal(example.responses["202"].headers["Cache-Control"], "no-store");
  }
  const source = await readFile(
    resolve(project, "src/voice-agents/campaign-routes.tsp"),
    "utf8",
  );
  assert.doesNotMatch(source, /param:\s*"inputs"/);
});
