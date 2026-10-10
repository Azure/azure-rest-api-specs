// Run after tsp compile: node --test specification/cognitiveservices/resource-manager/Microsoft.CognitiveServices/CognitiveServices/test/cost-control-contract.test.mjs
import assert from "node:assert/strict";
import { readFileSync, readdirSync } from "node:fs";
import { test } from "node:test";
import { compile, NodeHost } from "@typespec/compiler";
import { createSdkContext } from "@azure-tools/typespec-client-generator-core";

const project = new URL("../", import.meta.url);
const version = "2026-09-15-preview";
const swagger = JSON.parse(
  readFileSync(
    new URL(`preview/${version}/cognitiveservices.json`, project),
    "utf8",
  ),
);
const definitions = swagger.definitions;
const route = Object.values(swagger.paths).find(
  (operations) => operations.put?.operationId === "CostControls_CreateOrUpdate",
);
const examples = new URL(`examples/${version}/CostControl/`, project);

test("canonical counterKey is one object, not the former plural array", () => {
  const rule = definitions.CostControlRule;
  assert(rule.required.includes("counterKey"));
  assert.equal(Object.hasOwn(rule.properties, "counterKeys"), false);
  assert.equal(
    rule.properties.counterKey.$ref,
    "#/definitions/CostControlDimension",
  );
  assert.equal(rule.properties.counterKey.type, undefined);
  const attribute = definitions.CostControlDimension.properties.attribute;
  assert.equal(attribute.readOnly, true);
  assert.equal(attribute.pattern, undefined);
  assert.equal(attribute.maxLength, undefined);
});

test("counterKey documentation matches the backend summary without paraphrasing", () => {
  assert.equal(
    definitions.CostControlRule.properties.counterKey.description.replace(
      /\s+/g,
      " ",
    ),
    [
      "Gets or sets the single built-in dimension used to partition consumption.",
      "Custom dimensions are retained only for legacy reads and metadata-only updates.",
      "Legacy singleton arrays are accepted on read; serialization always emits an object.",
      "To track another field, create another rule.",
    ].join(" "),
  );
});

test("PUT, GET and PATCH use the same resource schema", () => {
  const body = route.put.parameters.find(
    (parameter) => parameter.in === "body",
  );
  for (const schema of [
    body.schema,
    route.put.responses["200"].schema,
    route.put.responses["201"].schema,
    route.get.responses["200"].schema,
    route.patch.responses["200"].schema,
  ]) {
    assert.deepEqual(schema, { $ref: "#/definitions/CostControl" });
  }
  assert.deepEqual(
    route.patch.parameters.find((parameter) => parameter.in === "body").schema,
    {
      $ref: "#/definitions/CostControlPatch",
    },
  );
});

test("threshold actions are explicit without an Audit authoring default", () => {
  const threshold = definitions.CostControlThreshold;
  assert(threshold.required.includes("action"));
  assert.equal(Object.hasOwn(threshold.properties.action, "default"), false);
  assert(definitions.CostControlThresholdAction.enum.includes("Audit"));
  assert.match(threshold.properties.action.description, /legacy/i);
  assert.match(
    threshold.properties.action.description,
    /explicitly specify Alert or Block/,
  );
  assert.match(
    definitions.CostControlRule.properties.thresholds.description,
    /Omitted or empty thresholds track usage without explicit actions/,
  );
});

test("legacy values stay readable while current authoring restrictions are documented", () => {
  assert(definitions.CostControlDimensionType.enum.includes("Custom"));
  assert.match(
    definitions.CostControlDimensionType["x-ms-enum"].values.find(
      (value) => value.value === "Custom",
    ).description,
    /Legacy read-only/,
  );
  for (const period of ["Minute", "Hour", "Year"]) {
    assert(definitions.CostControlPeriod.enum.includes(period));
    assert.match(
      definitions.CostControlPeriod["x-ms-enum"].values.find(
        (value) => value.value === period,
      ).description,
      /Legacy read-only/,
    );
  }
});

test("agent filters use resource IDs without expanding unchanged non-agent filters", () => {
  const match = definitions.CostControlMatch.properties;
  assert.equal(Object.hasOwn(match, "agentIds"), false);
  assert.equal(Object.hasOwn(match, "foundry.caller.agent.id"), false);
  assert.equal(match.agentResourceIds.minItems, 1);
  assert.equal(match.agentResourceIds.maxItems, 20);
  assert.equal(
    match.agentResourceIds.items.$ref,
    "#/definitions/CostControlMatchValue",
  );
  assert.match(
    match.agentResourceIds.description,
    /Agent resource IDs use \/subscriptions\//,
  );
  assert.deepEqual(Object.keys(match).sort(), [
    "agentResourceIds",
    "identityObjectIds",
    "projectIds",
    "sessionIds",
  ]);
});

test("unchanged token capabilities stay outside this USD-only preview scope", () => {
  assert.deepEqual(definitions.CostControlUnit.enum, ["Usd"]);
  assert.equal(
    Object.hasOwn(definitions.CostControlRule.properties, "tokenTypes"),
    false,
  );
  assert.equal(Object.hasOwn(definitions, "CostControlTokenType"), false);
  assert.equal(
    readdirSync(examples).includes("createOrUpdateTokens.json"),
    false,
  );
  assert.equal(
    JSON.stringify(definitions.CostControlRule).includes("Tokens"),
    false,
  );
  assert.equal(
    JSON.stringify(definitions.CostControlThreshold).includes("token"),
    false,
  );
});

test("Application Insights remains optional and Event Grid protects Alert attachments", () => {
  const app =
    definitions.CostControlConnections.properties.appInsightsConnectionId;
  const event =
    definitions.CostControlConnections.properties.eventGridConnectionId;
  assert.match(
    definitions.CostControlConnections.description,
    /Application Insights is optional and may be removed while policies remain attached/,
  );
  assert.match(
    definitions.CostControlConnections.description,
    /Event Grid is required for alerts/,
  );
  assert.match(app.description, /optional Application Insights connection/);
  assert.match(
    event.description,
    /must be configured when an attached cost control contains an alert/,
  );
  assert.equal(app["x-nullable"], true);
  assert.equal(event["x-nullable"], true);
});

test("canonical authoring examples and legacy metadata updates are coherent", () => {
  const cases = [];
  for (const file of readdirSync(examples).filter((name) =>
    name.endsWith(".json"),
  )) {
    const source = readFileSync(new URL(file, examples));
    const emitted = readFileSync(
      new URL(`preview/${version}/examples/CostControl/${file}`, project),
    );
    assert.deepEqual(source, emitted);
    const example = JSON.parse(source);
    const operation = Object.values(swagger.paths)
      .flatMap((operations) => Object.values(operations))
      .find((candidate) => candidate.operationId === example.operationId);
    assert(operation);
    assert(
      Object.values(operation["x-ms-examples"]).some((value) =>
        value.$ref.endsWith(`/CostControl/${file}`),
      ),
    );
    assert.deepEqual(
      Object.keys(example.responses).sort(),
      Object.keys(operation.responses)
        .filter((status) => status !== "default")
        .sort(),
    );
    for (const response of Object.values(example.responses)) {
      if (response.body?.etag !== undefined) {
        assert.equal(response.body.etag, response.headers.ETag, file);
      }
    }
    const request =
      example.parameters.resource ?? example.parameters.properties;
    const authored = request?.properties?.rules;
    for (const rule of authored ?? []) {
      assert(!Array.isArray(rule.counterKey));
      assert.equal(Object.hasOwn(rule, "counterKeys"), false);
      assert.notEqual(rule.counterKey.type, "Custom");
      assert.equal(Object.hasOwn(rule.counterKey, "attribute"), false);
      for (const threshold of rule.thresholds ?? []) {
        assert(["Alert", "Block"].includes(threshold.action));
      }
      for (const value of rule.match?.agentResourceIds ?? []) {
        assert.match(
          value,
          /^\/subscriptions\/[0-9a-f-]{36}\/accounts\/[^/]+\/project\/[^/]+\/agent\/[^/]+$/,
        );
      }
    }
    cases.push({ file, example });
  }
  const legacy = cases.find((value) => value.file === "getLegacy.json").example;
  assert.equal(
    legacy.responses["200"].body.properties.rules[0].counterKey.type,
    "Custom",
  );
  assert.equal(
    legacy.responses["200"].body.properties.rules[0].thresholds[0].action,
    "Audit",
  );
  const metadata = cases.find(
    (value) => value.file === "updateMetadata.json",
  ).example;
  assert.deepEqual(metadata.parameters.properties, {
    properties: { displayName: "Renamed legacy budget" },
  });
  assert.equal(
    metadata.responses["200"].body.properties.rules[0].counterKey.type,
    "Custom",
  );
  const create = cases.find(
    (value) => value.file === "createOrUpdate.json",
  ).example;
  assert.equal(create.parameters["If-None-Match"], "*");
});

test("both entrypoints expose only the scoped backend updates in SDK model graphs", async () => {
  for (const entry of ["main.tsp", "client.tsp"]) {
    const program = await compile(NodeHost, new URL(entry, project).pathname, {
      noEmit: true,
      warningAsError: true,
    });
    assert(!program.hasError(), entry);
    for (const emitter of [
      "@azure-tools/typespec-csharp",
      "@azure-tools/typespec-ts",
    ]) {
      const context = await createSdkContext(
        {
          program,
          emitterOutputDir: project.pathname,
          options: { "api-version": version },
        },
        emitter,
      );
      const rule = context.sdkPackage.models.find(
        (model) => model.__raw?.name === "CostControlRule",
      );
      assert(rule, emitter);
      const counter = rule.properties.find(
        (property) => property.serializedName === "counterKey",
      );
      assert(counter && !counter.optional);
      assert.equal(counter.type.kind, "model");
      assert.equal(
        rule.properties.some(
          (property) => property.serializedName === "counterKeys",
        ),
        false,
      );
      const threshold = context.sdkPackage.models.find(
        (model) => model.__raw?.name === "CostControlThreshold",
      );
      assert.equal(
        threshold.properties.find(
          (property) => property.serializedName === "action",
        ).optional,
        false,
      );
      const match = context.sdkPackage.models.find(
        (model) => model.__raw?.name === "CostControlMatch",
      );
      assert(
        match.properties.some(
          (property) => property.serializedName === "agentResourceIds",
        ),
      );
      assert(
        match.properties.some(
          (property) => property.serializedName === "identityObjectIds",
        ),
      );
      assert.equal(
        match.properties.some((property) =>
          property.serializedName.startsWith("foundry."),
        ),
        false,
      );
      assert.equal(
        rule.properties.some(
          (property) => property.serializedName === "tokenTypes",
        ),
        false,
      );
      assert.equal(
        context.sdkPackage.models.some(
          (model) => model.__raw?.name === "CostControlTokenType",
        ),
        false,
      );
    }
  }
});
