import "./routes.tsp";
import "@typespec/openapi";
using TypeSpec.OpenAPI;
namespace Azure.AI.Projects;
@@extension(
  Azure.AI.Projects.Moderations.createModeration,
  "x-oaiMeta",
  #{
    name: "Create moderation",
    group: "moderations",
    examples: #[
      #{
        title: "Single string",
        request: #{
          curl: """
            curl https://api.openai.com/v1/moderations \\
              -H "Content-Type: application/json" \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -d '{
                "input": "I want to kill them."
              }'
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            moderation = client.moderations.create(
                input="I want to kill them.",
            )
            print(moderation.id)
            """,
          javascript: """
            import OpenAI from "openai";
            
            const openai = new OpenAI();
            
            async function main() {
              const moderation = await openai.moderations.create({ input: "I want to kill them." });
            
              console.log(moderation);
            }
            main();
            
            """,
          csharp: """
            using System;
            using System.ClientModel;
            
            using OpenAI.Moderations;
            
            ModerationClient client = new(
                model: "omni-moderation-latest",
                apiKey: Environment.GetEnvironmentVariable("OPENAI_API_KEY")
            );
            
            ClientResult<ModerationResult> moderation = client.ClassifyText("I want to kill them.");
            
            """,
          `node.js`: """
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const moderation = await client.moderations.create({ input: 'I want to kill them.' });
            
            console.log(moderation.id);
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
            	moderation, err := client.Moderations.New(context.TODO(), openai.ModerationNewParams{
            		Input: openai.ModerationNewParamsInputUnion{
            			OfString: openai.String("I want to kill them."),
            		},
            	})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", moderation.ID)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.moderations.ModerationCreateParams;
            import com.openai.models.moderations.ModerationCreateResponse;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    ModerationCreateParams params = ModerationCreateParams.builder()
                        .input("I want to kill them.")
                        .build();
                    ModerationCreateResponse moderation = client.moderations().create(params);
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            moderation = openai.moderations.create(input: "I want to kill them.")
            
            puts(moderation)
            """,
        },
        response: """
          {
            "id": "modr-AB8CjOTu2jiq12hp1AQPfeqFWaORR",
            "model": "text-moderation-007",
            "results": [
              {
                "flagged": true,
                "categories": {
                  "sexual": false,
                  "hate": false,
                  "harassment": true,
                  "self-harm": false,
                  "sexual/minors": false,
                  "hate/threatening": false,
                  "violence/graphic": false,
                  "self-harm/intent": false,
                  "self-harm/instructions": false,
                  "harassment/threatening": true,
                  "violence": true
                },
                "category_scores": {
                  "sexual": 0.000011726012417057063,
                  "hate": 0.22706663608551025,
                  "harassment": 0.5215635299682617,
                  "self-harm": 2.227119921371923e-6,
                  "sexual/minors": 7.107352217872176e-8,
                  "hate/threatening": 0.023547329008579254,
                  "violence/graphic": 0.00003391829886822961,
                  "self-harm/intent": 1.646940972932498e-6,
                  "self-harm/instructions": 1.1198755256458526e-9,
                  "harassment/threatening": 0.5694745779037476,
                  "violence": 0.9971134662628174
                }
              }
            ]
          }
          
          """,
      },
      #{
        title: "Image and text",
        request: #{
          curl: """
            curl https://api.openai.com/v1/moderations \\
              -X POST \\
              -H "Content-Type: application/json" \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -d '{
                "model": "omni-moderation-latest",
                "input": [
                  { "type": "text", "text": "...text to classify goes here..." },
                  {
                    "type": "image_url",
                    "image_url": {
                      "url": "https://example.com/image.png"
                    }
                  }
                ]
              }'
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            moderation = client.moderations.create(
                input="I want to kill them.",
            )
            print(moderation.id)
            """,
          javascript: """
            import OpenAI from "openai";
            const openai = new OpenAI();
            
            const moderation = await openai.moderations.create({
                model: "omni-moderation-latest",
                input: [
                    { type: "text", text: "...text to classify goes here..." },
                    {
                        type: "image_url",
                        image_url: {
                            url: "https://example.com/image.png"
                            // can also use base64 encoded image URLs
                            // url: "data:image/jpeg;base64,abcdefg..."
                        }
                    }
                ],
            });
            
            console.log(moderation);
            
            """,
          `node.js`: """
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const moderation = await client.moderations.create({ input: 'I want to kill them.' });
            
            console.log(moderation.id);
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
            	moderation, err := client.Moderations.New(context.TODO(), openai.ModerationNewParams{
            		Input: openai.ModerationNewParamsInputUnion{
            			OfString: openai.String("I want to kill them."),
            		},
            	})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", moderation.ID)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.moderations.ModerationCreateParams;
            import com.openai.models.moderations.ModerationCreateResponse;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    ModerationCreateParams params = ModerationCreateParams.builder()
                        .input("I want to kill them.")
                        .build();
                    ModerationCreateResponse moderation = client.moderations().create(params);
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            moderation = openai.moderations.create(input: "I want to kill them.")
            
            puts(moderation)
            """,
        },
        response: """
          {
            "id": "modr-0d9740456c391e43c445bf0f010940c7",
            "model": "omni-moderation-latest",
            "results": [
              {
                "flagged": true,
                "categories": {
                  "harassment": true,
                  "harassment/threatening": true,
                  "sexual": false,
                  "hate": false,
                  "hate/threatening": false,
                  "illicit": false,
                  "illicit/violent": false,
                  "self-harm/intent": false,
                  "self-harm/instructions": false,
                  "self-harm": false,
                  "sexual/minors": false,
                  "violence": true,
                  "violence/graphic": true
                },
                "category_scores": {
                  "harassment": 0.8189693396524255,
                  "harassment/threatening": 0.804985420696006,
                  "sexual": 1.573112165348997e-6,
                  "hate": 0.007562942636942845,
                  "hate/threatening": 0.004208854591835476,
                  "illicit": 0.030535955153511665,
                  "illicit/violent": 0.008925306722380033,
                  "self-harm/intent": 0.00023023930975076432,
                  "self-harm/instructions": 0.0002293869201073356,
                  "self-harm": 0.012598046106750154,
                  "sexual/minors": 2.212566909570261e-8,
                  "violence": 0.9999992735124786,
                  "violence/graphic": 0.843064871157054
                },
                "category_applied_input_types": {
                  "harassment": [
                    "text"
                  ],
                  "harassment/threatening": [
                    "text"
                  ],
                  "sexual": [
                    "text",
                    "image"
                  ],
                  "hate": [
                    "text"
                  ],
                  "hate/threatening": [
                    "text"
                  ],
                  "illicit": [
                    "text"
                  ],
                  "illicit/violent": [
                    "text"
                  ],
                  "self-harm/intent": [
                    "text",
                    "image"
                  ],
                  "self-harm/instructions": [
                    "text",
                    "image"
                  ],
                  "self-harm": [
                    "text",
                    "image"
                  ],
                  "sexual/minors": [
                    "text"
                  ],
                  "violence": [
                    "text",
                    "image"
                  ],
                  "violence/graphic": [
                    "text",
                    "image"
                  ]
                }
              }
            ]
          }
          
          """,
      }
    ],
  }
);
