import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { test } from "node:test";
import { compile, NodeHost, resolveCompilerOptions } from "@typespec/compiler";

const project = resolve(dirname(fileURLToPath(import.meta.url)), "..");
const entrypoint = resolve(project, "main.tsp");
const [options, configDiagnostics] = await resolveCompilerOptions(NodeHost, {
  entrypoint,
  cwd: project,
});
assert.deepEqual(configDiagnostics, []);
const program = await compile(NodeHost, entrypoint, {
  ...options,
  noEmit: true,
});
assert.deepEqual(
  program.diagnostics.map(({ code, message }) => ({ code, message })),
  [],
);
const projects = program
  .getGlobalNamespaceType()
  .namespaces.get("Azure")
  .namespaces.get("AI")
  .namespaces.get("Projects");

test("Campaign and direct CallJob accept the same structured-input value type", () => {
  const campaign = projects.models
    .get("TelephonyRecipient")
    .properties.get("structured_inputs");
  const direct = projects.models
    .get("TelephonyCallJobConfiguration")
    .properties.get("structured_inputs");
  assert.equal(campaign.optional, true);
  assert.equal(direct.optional, true);
  assert.equal(campaign.type.kind, "Model");
  assert.equal(campaign.type.indexer.key.name, "string");
  assert.equal(campaign.type.indexer.value.name, "unknown");
  assert.equal(campaign.type.indexer.value, direct.type.indexer.value);
  assert.equal(projects.unions.has("TelephonyCampaignInputValue"), false);
});

for (const version of ["v1", "virtual-public-preview"]) {
  test(`${version}: emitted Campaign dictionary matches direct CallJob without scalar restrictions`, async () => {
    const document = JSON.parse(
      await readFile(
        resolve(project, `openapi3/${version}/microsoft-foundry-openapi3.json`),
        "utf8",
      ),
    );
    const schemas = document.components.schemas;
    const campaign = schemas.TelephonyRecipient.properties.structured_inputs;
    const direct = schemas.TelephonyCallJob.properties.structured_inputs;
    const withoutDescription = ({ description, ...schema }) => schema;
    assert.deepEqual(withoutDescription(campaign), withoutDescription(direct));
    assert.equal(campaign.type, "object");
    assert.deepEqual(campaign.additionalProperties, {});
    assert.equal(schemas.TelephonyCampaignInputValue, undefined);
    assert.match(campaign.description, /null, objects and arrays/);
    assert.match(campaign.description, /required\/default\/schema/);
  });
}
