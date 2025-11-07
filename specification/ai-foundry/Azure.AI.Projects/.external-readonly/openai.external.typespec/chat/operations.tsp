import "@typespec/http";
import "@typespec/openapi";
import "../common/models.tsp";
import "./models.tsp";
using TypeSpec.Http;
using TypeSpec.OpenAPI;
namespace OpenAI;
/**List stored Chat Completions. Only Chat Completions that have been stored
with the `store` parameter set to `true` will be returned.*/
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@summary("List Chat Completions")
@get
@route("/chat/completions")
@extension(
  "x-oaiMeta",
  #{
    name: "List Chat Completions",
    group: "chat",
    returns: "A list of [Chat Completions](https://platform.openai.com/docs/api-reference/chat/list-object) matching the specified filters.",
    path: "list",
    examples: #{
      response: "{\n  \"object\": \"list\",\n  \"data\": [\n    {\n      \"object\": \"chat.completion\",\n      \"id\": \"chatcmpl-AyPNinnUqUDYo9SAdA52NobMflmj2\",\n      \"model\": \"gpt-4.1-2025-04-14\",\n      \"created\": 1738960610,\n      \"request_id\": \"req_ded8ab984ec4bf840f37566c1011c417\",\n      \"tool_choice\": null,\n      \"usage\": {\n        \"total_tokens\": 31,\n        \"completion_tokens\": 18,\n        \"prompt_tokens\": 13\n      },\n      \"seed\": 4944116822809979520,\n      \"top_p\": 1.0,\n      \"temperature\": 1.0,\n      \"presence_penalty\": 0.0,\n      \"frequency_penalty\": 0.0,\n      \"system_fingerprint\": \"fp_50cad350e4\",\n      \"input_user\": null,\n      \"service_tier\": \"default\",\n      \"tools\": null,\n      \"metadata\": {},\n      \"choices\": [\n        {\n          \"index\": 0,\n          \"message\": {\n            \"content\": \"Mind of circuits hum,  \\nLearning patterns in silence—  \\nFuture's quiet spark.\",\n            \"role\": \"assistant\",\n            \"tool_calls\": null,\n            \"function_call\": null\n          },\n          \"finish_reason\": \"stop\",\n          \"logprobs\": null\n        }\n      ],\n      \"response_format\": null\n    }\n  ],\n  \"first_id\": \"chatcmpl-AyPNinnUqUDYo9SAdA52NobMflmj2\",\n  \"last_id\": \"chatcmpl-AyPNinnUqUDYo9SAdA52NobMflmj2\",\n  \"has_more\": false\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/chat/completions \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\"\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\npage = client.chat.completions.list()\npage = page.data[0]\nprint(page.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\n// Automatically fetches more pages as needed.\nfor await (const chatCompletion of client.chat.completions.list()) {\n  console.log(chatCompletion.id);\n}",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  page, err := client.Chat.Completions.List(context.TODO(), openai.ChatCompletionListParams{\n\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", page)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.chat.completions.ChatCompletionListPage;\nimport com.openai.models.chat.completions.ChatCompletionListParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        ChatCompletionListPage page = client.chat().completions().list();\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\npage = openai.chat.completions.list\n\nputs(page)",
      },
    },
  }
)
@tag("Chat")
op listChatCompletions(
  /** The model used to generate the Chat Completions. */
  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "Auto-suppressed warnings non-applicable rules during import."
  @query(#{ explode: true })
  `model`?: string,

  /**A list of metadata keys to filter the Chat Completions by. Example:

`metadata[key1]=value1&metadata[key2]=value2`*/
  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "Auto-suppressed warnings non-applicable rules during import."
  @query(#{ explode: true })
  metadata?: Metadata,

  /** Identifier for the last chat completion from the previous pagination request. */
  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "Auto-suppressed warnings non-applicable rules during import."
  @query(#{ explode: true })
  after?: string,

  /** Number of Chat Completions to retrieve. */
  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "Auto-suppressed warnings non-applicable rules during import."
  @query(#{ explode: true })
  limit?: integer = 20,

  /** Sort order for Chat Completions by timestamp. Use `asc` for ascending order or `desc` for descending order. Defaults to `asc`. */
  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  @query(#{ explode: true })
  order?: "asc" | "desc" = "asc",
): ChatCompletionList;

/****Starting a new project?** We recommend trying [Responses](https://platform.openai.com/docs/api-reference/responses)
to take advantage of the latest OpenAI platform features. Compare
[Chat Completions with Responses](https://platform.openai.com/docs/guides/responses-vs-chat-completions?api-mode=responses).

---

Creates a model response for the given chat conversation. Learn more in the
[text generation](https://platform.openai.com/docs/guides/text-generation), [vision](https://platform.openai.com/docs/guides/vision),
and [audio](https://platform.openai.com/docs/guides/audio) guides.

Parameter support can differ depending on the model used to generate the
response, particularly for newer reasoning models. Parameters that are only
supported for reasoning models are noted below. For the current state of
unsupported parameters in reasoning models,
[refer to the reasoning guide](https://platform.openai.com/docs/guides/reasoning).*/
#suppress "@azure-tools/typespec-azure-core/response-schema-problem" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@summary("Create chat completion")
@post
@route("/chat/completions")
@extension(
  "x-oaiMeta",
  #{
    name: "Create chat completion",
    group: "chat",
    returns: "Returns a [chat completion](https://platform.openai.com/docs/api-reference/chat/object) object, or a streamed sequence of [chat completion chunk](https://platform.openai.com/docs/api-reference/chat/streaming) objects if the request is streamed.\n",
    path: "create",
    examples: #[
      #{
        title: "Default",
        request: #{
          curl: "curl https://api.openai.com/v1/chat/completions \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -d '{\n    \"model\": \"VAR_chat_model_id\",\n    \"messages\": [\n      {\n        \"role\": \"developer\",\n        \"content\": \"You are a helpful assistant.\"\n      },\n      {\n        \"role\": \"user\",\n        \"content\": \"Hello!\"\n      }\n    ]\n  }'\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nchat_completion = client.chat.completions.create(\n    messages=[{\n        \"content\": \"string\",\n        \"role\": \"developer\",\n    }],\n    model=\"gpt-4o\",\n)\nprint(chat_completion)",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst chatCompletion = await client.chat.completions.create({\n  messages: [{ content: 'string', role: 'developer' }],\n  model: 'gpt-4o',\n});\n\nconsole.log(chatCompletion);",
          csharp: "using System;\nusing System.Collections.Generic;\n\nusing OpenAI.Chat;\n\nChatClient client = new(\n    model: \"gpt-4.1\",\n    apiKey: Environment.GetEnvironmentVariable(\"OPENAI_API_KEY\")\n);\n\nList<ChatMessage> messages =\n[\n    new SystemChatMessage(\"You are a helpful assistant.\"),\n    new UserChatMessage(\"Hello!\")\n];\n\nChatCompletion completion = client.CompleteChat(messages);\n\nConsole.WriteLine(completion.Content[0].Text);\n",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n  \"github.com/openai/openai-go/shared\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  chatCompletion, err := client.Chat.Completions.New(context.TODO(), openai.ChatCompletionNewParams{\n    Messages: []openai.ChatCompletionMessageParamUnion{openai.ChatCompletionMessageParamUnion{\n      OfDeveloper: &openai.ChatCompletionDeveloperMessageParam{\n        Content: openai.ChatCompletionDeveloperMessageParamContentUnion{\n          OfString: openai.String(\"string\"),\n        },\n      },\n    }},\n    Model: shared.ChatModelGPT5,\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", chatCompletion)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.ChatModel;\nimport com.openai.models.chat.completions.ChatCompletion;\nimport com.openai.models.chat.completions.ChatCompletionCreateParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        ChatCompletionCreateParams params = ChatCompletionCreateParams.builder()\n            .addDeveloperMessage(\"string\")\n            .model(ChatModel.GPT_5)\n            .build();\n        ChatCompletion chatCompletion = client.chat().completions().create(params);\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nchat_completion = openai.chat.completions.create(messages: [{content: \"string\", role: :developer}], model: :\"gpt-5\")\n\nputs(chat_completion)",
        },
        response: "{\n  \"id\": \"chatcmpl-B9MBs8CjcvOU2jLn4n570S5qMJKcT\",\n  \"object\": \"chat.completion\",\n  \"created\": 1741569952,\n  \"model\": \"gpt-4.1-2025-04-14\",\n  \"choices\": [\n    {\n      \"index\": 0,\n      \"message\": {\n        \"role\": \"assistant\",\n        \"content\": \"Hello! How can I assist you today?\",\n        \"refusal\": null,\n        \"annotations\": []\n      },\n      \"logprobs\": null,\n      \"finish_reason\": \"stop\"\n    }\n  ],\n  \"usage\": {\n    \"prompt_tokens\": 19,\n    \"completion_tokens\": 10,\n    \"total_tokens\": 29,\n    \"prompt_tokens_details\": {\n      \"cached_tokens\": 0,\n      \"audio_tokens\": 0\n    },\n    \"completion_tokens_details\": {\n      \"reasoning_tokens\": 0,\n      \"audio_tokens\": 0,\n      \"accepted_prediction_tokens\": 0,\n      \"rejected_prediction_tokens\": 0\n    }\n  },\n  \"service_tier\": \"default\"\n}\n",
      },
      #{
        title: "Image input",
        request: #{
          curl: "curl https://api.openai.com/v1/chat/completions \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -d '{\n    \"model\": \"gpt-4.1\",\n    \"messages\": [\n      {\n        \"role\": \"user\",\n        \"content\": [\n          {\n            \"type\": \"text\",\n            \"text\": \"What is in this image?\"\n          },\n          {\n            \"type\": \"image_url\",\n            \"image_url\": {\n              \"url\": \"https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Gfp-wisconsin-madison-the-nature-boardwalk.jpg/2560px-Gfp-wisconsin-madison-the-nature-boardwalk.jpg\"\n            }\n          }\n        ]\n      }\n    ],\n    \"max_tokens\": 300\n  }'\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nchat_completion = client.chat.completions.create(\n    messages=[{\n        \"content\": \"string\",\n        \"role\": \"developer\",\n    }],\n    model=\"gpt-4o\",\n)\nprint(chat_completion)",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst chatCompletion = await client.chat.completions.create({\n  messages: [{ content: 'string', role: 'developer' }],\n  model: 'gpt-4o',\n});\n\nconsole.log(chatCompletion);",
          csharp: "using System;\nusing System.Collections.Generic;\n\nusing OpenAI.Chat;\n\nChatClient client = new(\n    model: \"gpt-4.1\",\n    apiKey: Environment.GetEnvironmentVariable(\"OPENAI_API_KEY\")\n);\n\nList<ChatMessage> messages =\n[\n    new UserChatMessage(\n    [\n        ChatMessageContentPart.CreateTextPart(\"What's in this image?\"),\n        ChatMessageContentPart.CreateImagePart(new Uri(\"https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Gfp-wisconsin-madison-the-nature-boardwalk.jpg/2560px-Gfp-wisconsin-madison-the-nature-boardwalk.jpg\"))\n    ])\n];\n\nChatCompletion completion = client.CompleteChat(messages);\n\nConsole.WriteLine(completion.Content[0].Text);\n",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n  \"github.com/openai/openai-go/shared\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  chatCompletion, err := client.Chat.Completions.New(context.TODO(), openai.ChatCompletionNewParams{\n    Messages: []openai.ChatCompletionMessageParamUnion{openai.ChatCompletionMessageParamUnion{\n      OfDeveloper: &openai.ChatCompletionDeveloperMessageParam{\n        Content: openai.ChatCompletionDeveloperMessageParamContentUnion{\n          OfString: openai.String(\"string\"),\n        },\n      },\n    }},\n    Model: shared.ChatModelGPT5,\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", chatCompletion)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.ChatModel;\nimport com.openai.models.chat.completions.ChatCompletion;\nimport com.openai.models.chat.completions.ChatCompletionCreateParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        ChatCompletionCreateParams params = ChatCompletionCreateParams.builder()\n            .addDeveloperMessage(\"string\")\n            .model(ChatModel.GPT_5)\n            .build();\n        ChatCompletion chatCompletion = client.chat().completions().create(params);\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nchat_completion = openai.chat.completions.create(messages: [{content: \"string\", role: :developer}], model: :\"gpt-5\")\n\nputs(chat_completion)",
        },
        response: "{\n  \"id\": \"chatcmpl-B9MHDbslfkBeAs8l4bebGdFOJ6PeG\",\n  \"object\": \"chat.completion\",\n  \"created\": 1741570283,\n  \"model\": \"gpt-4.1-2025-04-14\",\n  \"choices\": [\n    {\n      \"index\": 0,\n      \"message\": {\n        \"role\": \"assistant\",\n        \"content\": \"The image shows a wooden boardwalk path running through a lush green field or meadow. The sky is bright blue with some scattered clouds, giving the scene a serene and peaceful atmosphere. Trees and shrubs are visible in the background.\",\n        \"refusal\": null,\n        \"annotations\": []\n      },\n      \"logprobs\": null,\n      \"finish_reason\": \"stop\"\n    }\n  ],\n  \"usage\": {\n    \"prompt_tokens\": 1117,\n    \"completion_tokens\": 46,\n    \"total_tokens\": 1163,\n    \"prompt_tokens_details\": {\n      \"cached_tokens\": 0,\n      \"audio_tokens\": 0\n    },\n    \"completion_tokens_details\": {\n      \"reasoning_tokens\": 0,\n      \"audio_tokens\": 0,\n      \"accepted_prediction_tokens\": 0,\n      \"rejected_prediction_tokens\": 0\n    }\n  },\n  \"service_tier\": \"default\"\n}\n",
      },
      #{
        title: "Streaming",
        request: #{
          curl: "curl https://api.openai.com/v1/chat/completions \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -d '{\n    \"model\": \"VAR_chat_model_id\",\n    \"messages\": [\n      {\n        \"role\": \"developer\",\n        \"content\": \"You are a helpful assistant.\"\n      },\n      {\n        \"role\": \"user\",\n        \"content\": \"Hello!\"\n      }\n    ],\n    \"stream\": true\n  }'\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nchat_completion = client.chat.completions.create(\n    messages=[{\n        \"content\": \"string\",\n        \"role\": \"developer\",\n    }],\n    model=\"gpt-4o\",\n)\nprint(chat_completion)",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst chatCompletion = await client.chat.completions.create({\n  messages: [{ content: 'string', role: 'developer' }],\n  model: 'gpt-4o',\n});\n\nconsole.log(chatCompletion);",
          csharp: "using System;\nusing System.ClientModel;\nusing System.Collections.Generic;\nusing System.Threading.Tasks;\n\nusing OpenAI.Chat;\n\nChatClient client = new(\n    model: \"gpt-4.1\",\n    apiKey: Environment.GetEnvironmentVariable(\"OPENAI_API_KEY\")\n);\n\nList<ChatMessage> messages =\n[\n    new SystemChatMessage(\"You are a helpful assistant.\"),\n    new UserChatMessage(\"Hello!\")\n];\n\nAsyncCollectionResult<StreamingChatCompletionUpdate> completionUpdates = client.CompleteChatStreamingAsync(messages);\n\nawait foreach (StreamingChatCompletionUpdate completionUpdate in completionUpdates)\n{\n    if (completionUpdate.ContentUpdate.Count > 0)\n    {\n        Console.Write(completionUpdate.ContentUpdate[0].Text);\n    }\n}\n",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n  \"github.com/openai/openai-go/shared\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  chatCompletion, err := client.Chat.Completions.New(context.TODO(), openai.ChatCompletionNewParams{\n    Messages: []openai.ChatCompletionMessageParamUnion{openai.ChatCompletionMessageParamUnion{\n      OfDeveloper: &openai.ChatCompletionDeveloperMessageParam{\n        Content: openai.ChatCompletionDeveloperMessageParamContentUnion{\n          OfString: openai.String(\"string\"),\n        },\n      },\n    }},\n    Model: shared.ChatModelGPT5,\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", chatCompletion)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.ChatModel;\nimport com.openai.models.chat.completions.ChatCompletion;\nimport com.openai.models.chat.completions.ChatCompletionCreateParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        ChatCompletionCreateParams params = ChatCompletionCreateParams.builder()\n            .addDeveloperMessage(\"string\")\n            .model(ChatModel.GPT_5)\n            .build();\n        ChatCompletion chatCompletion = client.chat().completions().create(params);\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nchat_completion = openai.chat.completions.create(messages: [{content: \"string\", role: :developer}], model: :\"gpt-5\")\n\nputs(chat_completion)",
        },
        response: "{\"id\":\"chatcmpl-123\",\"object\":\"chat.completion.chunk\",\"created\":1694268190,\"model\":\"gpt-4o-mini\", \"system_fingerprint\": \"fp_44709d6fcb\", \"choices\":[{\"index\":0,\"delta\":{\"role\":\"assistant\",\"content\":\"\"},\"logprobs\":null,\"finish_reason\":null}]}\n\n{\"id\":\"chatcmpl-123\",\"object\":\"chat.completion.chunk\",\"created\":1694268190,\"model\":\"gpt-4o-mini\", \"system_fingerprint\": \"fp_44709d6fcb\", \"choices\":[{\"index\":0,\"delta\":{\"content\":\"Hello\"},\"logprobs\":null,\"finish_reason\":null}]}\n\n....\n\n{\"id\":\"chatcmpl-123\",\"object\":\"chat.completion.chunk\",\"created\":1694268190,\"model\":\"gpt-4o-mini\", \"system_fingerprint\": \"fp_44709d6fcb\", \"choices\":[{\"index\":0,\"delta\":{},\"logprobs\":null,\"finish_reason\":\"stop\"}]}\n",
      },
      #{
        title: "Functions",
        request: #{
          curl: "curl https://api.openai.com/v1/chat/completions \\\n-H \"Content-Type: application/json\" \\\n-H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n-d '{\n  \"model\": \"gpt-4.1\",\n  \"messages\": [\n    {\n      \"role\": \"user\",\n      \"content\": \"What is the weather like in Boston today?\"\n    }\n  ],\n  \"tools\": [\n    {\n      \"type\": \"function\",\n      \"function\": {\n        \"name\": \"get_current_weather\",\n        \"description\": \"Get the current weather in a given location\",\n        \"parameters\": {\n          \"type\": \"object\",\n          \"properties\": {\n            \"location\": {\n              \"type\": \"string\",\n              \"description\": \"The city and state, e.g. San Francisco, CA\"\n            },\n            \"unit\": {\n              \"type\": \"string\",\n              \"enum\": [\"celsius\", \"fahrenheit\"]\n            }\n          },\n          \"required\": [\"location\"]\n        }\n      }\n    }\n  ],\n  \"tool_choice\": \"auto\"\n}'\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nchat_completion = client.chat.completions.create(\n    messages=[{\n        \"content\": \"string\",\n        \"role\": \"developer\",\n    }],\n    model=\"gpt-4o\",\n)\nprint(chat_completion)",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst chatCompletion = await client.chat.completions.create({\n  messages: [{ content: 'string', role: 'developer' }],\n  model: 'gpt-4o',\n});\n\nconsole.log(chatCompletion);",
          csharp: "using System;\nusing System.Collections.Generic;\n\nusing OpenAI.Chat;\n\nChatClient client = new(\n    model: \"gpt-4.1\",\n    apiKey: Environment.GetEnvironmentVariable(\"OPENAI_API_KEY\")\n);\n\nChatTool getCurrentWeatherTool = ChatTool.CreateFunctionTool(\n    functionName: \"get_current_weather\",\n    functionDescription: \"Get the current weather in a given location\",\n    functionParameters: BinaryData.FromString(\"\"\"\n        {\n            \"type\": \"object\",\n            \"properties\": {\n                \"location\": {\n                    \"type\": \"string\",\n                    \"description\": \"The city and state, e.g. San Francisco, CA\"\n                },\n                \"unit\": {\n                    \"type\": \"string\",\n                    \"enum\": [ \"celsius\", \"fahrenheit\" ]\n                }\n            },\n            \"required\": [ \"location\" ]\n        }\n    \"\"\")\n);\n\nList<ChatMessage> messages =\n[\n    new UserChatMessage(\"What's the weather like in Boston today?\"),\n];\n\nChatCompletionOptions options = new()\n{\n    Tools =\n    {\n        getCurrentWeatherTool\n    },\n    ToolChoice = ChatToolChoice.CreateAutoChoice(),\n};\n\nChatCompletion completion = client.CompleteChat(messages, options);\n",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n  \"github.com/openai/openai-go/shared\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  chatCompletion, err := client.Chat.Completions.New(context.TODO(), openai.ChatCompletionNewParams{\n    Messages: []openai.ChatCompletionMessageParamUnion{openai.ChatCompletionMessageParamUnion{\n      OfDeveloper: &openai.ChatCompletionDeveloperMessageParam{\n        Content: openai.ChatCompletionDeveloperMessageParamContentUnion{\n          OfString: openai.String(\"string\"),\n        },\n      },\n    }},\n    Model: shared.ChatModelGPT5,\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", chatCompletion)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.ChatModel;\nimport com.openai.models.chat.completions.ChatCompletion;\nimport com.openai.models.chat.completions.ChatCompletionCreateParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        ChatCompletionCreateParams params = ChatCompletionCreateParams.builder()\n            .addDeveloperMessage(\"string\")\n            .model(ChatModel.GPT_5)\n            .build();\n        ChatCompletion chatCompletion = client.chat().completions().create(params);\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nchat_completion = openai.chat.completions.create(messages: [{content: \"string\", role: :developer}], model: :\"gpt-5\")\n\nputs(chat_completion)",
        },
        response: "{\n  \"id\": \"chatcmpl-abc123\",\n  \"object\": \"chat.completion\",\n  \"created\": 1699896916,\n  \"model\": \"gpt-4o-mini\",\n  \"choices\": [\n    {\n      \"index\": 0,\n      \"message\": {\n        \"role\": \"assistant\",\n        \"content\": null,\n        \"tool_calls\": [\n          {\n            \"id\": \"call_abc123\",\n            \"type\": \"function\",\n            \"function\": {\n              \"name\": \"get_current_weather\",\n              \"arguments\": \"{\\n\\\"location\\\": \\\"Boston, MA\\\"\\n}\"\n            }\n          }\n        ]\n      },\n      \"logprobs\": null,\n      \"finish_reason\": \"tool_calls\"\n    }\n  ],\n  \"usage\": {\n    \"prompt_tokens\": 82,\n    \"completion_tokens\": 17,\n    \"total_tokens\": 99,\n    \"completion_tokens_details\": {\n      \"reasoning_tokens\": 0,\n      \"accepted_prediction_tokens\": 0,\n      \"rejected_prediction_tokens\": 0\n    }\n  }\n}\n",
      },
      #{
        title: "Logprobs",
        request: #{
          curl: "curl https://api.openai.com/v1/chat/completions \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -d '{\n    \"model\": \"VAR_chat_model_id\",\n    \"messages\": [\n      {\n        \"role\": \"user\",\n        \"content\": \"Hello!\"\n      }\n    ],\n    \"logprobs\": true,\n    \"top_logprobs\": 2\n  }'\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nchat_completion = client.chat.completions.create(\n    messages=[{\n        \"content\": \"string\",\n        \"role\": \"developer\",\n    }],\n    model=\"gpt-4o\",\n)\nprint(chat_completion)",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst chatCompletion = await client.chat.completions.create({\n  messages: [{ content: 'string', role: 'developer' }],\n  model: 'gpt-4o',\n});\n\nconsole.log(chatCompletion);",
          csharp: "using System;\nusing System.Collections.Generic;\n\nusing OpenAI.Chat;\n\nChatClient client = new(\n    model: \"gpt-4.1\",\n    apiKey: Environment.GetEnvironmentVariable(\"OPENAI_API_KEY\")\n);\n\nList<ChatMessage> messages =\n[\n    new UserChatMessage(\"Hello!\")\n];\n\nChatCompletionOptions options = new()\n{\n    IncludeLogProbabilities = true,\n    TopLogProbabilityCount = 2\n};\n\nChatCompletion completion = client.CompleteChat(messages, options);\n\nConsole.WriteLine(completion.Content[0].Text);\n",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n  \"github.com/openai/openai-go/shared\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  chatCompletion, err := client.Chat.Completions.New(context.TODO(), openai.ChatCompletionNewParams{\n    Messages: []openai.ChatCompletionMessageParamUnion{openai.ChatCompletionMessageParamUnion{\n      OfDeveloper: &openai.ChatCompletionDeveloperMessageParam{\n        Content: openai.ChatCompletionDeveloperMessageParamContentUnion{\n          OfString: openai.String(\"string\"),\n        },\n      },\n    }},\n    Model: shared.ChatModelGPT5,\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", chatCompletion)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.ChatModel;\nimport com.openai.models.chat.completions.ChatCompletion;\nimport com.openai.models.chat.completions.ChatCompletionCreateParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        ChatCompletionCreateParams params = ChatCompletionCreateParams.builder()\n            .addDeveloperMessage(\"string\")\n            .model(ChatModel.GPT_5)\n            .build();\n        ChatCompletion chatCompletion = client.chat().completions().create(params);\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nchat_completion = openai.chat.completions.create(messages: [{content: \"string\", role: :developer}], model: :\"gpt-5\")\n\nputs(chat_completion)",
        },
        response: "{\n  \"id\": \"chatcmpl-123\",\n  \"object\": \"chat.completion\",\n  \"created\": 1702685778,\n  \"model\": \"gpt-4o-mini\",\n  \"choices\": [\n    {\n      \"index\": 0,\n      \"message\": {\n        \"role\": \"assistant\",\n        \"content\": \"Hello! How can I assist you today?\"\n      },\n      \"logprobs\": {\n        \"content\": [\n          {\n            \"token\": \"Hello\",\n            \"logprob\": -0.31725305,\n            \"bytes\": [72, 101, 108, 108, 111],\n            \"top_logprobs\": [\n              {\n                \"token\": \"Hello\",\n                \"logprob\": -0.31725305,\n                \"bytes\": [72, 101, 108, 108, 111]\n              },\n              {\n                \"token\": \"Hi\",\n                \"logprob\": -1.3190403,\n                \"bytes\": [72, 105]\n              }\n            ]\n          },\n          {\n            \"token\": \"!\",\n            \"logprob\": -0.02380986,\n            \"bytes\": [\n              33\n            ],\n            \"top_logprobs\": [\n              {\n                \"token\": \"!\",\n                \"logprob\": -0.02380986,\n                \"bytes\": [33]\n              },\n              {\n                \"token\": \" there\",\n                \"logprob\": -3.787621,\n                \"bytes\": [32, 116, 104, 101, 114, 101]\n              }\n            ]\n          },\n          {\n            \"token\": \" How\",\n            \"logprob\": -0.000054669687,\n            \"bytes\": [32, 72, 111, 119],\n            \"top_logprobs\": [\n              {\n                \"token\": \" How\",\n                \"logprob\": -0.000054669687,\n                \"bytes\": [32, 72, 111, 119]\n              },\n              {\n                \"token\": \"<|end|>\",\n                \"logprob\": -10.953937,\n                \"bytes\": null\n              }\n            ]\n          },\n          {\n            \"token\": \" can\",\n            \"logprob\": -0.015801601,\n            \"bytes\": [32, 99, 97, 110],\n            \"top_logprobs\": [\n              {\n                \"token\": \" can\",\n                \"logprob\": -0.015801601,\n                \"bytes\": [32, 99, 97, 110]\n              },\n              {\n                \"token\": \" may\",\n                \"logprob\": -4.161023,\n                \"bytes\": [32, 109, 97, 121]\n              }\n            ]\n          },\n          {\n            \"token\": \" I\",\n            \"logprob\": -3.7697225e-6,\n            \"bytes\": [\n              32,\n              73\n            ],\n            \"top_logprobs\": [\n              {\n                \"token\": \" I\",\n                \"logprob\": -3.7697225e-6,\n                \"bytes\": [32, 73]\n              },\n              {\n                \"token\": \" assist\",\n                \"logprob\": -13.596657,\n                \"bytes\": [32, 97, 115, 115, 105, 115, 116]\n              }\n            ]\n          },\n          {\n            \"token\": \" assist\",\n            \"logprob\": -0.04571125,\n            \"bytes\": [32, 97, 115, 115, 105, 115, 116],\n            \"top_logprobs\": [\n              {\n                \"token\": \" assist\",\n                \"logprob\": -0.04571125,\n                \"bytes\": [32, 97, 115, 115, 105, 115, 116]\n              },\n              {\n                \"token\": \" help\",\n                \"logprob\": -3.1089056,\n                \"bytes\": [32, 104, 101, 108, 112]\n              }\n            ]\n          },\n          {\n            \"token\": \" you\",\n            \"logprob\": -5.4385737e-6,\n            \"bytes\": [32, 121, 111, 117],\n            \"top_logprobs\": [\n              {\n                \"token\": \" you\",\n                \"logprob\": -5.4385737e-6,\n                \"bytes\": [32, 121, 111, 117]\n              },\n              {\n                \"token\": \" today\",\n                \"logprob\": -12.807695,\n                \"bytes\": [32, 116, 111, 100, 97, 121]\n              }\n            ]\n          },\n          {\n            \"token\": \" today\",\n            \"logprob\": -0.0040071653,\n            \"bytes\": [32, 116, 111, 100, 97, 121],\n            \"top_logprobs\": [\n              {\n                \"token\": \" today\",\n                \"logprob\": -0.0040071653,\n                \"bytes\": [32, 116, 111, 100, 97, 121]\n              },\n              {\n                \"token\": \"?\",\n                \"logprob\": -5.5247097,\n                \"bytes\": [63]\n              }\n            ]\n          },\n          {\n            \"token\": \"?\",\n            \"logprob\": -0.0008108172,\n            \"bytes\": [63],\n            \"top_logprobs\": [\n              {\n                \"token\": \"?\",\n                \"logprob\": -0.0008108172,\n                \"bytes\": [63]\n              },\n              {\n                \"token\": \"?\\n\",\n                \"logprob\": -7.184561,\n                \"bytes\": [63, 10]\n              }\n            ]\n          }\n        ]\n      },\n      \"finish_reason\": \"stop\"\n    }\n  ],\n  \"usage\": {\n    \"prompt_tokens\": 9,\n    \"completion_tokens\": 9,\n    \"total_tokens\": 18,\n    \"completion_tokens_details\": {\n      \"reasoning_tokens\": 0,\n      \"accepted_prediction_tokens\": 0,\n      \"rejected_prediction_tokens\": 0\n    }\n  },\n  \"system_fingerprint\": null\n}\n",
      }
    ],
  }
)
@tag("Chat")
op createChatCompletion(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  @body
  body: CreateChatCompletionRequest,
): CreateChatCompletionResponse | CreateChatCompletionStreamingResponse;

/**Delete a stored chat completion. Only Chat Completions that have been
created with the `store` parameter set to `true` can be deleted.*/
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@summary("Delete chat completion")
@delete
@route("/chat/completions/{completion_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Delete chat completion",
    group: "chat",
    returns: "A deletion confirmation object.",
    examples: #{
      response: "{\n  \"object\": \"chat.completion.deleted\",\n  \"id\": \"chatcmpl-AyPNinnUqUDYo9SAdA52NobMflmj2\",\n  \"deleted\": true\n}\n",
      request: #{
        curl: "curl -X DELETE https://api.openai.com/v1/chat/completions/chat_abc123 \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\"\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nchat_completion_deleted = client.chat.completions.delete(\n    \"completion_id\",\n)\nprint(chat_completion_deleted.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst chatCompletionDeleted = await client.chat.completions.delete('completion_id');\n\nconsole.log(chatCompletionDeleted.id);",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  chatCompletionDeleted, err := client.Chat.Completions.Delete(context.TODO(), \"completion_id\")\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", chatCompletionDeleted.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.chat.completions.ChatCompletionDeleteParams;\nimport com.openai.models.chat.completions.ChatCompletionDeleted;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        ChatCompletionDeleted chatCompletionDeleted = client.chat().completions().delete(\"completion_id\");\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nchat_completion_deleted = openai.chat.completions.delete(\"completion_id\")\n\nputs(chat_completion_deleted)",
      },
    },
  }
)
@tag("Chat")
op deleteChatCompletion(
  /** The ID of the chat completion to delete. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  @path
  completion_id: string,
): ChatCompletionDeleted;

/**Get a stored chat completion. Only Chat Completions that have been created
with the `store` parameter set to `true` will be returned.*/
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@summary("Get chat completion")
@get
@route("/chat/completions/{completion_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Get chat completion",
    group: "chat",
    returns: "The [ChatCompletion](https://platform.openai.com/docs/api-reference/chat/object) object matching the specified ID.",
    examples: #{
      response: "{\n  \"object\": \"chat.completion\",\n  \"id\": \"chatcmpl-abc123\",\n  \"model\": \"gpt-4o-2024-08-06\",\n  \"created\": 1738960610,\n  \"request_id\": \"req_ded8ab984ec4bf840f37566c1011c417\",\n  \"tool_choice\": null,\n  \"usage\": {\n    \"total_tokens\": 31,\n    \"completion_tokens\": 18,\n    \"prompt_tokens\": 13\n  },\n  \"seed\": 4944116822809979520,\n  \"top_p\": 1.0,\n  \"temperature\": 1.0,\n  \"presence_penalty\": 0.0,\n  \"frequency_penalty\": 0.0,\n  \"system_fingerprint\": \"fp_50cad350e4\",\n  \"input_user\": null,\n  \"service_tier\": \"default\",\n  \"tools\": null,\n  \"metadata\": {},\n  \"choices\": [\n    {\n      \"index\": 0,\n      \"message\": {\n        \"content\": \"Mind of circuits hum,  \\nLearning patterns in silence—  \\nFuture's quiet spark.\",\n        \"role\": \"assistant\",\n        \"tool_calls\": null,\n        \"function_call\": null\n      },\n      \"finish_reason\": \"stop\",\n      \"logprobs\": null\n    }\n  ],\n  \"response_format\": null\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/chat/completions/chatcmpl-abc123 \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\"\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nchat_completion = client.chat.completions.retrieve(\n    \"completion_id\",\n)\nprint(chat_completion.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst chatCompletion = await client.chat.completions.retrieve('completion_id');\n\nconsole.log(chatCompletion.id);",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  chatCompletion, err := client.Chat.Completions.Get(context.TODO(), \"completion_id\")\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", chatCompletion.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.chat.completions.ChatCompletion;\nimport com.openai.models.chat.completions.ChatCompletionRetrieveParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        ChatCompletion chatCompletion = client.chat().completions().retrieve(\"completion_id\");\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nchat_completion = openai.chat.completions.retrieve(\"completion_id\")\n\nputs(chat_completion)",
      },
    },
  }
)
@tag("Chat")
op getChatCompletion(
  /** The ID of the chat completion to retrieve. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  @path
  completion_id: string,
): CreateChatCompletionResponse;

/**Modify a stored chat completion. Only Chat Completions that have been
created with the `store` parameter set to `true` can be modified. Currently,
the only supported modification is to update the `metadata` field.*/
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@summary("Update chat completion")
@post
@route("/chat/completions/{completion_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Update chat completion",
    group: "chat",
    returns: "The [ChatCompletion](https://platform.openai.com/docs/api-reference/chat/object) object matching the specified ID.",
    examples: #{
      response: "{\n  \"object\": \"chat.completion\",\n  \"id\": \"chatcmpl-AyPNinnUqUDYo9SAdA52NobMflmj2\",\n  \"model\": \"gpt-4o-2024-08-06\",\n  \"created\": 1738960610,\n  \"request_id\": \"req_ded8ab984ec4bf840f37566c1011c417\",\n  \"tool_choice\": null,\n  \"usage\": {\n    \"total_tokens\": 31,\n    \"completion_tokens\": 18,\n    \"prompt_tokens\": 13\n  },\n  \"seed\": 4944116822809979520,\n  \"top_p\": 1.0,\n  \"temperature\": 1.0,\n  \"presence_penalty\": 0.0,\n  \"frequency_penalty\": 0.0,\n  \"system_fingerprint\": \"fp_50cad350e4\",\n  \"input_user\": null,\n  \"service_tier\": \"default\",\n  \"tools\": null,\n  \"metadata\": {\n    \"foo\": \"bar\"\n  },\n  \"choices\": [\n    {\n      \"index\": 0,\n      \"message\": {\n        \"content\": \"Mind of circuits hum,  \\nLearning patterns in silence—  \\nFuture's quiet spark.\",\n        \"role\": \"assistant\",\n        \"tool_calls\": null,\n        \"function_call\": null\n      },\n      \"finish_reason\": \"stop\",\n      \"logprobs\": null\n    }\n  ],\n  \"response_format\": null\n}\n",
      request: #{
        curl: "curl -X POST https://api.openai.com/v1/chat/completions/chat_abc123 \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -d '{\"metadata\": {\"foo\": \"bar\"}}'\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nchat_completion = client.chat.completions.update(\n    completion_id=\"completion_id\",\n    metadata={\n        \"foo\": \"string\"\n    },\n)\nprint(chat_completion.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst chatCompletion = await client.chat.completions.update('completion_id', { metadata: { foo: 'string' } });\n\nconsole.log(chatCompletion.id);",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n  \"github.com/openai/openai-go/shared\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  chatCompletion, err := client.Chat.Completions.Update(\n    context.TODO(),\n    \"completion_id\",\n    openai.ChatCompletionUpdateParams{\n      Metadata: shared.Metadata{\n      \"foo\": \"string\",\n      },\n    },\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", chatCompletion.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.core.JsonValue;\nimport com.openai.models.chat.completions.ChatCompletion;\nimport com.openai.models.chat.completions.ChatCompletionUpdateParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        ChatCompletionUpdateParams params = ChatCompletionUpdateParams.builder()\n            .completionId(\"completion_id\")\n            .metadata(ChatCompletionUpdateParams.Metadata.builder()\n                .putAdditionalProperty(\"foo\", JsonValue.from(\"string\"))\n                .build())\n            .build();\n        ChatCompletion chatCompletion = client.chat().completions().update(params);\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nchat_completion = openai.chat.completions.update(\"completion_id\", metadata: {foo: \"string\"})\n\nputs(chat_completion)",
      },
    },
  }
)
@tag("Chat")
op updateChatCompletion(
  /** The ID of the chat completion to update. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  @path
  completion_id: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  @body
  body: UpdateChatCompletionParametersBody,
): CreateChatCompletionResponse;

/**Get the messages in a stored chat completion. Only Chat Completions that
have been created with the `store` parameter set to `true` will be
returned.*/
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@summary("Get chat messages")
@get
@route("/chat/completions/{completion_id}/messages")
@extension(
  "x-oaiMeta",
  #{
    name: "Get chat messages",
    group: "chat",
    returns: "A list of [messages](https://platform.openai.com/docs/api-reference/chat/message-list) for the specified chat completion.",
    examples: #{
      response: "{\n  \"object\": \"list\",\n  \"data\": [\n    {\n      \"id\": \"chatcmpl-AyPNinnUqUDYo9SAdA52NobMflmj2-0\",\n      \"role\": \"user\",\n      \"content\": \"write a haiku about ai\",\n      \"name\": null,\n      \"content_parts\": null\n    }\n  ],\n  \"first_id\": \"chatcmpl-AyPNinnUqUDYo9SAdA52NobMflmj2-0\",\n  \"last_id\": \"chatcmpl-AyPNinnUqUDYo9SAdA52NobMflmj2-0\",\n  \"has_more\": false\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/chat/completions/chat_abc123/messages \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\"\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\npage = client.chat.completions.messages.list(\n    completion_id=\"completion_id\",\n)\npage = page.data[0]\nprint(page)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\n// Automatically fetches more pages as needed.\nfor await (const chatCompletionStoreMessage of client.chat.completions.messages.list('completion_id')) {\n  console.log(chatCompletionStoreMessage);\n}",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  page, err := client.Chat.Completions.Messages.List(\n    context.TODO(),\n    \"completion_id\",\n    openai.ChatCompletionMessageListParams{\n\n    },\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", page)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.chat.completions.messages.MessageListPage;\nimport com.openai.models.chat.completions.messages.MessageListParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        MessageListPage page = client.chat().completions().messages().list(\"completion_id\");\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\npage = openai.chat.completions.messages.list(\"completion_id\")\n\nputs(page)",
      },
    },
  }
)
@tag("Chat")
op getChatCompletionMessages(
  /** The ID of the chat completion to retrieve messages from. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Auto-suppressed warnings non-applicable rules during import."
  @path
  completion_id: string,

  /** Identifier for the last message from the previous pagination request. */
  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "Auto-suppressed warnings non-applicable rules during import."
  @query(#{ explode: true })
  after?: string,

  /** Number of messages to retrieve. */
  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "Auto-suppressed warnings non-applicable rules during import."
  @query(#{ explode: true })
  limit?: integer = 20,

  /** Sort order for messages by timestamp. Use `asc` for ascending order or `desc` for descending order. Defaults to `asc`. */
  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "Auto-suppressed warnings non-applicable rules during import."
  #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Auto-suppressed warnings non-applicable rules during import."
  @query(#{ explode: true })
  order?: "asc" | "desc" = "asc",
): ChatCompletionMessageList;
