import "./routes.tsp";
import "@typespec/openapi";
using TypeSpec.OpenAPI;
namespace Azure.AI.Projects;
@@extension(
  Azure.AI.Projects.Uploads.createUpload,
  "x-oaiMeta",
  #{
    name: "Create upload",
    group: "uploads",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/uploads \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -d '{
              "purpose": "fine-tune",
              "filename": "training_examples.jsonl",
              "bytes": 2147483648,
              "mime_type": "text/jsonl",
              "expires_after": {
                "anchor": "created_at",
                "seconds": 3600
              }
            }'
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const upload = await client.uploads.create({
            bytes: 0,
            filename: 'filename',
            mime_type: 'mime_type',
            purpose: 'assistants',
          });
          
          console.log(upload.id);
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          upload = client.uploads.create(
              bytes=0,
              filename="filename",
              mime_type="mime_type",
              purpose="assistants",
          )
          print(upload.id)
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
          	upload, err := client.Uploads.New(context.TODO(), openai.UploadNewParams{
          		Bytes:    0,
          		Filename: "filename",
          		MimeType: "mime_type",
          		Purpose:  openai.FilePurposeAssistants,
          	})
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", upload.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.files.FilePurpose;
          import com.openai.models.uploads.Upload;
          import com.openai.models.uploads.UploadCreateParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  UploadCreateParams params = UploadCreateParams.builder()
                      .bytes(0L)
                      .filename("filename")
                      .mimeType("mime_type")
                      .purpose(FilePurpose.ASSISTANTS)
                      .build();
                  Upload upload = client.uploads().create(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          upload = openai.uploads.create(bytes: 0, filename: "filename", mime_type: "mime_type", purpose: :assistants)
          
          puts(upload)
          """,
      },
      response: """
        {
          "id": "upload_abc123",
          "object": "upload",
          "bytes": 2147483648,
          "created_at": 1719184911,
          "filename": "training_examples.jsonl",
          "purpose": "fine-tune",
          "status": "pending",
          "expires_at": 1719127296
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Uploads.cancelUpload,
  "x-oaiMeta",
  #{
    name: "Cancel upload",
    group: "uploads",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/uploads/upload_abc123/cancel
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const upload = await client.uploads.cancel('upload_abc123');
          
          console.log(upload.id);
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          upload = client.uploads.cancel(
              "upload_abc123",
          )
          print(upload.id)
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
          	upload, err := client.Uploads.Cancel(context.TODO(), "upload_abc123")
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", upload.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.uploads.Upload;
          import com.openai.models.uploads.UploadCancelParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  Upload upload = client.uploads().cancel("upload_abc123");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          upload = openai.uploads.cancel("upload_abc123")
          
          puts(upload)
          """,
      },
      response: """
        {
          "id": "upload_abc123",
          "object": "upload",
          "bytes": 2147483648,
          "created_at": 1719184911,
          "filename": "training_examples.jsonl",
          "purpose": "fine-tune",
          "status": "cancelled",
          "expires_at": 1719127296
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Uploads.completeUpload,
  "x-oaiMeta",
  #{
    name: "Complete upload",
    group: "uploads",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/uploads/upload_abc123/complete
            -d '{
              "part_ids": ["part_def456", "part_ghi789"]
            }'
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const upload = await client.uploads.complete('upload_abc123', { part_ids: ['string'] });
          
          console.log(upload.id);
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          upload = client.uploads.complete(
              upload_id="upload_abc123",
              part_ids=["string"],
          )
          print(upload.id)
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
          	upload, err := client.Uploads.Complete(
          		context.TODO(),
          		"upload_abc123",
          		openai.UploadCompleteParams{
          			PartIDs: []string{"string"},
          		},
          	)
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", upload.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.uploads.Upload;
          import com.openai.models.uploads.UploadCompleteParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  UploadCompleteParams params = UploadCompleteParams.builder()
                      .uploadId("upload_abc123")
                      .addPartId("string")
                      .build();
                  Upload upload = client.uploads().complete(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          upload = openai.uploads.complete("upload_abc123", part_ids: ["string"])
          
          puts(upload)
          """,
      },
      response: """
        {
          "id": "upload_abc123",
          "object": "upload",
          "bytes": 2147483648,
          "created_at": 1719184911,
          "filename": "training_examples.jsonl",
          "purpose": "fine-tune",
          "status": "completed",
          "expires_at": 1719127296,
          "file": {
            "id": "file-xyz321",
            "object": "file",
            "bytes": 2147483648,
            "created_at": 1719186911,
            "expires_at": 1719127296,
            "filename": "training_examples.jsonl",
            "purpose": "fine-tune",
          }
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Uploads.addUploadPart,
  "x-oaiMeta",
  #{
    name: "Add upload part",
    group: "uploads",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/uploads/upload_abc123/parts
            -F data="aHR0cHM6Ly9hcGkub3BlbmFpLmNvbS92MS91cGxvYWRz..."
          
          """,
        `node.js`: """
          import fs from 'fs';
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const uploadPart = await client.uploads.parts.create('upload_abc123', {
            data: fs.createReadStream('path/to/file'),
          });
          
          console.log(uploadPart.id);
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          upload_part = client.uploads.parts.create(
              upload_id="upload_abc123",
              data=b"Example data",
          )
          print(upload_part.id)
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
          	uploadPart, err := client.Uploads.Parts.New(
          		context.TODO(),
          		"upload_abc123",
          		openai.UploadPartNewParams{
          			Data: io.Reader(bytes.NewBuffer([]byte("Example data"))),
          		},
          	)
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", uploadPart.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.uploads.parts.PartCreateParams;
          import com.openai.models.uploads.parts.UploadPart;
          import java.io.ByteArrayInputStream;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  PartCreateParams params = PartCreateParams.builder()
                      .uploadId("upload_abc123")
                      .data(new ByteArrayInputStream("Example data".getBytes()))
                      .build();
                  UploadPart uploadPart = client.uploads().parts().create(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          upload_part = openai.uploads.parts.create("upload_abc123", data: StringIO.new("Example data"))
          
          puts(upload_part)
          """,
      },
      response: """
        {
          "id": "part_def456",
          "object": "upload.part",
          "created_at": 1719185911,
          "upload_id": "upload_abc123"
        }
        
        """,
    },
  }
);
