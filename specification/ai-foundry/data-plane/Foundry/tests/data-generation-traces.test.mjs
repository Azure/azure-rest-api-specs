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
  const conversations = schemas.ConversationsDataGenerationJobConfiguration;
  const traces = schemas.TracesDataGenerationJobConfiguration;

  test(`${version}: description generation is conversation-only and rubric generation is limited to traces and conversations`, () => {
    for (const [name, schema] of Object.entries(schemas)) {
      if (!name.endsWith("DataGenerationJobConfiguration")) continue;
      for (const removed of [
        "sample_level",
        "generate_test_case_description_preview",
        "generate_test_case_rubric_preview",
      ]) {
        assert(
          !Object.hasOwn(schema.properties, removed),
          `${name}.${removed}`,
        );
      }
      if (name === "ConversationsDataGenerationJobConfiguration") continue;
      assert(
        !Object.hasOwn(schema.properties, "generate_test_case_description"),
        `${name}.generate_test_case_description`,
      );
      if (name !== "TracesDataGenerationJobConfiguration") {
        assert(
          !Object.hasOwn(schema.properties, "generate_test_case_rubric"),
          `${name}.generate_test_case_rubric`,
        );
      }
    }
    assert(!Object.hasOwn(schemas, "TraceSampleLevel"));
    assert.deepEqual(
      Object.keys(traces.properties).sort(),
      [
        "generate_test_case_rubric",
        "max_samples",
        "redact_private_content",
        "type",
      ],
    );
  });

  test(`${version}: trace rubric generation is optional and uses existing model options`, () => {
    assert.deepEqual(traces.required, ["type"]);
    assert.equal(traces.properties.generate_test_case_rubric.type, "boolean");
    assert.match(
      traces.properties.generate_test_case_rubric.description,
      /requires a nonempty `model_options\.model`/,
    );
    assert.equal(
      schemas.DataGenerationJobConfiguration.properties.model_options.$ref,
      "#/components/schemas/DataGenerationModelOptions",
    );
    assert.deepEqual(traces.allOf, [
      { $ref: "#/components/schemas/DataGenerationJobConfiguration" },
    ]);
  });

  test(`${version}: conversation generation supports independent flags and shared model options`, () => {
    assert.deepEqual(conversations.required, ["type"]);
    assert.deepEqual(conversations.properties.type.enum, ["conversations"]);
    for (const flag of [
      "generate_test_case_description",
      "generate_test_case_rubric",
    ]) {
      assert.equal(conversations.properties[flag].type, "boolean");
      assert.match(
        conversations.properties[flag].description,
        /requires a nonempty `model_options\.model`/,
      );
    }
    assert.equal(
      conversations.properties.generate_test_case_description.default,
      false,
    );
    assert.deepEqual(
      conversations.properties.redact_private_content,
      schemas.TracesDataGenerationJobConfiguration.properties
        .redact_private_content,
    );
    assert.equal(
      conversations.properties.model_options.$ref,
      "#/components/schemas/DataGenerationModelOptions",
    );
    assert.match(
      conversations.properties.model_options.description,
      /generate_test_case_description.*or.*generate_test_case_rubric/,
    );
    assert.deepEqual(schemas.DataGenerationModelOptions.required, ["model"]);
  });

  test(`${version}: examples support rubric generation on traces and conversations`, () => {
    for (const [name, job] of Object.entries(examples)) {
      const configuration = job.generation_configuration;
      assert(!Object.hasOwn(configuration, "sample_level"), name);
      assert(
        !Object.hasOwn(configuration, "generate_test_case_description_preview"),
        name,
      );
      assert(
        !Object.hasOwn(configuration, "generate_test_case_rubric_preview"),
        name,
      );
      for (const field of Object.keys(configuration)) {
        const ownProperties =
          configuration.type === "traces"
            ? schemas.TracesDataGenerationJobConfiguration.properties
            : conversations.properties;
        assert(
          Object.hasOwn(ownProperties, field) ||
            Object.hasOwn(
              schemas.DataGenerationJobConfiguration.properties,
              field,
            ),
          `${name}.${field}`,
        );
      }
      const needsModel =
        configuration.generate_test_case_description === true ||
        configuration.generate_test_case_rubric === true;
      if (needsModel) {
        assert(configuration.model_options.model.length > 0, name);
      } else if (configuration.type === "conversations") {
        assert(!Object.hasOwn(configuration, "model_options"), name);
      }
      if (name.startsWith("turn-")) {
        assert.equal(configuration.type, "traces");
        continue;
      }
      assert.equal(configuration.type, "conversations", name);
      assert.equal(job.scenario, "evaluation", name);
      assert(
        job.sources.every((source) => source.type === "traces"),
        name,
      );
    }
    assert.equal(
      examples["description-request"].generation_configuration
        .generate_test_case_description,
      true,
    );
    assert.equal(
      examples["turn-rubric-request"].generation_configuration
        .generate_test_case_rubric,
      true,
    );
    assert(
      !Object.hasOwn(
        examples["turn-rubric-request"].generation_configuration,
        "generate_test_case_description",
      ),
    );
    assert.equal(
      examples["rubric-request"].generation_configuration
        .generate_test_case_rubric,
      true,
    );
    assert(
      !Object.hasOwn(
        examples["rubric-request"].generation_configuration,
        "generate_test_case_description",
      ),
    );
    assert.match(conversations.description, /row is retained/);
  });

  test(`${version}: create/get/list share the conversation configuration without changing other job types`, () => {
    const collection = spec.paths["/data_generation_jobs"];
    assert.equal(
      collection.post.requestBody.content["application/json"].schema.$ref,
      "#/components/schemas/DataGenerationJobInputs",
    );
    for (const [operation, status] of [
      [collection.post, "201"],
      [spec.paths["/data_generation_jobs/{jobId}"].get, "200"],
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
    const header = collection.post.parameters.find(
      (parameter) => parameter.name === "Foundry-Features",
    );
    assert.equal(header.required, false);
    assert.deepEqual(header.schema.enum, ["DataGenerationJobs=V1Preview"]);
  });

  test(`${version}: warning codes are optional unrestricted strings`, () => {
    const warning = schemas.DataGenerationWarning;
    assert.equal(warning.properties.code.type, "string");
    assert(!Object.hasOwn(warning.properties.code, "enum"));
    assert(!Object.hasOwn(warning.properties.code, "$ref"));
    assert.deepEqual(warning.required, ["message"]);
    assert(!Object.hasOwn(schemas, "DataGenerationWarningCode"));
    assert.equal(
      schemas.DataGenerationJobResult.properties.warnings.items.$ref,
      "#/components/schemas/DataGenerationWarning",
    );
    assert.equal(examples["warning-response"].status, "succeeded");
  });
}
