import "./routes.tsp";
import "@typespec/openapi";
using TypeSpec.OpenAPI;
namespace Azure.AI.Projects;
@@extension(
  Azure.AI.Projects.Responses.createResponse,
  "x-oaiMeta",
  #{
    name: "Create a model response",
    group: "responses",
    path: "create",
    examples: #[
      #{
        title: "Text input",
        request: #{
          curl: """
            curl https://api.openai.com/v1/responses \\
              -H "Content-Type: application/json" \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -d '{
                "model": "gpt-5.4",
                "input": "Tell me a three sentence bedtime story about a unicorn."
              }'
            
            """,
          javascript: """
            import OpenAI from "openai";
            
            const openai = new OpenAI();
            
            const response = await openai.responses.create({
                model: "gpt-5.4",
                input: "Tell me a three sentence bedtime story about a unicorn."
            });
            
            console.log(response);
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            for response in client.responses.create():
              print(response)
            """,
          csharp: """
            using System;
            using OpenAI.Responses;
            
            OpenAIResponseClient client = new(
                model: "gpt-5.4",
                apiKey: Environment.GetEnvironmentVariable("OPENAI_API_KEY")
            );
            
            OpenAIResponse response = client.CreateResponse("Tell me a three sentence bedtime story about a unicorn.");
            
            Console.WriteLine(response.GetOutputText());
            
            """,
          `node.js`: """
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const response = await client.responses.create();
            
            console.log(response.id);
            """,
          go: """
            package main
            
            import (
            	"context"
            	"fmt"
            
            	"github.com/openai/openai-go"
            	"github.com/openai/openai-go/option"
            	"github.com/openai/openai-go/responses"
            )
            
            func main() {
            	client := openai.NewClient(
            		option.WithAPIKey("My API Key"),
            	)
            	response, err := client.Responses.New(context.TODO(), responses.ResponseNewParams{})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", response.ID)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.responses.Response;
            import com.openai.models.responses.ResponseCreateParams;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    Response response = client.responses().create();
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            response = openai.responses.create
            
            puts(response)
            """,
        },
        response: """
          {
            "id": "resp_67ccd2bed1ec8190b14f964abc0542670bb6a6b452d3795b",
            "object": "response",
            "created_at": 1741476542,
            "status": "completed",
            "completed_at": 1741476543,
            "error": null,
            "incomplete_details": null,
            "instructions": null,
            "max_output_tokens": null,
            "model": "gpt-5.4",
            "output": [
              {
                "type": "message",
                "id": "msg_67ccd2bf17f0819081ff3bb2cf6508e60bb6a6b452d3795b",
                "status": "completed",
                "role": "assistant",
                "content": [
                  {
                    "type": "output_text",
                    "text": "In a peaceful grove beneath a silver moon, a unicorn named Lumina discovered a hidden pool that reflected the stars. As she dipped her horn into the water, the pool began to shimmer, revealing a pathway to a magical realm of endless night skies. Filled with wonder, Lumina whispered a wish for all who dream to find their own hidden magic, and as she glanced back, her hoofprints sparkled like stardust.",
                    "annotations": []
                  }
                ]
              }
            ],
            "parallel_tool_calls": true,
            "previous_response_id": null,
            "reasoning": {
              "effort": null,
              "summary": null
            },
            "store": true,
            "temperature": 1.0,
            "text": {
              "format": {
                "type": "text"
              }
            },
            "tool_choice": "auto",
            "tools": [],
            "top_p": 1.0,
            "truncation": "disabled",
            "usage": {
              "input_tokens": 36,
              "input_tokens_details": {
                "cached_tokens": 0
              },
              "output_tokens": 87,
              "output_tokens_details": {
                "reasoning_tokens": 0
              },
              "total_tokens": 123
            },
            "user": null,
            "metadata": {}
          }
          
          """,
      },
      #{
        title: "Image input",
        request: #{
          curl: """
            curl https://api.openai.com/v1/responses \\
              -H "Content-Type: application/json" \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -d '{
                "model": "gpt-5.4",
                "input": [
                  {
                    "role": "user",
                    "content": [
                      {"type": "input_text", "text": "what is in this image?"},
                      {
                        "type": "input_image",
                        "image_url": "https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Gfp-wisconsin-madison-the-nature-boardwalk.jpg/2560px-Gfp-wisconsin-madison-the-nature-boardwalk.jpg"
                      }
                    ]
                  }
                ]
              }'
            
            """,
          javascript: """
            import OpenAI from "openai";
            
            const openai = new OpenAI();
            
            const response = await openai.responses.create({
                model: "gpt-5.4",
                input: [
                    {
                        role: "user",
                        content: [
                            { type: "input_text", text: "what is in this image?" },
                            {
                                type: "input_image",
                                image_url:
                                    "https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Gfp-wisconsin-madison-the-nature-boardwalk.jpg/2560px-Gfp-wisconsin-madison-the-nature-boardwalk.jpg",
                            },
                        ],
                    },
                ],
            });
            
            console.log(response);
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            for response in client.responses.create():
              print(response)
            """,
          csharp: """
            using System;
            using System.Collections.Generic;
            
            using OpenAI.Responses;
            
            OpenAIResponseClient client = new(
                model: "gpt-5.4",
                apiKey: Environment.GetEnvironmentVariable("OPENAI_API_KEY")
            );
            
            List<ResponseItem> inputItems =
            [
                ResponseItem.CreateUserMessageItem(
                    [
                        ResponseContentPart.CreateInputTextPart("What is in this image?"),
                        ResponseContentPart.CreateInputImagePart(new Uri("https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Gfp-wisconsin-madison-the-nature-boardwalk.jpg/2560px-Gfp-wisconsin-madison-the-nature-boardwalk.jpg"))
                    ]
                )
            ];
            
            OpenAIResponse response = client.CreateResponse(inputItems);
            
            Console.WriteLine(response.GetOutputText());
            
            """,
          `node.js`: """
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const response = await client.responses.create();
            
            console.log(response.id);
            """,
          go: """
            package main
            
            import (
            	"context"
            	"fmt"
            
            	"github.com/openai/openai-go"
            	"github.com/openai/openai-go/option"
            	"github.com/openai/openai-go/responses"
            )
            
            func main() {
            	client := openai.NewClient(
            		option.WithAPIKey("My API Key"),
            	)
            	response, err := client.Responses.New(context.TODO(), responses.ResponseNewParams{})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", response.ID)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.responses.Response;
            import com.openai.models.responses.ResponseCreateParams;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    Response response = client.responses().create();
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            response = openai.responses.create
            
            puts(response)
            """,
        },
        response: """
          {
            "id": "resp_67ccd3a9da748190baa7f1570fe91ac604becb25c45c1d41",
            "object": "response",
            "created_at": 1741476777,
            "status": "completed",
            "completed_at": 1741476778,
            "error": null,
            "incomplete_details": null,
            "instructions": null,
            "max_output_tokens": null,
            "model": "gpt-5.4",
            "output": [
              {
                "type": "message",
                "id": "msg_67ccd3acc8d48190a77525dc6de64b4104becb25c45c1d41",
                "status": "completed",
                "role": "assistant",
                "content": [
                  {
                    "type": "output_text",
                    "text": "The image depicts a scenic landscape with a wooden boardwalk or pathway leading through lush, green grass under a blue sky with some clouds. The setting suggests a peaceful natural area, possibly a park or nature reserve. There are trees and shrubs in the background.",
                    "annotations": []
                  }
                ]
              }
            ],
            "parallel_tool_calls": true,
            "previous_response_id": null,
            "reasoning": {
              "effort": null,
              "summary": null
            },
            "store": true,
            "temperature": 1.0,
            "text": {
              "format": {
                "type": "text"
              }
            },
            "tool_choice": "auto",
            "tools": [],
            "top_p": 1.0,
            "truncation": "disabled",
            "usage": {
              "input_tokens": 328,
              "input_tokens_details": {
                "cached_tokens": 0
              },
              "output_tokens": 52,
              "output_tokens_details": {
                "reasoning_tokens": 0
              },
              "total_tokens": 380
            },
            "user": null,
            "metadata": {}
          }
          
          """,
      },
      #{
        title: "File input",
        request: #{
          curl: """
            curl https://api.openai.com/v1/responses \\
              -H "Content-Type: application/json" \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -d '{
                "model": "gpt-5.4",
                "input": [
                  {
                    "role": "user",
                    "content": [
                      {"type": "input_text", "text": "what is in this file?"},
                      {
                        "type": "input_file",
                        "file_url": "https://www.berkshirehathaway.com/letters/2024ltr.pdf"
                      }
                    ]
                  }
                ]
              }'
            
            """,
          javascript: """
            import OpenAI from "openai";
            
            const openai = new OpenAI();
            
            const response = await openai.responses.create({
                model: "gpt-5.4",
                input: [
                    {
                        role: "user",
                        content: [
                            { type: "input_text", text: "what is in this file?" },
                            {
                                type: "input_file",
                                file_url: "https://www.berkshirehathaway.com/letters/2024ltr.pdf",
                            },
                        ],
                    },
                ],
            });
            
            console.log(response);
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            for response in client.responses.create():
              print(response)
            """,
          `node.js`: """
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const response = await client.responses.create();
            
            console.log(response.id);
            """,
          go: """
            package main
            
            import (
            	"context"
            	"fmt"
            
            	"github.com/openai/openai-go"
            	"github.com/openai/openai-go/option"
            	"github.com/openai/openai-go/responses"
            )
            
            func main() {
            	client := openai.NewClient(
            		option.WithAPIKey("My API Key"),
            	)
            	response, err := client.Responses.New(context.TODO(), responses.ResponseNewParams{})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", response.ID)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.responses.Response;
            import com.openai.models.responses.ResponseCreateParams;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    Response response = client.responses().create();
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            response = openai.responses.create
            
            puts(response)
            """,
        },
        response: """
          {
            "id": "resp_686eef60237881a2bd1180bb8b13de430e34c516d176ff86",
            "object": "response",
            "created_at": 1752100704,
            "status": "completed",
            "completed_at": 1752100705,
            "background": false,
            "error": null,
            "incomplete_details": null,
            "instructions": null,
            "max_output_tokens": null,
            "max_tool_calls": null,
            "model": "gpt-5.4",
            "output": [
              {
                "id": "msg_686eef60d3e081a29283bdcbc4322fd90e34c516d176ff86",
                "type": "message",
                "status": "completed",
                "content": [
                  {
                    "type": "output_text",
                    "annotations": [],
                    "logprobs": [],
                    "text": "The file seems to contain excerpts from a letter to the shareholders of Berkshire Hathaway Inc., likely written by Warren Buffett. It covers several topics:
          
          1. **Communication Philosophy**: Buffett emphasizes the importance of transparency and candidness in reporting mistakes and successes to shareholders.
          
          2. **Mistakes and Learnings**: The letter acknowledges past mistakes in business assessments and management hires, highlighting the importance of correcting errors promptly.
          
          3. **CEO Succession**: Mention of Greg Abel stepping in as the new CEO and continuing the tradition of honest communication.
          
          4. **Pete Liegl Story**: A detailed account of acquiring Forest River and the relationship with its founder, highlighting trust and effective business decisions.
          
          5. **2024 Performance**: Overview of business performance, particularly in insurance and investment activities, with a focus on GEICO's improvement.
          
          6. **Tax Contributions**: Discussion of significant tax payments to the U.S. Treasury, credited to shareholders' reinvestments.
          
          7. **Investment Strategy**: A breakdown of Berkshire\\u2019s investments in both controlled subsidiaries and marketable equities, along with a focus on long-term holding strategies.
          
          8. **American Capitalism**: Reflections on America\\u2019s economic development and Berkshire\\u2019s role within it.
          
          9. **Property-Casualty Insurance**: Insights into the P/C insurance business model and its challenges and benefits.
          
          10. **Japanese Investments**: Information about Berkshire\\u2019s investments in Japanese companies and future plans.
          
          11. **Annual Meeting**: Details about the upcoming annual gathering in Omaha, including schedule changes and new book releases.
          
          12. **Personal Anecdotes**: Light-hearted stories about family and interactions, conveying Buffett's personable approach.
          
          13. **Financial Performance Data**: Tables comparing Berkshire\\u2019s annual performance to the S&P 500, showing impressive long-term gains.
          
          Overall, the letter reinforces Berkshire Hathaway's commitment to transparency, investment in both its businesses and the wider economy, and emphasizes strong leadership and prudent financial management."
                  }
                ],
                "role": "assistant"
              }
            ],
            "parallel_tool_calls": true,
            "previous_response_id": null,
            "reasoning": {
              "effort": null,
              "summary": null
            },
            "service_tier": "default",
            "store": true,
            "temperature": 1.0,
            "text": {
              "format": {
                "type": "text"
              }
            },
            "tool_choice": "auto",
            "tools": [],
            "top_logprobs": 0,
            "top_p": 1.0,
            "truncation": "disabled",
            "usage": {
              "input_tokens": 8438,
              "input_tokens_details": {
                "cached_tokens": 0
              },
              "output_tokens": 398,
              "output_tokens_details": {
                "reasoning_tokens": 0
              },
              "total_tokens": 8836
            },
            "user": null,
            "metadata": {}
          }
          
          """,
      },
      #{
        title: "Web search",
        request: #{
          curl: """
            curl https://api.openai.com/v1/responses \\
              -H "Content-Type: application/json" \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -d '{
                "model": "gpt-5.4",
                "tools": [{ "type": "web_search_preview" }],
                "input": "What was a positive news story from today?"
              }'
            
            """,
          javascript: """
            import OpenAI from "openai";
            
            const openai = new OpenAI();
            
            const response = await openai.responses.create({
                model: "gpt-5.4",
                tools: [{ type: "web_search_preview" }],
                input: "What was a positive news story from today?",
            });
            
            console.log(response);
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            for response in client.responses.create():
              print(response)
            """,
          csharp: """
            using System;
            
            using OpenAI.Responses;
            
            OpenAIResponseClient client = new(
                model: "gpt-5.4",
                apiKey: Environment.GetEnvironmentVariable("OPENAI_API_KEY")
            );
            
            string userInputText = "What was a positive news story from today?";
            
            ResponseCreationOptions options = new()
            {
                Tools =
                {
                    ResponseTool.CreateWebSearchTool()
                },
            };
            
            OpenAIResponse response = client.CreateResponse(userInputText, options);
            
            Console.WriteLine(response.GetOutputText());
            
            """,
          `node.js`: """
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const response = await client.responses.create();
            
            console.log(response.id);
            """,
          go: """
            package main
            
            import (
            	"context"
            	"fmt"
            
            	"github.com/openai/openai-go"
            	"github.com/openai/openai-go/option"
            	"github.com/openai/openai-go/responses"
            )
            
            func main() {
            	client := openai.NewClient(
            		option.WithAPIKey("My API Key"),
            	)
            	response, err := client.Responses.New(context.TODO(), responses.ResponseNewParams{})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", response.ID)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.responses.Response;
            import com.openai.models.responses.ResponseCreateParams;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    Response response = client.responses().create();
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            response = openai.responses.create
            
            puts(response)
            """,
        },
        response: """
          {
            "id": "resp_67ccf18ef5fc8190b16dbee19bc54e5f087bb177ab789d5c",
            "object": "response",
            "created_at": 1741484430,
            "status": "completed",
            "completed_at": 1741484431,
            "error": null,
            "incomplete_details": null,
            "instructions": null,
            "max_output_tokens": null,
            "model": "gpt-5.4",
            "output": [
              {
                "type": "web_search_call",
                "id": "ws_67ccf18f64008190a39b619f4c8455ef087bb177ab789d5c",
                "status": "completed"
              },
              {
                "type": "message",
                "id": "msg_67ccf190ca3881909d433c50b1f6357e087bb177ab789d5c",
                "status": "completed",
                "role": "assistant",
                "content": [
                  {
                    "type": "output_text",
                    "text": "As of today, March 9, 2025, one notable positive news story...",
                    "annotations": [
                      {
                        "type": "url_citation",
                        "start_index": 442,
                        "end_index": 557,
                        "url": "https://.../?utm_source=chatgpt.com",
                        "title": "..."
                      },
                      {
                        "type": "url_citation",
                        "start_index": 962,
                        "end_index": 1077,
                        "url": "https://.../?utm_source=chatgpt.com",
                        "title": "..."
                      },
                      {
                        "type": "url_citation",
                        "start_index": 1336,
                        "end_index": 1451,
                        "url": "https://.../?utm_source=chatgpt.com",
                        "title": "..."
                      }
                    ]
                  }
                ]
              }
            ],
            "parallel_tool_calls": true,
            "previous_response_id": null,
            "reasoning": {
              "effort": null,
              "summary": null
            },
            "store": true,
            "temperature": 1.0,
            "text": {
              "format": {
                "type": "text"
              }
            },
            "tool_choice": "auto",
            "tools": [
              {
                "type": "web_search_preview",
                "domains": [],
                "search_context_size": "medium",
                "user_location": {
                  "type": "approximate",
                  "city": null,
                  "country": "US",
                  "region": null,
                  "timezone": null
                }
              }
            ],
            "top_p": 1.0,
            "truncation": "disabled",
            "usage": {
              "input_tokens": 328,
              "input_tokens_details": {
                "cached_tokens": 0
              },
              "output_tokens": 356,
              "output_tokens_details": {
                "reasoning_tokens": 0
              },
              "total_tokens": 684
            },
            "user": null,
            "metadata": {}
          }
          
          """,
      },
      #{
        title: "File search",
        request: #{
          curl: """
            curl https://api.openai.com/v1/responses \\
              -H "Content-Type: application/json" \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -d '{
                "model": "gpt-5.4",
                "tools": [{
                  "type": "file_search",
                  "vector_store_ids": ["vs_1234567890"],
                  "max_num_results": 20
                }],
                "input": "What are the attributes of an ancient brown dragon?"
              }'
            
            """,
          javascript: """
            import OpenAI from "openai";
            
            const openai = new OpenAI();
            
            const response = await openai.responses.create({
                model: "gpt-5.4",
                tools: [{
                  type: "file_search",
                  vector_store_ids: ["vs_1234567890"],
                  max_num_results: 20
                }],
                input: "What are the attributes of an ancient brown dragon?",
            });
            
            console.log(response);
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            for response in client.responses.create():
              print(response)
            """,
          csharp: """
            using System;
            
            using OpenAI.Responses;
            
            OpenAIResponseClient client = new(
                model: "gpt-5.4",
                apiKey: Environment.GetEnvironmentVariable("OPENAI_API_KEY")
            );
            
            string userInputText = "What are the attributes of an ancient brown dragon?";
            
            ResponseCreationOptions options = new()
            {
                Tools =
                {
                    ResponseTool.CreateFileSearchTool(
                        vectorStoreIds: ["vs_1234567890"],
                        maxResultCount: 20
                    )
                },
            };
            
            OpenAIResponse response = client.CreateResponse(userInputText, options);
            
            Console.WriteLine(response.GetOutputText());
            
            """,
          `node.js`: """
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const response = await client.responses.create();
            
            console.log(response.id);
            """,
          go: """
            package main
            
            import (
            	"context"
            	"fmt"
            
            	"github.com/openai/openai-go"
            	"github.com/openai/openai-go/option"
            	"github.com/openai/openai-go/responses"
            )
            
            func main() {
            	client := openai.NewClient(
            		option.WithAPIKey("My API Key"),
            	)
            	response, err := client.Responses.New(context.TODO(), responses.ResponseNewParams{})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", response.ID)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.responses.Response;
            import com.openai.models.responses.ResponseCreateParams;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    Response response = client.responses().create();
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            response = openai.responses.create
            
            puts(response)
            """,
        },
        response: """
          {
            "id": "resp_67ccf4c55fc48190b71bd0463ad3306d09504fb6872380d7",
            "object": "response",
            "created_at": 1741485253,
            "status": "completed",
            "completed_at": 1741485254,
            "error": null,
            "incomplete_details": null,
            "instructions": null,
            "max_output_tokens": null,
            "model": "gpt-5.4",
            "output": [
              {
                "type": "file_search_call",
                "id": "fs_67ccf4c63cd08190887ef6464ba5681609504fb6872380d7",
                "status": "completed",
                "queries": [
                  "attributes of an ancient brown dragon"
                ],
                "results": null
              },
              {
                "type": "message",
                "id": "msg_67ccf4c93e5c81909d595b369351a9d309504fb6872380d7",
                "status": "completed",
                "role": "assistant",
                "content": [
                  {
                    "type": "output_text",
                    "text": "The attributes of an ancient brown dragon include...",
                    "annotations": [
                      {
                        "type": "file_citation",
                        "index": 320,
                        "file_id": "file-4wDz5b167pAf72nx1h9eiN",
                        "filename": "dragons.pdf"
                      },
                      {
                        "type": "file_citation",
                        "index": 576,
                        "file_id": "file-4wDz5b167pAf72nx1h9eiN",
                        "filename": "dragons.pdf"
                      },
                      {
                        "type": "file_citation",
                        "index": 815,
                        "file_id": "file-4wDz5b167pAf72nx1h9eiN",
                        "filename": "dragons.pdf"
                      },
                      {
                        "type": "file_citation",
                        "index": 815,
                        "file_id": "file-4wDz5b167pAf72nx1h9eiN",
                        "filename": "dragons.pdf"
                      },
                      {
                        "type": "file_citation",
                        "index": 1030,
                        "file_id": "file-4wDz5b167pAf72nx1h9eiN",
                        "filename": "dragons.pdf"
                      },
                      {
                        "type": "file_citation",
                        "index": 1030,
                        "file_id": "file-4wDz5b167pAf72nx1h9eiN",
                        "filename": "dragons.pdf"
                      },
                      {
                        "type": "file_citation",
                        "index": 1156,
                        "file_id": "file-4wDz5b167pAf72nx1h9eiN",
                        "filename": "dragons.pdf"
                      },
                      {
                        "type": "file_citation",
                        "index": 1225,
                        "file_id": "file-4wDz5b167pAf72nx1h9eiN",
                        "filename": "dragons.pdf"
                      }
                    ]
                  }
                ]
              }
            ],
            "parallel_tool_calls": true,
            "previous_response_id": null,
            "reasoning": {
              "effort": null,
              "summary": null
            },
            "store": true,
            "temperature": 1.0,
            "text": {
              "format": {
                "type": "text"
              }
            },
            "tool_choice": "auto",
            "tools": [
              {
                "type": "file_search",
                "filters": null,
                "max_num_results": 20,
                "ranking_options": {
                  "ranker": "auto",
                  "score_threshold": 0.0
                },
                "vector_store_ids": [
                  "vs_1234567890"
                ]
              }
            ],
            "top_p": 1.0,
            "truncation": "disabled",
            "usage": {
              "input_tokens": 18307,
              "input_tokens_details": {
                "cached_tokens": 0
              },
              "output_tokens": 348,
              "output_tokens_details": {
                "reasoning_tokens": 0
              },
              "total_tokens": 18655
            },
            "user": null,
            "metadata": {}
          }
          
          """,
      },
      #{
        title: "Streaming",
        request: #{
          curl: """
            curl https://api.openai.com/v1/responses \\
              -H "Content-Type: application/json" \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -d '{
                "model": "gpt-5.4",
                "instructions": "You are a helpful assistant.",
                "input": "Hello!",
                "stream": true
              }'
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            for response in client.responses.create():
              print(response)
            """,
          javascript: """
            import OpenAI from "openai";
            
            const openai = new OpenAI();
            
            const response = await openai.responses.create({
                model: "gpt-5.4",
                instructions: "You are a helpful assistant.",
                input: "Hello!",
                stream: true,
            });
            
            for await (const event of response) {
                console.log(event);
            }
            
            """,
          csharp: """
            using System;
            using System.ClientModel;
            using System.Threading.Tasks;
            
            using OpenAI.Responses;
            
            OpenAIResponseClient client = new(
                model: "gpt-5.4",
                apiKey: Environment.GetEnvironmentVariable("OPENAI_API_KEY")
            );
            
            string userInputText = "Hello!";
            
            ResponseCreationOptions options = new()
            {
                Instructions = "You are a helpful assistant.",
            };
            
            AsyncCollectionResult<StreamingResponseUpdate> responseUpdates = client.CreateResponseStreamingAsync(userInputText, options);
            
            await foreach (StreamingResponseUpdate responseUpdate in responseUpdates)
            {
                if (responseUpdate is StreamingResponseOutputTextDeltaUpdate outputTextDeltaUpdate)
                {
                    Console.Write(outputTextDeltaUpdate.Delta);
                }
            }
            
            """,
          `node.js`: """
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const response = await client.responses.create();
            
            console.log(response.id);
            """,
          go: """
            package main
            
            import (
            	"context"
            	"fmt"
            
            	"github.com/openai/openai-go"
            	"github.com/openai/openai-go/option"
            	"github.com/openai/openai-go/responses"
            )
            
            func main() {
            	client := openai.NewClient(
            		option.WithAPIKey("My API Key"),
            	)
            	response, err := client.Responses.New(context.TODO(), responses.ResponseNewParams{})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", response.ID)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.responses.Response;
            import com.openai.models.responses.ResponseCreateParams;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    Response response = client.responses().create();
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            response = openai.responses.create
            
            puts(response)
            """,
        },
        response: """
          event: response.created
          data: {"type":"response.created","response":{"id":"resp_67c9fdcecf488190bdd9a0409de3a1ec07b8b0ad4e5eb654","object":"response","created_at":1741290958,"status":"in_progress","error":null,"incomplete_details":null,"instructions":"You are a helpful assistant.","max_output_tokens":null,"model":"gpt-5.4","output":[],"parallel_tool_calls":true,"previous_response_id":null,"reasoning":{"effort":null,"summary":null},"store":true,"temperature":1.0,"text":{"format":{"type":"text"}},"tool_choice":"auto","tools":[],"top_p":1.0,"truncation":"disabled","usage":null,"user":null,"metadata":{}}}
          
          event: response.in_progress
          data: {"type":"response.in_progress","response":{"id":"resp_67c9fdcecf488190bdd9a0409de3a1ec07b8b0ad4e5eb654","object":"response","created_at":1741290958,"status":"in_progress","error":null,"incomplete_details":null,"instructions":"You are a helpful assistant.","max_output_tokens":null,"model":"gpt-5.4","output":[],"parallel_tool_calls":true,"previous_response_id":null,"reasoning":{"effort":null,"summary":null},"store":true,"temperature":1.0,"text":{"format":{"type":"text"}},"tool_choice":"auto","tools":[],"top_p":1.0,"truncation":"disabled","usage":null,"user":null,"metadata":{}}}
          
          event: response.output_item.added
          data: {"type":"response.output_item.added","output_index":0,"item":{"id":"msg_67c9fdcf37fc8190ba82116e33fb28c507b8b0ad4e5eb654","type":"message","status":"in_progress","role":"assistant","content":[]}}
          
          event: response.content_part.added
          data: {"type":"response.content_part.added","item_id":"msg_67c9fdcf37fc8190ba82116e33fb28c507b8b0ad4e5eb654","output_index":0,"content_index":0,"part":{"type":"output_text","text":"","annotations":[]}}
          
          event: response.output_text.delta
          data: {"type":"response.output_text.delta","item_id":"msg_67c9fdcf37fc8190ba82116e33fb28c507b8b0ad4e5eb654","output_index":0,"content_index":0,"delta":"Hi"}
          
          ...
          
          event: response.output_text.done
          data: {"type":"response.output_text.done","item_id":"msg_67c9fdcf37fc8190ba82116e33fb28c507b8b0ad4e5eb654","output_index":0,"content_index":0,"text":"Hi there! How can I assist you today?"}
          
          event: response.content_part.done
          data: {"type":"response.content_part.done","item_id":"msg_67c9fdcf37fc8190ba82116e33fb28c507b8b0ad4e5eb654","output_index":0,"content_index":0,"part":{"type":"output_text","text":"Hi there! How can I assist you today?","annotations":[]}}
          
          event: response.output_item.done
          data: {"type":"response.output_item.done","output_index":0,"item":{"id":"msg_67c9fdcf37fc8190ba82116e33fb28c507b8b0ad4e5eb654","type":"message","status":"completed","role":"assistant","content":[{"type":"output_text","text":"Hi there! How can I assist you today?","annotations":[]}]}}
          
          event: response.completed
          data: {"type":"response.completed","response":{"id":"resp_67c9fdcecf488190bdd9a0409de3a1ec07b8b0ad4e5eb654","object":"response","created_at":1741290958,"status":"completed","error":null,"incomplete_details":null,"instructions":"You are a helpful assistant.","max_output_tokens":null,"model":"gpt-5.4","output":[{"id":"msg_67c9fdcf37fc8190ba82116e33fb28c507b8b0ad4e5eb654","type":"message","status":"completed","role":"assistant","content":[{"type":"output_text","text":"Hi there! How can I assist you today?","annotations":[]}]}],"parallel_tool_calls":true,"previous_response_id":null,"reasoning":{"effort":null,"summary":null},"store":true,"temperature":1.0,"text":{"format":{"type":"text"}},"tool_choice":"auto","tools":[],"top_p":1.0,"truncation":"disabled","usage":{"input_tokens":37,"output_tokens":11,"output_tokens_details":{"reasoning_tokens":0},"total_tokens":48},"user":null,"metadata":{}}}
          
          """,
      },
      #{
        title: "Functions",
        request: #{
          curl: """
            curl https://api.openai.com/v1/responses \\
              -H "Content-Type: application/json" \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -d '{
                "model": "gpt-5.4",
                "input": "What is the weather like in Boston today?",
                "tools": [
                  {
                    "type": "function",
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
                      "required": ["location", "unit"]
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
            for response in client.responses.create():
              print(response)
            """,
          javascript: """
            import OpenAI from "openai";
            
            const openai = new OpenAI();
            
            const tools = [
                {
                    type: "function",
                    name: "get_current_weather",
                    description: "Get the current weather in a given location",
                    parameters: {
                        type: "object",
                        properties: {
                            location: {
                                type: "string",
                                description: "The city and state, e.g. San Francisco, CA",
                            },
                            unit: { type: "string", enum: ["celsius", "fahrenheit"] },
                        },
                        required: ["location", "unit"],
                    },
                },
            ];
            
            const response = await openai.responses.create({
                model: "gpt-5.4",
                tools: tools,
                input: "What is the weather like in Boston today?",
                tool_choice: "auto",
            });
            
            console.log(response);
            
            """,
          csharp: """
            using System;
            using OpenAI.Responses;
            
            OpenAIResponseClient client = new(
                model: "gpt-5.4",
                apiKey: Environment.GetEnvironmentVariable("OPENAI_API_KEY")
            );
            
            ResponseTool getCurrentWeatherFunctionTool = ResponseTool.CreateFunctionTool(
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
                            "unit": {"type": "string", "enum": ["celsius", "fahrenheit"]}
                        },
                        "required": ["location", "unit"]
                    }
                    \"""
                )
            );
            
            string userInputText = "What is the weather like in Boston today?";
            
            ResponseCreationOptions options = new()
            {
                Tools =
                {
                    getCurrentWeatherFunctionTool
                },
                ToolChoice = ResponseToolChoice.CreateAutoChoice(),
            };
            
            OpenAIResponse response = client.CreateResponse(userInputText, options);
            
            """,
          `node.js`: """
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const response = await client.responses.create();
            
            console.log(response.id);
            """,
          go: """
            package main
            
            import (
            	"context"
            	"fmt"
            
            	"github.com/openai/openai-go"
            	"github.com/openai/openai-go/option"
            	"github.com/openai/openai-go/responses"
            )
            
            func main() {
            	client := openai.NewClient(
            		option.WithAPIKey("My API Key"),
            	)
            	response, err := client.Responses.New(context.TODO(), responses.ResponseNewParams{})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", response.ID)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.responses.Response;
            import com.openai.models.responses.ResponseCreateParams;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    Response response = client.responses().create();
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            response = openai.responses.create
            
            puts(response)
            """,
        },
        response: """
          {
            "id": "resp_67ca09c5efe0819096d0511c92b8c890096610f474011cc0",
            "object": "response",
            "created_at": 1741294021,
            "status": "completed",
            "completed_at": 1741294022,
            "error": null,
            "incomplete_details": null,
            "instructions": null,
            "max_output_tokens": null,
            "model": "gpt-5.4",
            "output": [
              {
                "type": "function_call",
                "id": "fc_67ca09c6bedc8190a7abfec07b1a1332096610f474011cc0",
                "call_id": "call_unLAR8MvFNptuiZK6K6HCy5k",
                "name": "get_current_weather",
                "arguments": "{"location":"Boston, MA","unit":"celsius"}",
                "status": "completed"
              }
            ],
            "parallel_tool_calls": true,
            "previous_response_id": null,
            "reasoning": {
              "effort": null,
              "summary": null
            },
            "store": true,
            "temperature": 1.0,
            "text": {
              "format": {
                "type": "text"
              }
            },
            "tool_choice": "auto",
            "tools": [
              {
                "type": "function",
                "description": "Get the current weather in a given location",
                "name": "get_current_weather",
                "parameters": {
                  "type": "object",
                  "properties": {
                    "location": {
                      "type": "string",
                      "description": "The city and state, e.g. San Francisco, CA"
                    },
                    "unit": {
                      "type": "string",
                      "enum": [
                        "celsius",
                        "fahrenheit"
                      ]
                    }
                  },
                  "required": [
                    "location",
                    "unit"
                  ]
                },
                "strict": true
              }
            ],
            "top_p": 1.0,
            "truncation": "disabled",
            "usage": {
              "input_tokens": 291,
              "output_tokens": 23,
              "output_tokens_details": {
                "reasoning_tokens": 0
              },
              "total_tokens": 314
            },
            "user": null,
            "metadata": {}
          }
          
          """,
      },
      #{
        title: "Reasoning",
        request: #{
          curl: """
            curl https://api.openai.com/v1/responses \\
              -H "Content-Type: application/json" \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -d '{
                "model": "o3-mini",
                "input": "How much wood would a woodchuck chuck?",
                "reasoning": {
                  "effort": "high"
                }
              }'
            
            """,
          javascript: """
            import OpenAI from "openai";
            const openai = new OpenAI();
            
            const response = await openai.responses.create({
                model: "o3-mini",
                input: "How much wood would a woodchuck chuck?",
                reasoning: {
                  effort: "high"
                }
            });
            
            console.log(response);
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            for response in client.responses.create():
              print(response)
            """,
          csharp: """
            using System;
            using OpenAI.Responses;
            
            OpenAIResponseClient client = new(
                model: "o3-mini",
                apiKey: Environment.GetEnvironmentVariable("OPENAI_API_KEY")
            );
            
            string userInputText = "How much wood would a woodchuck chuck?";
            
            ResponseCreationOptions options = new()
            {
                ReasoningOptions = new()
                {
                    ReasoningEffortLevel = ResponseReasoningEffortLevel.High,
                },
            };
            
            OpenAIResponse response = client.CreateResponse(userInputText, options);
            
            Console.WriteLine(response.GetOutputText());
            
            """,
          `node.js`: """
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const response = await client.responses.create();
            
            console.log(response.id);
            """,
          go: """
            package main
            
            import (
            	"context"
            	"fmt"
            
            	"github.com/openai/openai-go"
            	"github.com/openai/openai-go/option"
            	"github.com/openai/openai-go/responses"
            )
            
            func main() {
            	client := openai.NewClient(
            		option.WithAPIKey("My API Key"),
            	)
            	response, err := client.Responses.New(context.TODO(), responses.ResponseNewParams{})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", response.ID)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.responses.Response;
            import com.openai.models.responses.ResponseCreateParams;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    Response response = client.responses().create();
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            response = openai.responses.create
            
            puts(response)
            """,
        },
        response: """
          {
            "id": "resp_67ccd7eca01881908ff0b5146584e408072912b2993db808",
            "object": "response",
            "created_at": 1741477868,
            "status": "completed",
            "completed_at": 1741477869,
            "error": null,
            "incomplete_details": null,
            "instructions": null,
            "max_output_tokens": null,
            "model": "o1-2024-12-17",
            "output": [
              {
                "type": "message",
                "id": "msg_67ccd7f7b5848190a6f3e95d809f6b44072912b2993db808",
                "status": "completed",
                "role": "assistant",
                "content": [
                  {
                    "type": "output_text",
                    "text": "The classic tongue twister...",
                    "annotations": []
                  }
                ]
              }
            ],
            "parallel_tool_calls": true,
            "previous_response_id": null,
            "reasoning": {
              "effort": "high",
              "summary": null
            },
            "store": true,
            "temperature": 1.0,
            "text": {
              "format": {
                "type": "text"
              }
            },
            "tool_choice": "auto",
            "tools": [],
            "top_p": 1.0,
            "truncation": "disabled",
            "usage": {
              "input_tokens": 81,
              "input_tokens_details": {
                "cached_tokens": 0
              },
              "output_tokens": 1035,
              "output_tokens_details": {
                "reasoning_tokens": 832
              },
              "total_tokens": 1116
            },
            "user": null,
            "metadata": {}
          }
          
          """,
      }
    ],
  }
);

@@extension(
  Azure.AI.Projects.Responses.deleteResponse,
  "x-oaiMeta",
  #{
    name: "Delete a model response",
    group: "responses",
    examples: #{
      request: #{
        curl: """
          curl -X DELETE https://api.openai.com/v1/responses/resp_123 \\
              -H "Content-Type: application/json" \\
              -H "Authorization: Bearer $OPENAI_API_KEY"
          
          """,
        javascript: """
          import OpenAI from "openai";
          const client = new OpenAI();
          
          const response = await client.responses.delete("resp_123");
          console.log(response);
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          client.responses.delete(
              "resp_677efb5139a88190b512bc3fef8e535d",
          )
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          await client.responses.delete('resp_677efb5139a88190b512bc3fef8e535d');
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
          	err := client.Responses.Delete(context.TODO(), "resp_677efb5139a88190b512bc3fef8e535d")
          	if err != nil {
          		panic(err.Error())
          	}
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.responses.ResponseDeleteParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  client.responses().delete("resp_677efb5139a88190b512bc3fef8e535d");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          result = openai.responses.delete("resp_677efb5139a88190b512bc3fef8e535d")
          
          puts(result)
          """,
      },
      response: """
        {
          "id": "resp_6786a1bec27481909a17d673315b29f6",
          "object": "response",
          "deleted": true
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Responses.getResponse,
  "x-oaiMeta",
  #{
    name: "Get a model response",
    group: "responses",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/responses/resp_123 \\
              -H "Content-Type: application/json" \\
              -H "Authorization: Bearer $OPENAI_API_KEY"
          
          """,
        javascript: """
          import OpenAI from "openai";
          const client = new OpenAI();
          
          const response = await client.responses.retrieve("resp_123");
          console.log(response);
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          for response in client.responses.retrieve(
              response_id="resp_677efb5139a88190b512bc3fef8e535d",
          ):
            print(response)
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const response = await client.responses.retrieve('resp_677efb5139a88190b512bc3fef8e535d');
          
          console.log(response.id);
          """,
        go: """
          package main
          
          import (
          	"context"
          	"fmt"
          
          	"github.com/openai/openai-go"
          	"github.com/openai/openai-go/option"
          	"github.com/openai/openai-go/responses"
          )
          
          func main() {
          	client := openai.NewClient(
          		option.WithAPIKey("My API Key"),
          	)
          	response, err := client.Responses.Get(
          		context.TODO(),
          		"resp_677efb5139a88190b512bc3fef8e535d",
          		responses.ResponseGetParams{},
          	)
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", response.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.responses.Response;
          import com.openai.models.responses.ResponseRetrieveParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  Response response = client.responses().retrieve("resp_677efb5139a88190b512bc3fef8e535d");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          response = openai.responses.retrieve("resp_677efb5139a88190b512bc3fef8e535d")
          
          puts(response)
          """,
      },
      response: """
        {
          "id": "resp_67cb71b351908190a308f3859487620d06981a8637e6bc44",
          "object": "response",
          "created_at": 1741386163,
          "status": "completed",
          "completed_at": 1741386164,
          "error": null,
          "incomplete_details": null,
          "instructions": null,
          "max_output_tokens": null,
          "model": "gpt-4o-2024-08-06",
          "output": [
            {
              "type": "message",
              "id": "msg_67cb71b3c2b0819084d481baaaf148f206981a8637e6bc44",
              "status": "completed",
              "role": "assistant",
              "content": [
                {
                  "type": "output_text",
                  "text": "Silent circuits hum,
        Thoughts emerge in data streams—
        Digital dawn breaks.",
                  "annotations": []
                }
              ]
            }
          ],
          "parallel_tool_calls": true,
          "previous_response_id": null,
          "reasoning": {
            "effort": null,
            "summary": null
          },
          "store": true,
          "temperature": 1.0,
          "text": {
            "format": {
              "type": "text"
            }
          },
          "tool_choice": "auto",
          "tools": [],
          "top_p": 1.0,
          "truncation": "disabled",
          "usage": {
            "input_tokens": 32,
            "input_tokens_details": {
              "cached_tokens": 0
            },
            "output_tokens": 18,
            "output_tokens_details": {
              "reasoning_tokens": 0
            },
            "total_tokens": 50
          },
          "user": null,
          "metadata": {}
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Responses.cancelResponse,
  "x-oaiMeta",
  #{
    name: "Cancel a response",
    group: "responses",
    examples: #{
      request: #{
        curl: """
          curl -X POST https://api.openai.com/v1/responses/resp_123/cancel \\
              -H "Content-Type: application/json" \\
              -H "Authorization: Bearer $OPENAI_API_KEY"
          
          """,
        javascript: """
          import OpenAI from "openai";
          const client = new OpenAI();
          
          const response = await client.responses.cancel("resp_123");
          console.log(response);
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          response = client.responses.cancel(
              "resp_677efb5139a88190b512bc3fef8e535d",
          )
          print(response.id)
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const response = await client.responses.cancel('resp_677efb5139a88190b512bc3fef8e535d');
          
          console.log(response.id);
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
          	response, err := client.Responses.Cancel(context.TODO(), "resp_677efb5139a88190b512bc3fef8e535d")
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", response.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.responses.Response;
          import com.openai.models.responses.ResponseCancelParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  Response response = client.responses().cancel("resp_677efb5139a88190b512bc3fef8e535d");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          response = openai.responses.cancel("resp_677efb5139a88190b512bc3fef8e535d")
          
          puts(response)
          """,
      },
      response: """
        {
          "id": "resp_67cb71b351908190a308f3859487620d06981a8637e6bc44",
          "object": "response",
          "created_at": 1741386163,
          "status": "cancelled",
          "background": true,
          "completed_at": null,
          "error": null,
          "incomplete_details": null,
          "instructions": null,
          "max_output_tokens": null,
          "model": "gpt-4o-2024-08-06",
          "output": [
            {
              "type": "message",
              "id": "msg_67cb71b3c2b0819084d481baaaf148f206981a8637e6bc44",
              "status": "in_progress",
              "role": "assistant",
              "content": [
                {
                  "type": "output_text",
                  "text": "Silent circuits hum,
        Thoughts emerge in data streams—
        Digital dawn breaks.",
                  "annotations": []
                }
              ]
            }
          ],
          "parallel_tool_calls": true,
          "previous_response_id": null,
          "reasoning": {
            "effort": null,
            "summary": null
          },
          "store": true,
          "temperature": 1.0,
          "text": {
            "format": {
              "type": "text"
            }
          },
          "tool_choice": "auto",
          "tools": [],
          "top_p": 1.0,
          "truncation": "disabled",
          "usage": null,
          "user": null,
          "metadata": {}
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Responses.listInputItems,
  "x-oaiMeta",
  #{
    name: "List input items",
    group: "responses",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/responses/resp_abc123/input_items \\
            -H "Content-Type: application/json" \\
            -H "Authorization: Bearer $OPENAI_API_KEY"
          
          """,
        javascript: """
          import OpenAI from "openai";
          const client = new OpenAI();
          
          const response = await client.responses.inputItems.list("resp_123");
          console.log(response.data);
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          page = client.responses.input_items.list(
              response_id="response_id",
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
          for await (const responseItem of client.responses.inputItems.list('response_id')) {
            console.log(responseItem);
          }
          """,
        go: """
          package main
          
          import (
          	"context"
          	"fmt"
          
          	"github.com/openai/openai-go"
          	"github.com/openai/openai-go/option"
          	"github.com/openai/openai-go/responses"
          )
          
          func main() {
          	client := openai.NewClient(
          		option.WithAPIKey("My API Key"),
          	)
          	page, err := client.Responses.InputItems.List(
          		context.TODO(),
          		"response_id",
          		responses.InputItemListParams{},
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
          import com.openai.models.responses.inputitems.InputItemListPage;
          import com.openai.models.responses.inputitems.InputItemListParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  InputItemListPage page = client.responses().inputItems().list("response_id");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          page = openai.responses.input_items.list("response_id")
          
          puts(page)
          """,
      },
      response: """
        {
          "object": "list",
          "data": [
            {
              "id": "msg_abc123",
              "type": "message",
              "role": "user",
              "content": [
                {
                  "type": "input_text",
                  "text": "Tell me a three sentence bedtime story about a unicorn."
                }
              ]
            }
          ],
          "first_id": "msg_abc123",
          "last_id": "msg_abc123",
          "has_more": false
        }
        
        """,
    },
  }
);

@@extension(Azure.AI.Projects.Responses.listInputItems, "x-ms-list", true);

@@extension(
  Azure.AI.Projects.Responses.Compactconversation,
  "x-oaiMeta",
  #{
    name: "Compact a response",
    group: "responses",
    examples: #{
      request: #{
        curl: """
          curl -X POST https://api.openai.com/v1/responses/compact \\
              -H "Content-Type: application/json" \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -d '{
                "model": "gpt-5.1-codex-max",
                "input": [
                  {
                    "role": "user",
                    "content": "Create a simple landing page for a dog petting café."
                  },
                  {
                    "id": "msg_001",
                    "type": "message",
                    "status": "completed",
                    "content": [
                      {
                        "type": "output_text",
                        "annotations": [],
                        "logprobs": [],
                        "text": "Below is a single file, ready-to-use landing page for a dog petting café:..."
                      }
                    ],
                    "role": "assistant"
                  }
                ]
              }'
          
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          // Compact the previous response if you are running out of tokens
          const compactedResponse = await openai.responses.compact({
            model: "gpt-5.1-codex-max",
            input: [
              {
                role: "user",
                content: "Create a simple landing page for a dog petting café.",
              },
              // All items returned from previous requests are included here, like reasoning, message, function call, etc.
              {
                id: "msg_030d085c0b53e67e0069332e3a72d4819c96c6f2c4adc15d33",
                type: "message",
                status: "completed",
                content: [
                  {
                    type: "output_text",
                    annotations: [],
                    logprobs: [],
                    text: "Below is a single file, ready-to-use landing page for a dog petting café:...",
                  },
                ],
                role: "assistant",
              },
            ],
          });
          
          // Pass the compactedResponse.output as input to the next request
          console.log(compactedResponse);
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          compacted_response = client.responses.compact(
              model="gpt-5.4",
          )
          print(compacted_response.id)
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const compactedResponse = await client.responses.compact({ model: 'gpt-5.4' });
          
          console.log(compactedResponse.id);
          """,
        go: """
          package main
          
          import (
          	"context"
          	"fmt"
          
          	"github.com/openai/openai-go"
          	"github.com/openai/openai-go/option"
          	"github.com/openai/openai-go/responses"
          )
          
          func main() {
          	client := openai.NewClient(
          		option.WithAPIKey("My API Key"),
          	)
          	compactedResponse, err := client.Responses.Compact(context.TODO(), responses.ResponseCompactParams{
          		Model: responses.ResponseCompactParamsModelGPT5_4,
          	})
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", compactedResponse.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.responses.CompactedResponse;
          import com.openai.models.responses.ResponseCompactParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  ResponseCompactParams params = ResponseCompactParams.builder()
                      .model(ResponseCompactParams.Model.GPT_5_4)
                      .build();
                  CompactedResponse compactedResponse = client.responses().compact(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          compacted_response = openai.responses.compact(model: :"gpt-5.4")
          
          puts(compacted_response)
          """,
      },
      response: """
        {
          "id": "resp_001",
          "object": "response.compaction",
          "created_at": 1764967971,
          "output": [
            {
              "id": "msg_000",
              "type": "message",
              "status": "completed",
              "content": [
                {
                  "type": "input_text",
                  "text": "Create a simple landing page for a dog petting cafe."
                }
              ],
              "role": "user"
            },
            {
              "id": "cmp_001",
              "type": "compaction",
              "encrypted_content": "gAAAAABpM0Yj-...="
            }
          ],
          "usage": {
            "input_tokens": 139,
            "input_tokens_details": {
              "cached_tokens": 0
            },
            "output_tokens": 438,
            "output_tokens_details": {
              "reasoning_tokens": 64
            },
            "total_tokens": 577
          }
        }
        
        """,
    },
  }
);
