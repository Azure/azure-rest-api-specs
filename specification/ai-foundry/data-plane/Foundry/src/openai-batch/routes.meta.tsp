import "./routes.tsp";
import "@typespec/openapi";
using TypeSpec.OpenAPI;
namespace Azure.AI.Projects;
@@extension(
  Azure.AI.Projects.Batches.listBatches,
  "x-oaiMeta",
  #{
    name: "List batches",
    group: "batch",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/batches?limit=2 \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "Content-Type: application/json"
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          page = client.batches.list()
          page = page.data[0]
          print(page.id)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          async function main() {
            const list = await openai.batches.list();
          
            for await (const batch of list) {
              console.log(batch);
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
          for await (const batch of client.batches.list()) {
            console.log(batch.id);
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
          	page, err := client.Batches.List(context.TODO(), openai.BatchListParams{})
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
          import com.openai.models.batches.BatchListPage;
          import com.openai.models.batches.BatchListParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  BatchListPage page = client.batches().list();
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          page = openai.batches.list
          
          puts(page)
          """,
      },
      response: """
        {
          "object": "list",
          "data": [
            {
              "id": "batch_abc123",
              "object": "batch",
              "endpoint": "/v1/chat/completions",
              "errors": null,
              "input_file_id": "file-abc123",
              "completion_window": "24h",
              "status": "completed",
              "output_file_id": "file-cvaTdG",
              "error_file_id": "file-HOWS94",
              "created_at": 1711471533,
              "in_progress_at": 1711471538,
              "expires_at": 1711557933,
              "finalizing_at": 1711493133,
              "completed_at": 1711493163,
              "failed_at": null,
              "expired_at": null,
              "cancelling_at": null,
              "cancelled_at": null,
              "request_counts": {
                "total": 100,
                "completed": 95,
                "failed": 5
              },
              "metadata": {
                "customer_id": "user_123456789",
                "batch_description": "Nightly job",
              }
            },
            { ... },
          ],
          "first_id": "batch_abc123",
          "last_id": "batch_abc456",
          "has_more": true
        }
        
        """,
    },
  }
);

@@extension(Azure.AI.Projects.Batches.listBatches, "x-ms-list", true);

@@extension(
  Azure.AI.Projects.Batches.createBatch,
  "x-oaiMeta",
  #{
    name: "Create batch",
    group: "batch",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/batches \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "Content-Type: application/json" \\
            -d '{
              "input_file_id": "file-abc123",
              "endpoint": "/v1/chat/completions",
              "completion_window": "24h"
            }'
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          batch = client.batches.create(
              completion_window="24h",
              endpoint="/v1/responses",
              input_file_id="input_file_id",
          )
          print(batch.id)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          async function main() {
            const batch = await openai.batches.create({
              input_file_id: "file-abc123",
              endpoint: "/v1/chat/completions",
              completion_window: "24h"
            });
          
            console.log(batch);
          }
          
          main();
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const batch = await client.batches.create({
            completion_window: '24h',
            endpoint: '/v1/responses',
            input_file_id: 'input_file_id',
          });
          
          console.log(batch.id);
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
          	batch, err := client.Batches.New(context.TODO(), openai.BatchNewParams{
          		CompletionWindow: openai.BatchNewParamsCompletionWindow24h,
          		Endpoint:         openai.BatchNewParamsEndpointV1Responses,
          		InputFileID:      "input_file_id",
          	})
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", batch.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.batches.Batch;
          import com.openai.models.batches.BatchCreateParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  BatchCreateParams params = BatchCreateParams.builder()
                      .completionWindow(BatchCreateParams.CompletionWindow._24H)
                      .endpoint(BatchCreateParams.Endpoint.V1_RESPONSES)
                      .inputFileId("input_file_id")
                      .build();
                  Batch batch = client.batches().create(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          batch = openai.batches.create(
            completion_window: :"24h",
            endpoint: :"/v1/responses",
            input_file_id: "input_file_id"
          )
          
          puts(batch)
          """,
      },
      response: """
        {
          "id": "batch_abc123",
          "object": "batch",
          "endpoint": "/v1/chat/completions",
          "errors": null,
          "input_file_id": "file-abc123",
          "completion_window": "24h",
          "status": "validating",
          "output_file_id": null,
          "error_file_id": null,
          "created_at": 1711471533,
          "in_progress_at": null,
          "expires_at": null,
          "finalizing_at": null,
          "completed_at": null,
          "failed_at": null,
          "expired_at": null,
          "cancelling_at": null,
          "cancelled_at": null,
          "request_counts": {
            "total": 0,
            "completed": 0,
            "failed": 0
          },
          "metadata": {
            "customer_id": "user_123456789",
            "batch_description": "Nightly eval job",
          }
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Batches.retrieveBatch,
  "x-oaiMeta",
  #{
    name: "Retrieve batch",
    group: "batch",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/batches/batch_abc123 \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "Content-Type: application/json" \\
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          batch = client.batches.retrieve(
              "batch_id",
          )
          print(batch.id)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          async function main() {
            const batch = await openai.batches.retrieve("batch_abc123");
          
            console.log(batch);
          }
          
          main();
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const batch = await client.batches.retrieve('batch_id');
          
          console.log(batch.id);
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
          	batch, err := client.Batches.Get(context.TODO(), "batch_id")
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", batch.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.batches.Batch;
          import com.openai.models.batches.BatchRetrieveParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  Batch batch = client.batches().retrieve("batch_id");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          batch = openai.batches.retrieve("batch_id")
          
          puts(batch)
          """,
      },
      response: """
        {
          "id": "batch_abc123",
          "object": "batch",
          "endpoint": "/v1/completions",
          "errors": null,
          "input_file_id": "file-abc123",
          "completion_window": "24h",
          "status": "completed",
          "output_file_id": "file-cvaTdG",
          "error_file_id": "file-HOWS94",
          "created_at": 1711471533,
          "in_progress_at": 1711471538,
          "expires_at": 1711557933,
          "finalizing_at": 1711493133,
          "completed_at": 1711493163,
          "failed_at": null,
          "expired_at": null,
          "cancelling_at": null,
          "cancelled_at": null,
          "request_counts": {
            "total": 100,
            "completed": 95,
            "failed": 5
          },
          "metadata": {
            "customer_id": "user_123456789",
            "batch_description": "Nightly eval job",
          }
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Batches.cancelBatch,
  "x-oaiMeta",
  #{
    name: "Cancel batch",
    group: "batch",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/batches/batch_abc123/cancel \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "Content-Type: application/json" \\
            -X POST
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          batch = client.batches.cancel(
              "batch_id",
          )
          print(batch.id)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          async function main() {
            const batch = await openai.batches.cancel("batch_abc123");
          
            console.log(batch);
          }
          
          main();
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const batch = await client.batches.cancel('batch_id');
          
          console.log(batch.id);
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
          	batch, err := client.Batches.Cancel(context.TODO(), "batch_id")
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", batch.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.batches.Batch;
          import com.openai.models.batches.BatchCancelParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  Batch batch = client.batches().cancel("batch_id");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          batch = openai.batches.cancel("batch_id")
          
          puts(batch)
          """,
      },
      response: """
        {
          "id": "batch_abc123",
          "object": "batch",
          "endpoint": "/v1/chat/completions",
          "errors": null,
          "input_file_id": "file-abc123",
          "completion_window": "24h",
          "status": "cancelling",
          "output_file_id": null,
          "error_file_id": null,
          "created_at": 1711471533,
          "in_progress_at": 1711471538,
          "expires_at": 1711557933,
          "finalizing_at": null,
          "completed_at": null,
          "failed_at": null,
          "expired_at": null,
          "cancelling_at": 1711475133,
          "cancelled_at": null,
          "request_counts": {
            "total": 100,
            "completed": 23,
            "failed": 1
          },
          "metadata": {
            "customer_id": "user_123456789",
            "batch_description": "Nightly eval job",
          }
        }
        
        """,
    },
  }
);
