import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { test } from "node:test";

const project = resolve(dirname(fileURLToPath(import.meta.url)), "..");
const campaigns = "/agents/{agent_name}/telephony_campaigns";
const jobs = "/agents/{agent_name}/telephony_call_jobs";
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

  test(`${version}: compound Telephony routes retain required Agent path ownership`, () => {
    const paths = [
      campaigns,
      `${campaigns}/{campaign_name}`,
      `${campaigns}/{campaign_name}:cancel`,
      `${campaigns}/{campaign_name}/validation_errors`,
      `${campaigns}/{campaign_name}/operations/{operation_id}`,
      jobs,
      `${jobs}/{call_job_id}`,
      `${jobs}/{call_job_id}:cancel`,
    ];
    let operations = 0;
    for (const path of paths) {
      assert(document.paths[path], path);
      for (const [verb, operation] of Object.entries(document.paths[path])) {
        if (!verbs.has(verb)) continue;
        operations++;
        const agent = operation.parameters.filter(
          (parameter) => parameter.name === "agent_name",
        );
        assert.equal(agent.length, 1);
        assert.equal(agent[0].in, "path");
        assert.equal(agent[0].required, true);
      }
    }
    assert.equal(operations, 12);
    assert(
      !Object.keys(document.paths).some(
        (path) =>
          path.startsWith("/telephony_campaigns") ||
          path.startsWith("/telephony_call_jobs"),
      ),
    );
    assert(
      !Object.keys(document.paths).some(
        (path) =>
          path.startsWith("/agents/{agent_name}/telephony/campaigns") ||
          path.startsWith("/agents/{agent_name}/telephony/call_jobs"),
      ),
    );
  });

  test(`${version}: creation has no second Agent identity and Campaign names remain Agent-scoped`, () => {
    for (const [path, verb] of [
      [`${campaigns}/{campaign_name}`, "put"],
      [jobs, "post"],
    ]) {
      const request = schema(
        document,
        document.paths[path][verb].requestBody.content["application/json"]
          .schema,
      );
      assert.equal(request.properties.agent_name, undefined);
      assert(!request.required.includes("agent_name"));
    }
    assert.match(
      document.components.schemas.TelephonyCampaignName.description,
      /project and Agent/,
    );
    assert.match(
      document.components.schemas.TelephonyCampaign.properties.name.description,
      /project and Agent/,
    );
    assert.equal(
      document.components.schemas.TelephonyCampaign.properties.agent_name,
      undefined,
    );
    assert(
      document.components.schemas.TelephonyCallJob.required.includes(
        "agent_name",
      ),
    );
    assert(
      document.components.schemas.TelephonyCallJob.required.includes(
        "retry_policy",
      ),
    );
  });
}

test("Campaign examples keep Agent path identity and matching compound resource links", async () => {
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
    const agent = example.parameters.agent_name;
    assert.equal(agent, "contoso-reminder-agent");
    if (example.parameters.campaign)
      assert.equal(example.parameters.campaign.agent_name, undefined);
    for (const response of Object.values(example.responses)) {
      for (const header of ["Location", "Operation-Location"]) {
        const url = response.headers?.[header];
        if (url) assert(url.includes(`/agents/${agent}/telephony_campaigns/`));
      }
    }
  }
});
