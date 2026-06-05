import "./routes.tsp";
import "@typespec/openapi";
using TypeSpec.OpenAPI;
namespace Azure.AI.Projects;
@@extension(
  Azure.AI.Projects.Completions.createCompletion,
  "x-oaiMeta",
  #{
    name: "Create completion",
    group: "completions",
    legacy: true,
    examples: #[
      #{
        title: "No streaming",
        request: #{
          curl: """
            curl https://api.openai.com/v1/completions \\
              -H "Content-Type: application/json" \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -d '{
                "model": "VAR_completion_model_id",
                "prompt": "Say this is a test",
                "max_tokens": 7,
                "temperature": 0
              }'
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            for completion in client.completions.create(
                model="gpt-3.5-turbo-instruct",
                prompt="This is a test.",
            ):
              print(completion)
            """,
          javascript: """
            import OpenAI from "openai";
            
            const openai = new OpenAI();
            
            async function main() {
              const completion = await openai.completions.create({
                model: "VAR_completion_model_id",
                prompt: "Say this is a test.",
                max_tokens: 7,
                temperature: 0,
              });
            
              console.log(completion);
            }
            main();
            """,
          `node.js`: """
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const completion = await client.completions.create({
              model: 'gpt-3.5-turbo-instruct',
              prompt: 'This is a test.',
            });
            
            console.log(completion);
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
            	completion, err := client.Completions.New(context.TODO(), openai.CompletionNewParams{
            		Model: openai.CompletionNewParamsModelGPT3_5TurboInstruct,
            		Prompt: openai.CompletionNewParamsPromptUnion{
            			OfString: openai.String("This is a test."),
            		},
            	})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", completion)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.completions.Completion;
            import com.openai.models.completions.CompletionCreateParams;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    CompletionCreateParams params = CompletionCreateParams.builder()
                        .model(CompletionCreateParams.Model.GPT_3_5_TURBO_INSTRUCT)
                        .prompt("This is a test.")
                        .build();
                    Completion completion = client.completions().create(params);
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            completion = openai.completions.create(model: :"gpt-3.5-turbo-instruct", prompt: "This is a test.")
            
            puts(completion)
            """,
        },
        response: """
          {
            "id": "cmpl-uqkvlQyYK7bGYrRHQ0eXlWi7",
            "object": "text_completion",
            "created": 1589478378,
            "model": "VAR_completion_model_id",
            "system_fingerprint": "fp_44709d6fcb",
            "choices": [
              {
                "text": "
          
          This is indeed a test",
                "index": 0,
                "logprobs": null,
                "finish_reason": "length"
              }
            ],
            "usage": {
              "prompt_tokens": 5,
              "completion_tokens": 7,
              "total_tokens": 12
            }
          }
          
          """,
      },
      #{
        title: "Streaming",
        request: #{
          curl: """
            curl https://api.openai.com/v1/completions \\
              -H "Content-Type: application/json" \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -d '{
                "model": "VAR_completion_model_id",
                "prompt": "Say this is a test",
                "max_tokens": 7,
                "temperature": 0,
                "stream": true
              }'
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            for completion in client.completions.create(
                model="gpt-3.5-turbo-instruct",
                prompt="This is a test.",
            ):
              print(completion)
            """,
          javascript: """
            import OpenAI from "openai";
            
            const openai = new OpenAI();
            
            async function main() {
              const stream = await openai.completions.create({
                model: "VAR_completion_model_id",
                prompt: "Say this is a test.",
                stream: true,
              });
            
              for await (const chunk of stream) {
                console.log(chunk.choices[0].text)
              }
            }
            main();
            """,
          `node.js`: """
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const completion = await client.completions.create({
              model: 'gpt-3.5-turbo-instruct',
              prompt: 'This is a test.',
            });
            
            console.log(completion);
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
            	completion, err := client.Completions.New(context.TODO(), openai.CompletionNewParams{
            		Model: openai.CompletionNewParamsModelGPT3_5TurboInstruct,
            		Prompt: openai.CompletionNewParamsPromptUnion{
            			OfString: openai.String("This is a test."),
            		},
            	})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", completion)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.completions.Completion;
            import com.openai.models.completions.CompletionCreateParams;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    CompletionCreateParams params = CompletionCreateParams.builder()
                        .model(CompletionCreateParams.Model.GPT_3_5_TURBO_INSTRUCT)
                        .prompt("This is a test.")
                        .build();
                    Completion completion = client.completions().create(params);
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            completion = openai.completions.create(model: :"gpt-3.5-turbo-instruct", prompt: "This is a test.")
            
            puts(completion)
            """,
        },
        response: """
          {
            "id": "cmpl-7iA7iJjj8V2zOkCGvWF2hAkDWBQZe",
            "object": "text_completion",
            "created": 1690759702,
            "choices": [
              {
                "text": "This",
                "index": 0,
                "logprobs": null,
                "finish_reason": null
              }
            ],
            "model": "gpt-3.5-turbo-instruct"
            "system_fingerprint": "fp_44709d6fcb",
          }
          
          """,
      }
    ],
  }
);
