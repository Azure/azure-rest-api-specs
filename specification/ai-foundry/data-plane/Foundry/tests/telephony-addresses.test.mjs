import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";
import { dirname, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import { test } from "node:test";
import { compile, NodeHost, resolveCompilerOptions } from "@typespec/compiler";

const project = resolve(dirname(fileURLToPath(import.meta.url)), "..");
const entrypoint = resolve(project, "main.tsp");
const [options, diagnostics] = await resolveCompilerOptions(NodeHost, {
  entrypoint,
  cwd: project,
});
assert.deepEqual(diagnostics, []);
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
const roles = [
  ["TelephonyCallJobConfiguration", "source"],
  ["TelephonyCallJobConfiguration", "destination"],
  ["TelephonyCampaign", "source"],
  ["TelephonyRecipient", "destination"],
  ["TelephonyTransferTarget", "destination"],
];
const retiredModels = [
  "TeamsResourceAccount",
  "TeamsTelephonyTransferDestination",
  "SipTelephonyTransferDestination",
];
const addressTypes = {
  phone_number: "PhoneNumber",
  teams: "TeamsAddress",
  sip: "SipAddress",
};

test("all telephony roles reuse one address model and one set of wire kinds", () => {
  const address = projects.models.get("TelephonyAddress");
  for (const [model, property] of roles) {
    assert.equal(
      projects.models.get(model).properties.get(property).type,
      address,
      `${model}.${property}`,
    );
  }
  const kinds = projects.unions.get("TelephonyAddressType");
  assert.deepEqual(
    [...kinds.variants.values()]
      .filter(({ type }) => type.kind === "String")
      .map(({ type }) => type.value)
      .sort(),
    Object.keys(addressTypes).sort(),
  );
  assert.equal(address.properties.get("type").type, kinds);
  for (const [wireKind, model] of Object.entries(addressTypes)) {
    const variant = projects.models.get(model);
    assert.equal(variant.baseModel, address);
    assert.equal(variant.properties.get("type").type.type.value, wireKind);
  }
  for (const name of retiredModels)
    assert.equal(projects.models.has(name), false);
});

for (const version of ["v1", "virtual-public-preview"]) {
  test(`${version}: one discriminator mapping is shared by source, recipient and transfer`, async () => {
    const { components } = JSON.parse(
      await readFile(
        resolve(project, `openapi3/${version}/microsoft-foundry-openapi3.json`),
        "utf8",
      ),
    );
    const schemas = components.schemas;
    const addressRef = "#/components/schemas/TelephonyAddress";
    assert.equal(schemas.TelephonyAddress.discriminator.propertyName, "type");
    assert.deepEqual(
      schemas.TelephonyAddress.discriminator.mapping,
      Object.fromEntries(
        Object.entries(addressTypes).map(([kind, name]) => [
          kind,
          `#/components/schemas/${name}`,
        ]),
      ),
    );
    for (const [model, property] of [
      ["TelephonyCallJob", "source"],
      ["TelephonyCallJob", "destination"],
      ["TelephonyCampaignCreate", "source"],
      ["TelephonyCampaign", "source"],
      ["TelephonyRecipient", "destination"],
      ["TelephonyTransferTarget", "destination"],
    ]) {
      assert.equal(schemas[model].properties[property].$ref, addressRef);
    }
    for (const name of retiredModels) assert.equal(schemas[name], undefined);
    assert.equal(schemas.TeamsAddress.properties.value.maxLength, 256);
    assert.equal(schemas.SipAddress.properties.value.maxLength, 2048);
    assert.match(
      schemas.TelephonyCallJob.properties.source.description,
      /nonempty resource-account GUID/,
    );
    assert.match(
      schemas.TelephonyCallJob.properties.source.description,
      /sip source addresses are rejected/,
    );
    assert.match(
      schemas.SipAddress.description,
      /recipients remain phone numbers/,
    );
    assert.match(schemas.TeamsAddress.description, /28:orgid/);
    const phone = new RegExp(schemas.PhoneNumber.properties.value.pattern);
    assert.equal(phone.test("+14255550100"), true);
    for (const value of ["4255550100", "+14255550100\n", "+1\u0662\u0663"]) {
      assert.equal(phone.test(value), false);
    }
  });
}
