import "@typespec/http";
import "@typespec/openapi";
import "./models.tsp";
import "../responses/models.tsp";
using TypeSpec.Http;
using TypeSpec.OpenAPI;
namespace OpenAI;
/** Create a conversation. */
@summary("Create a conversation")
@post
@route("/conversations")
@extension(
  "x-oaiMeta",
  #{
    name: "Create a conversation",
    group: "conversations",
    returns: "Returns a [Conversation](https://platform.openai.com/docs/api-reference/conversations/object) object.\n",
    path: "create",
    examples: #[
      #{
        title: "Create a conversation.",
        request: #{
          curl: "curl https://api.openai.com/v1/conversations \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -d '{\n    \"metadata\": {\"topic\": \"demo\"},\n    \"items\": [\n      {\n        \"type\": \"message\",\n        \"role\": \"user\",\n        \"content\": \"Hello!\"\n      }\n    ]\n  }'\n",
          javascript: "import OpenAI from \"openai\";\nconst client = new OpenAI();\n\nconst conversation = await client.conversations.create({\n  metadata: { topic: \"demo\" },\n  items: [\n    { type: \"message\", role: \"user\", content: \"Hello!\" }\n  ],\n});\nconsole.log(conversation);\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nconversation = client.conversations.create()\nprint(conversation.id)",
          csharp: "using System;\nusing System.Collections.Generic;\nusing OpenAI.Conversations;\n\nOpenAIConversationClient client = new(\n    apiKey: Environment.GetEnvironmentVariable(\"OPENAI_API_KEY\")\n);\n\nConversation conversation = client.CreateConversation(\n    new CreateConversationOptions\n    {\n        Metadata = new Dictionary<string, string>\n        {\n            { \"topic\", \"demo\" }\n        },\n        Items =\n        {\n            new ConversationMessageInput\n            {\n                Role = \"user\",\n                Content = \"Hello!\"\n            }\n        }\n    }\n);\nConsole.WriteLine(conversation.Id);\n",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst conversation = await client.conversations.create();\n\nconsole.log(conversation.id);",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/conversations\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  conversation, err := client.Conversations.New(context.TODO(), conversations.ConversationNewParams{\n\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", conversation.ID)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.conversations.Conversation;\nimport com.openai.models.conversations.ConversationCreateParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        Conversation conversation = client.conversations().create();\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nconversation = openai.conversations.create\n\nputs(conversation)",
        },
        response: "{\n  \"id\": \"conv_123\",\n  \"object\": \"conversation\",\n  \"created_at\": 1741900000,\n  \"metadata\": {\"topic\": \"demo\"}\n}\n",
      }
    ],
  }
)
@tag("Conversations")
op createConversation(
  @body
  body: CreateConversationRequest,
): ConversationResource;

/** Delete a conversation with the given ID. */
@summary("Delete a conversation")
@delete
@route("/conversations/{conversation_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Delete a conversation",
    group: "conversations",
    returns: "A success message.\n",
    path: "delete",
    examples: #[
      #{
        title: "Delete a conversation",
        request: #{
          curl: "curl -X DELETE https://api.openai.com/v1/conversations/conv_123 \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\"\n",
          javascript: "import OpenAI from \"openai\";\nconst client = new OpenAI();\n\nconst deleted = await client.conversations.delete(\"conv_123\");\nconsole.log(deleted);\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nconversation_deleted_resource = client.conversations.delete(\n    \"conv_123\",\n)\nprint(conversation_deleted_resource.id)",
          csharp: "using System;\nusing OpenAI.Conversations;\n\nOpenAIConversationClient client = new(\n    apiKey: Environment.GetEnvironmentVariable(\"OPENAI_API_KEY\")\n);\n\nDeletedConversation deleted = client.DeleteConversation(\"conv_123\");\nConsole.WriteLine(deleted.Id);\n",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst conversationDeletedResource = await client.conversations.delete('conv_123');\n\nconsole.log(conversationDeletedResource.id);",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  conversationDeletedResource, err := client.Conversations.Delete(context.TODO(), \"conv_123\")\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", conversationDeletedResource.ID)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.conversations.ConversationDeleteParams;\nimport com.openai.models.conversations.ConversationDeletedResource;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        ConversationDeletedResource conversationDeletedResource = client.conversations().delete(\"conv_123\");\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nconversation_deleted_resource = openai.conversations.delete(\"conv_123\")\n\nputs(conversation_deleted_resource)",
        },
        response: "{\n  \"id\": \"conv_123\",\n  \"object\": \"conversation.deleted\",\n  \"deleted\": true\n}\n",
      }
    ],
  }
)
@tag("Conversations")
op deleteConversation(
  /** The ID of the conversation to delete. */
  @path
  conversation_id: string,
): DeletedConversationResource;

/** Get a conversation with the given ID. */
@summary("Retrieve a conversation")
@get
@route("/conversations/{conversation_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Retrieve a conversation",
    group: "conversations",
    returns: "Returns a [Conversation](https://platform.openai.com/docs/api-reference/conversations/object) object.\n",
    path: "retrieve",
    examples: #[
      #{
        title: "Retrieve a conversation",
        request: #{
          curl: "curl https://api.openai.com/v1/conversations/conv_123 \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\"\n",
          javascript: "import OpenAI from \"openai\";\nconst client = new OpenAI();\n\nconst conversation = await client.conversations.retrieve(\"conv_123\");\nconsole.log(conversation);\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nconversation = client.conversations.retrieve(\n    \"conv_123\",\n)\nprint(conversation.id)",
          csharp: "using System;\nusing OpenAI.Conversations;\n\nOpenAIConversationClient client = new(\n    apiKey: Environment.GetEnvironmentVariable(\"OPENAI_API_KEY\")\n);\n\nConversation conversation = client.GetConversation(\"conv_123\");\nConsole.WriteLine(conversation.Id);\n",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst conversation = await client.conversations.retrieve('conv_123');\n\nconsole.log(conversation.id);",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  conversation, err := client.Conversations.Get(context.TODO(), \"conv_123\")\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", conversation.ID)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.conversations.Conversation;\nimport com.openai.models.conversations.ConversationRetrieveParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        Conversation conversation = client.conversations().retrieve(\"conv_123\");\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nconversation = openai.conversations.retrieve(\"conv_123\")\n\nputs(conversation)",
        },
        response: "{\n  \"id\": \"conv_123\",\n  \"object\": \"conversation\",\n  \"created_at\": 1741900000,\n  \"metadata\": {\"topic\": \"demo\"}\n}\n",
      }
    ],
  }
)
@tag("Conversations")
op getConversation(
  /** The ID of the conversation to retrieve. */
  @path
  conversation_id: string,
): ConversationResource;

/** Update a conversation's metadata with the given ID. */
@summary("Update a conversation")
@post
@route("/conversations/{conversation_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Update a conversation",
    group: "conversations",
    returns: "Returns the updated [Conversation](https://platform.openai.com/docs/api-reference/conversations/object) object.\n",
    path: "update",
    examples: #[
      #{
        title: "Update conversation metadata",
        request: #{
          curl: "curl https://api.openai.com/v1/conversations/conv_123 \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -d '{\n    \"metadata\": {\"topic\": \"project-x\"}\n  }'\n",
          javascript: "import OpenAI from \"openai\";\nconst client = new OpenAI();\n\nconst updated = await client.conversations.update(\n  \"conv_123\",\n  { metadata: { topic: \"project-x\" } }\n);\nconsole.log(updated);\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nconversation = client.conversations.update(\n    conversation_id=\"conv_123\",\n    metadata={\n        \"foo\": \"string\"\n    },\n)\nprint(conversation.id)",
          csharp: "using System;\nusing System.Collections.Generic;\nusing OpenAI.Conversations;\n\nOpenAIConversationClient client = new(\n    apiKey: Environment.GetEnvironmentVariable(\"OPENAI_API_KEY\")\n);\n\nConversation updated = client.UpdateConversation(\n    conversationId: \"conv_123\",\n    new UpdateConversationOptions\n    {\n        Metadata = new Dictionary<string, string>\n        {\n            { \"topic\", \"project-x\" }\n        }\n    }\n);\nConsole.WriteLine(updated.Id);\n",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst conversation = await client.conversations.update('conv_123', { metadata: { foo: 'string' } });\n\nconsole.log(conversation.id);",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/conversations\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  conversation, err := client.Conversations.Update(\n    context.TODO(),\n    \"conv_123\",\n    conversations.ConversationUpdateParams{\n      Metadata: map[string]string{\n      \"foo\": \"string\",\n      },\n    },\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", conversation.ID)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.core.JsonValue;\nimport com.openai.models.conversations.Conversation;\nimport com.openai.models.conversations.ConversationUpdateParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        ConversationUpdateParams params = ConversationUpdateParams.builder()\n            .conversationId(\"conv_123\")\n            .metadata(ConversationUpdateParams.Metadata.builder()\n                .putAdditionalProperty(\"foo\", JsonValue.from(\"string\"))\n                .build())\n            .build();\n        Conversation conversation = client.conversations().update(params);\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nconversation = openai.conversations.update(\"conv_123\", metadata: {foo: \"string\"})\n\nputs(conversation)",
        },
        response: "{\n  \"id\": \"conv_123\",\n  \"object\": \"conversation\",\n  \"created_at\": 1741900000,\n  \"metadata\": {\"topic\": \"project-x\"}\n}\n",
      }
    ],
  }
)
@tag("Conversations")
op updateConversation(
  /** The ID of the conversation to update. */
  @path
  conversation_id: string,

  @body
  body: UpdateConversationBody,
): ConversationResource;

/** List all items for a conversation with the given ID. */
@summary("List items")
@get
@route("/conversations/{conversation_id}/items")
@extension(
  "x-oaiMeta",
  #{
    name: "List items",
    group: "conversations",
    returns: "Returns a [list object](https://platform.openai.com/docs/api-reference/conversations/list-items-object) containing Conversation items.\n",
    path: "list-items",
    examples: #[
      #{
        title: "List items in a conversation",
        request: #{
          curl: "curl \"https://api.openai.com/v1/conversations/conv_123/items?limit=10\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\"\n",
          javascript: "import OpenAI from \"openai\";\nconst client = new OpenAI();\n\nconst items = await client.conversations.items.list(\"conv_123\", { limit: 10 });\nconsole.log(items.data);\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\npage = client.conversations.items.list(\n    conversation_id=\"conv_123\",\n)\npage = page.data[0]\nprint(page)",
          csharp: "using System;\nusing OpenAI.Conversations;\n\nOpenAIConversationClient client = new(\n    apiKey: Environment.GetEnvironmentVariable(\"OPENAI_API_KEY\")\n);\n\nConversationItemList items = client.ConversationItems.List(\n    conversationId: \"conv_123\",\n    new ListConversationItemsOptions { Limit = 10 }\n);\nConsole.WriteLine(items.Data.Count);\n",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\n// Automatically fetches more pages as needed.\nfor await (const conversationItem of client.conversations.items.list('conv_123')) {\n  console.log(conversationItem);\n}",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/conversations\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  page, err := client.Conversations.Items.List(\n    context.TODO(),\n    \"conv_123\",\n    conversations.ItemListParams{\n\n    },\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", page)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.conversations.items.ItemListPage;\nimport com.openai.models.conversations.items.ItemListParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        ItemListPage page = client.conversations().items().list(\"conv_123\");\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\npage = openai.conversations.items.list(\"conv_123\")\n\nputs(page)",
        },
        response: "{\n  \"object\": \"list\",\n  \"data\": [\n    {\n      \"type\": \"message\",\n      \"id\": \"msg_abc\",\n      \"status\": \"completed\",\n      \"role\": \"user\",\n      \"content\": [\n        {\"type\": \"input_text\", \"text\": \"Hello!\"}\n      ]\n    }\n  ],\n  \"first_id\": \"msg_abc\",\n  \"last_id\": \"msg_abc\",\n  \"has_more\": false\n}\n",
      }
    ],
  }
)
@tag("Conversations")
op listConversationItems(
  /** The ID of the conversation to list items for. */
  @path
  conversation_id: string,

  /**A limit on the number of objects to be returned. Limit can range between
1 and 100, and the default is 20.*/
  @query(#{ explode: true })
  limit?: integer = 20,

  /**The order to return the input items in. Default is `desc`.
- `asc`: Return the input items in ascending order.
- `desc`: Return the input items in descending order.*/
  @query(#{ explode: true })
  order?: "asc" | "desc",

  /** An item ID to list items after, used in pagination. */
  @query(#{ explode: true })
  after?: string,

  /**Specify additional output data to include in the model response. Currently
supported values are:
- `web_search_call.action.sources`: Include the sources of the web search tool call.
- `code_interpreter_call.outputs`: Includes the outputs of python code execution
in code interpreter tool call items.
- `computer_call_output.output.image_url`: Include image urls from the computer call output.
- `file_search_call.results`: Include the search results of
the file search tool call.
- `message.input_image.image_url`: Include image urls from the input message.
- `message.output_text.logprobs`: Include logprobs with assistant messages.
- `reasoning.encrypted_content`: Includes an encrypted version of reasoning
tokens in reasoning item outputs. This enables reasoning items to be used in
multi-turn conversations when using the Responses API statelessly (like
when the `store` parameter is set to `false`, or when an organization is
enrolled in the zero data retention program).*/
  @query(#{ explode: true })
  include?: Includable[],
): ConversationItemList;

/** Create items in a conversation with the given ID. */
@summary("Create items")
@post
@route("/conversations/{conversation_id}/items")
@extension(
  "x-oaiMeta",
  #{
    name: "Create items",
    group: "conversations",
    returns: "Returns the list of added [items](https://platform.openai.com/docs/api-reference/conversations/list-items-object).\n",
    path: "create-item",
    examples: #[
      #{
        title: "Add a user message to a conversation",
        request: #{
          curl: "curl https://api.openai.com/v1/conversations/conv_123/items \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -d '{\n    \"items\": [\n      {\n        \"type\": \"message\",\n        \"role\": \"user\",\n        \"content\": [\n          {\"type\": \"input_text\", \"text\": \"Hello!\"}\n        ]\n      },\n      {\n        \"type\": \"message\",\n        \"role\": \"user\",\n        \"content\": [\n          {\"type\": \"input_text\", \"text\": \"How are you?\"}\n        ]\n      }\n    ]\n  }'\n",
          javascript: "import OpenAI from \"openai\";\nconst client = new OpenAI();\n\nconst items = await client.conversations.items.create(\n  \"conv_123\",\n  {\n    items: [\n      {\n        type: \"message\",\n        role: \"user\",\n        content: [{ type: \"input_text\", text: \"Hello!\" }],\n      },\n      {\n        type: \"message\",\n        role: \"user\",\n        content: [{ type: \"input_text\", text: \"How are you?\" }],\n      },\n    ],\n  }\n);\nconsole.log(items.data);\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nconversation_item_list = client.conversations.items.create(\n    conversation_id=\"conv_123\",\n    items=[{\n        \"content\": \"string\",\n        \"role\": \"user\",\n    }],\n)\nprint(conversation_item_list.first_id)",
          csharp: "using System;\nusing System.Collections.Generic;\nusing OpenAI.Conversations;\n\nOpenAIConversationClient client = new(\n    apiKey: Environment.GetEnvironmentVariable(\"OPENAI_API_KEY\")\n);\n\nConversationItemList created = client.ConversationItems.Create(\n    conversationId: \"conv_123\",\n    new CreateConversationItemsOptions\n    {\n        Items = new List<ConversationItem>\n        {\n            new ConversationMessage\n            {\n                Role = \"user\",\n                Content =\n                {\n                    new ConversationInputText { Text = \"Hello!\" }\n                }\n            },\n            new ConversationMessage\n            {\n                Role = \"user\",\n                Content =\n                {\n                    new ConversationInputText { Text = \"How are you?\" }\n                }\n            }\n        }\n    }\n);\nConsole.WriteLine(created.Data.Count);\n",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst conversationItemList = await client.conversations.items.create('conv_123', {\n  items: [{ content: 'string', role: 'user' }],\n});\n\nconsole.log(conversationItemList.first_id);",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/conversations\"\n  \"github.com/openai/openai-go/option\"\n  \"github.com/openai/openai-go/responses\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  conversationItemList, err := client.Conversations.Items.New(\n    context.TODO(),\n    \"conv_123\",\n    conversations.ItemNewParams{\n      Items: []responses.ResponseInputItemUnionParam{responses.ResponseInputItemUnionParam{\n        OfMessage: &responses.EasyInputMessageParam{\n          Content: responses.EasyInputMessageContentUnionParam{\n            OfString: openai.String(\"string\"),\n          },\n          Role: responses.EasyInputMessageRoleUser,\n        },\n      }},\n    },\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", conversationItemList.FirstID)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.conversations.items.ConversationItemList;\nimport com.openai.models.conversations.items.ItemCreateParams;\nimport com.openai.models.responses.EasyInputMessage;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        ItemCreateParams params = ItemCreateParams.builder()\n            .conversationId(\"conv_123\")\n            .addItem(EasyInputMessage.builder()\n                .content(\"string\")\n                .role(EasyInputMessage.Role.USER)\n                .build())\n            .build();\n        ConversationItemList conversationItemList = client.conversations().items().create(params);\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nconversation_item_list = openai.conversations.items.create(\"conv_123\", items: [{content: \"string\", role: :user}])\n\nputs(conversation_item_list)",
        },
        response: "{\n  \"object\": \"list\",\n  \"data\": [\n    {\n      \"type\": \"message\",\n      \"id\": \"msg_abc\",\n      \"status\": \"completed\",\n      \"role\": \"user\",\n      \"content\": [\n        {\"type\": \"input_text\", \"text\": \"Hello!\"}\n      ]\n    },\n    {\n      \"type\": \"message\",\n      \"id\": \"msg_def\",\n      \"status\": \"completed\",\n      \"role\": \"user\",\n      \"content\": [\n        {\"type\": \"input_text\", \"text\": \"How are you?\"}\n      ]\n    }\n  ],\n  \"first_id\": \"msg_abc\",\n  \"last_id\": \"msg_def\",\n  \"has_more\": false\n}\n",
      }
    ],
  }
)
@tag("Conversations")
op createConversationItems(
  /** The ID of the conversation to add the item to. */
  @path
  conversation_id: string,

  /**Additional fields to include in the response. See the `include`
parameter for [listing Conversation items above](https://platform.openai.com/docs/api-reference/conversations/list-items#conversations_list_items-include) for more information.*/
  @query(#{ explode: true })
  include?: Includable[],

  @body
  body: {
    @maxItems(20)
    items: InputItem[];
  },
): ConversationItemList;

/** Delete an item from a conversation with the given IDs. */
@summary("Delete an item")
@delete
@route("/conversations/{conversation_id}/items/{item_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Delete an item",
    group: "conversations",
    returns: "Returns the updated [Conversation](https://platform.openai.com/docs/api-reference/conversations/object) object.\n",
    path: "delete-item",
    examples: #[
      #{
        title: "Delete an item",
        request: #{
          curl: "curl -X DELETE https://api.openai.com/v1/conversations/conv_123/items/msg_abc \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\"\n",
          javascript: "import OpenAI from \"openai\";\nconst client = new OpenAI();\n\nconst conversation = await client.conversations.items.delete(\n  \"conv_123\",\n  \"msg_abc\"\n);\nconsole.log(conversation);\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nconversation = client.conversations.items.delete(\n    item_id=\"msg_abc\",\n    conversation_id=\"conv_123\",\n)\nprint(conversation.id)",
          csharp: "using System;\nusing OpenAI.Conversations;\n\nOpenAIConversationClient client = new(\n    apiKey: Environment.GetEnvironmentVariable(\"OPENAI_API_KEY\")\n);\n\nConversation conversation = client.ConversationItems.Delete(\n    conversationId: \"conv_123\",\n    itemId: \"msg_abc\"\n);\nConsole.WriteLine(conversation.Id);\n",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst conversation = await client.conversations.items.delete('msg_abc', { conversation_id: 'conv_123' });\n\nconsole.log(conversation.id);",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  conversation, err := client.Conversations.Items.Delete(\n    context.TODO(),\n    \"conv_123\",\n    \"msg_abc\",\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", conversation.ID)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.conversations.Conversation;\nimport com.openai.models.conversations.items.ItemDeleteParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        ItemDeleteParams params = ItemDeleteParams.builder()\n            .conversationId(\"conv_123\")\n            .itemId(\"msg_abc\")\n            .build();\n        Conversation conversation = client.conversations().items().delete(params);\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nconversation = openai.conversations.items.delete(\"msg_abc\", conversation_id: \"conv_123\")\n\nputs(conversation)",
        },
        response: "{\n  \"id\": \"conv_123\",\n  \"object\": \"conversation\",\n  \"created_at\": 1741900000,\n  \"metadata\": {\"topic\": \"demo\"}\n}\n",
      }
    ],
  }
)
@tag("Conversations")
op deleteConversationItem(
  /** The ID of the conversation that contains the item. */
  @path
  conversation_id: string,

  /** The ID of the item to delete. */
  @path
  item_id: string,
): ConversationResource;

/** Get a single item from a conversation with the given IDs. */
@summary("Retrieve an item")
@get
@route("/conversations/{conversation_id}/items/{item_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Retrieve an item",
    group: "conversations",
    returns: "Returns a [Conversation Item](https://platform.openai.com/docs/api-reference/conversations/item-object).\n",
    path: "get-item",
    examples: #[
      #{
        title: "Retrieve an item",
        request: #{
          curl: "curl https://api.openai.com/v1/conversations/conv_123/items/msg_abc \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\"\n",
          javascript: "import OpenAI from \"openai\";\nconst client = new OpenAI();\n\nconst item = await client.conversations.items.retrieve(\n  \"conv_123\",\n  \"msg_abc\"\n);\nconsole.log(item);\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nconversation_item = client.conversations.items.retrieve(\n    item_id=\"msg_abc\",\n    conversation_id=\"conv_123\",\n)\nprint(conversation_item)",
          csharp: "using System;\nusing OpenAI.Conversations;\n\nOpenAIConversationClient client = new(\n    apiKey: Environment.GetEnvironmentVariable(\"OPENAI_API_KEY\")\n);\n\nConversationItem item = client.ConversationItems.Get(\n    conversationId: \"conv_123\",\n    itemId: \"msg_abc\"\n);\nConsole.WriteLine(item.Id);\n",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst conversationItem = await client.conversations.items.retrieve('msg_abc', {\n  conversation_id: 'conv_123',\n});\n\nconsole.log(conversationItem);",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/conversations\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  conversationItem, err := client.Conversations.Items.Get(\n    context.TODO(),\n    \"conv_123\",\n    \"msg_abc\",\n    conversations.ItemGetParams{\n\n    },\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", conversationItem)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.conversations.items.ConversationItem;\nimport com.openai.models.conversations.items.ItemRetrieveParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        ItemRetrieveParams params = ItemRetrieveParams.builder()\n            .conversationId(\"conv_123\")\n            .itemId(\"msg_abc\")\n            .build();\n        ConversationItem conversationItem = client.conversations().items().retrieve(params);\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nconversation_item = openai.conversations.items.retrieve(\"msg_abc\", conversation_id: \"conv_123\")\n\nputs(conversation_item)",
        },
        response: "{\n  \"type\": \"message\",\n  \"id\": \"msg_abc\",\n  \"status\": \"completed\",\n  \"role\": \"user\",\n  \"content\": [\n    {\"type\": \"input_text\", \"text\": \"Hello!\"}\n  ]\n}\n",
      }
    ],
  }
)
@tag("Conversations")
op getConversationItem(
  /** The ID of the conversation that contains the item. */
  @path
  conversation_id: string,

  /** The ID of the item to retrieve. */
  @path
  item_id: string,

  /**Additional fields to include in the response. See the `include`
parameter for [listing Conversation items above](https://platform.openai.com/docs/api-reference/conversations/list-items#conversations_list_items-include) for more information.*/
  @query(#{ explode: true })
  include?: Includable[],
): ConversationItem;
