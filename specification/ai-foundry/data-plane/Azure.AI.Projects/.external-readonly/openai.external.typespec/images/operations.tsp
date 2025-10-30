import "@typespec/http";
import "@typespec/openapi";
import "./models.tsp";
using TypeSpec.Http;
using TypeSpec.OpenAPI;
namespace OpenAI;
/** Creates an edited or extended image given one or more source images and a prompt. This endpoint only supports `gpt-image-1` and `dall-e-2`. */
#suppress "@azure-tools/typespec-azure-core/byos" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/response-schema-problem" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@summary("Create image edit")
@post
@route("/images/edits")
@extension(
  "x-oaiMeta",
  #{
    name: "Create image edit",
    group: "images",
    returns: "Returns an [image](https://platform.openai.com/docs/api-reference/images/object) object.",
    examples: #[
      #{
        title: "Edit image",
        request: #{
          curl: "curl -s -D >(grep -i x-request-id >&2) \\\n  -o >(jq -r '.data[0].b64_json' | base64 --decode > gift-basket.png) \\\n  -X POST \"https://api.openai.com/v1/images/edits\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -F \"model=gpt-image-1\" \\\n  -F \"image[]=@body-lotion.png\" \\\n  -F \"image[]=@bath-bomb.png\" \\\n  -F \"image[]=@incense-kit.png\" \\\n  -F \"image[]=@soap.png\" \\\n  -F 'prompt=Create a lovely gift basket with these four items in it'\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nimages_response = client.images.edit(\n    image=b\"raw file contents\",\n    prompt=\"A cute baby sea otter wearing a beret\",\n)\nprint(images_response)",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst imagesResponse = await client.images.edit({\n  image: fs.createReadStream('path/to/file'),\n  prompt: 'A cute baby sea otter wearing a beret',\n});\n\nconsole.log(imagesResponse);",
          go: "package main\n\nimport (\n  \"bytes\"\n  \"context\"\n  \"fmt\"\n  \"io\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  imagesResponse, err := client.Images.Edit(context.TODO(), openai.ImageEditParams{\n    Image: openai.ImageEditParamsImageUnion{\n      OfFile: io.Reader(bytes.NewBuffer([]byte(\"some file contents\"))),\n    },\n    Prompt: \"A cute baby sea otter wearing a beret\",\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", imagesResponse)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.images.ImageEditParams;\nimport com.openai.models.images.ImagesResponse;\nimport java.io.ByteArrayInputStream;\nimport java.io.InputStream;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        ImageEditParams params = ImageEditParams.builder()\n            .image(ByteArrayInputStream(\"some content\".getBytes()))\n            .prompt(\"A cute baby sea otter wearing a beret\")\n            .build();\n        ImagesResponse imagesResponse = client.images().edit(params);\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nimages_response = openai.images.edit(image: Pathname(__FILE__), prompt: \"A cute baby sea otter wearing a beret\")\n\nputs(images_response)",
        },
      },
      #{
        title: "Streaming",
        request: #{
          curl: "curl -s -N -X POST \"https://api.openai.com/v1/images/edits\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -F \"model=gpt-image-1\" \\\n  -F \"image[]=@body-lotion.png\" \\\n  -F \"image[]=@bath-bomb.png\" \\\n  -F \"image[]=@incense-kit.png\" \\\n  -F \"image[]=@soap.png\" \\\n  -F 'prompt=Create a lovely gift basket with these four items in it' \\\n  -F \"stream=true\"\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nimages_response = client.images.edit(\n    image=b\"raw file contents\",\n    prompt=\"A cute baby sea otter wearing a beret\",\n)\nprint(images_response)",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst imagesResponse = await client.images.edit({\n  image: fs.createReadStream('path/to/file'),\n  prompt: 'A cute baby sea otter wearing a beret',\n});\n\nconsole.log(imagesResponse);",
          go: "package main\n\nimport (\n  \"bytes\"\n  \"context\"\n  \"fmt\"\n  \"io\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  imagesResponse, err := client.Images.Edit(context.TODO(), openai.ImageEditParams{\n    Image: openai.ImageEditParamsImageUnion{\n      OfFile: io.Reader(bytes.NewBuffer([]byte(\"some file contents\"))),\n    },\n    Prompt: \"A cute baby sea otter wearing a beret\",\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", imagesResponse)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.images.ImageEditParams;\nimport com.openai.models.images.ImagesResponse;\nimport java.io.ByteArrayInputStream;\nimport java.io.InputStream;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        ImageEditParams params = ImageEditParams.builder()\n            .image(ByteArrayInputStream(\"some content\".getBytes()))\n            .prompt(\"A cute baby sea otter wearing a beret\")\n            .build();\n        ImagesResponse imagesResponse = client.images().edit(params);\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nimages_response = openai.images.edit(image: Pathname(__FILE__), prompt: \"A cute baby sea otter wearing a beret\")\n\nputs(images_response)",
        },
        response: "event: image_edit.partial_image\ndata: {\"type\":\"image_edit.partial_image\",\"b64_json\":\"...\",\"partial_image_index\":0}\n\nevent: image_edit.completed\ndata: {\"type\":\"image_edit.completed\",\"b64_json\":\"...\",\"usage\":{\"total_tokens\":100,\"input_tokens\":50,\"output_tokens\":50,\"input_tokens_details\":{\"text_tokens\":10,\"image_tokens\":40}}}\n",
      }
    ],
  }
)
@tag("Images")
op createImageEdit(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  @header
  contentType: "multipart/form-data",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  @multipartBody
  body: CreateImageEditRequest,
): ImagesResponse | CreateImageEditStreamingResponse;

/** Creates an image given a prompt. [Learn more](https://platform.openai.com/docs/guides/images). */
#suppress "@azure-tools/typespec-azure-core/response-schema-problem" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@summary("Create image")
@post
@route("/images/generations")
@extension(
  "x-oaiMeta",
  #{
    name: "Create image",
    group: "images",
    returns: "Returns an [image](https://platform.openai.com/docs/api-reference/images/object) object.",
    examples: #[
      #{
        title: "Generate image",
        request: #{
          curl: "curl https://api.openai.com/v1/images/generations \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -d '{\n    \"model\": \"gpt-image-1\",\n    \"prompt\": \"A cute baby sea otter\",\n    \"n\": 1,\n    \"size\": \"1024x1024\"\n  }'\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nimages_response = client.images.generate(\n    prompt=\"A cute baby sea otter\",\n)\nprint(images_response)",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst imagesResponse = await client.images.generate({ prompt: 'A cute baby sea otter' });\n\nconsole.log(imagesResponse);",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  imagesResponse, err := client.Images.Generate(context.TODO(), openai.ImageGenerateParams{\n    Prompt: \"A cute baby sea otter\",\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", imagesResponse)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.images.ImageGenerateParams;\nimport com.openai.models.images.ImagesResponse;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        ImageGenerateParams params = ImageGenerateParams.builder()\n            .prompt(\"A cute baby sea otter\")\n            .build();\n        ImagesResponse imagesResponse = client.images().generate(params);\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nimages_response = openai.images.generate(prompt: \"A cute baby sea otter\")\n\nputs(images_response)",
        },
        response: "{\n  \"created\": 1713833628,\n  \"data\": [\n    {\n      \"b64_json\": \"...\"\n    }\n  ],\n  \"usage\": {\n    \"total_tokens\": 100,\n    \"input_tokens\": 50,\n    \"output_tokens\": 50,\n    \"input_tokens_details\": {\n      \"text_tokens\": 10,\n      \"image_tokens\": 40\n    }\n  }\n}\n",
      },
      #{
        title: "Streaming",
        request: #{
          curl: "curl https://api.openai.com/v1/images/generations \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -d '{\n    \"model\": \"gpt-image-1\",\n    \"prompt\": \"A cute baby sea otter\",\n    \"n\": 1,\n    \"size\": \"1024x1024\",\n    \"stream\": true\n  }' \\\n  --no-buffer\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nimages_response = client.images.generate(\n    prompt=\"A cute baby sea otter\",\n)\nprint(images_response)",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst imagesResponse = await client.images.generate({ prompt: 'A cute baby sea otter' });\n\nconsole.log(imagesResponse);",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  imagesResponse, err := client.Images.Generate(context.TODO(), openai.ImageGenerateParams{\n    Prompt: \"A cute baby sea otter\",\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", imagesResponse)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.images.ImageGenerateParams;\nimport com.openai.models.images.ImagesResponse;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        ImageGenerateParams params = ImageGenerateParams.builder()\n            .prompt(\"A cute baby sea otter\")\n            .build();\n        ImagesResponse imagesResponse = client.images().generate(params);\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nimages_response = openai.images.generate(prompt: \"A cute baby sea otter\")\n\nputs(images_response)",
        },
        response: "event: image_generation.partial_image\ndata: {\"type\":\"image_generation.partial_image\",\"b64_json\":\"...\",\"partial_image_index\":0}\n\nevent: image_generation.completed\ndata: {\"type\":\"image_generation.completed\",\"b64_json\":\"...\",\"usage\":{\"total_tokens\":100,\"input_tokens\":50,\"output_tokens\":50,\"input_tokens_details\":{\"text_tokens\":10,\"image_tokens\":40}}}\n",
      }
    ],
  }
)
@tag("Images")
op createImage(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  @body
  body: CreateImageRequest,
): ImagesResponse | CreateImageStreamingResponse;

/** Creates a variation of a given image. This endpoint only supports `dall-e-2`. */
#suppress "@azure-tools/typespec-azure-core/byos" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Auto-suppressed warnings non-applicable rules during import."
#suppress "@azure-tools/typespec-azure-core/no-openapi" "Auto-suppressed warnings non-applicable rules during import."
@summary("Create image variation")
@post
@route("/images/variations")
@extension(
  "x-oaiMeta",
  #{
    name: "Create image variation",
    group: "images",
    returns: "Returns a list of [image](https://platform.openai.com/docs/api-reference/images/object) objects.",
    examples: #{
      response: "{\n  \"created\": 1589478378,\n  \"data\": [\n    {\n      \"url\": \"https://...\"\n    },\n    {\n      \"url\": \"https://...\"\n    }\n  ]\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/images/variations \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -F image=\"@otter.png\" \\\n  -F n=2 \\\n  -F size=\"1024x1024\"\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nimages_response = client.images.create_variation(\n    image=b\"raw file contents\",\n)\nprint(images_response.created)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst imagesResponse = await client.images.createVariation({ image: fs.createReadStream('otter.png') });\n\nconsole.log(imagesResponse.created);",
        csharp: "using System;\n\nusing OpenAI.Images;\n\nImageClient client = new(\n    model: \"dall-e-2\",\n    apiKey: Environment.GetEnvironmentVariable(\"OPENAI_API_KEY\")\n);\n\nGeneratedImage image = client.GenerateImageVariation(imageFilePath: \"otter.png\");\n\nConsole.WriteLine(image.ImageUri);\n",
        go: "package main\n\nimport (\n  \"bytes\"\n  \"context\"\n  \"fmt\"\n  \"io\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  imagesResponse, err := client.Images.NewVariation(context.TODO(), openai.ImageNewVariationParams{\n    Image: io.Reader(bytes.NewBuffer([]byte(\"some file contents\"))),\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", imagesResponse.Created)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.images.ImageCreateVariationParams;\nimport com.openai.models.images.ImagesResponse;\nimport java.io.ByteArrayInputStream;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        ImageCreateVariationParams params = ImageCreateVariationParams.builder()\n            .image(ByteArrayInputStream(\"some content\".getBytes()))\n            .build();\n        ImagesResponse imagesResponse = client.images().createVariation(params);\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nimages_response = openai.images.create_variation(image: Pathname(__FILE__))\n\nputs(images_response)",
      },
    },
  }
)
@tag("Images")
op createImageVariation(
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  @header
  contentType: "multipart/form-data",

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Auto-suppressed warnings non-applicable rules during import."
  @multipartBody
  body: CreateImageVariationRequest,
): ImagesResponse;
