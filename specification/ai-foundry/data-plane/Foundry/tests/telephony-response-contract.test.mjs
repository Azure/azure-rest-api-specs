import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { test } from "node:test";

const project = resolve(dirname(fileURLToPath(import.meta.url)), "..");
const prefix = "/agents/{agent_name}/telephony/campaigns";
const item = `${prefix}/{campaign_name}`;

test("CallJob responses document their existing entity, location and retry headers", async () => {
  for (const version of ["v1", "virtual-public-preview"]) {
    const document = JSON.parse(
      await readFile(
        resolve(project, `openapi3/${version}/microsoft-foundry-openapi3.json`),
        "utf8",
      ),
    );
    const job = "/agents/{agent_name}/telephony/call_jobs";
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
    resolve(project, "src/voice-agents/campaign-jobs.tsp"),
    "utf8",
  );
  assert.doesNotMatch(source, /param:\s*"inputs"/);
});
