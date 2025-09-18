import "@typespec/http";
import "@typespec/openapi";
import "./models.tsp";
using TypeSpec.Http;
using TypeSpec.OpenAPI;
namespace OpenAI;
/**Classifies if text and/or image inputs are potentially harmful. Learn
more in the [moderation guide](https://platform.openai.com/docs/guides/moderation).*/
@summary("Create moderation")
@post
@route("/moderations")
@extension(
  "x-oaiMeta",
  #{
    name: "Create moderation",
    group: "moderations",
    returns: "A [moderation](https://platform.openai.com/docs/api-reference/moderations/object) object.",
    examples: #[
      #{
        title: "Single string",
        request: #{
          curl: "curl https://api.openai.com/v1/moderations \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -d '{\n    \"input\": \"I want to kill them.\"\n  }'\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nmoderation = client.moderations.create(\n    input=\"I want to kill them.\",\n)\nprint(moderation.id)",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst moderation = await client.moderations.create({ input: 'I want to kill them.' });\n\nconsole.log(moderation.id);",
          csharp: "using System;\nusing System.ClientModel;\n\nusing OpenAI.Moderations;\n\nModerationClient client = new(\n    model: \"omni-moderation-latest\",\n    apiKey: Environment.GetEnvironmentVariable(\"OPENAI_API_KEY\")\n);\n\nClientResult<ModerationResult> moderation = client.ClassifyText(\"I want to kill them.\");\n",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  moderation, err := client.Moderations.New(context.TODO(), openai.ModerationNewParams{\n    Input: openai.ModerationNewParamsInputUnion{\n      OfString: openai.String(\"I want to kill them.\"),\n    },\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", moderation.ID)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.moderations.ModerationCreateParams;\nimport com.openai.models.moderations.ModerationCreateResponse;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        ModerationCreateParams params = ModerationCreateParams.builder()\n            .input(\"I want to kill them.\")\n            .build();\n        ModerationCreateResponse moderation = client.moderations().create(params);\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nmoderation = openai.moderations.create(input: \"I want to kill them.\")\n\nputs(moderation)",
        },
        response: "{\n  \"id\": \"modr-AB8CjOTu2jiq12hp1AQPfeqFWaORR\",\n  \"model\": \"text-moderation-007\",\n  \"results\": [\n    {\n      \"flagged\": true,\n      \"categories\": {\n        \"sexual\": false,\n        \"hate\": false,\n        \"harassment\": true,\n        \"self-harm\": false,\n        \"sexual/minors\": false,\n        \"hate/threatening\": false,\n        \"violence/graphic\": false,\n        \"self-harm/intent\": false,\n        \"self-harm/instructions\": false,\n        \"harassment/threatening\": true,\n        \"violence\": true\n      },\n      \"category_scores\": {\n        \"sexual\": 0.000011726012417057063,\n        \"hate\": 0.22706663608551025,\n        \"harassment\": 0.5215635299682617,\n        \"self-harm\": 2.227119921371923e-6,\n        \"sexual/minors\": 7.107352217872176e-8,\n        \"hate/threatening\": 0.023547329008579254,\n        \"violence/graphic\": 0.00003391829886822961,\n        \"self-harm/intent\": 1.646940972932498e-6,\n        \"self-harm/instructions\": 1.1198755256458526e-9,\n        \"harassment/threatening\": 0.5694745779037476,\n        \"violence\": 0.9971134662628174\n      }\n    }\n  ]\n}\n",
      },
      #{
        title: "Image and text",
        request: #{
          curl: "curl https://api.openai.com/v1/moderations \\\n  -X POST \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -d '{\n    \"model\": \"omni-moderation-latest\",\n    \"input\": [\n      { \"type\": \"text\", \"text\": \"...text to classify goes here...\" },\n      {\n        \"type\": \"image_url\",\n        \"image_url\": {\n          \"url\": \"https://example.com/image.png\"\n        }\n      }\n    ]\n  }'\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nmoderation = client.moderations.create(\n    input=\"I want to kill them.\",\n)\nprint(moderation.id)",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst moderation = await client.moderations.create({ input: 'I want to kill them.' });\n\nconsole.log(moderation.id);",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  moderation, err := client.Moderations.New(context.TODO(), openai.ModerationNewParams{\n    Input: openai.ModerationNewParamsInputUnion{\n      OfString: openai.String(\"I want to kill them.\"),\n    },\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", moderation.ID)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.moderations.ModerationCreateParams;\nimport com.openai.models.moderations.ModerationCreateResponse;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        ModerationCreateParams params = ModerationCreateParams.builder()\n            .input(\"I want to kill them.\")\n            .build();\n        ModerationCreateResponse moderation = client.moderations().create(params);\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nmoderation = openai.moderations.create(input: \"I want to kill them.\")\n\nputs(moderation)",
        },
        response: "{\n  \"id\": \"modr-0d9740456c391e43c445bf0f010940c7\",\n  \"model\": \"omni-moderation-latest\",\n  \"results\": [\n    {\n      \"flagged\": true,\n      \"categories\": {\n        \"harassment\": true,\n        \"harassment/threatening\": true,\n        \"sexual\": false,\n        \"hate\": false,\n        \"hate/threatening\": false,\n        \"illicit\": false,\n        \"illicit/violent\": false,\n        \"self-harm/intent\": false,\n        \"self-harm/instructions\": false,\n        \"self-harm\": false,\n        \"sexual/minors\": false,\n        \"violence\": true,\n        \"violence/graphic\": true\n      },\n      \"category_scores\": {\n        \"harassment\": 0.8189693396524255,\n        \"harassment/threatening\": 0.804985420696006,\n        \"sexual\": 1.573112165348997e-6,\n        \"hate\": 0.007562942636942845,\n        \"hate/threatening\": 0.004208854591835476,\n        \"illicit\": 0.030535955153511665,\n        \"illicit/violent\": 0.008925306722380033,\n        \"self-harm/intent\": 0.00023023930975076432,\n        \"self-harm/instructions\": 0.0002293869201073356,\n        \"self-harm\": 0.012598046106750154,\n        \"sexual/minors\": 2.212566909570261e-8,\n        \"violence\": 0.9999992735124786,\n        \"violence/graphic\": 0.843064871157054\n      },\n      \"category_applied_input_types\": {\n        \"harassment\": [\n          \"text\"\n        ],\n        \"harassment/threatening\": [\n          \"text\"\n        ],\n        \"sexual\": [\n          \"text\",\n          \"image\"\n        ],\n        \"hate\": [\n          \"text\"\n        ],\n        \"hate/threatening\": [\n          \"text\"\n        ],\n        \"illicit\": [\n          \"text\"\n        ],\n        \"illicit/violent\": [\n          \"text\"\n        ],\n        \"self-harm/intent\": [\n          \"text\",\n          \"image\"\n        ],\n        \"self-harm/instructions\": [\n          \"text\",\n          \"image\"\n        ],\n        \"self-harm\": [\n          \"text\",\n          \"image\"\n        ],\n        \"sexual/minors\": [\n          \"text\"\n        ],\n        \"violence\": [\n          \"text\",\n          \"image\"\n        ],\n        \"violence/graphic\": [\n          \"text\",\n          \"image\"\n        ]\n      }\n    }\n  ]\n}\n",
      }
    ],
  }
)
@tag("Moderations")
op createModeration(
  @body
  body: CreateModerationRequest,
): CreateModerationResponse;
