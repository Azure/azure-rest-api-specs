import "./routes.tsp";
import "@typespec/openapi";
using TypeSpec.OpenAPI;
namespace Azure.AI.Projects;
@@extension(
  Azure.AI.Projects.Files.listFiles,
  "x-oaiMeta",
  #{
    name: "List files",
    group: "files",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/files \\
            -H "Authorization: Bearer $OPENAI_API_KEY"
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          page = client.files.list()
          page = page.data[0]
          print(page)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          async function main() {
            const list = await openai.files.list();
          
            for await (const file of list) {
              console.log(file);
            }
          }
          
          main();
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          // Automatically fetches more pages as needed.
          for await (const fileObject of client.files.list()) {
            console.log(fileObject);
          }
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
          	page, err := client.Files.List(context.TODO(), openai.FileListParams{})
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
          import com.openai.models.files.FileListPage;
          import com.openai.models.files.FileListParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  FileListPage page = client.files().list();
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          page = openai.files.list
          
          puts(page)
          """,
      },
      response: """
        {
          "object": "list",
          "data": [
            {
              "id": "file-abc123",
              "object": "file",
              "bytes": 175,
              "created_at": 1613677385,
              "expires_at": 1677614202,
              "filename": "salesOverview.pdf",
              "purpose": "assistants",
            },
            {
              "id": "file-abc456",
              "object": "file",
              "bytes": 140,
              "created_at": 1613779121,
              "expires_at": 1677614202,
              "filename": "puppy.jsonl",
              "purpose": "fine-tune",
            }
          ],
          "first_id": "file-abc123",
          "last_id": "file-abc456",
          "has_more": false
        }
        
        """,
    },
  }
);

@@extension(Azure.AI.Projects.Files.listFiles, "x-ms-list", true);

@@extension(
  Azure.AI.Projects.Files.createFile,
  "x-oaiMeta",
  #{
    name: "Upload file",
    group: "files",
    description: """
      Uploads a file for later use across OpenAI APIs. Uploads to this endpoint are rate-limited to 1,000 requests per minute per authenticated user. For Retrieval or `file_search` ingestion, upload files here first. If you need to attach multiple uploaded files to the same vector store, use vector store file batches instead of attaching them one by one.
      
      """,
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/files \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -F purpose="fine-tune" \\
            -F file="@mydata.jsonl"
            -F expires_after[anchor]="created_at"
            -F expires_after[seconds]=2592000
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          file_object = client.files.create(
              file=b"Example data",
              purpose="assistants",
          )
          print(file_object.id)
          """,
        javascript: """
          import fs from "fs";
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          async function main() {
            const file = await openai.files.create({
              file: fs.createReadStream("mydata.jsonl"),
              purpose: "fine-tune",
              expires_after: {
                anchor: "created_at",
                seconds: 2592000
              }
            });
          
            console.log(file);
          }
          
          main();
          """,
        `node.js`: """
          import fs from 'fs';
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const fileObject = await client.files.create({
            file: fs.createReadStream('fine-tune.jsonl'),
            purpose: 'assistants',
          });
          
          console.log(fileObject.id);
          """,
        go: """
          package main
          
          import (
          	"bytes"
          	"context"
          	"fmt"
          	"io"
          
          	"github.com/openai/openai-go"
          	"github.com/openai/openai-go/option"
          )
          
          func main() {
          	client := openai.NewClient(
          		option.WithAPIKey("My API Key"),
          	)
          	fileObject, err := client.Files.New(context.TODO(), openai.FileNewParams{
          		File:    io.Reader(bytes.NewBuffer([]byte("Example data"))),
          		Purpose: openai.FilePurposeAssistants,
          	})
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", fileObject.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.files.FileCreateParams;
          import com.openai.models.files.FileObject;
          import com.openai.models.files.FilePurpose;
          import java.io.ByteArrayInputStream;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  FileCreateParams params = FileCreateParams.builder()
                      .file(new ByteArrayInputStream("Example data".getBytes()))
                      .purpose(FilePurpose.ASSISTANTS)
                      .build();
                  FileObject fileObject = client.files().create(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          file_object = openai.files.create(file: StringIO.new("Example data"), purpose: :assistants)
          
          puts(file_object)
          """,
      },
      response: """
        {
          "id": "file-abc123",
          "object": "file",
          "bytes": 120000,
          "created_at": 1677610602,
          "expires_at": 1677614202,
          "filename": "mydata.jsonl",
          "purpose": "fine-tune",
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Files.deleteFile,
  "x-oaiMeta",
  #{
    name: "Delete file",
    group: "files",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/files/file-abc123 \\
            -X DELETE \\
            -H "Authorization: Bearer $OPENAI_API_KEY"
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          file_deleted = client.files.delete(
              "file_id",
          )
          print(file_deleted.id)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          async function main() {
            const file = await openai.files.delete("file-abc123");
          
            console.log(file);
          }
          
          main();
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const fileDeleted = await client.files.delete('file_id');
          
          console.log(fileDeleted.id);
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
          	fileDeleted, err := client.Files.Delete(context.TODO(), "file_id")
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", fileDeleted.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.files.FileDeleteParams;
          import com.openai.models.files.FileDeleted;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  FileDeleted fileDeleted = client.files().delete("file_id");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          file_deleted = openai.files.delete("file_id")
          
          puts(file_deleted)
          """,
      },
      response: """
        {
          "id": "file-abc123",
          "object": "file",
          "deleted": true
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Files.retrieveFile,
  "x-oaiMeta",
  #{
    name: "Retrieve file",
    group: "files",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/files/file-abc123 \\
            -H "Authorization: Bearer $OPENAI_API_KEY"
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          file_object = client.files.retrieve(
              "file_id",
          )
          print(file_object.id)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          async function main() {
            const file = await openai.files.retrieve("file-abc123");
          
            console.log(file);
          }
          
          main();
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const fileObject = await client.files.retrieve('file_id');
          
          console.log(fileObject.id);
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
          	fileObject, err := client.Files.Get(context.TODO(), "file_id")
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", fileObject.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.files.FileObject;
          import com.openai.models.files.FileRetrieveParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  FileObject fileObject = client.files().retrieve("file_id");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          file_object = openai.files.retrieve("file_id")
          
          puts(file_object)
          """,
      },
      response: """
        {
          "id": "file-abc123",
          "object": "file",
          "bytes": 120000,
          "created_at": 1677610602,
          "expires_at": 1677614202,
          "filename": "mydata.jsonl",
          "purpose": "fine-tune",
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Files.downloadFile,
  "x-oaiMeta",
  #{
    name: "Retrieve file content",
    group: "files",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/files/file-abc123/content \\
            -H "Authorization: Bearer $OPENAI_API_KEY" > file.jsonl
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          response = client.files.content(
              "file_id",
          )
          print(response)
          content = response.read()
          print(content)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          async function main() {
            const file = await openai.files.content("file-abc123");
          
            console.log(file);
          }
          
          main();
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const response = await client.files.content('file_id');
          
          console.log(response);
          
          const content = await response.blob();
          console.log(content);
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
          	response, err := client.Files.Content(context.TODO(), "file_id")
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", response)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.core.http.HttpResponse;
          import com.openai.models.files.FileContentParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  HttpResponse response = client.files().content("file_id");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          response = openai.files.content("file_id")
          
          puts(response)
          """,
      },
      response: "",
    },
  }
);
