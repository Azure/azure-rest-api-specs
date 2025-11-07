import "@typespec/http";
import "@typespec/openapi";
import "./models.tsp";
import "../common/models.tsp";
using TypeSpec.Http;
using TypeSpec.OpenAPI;
namespace OpenAI;
/** List evaluations for a project. */
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@summary("List evals")
@get
@route("/evals")
@extension(
  "x-oaiMeta",
  #{
    name: "List evals",
    group: "evals",
    returns: "A list of [evals](https://platform.openai.com/docs/api-reference/evals/object) matching the specified filters.",
    path: "list",
    examples: #{
      response: "{\n  \"object\": \"list\",\n  \"data\": [\n    {\n      \"id\": \"eval_67abd54d9b0081909a86353f6fb9317a\",\n      \"object\": \"eval\",\n      \"data_source_config\": {\n        \"type\": \"stored_completions\",\n        \"metadata\": {\n          \"usecase\": \"push_notifications_summarizer\"\n        },\n        \"schema\": {\n          \"type\": \"object\",\n          \"properties\": {\n            \"item\": {\n              \"type\": \"object\"\n            },\n            \"sample\": {\n              \"type\": \"object\"\n            }\n          },\n          \"required\": [\n            \"item\",\n            \"sample\"\n          ]\n        }\n      },\n      \"testing_criteria\": [\n        {\n          \"name\": \"Push Notification Summary Grader\",\n          \"id\": \"Push Notification Summary Grader-9b876f24-4762-4be9-aff4-db7a9b31c673\",\n          \"type\": \"label_model\",\n          \"model\": \"o3-mini\",\n          \"input\": [\n            {\n              \"type\": \"message\",\n              \"role\": \"developer\",\n              \"content\": {\n                \"type\": \"input_text\",\n                \"text\": \"\\nLabel the following push notification summary as either correct or incorrect.\\nThe push notification and the summary will be provided below.\\nA good push notificiation summary is concise and snappy.\\nIf it is good, then label it as correct, if not, then incorrect.\\n\"\n              }\n            },\n            {\n              \"type\": \"message\",\n              \"role\": \"user\",\n              \"content\": {\n                \"type\": \"input_text\",\n                \"text\": \"\\nPush notifications: {{item.input}}\\nSummary: {{sample.output_text}}\\n\"\n              }\n            }\n          ],\n          \"passing_labels\": [\n            \"correct\"\n          ],\n          \"labels\": [\n            \"correct\",\n            \"incorrect\"\n          ],\n          \"sampling_params\": null\n        }\n      ],\n      \"name\": \"Push Notification Summary Grader\",\n      \"created_at\": 1739314509,\n      \"metadata\": {\n        \"description\": \"A stored completions eval for push notification summaries\"\n      }\n    }\n  ],\n  \"first_id\": \"eval_67abd54d9b0081909a86353f6fb9317a\",\n  \"last_id\": \"eval_67aa884cf6688190b58f657d4441c8b7\",\n  \"has_more\": true\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/evals?limit=1 \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\"\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\npage = client.evals.list()\npage = page.data[0]\nprint(page.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\n// Automatically fetches more pages as needed.\nfor await (const evalListResponse of client.evals.list()) {\n  console.log(evalListResponse.id);\n}",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.evals.EvalListPage;\nimport com.openai.models.evals.EvalListParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        EvalListPage page = client.evals().list();\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\npage = openai.evals.list\n\nputs(page)",
      },
    },
  }
)
@tag("Evals")
op listEvals(
  /** Identifier for the last eval from the previous pagination request. */
  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "Auto-suppressed warnings non-applicable rules during import."
  @query(#{ explode: true })
  after?: string,

  /** Number of evals to retrieve. */
  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "Auto-suppressed warnings non-applicable rules during import."
  @query(#{ explode: true })
  limit?: integer = 20,

  /** Sort order for evals by timestamp. Use `asc` for ascending order or `desc` for descending order. */
  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  @query(#{ explode: true })
  order?: "asc" | "desc" = "asc",

  /**Evals can be ordered by creation time or last updated time. Use
`created_at` for creation time or `updated_at` for last updated time.*/
  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  @query(#{ explode: true })
  order_by?: "created_at" | "updated_at" = "created_at",
): EvalList;

/**Create the structure of an evaluation that can be used to test a model's performance.
An evaluation is a set of testing criteria and the config for a data source, which dictates the schema of the data used in the evaluation. After creating an evaluation, you can run it on different models and model parameters. We support several types of graders and datasources.
For more information, see the [Evals guide](https://platform.openai.com/docs/guides/evals).*/
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@summary("Create eval")
@post
@route("/evals")
@extension(
  "x-oaiMeta",
  #{
    name: "Create eval",
    group: "evals",
    returns: "The created [Eval](https://platform.openai.com/docs/api-reference/evals/object) object.",
    path: "post",
    examples: #{
      response: "{\n  \"object\": \"eval\",\n  \"id\": \"eval_67b7fa9a81a88190ab4aa417e397ea21\",\n  \"data_source_config\": {\n    \"type\": \"stored_completions\",\n    \"metadata\": {\n      \"usecase\": \"chatbot\"\n    },\n    \"schema\": {\n      \"type\": \"object\",\n      \"properties\": {\n        \"item\": {\n          \"type\": \"object\"\n        },\n        \"sample\": {\n          \"type\": \"object\"\n        }\n      },\n      \"required\": [\n        \"item\",\n        \"sample\"\n      ]\n  },\n  \"testing_criteria\": [\n    {\n      \"name\": \"Example label grader\",\n      \"type\": \"label_model\",\n      \"model\": \"o3-mini\",\n      \"input\": [\n        {\n          \"type\": \"message\",\n          \"role\": \"developer\",\n          \"content\": {\n            \"type\": \"input_text\",\n            \"text\": \"Classify the sentiment of the following statement as one of positive, neutral, or negative\"\n          }\n        },\n        {\n          \"type\": \"message\",\n          \"role\": \"user\",\n          \"content\": {\n            \"type\": \"input_text\",\n            \"text\": \"Statement: {{item.input}}\"\n          }\n        }\n      ],\n      \"passing_labels\": [\n        \"positive\"\n      ],\n      \"labels\": [\n        \"positive\",\n        \"neutral\",\n        \"negative\"\n      ]\n    }\n  ],\n  \"name\": \"Sentiment\",\n  \"created_at\": 1740110490,\n  \"metadata\": {\n    \"description\": \"An eval for sentiment analysis\"\n  }\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/evals \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -d '{\n        \"name\": \"Sentiment\",\n        \"data_source_config\": {\n          \"type\": \"stored_completions\",\n          \"metadata\": {\n              \"usecase\": \"chatbot\"\n          }\n        },\n        \"testing_criteria\": [\n          {\n            \"type\": \"label_model\",\n            \"model\": \"o3-mini\",\n            \"input\": [\n              {\n                \"role\": \"developer\",\n                \"content\": \"Classify the sentiment of the following statement as one of 'positive', 'neutral', or 'negative'\"\n              },\n              {\n                \"role\": \"user\",\n                \"content\": \"Statement: {{item.input}}\"\n              }\n            ],\n            \"passing_labels\": [\n              \"positive\"\n            ],\n            \"labels\": [\n              \"positive\",\n              \"neutral\",\n              \"negative\"\n            ],\n            \"name\": \"Example label grader\"\n          }\n        ]\n      }'\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\neval = client.evals.create(\n    data_source_config={\n        \"item_schema\": {\n            \"foo\": \"bar\"\n        },\n        \"type\": \"custom\",\n    },\n    testing_criteria=[{\n        \"input\": [{\n            \"content\": \"content\",\n            \"role\": \"role\",\n        }],\n        \"labels\": [\"string\"],\n        \"model\": \"model\",\n        \"name\": \"name\",\n        \"passing_labels\": [\"string\"],\n        \"type\": \"label_model\",\n    }],\n)\nprint(eval.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst _eval = await client.evals.create({\n  data_source_config: { item_schema: { foo: 'bar' }, type: 'custom' },\n  testing_criteria: [\n    {\n      input: [{ content: 'content', role: 'role' }],\n      labels: ['string'],\n      model: 'model',\n      name: 'name',\n      passing_labels: ['string'],\n      type: 'label_model',\n    },\n  ],\n});\n\nconsole.log(_eval.id);",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.core.JsonValue;\nimport com.openai.models.evals.EvalCreateParams;\nimport com.openai.models.evals.EvalCreateResponse;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        EvalCreateParams params = EvalCreateParams.builder()\n            .customDataSourceConfig(EvalCreateParams.DataSourceConfig.Custom.ItemSchema.builder()\n                .putAdditionalProperty(\"foo\", JsonValue.from(\"bar\"))\n                .build())\n            .addTestingCriterion(EvalCreateParams.TestingCriterion.LabelModel.builder()\n                .addInput(EvalCreateParams.TestingCriterion.LabelModel.Input.SimpleInputMessage.builder()\n                    .content(\"content\")\n                    .role(\"role\")\n                    .build())\n                .addLabel(\"string\")\n                .model(\"model\")\n                .name(\"name\")\n                .addPassingLabel(\"string\")\n                .build())\n            .build();\n        EvalCreateResponse eval = client.evals().create(params);\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\neval_ = openai.evals.create(\n  data_source_config: {item_schema: {foo: \"bar\"}, type: :custom},\n  testing_criteria: [\n    {\n      input: [{content: \"content\", role: \"role\"}],\n      labels: [\"string\"],\n      model: \"model\",\n      name: \"name\",\n      passing_labels: [\"string\"],\n      type: :label_model\n    }\n  ]\n)\n\nputs(eval_)",
      },
    },
  }
)
@tag("Evals")
op createEval(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  @body
  body: CreateEvalRequest,
): {
  ...CreatedResponse;
  ...Eval;
};

/** Delete an evaluation. */
#suppress "@azure-tools/typespec-azure-core/response-schema-problem" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@summary("Delete an eval")
@delete
@route("/evals/{eval_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Delete an eval",
    group: "evals",
    returns: "A deletion confirmation object.",
    examples: #{
      response: "{\n  \"object\": \"eval.deleted\",\n  \"deleted\": true,\n  \"eval_id\": \"eval_abc123\"\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/evals/eval_abc123 \\\n  -X DELETE \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\"\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\neval = client.evals.delete(\n    \"eval_id\",\n)\nprint(eval.eval_id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst _eval = await client.evals.delete('eval_id');\n\nconsole.log(_eval.eval_id);",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.evals.EvalDeleteParams;\nimport com.openai.models.evals.EvalDeleteResponse;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        EvalDeleteResponse eval = client.evals().delete(\"eval_id\");\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\neval_ = openai.evals.delete(\"eval_id\")\n\nputs(eval_)",
      },
    },
  }
)
@tag("Evals")
op deleteEval(
  /** The ID of the evaluation to delete. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  @path
  eval_id: string,
): Body<{
  object: string;
  deleted: boolean;
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  eval_id: string;
}> | {
  ...NotFoundResponse;
  ...Error;
};

/** Get an evaluation by ID. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@summary("Get an eval")
@get
@route("/evals/{eval_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Get an eval",
    group: "evals",
    returns: "The [Eval](https://platform.openai.com/docs/api-reference/evals/object) object matching the specified ID.",
    path: "get",
    examples: #{
      response: "{\n  \"object\": \"eval\",\n  \"id\": \"eval_67abd54d9b0081909a86353f6fb9317a\",\n  \"data_source_config\": {\n    \"type\": \"custom\",\n    \"schema\": {\n      \"type\": \"object\",\n      \"properties\": {\n        \"item\": {\n          \"type\": \"object\",\n          \"properties\": {\n            \"input\": {\n              \"type\": \"string\"\n            },\n            \"ground_truth\": {\n              \"type\": \"string\"\n            }\n          },\n          \"required\": [\n            \"input\",\n            \"ground_truth\"\n          ]\n        }\n      },\n      \"required\": [\n        \"item\"\n      ]\n    }\n  },\n  \"testing_criteria\": [\n    {\n      \"name\": \"String check\",\n      \"id\": \"String check-2eaf2d8d-d649-4335-8148-9535a7ca73c2\",\n      \"type\": \"string_check\",\n      \"input\": \"{{item.input}}\",\n      \"reference\": \"{{item.ground_truth}}\",\n      \"operation\": \"eq\"\n    }\n  ],\n  \"name\": \"External Data Eval\",\n  \"created_at\": 1739314509,\n  \"metadata\": {},\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/evals/eval_67abd54d9b0081909a86353f6fb9317a \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\"\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\neval = client.evals.retrieve(\n    \"eval_id\",\n)\nprint(eval.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst _eval = await client.evals.retrieve('eval_id');\n\nconsole.log(_eval.id);",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.evals.EvalRetrieveParams;\nimport com.openai.models.evals.EvalRetrieveResponse;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        EvalRetrieveResponse eval = client.evals().retrieve(\"eval_id\");\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\neval_ = openai.evals.retrieve(\"eval_id\")\n\nputs(eval_)",
      },
    },
  }
)
@tag("Evals")
op getEval(
  /** The ID of the evaluation to retrieve. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  @path
  eval_id: string,
): Eval;

/** Update certain properties of an evaluation. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@summary("Update an eval")
@post
@route("/evals/{eval_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Update an eval",
    group: "evals",
    returns: "The [Eval](https://platform.openai.com/docs/api-reference/evals/object) object matching the updated version.",
    path: "update",
    examples: #{
      response: "{\n  \"object\": \"eval\",\n  \"id\": \"eval_67abd54d9b0081909a86353f6fb9317a\",\n  \"data_source_config\": {\n    \"type\": \"custom\",\n    \"schema\": {\n      \"type\": \"object\",\n      \"properties\": {\n        \"item\": {\n          \"type\": \"object\",\n          \"properties\": {\n            \"input\": {\n              \"type\": \"string\"\n            },\n            \"ground_truth\": {\n              \"type\": \"string\"\n            }\n          },\n          \"required\": [\n            \"input\",\n            \"ground_truth\"\n          ]\n        }\n      },\n      \"required\": [\n        \"item\"\n      ]\n    }\n  },\n  \"testing_criteria\": [\n    {\n      \"name\": \"String check\",\n      \"id\": \"String check-2eaf2d8d-d649-4335-8148-9535a7ca73c2\",\n      \"type\": \"string_check\",\n      \"input\": \"{{item.input}}\",\n      \"reference\": \"{{item.ground_truth}}\",\n      \"operation\": \"eq\"\n    }\n  ],\n  \"name\": \"Updated Eval\",\n  \"created_at\": 1739314509,\n  \"metadata\": {\"description\": \"Updated description\"},\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/evals/eval_67abd54d9b0081909a86353f6fb9317a \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -d '{\"name\": \"Updated Eval\", \"metadata\": {\"description\": \"Updated description\"}}'\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\neval = client.evals.update(\n    eval_id=\"eval_id\",\n)\nprint(eval.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst _eval = await client.evals.update('eval_id');\n\nconsole.log(_eval.id);",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.evals.EvalUpdateParams;\nimport com.openai.models.evals.EvalUpdateResponse;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        EvalUpdateResponse eval = client.evals().update(\"eval_id\");\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\neval_ = openai.evals.update(\"eval_id\")\n\nputs(eval_)",
      },
    },
  }
)
@tag("Evals")
op updateEval(
  /** The ID of the evaluation to update. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  @path
  eval_id: string,

  /** Request to update an evaluation */
  @body
  body: UpdateEvalParametersBody,
): Eval;

/** Get a list of runs for an evaluation. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@summary("Get eval runs")
@get
@route("/evals/{eval_id}/runs")
@extension(
  "x-oaiMeta",
  #{
    name: "Get eval runs",
    group: "evals",
    returns: "A list of [EvalRun](https://platform.openai.com/docs/api-reference/evals/run-object) objects matching the specified ID.",
    path: "get-runs",
    examples: #{
      response: "{\n  \"object\": \"list\",\n  \"data\": [\n    {\n      \"object\": \"eval.run\",\n      \"id\": \"evalrun_67e0c7d31560819090d60c0780591042\",\n      \"eval_id\": \"eval_67e0c726d560819083f19a957c4c640b\",\n      \"report_url\": \"https://platform.openai.com/evaluations/eval_67e0c726d560819083f19a957c4c640b\",\n      \"status\": \"completed\",\n      \"model\": \"o3-mini\",\n      \"name\": \"bulk_with_negative_examples_o3-mini\",\n      \"created_at\": 1742784467,\n      \"result_counts\": {\n        \"total\": 1,\n        \"errored\": 0,\n        \"failed\": 0,\n        \"passed\": 1\n      },\n      \"per_model_usage\": [\n        {\n          \"model_name\": \"o3-mini\",\n          \"invocation_count\": 1,\n          \"prompt_tokens\": 563,\n          \"completion_tokens\": 874,\n          \"total_tokens\": 1437,\n          \"cached_tokens\": 0\n        }\n      ],\n      \"per_testing_criteria_results\": [\n        {\n          \"testing_criteria\": \"Push Notification Summary Grader-1808cd0b-eeec-4e0b-a519-337e79f4f5d1\",\n          \"passed\": 1,\n          \"failed\": 0\n        }\n      ],\n      \"data_source\": {\n        \"type\": \"completions\",\n        \"source\": {\n          \"type\": \"file_content\",\n          \"content\": [\n            {\n              \"item\": {\n                \"notifications\": \"\\n- New message from Sarah: \\\"Can you call me later?\\\"\\n- Your package has been delivered!\\n- Flash sale: 20% off electronics for the next 2 hours!\\n\"\n              }\n            }\n          ]\n        },\n        \"input_messages\": {\n          \"type\": \"template\",\n          \"template\": [\n            {\n              \"type\": \"message\",\n              \"role\": \"developer\",\n              \"content\": {\n                \"type\": \"input_text\",\n                \"text\": \"\\n\\n\\n\\nYou are a helpful assistant that takes in an array of push notifications and returns a collapsed summary of them.\\nThe push notification will be provided as follows:\\n<push_notifications>\\n...notificationlist...\\n</push_notifications>\\n\\nYou should return just the summary and nothing else.\\n\\n\\nYou should return a summary that is concise and snappy.\\n\\n\\nHere is an example of a good summary:\\n<push_notifications>\\n- Traffic alert: Accident reported on Main Street.- Package out for delivery: Expected by 5 PM.- New friend suggestion: Connect with Emma.\\n</push_notifications>\\n<summary>\\nTraffic alert, package expected by 5pm, suggestion for new friend (Emily).\\n</summary>\\n\\n\\nHere is an example of a bad summary:\\n<push_notifications>\\n- Traffic alert: Accident reported on Main Street.- Package out for delivery: Expected by 5 PM.- New friend suggestion: Connect with Emma.\\n</push_notifications>\\n<summary>\\nTraffic alert reported on main street. You have a package that will arrive by 5pm, Emily is a new friend suggested for you.\\n</summary>\\n\"\n              }\n            },\n            {\n              \"type\": \"message\",\n              \"role\": \"user\",\n              \"content\": {\n                \"type\": \"input_text\",\n                \"text\": \"<push_notifications>{{item.notifications}}</push_notifications>\"\n              }\n            }\n          ]\n        },\n        \"model\": \"o3-mini\",\n        \"sampling_params\": null\n      },\n      \"error\": null,\n      \"metadata\": {}\n    }\n  ],\n  \"first_id\": \"evalrun_67e0c7d31560819090d60c0780591042\",\n  \"last_id\": \"evalrun_67e0c7d31560819090d60c0780591042\",\n  \"has_more\": true\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/evals/egroup_67abd54d9b0081909a86353f6fb9317a/runs \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\"\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\npage = client.evals.runs.list(\n    eval_id=\"eval_id\",\n)\npage = page.data[0]\nprint(page.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\n// Automatically fetches more pages as needed.\nfor await (const runListResponse of client.evals.runs.list('eval_id')) {\n  console.log(runListResponse.id);\n}",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.evals.runs.RunListPage;\nimport com.openai.models.evals.runs.RunListParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        RunListPage page = client.evals().runs().list(\"eval_id\");\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\npage = openai.evals.runs.list(\"eval_id\")\n\nputs(page)",
      },
    },
  }
)
@tag("Evals")
op getEvalRuns(
  /** The ID of the evaluation to retrieve runs for. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  @path
  eval_id: string,

  /** Identifier for the last run from the previous pagination request. */
  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "Auto-suppressed warnings non-applicable rules during import."
  @query(#{ explode: true })
  after?: string,

  /** Number of runs to retrieve. */
  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "Auto-suppressed warnings non-applicable rules during import."
  @query(#{ explode: true })
  limit?: integer = 20,

  /** Sort order for runs by timestamp. Use `asc` for ascending order or `desc` for descending order. Defaults to `asc`. */
  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  @query(#{ explode: true })
  order?: "asc" | "desc" = "asc",

  /** Filter runs by status. One of `queued` | `in_progress` | `failed` | `completed` | `canceled`. */
  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  @query(#{ explode: true })
  status?: "queued" | "in_progress" | "completed" | "canceled" | "failed",
): EvalRunList;

/** Kicks off a new run for a given evaluation, specifying the data source, and what model configuration to use to test. The datasource will be validated against the schema specified in the config of the evaluation. */
#suppress "@azure-tools/typespec-azure-core/response-schema-problem" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@summary("Create eval run")
@post
@route("/evals/{eval_id}/runs")
@extension(
  "x-oaiMeta",
  #{
    name: "Create eval run",
    group: "evals",
    returns: "The [EvalRun](https://platform.openai.com/docs/api-reference/evals/run-object) object matching the specified ID.",
    examples: #{
      response: "{\n  \"object\": \"eval.run\",\n  \"id\": \"evalrun_67e57965b480819094274e3a32235e4c\",\n  \"eval_id\": \"eval_67e579652b548190aaa83ada4b125f47\",\n  \"report_url\": \"https://platform.openai.com/evaluations/eval_67e579652b548190aaa83ada4b125f47&run_id=evalrun_67e57965b480819094274e3a32235e4c\",\n  \"status\": \"queued\",\n  \"model\": \"gpt-4o-mini\",\n  \"name\": \"gpt-4o-mini\",\n  \"created_at\": 1743092069,\n  \"result_counts\": {\n    \"total\": 0,\n    \"errored\": 0,\n    \"failed\": 0,\n    \"passed\": 0\n  },\n  \"per_model_usage\": null,\n  \"per_testing_criteria_results\": null,\n  \"data_source\": {\n    \"type\": \"completions\",\n    \"source\": {\n      \"type\": \"file_content\",\n      \"content\": [\n        {\n          \"item\": {\n            \"input\": \"Tech Company Launches Advanced Artificial Intelligence Platform\",\n            \"ground_truth\": \"Technology\"\n          }\n        }\n      ]\n    },\n    \"input_messages\": {\n      \"type\": \"template\",\n      \"template\": [\n        {\n          \"type\": \"message\",\n          \"role\": \"developer\",\n          \"content\": {\n            \"type\": \"input_text\",\n            \"text\": \"Categorize a given news headline into one of the following topics: Technology, Markets, World, Business, or Sports.\\n\\n# Steps\\n\\n1. Analyze the content of the news headline to understand its primary focus.\\n2. Extract the subject matter, identifying any key indicators or keywords.\\n3. Use the identified indicators to determine the most suitable category out of the five options: Technology, Markets, World, Business, or Sports.\\n4. Ensure only one category is selected per headline.\\n\\n# Output Format\\n\\nRespond with the chosen category as a single word. For instance: \\\"Technology\\\", \\\"Markets\\\", \\\"World\\\", \\\"Business\\\", or \\\"Sports\\\".\\n\\n# Examples\\n\\n**Input**: \\\"Apple Unveils New iPhone Model, Featuring Advanced AI Features\\\"  \\n**Output**: \\\"Technology\\\"\\n\\n**Input**: \\\"Global Stocks Mixed as Investors Await Central Bank Decisions\\\"  \\n**Output**: \\\"Markets\\\"\\n\\n**Input**: \\\"War in Ukraine: Latest Updates on Negotiation Status\\\"  \\n**Output**: \\\"World\\\"\\n\\n**Input**: \\\"Microsoft in Talks to Acquire Gaming Company for $2 Billion\\\"  \\n**Output**: \\\"Business\\\"\\n\\n**Input**: \\\"Manchester United Secures Win in Premier League Football Match\\\"  \\n**Output**: \\\"Sports\\\" \\n\\n# Notes\\n\\n- If the headline appears to fit into more than one category, choose the most dominant theme.\\n- Keywords or phrases such as \\\"stocks\\\", \\\"company acquisition\\\", \\\"match\\\", or technological brands can be good indicators for classification.\\n\"\n          }\n        },\n        {\n          \"type\": \"message\",\n          \"role\": \"user\",\n          \"content\": {\n            \"type\": \"input_text\",\n            \"text\": \"{{item.input}}\"\n          }\n        }\n      ]\n    },\n    \"model\": \"gpt-4o-mini\",\n    \"sampling_params\": {\n      \"seed\": 42,\n      \"temperature\": 1.0,\n      \"top_p\": 1.0,\n      \"max_completions_tokens\": 2048\n    }\n  },\n  \"error\": null,\n  \"metadata\": {}\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/evals/eval_67e579652b548190aaa83ada4b125f47/runs \\\n  -X POST \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -d '{\"name\":\"gpt-4o-mini\",\"data_source\":{\"type\":\"completions\",\"input_messages\":{\"type\":\"template\",\"template\":[{\"role\":\"developer\",\"content\":\"Categorize a given news headline into one of the following topics: Technology, Markets, World, Business, or Sports.\\n\\n# Steps\\n\\n1. Analyze the content of the news headline to understand its primary focus.\\n2. Extract the subject matter, identifying any key indicators or keywords.\\n3. Use the identified indicators to determine the most suitable category out of the five options: Technology, Markets, World, Business, or Sports.\\n4. Ensure only one category is selected per headline.\\n\\n# Output Format\\n\\nRespond with the chosen category as a single word. For instance: \\\"Technology\\\", \\\"Markets\\\", \\\"World\\\", \\\"Business\\\", or \\\"Sports\\\".\\n\\n# Examples\\n\\n**Input**: \\\"Apple Unveils New iPhone Model, Featuring Advanced AI Features\\\"  \\n**Output**: \\\"Technology\\\"\\n\\n**Input**: \\\"Global Stocks Mixed as Investors Await Central Bank Decisions\\\"  \\n**Output**: \\\"Markets\\\"\\n\\n**Input**: \\\"War in Ukraine: Latest Updates on Negotiation Status\\\"  \\n**Output**: \\\"World\\\"\\n\\n**Input**: \\\"Microsoft in Talks to Acquire Gaming Company for $2 Billion\\\"  \\n**Output**: \\\"Business\\\"\\n\\n**Input**: \\\"Manchester United Secures Win in Premier League Football Match\\\"  \\n**Output**: \\\"Sports\\\" \\n\\n# Notes\\n\\n- If the headline appears to fit into more than one category, choose the most dominant theme.\\n- Keywords or phrases such as \\\"stocks\\\", \\\"company acquisition\\\", \\\"match\\\", or technological brands can be good indicators for classification.\\n\"} , {\"role\":\"user\",\"content\":\"{{item.input}}\"}]} ,\"sampling_params\":{\"temperature\":1,\"max_completions_tokens\":2048,\"top_p\":1,\"seed\":42},\"model\":\"gpt-4o-mini\",\"source\":{\"type\":\"file_content\",\"content\":[{\"item\":{\"input\":\"Tech Company Launches Advanced Artificial Intelligence Platform\",\"ground_truth\":\"Technology\"}}]}}'\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nrun = client.evals.runs.create(\n    eval_id=\"eval_id\",\n    data_source={\n        \"source\": {\n            \"content\": [{\n                \"item\": {\n                    \"foo\": \"bar\"\n                }\n            }],\n            \"type\": \"file_content\",\n        },\n        \"type\": \"jsonl\",\n    },\n)\nprint(run.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst run = await client.evals.runs.create('eval_id', {\n  data_source: { source: { content: [{ item: { foo: 'bar' } }], type: 'file_content' }, type: 'jsonl' },\n});\n\nconsole.log(run.id);",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.core.JsonValue;\nimport com.openai.models.evals.runs.CreateEvalJsonlRunDataSource;\nimport com.openai.models.evals.runs.RunCreateParams;\nimport com.openai.models.evals.runs.RunCreateResponse;\nimport java.util.List;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        RunCreateParams params = RunCreateParams.builder()\n            .evalId(\"eval_id\")\n            .dataSource(CreateEvalJsonlRunDataSource.builder()\n                .fileContentSource(List.of(CreateEvalJsonlRunDataSource.Source.FileContent.Content.builder()\n                    .item(CreateEvalJsonlRunDataSource.Source.FileContent.Content.Item.builder()\n                        .putAdditionalProperty(\"foo\", JsonValue.from(\"bar\"))\n                        .build())\n                    .build()))\n                .build())\n            .build();\n        RunCreateResponse run = client.evals().runs().create(params);\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nrun = openai.evals.runs.create(\n  \"eval_id\",\n  data_source: {source: {content: [{item: {foo: \"bar\"}}], type: :file_content}, type: :jsonl}\n)\n\nputs(run)",
      },
    },
  }
)
@tag("Evals")
op createEvalRun(
  /** The ID of the evaluation to create a run for. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  @path
  eval_id: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  @body
  body: CreateEvalRunRequest,
): {
  ...CreatedResponse;
  ...EvalRun;
} | {
  ...BadRequestResponse;
  ...Error;
};

/** Delete an eval run. */
#suppress "@azure-tools/typespec-azure-core/response-schema-problem" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@summary("Delete eval run")
@delete
@route("/evals/{eval_id}/runs/{run_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Delete eval run",
    group: "evals",
    returns: "An object containing the status of the delete operation.",
    path: "delete",
    examples: #{
      response: "{\n  \"object\": \"eval.run.deleted\",\n  \"deleted\": true,\n  \"run_id\": \"evalrun_abc456\"\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/evals/eval_123abc/runs/evalrun_abc456 \\\n  -X DELETE \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\"\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nrun = client.evals.runs.delete(\n    run_id=\"run_id\",\n    eval_id=\"eval_id\",\n)\nprint(run.run_id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst run = await client.evals.runs.delete('run_id', { eval_id: 'eval_id' });\n\nconsole.log(run.run_id);",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.evals.runs.RunDeleteParams;\nimport com.openai.models.evals.runs.RunDeleteResponse;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        RunDeleteParams params = RunDeleteParams.builder()\n            .evalId(\"eval_id\")\n            .runId(\"run_id\")\n            .build();\n        RunDeleteResponse run = client.evals().runs().delete(params);\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nrun = openai.evals.runs.delete(\"run_id\", eval_id: \"eval_id\")\n\nputs(run)",
      },
    },
  }
)
@tag("Evals")
op deleteEvalRun(
  /** The ID of the evaluation to delete the run from. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  @path
  eval_id: string,

  /** The ID of the run to delete. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  @path
  run_id: string,
): Body<{
  object?: string;
  deleted?: boolean;
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  run_id?: string;
}> | {
  ...NotFoundResponse;
  ...Error;
};

/** Get an evaluation run by ID. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@summary("Get an eval run")
@get
@route("/evals/{eval_id}/runs/{run_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Get an eval run",
    group: "evals",
    returns: "The [EvalRun](https://platform.openai.com/docs/api-reference/evals/run-object) object matching the specified ID.",
    path: "get",
    examples: #{
      response: "{\n  \"object\": \"eval.run\",\n  \"id\": \"evalrun_67abd54d60ec8190832b46859da808f7\",\n  \"eval_id\": \"eval_67abd54d9b0081909a86353f6fb9317a\",\n  \"report_url\": \"https://platform.openai.com/evaluations/eval_67abd54d9b0081909a86353f6fb9317a?run_id=evalrun_67abd54d60ec8190832b46859da808f7\",\n  \"status\": \"queued\",\n  \"model\": \"gpt-4o-mini\",\n  \"name\": \"gpt-4o-mini\",\n  \"created_at\": 1743092069,\n  \"result_counts\": {\n    \"total\": 0,\n    \"errored\": 0,\n    \"failed\": 0,\n    \"passed\": 0\n  },\n  \"per_model_usage\": null,\n  \"per_testing_criteria_results\": null,\n  \"data_source\": {\n    \"type\": \"completions\",\n    \"source\": {\n      \"type\": \"file_content\",\n      \"content\": [\n        {\n          \"item\": {\n            \"input\": \"Tech Company Launches Advanced Artificial Intelligence Platform\",\n            \"ground_truth\": \"Technology\"\n          }\n        },\n        {\n          \"item\": {\n            \"input\": \"Central Bank Increases Interest Rates Amid Inflation Concerns\",\n            \"ground_truth\": \"Markets\"\n          }\n        },\n        {\n          \"item\": {\n            \"input\": \"International Summit Addresses Climate Change Strategies\",\n            \"ground_truth\": \"World\"\n          }\n        },\n        {\n          \"item\": {\n            \"input\": \"Major Retailer Reports Record-Breaking Holiday Sales\",\n            \"ground_truth\": \"Business\"\n          }\n        },\n        {\n          \"item\": {\n            \"input\": \"National Team Qualifies for World Championship Finals\",\n            \"ground_truth\": \"Sports\"\n          }\n        },\n        {\n          \"item\": {\n            \"input\": \"Stock Markets Rally After Positive Economic Data Released\",\n            \"ground_truth\": \"Markets\"\n          }\n        },\n        {\n          \"item\": {\n            \"input\": \"Global Manufacturer Announces Merger with Competitor\",\n            \"ground_truth\": \"Business\"\n          }\n        },\n        {\n          \"item\": {\n            \"input\": \"Breakthrough in Renewable Energy Technology Unveiled\",\n            \"ground_truth\": \"Technology\"\n          }\n        },\n        {\n          \"item\": {\n            \"input\": \"World Leaders Sign Historic Climate Agreement\",\n            \"ground_truth\": \"World\"\n          }\n        },\n        {\n          \"item\": {\n            \"input\": \"Professional Athlete Sets New Record in Championship Event\",\n            \"ground_truth\": \"Sports\"\n          }\n        },\n        {\n          \"item\": {\n            \"input\": \"Financial Institutions Adapt to New Regulatory Requirements\",\n            \"ground_truth\": \"Business\"\n          }\n        },\n        {\n          \"item\": {\n            \"input\": \"Tech Conference Showcases Advances in Artificial Intelligence\",\n            \"ground_truth\": \"Technology\"\n          }\n        },\n        {\n          \"item\": {\n            \"input\": \"Global Markets Respond to Oil Price Fluctuations\",\n            \"ground_truth\": \"Markets\"\n          }\n        },\n        {\n          \"item\": {\n            \"input\": \"International Cooperation Strengthened Through New Treaty\",\n            \"ground_truth\": \"World\"\n          }\n        },\n        {\n          \"item\": {\n            \"input\": \"Sports League Announces Revised Schedule for Upcoming Season\",\n            \"ground_truth\": \"Sports\"\n          }\n        }\n      ]\n    },\n    \"input_messages\": {\n      \"type\": \"template\",\n      \"template\": [\n        {\n          \"type\": \"message\",\n          \"role\": \"developer\",\n          \"content\": {\n            \"type\": \"input_text\",\n            \"text\": \"Categorize a given news headline into one of the following topics: Technology, Markets, World, Business, or Sports.\\n\\n# Steps\\n\\n1. Analyze the content of the news headline to understand its primary focus.\\n2. Extract the subject matter, identifying any key indicators or keywords.\\n3. Use the identified indicators to determine the most suitable category out of the five options: Technology, Markets, World, Business, or Sports.\\n4. Ensure only one category is selected per headline.\\n\\n# Output Format\\n\\nRespond with the chosen category as a single word. For instance: \\\"Technology\\\", \\\"Markets\\\", \\\"World\\\", \\\"Business\\\", or \\\"Sports\\\".\\n\\n# Examples\\n\\n**Input**: \\\"Apple Unveils New iPhone Model, Featuring Advanced AI Features\\\"  \\n**Output**: \\\"Technology\\\"\\n\\n**Input**: \\\"Global Stocks Mixed as Investors Await Central Bank Decisions\\\"  \\n**Output**: \\\"Markets\\\"\\n\\n**Input**: \\\"War in Ukraine: Latest Updates on Negotiation Status\\\"  \\n**Output**: \\\"World\\\"\\n\\n**Input**: \\\"Microsoft in Talks to Acquire Gaming Company for $2 Billion\\\"  \\n**Output**: \\\"Business\\\"\\n\\n**Input**: \\\"Manchester United Secures Win in Premier League Football Match\\\"  \\n**Output**: \\\"Sports\\\" \\n\\n# Notes\\n\\n- If the headline appears to fit into more than one category, choose the most dominant theme.\\n- Keywords or phrases such as \\\"stocks\\\", \\\"company acquisition\\\", \\\"match\\\", or technological brands can be good indicators for classification.\\n\"\n          }\n        },\n        {\n          \"type\": \"message\",\n          \"role\": \"user\",\n          \"content\": {\n            \"type\": \"input_text\",\n            \"text\": \"{{item.input}}\"\n          }\n        }\n      ]\n    },\n    \"model\": \"gpt-4o-mini\",\n    \"sampling_params\": {\n      \"seed\": 42,\n      \"temperature\": 1.0,\n      \"top_p\": 1.0,\n      \"max_completions_tokens\": 2048\n    }\n  },\n  \"error\": null,\n  \"metadata\": {}\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/evals/eval_67abd54d9b0081909a86353f6fb9317a/runs/evalrun_67abd54d60ec8190832b46859da808f7 \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\"\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nrun = client.evals.runs.retrieve(\n    run_id=\"run_id\",\n    eval_id=\"eval_id\",\n)\nprint(run.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst run = await client.evals.runs.retrieve('run_id', { eval_id: 'eval_id' });\n\nconsole.log(run.id);",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.evals.runs.RunRetrieveParams;\nimport com.openai.models.evals.runs.RunRetrieveResponse;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        RunRetrieveParams params = RunRetrieveParams.builder()\n            .evalId(\"eval_id\")\n            .runId(\"run_id\")\n            .build();\n        RunRetrieveResponse run = client.evals().runs().retrieve(params);\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nrun = openai.evals.runs.retrieve(\"run_id\", eval_id: \"eval_id\")\n\nputs(run)",
      },
    },
  }
)
@tag("Evals")
op getEvalRun(
  /** The ID of the evaluation to retrieve runs for. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  @path
  eval_id: string,

  /** The ID of the run to retrieve. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  @path
  run_id: string,
): EvalRun;

/** Cancel an ongoing evaluation run. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@summary("Cancel eval run")
@post
@route("/evals/{eval_id}/runs/{run_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Cancel eval run",
    group: "evals",
    returns: "The updated [EvalRun](https://platform.openai.com/docs/api-reference/evals/run-object) object reflecting that the run is canceled.",
    path: "post",
    examples: #{
      response: "{\n  \"object\": \"eval.run\",\n  \"id\": \"evalrun_67abd54d60ec8190832b46859da808f7\",\n  \"eval_id\": \"eval_67abd54d9b0081909a86353f6fb9317a\",\n  \"report_url\": \"https://platform.openai.com/evaluations/eval_67abd54d9b0081909a86353f6fb9317a?run_id=evalrun_67abd54d60ec8190832b46859da808f7\",\n  \"status\": \"canceled\",\n  \"model\": \"gpt-4o-mini\",\n  \"name\": \"gpt-4o-mini\",\n  \"created_at\": 1743092069,\n  \"result_counts\": {\n    \"total\": 0,\n    \"errored\": 0,\n    \"failed\": 0,\n    \"passed\": 0\n  },\n  \"per_model_usage\": null,\n  \"per_testing_criteria_results\": null,\n  \"data_source\": {\n    \"type\": \"completions\",\n    \"source\": {\n      \"type\": \"file_content\",\n      \"content\": [\n        {\n          \"item\": {\n            \"input\": \"Tech Company Launches Advanced Artificial Intelligence Platform\",\n            \"ground_truth\": \"Technology\"\n          }\n        },\n        {\n          \"item\": {\n            \"input\": \"Central Bank Increases Interest Rates Amid Inflation Concerns\",\n            \"ground_truth\": \"Markets\"\n          }\n        },\n        {\n          \"item\": {\n            \"input\": \"International Summit Addresses Climate Change Strategies\",\n            \"ground_truth\": \"World\"\n          }\n        },\n        {\n          \"item\": {\n            \"input\": \"Major Retailer Reports Record-Breaking Holiday Sales\",\n            \"ground_truth\": \"Business\"\n          }\n        },\n        {\n          \"item\": {\n            \"input\": \"National Team Qualifies for World Championship Finals\",\n            \"ground_truth\": \"Sports\"\n          }\n        },\n        {\n          \"item\": {\n            \"input\": \"Stock Markets Rally After Positive Economic Data Released\",\n            \"ground_truth\": \"Markets\"\n          }\n        },\n        {\n          \"item\": {\n            \"input\": \"Global Manufacturer Announces Merger with Competitor\",\n            \"ground_truth\": \"Business\"\n          }\n        },\n        {\n          \"item\": {\n            \"input\": \"Breakthrough in Renewable Energy Technology Unveiled\",\n            \"ground_truth\": \"Technology\"\n          }\n        },\n        {\n          \"item\": {\n            \"input\": \"World Leaders Sign Historic Climate Agreement\",\n            \"ground_truth\": \"World\"\n          }\n        },\n        {\n          \"item\": {\n            \"input\": \"Professional Athlete Sets New Record in Championship Event\",\n            \"ground_truth\": \"Sports\"\n          }\n        },\n        {\n          \"item\": {\n            \"input\": \"Financial Institutions Adapt to New Regulatory Requirements\",\n            \"ground_truth\": \"Business\"\n          }\n        },\n        {\n          \"item\": {\n            \"input\": \"Tech Conference Showcases Advances in Artificial Intelligence\",\n            \"ground_truth\": \"Technology\"\n          }\n        },\n        {\n          \"item\": {\n            \"input\": \"Global Markets Respond to Oil Price Fluctuations\",\n            \"ground_truth\": \"Markets\"\n          }\n        },\n        {\n          \"item\": {\n            \"input\": \"International Cooperation Strengthened Through New Treaty\",\n            \"ground_truth\": \"World\"\n          }\n        },\n        {\n          \"item\": {\n            \"input\": \"Sports League Announces Revised Schedule for Upcoming Season\",\n            \"ground_truth\": \"Sports\"\n          }\n        }\n      ]\n    },\n    \"input_messages\": {\n      \"type\": \"template\",\n      \"template\": [\n        {\n          \"type\": \"message\",\n          \"role\": \"developer\",\n          \"content\": {\n            \"type\": \"input_text\",\n            \"text\": \"Categorize a given news headline into one of the following topics: Technology, Markets, World, Business, or Sports.\\n\\n# Steps\\n\\n1. Analyze the content of the news headline to understand its primary focus.\\n2. Extract the subject matter, identifying any key indicators or keywords.\\n3. Use the identified indicators to determine the most suitable category out of the five options: Technology, Markets, World, Business, or Sports.\\n4. Ensure only one category is selected per headline.\\n\\n# Output Format\\n\\nRespond with the chosen category as a single word. For instance: \\\"Technology\\\", \\\"Markets\\\", \\\"World\\\", \\\"Business\\\", or \\\"Sports\\\".\\n\\n# Examples\\n\\n**Input**: \\\"Apple Unveils New iPhone Model, Featuring Advanced AI Features\\\"  \\n**Output**: \\\"Technology\\\"\\n\\n**Input**: \\\"Global Stocks Mixed as Investors Await Central Bank Decisions\\\"  \\n**Output**: \\\"Markets\\\"\\n\\n**Input**: \\\"War in Ukraine: Latest Updates on Negotiation Status\\\"  \\n**Output**: \\\"World\\\"\\n\\n**Input**: \\\"Microsoft in Talks to Acquire Gaming Company for $2 Billion\\\"  \\n**Output**: \\\"Business\\\"\\n\\n**Input**: \\\"Manchester United Secures Win in Premier League Football Match\\\"  \\n**Output**: \\\"Sports\\\" \\n\\n# Notes\\n\\n- If the headline appears to fit into more than one category, choose the most dominant theme.\\n- Keywords or phrases such as \\\"stocks\\\", \\\"company acquisition\\\", \\\"match\\\", or technological brands can be good indicators for classification.\\n\"\n          }\n        },\n        {\n          \"type\": \"message\",\n          \"role\": \"user\",\n          \"content\": {\n            \"type\": \"input_text\",\n            \"text\": \"{{item.input}}\"\n          }\n        }\n      ]\n    },\n    \"model\": \"gpt-4o-mini\",\n    \"sampling_params\": {\n      \"seed\": 42,\n      \"temperature\": 1.0,\n      \"top_p\": 1.0,\n      \"max_completions_tokens\": 2048\n    }\n  },\n  \"error\": null,\n  \"metadata\": {}\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/evals/eval_67abd54d9b0081909a86353f6fb9317a/runs/evalrun_67abd54d60ec8190832b46859da808f7/cancel \\\n  -X POST \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\"\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nresponse = client.evals.runs.cancel(\n    run_id=\"run_id\",\n    eval_id=\"eval_id\",\n)\nprint(response.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst response = await client.evals.runs.cancel('run_id', { eval_id: 'eval_id' });\n\nconsole.log(response.id);",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.evals.runs.RunCancelParams;\nimport com.openai.models.evals.runs.RunCancelResponse;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        RunCancelParams params = RunCancelParams.builder()\n            .evalId(\"eval_id\")\n            .runId(\"run_id\")\n            .build();\n        RunCancelResponse response = client.evals().runs().cancel(params);\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nresponse = openai.evals.runs.cancel(\"run_id\", eval_id: \"eval_id\")\n\nputs(response)",
      },
    },
  }
)
@tag("Evals")
op cancelEvalRun(
  /** The ID of the evaluation whose run you want to cancel. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  @path
  eval_id: string,

  /** The ID of the run to cancel. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  @path
  run_id: string,
): EvalRun;

/** Get a list of output items for an evaluation run. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@summary("Get eval run output items")
@get
@route("/evals/{eval_id}/runs/{run_id}/output_items")
@extension(
  "x-oaiMeta",
  #{
    name: "Get eval run output items",
    group: "evals",
    returns: "A list of [EvalRunOutputItem](https://platform.openai.com/docs/api-reference/evals/run-output-item-object) objects matching the specified ID.",
    path: "get",
    examples: #{
      response: "{\n  \"object\": \"list\",\n  \"data\": [\n    {\n      \"object\": \"eval.run.output_item\",\n      \"id\": \"outputitem_67e5796c28e081909917bf79f6e6214d\",\n      \"created_at\": 1743092076,\n      \"run_id\": \"evalrun_67abd54d60ec8190832b46859da808f7\",\n      \"eval_id\": \"eval_67abd54d9b0081909a86353f6fb9317a\",\n      \"status\": \"pass\",\n      \"datasource_item_id\": 5,\n      \"datasource_item\": {\n        \"input\": \"Stock Markets Rally After Positive Economic Data Released\",\n        \"ground_truth\": \"Markets\"\n      },\n      \"results\": [\n        {\n          \"name\": \"String check-a2486074-d803-4445-b431-ad2262e85d47\",\n          \"sample\": null,\n          \"passed\": true,\n          \"score\": 1.0\n        }\n      ],\n      \"sample\": {\n        \"input\": [\n          {\n            \"role\": \"developer\",\n            \"content\": \"Categorize a given news headline into one of the following topics: Technology, Markets, World, Business, or Sports.\\n\\n# Steps\\n\\n1. Analyze the content of the news headline to understand its primary focus.\\n2. Extract the subject matter, identifying any key indicators or keywords.\\n3. Use the identified indicators to determine the most suitable category out of the five options: Technology, Markets, World, Business, or Sports.\\n4. Ensure only one category is selected per headline.\\n\\n# Output Format\\n\\nRespond with the chosen category as a single word. For instance: \\\"Technology\\\", \\\"Markets\\\", \\\"World\\\", \\\"Business\\\", or \\\"Sports\\\".\\n\\n# Examples\\n\\n**Input**: \\\"Apple Unveils New iPhone Model, Featuring Advanced AI Features\\\"  \\n**Output**: \\\"Technology\\\"\\n\\n**Input**: \\\"Global Stocks Mixed as Investors Await Central Bank Decisions\\\"  \\n**Output**: \\\"Markets\\\"\\n\\n**Input**: \\\"War in Ukraine: Latest Updates on Negotiation Status\\\"  \\n**Output**: \\\"World\\\"\\n\\n**Input**: \\\"Microsoft in Talks to Acquire Gaming Company for $2 Billion\\\"  \\n**Output**: \\\"Business\\\"\\n\\n**Input**: \\\"Manchester United Secures Win in Premier League Football Match\\\"  \\n**Output**: \\\"Sports\\\" \\n\\n# Notes\\n\\n- If the headline appears to fit into more than one category, choose the most dominant theme.\\n- Keywords or phrases such as \\\"stocks\\\", \\\"company acquisition\\\", \\\"match\\\", or technological brands can be good indicators for classification.\\n\",\n            \"tool_call_id\": null,\n            \"tool_calls\": null,\n            \"function_call\": null\n          },\n          {\n            \"role\": \"user\",\n            \"content\": \"Stock Markets Rally After Positive Economic Data Released\",\n            \"tool_call_id\": null,\n            \"tool_calls\": null,\n            \"function_call\": null\n          }\n        ],\n        \"output\": [\n          {\n            \"role\": \"assistant\",\n            \"content\": \"Markets\",\n            \"tool_call_id\": null,\n            \"tool_calls\": null,\n            \"function_call\": null\n          }\n        ],\n        \"finish_reason\": \"stop\",\n        \"model\": \"gpt-4o-mini-2024-07-18\",\n        \"usage\": {\n          \"total_tokens\": 325,\n          \"completion_tokens\": 2,\n          \"prompt_tokens\": 323,\n          \"cached_tokens\": 0\n        },\n        \"error\": null,\n        \"temperature\": 1.0,\n        \"max_completion_tokens\": 2048,\n        \"top_p\": 1.0,\n        \"seed\": 42\n      }\n    }\n  ],\n  \"first_id\": \"outputitem_67e5796c28e081909917bf79f6e6214d\",\n  \"last_id\": \"outputitem_67e5796c28e081909917bf79f6e6214d\",\n  \"has_more\": true\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/evals/egroup_67abd54d9b0081909a86353f6fb9317a/runs/erun_67abd54d60ec8190832b46859da808f7/output_items \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\"\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\npage = client.evals.runs.output_items.list(\n    run_id=\"run_id\",\n    eval_id=\"eval_id\",\n)\npage = page.data[0]\nprint(page.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\n// Automatically fetches more pages as needed.\nfor await (const outputItemListResponse of client.evals.runs.outputItems.list('run_id', {\n  eval_id: 'eval_id',\n})) {\n  console.log(outputItemListResponse.id);\n}",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.evals.runs.outputitems.OutputItemListPage;\nimport com.openai.models.evals.runs.outputitems.OutputItemListParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        OutputItemListParams params = OutputItemListParams.builder()\n            .evalId(\"eval_id\")\n            .runId(\"run_id\")\n            .build();\n        OutputItemListPage page = client.evals().runs().outputItems().list(params);\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\npage = openai.evals.runs.output_items.list(\"run_id\", eval_id: \"eval_id\")\n\nputs(page)",
      },
    },
  }
)
@tag("Evals")
op getEvalRunOutputItems(
  /** The ID of the evaluation to retrieve runs for. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  @path
  eval_id: string,

  /** The ID of the run to retrieve output items for. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  @path
  run_id: string,

  /** Identifier for the last output item from the previous pagination request. */
  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "Auto-suppressed warnings non-applicable rules during import."
  @query(#{ explode: true })
  after?: string,

  /** Number of output items to retrieve. */
  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "Auto-suppressed warnings non-applicable rules during import."
  @query(#{ explode: true })
  limit?: integer = 20,

  /**Filter output items by status. Use `failed` to filter by failed output
items or `pass` to filter by passed output items.*/
  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  @query(#{ explode: true })
  status?: "fail" | "pass",

  /** Sort order for output items by timestamp. Use `asc` for ascending order or `desc` for descending order. Defaults to `asc`. */
  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  @query(#{ explode: true })
  order?: "asc" | "desc" = "asc",
): EvalRunOutputItemList;

/** Get an evaluation run output item by ID. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@summary("Get an output item of an eval run")
@get
@route("/evals/{eval_id}/runs/{run_id}/output_items/{output_item_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Get an output item of an eval run",
    group: "evals",
    returns: "The [EvalRunOutputItem](https://platform.openai.com/docs/api-reference/evals/run-output-item-object) object matching the specified ID.",
    path: "get",
    examples: #{
      response: "{\n  \"object\": \"eval.run.output_item\",\n  \"id\": \"outputitem_67e5796c28e081909917bf79f6e6214d\",\n  \"created_at\": 1743092076,\n  \"run_id\": \"evalrun_67abd54d60ec8190832b46859da808f7\",\n  \"eval_id\": \"eval_67abd54d9b0081909a86353f6fb9317a\",\n  \"status\": \"pass\",\n  \"datasource_item_id\": 5,\n  \"datasource_item\": {\n    \"input\": \"Stock Markets Rally After Positive Economic Data Released\",\n    \"ground_truth\": \"Markets\"\n  },\n  \"results\": [\n    {\n      \"name\": \"String check-a2486074-d803-4445-b431-ad2262e85d47\",\n      \"sample\": null,\n      \"passed\": true,\n      \"score\": 1.0\n    }\n  ],\n  \"sample\": {\n    \"input\": [\n      {\n        \"role\": \"developer\",\n        \"content\": \"Categorize a given news headline into one of the following topics: Technology, Markets, World, Business, or Sports.\\n\\n# Steps\\n\\n1. Analyze the content of the news headline to understand its primary focus.\\n2. Extract the subject matter, identifying any key indicators or keywords.\\n3. Use the identified indicators to determine the most suitable category out of the five options: Technology, Markets, World, Business, or Sports.\\n4. Ensure only one category is selected per headline.\\n\\n# Output Format\\n\\nRespond with the chosen category as a single word. For instance: \\\"Technology\\\", \\\"Markets\\\", \\\"World\\\", \\\"Business\\\", or \\\"Sports\\\".\\n\\n# Examples\\n\\n**Input**: \\\"Apple Unveils New iPhone Model, Featuring Advanced AI Features\\\"  \\n**Output**: \\\"Technology\\\"\\n\\n**Input**: \\\"Global Stocks Mixed as Investors Await Central Bank Decisions\\\"  \\n**Output**: \\\"Markets\\\"\\n\\n**Input**: \\\"War in Ukraine: Latest Updates on Negotiation Status\\\"  \\n**Output**: \\\"World\\\"\\n\\n**Input**: \\\"Microsoft in Talks to Acquire Gaming Company for $2 Billion\\\"  \\n**Output**: \\\"Business\\\"\\n\\n**Input**: \\\"Manchester United Secures Win in Premier League Football Match\\\"  \\n**Output**: \\\"Sports\\\" \\n\\n# Notes\\n\\n- If the headline appears to fit into more than one category, choose the most dominant theme.\\n- Keywords or phrases such as \\\"stocks\\\", \\\"company acquisition\\\", \\\"match\\\", or technological brands can be good indicators for classification.\\n\",\n        \"tool_call_id\": null,\n        \"tool_calls\": null,\n        \"function_call\": null\n      },\n      {\n        \"role\": \"user\",\n        \"content\": \"Stock Markets Rally After Positive Economic Data Released\",\n        \"tool_call_id\": null,\n        \"tool_calls\": null,\n        \"function_call\": null\n      }\n    ],\n    \"output\": [\n      {\n        \"role\": \"assistant\",\n        \"content\": \"Markets\",\n        \"tool_call_id\": null,\n        \"tool_calls\": null,\n        \"function_call\": null\n      }\n    ],\n    \"finish_reason\": \"stop\",\n    \"model\": \"gpt-4o-mini-2024-07-18\",\n    \"usage\": {\n      \"total_tokens\": 325,\n      \"completion_tokens\": 2,\n      \"prompt_tokens\": 323,\n      \"cached_tokens\": 0\n    },\n    \"error\": null,\n    \"temperature\": 1.0,\n    \"max_completion_tokens\": 2048,\n    \"top_p\": 1.0,\n    \"seed\": 42\n  }\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/evals/eval_67abd54d9b0081909a86353f6fb9317a/runs/evalrun_67abd54d60ec8190832b46859da808f7/output_items/outputitem_67abd55eb6548190bb580745d5644a33 \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\"\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\noutput_item = client.evals.runs.output_items.retrieve(\n    output_item_id=\"output_item_id\",\n    eval_id=\"eval_id\",\n    run_id=\"run_id\",\n)\nprint(output_item.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst outputItem = await client.evals.runs.outputItems.retrieve('output_item_id', {\n  eval_id: 'eval_id',\n  run_id: 'run_id',\n});\n\nconsole.log(outputItem.id);",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.evals.runs.outputitems.OutputItemRetrieveParams;\nimport com.openai.models.evals.runs.outputitems.OutputItemRetrieveResponse;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        OutputItemRetrieveParams params = OutputItemRetrieveParams.builder()\n            .evalId(\"eval_id\")\n            .runId(\"run_id\")\n            .outputItemId(\"output_item_id\")\n            .build();\n        OutputItemRetrieveResponse outputItem = client.evals().runs().outputItems().retrieve(params);\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\noutput_item = openai.evals.runs.output_items.retrieve(\"output_item_id\", eval_id: \"eval_id\", run_id: \"run_id\")\n\nputs(output_item)",
      },
    },
  }
)
@tag("Evals")
op getEvalRunOutputItem(
  /** The ID of the evaluation to retrieve runs for. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  @path
  eval_id: string,

  /** The ID of the run to retrieve. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  @path
  run_id: string,

  /** The ID of the output item to retrieve. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  @path
  output_item_id: string,
): EvalRunOutputItem;
