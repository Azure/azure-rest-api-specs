import "@typespec/http";
import "@typespec/openapi";
import "./models.tsp";
using TypeSpec.Http;
using TypeSpec.OpenAPI;
namespace OpenAI;
/** Returns a list of assistants. */
@summary("List assistants")
@get
@route("/assistants")
@extension(
  "x-oaiMeta",
  #{
    name: "List assistants",
    group: "assistants",
    beta: true,
    returns: "A list of [assistant](https://platform.openai.com/docs/api-reference/assistants/object) objects.",
    examples: #{
      response: "{\n  \"object\": \"list\",\n  \"data\": [\n    {\n      \"id\": \"asst_abc123\",\n      \"object\": \"assistant\",\n      \"created_at\": 1698982736,\n      \"name\": \"Coding Tutor\",\n      \"description\": null,\n      \"model\": \"gpt-4o\",\n      \"instructions\": \"You are a helpful assistant designed to make me better at coding!\",\n      \"tools\": [],\n      \"tool_resources\": {},\n      \"metadata\": {},\n      \"top_p\": 1.0,\n      \"temperature\": 1.0,\n      \"response_format\": \"auto\"\n    },\n    {\n      \"id\": \"asst_abc456\",\n      \"object\": \"assistant\",\n      \"created_at\": 1698982718,\n      \"name\": \"My Assistant\",\n      \"description\": null,\n      \"model\": \"gpt-4o\",\n      \"instructions\": \"You are a helpful assistant designed to make me better at coding!\",\n      \"tools\": [],\n      \"tool_resources\": {},\n      \"metadata\": {},\n      \"top_p\": 1.0,\n      \"temperature\": 1.0,\n      \"response_format\": \"auto\"\n    },\n    {\n      \"id\": \"asst_abc789\",\n      \"object\": \"assistant\",\n      \"created_at\": 1698982643,\n      \"name\": null,\n      \"description\": null,\n      \"model\": \"gpt-4o\",\n      \"instructions\": null,\n      \"tools\": [],\n      \"tool_resources\": {},\n      \"metadata\": {},\n      \"top_p\": 1.0,\n      \"temperature\": 1.0,\n      \"response_format\": \"auto\"\n    }\n  ],\n  \"first_id\": \"asst_abc123\",\n  \"last_id\": \"asst_abc789\",\n  \"has_more\": false\n}\n",
      request: #{
        curl: "curl \"https://api.openai.com/v1/assistants?order=desc&limit=20\" \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"OpenAI-Beta: assistants=v2\"\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\npage = client.beta.assistants.list()\npage = page.data[0]\nprint(page.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\n// Automatically fetches more pages as needed.\nfor await (const assistant of client.beta.assistants.list()) {\n  console.log(assistant.id);\n}",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  page, err := client.Beta.Assistants.List(context.TODO(), openai.BetaAssistantListParams{\n\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", page)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.beta.assistants.AssistantListPage;\nimport com.openai.models.beta.assistants.AssistantListParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        AssistantListPage page = client.beta().assistants().list();\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\npage = openai.beta.assistants.list\n\nputs(page)",
      },
    },
  }
)
@tag("Assistants")
op listAssistants(
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
): ListAssistantsResponse;

/** Create an assistant with a model and instructions. */
@summary("Create assistant")
@post
@route("/assistants")
@extension(
  "x-oaiMeta",
  #{
    name: "Create assistant",
    group: "assistants",
    beta: true,
    returns: "An [assistant](https://platform.openai.com/docs/api-reference/assistants/object) object.",
    examples: #[
      #{
        title: "Code Interpreter",
        request: #{
          curl: "curl \"https://api.openai.com/v1/assistants\" \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"OpenAI-Beta: assistants=v2\" \\\n  -d '{\n    \"instructions\": \"You are a personal math tutor. When asked a question, write and run Python code to answer the question.\",\n    \"name\": \"Math Tutor\",\n    \"tools\": [{\"type\": \"code_interpreter\"}],\n    \"model\": \"gpt-4o\"\n  }'\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nassistant = client.beta.assistants.create(\n    model=\"gpt-4o\",\n)\nprint(assistant.id)",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst assistant = await client.beta.assistants.create({ model: 'gpt-4o' });\n\nconsole.log(assistant.id);",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n  \"github.com/openai/openai-go/shared\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  assistant, err := client.Beta.Assistants.New(context.TODO(), openai.BetaAssistantNewParams{\n    Model: shared.ChatModelGPT5,\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", assistant.ID)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.ChatModel;\nimport com.openai.models.beta.assistants.Assistant;\nimport com.openai.models.beta.assistants.AssistantCreateParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        AssistantCreateParams params = AssistantCreateParams.builder()\n            .model(ChatModel.GPT_5)\n            .build();\n        Assistant assistant = client.beta().assistants().create(params);\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nassistant = openai.beta.assistants.create(model: :\"gpt-5\")\n\nputs(assistant)",
        },
        response: "{\n  \"id\": \"asst_abc123\",\n  \"object\": \"assistant\",\n  \"created_at\": 1698984975,\n  \"name\": \"Math Tutor\",\n  \"description\": null,\n  \"model\": \"gpt-4o\",\n  \"instructions\": \"You are a personal math tutor. When asked a question, write and run Python code to answer the question.\",\n  \"tools\": [\n    {\n      \"type\": \"code_interpreter\"\n    }\n  ],\n  \"metadata\": {},\n  \"top_p\": 1.0,\n  \"temperature\": 1.0,\n  \"response_format\": \"auto\"\n}\n",
      },
      #{
        title: "Files",
        request: #{
          curl: "curl https://api.openai.com/v1/assistants \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"OpenAI-Beta: assistants=v2\" \\\n  -d '{\n    \"instructions\": \"You are an HR bot, and you have access to files to answer employee questions about company policies.\",\n    \"tools\": [{\"type\": \"file_search\"}],\n    \"tool_resources\": {\"file_search\": {\"vector_store_ids\": [\"vs_123\"]}},\n    \"model\": \"gpt-4o\"\n  }'\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nassistant = client.beta.assistants.create(\n    model=\"gpt-4o\",\n)\nprint(assistant.id)",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst assistant = await client.beta.assistants.create({ model: 'gpt-4o' });\n\nconsole.log(assistant.id);",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n  \"github.com/openai/openai-go/shared\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  assistant, err := client.Beta.Assistants.New(context.TODO(), openai.BetaAssistantNewParams{\n    Model: shared.ChatModelGPT5,\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", assistant.ID)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.ChatModel;\nimport com.openai.models.beta.assistants.Assistant;\nimport com.openai.models.beta.assistants.AssistantCreateParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        AssistantCreateParams params = AssistantCreateParams.builder()\n            .model(ChatModel.GPT_5)\n            .build();\n        Assistant assistant = client.beta().assistants().create(params);\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nassistant = openai.beta.assistants.create(model: :\"gpt-5\")\n\nputs(assistant)",
        },
        response: "{\n  \"id\": \"asst_abc123\",\n  \"object\": \"assistant\",\n  \"created_at\": 1699009403,\n  \"name\": \"HR Helper\",\n  \"description\": null,\n  \"model\": \"gpt-4o\",\n  \"instructions\": \"You are an HR bot, and you have access to files to answer employee questions about company policies.\",\n  \"tools\": [\n    {\n      \"type\": \"file_search\"\n    }\n  ],\n  \"tool_resources\": {\n    \"file_search\": {\n      \"vector_store_ids\": [\"vs_123\"]\n    }\n  },\n  \"metadata\": {},\n  \"top_p\": 1.0,\n  \"temperature\": 1.0,\n  \"response_format\": \"auto\"\n}\n",
      }
    ],
  }
)
@tag("Assistants")
op createAssistant(
  @body
  body: CreateAssistantRequest,
): AssistantObject;

/** Delete an assistant. */
@summary("Delete assistant")
@delete
@route("/assistants/{assistant_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Delete assistant",
    group: "assistants",
    beta: true,
    returns: "Deletion status",
    examples: #{
      response: "{\n  \"id\": \"asst_abc123\",\n  \"object\": \"assistant.deleted\",\n  \"deleted\": true\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/assistants/asst_abc123 \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"OpenAI-Beta: assistants=v2\" \\\n  -X DELETE\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nassistant_deleted = client.beta.assistants.delete(\n    \"assistant_id\",\n)\nprint(assistant_deleted.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst assistantDeleted = await client.beta.assistants.delete('assistant_id');\n\nconsole.log(assistantDeleted.id);",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  assistantDeleted, err := client.Beta.Assistants.Delete(context.TODO(), \"assistant_id\")\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", assistantDeleted.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.beta.assistants.AssistantDeleteParams;\nimport com.openai.models.beta.assistants.AssistantDeleted;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        AssistantDeleted assistantDeleted = client.beta().assistants().delete(\"assistant_id\");\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nassistant_deleted = openai.beta.assistants.delete(\"assistant_id\")\n\nputs(assistant_deleted)",
      },
    },
  }
)
@tag("Assistants")
op deleteAssistant(
  /** The ID of the assistant to delete. */
  @path
  assistant_id: string,
): DeleteAssistantResponse;

/** Retrieves an assistant. */
@summary("Retrieve assistant")
@get
@route("/assistants/{assistant_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Retrieve assistant",
    group: "assistants",
    beta: true,
    returns: "The [assistant](https://platform.openai.com/docs/api-reference/assistants/object) object matching the specified ID.",
    examples: #{
      response: "{\n  \"id\": \"asst_abc123\",\n  \"object\": \"assistant\",\n  \"created_at\": 1699009709,\n  \"name\": \"HR Helper\",\n  \"description\": null,\n  \"model\": \"gpt-4o\",\n  \"instructions\": \"You are an HR bot, and you have access to files to answer employee questions about company policies.\",\n  \"tools\": [\n    {\n      \"type\": \"file_search\"\n    }\n  ],\n  \"metadata\": {},\n  \"top_p\": 1.0,\n  \"temperature\": 1.0,\n  \"response_format\": \"auto\"\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/assistants/asst_abc123 \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"OpenAI-Beta: assistants=v2\"\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nassistant = client.beta.assistants.retrieve(\n    \"assistant_id\",\n)\nprint(assistant.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst assistant = await client.beta.assistants.retrieve('assistant_id');\n\nconsole.log(assistant.id);",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  assistant, err := client.Beta.Assistants.Get(context.TODO(), \"assistant_id\")\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", assistant.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.beta.assistants.Assistant;\nimport com.openai.models.beta.assistants.AssistantRetrieveParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        Assistant assistant = client.beta().assistants().retrieve(\"assistant_id\");\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nassistant = openai.beta.assistants.retrieve(\"assistant_id\")\n\nputs(assistant)",
      },
    },
  }
)
@tag("Assistants")
op getAssistant(
  /** The ID of the assistant to retrieve. */
  @path
  assistant_id: string,
): AssistantObject;

/** Modifies an assistant. */
@summary("Modify assistant")
@post
@route("/assistants/{assistant_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Modify assistant",
    group: "assistants",
    beta: true,
    returns: "The modified [assistant](https://platform.openai.com/docs/api-reference/assistants/object) object.",
    examples: #{
      response: "{\n  \"id\": \"asst_123\",\n  \"object\": \"assistant\",\n  \"created_at\": 1699009709,\n  \"name\": \"HR Helper\",\n  \"description\": null,\n  \"model\": \"gpt-4o\",\n  \"instructions\": \"You are an HR bot, and you have access to files to answer employee questions about company policies. Always response with info from either of the files.\",\n  \"tools\": [\n    {\n      \"type\": \"file_search\"\n    }\n  ],\n  \"tool_resources\": {\n    \"file_search\": {\n      \"vector_store_ids\": []\n    }\n  },\n  \"metadata\": {},\n  \"top_p\": 1.0,\n  \"temperature\": 1.0,\n  \"response_format\": \"auto\"\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/assistants/asst_abc123 \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"OpenAI-Beta: assistants=v2\" \\\n  -d '{\n      \"instructions\": \"You are an HR bot, and you have access to files to answer employee questions about company policies. Always response with info from either of the files.\",\n      \"tools\": [{\"type\": \"file_search\"}],\n      \"model\": \"gpt-4o\"\n    }'\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nassistant = client.beta.assistants.update(\n    assistant_id=\"assistant_id\",\n)\nprint(assistant.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst assistant = await client.beta.assistants.update('assistant_id');\n\nconsole.log(assistant.id);",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  assistant, err := client.Beta.Assistants.Update(\n    context.TODO(),\n    \"assistant_id\",\n    openai.BetaAssistantUpdateParams{\n\n    },\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", assistant.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.beta.assistants.Assistant;\nimport com.openai.models.beta.assistants.AssistantUpdateParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        Assistant assistant = client.beta().assistants().update(\"assistant_id\");\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nassistant = openai.beta.assistants.update(\"assistant_id\")\n\nputs(assistant)",
      },
    },
  }
)
@tag("Assistants")
op modifyAssistant(
  /** The ID of the assistant to modify. */
  @path
  assistant_id: string,

  @body
  body: ModifyAssistantRequest,
): AssistantObject;
