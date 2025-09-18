import "@typespec/http";
import "@typespec/openapi";
import "./models.tsp";
using TypeSpec.Http;
using TypeSpec.OpenAPI;
namespace OpenAI;
/** Creates an embedding vector representing the input text. */
@summary("Create embeddings")
@post
@route("/embeddings")
@extension(
  "x-oaiMeta",
  #{
    name: "Create embeddings",
    group: "embeddings",
    returns: "A list of [embedding](https://platform.openai.com/docs/api-reference/embeddings/object) objects.",
    examples: #{
      response: "{\n  \"object\": \"list\",\n  \"data\": [\n    {\n      \"object\": \"embedding\",\n      \"embedding\": [\n        0.0023064255,\n        -0.009327292,\n        .... (1536 floats total for ada-002)\n        -0.0028842222,\n      ],\n      \"index\": 0\n    }\n  ],\n  \"model\": \"text-embedding-ada-002\",\n  \"usage\": {\n    \"prompt_tokens\": 8,\n    \"total_tokens\": 8\n  }\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/embeddings \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -d '{\n    \"input\": \"The food was delicious and the waiter...\",\n    \"model\": \"text-embedding-ada-002\",\n    \"encoding_format\": \"float\"\n  }'\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\ncreate_embedding_response = client.embeddings.create(\n    input=\"The quick brown fox jumped over the lazy dog\",\n    model=\"text-embedding-3-small\",\n)\nprint(create_embedding_response.data)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst createEmbeddingResponse = await client.embeddings.create({\n  input: 'The quick brown fox jumped over the lazy dog',\n  model: 'text-embedding-3-small',\n});\n\nconsole.log(createEmbeddingResponse.data);",
        csharp: "using System;\n\nusing OpenAI.Embeddings;\n\nEmbeddingClient client = new(\n    model: \"text-embedding-3-small\",\n    apiKey: Environment.GetEnvironmentVariable(\"OPENAI_API_KEY\")\n);\n\nOpenAIEmbedding embedding = client.GenerateEmbedding(input: \"The quick brown fox jumped over the lazy dog\");\nReadOnlyMemory<float> vector = embedding.ToFloats();\n\nfor (int i = 0; i < vector.Length; i++)\n{\n    Console.WriteLine($\"  [{i,4}] = {vector.Span[i]}\");\n}\n",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  createEmbeddingResponse, err := client.Embeddings.New(context.TODO(), openai.EmbeddingNewParams{\n    Input: openai.EmbeddingNewParamsInputUnion{\n      OfString: openai.String(\"The quick brown fox jumped over the lazy dog\"),\n    },\n    Model: openai.EmbeddingModelTextEmbeddingAda002,\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", createEmbeddingResponse.Data)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.embeddings.CreateEmbeddingResponse;\nimport com.openai.models.embeddings.EmbeddingCreateParams;\nimport com.openai.models.embeddings.EmbeddingModel;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        EmbeddingCreateParams params = EmbeddingCreateParams.builder()\n            .input(\"The quick brown fox jumped over the lazy dog\")\n            .model(EmbeddingModel.TEXT_EMBEDDING_ADA_002)\n            .build();\n        CreateEmbeddingResponse createEmbeddingResponse = client.embeddings().create(params);\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\ncreate_embedding_response = openai.embeddings.create(\n  input: \"The quick brown fox jumped over the lazy dog\",\n  model: :\"text-embedding-ada-002\"\n)\n\nputs(create_embedding_response)",
      },
    },
  }
)
@tag("Embeddings")
op createEmbedding(
  @body
  body: CreateEmbeddingRequest,
): CreateEmbeddingResponse;
