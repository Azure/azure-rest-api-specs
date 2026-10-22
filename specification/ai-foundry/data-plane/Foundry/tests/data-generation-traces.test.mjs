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

  test(`${version}: trace settings stay optional and separate from other generation modes`, () => {
    assert.equal(traces.properties.sample_level.default, "turn");
    assert.equal(
      traces.properties.generate_test_case_description.default,
      false,
    );
    assert(!traces.required.includes("sample_level"));
    assert(!traces.required.includes("generate_test_case_description"));
    assert.equal(
      traces.properties.generate_test_case_rubric_preview.type,
      "boolean",
    );
    assert(!traces.required.includes("generate_test_case_rubric_preview"));
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
        if (name !== "ConversationsDataGenerationJobConfiguration") {
          assert(
            !Object.hasOwn(schema.properties, "generate_test_case_description"),
            name,
          );
        }
        assert(
          !Object.hasOwn(
            schema.properties,
            "generate_test_case_rubric_preview",
          ),
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

  test(`${version}: conversations reconstruct traces with implicit sampling and optional descriptions`, () => {
    const conversations = schemas.ConversationsDataGenerationJobConfiguration;
    assert(conversations, "The conversations configuration must be emitted.");
    assert.deepEqual(conversations.allOf, [
      { $ref: "#/components/schemas/DataGenerationJobConfiguration" },
    ]);
    assert.deepEqual(conversations.properties.type.enum, ["conversations"]);
    assert(!Object.hasOwn(conversations.properties, "sample_level"));
    assert(
      !Object.hasOwn(
        conversations.properties,
        "generate_test_case_rubric_preview",
      ),
    );
    assert(
      !Object.hasOwn(
        schemas.DataGenerationJobConfiguration.properties,
        "sample_level",
      ),
    );
    assert.deepEqual(conversations.required, ["type"]);
    assert.equal(conversations.properties.max_samples.type, "integer");
    assert.deepEqual(
      conversations.properties.redact_private_content,
      traces.properties.redact_private_content,
    );
    assert.equal(
      conversations.properties.generate_test_case_description.default,
      false,
    );
    assert.equal(
      conversations.properties.model_options.$ref,
      "#/components/schemas/DataGenerationModelOptions",
    );
    assert.match(
      conversations.properties.model_options.description,
      /must be omitted otherwise/,
    );

    const request = examples["conversations-type-request"];
    const response = examples["conversations-type-response"];
    const defaults = examples["conversations-type-default-request"];
    for (const job of [request, response, defaults]) {
      assert.equal(job.scenario, "evaluation");
      assert.equal(job.generation_configuration.type, "conversations");
      assert(!Object.hasOwn(job.generation_configuration, "sample_level"));
      for (const source of job.sources) {
        assert.equal(source.type, "traces");
        for (const field of Object.keys(source)) {
          assert(
            Object.hasOwn(
              schemas.TracesDataGenerationJobSource.properties,
              field,
            ),
            field,
          );
        }
      }
    }
    assert.equal(
      request.generation_configuration.generate_test_case_description,
      true,
    );
    assert(request.generation_configuration.model_options.model.length > 0);
    assert.deepEqual(
      response.generation_configuration.model_options,
      request.generation_configuration.model_options,
    );
    assert(!Object.hasOwn(defaults.generation_configuration, "model_options"));
    assert(
      !Object.hasOwn(
        defaults.generation_configuration,
        "generate_test_case_description",
      ),
    );
    assert(
      !Object.hasOwn(
        schemas.DataGenerationJobSource.discriminator.mapping,
        "conversations",
      ),
    );
  });

  test(`${version}: rubric generation reuses model options independently of descriptions`, () => {
    const rubric = examples["rubric-request"].generation_configuration;
    assert.equal(rubric.type, "traces");
    assert.equal(rubric.generate_test_case_rubric_preview, true);
    assert(rubric.model_options.model.length > 0);
    assert(!Object.hasOwn(rubric, "generate_test_case_description"));
    assert.match(
      traces.properties.generate_test_case_rubric_preview.description,
      /requires a nonempty `model_options\.model`/,
    );
    assert.match(
      schemas.DataGenerationModelOptions.properties.model.description,
      /generate_test_case_rubric_preview/,
    );
    for (const name of [
      "turn-request",
      "conversation-request",
      "description-request",
    ]) {
      assert(
        !Object.hasOwn(
          examples[name].generation_configuration,
          "generate_test_case_rubric_preview",
        ),
      );
    }
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
    assert.deepEqual(
      schemas.DataGenerationJobConfiguration.discriminator.mapping,
      {
        simple_qna:
          "#/components/schemas/SimpleQnADataGenerationJobConfiguration",
        traces: "#/components/schemas/TracesDataGenerationJobConfiguration",
        conversations:
          "#/components/schemas/ConversationsDataGenerationJobConfiguration",
        simulation_seed:
          "#/components/schemas/SimulationSeedDataGenerationJobConfiguration",
        tool_use:
          "#/components/schemas/ToolUseFineTuningDataGenerationJobConfiguration",
      },
    );
    assert(
      schemas.DataGenerationJobType.anyOf.some((variant) =>
        variant.enum?.includes("conversations"),
      ),
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
    assert.match(traces.description, /row is retained/);
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
