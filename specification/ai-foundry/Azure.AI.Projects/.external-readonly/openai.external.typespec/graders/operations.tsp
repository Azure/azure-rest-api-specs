import "@typespec/http";
import "@typespec/openapi";
import "./models.tsp";
using TypeSpec.Http;
using TypeSpec.OpenAPI;
namespace OpenAI;
/** Run a grader. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@summary("Run grader")
@post
@route("/fine_tuning/alpha/graders/run")
@extension(
  "x-oaiMeta",
  #{
    name: "Run grader",
    beta: true,
    group: "graders",
    returns: "The results from the grader run.",
    examples: #{
      response: "{\n  \"reward\": 1.0,\n  \"metadata\": {\n    \"name\": \"Example score model grader\",\n    \"type\": \"score_model\",\n    \"errors\": {\n      \"formula_parse_error\": false,\n      \"sample_parse_error\": false,\n      \"truncated_observation_error\": false,\n      \"unresponsive_reward_error\": false,\n      \"invalid_variable_error\": false,\n      \"other_error\": false,\n      \"python_grader_server_error\": false,\n      \"python_grader_server_error_type\": null,\n      \"python_grader_runtime_error\": false,\n      \"python_grader_runtime_error_details\": null,\n      \"model_grader_server_error\": false,\n      \"model_grader_refusal_error\": false,\n      \"model_grader_parse_error\": false,\n      \"model_grader_server_error_details\": null\n    },\n    \"execution_time\": 4.365238428115845,\n    \"scores\": {},\n    \"token_usage\": {\n      \"prompt_tokens\": 190,\n      \"total_tokens\": 324,\n      \"completion_tokens\": 134,\n      \"cached_tokens\": 0\n    },\n    \"sampled_model_name\": \"gpt-4o-2024-08-06\"\n  },\n  \"sub_rewards\": {},\n  \"model_grader_token_usage_per_model\": {\n    \"gpt-4o-2024-08-06\": {\n      \"prompt_tokens\": 190,\n      \"total_tokens\": 324,\n      \"completion_tokens\": 134,\n      \"cached_tokens\": 0\n    }\n  }\n}\n",
      request: #{
        curl: "curl -X POST https://api.openai.com/v1/fine_tuning/alpha/graders/run \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -d '{\n    \"grader\": {\n      \"type\": \"score_model\",\n      \"name\": \"Example score model grader\",\n      \"input\": [\n        {\n          \"role\": \"user\",\n          \"content\": \"Score how close the reference answer is to the model\nanswer. Score 1.0 if they are the same and 0.0 if they are different. Return just a floating point score\\n\\nReference answer: {{item.reference_answer}}\\n\\nModel answer: {{sample.output_text}}\"\n        }\n      ],\n      \"model\": \"gpt-4o-2024-08-06\",\n      \"sampling_params\": {\n        \"temperature\": 1,\n        \"top_p\": 1,\n        \"seed\": 42\n      }\n    },\n    \"item\": {\n      \"reference_answer\": \"fuzzy wuzzy was a bear\"\n    },\n    \"model_sample\": \"fuzzy wuzzy was a bear\"\n  }'\n",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst response = await client.fineTuning.alpha.graders.run({\n  grader: { input: 'input', name: 'name', operation: 'eq', reference: 'reference', type: 'string_check' },\n  model_sample: 'model_sample',\n});\n\nconsole.log(response.metadata);",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nresponse = client.fine_tuning.alpha.graders.run(\n    grader={\n        \"input\": \"input\",\n        \"name\": \"name\",\n        \"operation\": \"eq\",\n        \"reference\": \"reference\",\n        \"type\": \"string_check\",\n    },\n    model_sample=\"model_sample\",\n)\nprint(response.metadata)",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  response, err := client.FineTuning.Alpha.Graders.Run(context.TODO(), openai.FineTuningAlphaGraderRunParams{\n    Grader: openai.FineTuningAlphaGraderRunParamsGraderUnion{\n      OfStringCheck: &openai.StringCheckGraderParam{\n        Input: \"input\",\n        Name: \"name\",\n        Operation: openai.StringCheckGraderOperationEq,\n        Reference: \"reference\",\n      },\n    },\n    ModelSample: \"model_sample\",\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", response.Metadata)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.finetuning.alpha.graders.GraderRunParams;\nimport com.openai.models.finetuning.alpha.graders.GraderRunResponse;\nimport com.openai.models.graders.gradermodels.StringCheckGrader;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        GraderRunParams params = GraderRunParams.builder()\n            .grader(StringCheckGrader.builder()\n                .input(\"input\")\n                .name(\"name\")\n                .operation(StringCheckGrader.Operation.EQ)\n                .reference(\"reference\")\n                .build())\n            .modelSample(\"model_sample\")\n            .build();\n        GraderRunResponse response = client.fineTuning().alpha().graders().run(params);\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nresponse = openai.fine_tuning.alpha.graders.run(\n  grader: {input: \"input\", name: \"name\", operation: :eq, reference: \"reference\", type: :string_check},\n  model_sample: \"model_sample\"\n)\n\nputs(response)",
      },
    },
  }
)
@tag("Fine-tuning")
op runGrader(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  @body
  body: RunGraderRequest,
): RunGraderResponse;

/** Validate a grader. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@summary("Validate grader")
@post
@route("/fine_tuning/alpha/graders/validate")
@extension(
  "x-oaiMeta",
  #{
    name: "Validate grader",
    beta: true,
    group: "graders",
    returns: "The validated grader object.",
    examples: #{
      response: "{\n  \"grader\": {\n    \"type\": \"string_check\",\n    \"name\": \"Example string check grader\",\n    \"input\": \"{{sample.output_text}}\",\n    \"reference\": \"{{item.label}}\",\n    \"operation\": \"eq\"\n  }\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/fine_tuning/alpha/graders/validate \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -d '{\n    \"grader\": {\n      \"type\": \"string_check\",\n      \"name\": \"Example string check grader\",\n      \"input\": \"{{sample.output_text}}\",\n      \"reference\": \"{{item.label}}\",\n      \"operation\": \"eq\"\n    }\n  }'\n",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst response = await client.fineTuning.alpha.graders.validate({\n  grader: { input: 'input', name: 'name', operation: 'eq', reference: 'reference', type: 'string_check' },\n});\n\nconsole.log(response.grader);",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nresponse = client.fine_tuning.alpha.graders.validate(\n    grader={\n        \"input\": \"input\",\n        \"name\": \"name\",\n        \"operation\": \"eq\",\n        \"reference\": \"reference\",\n        \"type\": \"string_check\",\n    },\n)\nprint(response.grader)",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  response, err := client.FineTuning.Alpha.Graders.Validate(context.TODO(), openai.FineTuningAlphaGraderValidateParams{\n    Grader: openai.FineTuningAlphaGraderValidateParamsGraderUnion{\n      OfStringCheckGrader: &openai.StringCheckGraderParam{\n        Input: \"input\",\n        Name: \"name\",\n        Operation: openai.StringCheckGraderOperationEq,\n        Reference: \"reference\",\n      },\n    },\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", response.Grader)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.finetuning.alpha.graders.GraderValidateParams;\nimport com.openai.models.finetuning.alpha.graders.GraderValidateResponse;\nimport com.openai.models.graders.gradermodels.StringCheckGrader;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        GraderValidateParams params = GraderValidateParams.builder()\n            .grader(StringCheckGrader.builder()\n                .input(\"input\")\n                .name(\"name\")\n                .operation(StringCheckGrader.Operation.EQ)\n                .reference(\"reference\")\n                .build())\n            .build();\n        GraderValidateResponse response = client.fineTuning().alpha().graders().validate(params);\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nresponse = openai.fine_tuning.alpha.graders.validate(\n  grader: {input: \"input\", name: \"name\", operation: :eq, reference: \"reference\", type: :string_check}\n)\n\nputs(response)",
      },
    },
  }
)
@tag("Fine-tuning")
op validateGrader(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  @body
  body: ValidateGraderRequest,
): ValidateGraderResponse;
