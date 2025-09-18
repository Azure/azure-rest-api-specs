import "@typespec/http";
import "@typespec/openapi";
import "./models.tsp";
using TypeSpec.Http;
using TypeSpec.OpenAPI;
namespace OpenAI;
/** Creates a completion for the provided prompt and parameters. */
@summary("Create completion")
@post
@route("/completions")
@extension(
  "x-oaiMeta",
  #{
    name: "Create completion",
    group: "completions",
    returns: "Returns a [completion](https://platform.openai.com/docs/api-reference/completions/object) object, or a sequence of completion objects if the request is streamed.\n",
    legacy: true,
    examples: #[
      #{
        title: "No streaming",
        request: #{
          curl: "curl https://api.openai.com/v1/completions \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -d '{\n    \"model\": \"VAR_completion_model_id\",\n    \"prompt\": \"Say this is a test\",\n    \"max_tokens\": 7,\n    \"temperature\": 0\n  }'\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\ncompletion = client.completions.create(\n    model=\"string\",\n    prompt=\"This is a test.\",\n)\nprint(completion)",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst completion = await client.completions.create({ model: 'string', prompt: 'This is a test.' });\n\nconsole.log(completion);",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  completion, err := client.Completions.New(context.TODO(), openai.CompletionNewParams{\n    Model: openai.CompletionNewParamsModelGPT3_5TurboInstruct,\n    Prompt: openai.CompletionNewParamsPromptUnion{\n      OfString: openai.String(\"This is a test.\"),\n    },\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", completion)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.completions.Completion;\nimport com.openai.models.completions.CompletionCreateParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        CompletionCreateParams params = CompletionCreateParams.builder()\n            .model(CompletionCreateParams.Model.GPT_3_5_TURBO_INSTRUCT)\n            .prompt(\"This is a test.\")\n            .build();\n        Completion completion = client.completions().create(params);\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\ncompletion = openai.completions.create(model: :\"gpt-3.5-turbo-instruct\", prompt: \"This is a test.\")\n\nputs(completion)",
        },
        response: "{\n  \"id\": \"cmpl-uqkvlQyYK7bGYrRHQ0eXlWi7\",\n  \"object\": \"text_completion\",\n  \"created\": 1589478378,\n  \"model\": \"VAR_completion_model_id\",\n  \"system_fingerprint\": \"fp_44709d6fcb\",\n  \"choices\": [\n    {\n      \"text\": \"\\n\\nThis is indeed a test\",\n      \"index\": 0,\n      \"logprobs\": null,\n      \"finish_reason\": \"length\"\n    }\n  ],\n  \"usage\": {\n    \"prompt_tokens\": 5,\n    \"completion_tokens\": 7,\n    \"total_tokens\": 12\n  }\n}\n",
      },
      #{
        title: "Streaming",
        request: #{
          curl: "curl https://api.openai.com/v1/completions \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -d '{\n    \"model\": \"VAR_completion_model_id\",\n    \"prompt\": \"Say this is a test\",\n    \"max_tokens\": 7,\n    \"temperature\": 0,\n    \"stream\": true\n  }'\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\ncompletion = client.completions.create(\n    model=\"string\",\n    prompt=\"This is a test.\",\n)\nprint(completion)",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst completion = await client.completions.create({ model: 'string', prompt: 'This is a test.' });\n\nconsole.log(completion);",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  completion, err := client.Completions.New(context.TODO(), openai.CompletionNewParams{\n    Model: openai.CompletionNewParamsModelGPT3_5TurboInstruct,\n    Prompt: openai.CompletionNewParamsPromptUnion{\n      OfString: openai.String(\"This is a test.\"),\n    },\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", completion)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.completions.Completion;\nimport com.openai.models.completions.CompletionCreateParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        CompletionCreateParams params = CompletionCreateParams.builder()\n            .model(CompletionCreateParams.Model.GPT_3_5_TURBO_INSTRUCT)\n            .prompt(\"This is a test.\")\n            .build();\n        Completion completion = client.completions().create(params);\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\ncompletion = openai.completions.create(model: :\"gpt-3.5-turbo-instruct\", prompt: \"This is a test.\")\n\nputs(completion)",
        },
        response: "{\n  \"id\": \"cmpl-7iA7iJjj8V2zOkCGvWF2hAkDWBQZe\",\n  \"object\": \"text_completion\",\n  \"created\": 1690759702,\n  \"choices\": [\n    {\n      \"text\": \"This\",\n      \"index\": 0,\n      \"logprobs\": null,\n      \"finish_reason\": null\n    }\n  ],\n  \"model\": \"gpt-3.5-turbo-instruct\"\n  \"system_fingerprint\": \"fp_44709d6fcb\",\n}\n",
      }
    ],
  }
)
@tag("Completions")
op createCompletion(
  @body
  body: CreateCompletionRequest,
): CreateCompletionResponse;
