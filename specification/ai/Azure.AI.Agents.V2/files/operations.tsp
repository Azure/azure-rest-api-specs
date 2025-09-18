import "@typespec/http";
import "@typespec/openapi";
import "./models.tsp";
using TypeSpec.Http;
using TypeSpec.OpenAPI;
namespace OpenAI;
/** Returns a list of files. */
@summary("List files")
@get
@route("/files")
@extension(
  "x-oaiMeta",
  #{
    name: "List files",
    group: "files",
    returns: "A list of [File](https://platform.openai.com/docs/api-reference/files/object) objects.",
    examples: #{
      response: "{\n  \"object\": \"list\",\n  \"data\": [\n    {\n      \"id\": \"file-abc123\",\n      \"object\": \"file\",\n      \"bytes\": 175,\n      \"created_at\": 1613677385,\n      \"expires_at\": 1677614202,\n      \"filename\": \"salesOverview.pdf\",\n      \"purpose\": \"assistants\",\n    },\n    {\n      \"id\": \"file-abc456\",\n      \"object\": \"file\",\n      \"bytes\": 140,\n      \"created_at\": 1613779121,\n      \"expires_at\": 1677614202,\n      \"filename\": \"puppy.jsonl\",\n      \"purpose\": \"fine-tune\",\n    }\n  ],\n  \"first_id\": \"file-abc123\",\n  \"last_id\": \"file-abc456\",\n  \"has_more\": false\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/files \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\"\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\npage = client.files.list()\npage = page.data[0]\nprint(page)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\n// Automatically fetches more pages as needed.\nfor await (const fileObject of client.files.list()) {\n  console.log(fileObject);\n}",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  page, err := client.Files.List(context.TODO(), openai.FileListParams{\n\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", page)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.files.FileListPage;\nimport com.openai.models.files.FileListParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        FileListPage page = client.files().list();\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\npage = openai.files.list\n\nputs(page)",
      },
    },
  }
)
@tag("Files")
op listFiles(
  /** Only return files with the given purpose. */
  @query(#{ explode: true })
  purpose?: string,

  /** A limit on the number of objects to be returned. Limit can range between 1 and 10,000, and the default is 10,000. */
  @query(#{ explode: true })
  limit?: integer = 10000,

  /** Sort order by the `created_at` timestamp of the objects. `asc` for ascending order and `desc` for descending order. */
  @query(#{ explode: true })
  order?: "asc" | "desc" = "desc",

  /** A cursor for use in pagination. `after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include after=obj_foo in order to fetch the next page of the list. */
  @query(#{ explode: true })
  after?: string,
): ListFilesResponse;

/**Upload a file that can be used across various endpoints. Individual files can be up to 512 MB, and the size of all files uploaded by one organization can be up to 1 TB.

The Assistants API supports files up to 2 million tokens and of specific file types. See the [Assistants Tools guide](https://platform.openai.com/docs/assistants/tools) for details.

The Fine-tuning API only supports `.jsonl` files. The input also has certain required formats for fine-tuning [chat](https://platform.openai.com/docs/api-reference/fine-tuning/chat-input) or [completions](https://platform.openai.com/docs/api-reference/fine-tuning/completions-input) models.

The Batch API only supports `.jsonl` files up to 200 MB in size. The input also has a specific required [format](https://platform.openai.com/docs/api-reference/batch/request-input).

Please [contact us](https://help.openai.com/) if you need to increase these storage limits.*/
@summary("Upload file")
@post
@route("/files")
@extension(
  "x-oaiMeta",
  #{
    name: "Upload file",
    group: "files",
    returns: "The uploaded [File](https://platform.openai.com/docs/api-reference/files/object) object.",
    examples: #{
      response: "{\n  \"id\": \"file-abc123\",\n  \"object\": \"file\",\n  \"bytes\": 120000,\n  \"created_at\": 1677610602,\n  \"expires_at\": 1677614202,\n  \"filename\": \"mydata.jsonl\",\n  \"purpose\": \"fine-tune\",\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/files \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -F purpose=\"fine-tune\" \\\n  -F file=\"@mydata.jsonl\"\n  -F expires_after[anchor]=\"created_at\"\n  -F expires_after[seconds]=2592000\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nfile_object = client.files.create(\n    file=b\"raw file contents\",\n    purpose=\"assistants\",\n)\nprint(file_object.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst fileObject = await client.files.create({\n  file: fs.createReadStream('fine-tune.jsonl'),\n  purpose: 'assistants',\n});\n\nconsole.log(fileObject.id);",
        go: "package main\n\nimport (\n  \"bytes\"\n  \"context\"\n  \"fmt\"\n  \"io\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  fileObject, err := client.Files.New(context.TODO(), openai.FileNewParams{\n    File: io.Reader(bytes.NewBuffer([]byte(\"some file contents\"))),\n    Purpose: openai.FilePurposeAssistants,\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", fileObject.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.files.FileCreateParams;\nimport com.openai.models.files.FileObject;\nimport com.openai.models.files.FilePurpose;\nimport java.io.ByteArrayInputStream;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        FileCreateParams params = FileCreateParams.builder()\n            .file(ByteArrayInputStream(\"some content\".getBytes()))\n            .purpose(FilePurpose.ASSISTANTS)\n            .build();\n        FileObject fileObject = client.files().create(params);\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nfile_object = openai.files.create(file: Pathname(__FILE__), purpose: :assistants)\n\nputs(file_object)",
      },
    },
  }
)
@tag("Files")
op createFile(
  @header
  contentType: "multipart/form-data",

  @multipartBody
  body: CreateFileRequest,
): OpenAIFile;

/** Delete a file. */
@summary("Delete file")
@delete
@route("/files/{file_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Delete file",
    group: "files",
    returns: "Deletion status.",
    examples: #{
      response: "{\n  \"id\": \"file-abc123\",\n  \"object\": \"file\",\n  \"deleted\": true\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/files/file-abc123 \\\n  -X DELETE \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\"\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nfile_deleted = client.files.delete(\n    \"file_id\",\n)\nprint(file_deleted.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst fileDeleted = await client.files.delete('file_id');\n\nconsole.log(fileDeleted.id);",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  fileDeleted, err := client.Files.Delete(context.TODO(), \"file_id\")\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", fileDeleted.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.files.FileDeleteParams;\nimport com.openai.models.files.FileDeleted;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        FileDeleted fileDeleted = client.files().delete(\"file_id\");\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nfile_deleted = openai.files.delete(\"file_id\")\n\nputs(file_deleted)",
      },
    },
  }
)
@tag("Files")
op deleteFile(
  /** The ID of the file to use for this request. */
  @path
  file_id: string,
): DeleteFileResponse;

/** Returns information about a specific file. */
@summary("Retrieve file")
@get
@route("/files/{file_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Retrieve file",
    group: "files",
    returns: "The [File](https://platform.openai.com/docs/api-reference/files/object) object matching the specified ID.",
    examples: #{
      response: "{\n  \"id\": \"file-abc123\",\n  \"object\": \"file\",\n  \"bytes\": 120000,\n  \"created_at\": 1677610602,\n  \"expires_at\": 1677614202,\n  \"filename\": \"mydata.jsonl\",\n  \"purpose\": \"fine-tune\",\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/files/file-abc123 \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\"\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nfile_object = client.files.retrieve(\n    \"file_id\",\n)\nprint(file_object.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst fileObject = await client.files.retrieve('file_id');\n\nconsole.log(fileObject.id);",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  fileObject, err := client.Files.Get(context.TODO(), \"file_id\")\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", fileObject.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.files.FileObject;\nimport com.openai.models.files.FileRetrieveParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        FileObject fileObject = client.files().retrieve(\"file_id\");\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nfile_object = openai.files.retrieve(\"file_id\")\n\nputs(file_object)",
      },
    },
  }
)
@tag("Files")
op retrieveFile(
  /** The ID of the file to use for this request. */
  @path
  file_id: string,
): OpenAIFile;

/** Returns the contents of the specified file. */
@summary("Retrieve file content")
@get
@route("/files/{file_id}/content")
@extension(
  "x-oaiMeta",
  #{
    name: "Retrieve file content",
    group: "files",
    returns: "The file content.",
    examples: #{
      response: "",
      request: #{
        curl: "curl https://api.openai.com/v1/files/file-abc123/content \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" > file.jsonl\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nresponse = client.files.content(\n    \"file_id\",\n)\nprint(response)\ncontent = response.read()\nprint(content)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst response = await client.files.content('file_id');\n\nconsole.log(response);\n\nconst content = await response.blob();\nconsole.log(content);",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  response, err := client.Files.Content(context.TODO(), \"file_id\")\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", response)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.core.http.HttpResponse;\nimport com.openai.models.files.FileContentParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        HttpResponse response = client.files().content(\"file_id\");\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nresponse = openai.files.content(\"file_id\")\n\nputs(response)",
      },
    },
  }
)
@tag("Files")
op downloadFile(
  /** The ID of the file to use for this request. */
  @path
  file_id: string,
): Body<string>;
