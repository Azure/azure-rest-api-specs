import "@typespec/http";
import "@typespec/openapi";
import "./models.tsp";
using TypeSpec.Http;
using TypeSpec.OpenAPI;
namespace OpenAI;
/**Creates an intermediate [Upload](https://platform.openai.com/docs/api-reference/uploads/object) object
that you can add [Parts](https://platform.openai.com/docs/api-reference/uploads/part-object) to.
Currently, an Upload can accept at most 8 GB in total and expires after an
hour after you create it.

Once you complete the Upload, we will create a
[File](https://platform.openai.com/docs/api-reference/files/object) object that contains all the parts
you uploaded. This File is usable in the rest of our platform as a regular
File object.

For certain `purpose` values, the correct `mime_type` must be specified.
Please refer to documentation for the
[supported MIME types for your use case](https://platform.openai.com/docs/assistants/tools/file-search#supported-files).

For guidance on the proper filename extensions for each purpose, please
follow the documentation on [creating a
File](https://platform.openai.com/docs/api-reference/files/create).*/
@summary("Create upload")
@post
@route("/uploads")
@extension(
  "x-oaiMeta",
  #{
    name: "Create upload",
    group: "uploads",
    returns: "The [Upload](https://platform.openai.com/docs/api-reference/uploads/object) object with status `pending`.",
    examples: #{
      response: "{\n  \"id\": \"upload_abc123\",\n  \"object\": \"upload\",\n  \"bytes\": 2147483648,\n  \"created_at\": 1719184911,\n  \"filename\": \"training_examples.jsonl\",\n  \"purpose\": \"fine-tune\",\n  \"status\": \"pending\",\n  \"expires_at\": 1719127296\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/uploads \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -d '{\n    \"purpose\": \"fine-tune\",\n    \"filename\": \"training_examples.jsonl\",\n    \"bytes\": 2147483648,\n    \"mime_type\": \"text/jsonl\",\n    \"expires_after\": {\n      \"anchor\": \"created_at\",\n      \"seconds\": 3600\n    }\n  }'\n",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst upload = await client.uploads.create({\n  bytes: 0,\n  filename: 'filename',\n  mime_type: 'mime_type',\n  purpose: 'assistants',\n});\n\nconsole.log(upload.id);",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nupload = client.uploads.create(\n    bytes=0,\n    filename=\"filename\",\n    mime_type=\"mime_type\",\n    purpose=\"assistants\",\n)\nprint(upload.id)",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  upload, err := client.Uploads.New(context.TODO(), openai.UploadNewParams{\n    Bytes: 0,\n    Filename: \"filename\",\n    MimeType: \"mime_type\",\n    Purpose: openai.FilePurposeAssistants,\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", upload.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.files.FilePurpose;\nimport com.openai.models.uploads.Upload;\nimport com.openai.models.uploads.UploadCreateParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        UploadCreateParams params = UploadCreateParams.builder()\n            .bytes(0L)\n            .filename(\"filename\")\n            .mimeType(\"mime_type\")\n            .purpose(FilePurpose.ASSISTANTS)\n            .build();\n        Upload upload = client.uploads().create(params);\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nupload = openai.uploads.create(bytes: 0, filename: \"filename\", mime_type: \"mime_type\", purpose: :assistants)\n\nputs(upload)",
      },
    },
  }
)
@tag("Uploads")
op createUpload(
  @body
  body: CreateUploadRequest,
): Upload;

/** Cancels the Upload. No Parts may be added after an Upload is cancelled. */
@summary("Cancel upload")
@post
@route("/uploads/{upload_id}/cancel")
@extension(
  "x-oaiMeta",
  #{
    name: "Cancel upload",
    group: "uploads",
    returns: "The [Upload](https://platform.openai.com/docs/api-reference/uploads/object) object with status `cancelled`.",
    examples: #{
      response: "{\n  \"id\": \"upload_abc123\",\n  \"object\": \"upload\",\n  \"bytes\": 2147483648,\n  \"created_at\": 1719184911,\n  \"filename\": \"training_examples.jsonl\",\n  \"purpose\": \"fine-tune\",\n  \"status\": \"cancelled\",\n  \"expires_at\": 1719127296\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/uploads/upload_abc123/cancel\n",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst upload = await client.uploads.cancel('upload_abc123');\n\nconsole.log(upload.id);",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nupload = client.uploads.cancel(\n    \"upload_abc123\",\n)\nprint(upload.id)",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  upload, err := client.Uploads.Cancel(context.TODO(), \"upload_abc123\")\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", upload.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.uploads.Upload;\nimport com.openai.models.uploads.UploadCancelParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        Upload upload = client.uploads().cancel(\"upload_abc123\");\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nupload = openai.uploads.cancel(\"upload_abc123\")\n\nputs(upload)",
      },
    },
  }
)
@tag("Uploads")
op cancelUpload(
  /** The ID of the Upload. */
  @path
  upload_id: string,
): Upload;

/**Completes the [Upload](https://platform.openai.com/docs/api-reference/uploads/object).

Within the returned Upload object, there is a nested [File](https://platform.openai.com/docs/api-reference/files/object) object that is ready to use in the rest of the platform.

You can specify the order of the Parts by passing in an ordered list of the Part IDs.

The number of bytes uploaded upon completion must match the number of bytes initially specified when creating the Upload object. No Parts may be added after an Upload is completed.*/
@summary("Complete upload")
@post
@route("/uploads/{upload_id}/complete")
@extension(
  "x-oaiMeta",
  #{
    name: "Complete upload",
    group: "uploads",
    returns: "The [Upload](https://platform.openai.com/docs/api-reference/uploads/object) object with status `completed` with an additional `file` property containing the created usable File object.",
    examples: #{
      response: "{\n  \"id\": \"upload_abc123\",\n  \"object\": \"upload\",\n  \"bytes\": 2147483648,\n  \"created_at\": 1719184911,\n  \"filename\": \"training_examples.jsonl\",\n  \"purpose\": \"fine-tune\",\n  \"status\": \"completed\",\n  \"expires_at\": 1719127296,\n  \"file\": {\n    \"id\": \"file-xyz321\",\n    \"object\": \"file\",\n    \"bytes\": 2147483648,\n    \"created_at\": 1719186911,\n    \"expires_at\": 1719127296,\n    \"filename\": \"training_examples.jsonl\",\n    \"purpose\": \"fine-tune\",\n  }\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/uploads/upload_abc123/complete\n  -d '{\n    \"part_ids\": [\"part_def456\", \"part_ghi789\"]\n  }'\n",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst upload = await client.uploads.complete('upload_abc123', { part_ids: ['string'] });\n\nconsole.log(upload.id);",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nupload = client.uploads.complete(\n    upload_id=\"upload_abc123\",\n    part_ids=[\"string\"],\n)\nprint(upload.id)",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  upload, err := client.Uploads.Complete(\n    context.TODO(),\n    \"upload_abc123\",\n    openai.UploadCompleteParams{\n      PartIDs: []string{\"string\"},\n    },\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", upload.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.uploads.Upload;\nimport com.openai.models.uploads.UploadCompleteParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        UploadCompleteParams params = UploadCompleteParams.builder()\n            .uploadId(\"upload_abc123\")\n            .addPartId(\"string\")\n            .build();\n        Upload upload = client.uploads().complete(params);\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nupload = openai.uploads.complete(\"upload_abc123\", part_ids: [\"string\"])\n\nputs(upload)",
      },
    },
  }
)
@tag("Uploads")
op completeUpload(
  /** The ID of the Upload. */
  @path
  upload_id: string,

  @body
  body: CompleteUploadRequest,
): Upload;

/**Adds a [Part](https://platform.openai.com/docs/api-reference/uploads/part-object) to an [Upload](https://platform.openai.com/docs/api-reference/uploads/object) object. A Part represents a chunk of bytes from the file you are trying to upload.

Each Part can be at most 64 MB, and you can add Parts until you hit the Upload maximum of 8 GB.

It is possible to add multiple Parts in parallel. You can decide the intended order of the Parts when you [complete the Upload](https://platform.openai.com/docs/api-reference/uploads/complete).*/
@summary("Add upload part")
@post
@route("/uploads/{upload_id}/parts")
@extension(
  "x-oaiMeta",
  #{
    name: "Add upload part",
    group: "uploads",
    returns: "The upload [Part](https://platform.openai.com/docs/api-reference/uploads/part-object) object.",
    examples: #{
      response: "{\n  \"id\": \"part_def456\",\n  \"object\": \"upload.part\",\n  \"created_at\": 1719185911,\n  \"upload_id\": \"upload_abc123\"\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/uploads/upload_abc123/parts\n  -F data=\"aHR0cHM6Ly9hcGkub3BlbmFpLmNvbS92MS91cGxvYWRz...\"\n",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst uploadPart = await client.uploads.parts.create('upload_abc123', {\n  data: fs.createReadStream('path/to/file'),\n});\n\nconsole.log(uploadPart.id);",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nupload_part = client.uploads.parts.create(\n    upload_id=\"upload_abc123\",\n    data=b\"raw file contents\",\n)\nprint(upload_part.id)",
        go: "package main\n\nimport (\n  \"bytes\"\n  \"context\"\n  \"fmt\"\n  \"io\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  uploadPart, err := client.Uploads.Parts.New(\n    context.TODO(),\n    \"upload_abc123\",\n    openai.UploadPartNewParams{\n      Data: io.Reader(bytes.NewBuffer([]byte(\"some file contents\"))),\n    },\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", uploadPart.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.uploads.parts.PartCreateParams;\nimport com.openai.models.uploads.parts.UploadPart;\nimport java.io.ByteArrayInputStream;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        PartCreateParams params = PartCreateParams.builder()\n            .uploadId(\"upload_abc123\")\n            .data(ByteArrayInputStream(\"some content\".getBytes()))\n            .build();\n        UploadPart uploadPart = client.uploads().parts().create(params);\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nupload_part = openai.uploads.parts.create(\"upload_abc123\", data: Pathname(__FILE__))\n\nputs(upload_part)",
      },
    },
  }
)
@tag("Uploads")
op addUploadPart(
  /** The ID of the Upload. */
  @path
  upload_id: string,

  @header
  contentType: "multipart/form-data",

  @multipartBody
  body: AddUploadPartRequest,
): UploadPart;
