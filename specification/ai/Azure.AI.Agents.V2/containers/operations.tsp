import "@typespec/http";
import "@typespec/openapi";
import "./models.tsp";
using TypeSpec.Http;
using TypeSpec.OpenAPI;
namespace OpenAI;
/** List Containers */
@summary("List containers")
@get
@route("/containers")
@extension(
  "x-oaiMeta",
  #{
    name: "List containers",
    group: "containers",
    returns: "a list of [container](https://platform.openai.com/docs/api-reference/containers/object) objects.",
    path: "get",
    examples: #{
      response: "{\n  \"object\": \"list\",\n  \"data\": [\n    {\n        \"id\": \"cntr_682dfebaacac8198bbfe9c2474fb6f4a085685cbe3cb5863\",\n        \"object\": \"container\",\n        \"created_at\": 1747844794,\n        \"status\": \"running\",\n        \"expires_after\": {\n            \"anchor\": \"last_active_at\",\n            \"minutes\": 20\n        },\n        \"last_active_at\": 1747844794,\n        \"name\": \"My Container\"\n    }\n  ],\n  \"first_id\": \"container_123\",\n  \"last_id\": \"container_123\",\n  \"has_more\": false\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/containers \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\"\n",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\n// Automatically fetches more pages as needed.\nfor await (const containerListResponse of client.containers.list()) {\n  console.log(containerListResponse.id);\n}",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\npage = client.containers.list()\npage = page.data[0]\nprint(page.id)",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  page, err := client.Containers.List(context.TODO(), openai.ContainerListParams{\n\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", page)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.containers.ContainerListPage;\nimport com.openai.models.containers.ContainerListParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        ContainerListPage page = client.containers().list();\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\npage = openai.containers.list\n\nputs(page)",
      },
    },
  }
)
op ListContainers(
  /** A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 20. */
  @query(#{ explode: true })
  limit?: integer = 20,

  /** Sort order by the `created_at` timestamp of the objects. `asc` for ascending order and `desc` for descending order. */
  @query(#{ explode: true })
  order?: "asc" | "desc" = "desc",

  /** A cursor for use in pagination. `after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include after=obj_foo in order to fetch the next page of the list. */
  @query(#{ explode: true })
  after?: string,
): ContainerListResource;

/** Create Container */
@summary("Create container")
@post
@route("/containers")
@extension(
  "x-oaiMeta",
  #{
    name: "Create container",
    group: "containers",
    returns: "The created [container](https://platform.openai.com/docs/api-reference/containers/object) object.",
    path: "post",
    examples: #{
      response: "{\n    \"id\": \"cntr_682e30645a488191b6363a0cbefc0f0a025ec61b66250591\",\n    \"object\": \"container\",\n    \"created_at\": 1747857508,\n    \"status\": \"running\",\n    \"expires_after\": {\n        \"anchor\": \"last_active_at\",\n        \"minutes\": 20\n    },\n    \"last_active_at\": 1747857508,\n    \"name\": \"My Container\"\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/containers \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -H \"Content-Type: application/json\" \\\n  -d '{\n        \"name\": \"My Container\"\n      }'\n",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst container = await client.containers.create({ name: 'name' });\n\nconsole.log(container.id);",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\ncontainer = client.containers.create(\n    name=\"name\",\n)\nprint(container.id)",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  container, err := client.Containers.New(context.TODO(), openai.ContainerNewParams{\n    Name: \"name\",\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", container.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.containers.ContainerCreateParams;\nimport com.openai.models.containers.ContainerCreateResponse;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        ContainerCreateParams params = ContainerCreateParams.builder()\n            .name(\"name\")\n            .build();\n        ContainerCreateResponse container = client.containers().create(params);\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\ncontainer = openai.containers.create(name: \"name\")\n\nputs(container)",
      },
    },
  }
)
op CreateContainer(
  @body
  body: CreateContainerBody,
): ContainerResource;

/** Delete Container */
@summary("Delete a container")
@delete
@route("/containers/{container_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Delete a container",
    group: "containers",
    returns: "Deletion Status",
    path: "delete",
    examples: #{
      response: "{\n    \"id\": \"cntr_682dfebaacac8198bbfe9c2474fb6f4a085685cbe3cb5863\",\n    \"object\": \"container.deleted\",\n    \"deleted\": true\n}\n",
      request: #{
        curl: "curl -X DELETE https://api.openai.com/v1/containers/cntr_682dfebaacac8198bbfe9c2474fb6f4a085685cbe3cb5863 \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\"\n",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nawait client.containers.delete('container_id');",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nclient.containers.delete(\n    \"container_id\",\n)",
        go: "package main\n\nimport (\n  \"context\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  err := client.Containers.Delete(context.TODO(), \"container_id\")\n  if err != nil {\n    panic(err.Error())\n  }\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.containers.ContainerDeleteParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        client.containers().delete(\"container_id\");\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nresult = openai.containers.delete(\"container_id\")\n\nputs(result)",
      },
    },
  }
)
op DeleteContainer(
  /** The ID of the container to delete. */
  @path
  container_id: string,
): OkResponse;

/** Retrieve Container */
@summary("Retrieve container")
@get
@route("/containers/{container_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Retrieve container",
    group: "containers",
    returns: "The [container](https://platform.openai.com/docs/api-reference/containers/object) object.",
    path: "get",
    examples: #{
      response: "{\n    \"id\": \"cntr_682dfebaacac8198bbfe9c2474fb6f4a085685cbe3cb5863\",\n    \"object\": \"container\",\n    \"created_at\": 1747844794,\n    \"status\": \"running\",\n    \"expires_after\": {\n        \"anchor\": \"last_active_at\",\n        \"minutes\": 20\n    },\n    \"last_active_at\": 1747844794,\n    \"name\": \"My Container\"\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/containers/cntr_682dfebaacac8198bbfe9c2474fb6f4a085685cbe3cb5863 \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\"\n",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst container = await client.containers.retrieve('container_id');\n\nconsole.log(container.id);",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\ncontainer = client.containers.retrieve(\n    \"container_id\",\n)\nprint(container.id)",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  container, err := client.Containers.Get(context.TODO(), \"container_id\")\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", container.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.containers.ContainerRetrieveParams;\nimport com.openai.models.containers.ContainerRetrieveResponse;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        ContainerRetrieveResponse container = client.containers().retrieve(\"container_id\");\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\ncontainer = openai.containers.retrieve(\"container_id\")\n\nputs(container)",
      },
    },
  }
)
op RetrieveContainer(
  @path
  container_id: string,
): ContainerResource;

/** List Container files */
@summary("List container files")
@get
@route("/containers/{container_id}/files")
@extension(
  "x-oaiMeta",
  #{
    name: "List container files",
    group: "containers",
    returns: "a list of [container file](https://platform.openai.com/docs/api-reference/container-files/object) objects.",
    path: "get",
    examples: #{
      response: "{\n    \"object\": \"list\",\n    \"data\": [\n        {\n            \"id\": \"cfile_682e0e8a43c88191a7978f477a09bdf5\",\n            \"object\": \"container.file\",\n            \"created_at\": 1747848842,\n            \"bytes\": 880,\n            \"container_id\": \"cntr_682e0e7318108198aa783fd921ff305e08e78805b9fdbb04\",\n            \"path\": \"/mnt/data/88e12fa445d32636f190a0b33daed6cb-tsconfig.json\",\n            \"source\": \"user\"\n        }\n    ],\n    \"first_id\": \"cfile_682e0e8a43c88191a7978f477a09bdf5\",\n    \"has_more\": false,\n    \"last_id\": \"cfile_682e0e8a43c88191a7978f477a09bdf5\"\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/containers/cntr_682e0e7318108198aa783fd921ff305e08e78805b9fdbb04/files \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\"\n",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\n// Automatically fetches more pages as needed.\nfor await (const fileListResponse of client.containers.files.list('container_id')) {\n  console.log(fileListResponse.id);\n}",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\npage = client.containers.files.list(\n    container_id=\"container_id\",\n)\npage = page.data[0]\nprint(page.id)",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  page, err := client.Containers.Files.List(\n    context.TODO(),\n    \"container_id\",\n    openai.ContainerFileListParams{\n\n    },\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", page)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.containers.files.FileListPage;\nimport com.openai.models.containers.files.FileListParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        FileListPage page = client.containers().files().list(\"container_id\");\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\npage = openai.containers.files.list(\"container_id\")\n\nputs(page)",
      },
    },
  }
)
op ListContainerFiles(
  @path
  container_id: string,

  /** A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 20. */
  @query(#{ explode: true })
  limit?: integer = 20,

  /** Sort order by the `created_at` timestamp of the objects. `asc` for ascending order and `desc` for descending order. */
  @query(#{ explode: true })
  order?: "asc" | "desc" = "desc",

  /** A cursor for use in pagination. `after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with obj_foo, your subsequent call can include after=obj_foo in order to fetch the next page of the list. */
  @query(#{ explode: true })
  after?: string,
): ContainerFileListResource;

/**Create a Container File

You can send either a multipart/form-data request with the raw file content, or a JSON request with a file ID.*/
@summary("Create container file")
@post
@route("/containers/{container_id}/files")
@extension(
  "x-oaiMeta",
  #{
    name: "Create container file",
    group: "containers",
    returns: "The created [container file](https://platform.openai.com/docs/api-reference/container-files/object) object.",
    path: "post",
    examples: #{
      response: "{\n  \"id\": \"cfile_682e0e8a43c88191a7978f477a09bdf5\",\n  \"object\": \"container.file\",\n  \"created_at\": 1747848842,\n  \"bytes\": 880,\n  \"container_id\": \"cntr_682e0e7318108198aa783fd921ff305e08e78805b9fdbb04\",\n  \"path\": \"/mnt/data/88e12fa445d32636f190a0b33daed6cb-tsconfig.json\",\n  \"source\": \"user\"\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/containers/cntr_682e0e7318108198aa783fd921ff305e08e78805b9fdbb04/files \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -F file=\"@example.txt\"\n",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst file = await client.containers.files.create('container_id');\n\nconsole.log(file.id);",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nfile = client.containers.files.create(\n    container_id=\"container_id\",\n)\nprint(file.id)",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  file, err := client.Containers.Files.New(\n    context.TODO(),\n    \"container_id\",\n    openai.ContainerFileNewParams{\n\n    },\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", file.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.containers.files.FileCreateParams;\nimport com.openai.models.containers.files.FileCreateResponse;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        FileCreateResponse file = client.containers().files().create(\"container_id\");\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nfile = openai.containers.files.create(\"container_id\")\n\nputs(file)",
      },
    },
  }
)
op CreateContainerFile(
  @path
  container_id: string,

  @header
  contentType: "multipart/form-data",

  @multipartBody
  body: CreateContainerFileBody,
): ContainerFileResource;

/** Delete Container File */
@summary("Delete a container file")
@delete
@route("/containers/{container_id}/files/{file_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Delete a container file",
    group: "containers",
    returns: "Deletion Status",
    path: "delete",
    examples: #{
      response: "{\n    \"id\": \"cfile_682e0e8a43c88191a7978f477a09bdf5\",\n    \"object\": \"container.file.deleted\",\n    \"deleted\": true\n}\n",
      request: #{
        curl: "curl -X DELETE https://api.openai.com/v1/containers/cntr_682dfebaacac8198bbfe9c2474fb6f4a085685cbe3cb5863/files/cfile_682e0e8a43c88191a7978f477a09bdf5 \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\"\n",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nawait client.containers.files.delete('file_id', { container_id: 'container_id' });",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nclient.containers.files.delete(\n    file_id=\"file_id\",\n    container_id=\"container_id\",\n)",
        go: "package main\n\nimport (\n  \"context\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  err := client.Containers.Files.Delete(\n    context.TODO(),\n    \"container_id\",\n    \"file_id\",\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.containers.files.FileDeleteParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        FileDeleteParams params = FileDeleteParams.builder()\n            .containerId(\"container_id\")\n            .fileId(\"file_id\")\n            .build();\n        client.containers().files().delete(params);\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nresult = openai.containers.files.delete(\"file_id\", container_id: \"container_id\")\n\nputs(result)",
      },
    },
  }
)
op DeleteContainerFile(
  @path
  container_id: string,

  @path
  file_id: string,
): OkResponse;

/** Retrieve Container File */
@summary("Retrieve container file")
@get
@route("/containers/{container_id}/files/{file_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Retrieve container file",
    group: "containers",
    returns: "The [container file](https://platform.openai.com/docs/api-reference/container-files/object) object.",
    path: "get",
    examples: #{
      response: "{\n    \"id\": \"cfile_682e0e8a43c88191a7978f477a09bdf5\",\n    \"object\": \"container.file\",\n    \"created_at\": 1747848842,\n    \"bytes\": 880,\n    \"container_id\": \"cntr_682e0e7318108198aa783fd921ff305e08e78805b9fdbb04\",\n    \"path\": \"/mnt/data/88e12fa445d32636f190a0b33daed6cb-tsconfig.json\",\n    \"source\": \"user\"\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/containers/container_123/files/file_456 \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\"\n",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst file = await client.containers.files.retrieve('file_id', { container_id: 'container_id' });\n\nconsole.log(file.id);",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nfile = client.containers.files.retrieve(\n    file_id=\"file_id\",\n    container_id=\"container_id\",\n)\nprint(file.id)",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  file, err := client.Containers.Files.Get(\n    context.TODO(),\n    \"container_id\",\n    \"file_id\",\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", file.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.containers.files.FileRetrieveParams;\nimport com.openai.models.containers.files.FileRetrieveResponse;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        FileRetrieveParams params = FileRetrieveParams.builder()\n            .containerId(\"container_id\")\n            .fileId(\"file_id\")\n            .build();\n        FileRetrieveResponse file = client.containers().files().retrieve(params);\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nfile = openai.containers.files.retrieve(\"file_id\", container_id: \"container_id\")\n\nputs(file)",
      },
    },
  }
)
op RetrieveContainerFile(
  @path
  container_id: string,

  @path
  file_id: string,
): ContainerFileResource;

/** Retrieve Container File Content */
@summary("Retrieve container file content")
@get
@route("/containers/{container_id}/files/{file_id}/content")
@extension(
  "x-oaiMeta",
  #{
    name: "Retrieve container file content",
    group: "containers",
    returns: "The contents of the container file.",
    path: "get",
    examples: #{
      response: "<binary content of the file>\n",
      request: #{
        curl: "curl https://api.openai.com/v1/containers/container_123/files/cfile_456/content \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\"\n",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst content = await client.containers.files.content.retrieve('file_id', { container_id: 'container_id' });\n\nconsole.log(content);\n\nconst data = await content.blob();\nconsole.log(data);",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\ncontent = client.containers.files.content.retrieve(\n    file_id=\"file_id\",\n    container_id=\"container_id\",\n)\nprint(content)\ndata = content.read()\nprint(data)",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  content, err := client.Containers.Files.Content.Get(\n    context.TODO(),\n    \"container_id\",\n    \"file_id\",\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", content)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.core.http.HttpResponse;\nimport com.openai.models.containers.files.content.ContentRetrieveParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        ContentRetrieveParams params = ContentRetrieveParams.builder()\n            .containerId(\"container_id\")\n            .fileId(\"file_id\")\n            .build();\n        HttpResponse content = client.containers().files().content().retrieve(params);\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\ncontent = openai.containers.files.content.retrieve(\"file_id\", container_id: \"container_id\")\n\nputs(content)",
      },
    },
  }
)
op RetrieveContainerFileContent(
  @path
  container_id: string,

  @path
  file_id: string,
): OkResponse;
