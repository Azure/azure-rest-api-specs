import "./routes.tsp";
import "@typespec/openapi";
using TypeSpec.OpenAPI;
namespace Azure.AI.Projects;
@@extension(
  Azure.AI.Projects.Containers.ListContainers,
  "x-oaiMeta",
  #{
    name: "List containers",
    group: "containers",
    path: "get",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/containers \\
            -H "Authorization: Bearer $OPENAI_API_KEY"
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          // Automatically fetches more pages as needed.
          for await (const containerListResponse of client.containers.list()) {
            console.log(containerListResponse.id);
          }
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          page = client.containers.list()
          page = page.data[0]
          print(page.id)
          """,
        go: """
          package main
          
          import (
          	"context"
          	"fmt"
          
          	"github.com/openai/openai-go"
          	"github.com/openai/openai-go/option"
          )
          
          func main() {
          	client := openai.NewClient(
          		option.WithAPIKey("My API Key"),
          	)
          	page, err := client.Containers.List(context.TODO(), openai.ContainerListParams{})
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", page)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.containers.ContainerListPage;
          import com.openai.models.containers.ContainerListParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  ContainerListPage page = client.containers().list();
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          page = openai.containers.list
          
          puts(page)
          """,
      },
      response: """
        {
          "object": "list",
          "data": [
            {
                "id": "cntr_682dfebaacac8198bbfe9c2474fb6f4a085685cbe3cb5863",
                "object": "container",
                "created_at": 1747844794,
                "status": "running",
                "expires_after": {
                    "anchor": "last_active_at",
                    "minutes": 20
                },
                "last_active_at": 1747844794,
                "memory_limit": "4g",
                "name": "My Container"
            }
          ],
          "first_id": "container_123",
          "last_id": "container_123",
          "has_more": false
        }
        
        """,
    },
  }
);

@@extension(Azure.AI.Projects.Containers.ListContainers, "x-ms-list", true);

@@extension(
  Azure.AI.Projects.Containers.CreateContainer,
  "x-oaiMeta",
  #{
    name: "Create container",
    group: "containers",
    path: "post",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/containers \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "Content-Type: application/json" \\
            -d '{
                  "name": "My Container",
                  "memory_limit": "4g",
                  "skills": [
                    {
                      "type": "skill_reference",
                      "skill_id": "skill_4db6f1a2c9e73508b41f9da06e2c7b5f"
                    },
                    {
                      "type": "skill_reference",
                      "skill_id": "openai-spreadsheets",
                      "version": "latest"
                    }
                  ],
                  "network_policy": {
                    "type": "allowlist",
                    "allowed_domains": ["api.buildkite.com"]
                  }
                }'
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const container = await client.containers.create({ name: 'name' });
          
          console.log(container.id);
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          container = client.containers.create(
              name="name",
          )
          print(container.id)
          """,
        go: """
          package main
          
          import (
          	"context"
          	"fmt"
          
          	"github.com/openai/openai-go"
          	"github.com/openai/openai-go/option"
          )
          
          func main() {
          	client := openai.NewClient(
          		option.WithAPIKey("My API Key"),
          	)
          	container, err := client.Containers.New(context.TODO(), openai.ContainerNewParams{
          		Name: "name",
          	})
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", container.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.containers.ContainerCreateParams;
          import com.openai.models.containers.ContainerCreateResponse;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  ContainerCreateParams params = ContainerCreateParams.builder()
                      .name("name")
                      .build();
                  ContainerCreateResponse container = client.containers().create(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          container = openai.containers.create(name: "name")
          
          puts(container)
          """,
      },
      response: """
        {
            "id": "cntr_682e30645a488191b6363a0cbefc0f0a025ec61b66250591",
            "object": "container",
            "created_at": 1747857508,
            "status": "running",
            "expires_after": {
                "anchor": "last_active_at",
                "minutes": 20
            },
            "last_active_at": 1747857508,
            "network_policy": {
                "type": "allowlist",
                "allowed_domains": ["api.buildkite.com"]
            },
            "memory_limit": "4g",
            "name": "My Container"
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Containers.DeleteContainer,
  "x-oaiMeta",
  #{
    name: "Delete a container",
    group: "containers",
    path: "delete",
    examples: #{
      request: #{
        curl: """
          curl -X DELETE https://api.openai.com/v1/containers/cntr_682dfebaacac8198bbfe9c2474fb6f4a085685cbe3cb5863 \\
            -H "Authorization: Bearer $OPENAI_API_KEY"
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          await client.containers.delete('container_id');
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          client.containers.delete(
              "container_id",
          )
          """,
        go: """
          package main
          
          import (
          	"context"
          
          	"github.com/openai/openai-go"
          	"github.com/openai/openai-go/option"
          )
          
          func main() {
          	client := openai.NewClient(
          		option.WithAPIKey("My API Key"),
          	)
          	err := client.Containers.Delete(context.TODO(), "container_id")
          	if err != nil {
          		panic(err.Error())
          	}
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.containers.ContainerDeleteParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  client.containers().delete("container_id");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          result = openai.containers.delete("container_id")
          
          puts(result)
          """,
      },
      response: """
        {
            "id": "cntr_682dfebaacac8198bbfe9c2474fb6f4a085685cbe3cb5863",
            "object": "container.deleted",
            "deleted": true
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Containers.RetrieveContainer,
  "x-oaiMeta",
  #{
    name: "Retrieve container",
    group: "containers",
    path: "get",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/containers/cntr_682dfebaacac8198bbfe9c2474fb6f4a085685cbe3cb5863 \\
            -H "Authorization: Bearer $OPENAI_API_KEY"
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const container = await client.containers.retrieve('container_id');
          
          console.log(container.id);
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          container = client.containers.retrieve(
              "container_id",
          )
          print(container.id)
          """,
        go: """
          package main
          
          import (
          	"context"
          	"fmt"
          
          	"github.com/openai/openai-go"
          	"github.com/openai/openai-go/option"
          )
          
          func main() {
          	client := openai.NewClient(
          		option.WithAPIKey("My API Key"),
          	)
          	container, err := client.Containers.Get(context.TODO(), "container_id")
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", container.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.containers.ContainerRetrieveParams;
          import com.openai.models.containers.ContainerRetrieveResponse;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  ContainerRetrieveResponse container = client.containers().retrieve("container_id");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          container = openai.containers.retrieve("container_id")
          
          puts(container)
          """,
      },
      response: """
        {
            "id": "cntr_682dfebaacac8198bbfe9c2474fb6f4a085685cbe3cb5863",
            "object": "container",
            "created_at": 1747844794,
            "status": "running",
            "expires_after": {
                "anchor": "last_active_at",
                "minutes": 20
            },
            "last_active_at": 1747844794,
            "memory_limit": "4g",
            "name": "My Container"
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Containers.ListContainerFiles,
  "x-oaiMeta",
  #{
    name: "List container files",
    group: "containers",
    path: "get",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/containers/cntr_682e0e7318108198aa783fd921ff305e08e78805b9fdbb04/files \\
            -H "Authorization: Bearer $OPENAI_API_KEY"
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          // Automatically fetches more pages as needed.
          for await (const fileListResponse of client.containers.files.list('container_id')) {
            console.log(fileListResponse.id);
          }
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          page = client.containers.files.list(
              container_id="container_id",
          )
          page = page.data[0]
          print(page.id)
          """,
        go: """
          package main
          
          import (
          	"context"
          	"fmt"
          
          	"github.com/openai/openai-go"
          	"github.com/openai/openai-go/option"
          )
          
          func main() {
          	client := openai.NewClient(
          		option.WithAPIKey("My API Key"),
          	)
          	page, err := client.Containers.Files.List(
          		context.TODO(),
          		"container_id",
          		openai.ContainerFileListParams{},
          	)
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", page)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.containers.files.FileListPage;
          import com.openai.models.containers.files.FileListParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  FileListPage page = client.containers().files().list("container_id");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          page = openai.containers.files.list("container_id")
          
          puts(page)
          """,
      },
      response: """
        {
            "object": "list",
            "data": [
                {
                    "id": "cfile_682e0e8a43c88191a7978f477a09bdf5",
                    "object": "container.file",
                    "created_at": 1747848842,
                    "bytes": 880,
                    "container_id": "cntr_682e0e7318108198aa783fd921ff305e08e78805b9fdbb04",
                    "path": "/mnt/data/88e12fa445d32636f190a0b33daed6cb-tsconfig.json",
                    "source": "user"
                }
            ],
            "first_id": "cfile_682e0e8a43c88191a7978f477a09bdf5",
            "has_more": false,
            "last_id": "cfile_682e0e8a43c88191a7978f477a09bdf5"
        }
        
        """,
    },
  }
);

@@extension(Azure.AI.Projects.Containers.ListContainerFiles, "x-ms-list", true);

@@extension(
  Azure.AI.Projects.Containers.CreateContainerFileMultipart,
  "x-oaiMeta",
  #{
    name: "Create container file",
    group: "containers",
    path: "post",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/containers/cntr_682e0e7318108198aa783fd921ff305e08e78805b9fdbb04/files \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -F file="@example.txt"
          
          """,
        `node.js`: """
          import fs from 'fs';
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const file = await client.containers.files.create('container_id');
          
          console.log(file.id);
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          file = client.containers.files.create(
              container_id="container_id",
          )
          print(file.id)
          """,
        go: """
          package main
          
          import (
          	"context"
          	"fmt"
          
          	"github.com/openai/openai-go"
          	"github.com/openai/openai-go/option"
          )
          
          func main() {
          	client := openai.NewClient(
          		option.WithAPIKey("My API Key"),
          	)
          	file, err := client.Containers.Files.New(
          		context.TODO(),
          		"container_id",
          		openai.ContainerFileNewParams{},
          	)
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", file.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.containers.files.FileCreateParams;
          import com.openai.models.containers.files.FileCreateResponse;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  FileCreateResponse file = client.containers().files().create("container_id");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          file = openai.containers.files.create("container_id")
          
          puts(file)
          """,
      },
      response: """
        {
          "id": "cfile_682e0e8a43c88191a7978f477a09bdf5",
          "object": "container.file",
          "created_at": 1747848842,
          "bytes": 880,
          "container_id": "cntr_682e0e7318108198aa783fd921ff305e08e78805b9fdbb04",
          "path": "/mnt/data/88e12fa445d32636f190a0b33daed6cb-tsconfig.json",
          "source": "user"
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Containers.CreateContainerFileJson,
  "x-oaiMeta",
  #{
    name: "Create container file",
    group: "containers",
    path: "post",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/containers/cntr_682e0e7318108198aa783fd921ff305e08e78805b9fdbb04/files \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -F file="@example.txt"
          
          """,
        `node.js`: """
          import fs from 'fs';
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const file = await client.containers.files.create('container_id');
          
          console.log(file.id);
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          file = client.containers.files.create(
              container_id="container_id",
          )
          print(file.id)
          """,
        go: """
          package main
          
          import (
          	"context"
          	"fmt"
          
          	"github.com/openai/openai-go"
          	"github.com/openai/openai-go/option"
          )
          
          func main() {
          	client := openai.NewClient(
          		option.WithAPIKey("My API Key"),
          	)
          	file, err := client.Containers.Files.New(
          		context.TODO(),
          		"container_id",
          		openai.ContainerFileNewParams{},
          	)
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", file.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.containers.files.FileCreateParams;
          import com.openai.models.containers.files.FileCreateResponse;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  FileCreateResponse file = client.containers().files().create("container_id");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          file = openai.containers.files.create("container_id")
          
          puts(file)
          """,
      },
      response: """
        {
          "id": "cfile_682e0e8a43c88191a7978f477a09bdf5",
          "object": "container.file",
          "created_at": 1747848842,
          "bytes": 880,
          "container_id": "cntr_682e0e7318108198aa783fd921ff305e08e78805b9fdbb04",
          "path": "/mnt/data/88e12fa445d32636f190a0b33daed6cb-tsconfig.json",
          "source": "user"
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Containers.DeleteContainerFile,
  "x-oaiMeta",
  #{
    name: "Delete a container file",
    group: "containers",
    path: "delete",
    examples: #{
      request: #{
        curl: """
          curl -X DELETE https://api.openai.com/v1/containers/cntr_682dfebaacac8198bbfe9c2474fb6f4a085685cbe3cb5863/files/cfile_682e0e8a43c88191a7978f477a09bdf5 \\
            -H "Authorization: Bearer $OPENAI_API_KEY"
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          await client.containers.files.delete('file_id', { container_id: 'container_id' });
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          client.containers.files.delete(
              file_id="file_id",
              container_id="container_id",
          )
          """,
        go: """
          package main
          
          import (
          	"context"
          
          	"github.com/openai/openai-go"
          	"github.com/openai/openai-go/option"
          )
          
          func main() {
          	client := openai.NewClient(
          		option.WithAPIKey("My API Key"),
          	)
          	err := client.Containers.Files.Delete(
          		context.TODO(),
          		"container_id",
          		"file_id",
          	)
          	if err != nil {
          		panic(err.Error())
          	}
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.containers.files.FileDeleteParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  FileDeleteParams params = FileDeleteParams.builder()
                      .containerId("container_id")
                      .fileId("file_id")
                      .build();
                  client.containers().files().delete(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          result = openai.containers.files.delete("file_id", container_id: "container_id")
          
          puts(result)
          """,
      },
      response: """
        {
            "id": "cfile_682e0e8a43c88191a7978f477a09bdf5",
            "object": "container.file.deleted",
            "deleted": true
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Containers.RetrieveContainerFile,
  "x-oaiMeta",
  #{
    name: "Retrieve container file",
    group: "containers",
    path: "get",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/containers/container_123/files/file_456 \\
            -H "Authorization: Bearer $OPENAI_API_KEY"
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const file = await client.containers.files.retrieve('file_id', { container_id: 'container_id' });
          
          console.log(file.id);
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          file = client.containers.files.retrieve(
              file_id="file_id",
              container_id="container_id",
          )
          print(file.id)
          """,
        go: """
          package main
          
          import (
          	"context"
          	"fmt"
          
          	"github.com/openai/openai-go"
          	"github.com/openai/openai-go/option"
          )
          
          func main() {
          	client := openai.NewClient(
          		option.WithAPIKey("My API Key"),
          	)
          	file, err := client.Containers.Files.Get(
          		context.TODO(),
          		"container_id",
          		"file_id",
          	)
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", file.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.containers.files.FileRetrieveParams;
          import com.openai.models.containers.files.FileRetrieveResponse;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  FileRetrieveParams params = FileRetrieveParams.builder()
                      .containerId("container_id")
                      .fileId("file_id")
                      .build();
                  FileRetrieveResponse file = client.containers().files().retrieve(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          file = openai.containers.files.retrieve("file_id", container_id: "container_id")
          
          puts(file)
          """,
      },
      response: """
        {
            "id": "cfile_682e0e8a43c88191a7978f477a09bdf5",
            "object": "container.file",
            "created_at": 1747848842,
            "bytes": 880,
            "container_id": "cntr_682e0e7318108198aa783fd921ff305e08e78805b9fdbb04",
            "path": "/mnt/data/88e12fa445d32636f190a0b33daed6cb-tsconfig.json",
            "source": "user"
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Containers.RetrieveContainerFileContent,
  "x-oaiMeta",
  #{
    name: "Retrieve container file content",
    group: "containers",
    path: "get",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/containers/container_123/files/cfile_456/content \\
            -H "Authorization: Bearer $OPENAI_API_KEY"
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const content = await client.containers.files.content.retrieve('file_id', {
            container_id: 'container_id',
          });
          
          console.log(content);
          
          const data = await content.blob();
          console.log(data);
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          content = client.containers.files.content.retrieve(
              file_id="file_id",
              container_id="container_id",
          )
          print(content)
          data = content.read()
          print(data)
          """,
        go: """
          package main
          
          import (
          	"context"
          	"fmt"
          
          	"github.com/openai/openai-go"
          	"github.com/openai/openai-go/option"
          )
          
          func main() {
          	client := openai.NewClient(
          		option.WithAPIKey("My API Key"),
          	)
          	content, err := client.Containers.Files.Content.Get(
          		context.TODO(),
          		"container_id",
          		"file_id",
          	)
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", content)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.core.http.HttpResponse;
          import com.openai.models.containers.files.content.ContentRetrieveParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  ContentRetrieveParams params = ContentRetrieveParams.builder()
                      .containerId("container_id")
                      .fileId("file_id")
                      .build();
                  HttpResponse content = client.containers().files().content().retrieve(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          content = openai.containers.files.content.retrieve("file_id", container_id: "container_id")
          
          puts(content)
          """,
      },
      response: """
        <binary content of the file>
        
        """,
    },
  }
);
