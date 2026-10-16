import assert from "node:assert/strict";
import { readFileSync } from "node:fs";
import { test } from "node:test";

const project = new URL("../", import.meta.url);
const readme = readFileSync(new URL("README.md", project), "utf8");
const examples = Object.fromEntries(
  [
    ...readme.matchAll(
      /<!-- trace-generation-example: ([\w-]+) -->\s*```json\s*([\s\S]*?)```/g,
    ),
  ].map(([, name, json]) => [name, JSON.parse(json)]),
);

for (const version of ["v1", "virtual-public-preview"]) {
  const spec = JSON.parse(
    readFileSync(
      new URL(`openapi3/${version}/microsoft-foundry-openapi3.json`, project),
      "utf8",
    ),
  );
  const schemas = spec.components.schemas;
  const traces = schemas.TracesDataGenerationJobConfiguration;

  test(`${version}: trace settings are optional and absent from other generation modes`, () => {
    assert.equal(traces.properties.sample_level.default, "turn");
    assert.equal(
      traces.properties.generate_test_case_description.default,
      false,
    );
    assert(!traces.required.includes("sample_level"));
    assert(!traces.required.includes("generate_test_case_description"));
    assert.deepEqual(
      schemas.TraceSampleLevel.anyOf.flatMap((variant) => variant.enum ?? []),
      ["turn", "conversation"],
    );
    for (const [name, schema] of Object.entries(schemas)) {
      if (
        name.endsWith("DataGenerationJobConfiguration") &&
        name !== "TracesDataGenerationJobConfiguration"
      ) {
        assert(!Object.hasOwn(schema.properties, "sample_level"), name);
        assert(
          !Object.hasOwn(schema.properties, "generate_test_case_description"),
          name,
        );
      }
    }
    assert.deepEqual(schemas.DataGenerationModelOptions.required, ["model"]);
    assert.deepEqual(
      Object.keys(schemas.DataGenerationModelOptions.properties),
      ["model"],
    );
    assert(
      !schemas.DataGenerationJobConfiguration.required.includes(
        "model_options",
      ),
    );
  });

  test(`${version}: create/get/list share effective trace settings through existing discriminators`, () => {
    const collection = spec.paths["/data_generation_jobs"];
    const get = spec.paths["/data_generation_jobs/{jobId}"].get;
    assert.equal(
      collection.post.requestBody.content["application/json"].schema.$ref,
      "#/components/schemas/DataGenerationJobInputs",
    );
    for (const [operation, status] of [
      [collection.post, "201"],
      [get, "200"],
    ]) {
      assert.equal(
        operation.responses[status].content["application/json"].schema.$ref,
        "#/components/schemas/DataGenerationJob",
      );
    }
    assert.equal(
      collection.get.responses["200"].content["application/json"].schema
        .properties.data.items.$ref,
      "#/components/schemas/DataGenerationJob",
    );
    for (const name of ["DataGenerationJobInputs", "DataGenerationJob"]) {
      assert.equal(schemas[name].discriminator.propertyName, "scenario");
      assert.equal(
        schemas[name].properties.generation_configuration.$ref,
        "#/components/schemas/DataGenerationJobConfiguration",
      );
    }
    assert.equal(
      schemas.DataGenerationJobConfiguration.discriminator.mapping.traces,
      "#/components/schemas/TracesDataGenerationJobConfiguration",
    );
    const header = collection.post.parameters.find(
      (parameter) => parameter.name === "Foundry-Features",
    );
    assert.equal(header.required, false);
    assert.deepEqual(header.schema.enum, ["DataGenerationJobs=V1Preview"]);
  });

  test(`${version}: documented requests preserve defaults and reuse the optional model`, () => {
    const turn = examples["turn-request"].generation_configuration;
    const conversation =
      examples["conversation-request"].generation_configuration;
    const description =
      examples["description-request"].generation_configuration;
    assert(!Object.hasOwn(turn, "sample_level"));
    assert(!Object.hasOwn(turn, "generate_test_case_description"));
    assert.equal(conversation.sample_level, "conversation");
    assert(!Object.hasOwn(conversation, "model_options"));
    assert(!Object.hasOwn(conversation, "generate_test_case_description"));
    assert.equal(description.generate_test_case_description, true);
    assert(description.model_options.model.length > 0);
    assert.equal(
      examples["turn-response"].generation_configuration.sample_level,
      "turn",
    );
    assert.equal(
      examples["turn-response"].generation_configuration
        .generate_test_case_description,
      false,
    );
    assert.equal(
      examples["conversation-response"].generation_configuration
        .generate_test_case_description,
      false,
    );
    assert.equal(
      examples["description-response"].generation_configuration.sample_level,
      "conversation",
    );
    assert.equal(
      examples["description-response"].generation_configuration
        .generate_test_case_description,
      true,
    );
  });

  test(`${version}: incomplete optional descriptions produce a nonfatal warning`, () => {
    const job = examples["warning-response"];
    assert.equal(job.status, "succeeded");
    assert(job.result.generated_samples > 0);
    assert.equal(
      schemas.DataGenerationJobResult.properties.warnings.items.$ref,
      "#/components/schemas/DataGenerationWarning",
    );
    assert.deepEqual(
      Object.keys(schemas.DataGenerationWarning.properties).sort(),
      ["code", "message"],
    );
    assert.equal(
      job.result.warnings[0].code,
      "TestCaseDescriptionGenerationIncomplete",
    );
    assert.deepEqual(Object.keys(job.result.warnings[0]).sort(), [
      "code",
      "message",
    ]);
    assert.match(
      schemas.DatasetDataGenerationJobOutput.description,
      /row is retained/,
    );
    assert.match(
      traces.properties.max_samples.description,
      /whole conversation candidates/,
    );
    assert.match(
      schemas.EvaluationDataGenerationJobOutputConfiguration.properties
        .write_mode.description,
      /snapshot/,
    );
  });
}
