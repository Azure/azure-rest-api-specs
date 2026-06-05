import "./routes.tsp";
import "@typespec/openapi";
using TypeSpec.OpenAPI;
namespace Azure.AI.Projects;
@@extension(
  Azure.AI.Projects.Chat.listChatCompletions,
  "x-oaiMeta",
  #{
    name: "List Chat Completions",
    group: "chat",
    path: "list",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/chat/completions \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "Content-Type: application/json"
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          page = client.chat.completions.list()
          page = page.data[0]
          print(page.id)
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          // Automatically fetches more pages as needed.
          for await (const chatCompletion of client.chat.completions.list()) {
            console.log(chatCompletion.id);
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
          	page, err := client.Chat.Completions.List(context.TODO(), openai.ChatCompletionListParams{})
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
          import com.openai.models.chat.completions.ChatCompletionListPage;
          import com.openai.models.chat.completions.ChatCompletionListParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  ChatCompletionListPage page = client.chat().completions().list();
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          page = openai.chat.completions.list
          
          puts(page)
          """,
      },
      response: """
        {
          "object": "list",
          "data": [
            {
              "object": "chat.completion",
              "id": "chatcmpl-AyPNinnUqUDYo9SAdA52NobMflmj2",
              "model": "gpt-5.4",
              "created": 1738960610,
              "request_id": "req_ded8ab984ec4bf840f37566c1011c417",
              "tool_choice": null,
              "usage": {
                "total_tokens": 31,
                "completion_tokens": 18,
                "prompt_tokens": 13
              },
              "seed": 4944116822809979520,
              "top_p": 1.0,
              "temperature": 1.0,
              "presence_penalty": 0.0,
              "frequency_penalty": 0.0,
              "system_fingerprint": "fp_50cad350e4",
              "input_user": null,
              "service_tier": "default",
              "tools": null,
              "metadata": {},
              "choices": [
                {
                  "index": 0,
                  "message": {
                    "content": "Mind of circuits hum,
        Learning patterns in silence—
        Future's quiet spark.",
                    "role": "assistant",
                    "tool_calls": null,
                    "function_call": null
                  },
                  "finish_reason": "stop",
                  "logprobs": null
                }
              ],
              "response_format": null
            }
          ],
          "first_id": "chatcmpl-AyPNinnUqUDYo9SAdA52NobMflmj2",
          "last_id": "chatcmpl-AyPNinnUqUDYo9SAdA52NobMflmj2",
          "has_more": false
        }
        
        """,
    },
  }
);

@@extension(Azure.AI.Projects.Chat.listChatCompletions, "x-ms-list", true);

@@extension(
  Azure.AI.Projects.Chat.createChatCompletion,
  "x-oaiMeta",
  #{
    name: "Create chat completion",
    group: "chat",
    path: "create",
    examples: #[
      #{
        title: "Default",
        request: #{
          curl: """
            curl https://api.openai.com/v1/chat/completions \\
              -H "Content-Type: application/json" \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -d '{
                "model": "VAR_chat_model_id",
                "messages": [
                  {
                    "role": "developer",
                    "content": "You are a helpful assistant."
                  },
                  {
                    "role": "user",
                    "content": "Hello!"
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
            for completion in client.chat.completions.create(
                messages=[{
                    "content": "string",
                    "role": "developer",
                }],
                model="gpt-5.4",
            ):
              print(completion)
            """,
          javascript: """
            import OpenAI from "openai";
            
            const openai = new OpenAI();
            
            async function main() {
              const completion = await openai.chat.completions.create({
                messages: [{ role: "developer", content: "You are a helpful assistant." }],
                model: "VAR_chat_model_id",
                store: true,
              });
            
              console.log(completion.choices[0]);
            }
            
            main();
            
            """,
          csharp: """
            using System;
            using System.Collections.Generic;
            
            using OpenAI.Chat;
            
            ChatClient client = new(
                model: "gpt-5.4",
                apiKey: Environment.GetEnvironmentVariable("OPENAI_API_KEY")
            );
            
            List<ChatMessage> messages =
            [
                new SystemChatMessage("You are a helpful assistant."),
                new UserChatMessage("Hello!")
            ];
            
            ChatCompletion completion = client.CompleteChat(messages);
            
            Console.WriteLine(completion.Content[0].Text);
            
            """,
          `node.js`: """
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const chatCompletion = await client.chat.completions.create({
              messages: [{ content: 'string', role: 'developer' }],
              model: 'gpt-5.4',
            });
            
            console.log(chatCompletion);
            """,
          go: """
            package main
            
            import (
            	"context"
            	"fmt"
            
            	"github.com/openai/openai-go"
            	"github.com/openai/openai-go/option"
            	"github.com/openai/openai-go/shared"
            )
            
            func main() {
            	client := openai.NewClient(
            		option.WithAPIKey("My API Key"),
            	)
            	chatCompletion, err := client.Chat.Completions.New(context.TODO(), openai.ChatCompletionNewParams{
            		Messages: []openai.ChatCompletionMessageParamUnion{{
            			OfDeveloper: &openai.ChatCompletionDeveloperMessageParam{
            				Content: openai.ChatCompletionDeveloperMessageParamContentUnion{
            					OfString: openai.String("string"),
            				},
            			},
            		}},
            		Model: shared.ChatModelGPT5_4,
            	})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", chatCompletion)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.ChatModel;
            import com.openai.models.chat.completions.ChatCompletion;
            import com.openai.models.chat.completions.ChatCompletionCreateParams;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    ChatCompletionCreateParams params = ChatCompletionCreateParams.builder()
                        .addDeveloperMessage("string")
                        .model(ChatModel.GPT_5_4)
                        .build();
                    ChatCompletion chatCompletion = client.chat().completions().create(params);
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            chat_completion = openai.chat.completions.create(messages: [{content: "string", role: :developer}], model: :"gpt-5.4")
            
            puts(chat_completion)
            """,
        },
        response: """
          {
            "id": "chatcmpl-B9MBs8CjcvOU2jLn4n570S5qMJKcT",
            "object": "chat.completion",
            "created": 1741569952,
            "model": "gpt-5.4",
            "choices": [
              {
                "index": 0,
                "message": {
                  "role": "assistant",
                  "content": "Hello! How can I assist you today?",
                  "refusal": null,
                  "annotations": []
                },
                "logprobs": null,
                "finish_reason": "stop"
              }
            ],
            "usage": {
              "prompt_tokens": 19,
              "completion_tokens": 10,
              "total_tokens": 29,
              "prompt_tokens_details": {
                "cached_tokens": 0,
                "audio_tokens": 0
              },
              "completion_tokens_details": {
                "reasoning_tokens": 0,
                "audio_tokens": 0,
                "accepted_prediction_tokens": 0,
                "rejected_prediction_tokens": 0
              }
            },
            "service_tier": "default"
          }
          
          """,
      },
      #{
        title: "Image input",
        request: #{
          curl: """
            curl https://api.openai.com/v1/chat/completions \\
              -H "Content-Type: application/json" \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -d '{
                "model": "gpt-5.4",
                "messages": [
                  {
                    "role": "user",
                    "content": [
                      {
                        "type": "text",
                        "text": "What is in this image?"
                      },
                      {
                        "type": "image_url",
                        "image_url": {
                          "url": "https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Gfp-wisconsin-madison-the-nature-boardwalk.jpg/2560px-Gfp-wisconsin-madison-the-nature-boardwalk.jpg"
                        }
                      }
                    ]
                  }
                ],
                "max_tokens": 300
              }'
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            for completion in client.chat.completions.create(
                messages=[{
                    "content": "string",
                    "role": "developer",
                }],
                model="gpt-5.4",
            ):
              print(completion)
            """,
          javascript: """
            import OpenAI from "openai";
            
            const openai = new OpenAI();
            
            async function main() {
              const response = await openai.chat.completions.create({
                model: "gpt-5.4",
                messages: [
                  {
                    role: "user",
                    content: [
                      { type: "text", text: "What's in this image?" },
                      {
                        type: "image_url",
                        image_url: {
                          "url": "https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Gfp-wisconsin-madison-the-nature-boardwalk.jpg/2560px-Gfp-wisconsin-madison-the-nature-boardwalk.jpg",
                        },
                      }
                    ],
                  },
                ],
              });
              console.log(response.choices[0]);
            }
            main();
            
            """,
          csharp: """
            using System;
            using System.Collections.Generic;
            
            using OpenAI.Chat;
            
            ChatClient client = new(
                model: "gpt-5.4",
                apiKey: Environment.GetEnvironmentVariable("OPENAI_API_KEY")
            );
            
            List<ChatMessage> messages =
            [
                new UserChatMessage(
                [
                    ChatMessageContentPart.CreateTextPart("What's in this image?"),
                    ChatMessageContentPart.CreateImagePart(new Uri("https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Gfp-wisconsin-madison-the-nature-boardwalk.jpg/2560px-Gfp-wisconsin-madison-the-nature-boardwalk.jpg"))
                ])
            ];
            
            ChatCompletion completion = client.CompleteChat(messages);
            
            Console.WriteLine(completion.Content[0].Text);
            
            """,
          `node.js`: """
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const chatCompletion = await client.chat.completions.create({
              messages: [{ content: 'string', role: 'developer' }],
              model: 'gpt-5.4',
            });
            
            console.log(chatCompletion);
            """,
          go: """
            package main
            
            import (
            	"context"
            	"fmt"
            
            	"github.com/openai/openai-go"
            	"github.com/openai/openai-go/option"
            	"github.com/openai/openai-go/shared"
            )
            
            func main() {
            	client := openai.NewClient(
            		option.WithAPIKey("My API Key"),
            	)
            	chatCompletion, err := client.Chat.Completions.New(context.TODO(), openai.ChatCompletionNewParams{
            		Messages: []openai.ChatCompletionMessageParamUnion{{
            			OfDeveloper: &openai.ChatCompletionDeveloperMessageParam{
            				Content: openai.ChatCompletionDeveloperMessageParamContentUnion{
            					OfString: openai.String("string"),
            				},
            			},
            		}},
            		Model: shared.ChatModelGPT5_4,
            	})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", chatCompletion)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.ChatModel;
            import com.openai.models.chat.completions.ChatCompletion;
            import com.openai.models.chat.completions.ChatCompletionCreateParams;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    ChatCompletionCreateParams params = ChatCompletionCreateParams.builder()
                        .addDeveloperMessage("string")
                        .model(ChatModel.GPT_5_4)
                        .build();
                    ChatCompletion chatCompletion = client.chat().completions().create(params);
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            chat_completion = openai.chat.completions.create(messages: [{content: "string", role: :developer}], model: :"gpt-5.4")
            
            puts(chat_completion)
            """,
        },
        response: """
          {
            "id": "chatcmpl-B9MHDbslfkBeAs8l4bebGdFOJ6PeG",
            "object": "chat.completion",
            "created": 1741570283,
            "model": "gpt-5.4",
            "choices": [
              {
                "index": 0,
                "message": {
                  "role": "assistant",
                  "content": "The image shows a wooden boardwalk path running through a lush green field or meadow. The sky is bright blue with some scattered clouds, giving the scene a serene and peaceful atmosphere. Trees and shrubs are visible in the background.",
                  "refusal": null,
                  "annotations": []
                },
                "logprobs": null,
                "finish_reason": "stop"
              }
            ],
            "usage": {
              "prompt_tokens": 1117,
              "completion_tokens": 46,
              "total_tokens": 1163,
              "prompt_tokens_details": {
                "cached_tokens": 0,
                "audio_tokens": 0
              },
              "completion_tokens_details": {
                "reasoning_tokens": 0,
                "audio_tokens": 0,
                "accepted_prediction_tokens": 0,
                "rejected_prediction_tokens": 0
              }
            },
            "service_tier": "default"
          }
          
          """,
      },
      #{
        title: "Streaming",
        request: #{
          curl: """
            curl https://api.openai.com/v1/chat/completions \\
              -H "Content-Type: application/json" \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -d '{
                "model": "VAR_chat_model_id",
                "messages": [
                  {
                    "role": "developer",
                    "content": "You are a helpful assistant."
                  },
                  {
                    "role": "user",
                    "content": "Hello!"
                  }
                ],
                "stream": true
              }'
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            for completion in client.chat.completions.create(
                messages=[{
                    "content": "string",
                    "role": "developer",
                }],
                model="gpt-5.4",
            ):
              print(completion)
            """,
          javascript: """
            import OpenAI from "openai";
            
            const openai = new OpenAI();
            
            async function main() {
              const completion = await openai.chat.completions.create({
                model: "VAR_chat_model_id",
                messages: [
                  {"role": "developer", "content": "You are a helpful assistant."},
                  {"role": "user", "content": "Hello!"}
                ],
                stream: true,
              });
            
              for await (const chunk of completion) {
                console.log(chunk.choices[0].delta.content);
              }
            }
            
            main();
            
            """,
          csharp: """
            using System;
            using System.ClientModel;
            using System.Collections.Generic;
            using System.Threading.Tasks;
            
            using OpenAI.Chat;
            
            ChatClient client = new(
                model: "gpt-5.4",
                apiKey: Environment.GetEnvironmentVariable("OPENAI_API_KEY")
            );
            
            List<ChatMessage> messages =
            [
                new SystemChatMessage("You are a helpful assistant."),
                new UserChatMessage("Hello!")
            ];
            
            AsyncCollectionResult<StreamingChatCompletionUpdate> completionUpdates = client.CompleteChatStreamingAsync(messages);
            
            await foreach (StreamingChatCompletionUpdate completionUpdate in completionUpdates)
            {
                if (completionUpdate.ContentUpdate.Count > 0)
                {
                    Console.Write(completionUpdate.ContentUpdate[0].Text);
                }
            }
            
            """,
          `node.js`: """
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const chatCompletion = await client.chat.completions.create({
              messages: [{ content: 'string', role: 'developer' }],
              model: 'gpt-5.4',
            });
            
            console.log(chatCompletion);
            """,
          go: """
            package main
            
            import (
            	"context"
            	"fmt"
            
            	"github.com/openai/openai-go"
            	"github.com/openai/openai-go/option"
            	"github.com/openai/openai-go/shared"
            )
            
            func main() {
            	client := openai.NewClient(
            		option.WithAPIKey("My API Key"),
            	)
            	chatCompletion, err := client.Chat.Completions.New(context.TODO(), openai.ChatCompletionNewParams{
            		Messages: []openai.ChatCompletionMessageParamUnion{{
            			OfDeveloper: &openai.ChatCompletionDeveloperMessageParam{
            				Content: openai.ChatCompletionDeveloperMessageParamContentUnion{
            					OfString: openai.String("string"),
            				},
            			},
            		}},
            		Model: shared.ChatModelGPT5_4,
            	})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", chatCompletion)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.ChatModel;
            import com.openai.models.chat.completions.ChatCompletion;
            import com.openai.models.chat.completions.ChatCompletionCreateParams;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    ChatCompletionCreateParams params = ChatCompletionCreateParams.builder()
                        .addDeveloperMessage("string")
                        .model(ChatModel.GPT_5_4)
                        .build();
                    ChatCompletion chatCompletion = client.chat().completions().create(params);
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            chat_completion = openai.chat.completions.create(messages: [{content: "string", role: :developer}], model: :"gpt-5.4")
            
            puts(chat_completion)
            """,
        },
        response: """
          {"id":"chatcmpl-123","object":"chat.completion.chunk","created":1694268190,"model":"gpt-4o-mini", "system_fingerprint": "fp_44709d6fcb", "choices":[{"index":0,"delta":{"role":"assistant","content":""},"logprobs":null,"finish_reason":null}]}
          
          {"id":"chatcmpl-123","object":"chat.completion.chunk","created":1694268190,"model":"gpt-4o-mini", "system_fingerprint": "fp_44709d6fcb", "choices":[{"index":0,"delta":{"content":"Hello"},"logprobs":null,"finish_reason":null}]}
          
          ....
          
          {"id":"chatcmpl-123","object":"chat.completion.chunk","created":1694268190,"model":"gpt-4o-mini", "system_fingerprint": "fp_44709d6fcb", "choices":[{"index":0,"delta":{},"logprobs":null,"finish_reason":"stop"}]}
          
          """,
      },
      #{
        title: "Functions",
        request: #{
          curl: """
            curl https://api.openai.com/v1/chat/completions \\
            -H "Content-Type: application/json" \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -d '{
              "model": "gpt-5.4",
              "messages": [
                {
                  "role": "user",
                  "content": "What is the weather like in Boston today?"
                }
              ],
              "tools": [
                {
                  "type": "function",
                  "function": {
                    "name": "get_current_weather",
                    "description": "Get the current weather in a given location",
                    "parameters": {
                      "type": "object",
                      "properties": {
                        "location": {
                          "type": "string",
                          "description": "The city and state, e.g. San Francisco, CA"
                        },
                        "unit": {
                          "type": "string",
                          "enum": ["celsius", "fahrenheit"]
                        }
                      },
                      "required": ["location"]
                    }
                  }
                }
              ],
              "tool_choice": "auto"
            }'
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            for completion in client.chat.completions.create(
                messages=[{
                    "content": "string",
                    "role": "developer",
                }],
                model="gpt-5.4",
            ):
              print(completion)
            """,
          javascript: """
            import OpenAI from "openai";
            
            const openai = new OpenAI();
            
            async function main() {
              const messages = [{"role": "user", "content": "What's the weather like in Boston today?"}];
              const tools = [
                  {
                    "type": "function",
                    "function": {
                      "name": "get_current_weather",
                      "description": "Get the current weather in a given location",
                      "parameters": {
                        "type": "object",
                        "properties": {
                          "location": {
                            "type": "string",
                            "description": "The city and state, e.g. San Francisco, CA",
                          },
                          "unit": {"type": "string", "enum": ["celsius", "fahrenheit"]},
                        },
                        "required": ["location"],
                      },
                    }
                  }
              ];
            
              const response = await openai.chat.completions.create({
                model: "gpt-5.4",
                messages: messages,
                tools: tools,
                tool_choice: "auto",
              });
            
              console.log(response);
            }
            
            main();
            
            """,
          csharp: """
            using System;
            using System.Collections.Generic;
            
            using OpenAI.Chat;
            
            ChatClient client = new(
                model: "gpt-5.4",
                apiKey: Environment.GetEnvironmentVariable("OPENAI_API_KEY")
            );
            
            ChatTool getCurrentWeatherTool = ChatTool.CreateFunctionTool(
                functionName: "get_current_weather",
                functionDescription: "Get the current weather in a given location",
                functionParameters: BinaryData.FromString(\"""
                    {
                        "type": "object",
                        "properties": {
                            "location": {
                                "type": "string",
                                "description": "The city and state, e.g. San Francisco, CA"
                            },
                            "unit": {
                                "type": "string",
                                "enum": [ "celsius", "fahrenheit" ]
                            }
                        },
                        "required": [ "location" ]
                    }
                \""")
            );
            
            List<ChatMessage> messages =
            [
                new UserChatMessage("What's the weather like in Boston today?"),
            ];
            
            ChatCompletionOptions options = new()
            {
                Tools =
                {
                    getCurrentWeatherTool
                },
                ToolChoice = ChatToolChoice.CreateAutoChoice(),
            };
            
            ChatCompletion completion = client.CompleteChat(messages, options);
            
            """,
          `node.js`: """
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const chatCompletion = await client.chat.completions.create({
              messages: [{ content: 'string', role: 'developer' }],
              model: 'gpt-5.4',
            });
            
            console.log(chatCompletion);
            """,
          go: """
            package main
            
            import (
            	"context"
            	"fmt"
            
            	"github.com/openai/openai-go"
            	"github.com/openai/openai-go/option"
            	"github.com/openai/openai-go/shared"
            )
            
            func main() {
            	client := openai.NewClient(
            		option.WithAPIKey("My API Key"),
            	)
            	chatCompletion, err := client.Chat.Completions.New(context.TODO(), openai.ChatCompletionNewParams{
            		Messages: []openai.ChatCompletionMessageParamUnion{{
            			OfDeveloper: &openai.ChatCompletionDeveloperMessageParam{
            				Content: openai.ChatCompletionDeveloperMessageParamContentUnion{
            					OfString: openai.String("string"),
            				},
            			},
            		}},
            		Model: shared.ChatModelGPT5_4,
            	})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", chatCompletion)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.ChatModel;
            import com.openai.models.chat.completions.ChatCompletion;
            import com.openai.models.chat.completions.ChatCompletionCreateParams;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    ChatCompletionCreateParams params = ChatCompletionCreateParams.builder()
                        .addDeveloperMessage("string")
                        .model(ChatModel.GPT_5_4)
                        .build();
                    ChatCompletion chatCompletion = client.chat().completions().create(params);
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            chat_completion = openai.chat.completions.create(messages: [{content: "string", role: :developer}], model: :"gpt-5.4")
            
            puts(chat_completion)
            """,
        },
        response: """
          {
            "id": "chatcmpl-abc123",
            "object": "chat.completion",
            "created": 1699896916,
            "model": "gpt-4o-mini",
            "choices": [
              {
                "index": 0,
                "message": {
                  "role": "assistant",
                  "content": null,
                  "tool_calls": [
                    {
                      "id": "call_abc123",
                      "type": "function",
                      "function": {
                        "name": "get_current_weather",
                        "arguments": "{
          "location": "Boston, MA"
          }"
                      }
                    }
                  ]
                },
                "logprobs": null,
                "finish_reason": "tool_calls"
              }
            ],
            "usage": {
              "prompt_tokens": 82,
              "completion_tokens": 17,
              "total_tokens": 99,
              "completion_tokens_details": {
                "reasoning_tokens": 0,
                "accepted_prediction_tokens": 0,
                "rejected_prediction_tokens": 0
              }
            }
          }
          
          """,
      },
      #{
        title: "Logprobs",
        request: #{
          curl: """
            curl https://api.openai.com/v1/chat/completions \\
              -H "Content-Type: application/json" \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -d '{
                "model": "VAR_chat_model_id",
                "messages": [
                  {
                    "role": "user",
                    "content": "Hello!"
                  }
                ],
                "logprobs": true,
                "top_logprobs": 2
              }'
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            for completion in client.chat.completions.create(
                messages=[{
                    "content": "string",
                    "role": "developer",
                }],
                model="gpt-5.4",
            ):
              print(completion)
            """,
          javascript: """
            import OpenAI from "openai";
            
            const openai = new OpenAI();
            
            async function main() {
              const completion = await openai.chat.completions.create({
                messages: [{ role: "user", content: "Hello!" }],
                model: "VAR_chat_model_id",
                logprobs: true,
                top_logprobs: 2,
              });
            
              console.log(completion.choices[0]);
            }
            
            main();
            
            """,
          csharp: """
            using System;
            using System.Collections.Generic;
            
            using OpenAI.Chat;
            
            ChatClient client = new(
                model: "gpt-5.4",
                apiKey: Environment.GetEnvironmentVariable("OPENAI_API_KEY")
            );
            
            List<ChatMessage> messages =
            [
                new UserChatMessage("Hello!")
            ];
            
            ChatCompletionOptions options = new()
            {
                IncludeLogProbabilities = true,
                TopLogProbabilityCount = 2
            };
            
            ChatCompletion completion = client.CompleteChat(messages, options);
            
            Console.WriteLine(completion.Content[0].Text);
            
            """,
          `node.js`: """
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const chatCompletion = await client.chat.completions.create({
              messages: [{ content: 'string', role: 'developer' }],
              model: 'gpt-5.4',
            });
            
            console.log(chatCompletion);
            """,
          go: """
            package main
            
            import (
            	"context"
            	"fmt"
            
            	"github.com/openai/openai-go"
            	"github.com/openai/openai-go/option"
            	"github.com/openai/openai-go/shared"
            )
            
            func main() {
            	client := openai.NewClient(
            		option.WithAPIKey("My API Key"),
            	)
            	chatCompletion, err := client.Chat.Completions.New(context.TODO(), openai.ChatCompletionNewParams{
            		Messages: []openai.ChatCompletionMessageParamUnion{{
            			OfDeveloper: &openai.ChatCompletionDeveloperMessageParam{
            				Content: openai.ChatCompletionDeveloperMessageParamContentUnion{
            					OfString: openai.String("string"),
            				},
            			},
            		}},
            		Model: shared.ChatModelGPT5_4,
            	})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", chatCompletion)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.ChatModel;
            import com.openai.models.chat.completions.ChatCompletion;
            import com.openai.models.chat.completions.ChatCompletionCreateParams;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    ChatCompletionCreateParams params = ChatCompletionCreateParams.builder()
                        .addDeveloperMessage("string")
                        .model(ChatModel.GPT_5_4)
                        .build();
                    ChatCompletion chatCompletion = client.chat().completions().create(params);
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            chat_completion = openai.chat.completions.create(messages: [{content: "string", role: :developer}], model: :"gpt-5.4")
            
            puts(chat_completion)
            """,
        },
        response: """
          {
            "id": "chatcmpl-123",
            "object": "chat.completion",
            "created": 1702685778,
            "model": "gpt-4o-mini",
            "choices": [
              {
                "index": 0,
                "message": {
                  "role": "assistant",
                  "content": "Hello! How can I assist you today?"
                },
                "logprobs": {
                  "content": [
                    {
                      "token": "Hello",
                      "logprob": -0.31725305,
                      "bytes": [72, 101, 108, 108, 111],
                      "top_logprobs": [
                        {
                          "token": "Hello",
                          "logprob": -0.31725305,
                          "bytes": [72, 101, 108, 108, 111]
                        },
                        {
                          "token": "Hi",
                          "logprob": -1.3190403,
                          "bytes": [72, 105]
                        }
                      ]
                    },
                    {
                      "token": "!",
                      "logprob": -0.02380986,
                      "bytes": [
                        33
                      ],
                      "top_logprobs": [
                        {
                          "token": "!",
                          "logprob": -0.02380986,
                          "bytes": [33]
                        },
                        {
                          "token": " there",
                          "logprob": -3.787621,
                          "bytes": [32, 116, 104, 101, 114, 101]
                        }
                      ]
                    },
                    {
                      "token": " How",
                      "logprob": -0.000054669687,
                      "bytes": [32, 72, 111, 119],
                      "top_logprobs": [
                        {
                          "token": " How",
                          "logprob": -0.000054669687,
                          "bytes": [32, 72, 111, 119]
                        },
                        {
                          "token": "<|end|>",
                          "logprob": -10.953937,
                          "bytes": null
                        }
                      ]
                    },
                    {
                      "token": " can",
                      "logprob": -0.015801601,
                      "bytes": [32, 99, 97, 110],
                      "top_logprobs": [
                        {
                          "token": " can",
                          "logprob": -0.015801601,
                          "bytes": [32, 99, 97, 110]
                        },
                        {
                          "token": " may",
                          "logprob": -4.161023,
                          "bytes": [32, 109, 97, 121]
                        }
                      ]
                    },
                    {
                      "token": " I",
                      "logprob": -3.7697225e-6,
                      "bytes": [
                        32,
                        73
                      ],
                      "top_logprobs": [
                        {
                          "token": " I",
                          "logprob": -3.7697225e-6,
                          "bytes": [32, 73]
                        },
                        {
                          "token": " assist",
                          "logprob": -13.596657,
                          "bytes": [32, 97, 115, 115, 105, 115, 116]
                        }
                      ]
                    },
                    {
                      "token": " assist",
                      "logprob": -0.04571125,
                      "bytes": [32, 97, 115, 115, 105, 115, 116],
                      "top_logprobs": [
                        {
                          "token": " assist",
                          "logprob": -0.04571125,
                          "bytes": [32, 97, 115, 115, 105, 115, 116]
                        },
                        {
                          "token": " help",
                          "logprob": -3.1089056,
                          "bytes": [32, 104, 101, 108, 112]
                        }
                      ]
                    },
                    {
                      "token": " you",
                      "logprob": -5.4385737e-6,
                      "bytes": [32, 121, 111, 117],
                      "top_logprobs": [
                        {
                          "token": " you",
                          "logprob": -5.4385737e-6,
                          "bytes": [32, 121, 111, 117]
                        },
                        {
                          "token": " today",
                          "logprob": -12.807695,
                          "bytes": [32, 116, 111, 100, 97, 121]
                        }
                      ]
                    },
                    {
                      "token": " today",
                      "logprob": -0.0040071653,
                      "bytes": [32, 116, 111, 100, 97, 121],
                      "top_logprobs": [
                        {
                          "token": " today",
                          "logprob": -0.0040071653,
                          "bytes": [32, 116, 111, 100, 97, 121]
                        },
                        {
                          "token": "?",
                          "logprob": -5.5247097,
                          "bytes": [63]
                        }
                      ]
                    },
                    {
                      "token": "?",
                      "logprob": -0.0008108172,
                      "bytes": [63],
                      "top_logprobs": [
                        {
                          "token": "?",
                          "logprob": -0.0008108172,
                          "bytes": [63]
                        },
                        {
                          "token": "?
          ",
                          "logprob": -7.184561,
                          "bytes": [63, 10]
                        }
                      ]
                    }
                  ]
                },
                "finish_reason": "stop"
              }
            ],
            "usage": {
              "prompt_tokens": 9,
              "completion_tokens": 9,
              "total_tokens": 18,
              "completion_tokens_details": {
                "reasoning_tokens": 0,
                "accepted_prediction_tokens": 0,
                "rejected_prediction_tokens": 0
              }
            },
            "system_fingerprint": null
          }
          
          """,
      }
    ],
  }
);

@@extension(
  Azure.AI.Projects.Chat.deleteChatCompletion,
  "x-oaiMeta",
  #{
    name: "Delete chat completion",
    group: "chat",
    examples: #{
      request: #{
        curl: """
          curl -X DELETE https://api.openai.com/v1/chat/completions/chat_abc123 \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "Content-Type: application/json"
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          chat_completion_deleted = client.chat.completions.delete(
              "completion_id",
          )
          print(chat_completion_deleted.id)
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const chatCompletionDeleted = await client.chat.completions.delete('completion_id');
          
          console.log(chatCompletionDeleted.id);
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
          	chatCompletionDeleted, err := client.Chat.Completions.Delete(context.TODO(), "completion_id")
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", chatCompletionDeleted.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.chat.completions.ChatCompletionDeleteParams;
          import com.openai.models.chat.completions.ChatCompletionDeleted;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  ChatCompletionDeleted chatCompletionDeleted = client.chat().completions().delete("completion_id");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          chat_completion_deleted = openai.chat.completions.delete("completion_id")
          
          puts(chat_completion_deleted)
          """,
      },
      response: """
        {
          "object": "chat.completion.deleted",
          "id": "chatcmpl-AyPNinnUqUDYo9SAdA52NobMflmj2",
          "deleted": true
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Chat.getChatCompletion,
  "x-oaiMeta",
  #{
    name: "Get chat completion",
    group: "chat",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/chat/completions/chatcmpl-abc123 \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "Content-Type: application/json"
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          chat_completion = client.chat.completions.retrieve(
              "completion_id",
          )
          print(chat_completion.id)
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const chatCompletion = await client.chat.completions.retrieve('completion_id');
          
          console.log(chatCompletion.id);
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
          	chatCompletion, err := client.Chat.Completions.Get(context.TODO(), "completion_id")
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", chatCompletion.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.chat.completions.ChatCompletion;
          import com.openai.models.chat.completions.ChatCompletionRetrieveParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  ChatCompletion chatCompletion = client.chat().completions().retrieve("completion_id");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          chat_completion = openai.chat.completions.retrieve("completion_id")
          
          puts(chat_completion)
          """,
      },
      response: """
        {
          "object": "chat.completion",
          "id": "chatcmpl-abc123",
          "model": "gpt-4o-2024-08-06",
          "created": 1738960610,
          "request_id": "req_ded8ab984ec4bf840f37566c1011c417",
          "tool_choice": null,
          "usage": {
            "total_tokens": 31,
            "completion_tokens": 18,
            "prompt_tokens": 13
          },
          "seed": 4944116822809979520,
          "top_p": 1.0,
          "temperature": 1.0,
          "presence_penalty": 0.0,
          "frequency_penalty": 0.0,
          "system_fingerprint": "fp_50cad350e4",
          "input_user": null,
          "service_tier": "default",
          "tools": null,
          "metadata": {},
          "choices": [
            {
              "index": 0,
              "message": {
                "content": "Mind of circuits hum,
        Learning patterns in silence—
        Future's quiet spark.",
                "role": "assistant",
                "tool_calls": null,
                "function_call": null
              },
              "finish_reason": "stop",
              "logprobs": null
            }
          ],
          "response_format": null
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Chat.updateChatCompletion,
  "x-oaiMeta",
  #{
    name: "Update chat completion",
    group: "chat",
    examples: #{
      request: #{
        curl: """
          curl -X POST https://api.openai.com/v1/chat/completions/chat_abc123 \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "Content-Type: application/json" \\
            -d '{"metadata": {"foo": "bar"}}'
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          chat_completion = client.chat.completions.update(
              completion_id="completion_id",
              metadata={
                  "foo": "string"
              },
          )
          print(chat_completion.id)
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const chatCompletion = await client.chat.completions.update('completion_id', {
            metadata: { foo: 'string' },
          });
          
          console.log(chatCompletion.id);
          """,
        go: """
          package main
          
          import (
          	"context"
          	"fmt"
          
          	"github.com/openai/openai-go"
          	"github.com/openai/openai-go/option"
          	"github.com/openai/openai-go/shared"
          )
          
          func main() {
          	client := openai.NewClient(
          		option.WithAPIKey("My API Key"),
          	)
          	chatCompletion, err := client.Chat.Completions.Update(
          		context.TODO(),
          		"completion_id",
          		openai.ChatCompletionUpdateParams{
          			Metadata: shared.Metadata{
          				"foo": "string",
          			},
          		},
          	)
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", chatCompletion.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.core.JsonValue;
          import com.openai.models.chat.completions.ChatCompletion;
          import com.openai.models.chat.completions.ChatCompletionUpdateParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  ChatCompletionUpdateParams params = ChatCompletionUpdateParams.builder()
                      .completionId("completion_id")
                      .metadata(ChatCompletionUpdateParams.Metadata.builder()
                          .putAdditionalProperty("foo", JsonValue.from("string"))
                          .build())
                      .build();
                  ChatCompletion chatCompletion = client.chat().completions().update(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          chat_completion = openai.chat.completions.update("completion_id", metadata: {foo: "string"})
          
          puts(chat_completion)
          """,
      },
      response: """
        {
          "object": "chat.completion",
          "id": "chatcmpl-AyPNinnUqUDYo9SAdA52NobMflmj2",
          "model": "gpt-4o-2024-08-06",
          "created": 1738960610,
          "request_id": "req_ded8ab984ec4bf840f37566c1011c417",
          "tool_choice": null,
          "usage": {
            "total_tokens": 31,
            "completion_tokens": 18,
            "prompt_tokens": 13
          },
          "seed": 4944116822809979520,
          "top_p": 1.0,
          "temperature": 1.0,
          "presence_penalty": 0.0,
          "frequency_penalty": 0.0,
          "system_fingerprint": "fp_50cad350e4",
          "input_user": null,
          "service_tier": "default",
          "tools": null,
          "metadata": {
            "foo": "bar"
          },
          "choices": [
            {
              "index": 0,
              "message": {
                "content": "Mind of circuits hum,
        Learning patterns in silence—
        Future's quiet spark.",
                "role": "assistant",
                "tool_calls": null,
                "function_call": null
              },
              "finish_reason": "stop",
              "logprobs": null
            }
          ],
          "response_format": null
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Chat.getChatCompletionMessages,
  "x-oaiMeta",
  #{
    name: "Get chat messages",
    group: "chat",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/chat/completions/chat_abc123/messages \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "Content-Type: application/json"
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          page = client.chat.completions.messages.list(
              completion_id="completion_id",
          )
          page = page.data[0]
          print(page)
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          // Automatically fetches more pages as needed.
          for await (const chatCompletionStoreMessage of client.chat.completions.messages.list(
            'completion_id',
          )) {
            console.log(chatCompletionStoreMessage);
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
          	page, err := client.Chat.Completions.Messages.List(
          		context.TODO(),
          		"completion_id",
          		openai.ChatCompletionMessageListParams{},
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
          import com.openai.models.chat.completions.messages.MessageListPage;
          import com.openai.models.chat.completions.messages.MessageListParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  MessageListPage page = client.chat().completions().messages().list("completion_id");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          page = openai.chat.completions.messages.list("completion_id")
          
          puts(page)
          """,
      },
      response: """
        {
          "object": "list",
          "data": [
            {
              "id": "chatcmpl-AyPNinnUqUDYo9SAdA52NobMflmj2-0",
              "role": "user",
              "content": "write a haiku about ai",
              "name": null,
              "content_parts": null
            }
          ],
          "first_id": "chatcmpl-AyPNinnUqUDYo9SAdA52NobMflmj2-0",
          "last_id": "chatcmpl-AyPNinnUqUDYo9SAdA52NobMflmj2-0",
          "has_more": false
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Chat.getChatCompletionMessages,
  "x-ms-list",
  true
);
