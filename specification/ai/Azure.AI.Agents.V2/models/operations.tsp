import "@typespec/http";
import "@typespec/openapi";
import "./models.tsp";
using TypeSpec.Http;
using TypeSpec.OpenAPI;
namespace OpenAI;
/** Lists the currently available models, and provides basic information about each one such as the owner and availability. */
@summary("List models")
@get
@route("/models")
@extension(
  "x-oaiMeta",
  #{
    name: "List models",
    group: "models",
    returns: "A list of [model](https://platform.openai.com/docs/api-reference/models/object) objects.",
    examples: #{
      response: "{\n  \"object\": \"list\",\n  \"data\": [\n    {\n      \"id\": \"model-id-0\",\n      \"object\": \"model\",\n      \"created\": 1686935002,\n      \"owned_by\": \"organization-owner\"\n    },\n    {\n      \"id\": \"model-id-1\",\n      \"object\": \"model\",\n      \"created\": 1686935002,\n      \"owned_by\": \"organization-owner\",\n    },\n    {\n      \"id\": \"model-id-2\",\n      \"object\": \"model\",\n      \"created\": 1686935002,\n      \"owned_by\": \"openai\"\n    },\n  ],\n  \"object\": \"list\"\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/models \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\"\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\npage = client.models.list()\npage = page.data[0]\nprint(page.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\n// Automatically fetches more pages as needed.\nfor await (const model of client.models.list()) {\n  console.log(model.id);\n}",
        csharp: "using System;\n\nusing OpenAI.Models;\n\nOpenAIModelClient client = new(\n    apiKey: Environment.GetEnvironmentVariable(\"OPENAI_API_KEY\")\n);\n\nforeach (var model in client.GetModels().Value)\n{\n    Console.WriteLine(model.Id);\n}\n",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  page, err := client.Models.List(context.TODO())\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", page)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.models.ModelListPage;\nimport com.openai.models.models.ModelListParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        ModelListPage page = client.models().list();\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\npage = openai.models.list\n\nputs(page)",
      },
    },
  }
)
@tag("Models")
op listModels(): ListModelsResponse;

/** Delete a fine-tuned model. You must have the Owner role in your organization to delete a model. */
@summary("Delete a fine-tuned model")
@delete
@route("/models/{model}")
@extension(
  "x-oaiMeta",
  #{
    name: "Delete a fine-tuned model",
    group: "models",
    returns: "Deletion status.",
    examples: #{
      response: "{\n  \"id\": \"ft:gpt-4o-mini:acemeco:suffix:abc123\",\n  \"object\": \"model\",\n  \"deleted\": true\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/models/ft:gpt-4o-mini:acemeco:suffix:abc123 \\\n  -X DELETE \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\"\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nmodel_deleted = client.models.delete(\n    \"ft:gpt-4o-mini:acemeco:suffix:abc123\",\n)\nprint(model_deleted.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst modelDeleted = await client.models.delete('ft:gpt-4o-mini:acemeco:suffix:abc123');\n\nconsole.log(modelDeleted.id);",
        csharp: "using System;\nusing System.ClientModel;\n\nusing OpenAI.Models;\n\nOpenAIModelClient client = new(\n    apiKey: Environment.GetEnvironmentVariable(\"OPENAI_API_KEY\")\n);\n\nClientResult success = client.DeleteModel(\"ft:gpt-4o-mini:acemeco:suffix:abc123\");\nConsole.WriteLine(success);\n",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  modelDeleted, err := client.Models.Delete(context.TODO(), \"ft:gpt-4o-mini:acemeco:suffix:abc123\")\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", modelDeleted.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.models.ModelDeleteParams;\nimport com.openai.models.models.ModelDeleted;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        ModelDeleted modelDeleted = client.models().delete(\"ft:gpt-4o-mini:acemeco:suffix:abc123\");\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nmodel_deleted = openai.models.delete(\"ft:gpt-4o-mini:acemeco:suffix:abc123\")\n\nputs(model_deleted)",
      },
    },
  }
)
@tag("Models")
op deleteModel(
  /** The model to delete */
  @path
  `model`: string,
): DeleteModelResponse;

/** Retrieves a model instance, providing basic information about the model such as the owner and permissioning. */
@summary("Retrieve model")
@get
@route("/models/{model}")
@extension(
  "x-oaiMeta",
  #{
    name: "Retrieve model",
    group: "models",
    returns: "The [model](https://platform.openai.com/docs/api-reference/models/object) object matching the specified ID.",
    examples: #{
      response: "{\n  \"id\": \"VAR_chat_model_id\",\n  \"object\": \"model\",\n  \"created\": 1686935002,\n  \"owned_by\": \"openai\"\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/models/VAR_chat_model_id \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\"\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nmodel = client.models.retrieve(\n    \"gpt-4o-mini\",\n)\nprint(model.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst model = await client.models.retrieve('gpt-4o-mini');\n\nconsole.log(model.id);",
        csharp: "using System;\nusing System.ClientModel;\n\nusing OpenAI.Models;\n\n  OpenAIModelClient client = new(\n    apiKey: Environment.GetEnvironmentVariable(\"OPENAI_API_KEY\")\n);\n\nClientResult<OpenAIModel> model = client.GetModel(\"babbage-002\");\nConsole.WriteLine(model.Value.Id);\n",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  model, err := client.Models.Get(context.TODO(), \"gpt-4o-mini\")\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", model.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.models.Model;\nimport com.openai.models.models.ModelRetrieveParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        Model model = client.models().retrieve(\"gpt-4o-mini\");\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nmodel = openai.models.retrieve(\"gpt-4o-mini\")\n\nputs(model)",
      },
    },
  }
)
@tag("Models")
op retrieveModel(
  /** The ID of the model to use for this request */
  @path
  `model`: string,
): Model;
