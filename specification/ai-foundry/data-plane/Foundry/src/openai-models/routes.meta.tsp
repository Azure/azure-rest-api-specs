import "./routes.tsp";
import "@typespec/openapi";
using TypeSpec.OpenAPI;
namespace Azure.AI.Projects;
@@extension(
  Azure.AI.Projects.Models.listModels,
  "x-oaiMeta",
  #{
    name: "List models",
    group: "models",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/models \\
            -H "Authorization: Bearer $OPENAI_API_KEY"
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          page = client.models.list()
          page = page.data[0]
          print(page.id)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          async function main() {
            const list = await openai.models.list();
          
            for await (const model of list) {
              console.log(model);
            }
          }
          main();
          """,
        csharp: """
          using System;
          
          using OpenAI.Models;
          
          OpenAIModelClient client = new(
              apiKey: Environment.GetEnvironmentVariable("OPENAI_API_KEY")
          );
          
          foreach (var model in client.GetModels().Value)
          {
              Console.WriteLine(model.Id);
          }
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          // Automatically fetches more pages as needed.
          for await (const model of client.models.list()) {
            console.log(model.id);
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
          	page, err := client.Models.List(context.TODO())
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
          import com.openai.models.models.ModelListPage;
          import com.openai.models.models.ModelListParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  ModelListPage page = client.models().list();
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          page = openai.models.list
          
          puts(page)
          """,
      },
      response: """
        {
          "object": "list",
          "data": [
            {
              "id": "model-id-0",
              "object": "model",
              "created": 1686935002,
              "owned_by": "organization-owner"
            },
            {
              "id": "model-id-1",
              "object": "model",
              "created": 1686935002,
              "owned_by": "organization-owner",
            },
            {
              "id": "model-id-2",
              "object": "model",
              "created": 1686935002,
              "owned_by": "openai"
            },
          ]
        }
        
        """,
    },
  }
);

@@extension(Azure.AI.Projects.Models.listModels, "x-ms-list", true);

@@extension(
  Azure.AI.Projects.Models.deleteModel,
  "x-oaiMeta",
  #{
    name: "Delete a fine-tuned model",
    group: "models",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/models/ft:gpt-4o-mini:acemeco:suffix:abc123 \\
            -X DELETE \\
            -H "Authorization: Bearer $OPENAI_API_KEY"
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          model_deleted = client.models.delete(
              "ft:gpt-4o-mini:acemeco:suffix:abc123",
          )
          print(model_deleted.id)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          async function main() {
            const model = await openai.models.delete("ft:gpt-4o-mini:acemeco:suffix:abc123");
          
            console.log(model);
          }
          main();
          """,
        csharp: """
          using System;
          using System.ClientModel;
          
          using OpenAI.Models;
          
          OpenAIModelClient client = new(
              apiKey: Environment.GetEnvironmentVariable("OPENAI_API_KEY")
          );
          
          ClientResult success = client.DeleteModel("ft:gpt-4o-mini:acemeco:suffix:abc123");
          Console.WriteLine(success);
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const modelDeleted = await client.models.delete('ft:gpt-4o-mini:acemeco:suffix:abc123');
          
          console.log(modelDeleted.id);
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
          	modelDeleted, err := client.Models.Delete(context.TODO(), "ft:gpt-4o-mini:acemeco:suffix:abc123")
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", modelDeleted.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.models.ModelDeleteParams;
          import com.openai.models.models.ModelDeleted;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  ModelDeleted modelDeleted = client.models().delete("ft:gpt-4o-mini:acemeco:suffix:abc123");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          model_deleted = openai.models.delete("ft:gpt-4o-mini:acemeco:suffix:abc123")
          
          puts(model_deleted)
          """,
      },
      response: """
        {
          "id": "ft:gpt-4o-mini:acemeco:suffix:abc123",
          "object": "model",
          "deleted": true
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Models.retrieveModel,
  "x-oaiMeta",
  #{
    name: "Retrieve model",
    group: "models",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/models/VAR_chat_model_id \\
            -H "Authorization: Bearer $OPENAI_API_KEY"
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          model = client.models.retrieve(
              "gpt-4o-mini",
          )
          print(model.id)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          async function main() {
            const model = await openai.models.retrieve("VAR_chat_model_id");
          
            console.log(model);
          }
          
          main();
          """,
        csharp: """
          using System;
          using System.ClientModel;
          
          using OpenAI.Models;
          
            OpenAIModelClient client = new(
              apiKey: Environment.GetEnvironmentVariable("OPENAI_API_KEY")
          );
          
          ClientResult<OpenAIModel> model = client.GetModel("babbage-002");
          Console.WriteLine(model.Value.Id);
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const model = await client.models.retrieve('gpt-4o-mini');
          
          console.log(model.id);
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
          	model, err := client.Models.Get(context.TODO(), "gpt-4o-mini")
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", model.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.models.Model;
          import com.openai.models.models.ModelRetrieveParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  Model model = client.models().retrieve("gpt-4o-mini");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          model = openai.models.retrieve("gpt-4o-mini")
          
          puts(model)
          """,
      },
      response: """
        {
          "id": "VAR_chat_model_id",
          "object": "model",
          "created": 1686935002,
          "owned_by": "openai"
        }
        
        """,
    },
  }
);
