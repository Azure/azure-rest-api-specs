import "@typespec/http";
import "@typespec/openapi";
import "./models.tsp";
import "../common/models.tsp";
using TypeSpec.Http;
using TypeSpec.OpenAPI;
namespace OpenAI;
/** List your organization's batches. */
@summary("List batch")
@get
@route("/batches")
@extension(
  "x-oaiMeta",
  #{
    name: "List batch",
    group: "batch",
    returns: "A list of paginated [Batch](https://platform.openai.com/docs/api-reference/batch/object) objects.",
    examples: #{
      response: "{\n  \"object\": \"list\",\n  \"data\": [\n    {\n      \"id\": \"batch_abc123\",\n      \"object\": \"batch\",\n      \"endpoint\": \"/v1/chat/completions\",\n      \"errors\": null,\n      \"input_file_id\": \"file-abc123\",\n      \"completion_window\": \"24h\",\n      \"status\": \"completed\",\n      \"output_file_id\": \"file-cvaTdG\",\n      \"error_file_id\": \"file-HOWS94\",\n      \"created_at\": 1711471533,\n      \"in_progress_at\": 1711471538,\n      \"expires_at\": 1711557933,\n      \"finalizing_at\": 1711493133,\n      \"completed_at\": 1711493163,\n      \"failed_at\": null,\n      \"expired_at\": null,\n      \"cancelling_at\": null,\n      \"cancelled_at\": null,\n      \"request_counts\": {\n        \"total\": 100,\n        \"completed\": 95,\n        \"failed\": 5\n      },\n      \"metadata\": {\n        \"customer_id\": \"user_123456789\",\n        \"batch_description\": \"Nightly job\",\n      }\n    },\n    { ... },\n  ],\n  \"first_id\": \"batch_abc123\",\n  \"last_id\": \"batch_abc456\",\n  \"has_more\": true\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/batches?limit=2 \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\"\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\npage = client.batches.list()\npage = page.data[0]\nprint(page.id)",
        node: "import OpenAI from \"openai\";\n\nconst openai = new OpenAI();\n\nasync function main() {\n  const list = await openai.batches.list();\n\n  for await (const batch of list) {\n    console.log(batch);\n  }\n}\n\nmain();\n",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\n// Automatically fetches more pages as needed.\nfor await (const batch of client.batches.list()) {\n  console.log(batch.id);\n}",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  page, err := client.Batches.List(context.TODO(), openai.BatchListParams{\n\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", page)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.batches.BatchListPage;\nimport com.openai.models.batches.BatchListParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        BatchListPage page = client.batches().list();\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\npage = openai.batches.list\n\nputs(page)",
      },
    },
  }
)
@tag("Batch")
op listBatches(
  /** A cursor for use in pagination. `after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include after=obj_foo in order to fetch the next page of the list. */
  @query(#{ explode: true })
  after?: string,

  /** A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 20. */
  @query(#{ explode: true })
  limit?: integer = 20,
): ListBatchesResponse;

/** Creates and executes a batch from an uploaded file of requests */
@summary("Create batch")
@post
@route("/batches")
@extension(
  "x-oaiMeta",
  #{
    name: "Create batch",
    group: "batch",
    returns: "The created [Batch](https://platform.openai.com/docs/api-reference/batch/object) object.",
    examples: #{
      response: "{\n  \"id\": \"batch_abc123\",\n  \"object\": \"batch\",\n  \"endpoint\": \"/v1/chat/completions\",\n  \"errors\": null,\n  \"input_file_id\": \"file-abc123\",\n  \"completion_window\": \"24h\",\n  \"status\": \"validating\",\n  \"output_file_id\": null,\n  \"error_file_id\": null,\n  \"created_at\": 1711471533,\n  \"in_progress_at\": null,\n  \"expires_at\": null,\n  \"finalizing_at\": null,\n  \"completed_at\": null,\n  \"failed_at\": null,\n  \"expired_at\": null,\n  \"cancelling_at\": null,\n  \"cancelled_at\": null,\n  \"request_counts\": {\n    \"total\": 0,\n    \"completed\": 0,\n    \"failed\": 0\n  },\n  \"metadata\": {\n    \"customer_id\": \"user_123456789\",\n    \"batch_description\": \"Nightly eval job\",\n  }\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/batches \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -d '{\n    \"input_file_id\": \"file-abc123\",\n    \"endpoint\": \"/v1/chat/completions\",\n    \"completion_window\": \"24h\"\n  }'\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nbatch = client.batches.create(\n    completion_window=\"24h\",\n    endpoint=\"/v1/responses\",\n    input_file_id=\"input_file_id\",\n)\nprint(batch.id)",
        node: "import OpenAI from \"openai\";\n\nconst openai = new OpenAI();\n\nasync function main() {\n  const batch = await openai.batches.create({\n    input_file_id: \"file-abc123\",\n    endpoint: \"/v1/chat/completions\",\n    completion_window: \"24h\"\n  });\n\n  console.log(batch);\n}\n\nmain();\n",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst batch = await client.batches.create({\n  completion_window: '24h',\n  endpoint: '/v1/responses',\n  input_file_id: 'input_file_id',\n});\n\nconsole.log(batch.id);",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  batch, err := client.Batches.New(context.TODO(), openai.BatchNewParams{\n    CompletionWindow: openai.BatchNewParamsCompletionWindow24h,\n    Endpoint: openai.BatchNewParamsEndpointV1Responses,\n    InputFileID: \"input_file_id\",\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", batch.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.batches.Batch;\nimport com.openai.models.batches.BatchCreateParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        BatchCreateParams params = BatchCreateParams.builder()\n            .completionWindow(BatchCreateParams.CompletionWindow._24H)\n            .endpoint(BatchCreateParams.Endpoint.V1_RESPONSES)\n            .inputFileId(\"input_file_id\")\n            .build();\n        Batch batch = client.batches().create(params);\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nbatch = openai.batches.create(\n  completion_window: :\"24h\",\n  endpoint: :\"/v1/responses\",\n  input_file_id: \"input_file_id\"\n)\n\nputs(batch)",
      },
    },
  }
)
@tag("Batch")
op createBatch(
  @body
  body: {
    input_file_id: string;
    endpoint:
      | "/v1/responses"
      | "/v1/chat/completions"
      | "/v1/embeddings"
      | "/v1/completions";
    completion_window: "24h";
    metadata?: Metadata;
    output_expires_after?: BatchFileExpirationAfter;
  },
): Batch;

/** Retrieves a batch. */
@summary("Retrieve batch")
@get
@route("/batches/{batch_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Retrieve batch",
    group: "batch",
    returns: "The [Batch](https://platform.openai.com/docs/api-reference/batch/object) object matching the specified ID.",
    examples: #{
      response: "{\n  \"id\": \"batch_abc123\",\n  \"object\": \"batch\",\n  \"endpoint\": \"/v1/completions\",\n  \"errors\": null,\n  \"input_file_id\": \"file-abc123\",\n  \"completion_window\": \"24h\",\n  \"status\": \"completed\",\n  \"output_file_id\": \"file-cvaTdG\",\n  \"error_file_id\": \"file-HOWS94\",\n  \"created_at\": 1711471533,\n  \"in_progress_at\": 1711471538,\n  \"expires_at\": 1711557933,\n  \"finalizing_at\": 1711493133,\n  \"completed_at\": 1711493163,\n  \"failed_at\": null,\n  \"expired_at\": null,\n  \"cancelling_at\": null,\n  \"cancelled_at\": null,\n  \"request_counts\": {\n    \"total\": 100,\n    \"completed\": 95,\n    \"failed\": 5\n  },\n  \"metadata\": {\n    \"customer_id\": \"user_123456789\",\n    \"batch_description\": \"Nightly eval job\",\n  }\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/batches/batch_abc123 \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nbatch = client.batches.retrieve(\n    \"batch_id\",\n)\nprint(batch.id)",
        node: "import OpenAI from \"openai\";\n\nconst openai = new OpenAI();\n\nasync function main() {\n  const batch = await openai.batches.retrieve(\"batch_abc123\");\n\n  console.log(batch);\n}\n\nmain();\n",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst batch = await client.batches.retrieve('batch_id');\n\nconsole.log(batch.id);",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  batch, err := client.Batches.Get(context.TODO(), \"batch_id\")\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", batch.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.batches.Batch;\nimport com.openai.models.batches.BatchRetrieveParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        Batch batch = client.batches().retrieve(\"batch_id\");\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nbatch = openai.batches.retrieve(\"batch_id\")\n\nputs(batch)",
      },
    },
  }
)
@tag("Batch")
op retrieveBatch(
  /** The ID of the batch to retrieve. */
  @path
  batch_id: string,
): Batch;

/** Cancels an in-progress batch. The batch will be in status `cancelling` for up to 10 minutes, before changing to `cancelled`, where it will have partial results (if any) available in the output file. */
@summary("Cancel batch")
@post
@route("/batches/{batch_id}/cancel")
@extension(
  "x-oaiMeta",
  #{
    name: "Cancel batch",
    group: "batch",
    returns: "The [Batch](https://platform.openai.com/docs/api-reference/batch/object) object matching the specified ID.",
    examples: #{
      response: "{\n  \"id\": \"batch_abc123\",\n  \"object\": \"batch\",\n  \"endpoint\": \"/v1/chat/completions\",\n  \"errors\": null,\n  \"input_file_id\": \"file-abc123\",\n  \"completion_window\": \"24h\",\n  \"status\": \"cancelling\",\n  \"output_file_id\": null,\n  \"error_file_id\": null,\n  \"created_at\": 1711471533,\n  \"in_progress_at\": 1711471538,\n  \"expires_at\": 1711557933,\n  \"finalizing_at\": null,\n  \"completed_at\": null,\n  \"failed_at\": null,\n  \"expired_at\": null,\n  \"cancelling_at\": 1711475133,\n  \"cancelled_at\": null,\n  \"request_counts\": {\n    \"total\": 100,\n    \"completed\": 23,\n    \"failed\": 1\n  },\n  \"metadata\": {\n    \"customer_id\": \"user_123456789\",\n    \"batch_description\": \"Nightly eval job\",\n  }\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/batches/batch_abc123/cancel \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -X POST\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nbatch = client.batches.cancel(\n    \"batch_id\",\n)\nprint(batch.id)",
        node: "import OpenAI from \"openai\";\n\nconst openai = new OpenAI();\n\nasync function main() {\n  const batch = await openai.batches.cancel(\"batch_abc123\");\n\n  console.log(batch);\n}\n\nmain();\n",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst batch = await client.batches.cancel('batch_id');\n\nconsole.log(batch.id);",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  batch, err := client.Batches.Cancel(context.TODO(), \"batch_id\")\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", batch.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.batches.Batch;\nimport com.openai.models.batches.BatchCancelParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        Batch batch = client.batches().cancel(\"batch_id\");\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nbatch = openai.batches.cancel(\"batch_id\")\n\nputs(batch)",
      },
    },
  }
)
@tag("Batch")
op cancelBatch(
  /** The ID of the batch to cancel. */
  @path
  batch_id: string,
): Batch;
