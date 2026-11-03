import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { test } from "node:test";

const project = resolve(dirname(fileURLToPath(import.meta.url)), "..");
const campaigns = "/telephony_campaigns";
const jobs = "/telephony_call_jobs";
const verbs = new Set(["get", "post", "put", "delete", "patch"]);

function schema(document, value) {
  if (!value.$ref) return value;
  return schema(
    document,
    value.$ref
      .slice(2)
      .split("/")
      .reduce((object, key) => object[key], document),
  );
}

for (const version of ["v1", "virtual-public-preview"]) {
  const document = JSON.parse(
    await readFile(
      resolve(project, `openapi3/${version}/microsoft-foundry-openapi3.json`),
      "utf8",
    ),
  );

  test(`${version}: Campaign and CallJob resources have project-level paths`, () => {
    const expected = [
      campaigns,
      `${campaigns}/{campaign_name}`,
      `${campaigns}/{campaign_name}:cancel`,
      `${campaigns}/{campaign_name}/validation_errors`,
      `${campaigns}/{campaign_name}/operations/{operation_id}`,
      jobs,
      `${jobs}/{call_job_id}`,
      `${jobs}/{call_job_id}:cancel`,
    ];
    for (const path of expected) assert(document.paths[path], path);
    assert(
      !Object.keys(document.paths).some(
        (path) =>
          path.startsWith("/agents/{agent_name}/telephony/campaigns") ||
          path.startsWith("/agents/{agent_name}/telephony/call_jobs"),
      ),
    );
    let operations = 0;
    for (const path of expected) {
      for (const [verb, operation] of Object.entries(document.paths[path])) {
        if (!verbs.has(verb)) continue;
        operations++;
        assert(
          !operation.parameters.some(
            (parameter) =>
              parameter.in === "path" && parameter.name === "agent_name",
          ),
        );
      }
    }
    assert.equal(operations, 12);
  });

  test(`${version}: Agent ownership is required in creation bodies, optional only as a list filter`, () => {
    for (const [path, verb] of [
      [`${campaigns}/{campaign_name}`, "put"],
      [jobs, "post"],
    ]) {
      const request = schema(
        document,
        document.paths[path][verb].requestBody.content["application/json"]
          .schema,
      );
      assert(request.required.includes("agent_name"));
      assert.equal(request.properties.agent_name.type, "string");
      assert.equal(request.properties.agent_name.minLength, 1);
      assert.notEqual(request.properties.agent_name.readOnly, true);
    }
    for (const path of [campaigns, jobs]) {
      const parameter = document.paths[path].get.parameters.find(
        (p) => p.name === "agent_name",
      );
      assert(parameter, path);
      assert.equal(parameter.in, "query");
      assert.equal(parameter.required, false);
    }
    const campaign = document.components.schemas.TelephonyCampaign;
    assert(campaign.required.includes("agent_name"));
    assert.match(campaign.properties.agent_name.description, /cannot change/);
    assert.match(
      campaign.properties.name.description,
      /Unique within the project/,
    );
    assert.match(
      document.components.schemas.TelephonyCampaignName.description,
      /unique within a project/,
    );
  });
}

test("Campaign examples carry Agent ownership in bodies and flat operation links", async () => {
  for (const name of [
    "CreateImmediate",
    "CreateScheduled",
    "CreateRecipientScheduled",
    "ReplaceFailedCampaign",
    "CancelCampaign",
    "DeleteTerminalCampaign",
  ]) {
    const example = JSON.parse(
      await readFile(
        resolve(project, `examples/campaigns/${name}.json`),
        "utf8",
      ),
    );
    assert.equal(example.parameters.agent_name, undefined);
    if (example.parameters.campaign)
      assert.equal(
        example.parameters.campaign.agent_name,
        "contoso-reminder-agent",
      );
    for (const response of Object.values(example.responses)) {
      for (const header of ["Location", "Operation-Location"]) {
        const url = response.headers?.[header];
        if (url) {
          assert.match(url, /\/telephony_campaigns\//);
          assert.doesNotMatch(url, /\/agents\/[^/]+\/telephony\//);
        }
      }
      if (response.body?.name)
        assert.equal(response.body.agent_name, "contoso-reminder-agent");
    }
  }
});
