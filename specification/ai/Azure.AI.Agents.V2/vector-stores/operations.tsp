import "@typespec/http";
import "@typespec/openapi";
import "./models.tsp";
using TypeSpec.Http;
using TypeSpec.OpenAPI;
namespace OpenAI;
/** Returns a list of vector stores. */
@summary("List vector stores")
@get
@route("/vector_stores")
@extension(
  "x-oaiMeta",
  #{
    name: "List vector stores",
    group: "vector_stores",
    returns: "A list of [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object) objects.",
    examples: #{
      response: "{\n  \"object\": \"list\",\n  \"data\": [\n    {\n      \"id\": \"vs_abc123\",\n      \"object\": \"vector_store\",\n      \"created_at\": 1699061776,\n      \"name\": \"Support FAQ\",\n      \"bytes\": 139920,\n      \"file_counts\": {\n        \"in_progress\": 0,\n        \"completed\": 3,\n        \"failed\": 0,\n        \"cancelled\": 0,\n        \"total\": 3\n      }\n    },\n    {\n      \"id\": \"vs_abc456\",\n      \"object\": \"vector_store\",\n      \"created_at\": 1699061776,\n      \"name\": \"Support FAQ v2\",\n      \"bytes\": 139920,\n      \"file_counts\": {\n        \"in_progress\": 0,\n        \"completed\": 3,\n        \"failed\": 0,\n        \"cancelled\": 0,\n        \"total\": 3\n      }\n    }\n  ],\n  \"first_id\": \"vs_abc123\",\n  \"last_id\": \"vs_abc456\",\n  \"has_more\": false\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/vector_stores \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -H \"OpenAI-Beta: assistants=v2\"\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\npage = client.vector_stores.list()\npage = page.data[0]\nprint(page.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\n// Automatically fetches more pages as needed.\nfor await (const vectorStore of client.vectorStores.list()) {\n  console.log(vectorStore.id);\n}",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  page, err := client.VectorStores.List(context.TODO(), openai.VectorStoreListParams{\n\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", page)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.vectorstores.VectorStoreListPage;\nimport com.openai.models.vectorstores.VectorStoreListParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        VectorStoreListPage page = client.vectorStores().list();\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\npage = openai.vector_stores.list\n\nputs(page)",
      },
    },
  }
)
@tag("Vector stores")
op listVectorStores(
  /** A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 20. */
  @query(#{ explode: true })
  limit?: integer = 20,

  /** Sort order by the `created_at` timestamp of the objects. `asc` for ascending order and `desc` for descending order. */
  @query(#{ explode: true })
  order?: "asc" | "desc" = "desc",

  /** A cursor for use in pagination. `after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include after=obj_foo in order to fetch the next page of the list. */
  @query(#{ explode: true })
  after?: string,

  /** A cursor for use in pagination. `before` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, starting with obj_foo, your subsequent call can include before=obj_foo in order to fetch the previous page of the list. */
  @query(#{ explode: true })
  before?: string,
): ListVectorStoresResponse;

/** Create a vector store. */
@summary("Create vector store")
@post
@route("/vector_stores")
@extension(
  "x-oaiMeta",
  #{
    name: "Create vector store",
    group: "vector_stores",
    returns: "A [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object) object.",
    examples: #{
      response: "{\n  \"id\": \"vs_abc123\",\n  \"object\": \"vector_store\",\n  \"created_at\": 1699061776,\n  \"name\": \"Support FAQ\",\n  \"bytes\": 139920,\n  \"file_counts\": {\n    \"in_progress\": 0,\n    \"completed\": 3,\n    \"failed\": 0,\n    \"cancelled\": 0,\n    \"total\": 3\n  }\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/vector_stores \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -H \"OpenAI-Beta: assistants=v2\" \\\n  -d '{\n    \"name\": \"Support FAQ\"\n  }'\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nvector_store = client.vector_stores.create()\nprint(vector_store.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst vectorStore = await client.vectorStores.create();\n\nconsole.log(vectorStore.id);",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  vectorStore, err := client.VectorStores.New(context.TODO(), openai.VectorStoreNewParams{\n\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", vectorStore.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.vectorstores.VectorStore;\nimport com.openai.models.vectorstores.VectorStoreCreateParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        VectorStore vectorStore = client.vectorStores().create();\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nvector_store = openai.vector_stores.create\n\nputs(vector_store)",
      },
    },
  }
)
@tag("Vector stores")
op createVectorStore(
  @body
  body: CreateVectorStoreRequest,
): VectorStoreObject;

/** Delete a vector store. */
@summary("Delete vector store")
@delete
@route("/vector_stores/{vector_store_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Delete vector store",
    group: "vector_stores",
    returns: "Deletion status",
    examples: #{
      response: "{\n  id: \"vs_abc123\",\n  object: \"vector_store.deleted\",\n  deleted: true\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/vector_stores/vs_abc123 \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -H \"OpenAI-Beta: assistants=v2\" \\\n  -X DELETE\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nvector_store_deleted = client.vector_stores.delete(\n    \"vector_store_id\",\n)\nprint(vector_store_deleted.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst vectorStoreDeleted = await client.vectorStores.delete('vector_store_id');\n\nconsole.log(vectorStoreDeleted.id);",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  vectorStoreDeleted, err := client.VectorStores.Delete(context.TODO(), \"vector_store_id\")\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", vectorStoreDeleted.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.vectorstores.VectorStoreDeleteParams;\nimport com.openai.models.vectorstores.VectorStoreDeleted;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        VectorStoreDeleted vectorStoreDeleted = client.vectorStores().delete(\"vector_store_id\");\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nvector_store_deleted = openai.vector_stores.delete(\"vector_store_id\")\n\nputs(vector_store_deleted)",
      },
    },
  }
)
@tag("Vector stores")
op deleteVectorStore(
  /** The ID of the vector store to delete. */
  @path
  vector_store_id: string,
): DeleteVectorStoreResponse;

/** Retrieves a vector store. */
@summary("Retrieve vector store")
@get
@route("/vector_stores/{vector_store_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Retrieve vector store",
    group: "vector_stores",
    returns: "The [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object) object matching the specified ID.",
    examples: #{
      response: "{\n  \"id\": \"vs_abc123\",\n  \"object\": \"vector_store\",\n  \"created_at\": 1699061776\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/vector_stores/vs_abc123 \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -H \"OpenAI-Beta: assistants=v2\"\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nvector_store = client.vector_stores.retrieve(\n    \"vector_store_id\",\n)\nprint(vector_store.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst vectorStore = await client.vectorStores.retrieve('vector_store_id');\n\nconsole.log(vectorStore.id);",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  vectorStore, err := client.VectorStores.Get(context.TODO(), \"vector_store_id\")\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", vectorStore.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.vectorstores.VectorStore;\nimport com.openai.models.vectorstores.VectorStoreRetrieveParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        VectorStore vectorStore = client.vectorStores().retrieve(\"vector_store_id\");\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nvector_store = openai.vector_stores.retrieve(\"vector_store_id\")\n\nputs(vector_store)",
      },
    },
  }
)
@tag("Vector stores")
op getVectorStore(
  /** The ID of the vector store to retrieve. */
  @path
  vector_store_id: string,
): VectorStoreObject;

/** Modifies a vector store. */
@summary("Modify vector store")
@post
@route("/vector_stores/{vector_store_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Modify vector store",
    group: "vector_stores",
    returns: "The modified [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object) object.",
    examples: #{
      response: "{\n  \"id\": \"vs_abc123\",\n  \"object\": \"vector_store\",\n  \"created_at\": 1699061776,\n  \"name\": \"Support FAQ\",\n  \"bytes\": 139920,\n  \"file_counts\": {\n    \"in_progress\": 0,\n    \"completed\": 3,\n    \"failed\": 0,\n    \"cancelled\": 0,\n    \"total\": 3\n  }\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/vector_stores/vs_abc123 \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -H \"OpenAI-Beta: assistants=v2\"\n  -d '{\n    \"name\": \"Support FAQ\"\n  }'\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nvector_store = client.vector_stores.update(\n    vector_store_id=\"vector_store_id\",\n)\nprint(vector_store.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst vectorStore = await client.vectorStores.update('vector_store_id');\n\nconsole.log(vectorStore.id);",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  vectorStore, err := client.VectorStores.Update(\n    context.TODO(),\n    \"vector_store_id\",\n    openai.VectorStoreUpdateParams{\n\n    },\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", vectorStore.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.vectorstores.VectorStore;\nimport com.openai.models.vectorstores.VectorStoreUpdateParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        VectorStore vectorStore = client.vectorStores().update(\"vector_store_id\");\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nvector_store = openai.vector_stores.update(\"vector_store_id\")\n\nputs(vector_store)",
      },
    },
  }
)
@tag("Vector stores")
op modifyVectorStore(
  /** The ID of the vector store to modify. */
  @path
  vector_store_id: string,

  @body
  body: UpdateVectorStoreRequest,
): VectorStoreObject;

/** Create a vector store file batch. */
@summary("Create vector store file batch")
@post
@route("/vector_stores/{vector_store_id}/file_batches")
@extension(
  "x-oaiMeta",
  #{
    name: "Create vector store file batch",
    group: "vector_stores",
    returns: "A [vector store file batch](https://platform.openai.com/docs/api-reference/vector-stores-file-batches/batch-object) object.",
    examples: #{
      response: "{\n  \"id\": \"vsfb_abc123\",\n  \"object\": \"vector_store.file_batch\",\n  \"created_at\": 1699061776,\n  \"vector_store_id\": \"vs_abc123\",\n  \"status\": \"in_progress\",\n  \"file_counts\": {\n    \"in_progress\": 1,\n    \"completed\": 1,\n    \"failed\": 0,\n    \"cancelled\": 0,\n    \"total\": 0,\n  }\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/vector_stores/vs_abc123/file_batches \\\n    -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n    -H \"Content-Type: application/json \\\n    -H \"OpenAI-Beta: assistants=v2\" \\\n    -d '{\n      \"file_ids\": [\"file-abc123\", \"file-abc456\"]\n    }'\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nvector_store_file_batch = client.vector_stores.file_batches.create(\n    vector_store_id=\"vs_abc123\",\n    file_ids=[\"string\"],\n)\nprint(vector_store_file_batch.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst vectorStoreFileBatch = await client.vectorStores.fileBatches.create('vs_abc123', {\n  file_ids: ['string'],\n});\n\nconsole.log(vectorStoreFileBatch.id);",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  vectorStoreFileBatch, err := client.VectorStores.FileBatches.New(\n    context.TODO(),\n    \"vs_abc123\",\n    openai.VectorStoreFileBatchNewParams{\n      FileIDs: []string{\"string\"},\n    },\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", vectorStoreFileBatch.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.vectorstores.filebatches.FileBatchCreateParams;\nimport com.openai.models.vectorstores.filebatches.VectorStoreFileBatch;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        FileBatchCreateParams params = FileBatchCreateParams.builder()\n            .vectorStoreId(\"vs_abc123\")\n            .addFileId(\"string\")\n            .build();\n        VectorStoreFileBatch vectorStoreFileBatch = client.vectorStores().fileBatches().create(params);\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nvector_store_file_batch = openai.vector_stores.file_batches.create(\"vs_abc123\", file_ids: [\"string\"])\n\nputs(vector_store_file_batch)",
      },
    },
  }
)
@tag("Vector stores")
op createVectorStoreFileBatch(
  /** The ID of the vector store for which to create a File Batch. */
  @path
  vector_store_id: string,

  @body
  body: CreateVectorStoreFileBatchRequest,
): VectorStoreFileBatchObject;

/** Retrieves a vector store file batch. */
@summary("Retrieve vector store file batch")
@get
@route("/vector_stores/{vector_store_id}/file_batches/{batch_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Retrieve vector store file batch",
    group: "vector_stores",
    returns: "The [vector store file batch](https://platform.openai.com/docs/api-reference/vector-stores-file-batches/batch-object) object.",
    examples: #{
      response: "{\n  \"id\": \"vsfb_abc123\",\n  \"object\": \"vector_store.file_batch\",\n  \"created_at\": 1699061776,\n  \"vector_store_id\": \"vs_abc123\",\n  \"status\": \"in_progress\",\n  \"file_counts\": {\n    \"in_progress\": 1,\n    \"completed\": 1,\n    \"failed\": 0,\n    \"cancelled\": 0,\n    \"total\": 0,\n  }\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/vector_stores/vs_abc123/files_batches/vsfb_abc123 \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -H \"OpenAI-Beta: assistants=v2\"\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nvector_store_file_batch = client.vector_stores.file_batches.retrieve(\n    batch_id=\"vsfb_abc123\",\n    vector_store_id=\"vs_abc123\",\n)\nprint(vector_store_file_batch.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst vectorStoreFileBatch = await client.vectorStores.fileBatches.retrieve('vsfb_abc123', {\n  vector_store_id: 'vs_abc123',\n});\n\nconsole.log(vectorStoreFileBatch.id);",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  vectorStoreFileBatch, err := client.VectorStores.FileBatches.Get(\n    context.TODO(),\n    \"vs_abc123\",\n    \"vsfb_abc123\",\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", vectorStoreFileBatch.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.vectorstores.filebatches.FileBatchRetrieveParams;\nimport com.openai.models.vectorstores.filebatches.VectorStoreFileBatch;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        FileBatchRetrieveParams params = FileBatchRetrieveParams.builder()\n            .vectorStoreId(\"vs_abc123\")\n            .batchId(\"vsfb_abc123\")\n            .build();\n        VectorStoreFileBatch vectorStoreFileBatch = client.vectorStores().fileBatches().retrieve(params);\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nvector_store_file_batch = openai.vector_stores.file_batches.retrieve(\"vsfb_abc123\", vector_store_id: \"vs_abc123\")\n\nputs(vector_store_file_batch)",
      },
    },
  }
)
@tag("Vector stores")
op getVectorStoreFileBatch(
  /** The ID of the vector store that the file batch belongs to. */
  @path
  vector_store_id: string,

  /** The ID of the file batch being retrieved. */
  @path
  batch_id: string,
): VectorStoreFileBatchObject;

/** Cancel a vector store file batch. This attempts to cancel the processing of files in this batch as soon as possible. */
@summary("Cancel vector store file batch")
@post
@route("/vector_stores/{vector_store_id}/file_batches/{batch_id}/cancel")
@extension(
  "x-oaiMeta",
  #{
    name: "Cancel vector store file batch",
    group: "vector_stores",
    returns: "The modified vector store file batch object.",
    examples: #{
      response: "{\n  \"id\": \"vsfb_abc123\",\n  \"object\": \"vector_store.file_batch\",\n  \"created_at\": 1699061776,\n  \"vector_store_id\": \"vs_abc123\",\n  \"status\": \"in_progress\",\n  \"file_counts\": {\n    \"in_progress\": 12,\n    \"completed\": 3,\n    \"failed\": 0,\n    \"cancelled\": 0,\n    \"total\": 15,\n  }\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/vector_stores/vs_abc123/files_batches/vsfb_abc123/cancel \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -H \"OpenAI-Beta: assistants=v2\" \\\n  -X POST\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nvector_store_file_batch = client.vector_stores.file_batches.cancel(\n    batch_id=\"batch_id\",\n    vector_store_id=\"vector_store_id\",\n)\nprint(vector_store_file_batch.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst vectorStoreFileBatch = await client.vectorStores.fileBatches.cancel('batch_id', {\n  vector_store_id: 'vector_store_id',\n});\n\nconsole.log(vectorStoreFileBatch.id);",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  vectorStoreFileBatch, err := client.VectorStores.FileBatches.Cancel(\n    context.TODO(),\n    \"vector_store_id\",\n    \"batch_id\",\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", vectorStoreFileBatch.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.vectorstores.filebatches.FileBatchCancelParams;\nimport com.openai.models.vectorstores.filebatches.VectorStoreFileBatch;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        FileBatchCancelParams params = FileBatchCancelParams.builder()\n            .vectorStoreId(\"vector_store_id\")\n            .batchId(\"batch_id\")\n            .build();\n        VectorStoreFileBatch vectorStoreFileBatch = client.vectorStores().fileBatches().cancel(params);\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nvector_store_file_batch = openai.vector_stores.file_batches.cancel(\"batch_id\", vector_store_id: \"vector_store_id\")\n\nputs(vector_store_file_batch)",
      },
    },
  }
)
@tag("Vector stores")
op cancelVectorStoreFileBatch(
  /** The ID of the vector store that the file batch belongs to. */
  @path
  vector_store_id: string,

  /** The ID of the file batch to cancel. */
  @path
  batch_id: string,
): VectorStoreFileBatchObject;

/** Returns a list of vector store files in a batch. */
@summary("List vector store files in a batch")
@get
@route("/vector_stores/{vector_store_id}/file_batches/{batch_id}/files")
@extension(
  "x-oaiMeta",
  #{
    name: "List vector store files in a batch",
    group: "vector_stores",
    returns: "A list of [vector store file](https://platform.openai.com/docs/api-reference/vector-stores-files/file-object) objects.",
    examples: #{
      response: "{\n  \"object\": \"list\",\n  \"data\": [\n    {\n      \"id\": \"file-abc123\",\n      \"object\": \"vector_store.file\",\n      \"created_at\": 1699061776,\n      \"vector_store_id\": \"vs_abc123\"\n    },\n    {\n      \"id\": \"file-abc456\",\n      \"object\": \"vector_store.file\",\n      \"created_at\": 1699061776,\n      \"vector_store_id\": \"vs_abc123\"\n    }\n  ],\n  \"first_id\": \"file-abc123\",\n  \"last_id\": \"file-abc456\",\n  \"has_more\": false\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/vector_stores/vs_abc123/files_batches/vsfb_abc123/files \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -H \"OpenAI-Beta: assistants=v2\"\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\npage = client.vector_stores.file_batches.list_files(\n    batch_id=\"batch_id\",\n    vector_store_id=\"vector_store_id\",\n)\npage = page.data[0]\nprint(page.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\n// Automatically fetches more pages as needed.\nfor await (const vectorStoreFile of client.vectorStores.fileBatches.listFiles('batch_id', {\n  vector_store_id: 'vector_store_id',\n})) {\n  console.log(vectorStoreFile.id);\n}",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  page, err := client.VectorStores.FileBatches.ListFiles(\n    context.TODO(),\n    \"vector_store_id\",\n    \"batch_id\",\n    openai.VectorStoreFileBatchListFilesParams{\n\n    },\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", page)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.vectorstores.filebatches.FileBatchListFilesPage;\nimport com.openai.models.vectorstores.filebatches.FileBatchListFilesParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        FileBatchListFilesParams params = FileBatchListFilesParams.builder()\n            .vectorStoreId(\"vector_store_id\")\n            .batchId(\"batch_id\")\n            .build();\n        FileBatchListFilesPage page = client.vectorStores().fileBatches().listFiles(params);\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\npage = openai.vector_stores.file_batches.list_files(\"batch_id\", vector_store_id: \"vector_store_id\")\n\nputs(page)",
      },
    },
  }
)
@tag("Vector stores")
op listFilesInVectorStoreBatch(
  /** The ID of the vector store that the files belong to. */
  @path
  vector_store_id: string,

  /** The ID of the file batch that the files belong to. */
  @path
  batch_id: string,

  /** A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 20. */
  @query(#{ explode: true })
  limit?: integer = 20,

  /** Sort order by the `created_at` timestamp of the objects. `asc` for ascending order and `desc` for descending order. */
  @query(#{ explode: true })
  order?: "asc" | "desc" = "desc",

  /** A cursor for use in pagination. `after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include after=obj_foo in order to fetch the next page of the list. */
  @query(#{ explode: true })
  after?: string,

  /** A cursor for use in pagination. `before` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, starting with obj_foo, your subsequent call can include before=obj_foo in order to fetch the previous page of the list. */
  @query(#{ explode: true })
  before?: string,

  /** Filter by file status. One of `in_progress`, `completed`, `failed`, `cancelled`. */
  @query(#{ explode: true })
  filter?: "in_progress" | "completed" | "failed" | "cancelled",
): ListVectorStoreFilesResponse;

/** Returns a list of vector store files. */
@summary("List vector store files")
@get
@route("/vector_stores/{vector_store_id}/files")
@extension(
  "x-oaiMeta",
  #{
    name: "List vector store files",
    group: "vector_stores",
    returns: "A list of [vector store file](https://platform.openai.com/docs/api-reference/vector-stores-files/file-object) objects.",
    examples: #{
      response: "{\n  \"object\": \"list\",\n  \"data\": [\n    {\n      \"id\": \"file-abc123\",\n      \"object\": \"vector_store.file\",\n      \"created_at\": 1699061776,\n      \"vector_store_id\": \"vs_abc123\"\n    },\n    {\n      \"id\": \"file-abc456\",\n      \"object\": \"vector_store.file\",\n      \"created_at\": 1699061776,\n      \"vector_store_id\": \"vs_abc123\"\n    }\n  ],\n  \"first_id\": \"file-abc123\",\n  \"last_id\": \"file-abc456\",\n  \"has_more\": false\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/vector_stores/vs_abc123/files \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -H \"OpenAI-Beta: assistants=v2\"\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\npage = client.vector_stores.files.list(\n    vector_store_id=\"vector_store_id\",\n)\npage = page.data[0]\nprint(page.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\n// Automatically fetches more pages as needed.\nfor await (const vectorStoreFile of client.vectorStores.files.list('vector_store_id')) {\n  console.log(vectorStoreFile.id);\n}",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  page, err := client.VectorStores.Files.List(\n    context.TODO(),\n    \"vector_store_id\",\n    openai.VectorStoreFileListParams{\n\n    },\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", page)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.vectorstores.files.FileListPage;\nimport com.openai.models.vectorstores.files.FileListParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        FileListPage page = client.vectorStores().files().list(\"vector_store_id\");\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\npage = openai.vector_stores.files.list(\"vector_store_id\")\n\nputs(page)",
      },
    },
  }
)
@tag("Vector stores")
op listVectorStoreFiles(
  /** The ID of the vector store that the files belong to. */
  @path
  vector_store_id: string,

  /** A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 20. */
  @query(#{ explode: true })
  limit?: integer = 20,

  /** Sort order by the `created_at` timestamp of the objects. `asc` for ascending order and `desc` for descending order. */
  @query(#{ explode: true })
  order?: "asc" | "desc" = "desc",

  /** A cursor for use in pagination. `after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include after=obj_foo in order to fetch the next page of the list. */
  @query(#{ explode: true })
  after?: string,

  /** A cursor for use in pagination. `before` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, starting with obj_foo, your subsequent call can include before=obj_foo in order to fetch the previous page of the list. */
  @query(#{ explode: true })
  before?: string,

  /** Filter by file status. One of `in_progress`, `completed`, `failed`, `cancelled`. */
  @query(#{ explode: true })
  filter?: "in_progress" | "completed" | "failed" | "cancelled",
): ListVectorStoreFilesResponse;

/** Create a vector store file by attaching a [File](https://platform.openai.com/docs/api-reference/files) to a [vector store](https://platform.openai.com/docs/api-reference/vector-stores/object). */
@summary("Create vector store file")
@post
@route("/vector_stores/{vector_store_id}/files")
@extension(
  "x-oaiMeta",
  #{
    name: "Create vector store file",
    group: "vector_stores",
    returns: "A [vector store file](https://platform.openai.com/docs/api-reference/vector-stores-files/file-object) object.",
    examples: #{
      response: "{\n  \"id\": \"file-abc123\",\n  \"object\": \"vector_store.file\",\n  \"created_at\": 1699061776,\n  \"usage_bytes\": 1234,\n  \"vector_store_id\": \"vs_abcd\",\n  \"status\": \"completed\",\n  \"last_error\": null\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/vector_stores/vs_abc123/files \\\n    -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n    -H \"Content-Type: application/json\" \\\n    -H \"OpenAI-Beta: assistants=v2\" \\\n    -d '{\n      \"file_id\": \"file-abc123\"\n    }'\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nvector_store_file = client.vector_stores.files.create(\n    vector_store_id=\"vs_abc123\",\n    file_id=\"file_id\",\n)\nprint(vector_store_file.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst vectorStoreFile = await client.vectorStores.files.create('vs_abc123', { file_id: 'file_id' });\n\nconsole.log(vectorStoreFile.id);",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  vectorStoreFile, err := client.VectorStores.Files.New(\n    context.TODO(),\n    \"vs_abc123\",\n    openai.VectorStoreFileNewParams{\n      FileID: \"file_id\",\n    },\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", vectorStoreFile.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.vectorstores.files.FileCreateParams;\nimport com.openai.models.vectorstores.files.VectorStoreFile;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        FileCreateParams params = FileCreateParams.builder()\n            .vectorStoreId(\"vs_abc123\")\n            .fileId(\"file_id\")\n            .build();\n        VectorStoreFile vectorStoreFile = client.vectorStores().files().create(params);\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nvector_store_file = openai.vector_stores.files.create(\"vs_abc123\", file_id: \"file_id\")\n\nputs(vector_store_file)",
      },
    },
  }
)
@tag("Vector stores")
op createVectorStoreFile(
  /** The ID of the vector store for which to create a File. */
  @path
  vector_store_id: string,

  @body
  body: CreateVectorStoreFileRequest,
): VectorStoreFileObject;

/** Delete a vector store file. This will remove the file from the vector store but the file itself will not be deleted. To delete the file, use the [delete file](https://platform.openai.com/docs/api-reference/files/delete) endpoint. */
@summary("Delete vector store file")
@delete
@route("/vector_stores/{vector_store_id}/files/{file_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Delete vector store file",
    group: "vector_stores",
    returns: "Deletion status",
    examples: #{
      response: "{\n  id: \"file-abc123\",\n  object: \"vector_store.file.deleted\",\n  deleted: true\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/vector_stores/vs_abc123/files/file-abc123 \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -H \"OpenAI-Beta: assistants=v2\" \\\n  -X DELETE\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nvector_store_file_deleted = client.vector_stores.files.delete(\n    file_id=\"file_id\",\n    vector_store_id=\"vector_store_id\",\n)\nprint(vector_store_file_deleted.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst vectorStoreFileDeleted = await client.vectorStores.files.delete('file_id', {\n  vector_store_id: 'vector_store_id',\n});\n\nconsole.log(vectorStoreFileDeleted.id);",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  vectorStoreFileDeleted, err := client.VectorStores.Files.Delete(\n    context.TODO(),\n    \"vector_store_id\",\n    \"file_id\",\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", vectorStoreFileDeleted.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.vectorstores.files.FileDeleteParams;\nimport com.openai.models.vectorstores.files.VectorStoreFileDeleted;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        FileDeleteParams params = FileDeleteParams.builder()\n            .vectorStoreId(\"vector_store_id\")\n            .fileId(\"file_id\")\n            .build();\n        VectorStoreFileDeleted vectorStoreFileDeleted = client.vectorStores().files().delete(params);\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nvector_store_file_deleted = openai.vector_stores.files.delete(\"file_id\", vector_store_id: \"vector_store_id\")\n\nputs(vector_store_file_deleted)",
      },
    },
  }
)
@tag("Vector stores")
op deleteVectorStoreFile(
  /** The ID of the vector store that the file belongs to. */
  @path
  vector_store_id: string,

  /** The ID of the file to delete. */
  @path
  file_id: string,
): DeleteVectorStoreFileResponse;

/** Retrieves a vector store file. */
@summary("Retrieve vector store file")
@get
@route("/vector_stores/{vector_store_id}/files/{file_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Retrieve vector store file",
    group: "vector_stores",
    returns: "The [vector store file](https://platform.openai.com/docs/api-reference/vector-stores-files/file-object) object.",
    examples: #{
      response: "{\n  \"id\": \"file-abc123\",\n  \"object\": \"vector_store.file\",\n  \"created_at\": 1699061776,\n  \"vector_store_id\": \"vs_abcd\",\n  \"status\": \"completed\",\n  \"last_error\": null\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/vector_stores/vs_abc123/files/file-abc123 \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -H \"OpenAI-Beta: assistants=v2\"\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nvector_store_file = client.vector_stores.files.retrieve(\n    file_id=\"file-abc123\",\n    vector_store_id=\"vs_abc123\",\n)\nprint(vector_store_file.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst vectorStoreFile = await client.vectorStores.files.retrieve('file-abc123', {\n  vector_store_id: 'vs_abc123',\n});\n\nconsole.log(vectorStoreFile.id);",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  vectorStoreFile, err := client.VectorStores.Files.Get(\n    context.TODO(),\n    \"vs_abc123\",\n    \"file-abc123\",\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", vectorStoreFile.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.vectorstores.files.FileRetrieveParams;\nimport com.openai.models.vectorstores.files.VectorStoreFile;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        FileRetrieveParams params = FileRetrieveParams.builder()\n            .vectorStoreId(\"vs_abc123\")\n            .fileId(\"file-abc123\")\n            .build();\n        VectorStoreFile vectorStoreFile = client.vectorStores().files().retrieve(params);\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nvector_store_file = openai.vector_stores.files.retrieve(\"file-abc123\", vector_store_id: \"vs_abc123\")\n\nputs(vector_store_file)",
      },
    },
  }
)
@tag("Vector stores")
op getVectorStoreFile(
  /** The ID of the vector store that the file belongs to. */
  @path
  vector_store_id: string,

  /** The ID of the file being retrieved. */
  @path
  file_id: string,
): VectorStoreFileObject;

/** Update attributes on a vector store file. */
@summary("Update vector store file attributes")
@post
@route("/vector_stores/{vector_store_id}/files/{file_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Update vector store file attributes",
    group: "vector_stores",
    returns: "The updated [vector store file](https://platform.openai.com/docs/api-reference/vector-stores-files/file-object) object.",
    examples: #{
      response: "{\n  \"id\": \"file-abc123\",\n  \"object\": \"vector_store.file\",\n  \"usage_bytes\": 1234,\n  \"created_at\": 1699061776,\n  \"vector_store_id\": \"vs_abcd\",\n  \"status\": \"completed\",\n  \"last_error\": null,\n  \"chunking_strategy\": {...},\n  \"attributes\": {\"key1\": \"value1\", \"key2\": 2}\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/vector_stores/{vector_store_id}/files/{file_id} \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -d '{\"attributes\": {\"key1\": \"value1\", \"key2\": 2}}'\n",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst vectorStoreFile = await client.vectorStores.files.update('file-abc123', {\n  vector_store_id: 'vs_abc123',\n  attributes: { foo: 'string' },\n});\n\nconsole.log(vectorStoreFile.id);",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nvector_store_file = client.vector_stores.files.update(\n    file_id=\"file-abc123\",\n    vector_store_id=\"vs_abc123\",\n    attributes={\n        \"foo\": \"string\"\n    },\n)\nprint(vector_store_file.id)",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  vectorStoreFile, err := client.VectorStores.Files.Update(\n    context.TODO(),\n    \"vs_abc123\",\n    \"file-abc123\",\n    openai.VectorStoreFileUpdateParams{\n      Attributes: map[string]openai.VectorStoreFileUpdateParamsAttributeUnion{\n      \"foo\": openai.VectorStoreFileUpdateParamsAttributeUnion{\n        OfString: openai.String(\"string\"),\n      },\n      },\n    },\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", vectorStoreFile.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.core.JsonValue;\nimport com.openai.models.vectorstores.files.FileUpdateParams;\nimport com.openai.models.vectorstores.files.VectorStoreFile;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        FileUpdateParams params = FileUpdateParams.builder()\n            .vectorStoreId(\"vs_abc123\")\n            .fileId(\"file-abc123\")\n            .attributes(FileUpdateParams.Attributes.builder()\n                .putAdditionalProperty(\"foo\", JsonValue.from(\"string\"))\n                .build())\n            .build();\n        VectorStoreFile vectorStoreFile = client.vectorStores().files().update(params);\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nvector_store_file = openai.vector_stores.files.update(\n  \"file-abc123\",\n  vector_store_id: \"vs_abc123\",\n  attributes: {foo: \"string\"}\n)\n\nputs(vector_store_file)",
      },
    },
  }
)
@tag("Vector stores")
op updateVectorStoreFileAttributes(
  /** The ID of the vector store the file belongs to. */
  @path
  vector_store_id: string,

  /** The ID of the file to update attributes. */
  @path
  file_id: string,

  @body
  body: UpdateVectorStoreFileAttributesRequest,
): VectorStoreFileObject;

/** Retrieve the parsed contents of a vector store file. */
@summary("Retrieve vector store file content")
@get
@route("/vector_stores/{vector_store_id}/files/{file_id}/content")
@extension(
  "x-oaiMeta",
  #{
    name: "Retrieve vector store file content",
    group: "vector_stores",
    returns: "The parsed contents of the specified vector store file.",
    examples: #{
      response: "{\n  \"file_id\": \"file-abc123\",\n  \"filename\": \"example.txt\",\n  \"attributes\": {\"key\": \"value\"},\n  \"content\": [\n    {\"type\": \"text\", \"text\": \"...\"},\n    ...\n  ]\n}\n",
      request: #{
        curl: "curl \\\nhttps://api.openai.com/v1/vector_stores/vs_abc123/files/file-abc123/content \\\n-H \"Authorization: Bearer $OPENAI_API_KEY\"\n",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\n// Automatically fetches more pages as needed.\nfor await (const fileContentResponse of client.vectorStores.files.content('file-abc123', {\n  vector_store_id: 'vs_abc123',\n})) {\n  console.log(fileContentResponse.text);\n}",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\npage = client.vector_stores.files.content(\n    file_id=\"file-abc123\",\n    vector_store_id=\"vs_abc123\",\n)\npage = page.data[0]\nprint(page.text)",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  page, err := client.VectorStores.Files.Content(\n    context.TODO(),\n    \"vs_abc123\",\n    \"file-abc123\",\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", page)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.vectorstores.files.FileContentPage;\nimport com.openai.models.vectorstores.files.FileContentParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        FileContentParams params = FileContentParams.builder()\n            .vectorStoreId(\"vs_abc123\")\n            .fileId(\"file-abc123\")\n            .build();\n        FileContentPage page = client.vectorStores().files().content(params);\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\npage = openai.vector_stores.files.content(\"file-abc123\", vector_store_id: \"vs_abc123\")\n\nputs(page)",
      },
    },
  }
)
@tag("Vector stores")
op retrieveVectorStoreFileContent(
  /** The ID of the vector store. */
  @path
  vector_store_id: string,

  /** The ID of the file within the vector store. */
  @path
  file_id: string,
): VectorStoreFileContentResponse;

/** Search a vector store for relevant chunks based on a query and file attributes filter. */
@summary("Search vector store")
@post
@route("/vector_stores/{vector_store_id}/search")
@extension(
  "x-oaiMeta",
  #{
    name: "Search vector store",
    group: "vector_stores",
    returns: "A page of search results from the vector store.",
    examples: #{
      response: "{\n  \"object\": \"vector_store.search_results.page\",\n  \"search_query\": \"What is the return policy?\",\n  \"data\": [\n    {\n      \"file_id\": \"file_123\",\n      \"filename\": \"document.pdf\",\n      \"score\": 0.95,\n      \"attributes\": {\n        \"author\": \"John Doe\",\n        \"date\": \"2023-01-01\"\n      },\n      \"content\": [\n        {\n          \"type\": \"text\",\n          \"text\": \"Relevant chunk\"\n        }\n      ]\n    },\n    {\n      \"file_id\": \"file_456\",\n      \"filename\": \"notes.txt\",\n      \"score\": 0.89,\n      \"attributes\": {\n        \"author\": \"Jane Smith\",\n        \"date\": \"2023-01-02\"\n      },\n      \"content\": [\n        {\n          \"type\": \"text\",\n          \"text\": \"Sample text content from the vector store.\"\n        }\n      ]\n    }\n  ],\n  \"has_more\": false,\n  \"next_page\": null\n}\n",
      request: #{
        curl: "curl -X POST \\\nhttps://api.openai.com/v1/vector_stores/vs_abc123/search \\\n-H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n-H \"Content-Type: application/json\" \\\n-d '{\"query\": \"What is the return policy?\", \"filters\": {...}}'\n",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\n// Automatically fetches more pages as needed.\nfor await (const vectorStoreSearchResponse of client.vectorStores.search('vs_abc123', { query: 'string' })) {\n  console.log(vectorStoreSearchResponse.file_id);\n}",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\npage = client.vector_stores.search(\n    vector_store_id=\"vs_abc123\",\n    query=\"string\",\n)\npage = page.data[0]\nprint(page.file_id)",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  page, err := client.VectorStores.Search(\n    context.TODO(),\n    \"vs_abc123\",\n    openai.VectorStoreSearchParams{\n      Query: openai.VectorStoreSearchParamsQueryUnion{\n        OfString: openai.String(\"string\"),\n      },\n    },\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", page)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.vectorstores.VectorStoreSearchPage;\nimport com.openai.models.vectorstores.VectorStoreSearchParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        VectorStoreSearchParams params = VectorStoreSearchParams.builder()\n            .vectorStoreId(\"vs_abc123\")\n            .query(\"string\")\n            .build();\n        VectorStoreSearchPage page = client.vectorStores().search(params);\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\npage = openai.vector_stores.search(\"vs_abc123\", query: \"string\")\n\nputs(page)",
      },
    },
  }
)
@tag("Vector stores")
op searchVectorStore(
  /** The ID of the vector store to search. */
  @path
  vector_store_id: string,

  @body
  body: VectorStoreSearchRequest,
): VectorStoreSearchResultsPage;
