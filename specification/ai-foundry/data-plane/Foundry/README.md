# Foundry data-plane TypeSpec

This folder contains the TypeSpec for all data-plane REST APIs of the Foundry service.

## Contributing

### Adding preview features

Make sure that all preview features (routes and TypeSpec models) that are not associated with the `/openai` routes are marked with
both the `@added` decorator for the target preview version, and the `@removed`
decorator for the GA `v1` version. If you don't add the `@removed` decorator, your preview
features will incorrectly appear in the GA `v1` swagger in
(file `..\data-plane\Azure.AI.Projects\stable\v1\azure-ai-projects.json`).

For example:

```txt
@removed(Versions.v1)
model MyNewPreviewModel {
...
}
```

The models.tsp files associated with OpenAI routes `openai/responses`, `"openai/conversations` and `openai/evals` should not have
these decorators. The interfaces using those will have the appropriate decorators.

### Compiling and sending a PR

Before you send a PR for changes in this folder, do the following:

Change to folder

```cmd
cd specification\ai\Azure.AI.Projects
```

Make sure you have latest tools by running:

```cmd
npm ci
```

Create an empty folder named "examples", if one does not already exist

```cmd
mkdir examples
```

Compile, validate and re-format by running:

```cmd
npx tsv .
```

Fix any errors you see. This command may also update the format
of some files to make sure all files use a common format.

The above will also automatically create or edit swagger (OpenAPI) files in the
`..\data-plane\Azure.AI.Projects` folder. Review the changes there to make
sure they make sense to you. Then add them to your PR.

The `npx tsv .` has a console spew that shows the diff between current and staged
changes. Once you `git add` all the changed files and run `npx tsv .` again, there should
no longer be any diffs to show.

## Conversation-level trace data generation

Trace jobs use the public `generation_configuration` request shape. This
TypeSpec project does not define the legacy `inputs.options` shape.

`sample_level` is optional and defaults to `turn` (one sample per eligible
captured turn). `conversation` reconstructs one evaluation sample per observed
conversation. `generate_test_case_description` is optional and defaults to
`false`. When enabled, it generates one AI-authored description for each new
retained conversation row, using the existing `model_options.model`.
The optional preview flag `generate_test_case_rubric_preview` controls test-case
rubric generation and also requires a nonempty `model_options.model` when true.
Conversation reconstruction without description or rubric generation does not
require model options.
Existing turn-level requests remain valid and behaviorally unchanged.

For `type: traces`, the service enforces the following rules at runtime; the
schema does not express these cross-property or conditional-header requirements:

| Invalid request                                                                                               | Reason for rejection                                   |
| ------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------ |
| `sample_level: "conversation"` with a scenario other than `evaluation`                                        | Conversation samples are evaluation-only.              |
| `generate_test_case_description: true` with `sample_level: "turn"` or omitted                                 | Descriptions require conversation samples.             |
| `generate_test_case_description: true` with missing `model_options` or missing/empty `model_options.model`    | Description generation requires a nonempty model name. |
| `generate_test_case_rubric_preview: true` with missing `model_options` or missing/empty `model_options.model` | Rubric generation requires a nonempty model name.      |
| `sample_level: "conversation"` without `Foundry-Features: DataGenerationJobs=V1Preview`                       | Conversation generation requires preview opt-in.       |

The feature header remains optional for ordinary turn-level requests. Reading an
existing job does not require preview opt-in. Create, get, and list responses
return effective trace settings, including `turn` and `false` for settings omitted
from trace requests or absent from older stored trace jobs.

Conversation dataset rows contain `test_case_id`, `messages`, `tool_definitions`,
and `metadata`. A successful optional description adds `test_case_description`.
Description failure retains the row and records safe row-level status/error
metadata, without raw provider or model error bodies.
`max_samples` counts whole conversation candidates, not turns.
Dataset merge preserves conversation-snapshot semantics: it is not a union of
newly observed turns into an existing conversation snapshot.

These complete wire examples are maintained here because OpenAPI3 operation
example emission through the existing polymorphic base types omits subtype
fields.

After regenerating OpenAPI, run the focused contract checks from this folder:

```cmd
node --test tests\data-generation-traces.test.mjs
```

### Dedicated conversations configuration

The additive `generation_configuration.type: "conversations"` variant
reconstructs existing traced conversations for evaluation. It does not generate
synthetic conversations or replace `simulation_seed`. The backward-compatible
`type: "traces"` with `sample_level: "conversation"` remains supported.

Use the existing `/data_generation_jobs?api-version=v1` endpoint and
`Foundry-Features: DataGenerationJobs=V1Preview` header. Conversation sampling is
implicit: the new variant does not expose `sample_level`. Optional `max_samples`
counts whole conversations, `redact_private_content` defaults to `true`, and
`generate_test_case_description` defaults to `false`.

Sources remain `type: "traces"` with the existing agent, time-window, and
`trace_ids` selectors. This variant does not change trace-selection expansion,
annotations, dataset rows, or snapshot merge behavior.

The service enforces these cross-property rules for `type: "conversations"`:

| Invalid request                                                                                            | Reason for rejection                                          |
| ---------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------- |
| A scenario other than `evaluation`                                                                         | Reconstruction is evaluation-only.                            |
| A source with a type other than `traces`                                                                   | Reconstruction uses existing traced conversations.            |
| Missing `Foundry-Features: DataGenerationJobs=V1Preview`                                                   | Reconstruction requires the existing preview opt-in.          |
| `generate_test_case_description: true` with missing `model_options` or missing/empty `model_options.model` | Description generation requires a nonempty model name.        |
| `model_options` supplied while `generate_test_case_description` is false or omitted                        | Model options must be omitted when descriptions are disabled. |
| `sample_level` supplied                                                                                    | Conversation-level sampling is implicit.                      |

#### Request with descriptions

```http
POST /data_generation_jobs?api-version=v1
Content-Type: application/json
Foundry-Features: DataGenerationJobs=V1Preview
```

<!-- trace-generation-example: conversations-type-request -->

```json
{
  "name": "conversation-eval-data",
  "scenario": "evaluation",
  "generation_configuration": {
    "type": "conversations",
    "generate_test_case_description": true,
    "model_options": {
      "model": "summary-deployment"
    }
  },
  "sources": [
    {
      "type": "traces",
      "agent_name": "sample-agent",
      "start_time": 1790060400
    }
  ]
}
```

Create and get return the same job resource shape; list returns these resources
as items in `data`. All preserve `generation_configuration.type: "conversations"`
rather than converting it to `traces`.

<!-- trace-generation-example: conversations-type-response -->

```json
{
  "id": "dgj-conversation-eval",
  "name": "conversation-eval-data",
  "scenario": "evaluation",
  "generation_configuration": {
    "type": "conversations",
    "redact_private_content": true,
    "generate_test_case_description": true,
    "model_options": {
      "model": "summary-deployment"
    }
  },
  "sources": [
    {
      "type": "traces",
      "agent_name": "sample-agent",
      "start_time": 1790060400
    }
  ],
  "status": "queued",
  "created_at": 1790100000
}
```

#### Request without descriptions or model options

Use the same endpoint and preview header. Both `generate_test_case_description`
and `model_options` are omitted:

<!-- trace-generation-example: conversations-type-default-request -->

```json
{
  "name": "conversation-eval-without-descriptions",
  "scenario": "evaluation",
  "generation_configuration": {
    "type": "conversations",
    "max_samples": 10
  },
  "sources": [
    {
      "type": "traces",
      "agent_name": "sample-agent",
      "start_time": 1790060400,
      "end_time": 1790146800,
      "trace_ids": ["trace-support-conversation"]
    }
  ]
}
```

### Default turn request and effective defaults

```http
POST /data_generation_jobs?api-version=v1
Content-Type: application/json
```

<!-- trace-generation-example: turn-request -->

```json
{
  "name": "travel-support-turns",
  "scenario": "evaluation",
  "sources": [
    {
      "type": "traces",
      "agent_name": "travel-support-agent",
      "start_time": 1792022400
    }
  ],
  "generation_configuration": {
    "type": "traces",
    "max_samples": 25
  }
}
```

The optional trace settings and the preview header are omitted.

```http
HTTP/1.1 201 Created
Operation-Location: https://travel-foundry.services.ai.azure.com/api/projects/travel/data_generation_jobs/dgj-turns?api-version=v1
Location: https://travel-foundry.services.ai.azure.com/api/projects/travel/data_generation_jobs/dgj-turns?api-version=v1
```

<!-- trace-generation-example: turn-response -->

```json
{
  "id": "dgj-turns",
  "name": "travel-support-turns",
  "scenario": "evaluation",
  "sources": [
    {
      "type": "traces",
      "agent_name": "travel-support-agent",
      "start_time": 1792022400
    }
  ],
  "generation_configuration": {
    "type": "traces",
    "max_samples": 25,
    "sample_level": "turn",
    "generate_test_case_description": false
  },
  "status": "queued",
  "created_at": 1792108800
}
```

### Conversation request without descriptions or model options

```http
POST /data_generation_jobs?api-version=v1
Content-Type: application/json
Foundry-Features: DataGenerationJobs=V1Preview
```

<!-- trace-generation-example: conversation-request -->

```json
{
  "name": "travel-support-conversations",
  "scenario": "evaluation",
  "sources": [
    {
      "type": "traces",
      "agent_name": "travel-support-agent",
      "start_time": 1792022400
    }
  ],
  "generation_configuration": {
    "type": "traces",
    "sample_level": "conversation",
    "max_samples": 10
  }
}
```

```http
HTTP/1.1 201 Created
Operation-Location: https://travel-foundry.services.ai.azure.com/api/projects/travel/data_generation_jobs/dgj-conversations?api-version=v1
Location: https://travel-foundry.services.ai.azure.com/api/projects/travel/data_generation_jobs/dgj-conversations?api-version=v1
```

<!-- trace-generation-example: conversation-response -->

```json
{
  "id": "dgj-conversations",
  "name": "travel-support-conversations",
  "scenario": "evaluation",
  "sources": [
    {
      "type": "traces",
      "agent_name": "travel-support-agent",
      "start_time": 1792022400
    }
  ],
  "generation_configuration": {
    "type": "traces",
    "sample_level": "conversation",
    "generate_test_case_description": false,
    "max_samples": 10
  },
  "status": "queued",
  "created_at": 1792108800
}
```

### Conversation request with descriptions and model options

```http
POST /data_generation_jobs?api-version=v1
Content-Type: application/json
Foundry-Features: DataGenerationJobs=V1Preview
```

<!-- trace-generation-example: description-request -->

```json
{
  "name": "travel-support-described-conversations",
  "scenario": "evaluation",
  "sources": [
    {
      "type": "traces",
      "agent_name": "travel-support-agent",
      "start_time": 1792022400
    }
  ],
  "generation_configuration": {
    "type": "traces",
    "sample_level": "conversation",
    "generate_test_case_description": true,
    "model_options": {
      "model": "gpt-4.1"
    },
    "max_samples": 10
  }
}
```

```http
HTTP/1.1 201 Created
Operation-Location: https://travel-foundry.services.ai.azure.com/api/projects/travel/data_generation_jobs/dgj-descriptions?api-version=v1
Location: https://travel-foundry.services.ai.azure.com/api/projects/travel/data_generation_jobs/dgj-descriptions?api-version=v1
```

<!-- trace-generation-example: description-response -->

```json
{
  "id": "dgj-descriptions",
  "name": "travel-support-described-conversations",
  "scenario": "evaluation",
  "sources": [
    {
      "type": "traces",
      "agent_name": "travel-support-agent",
      "start_time": 1792022400
    }
  ],
  "generation_configuration": {
    "type": "traces",
    "sample_level": "conversation",
    "generate_test_case_description": true,
    "model_options": {
      "model": "gpt-4.1"
    },
    "max_samples": 10
  },
  "status": "queued",
  "created_at": 1792108800
}
```

### Conversation request with rubric generation

Rubric generation uses the existing model options independently of optional
test-case description generation.

```http
POST /data_generation_jobs?api-version=v1
Content-Type: application/json
Foundry-Features: DataGenerationJobs=V1Preview
```

<!-- trace-generation-example: rubric-request -->

```json
{
  "name": "travel-support-rubric-conversations",
  "scenario": "evaluation",
  "sources": [
    {
      "type": "traces",
      "agent_name": "travel-support-agent",
      "start_time": 1792022400
    }
  ],
  "generation_configuration": {
    "type": "traces",
    "sample_level": "conversation",
    "generate_test_case_rubric_preview": true,
    "model_options": {
      "model": "gpt-4.1"
    },
    "max_samples": 10
  }
}
```

### Completed conversation job with an incomplete-description warning

```http
GET /data_generation_jobs/dgj-descriptions?api-version=v1
```

```http
HTTP/1.1 200 OK
```

<!-- trace-generation-example: warning-response -->

```json
{
  "id": "dgj-descriptions",
  "name": "travel-support-described-conversations",
  "scenario": "evaluation",
  "sources": [
    {
      "type": "traces",
      "agent_name": "travel-support-agent",
      "start_time": 1792022400
    }
  ],
  "generation_configuration": {
    "type": "traces",
    "sample_level": "conversation",
    "generate_test_case_description": true,
    "model_options": {
      "model": "gpt-4.1"
    },
    "max_samples": 10
  },
  "status": "succeeded",
  "created_at": 1792108800,
  "finished_at": 1792108920,
  "result": {
    "generated_samples": 10,
    "outputs": [
      {
        "type": "dataset",
        "name": "travel-support-conversations",
        "version": "1"
      }
    ],
    "warnings": [
      {
        "code": "TestCaseDescriptionGenerationIncomplete",
        "message": "Conversation rows were retained, but one or more optional test-case descriptions could not be generated."
      }
    ]
  }
}
```

The warning is nonfatal: usable conversation rows were produced even though some
optional descriptions failed.

## Emitting Python code

Please do not emit SDKs in the public Python repo. SDK originated from TypeSpec that is private should not be pushed into a branch in a public GitHub repo.

If you want to emit Python SDK from latest TypeSpec in this folder do the following:

- In repo `azure-sdk-for-python-pr`, create a topic branch off branch `feature/azure-ai-projects/2.0.0b1`. This means you get the changes to emitter tool files that define additional dependency on a package that contains new TypeSpec decorators. You will also get all the added hand-written code (in `_patch.py` files).
- cd `sdk\ai\azure-ai-projects`
- Emit using
  - `tsp-client update --local-spec-repo <path>` where "path" is your local path to the private TypeSpec project folder, or
  - `tsp-client update` to use the TypeSpec commit mentioned in the local tsp-location.yaml file
- After the code was emitted, run the script `post-emitter-fixes.cmd`
- To review your changes, send a PR for merging your topic branch into branch `feature/azure-ai-projects/2.0.0b1`
