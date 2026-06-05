import "./routes.tsp";
import "@typespec/openapi";
using TypeSpec.OpenAPI;
namespace Azure.AI.Projects;
@@extension(
  Azure.AI.Projects.Threads.createThread,
  "x-oaiMeta",
  #{
    name: "Create thread",
    group: "threads",
    beta: true,
    examples: #[
      #{
        title: "Empty",
        request: #{
          curl: """
            curl https://api.openai.com/v1/threads \\
              -H "Content-Type: application/json" \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -H "OpenAI-Beta: assistants=v2" \\
              -d ''
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            thread = client.beta.threads.create()
            print(thread.id)
            """,
          javascript: """
            import OpenAI from "openai";
            
            const openai = new OpenAI();
            
            async function main() {
              const emptyThread = await openai.beta.threads.create();
            
              console.log(emptyThread);
            }
            
            main();
            """,
          `node.js`: """
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const thread = await client.beta.threads.create();
            
            console.log(thread.id);
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
            	thread, err := client.Beta.Threads.New(context.TODO(), openai.BetaThreadNewParams{})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", thread.ID)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.beta.threads.Thread;
            import com.openai.models.beta.threads.ThreadCreateParams;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    Thread thread = client.beta().threads().create();
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            thread = openai.beta.threads.create
            
            puts(thread)
            """,
        },
        response: """
          {
            "id": "thread_abc123",
            "object": "thread",
            "created_at": 1699012949,
            "metadata": {},
            "tool_resources": {}
          }
          
          """,
      },
      #{
        title: "Messages",
        request: #{
          curl: """
            curl https://api.openai.com/v1/threads \\
            -H "Content-Type: application/json" \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "OpenAI-Beta: assistants=v2" \\
            -d '{
                "messages": [{
                  "role": "user",
                  "content": "Hello, what is AI?"
                }, {
                  "role": "user",
                  "content": "How does AI work? Explain it in simple terms."
                }]
              }'
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            thread = client.beta.threads.create()
            print(thread.id)
            """,
          javascript: """
            import OpenAI from "openai";
            
            const openai = new OpenAI();
            
            async function main() {
              const messageThread = await openai.beta.threads.create({
                messages: [
                  {
                    role: "user",
                    content: "Hello, what is AI?"
                  },
                  {
                    role: "user",
                    content: "How does AI work? Explain it in simple terms.",
                  },
                ],
              });
            
              console.log(messageThread);
            }
            
            main();
            """,
          `node.js`: """
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const thread = await client.beta.threads.create();
            
            console.log(thread.id);
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
            	thread, err := client.Beta.Threads.New(context.TODO(), openai.BetaThreadNewParams{})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", thread.ID)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.beta.threads.Thread;
            import com.openai.models.beta.threads.ThreadCreateParams;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    Thread thread = client.beta().threads().create();
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            thread = openai.beta.threads.create
            
            puts(thread)
            """,
        },
        response: """
          {
            "id": "thread_abc123",
            "object": "thread",
            "created_at": 1699014083,
            "metadata": {},
            "tool_resources": {}
          }
          
          """,
      }
    ],
  }
);

@@extension(
  Azure.AI.Projects.Threads.createThreadAndRun,
  "x-oaiMeta",
  #{
    name: "Create thread and run",
    group: "threads",
    beta: true,
    examples: #[
      #{
        title: "Default",
        request: #{
          curl: """
            curl https://api.openai.com/v1/threads/runs \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -H "Content-Type: application/json" \\
              -H "OpenAI-Beta: assistants=v2" \\
              -d '{
                  "assistant_id": "asst_abc123",
                  "thread": {
                    "messages": [
                      {"role": "user", "content": "Explain deep learning to a 5 year old."}
                    ]
                  }
                }'
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            for thread in client.beta.threads.create_and_run(
                assistant_id="assistant_id",
            ):
              print(thread)
            """,
          javascript: """
            import OpenAI from "openai";
            
            const openai = new OpenAI();
            
            async function main() {
              const run = await openai.beta.threads.createAndRun({
                assistant_id: "asst_abc123",
                thread: {
                  messages: [
                    { role: "user", content: "Explain deep learning to a 5 year old." },
                  ],
                },
              });
            
              console.log(run);
            }
            
            main();
            
            """,
          `node.js`: """
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const run = await client.beta.threads.createAndRun({ assistant_id: 'assistant_id' });
            
            console.log(run.id);
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
            	run, err := client.Beta.Threads.NewAndRun(context.TODO(), openai.BetaThreadNewAndRunParams{
            		AssistantID: "assistant_id",
            	})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", run.ID)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.beta.threads.ThreadCreateAndRunParams;
            import com.openai.models.beta.threads.runs.Run;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    ThreadCreateAndRunParams params = ThreadCreateAndRunParams.builder()
                        .assistantId("assistant_id")
                        .build();
                    Run run = client.beta().threads().createAndRun(params);
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            run = openai.beta.threads.create_and_run(assistant_id: "assistant_id")
            
            puts(run)
            """,
        },
        response: """
          {
            "id": "run_abc123",
            "object": "thread.run",
            "created_at": 1699076792,
            "assistant_id": "asst_abc123",
            "thread_id": "thread_abc123",
            "status": "queued",
            "started_at": null,
            "expires_at": 1699077392,
            "cancelled_at": null,
            "failed_at": null,
            "completed_at": null,
            "required_action": null,
            "last_error": null,
            "model": "gpt-4o",
            "instructions": "You are a helpful assistant.",
            "tools": [],
            "tool_resources": {},
            "metadata": {},
            "temperature": 1.0,
            "top_p": 1.0,
            "max_completion_tokens": null,
            "max_prompt_tokens": null,
            "truncation_strategy": {
              "type": "auto",
              "last_messages": null
            },
            "incomplete_details": null,
            "usage": null,
            "response_format": "auto",
            "tool_choice": "auto",
            "parallel_tool_calls": true
          }
          
          """,
      },
      #{
        title: "Streaming",
        request: #{
          curl: """
            curl https://api.openai.com/v1/threads/runs \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -H "Content-Type: application/json" \\
              -H "OpenAI-Beta: assistants=v2" \\
              -d '{
                "assistant_id": "asst_123",
                "thread": {
                  "messages": [
                    {"role": "user", "content": "Hello"}
                  ]
                },
                "stream": true
              }'
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            for thread in client.beta.threads.create_and_run(
                assistant_id="assistant_id",
            ):
              print(thread)
            """,
          javascript: """
            import OpenAI from "openai";
            
            const openai = new OpenAI();
            
            async function main() {
              const stream = await openai.beta.threads.createAndRun({
                  assistant_id: "asst_123",
                  thread: {
                    messages: [
                      { role: "user", content: "Hello" },
                    ],
                  },
                  stream: true
              });
            
              for await (const event of stream) {
                console.log(event);
              }
            }
            
            main();
            
            """,
          `node.js`: """
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const run = await client.beta.threads.createAndRun({ assistant_id: 'assistant_id' });
            
            console.log(run.id);
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
            	run, err := client.Beta.Threads.NewAndRun(context.TODO(), openai.BetaThreadNewAndRunParams{
            		AssistantID: "assistant_id",
            	})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", run.ID)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.beta.threads.ThreadCreateAndRunParams;
            import com.openai.models.beta.threads.runs.Run;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    ThreadCreateAndRunParams params = ThreadCreateAndRunParams.builder()
                        .assistantId("assistant_id")
                        .build();
                    Run run = client.beta().threads().createAndRun(params);
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            run = openai.beta.threads.create_and_run(assistant_id: "assistant_id")
            
            puts(run)
            """,
        },
        response: """
          event: thread.created
          data: {"id":"thread_123","object":"thread","created_at":1710348075,"metadata":{}}
          
          event: thread.run.created
          data: {"id":"run_123","object":"thread.run","created_at":1710348075,"assistant_id":"asst_123","thread_id":"thread_123","status":"queued","started_at":null,"expires_at":1710348675,"cancelled_at":null,"failed_at":null,"completed_at":null,"required_action":null,"last_error":null,"model":"gpt-4o","instructions":null,"tools":[],"tool_resources":{},"metadata":{},"temperature":1.0,"top_p":1.0,"max_completion_tokens":null,"max_prompt_tokens":null,"truncation_strategy":{"type":"auto","last_messages":null},"incomplete_details":null,"usage":null,"response_format":"auto","tool_choice":"auto","parallel_tool_calls":true}
          
          event: thread.run.queued
          data: {"id":"run_123","object":"thread.run","created_at":1710348075,"assistant_id":"asst_123","thread_id":"thread_123","status":"queued","started_at":null,"expires_at":1710348675,"cancelled_at":null,"failed_at":null,"completed_at":null,"required_action":null,"last_error":null,"model":"gpt-4o","instructions":null,"tools":[],"tool_resources":{},"metadata":{},"temperature":1.0,"top_p":1.0,"max_completion_tokens":null,"max_prompt_tokens":null,"truncation_strategy":{"type":"auto","last_messages":null},"incomplete_details":null,"usage":null,"response_format":"auto","tool_choice":"auto","parallel_tool_calls":true}
          
          event: thread.run.in_progress
          data: {"id":"run_123","object":"thread.run","created_at":1710348075,"assistant_id":"asst_123","thread_id":"thread_123","status":"in_progress","started_at":null,"expires_at":1710348675,"cancelled_at":null,"failed_at":null,"completed_at":null,"required_action":null,"last_error":null,"model":"gpt-4o","instructions":null,"tools":[],"tool_resources":{},"metadata":{},"temperature":1.0,"top_p":1.0,"max_completion_tokens":null,"max_prompt_tokens":null,"truncation_strategy":{"type":"auto","last_messages":null},"incomplete_details":null,"usage":null,"response_format":"auto","tool_choice":"auto","parallel_tool_calls":true}
          
          event: thread.run.step.created
          data: {"id":"step_001","object":"thread.run.step","created_at":1710348076,"run_id":"run_123","assistant_id":"asst_123","thread_id":"thread_123","type":"message_creation","status":"in_progress","cancelled_at":null,"completed_at":null,"expires_at":1710348675,"failed_at":null,"last_error":null,"step_details":{"type":"message_creation","message_creation":{"message_id":"msg_001"}},"usage":null}
          
          event: thread.run.step.in_progress
          data: {"id":"step_001","object":"thread.run.step","created_at":1710348076,"run_id":"run_123","assistant_id":"asst_123","thread_id":"thread_123","type":"message_creation","status":"in_progress","cancelled_at":null,"completed_at":null,"expires_at":1710348675,"failed_at":null,"last_error":null,"step_details":{"type":"message_creation","message_creation":{"message_id":"msg_001"}},"usage":null}
          
          event: thread.message.created
          data: {"id":"msg_001","object":"thread.message","created_at":1710348076,"assistant_id":"asst_123","thread_id":"thread_123","run_id":"run_123","status":"in_progress","incomplete_details":null,"incomplete_at":null,"completed_at":null,"role":"assistant","content":[], "metadata":{}}
          
          event: thread.message.in_progress
          data: {"id":"msg_001","object":"thread.message","created_at":1710348076,"assistant_id":"asst_123","thread_id":"thread_123","run_id":"run_123","status":"in_progress","incomplete_details":null,"incomplete_at":null,"completed_at":null,"role":"assistant","content":[], "metadata":{}}
          
          event: thread.message.delta
          data: {"id":"msg_001","object":"thread.message.delta","delta":{"content":[{"index":0,"type":"text","text":{"value":"Hello","annotations":[]}}]}}
          
          ...
          
          event: thread.message.delta
          data: {"id":"msg_001","object":"thread.message.delta","delta":{"content":[{"index":0,"type":"text","text":{"value":" today"}}]}}
          
          event: thread.message.delta
          data: {"id":"msg_001","object":"thread.message.delta","delta":{"content":[{"index":0,"type":"text","text":{"value":"?"}}]}}
          
          event: thread.message.completed
          data: {"id":"msg_001","object":"thread.message","created_at":1710348076,"assistant_id":"asst_123","thread_id":"thread_123","run_id":"run_123","status":"completed","incomplete_details":null,"incomplete_at":null,"completed_at":1710348077,"role":"assistant","content":[{"type":"text","text":{"value":"Hello! How can I assist you today?","annotations":[]}}], "metadata":{}}
          
          event: thread.run.step.completed
          data: {"id":"step_001","object":"thread.run.step","created_at":1710348076,"run_id":"run_123","assistant_id":"asst_123","thread_id":"thread_123","type":"message_creation","status":"completed","cancelled_at":null,"completed_at":1710348077,"expires_at":1710348675,"failed_at":null,"last_error":null,"step_details":{"type":"message_creation","message_creation":{"message_id":"msg_001"}},"usage":{"prompt_tokens":20,"completion_tokens":11,"total_tokens":31}}
          
          event: thread.run.completed
          {"id":"run_123","object":"thread.run","created_at":1710348076,"assistant_id":"asst_123","thread_id":"thread_123","status":"completed","started_at":1713226836,"expires_at":null,"cancelled_at":null,"failed_at":null,"completed_at":1713226837,"required_action":null,"last_error":null,"model":"gpt-4o","instructions":null,"tools":[],"metadata":{},"temperature":1.0,"top_p":1.0,"max_completion_tokens":null,"max_prompt_tokens":null,"truncation_strategy":{"type":"auto","last_messages":null},"incomplete_details":null,"usage":{"prompt_tokens":345,"completion_tokens":11,"total_tokens":356},"response_format":"auto","tool_choice":"auto","parallel_tool_calls":true}
          
          event: done
          data: [DONE]
          
          """,
      },
      #{
        title: "Streaming with Functions",
        request: #{
          curl: """
            curl https://api.openai.com/v1/threads/runs \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -H "Content-Type: application/json" \\
              -H "OpenAI-Beta: assistants=v2" \\
              -d '{
                "assistant_id": "asst_abc123",
                "thread": {
                  "messages": [
                    {"role": "user", "content": "What is the weather like in San Francisco?"}
                  ]
                },
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
                "stream": true
              }'
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            for thread in client.beta.threads.create_and_run(
                assistant_id="assistant_id",
            ):
              print(thread)
            """,
          javascript: """
            import OpenAI from "openai";
            
            const openai = new OpenAI();
            
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
            
            async function main() {
              const stream = await openai.beta.threads.createAndRun({
                assistant_id: "asst_123",
                thread: {
                  messages: [
                    { role: "user", content: "What is the weather like in San Francisco?" },
                  ],
                },
                tools: tools,
                stream: true
              });
            
              for await (const event of stream) {
                console.log(event);
              }
            }
            
            main();
            
            """,
          `node.js`: """
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const run = await client.beta.threads.createAndRun({ assistant_id: 'assistant_id' });
            
            console.log(run.id);
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
            	run, err := client.Beta.Threads.NewAndRun(context.TODO(), openai.BetaThreadNewAndRunParams{
            		AssistantID: "assistant_id",
            	})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", run.ID)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.beta.threads.ThreadCreateAndRunParams;
            import com.openai.models.beta.threads.runs.Run;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    ThreadCreateAndRunParams params = ThreadCreateAndRunParams.builder()
                        .assistantId("assistant_id")
                        .build();
                    Run run = client.beta().threads().createAndRun(params);
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            run = openai.beta.threads.create_and_run(assistant_id: "assistant_id")
            
            puts(run)
            """,
        },
        response: """
          event: thread.created
          data: {"id":"thread_123","object":"thread","created_at":1710351818,"metadata":{}}
          
          event: thread.run.created
          data: {"id":"run_123","object":"thread.run","created_at":1710351818,"assistant_id":"asst_123","thread_id":"thread_123","status":"queued","started_at":null,"expires_at":1710352418,"cancelled_at":null,"failed_at":null,"completed_at":null,"required_action":null,"last_error":null,"model":"gpt-4o","instructions":null,"tools":[{"type":"function","function":{"name":"get_current_weather","description":"Get the current weather in a given location","parameters":{"type":"object","properties":{"location":{"type":"string","description":"The city and state, e.g. San Francisco, CA"},"unit":{"type":"string","enum":["celsius","fahrenheit"]}},"required":["location"]}}}],"metadata":{},"temperature":1.0,"top_p":1.0,"max_completion_tokens":null,"max_prompt_tokens":null,"truncation_strategy":{"type":"auto","last_messages":null},"incomplete_details":null,"usage":null,"response_format":"auto","tool_choice":"auto","parallel_tool_calls":true}}
          
          event: thread.run.queued
          data: {"id":"run_123","object":"thread.run","created_at":1710351818,"assistant_id":"asst_123","thread_id":"thread_123","status":"queued","started_at":null,"expires_at":1710352418,"cancelled_at":null,"failed_at":null,"completed_at":null,"required_action":null,"last_error":null,"model":"gpt-4o","instructions":null,"tools":[{"type":"function","function":{"name":"get_current_weather","description":"Get the current weather in a given location","parameters":{"type":"object","properties":{"location":{"type":"string","description":"The city and state, e.g. San Francisco, CA"},"unit":{"type":"string","enum":["celsius","fahrenheit"]}},"required":["location"]}}}],"metadata":{},"temperature":1.0,"top_p":1.0,"max_completion_tokens":null,"max_prompt_tokens":null,"truncation_strategy":{"type":"auto","last_messages":null},"incomplete_details":null,"usage":null,"response_format":"auto","tool_choice":"auto","parallel_tool_calls":true}}
          
          event: thread.run.in_progress
          data: {"id":"run_123","object":"thread.run","created_at":1710351818,"assistant_id":"asst_123","thread_id":"thread_123","status":"in_progress","started_at":1710351818,"expires_at":1710352418,"cancelled_at":null,"failed_at":null,"completed_at":null,"required_action":null,"last_error":null,"model":"gpt-4o","instructions":null,"tools":[{"type":"function","function":{"name":"get_current_weather","description":"Get the current weather in a given location","parameters":{"type":"object","properties":{"location":{"type":"string","description":"The city and state, e.g. San Francisco, CA"},"unit":{"type":"string","enum":["celsius","fahrenheit"]}},"required":["location"]}}}],"metadata":{},"temperature":1.0,"top_p":1.0,"max_completion_tokens":null,"max_prompt_tokens":null,"truncation_strategy":{"type":"auto","last_messages":null},"incomplete_details":null,"usage":null,"response_format":"auto","tool_choice":"auto","parallel_tool_calls":true}}
          
          event: thread.run.step.created
          data: {"id":"step_001","object":"thread.run.step","created_at":1710351819,"run_id":"run_123","assistant_id":"asst_123","thread_id":"thread_123","type":"tool_calls","status":"in_progress","cancelled_at":null,"completed_at":null,"expires_at":1710352418,"failed_at":null,"last_error":null,"step_details":{"type":"tool_calls","tool_calls":[]},"usage":null}
          
          event: thread.run.step.in_progress
          data: {"id":"step_001","object":"thread.run.step","created_at":1710351819,"run_id":"run_123","assistant_id":"asst_123","thread_id":"thread_123","type":"tool_calls","status":"in_progress","cancelled_at":null,"completed_at":null,"expires_at":1710352418,"failed_at":null,"last_error":null,"step_details":{"type":"tool_calls","tool_calls":[]},"usage":null}
          
          event: thread.run.step.delta
          data: {"id":"step_001","object":"thread.run.step.delta","delta":{"step_details":{"type":"tool_calls","tool_calls":[{"index":0,"id":"call_XXNp8YGaFrjrSjgqxtC8JJ1B","type":"function","function":{"name":"get_current_weather","arguments":"","output":null}}]}}}
          
          event: thread.run.step.delta
          data: {"id":"step_001","object":"thread.run.step.delta","delta":{"step_details":{"type":"tool_calls","tool_calls":[{"index":0,"type":"function","function":{"arguments":"{""}}]}}}
          
          event: thread.run.step.delta
          data: {"id":"step_001","object":"thread.run.step.delta","delta":{"step_details":{"type":"tool_calls","tool_calls":[{"index":0,"type":"function","function":{"arguments":"location"}}]}}}
          
          ...
          
          event: thread.run.step.delta
          data: {"id":"step_001","object":"thread.run.step.delta","delta":{"step_details":{"type":"tool_calls","tool_calls":[{"index":0,"type":"function","function":{"arguments":"ahrenheit"}}]}}}
          
          event: thread.run.step.delta
          data: {"id":"step_001","object":"thread.run.step.delta","delta":{"step_details":{"type":"tool_calls","tool_calls":[{"index":0,"type":"function","function":{"arguments":""}"}}]}}}
          
          event: thread.run.requires_action
          data: {"id":"run_123","object":"thread.run","created_at":1710351818,"assistant_id":"asst_123","thread_id":"thread_123","status":"requires_action","started_at":1710351818,"expires_at":1710352418,"cancelled_at":null,"failed_at":null,"completed_at":null,"required_action":{"type":"submit_tool_outputs","submit_tool_outputs":{"tool_calls":[{"id":"call_XXNp8YGaFrjrSjgqxtC8JJ1B","type":"function","function":{"name":"get_current_weather","arguments":"{"location":"San Francisco, CA","unit":"fahrenheit"}"}}]}},"last_error":null,"model":"gpt-4o","instructions":null,"tools":[{"type":"function","function":{"name":"get_current_weather","description":"Get the current weather in a given location","parameters":{"type":"object","properties":{"location":{"type":"string","description":"The city and state, e.g. San Francisco, CA"},"unit":{"type":"string","enum":["celsius","fahrenheit"]}},"required":["location"]}}}],"metadata":{},"temperature":1.0,"top_p":1.0,"max_completion_tokens":null,"max_prompt_tokens":null,"truncation_strategy":{"type":"auto","last_messages":null},"incomplete_details":null,"usage":{"prompt_tokens":345,"completion_tokens":11,"total_tokens":356},"response_format":"auto","tool_choice":"auto","parallel_tool_calls":true}}
          
          event: done
          data: [DONE]
          
          """,
      }
    ],
  }
);

@@extension(
  Azure.AI.Projects.Threads.deleteThread,
  "x-oaiMeta",
  #{
    name: "Delete thread",
    group: "threads",
    beta: true,
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/threads/thread_abc123 \\
            -H "Content-Type: application/json" \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "OpenAI-Beta: assistants=v2" \\
            -X DELETE
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          thread_deleted = client.beta.threads.delete(
              "thread_id",
          )
          print(thread_deleted.id)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          async function main() {
            const response = await openai.beta.threads.delete("thread_abc123");
          
            console.log(response);
          }
          main();
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const threadDeleted = await client.beta.threads.delete('thread_id');
          
          console.log(threadDeleted.id);
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
          	threadDeleted, err := client.Beta.Threads.Delete(context.TODO(), "thread_id")
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", threadDeleted.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.beta.threads.ThreadDeleteParams;
          import com.openai.models.beta.threads.ThreadDeleted;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  ThreadDeleted threadDeleted = client.beta().threads().delete("thread_id");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          thread_deleted = openai.beta.threads.delete("thread_id")
          
          puts(thread_deleted)
          """,
      },
      response: """
        {
          "id": "thread_abc123",
          "object": "thread.deleted",
          "deleted": true
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Threads.getThread,
  "x-oaiMeta",
  #{
    name: "Retrieve thread",
    group: "threads",
    beta: true,
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/threads/thread_abc123 \\
            -H "Content-Type: application/json" \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "OpenAI-Beta: assistants=v2"
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          thread = client.beta.threads.retrieve(
              "thread_id",
          )
          print(thread.id)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          async function main() {
            const myThread = await openai.beta.threads.retrieve(
              "thread_abc123"
            );
          
            console.log(myThread);
          }
          
          main();
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const thread = await client.beta.threads.retrieve('thread_id');
          
          console.log(thread.id);
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
          	thread, err := client.Beta.Threads.Get(context.TODO(), "thread_id")
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", thread.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.beta.threads.Thread;
          import com.openai.models.beta.threads.ThreadRetrieveParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  Thread thread = client.beta().threads().retrieve("thread_id");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          thread = openai.beta.threads.retrieve("thread_id")
          
          puts(thread)
          """,
      },
      response: """
        {
          "id": "thread_abc123",
          "object": "thread",
          "created_at": 1699014083,
          "metadata": {},
          "tool_resources": {
            "code_interpreter": {
              "file_ids": []
            }
          }
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Threads.modifyThread,
  "x-oaiMeta",
  #{
    name: "Modify thread",
    group: "threads",
    beta: true,
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/threads/thread_abc123 \\
            -H "Content-Type: application/json" \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "OpenAI-Beta: assistants=v2" \\
            -d '{
                "metadata": {
                  "modified": "true",
                  "user": "abc123"
                }
              }'
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          thread = client.beta.threads.update(
              thread_id="thread_id",
          )
          print(thread.id)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          async function main() {
            const updatedThread = await openai.beta.threads.update(
              "thread_abc123",
              {
                metadata: { modified: "true", user: "abc123" },
              }
            );
          
            console.log(updatedThread);
          }
          
          main();
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const thread = await client.beta.threads.update('thread_id');
          
          console.log(thread.id);
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
          	thread, err := client.Beta.Threads.Update(
          		context.TODO(),
          		"thread_id",
          		openai.BetaThreadUpdateParams{},
          	)
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", thread.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.beta.threads.Thread;
          import com.openai.models.beta.threads.ThreadUpdateParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  Thread thread = client.beta().threads().update("thread_id");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          thread = openai.beta.threads.update("thread_id")
          
          puts(thread)
          """,
      },
      response: """
        {
          "id": "thread_abc123",
          "object": "thread",
          "created_at": 1699014083,
          "metadata": {
            "modified": "true",
            "user": "abc123"
          },
          "tool_resources": {}
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Threads.listMessages,
  "x-oaiMeta",
  #{
    name: "List messages",
    group: "threads",
    beta: true,
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/threads/thread_abc123/messages \\
            -H "Content-Type: application/json" \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "OpenAI-Beta: assistants=v2"
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          page = client.beta.threads.messages.list(
              thread_id="thread_id",
          )
          page = page.data[0]
          print(page.id)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          async function main() {
            const threadMessages = await openai.beta.threads.messages.list(
              "thread_abc123"
            );
          
            console.log(threadMessages.data);
          }
          
          main();
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          // Automatically fetches more pages as needed.
          for await (const message of client.beta.threads.messages.list('thread_id')) {
            console.log(message.id);
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
          	page, err := client.Beta.Threads.Messages.List(
          		context.TODO(),
          		"thread_id",
          		openai.BetaThreadMessageListParams{},
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
          import com.openai.models.beta.threads.messages.MessageListPage;
          import com.openai.models.beta.threads.messages.MessageListParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  MessageListPage page = client.beta().threads().messages().list("thread_id");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          page = openai.beta.threads.messages.list("thread_id")
          
          puts(page)
          """,
      },
      response: """
        {
          "object": "list",
          "data": [
            {
              "id": "msg_abc123",
              "object": "thread.message",
              "created_at": 1699016383,
              "assistant_id": null,
              "thread_id": "thread_abc123",
              "run_id": null,
              "role": "user",
              "content": [
                {
                  "type": "text",
                  "text": {
                    "value": "How does AI work? Explain it in simple terms.",
                    "annotations": []
                  }
                }
              ],
              "attachments": [],
              "metadata": {}
            },
            {
              "id": "msg_abc456",
              "object": "thread.message",
              "created_at": 1699016383,
              "assistant_id": null,
              "thread_id": "thread_abc123",
              "run_id": null,
              "role": "user",
              "content": [
                {
                  "type": "text",
                  "text": {
                    "value": "Hello, what is AI?",
                    "annotations": []
                  }
                }
              ],
              "attachments": [],
              "metadata": {}
            }
          ],
          "first_id": "msg_abc123",
          "last_id": "msg_abc456",
          "has_more": false
        }
        
        """,
    },
  }
);

@@extension(Azure.AI.Projects.Threads.listMessages, "x-ms-list", true);

@@extension(
  Azure.AI.Projects.Threads.createMessage,
  "x-oaiMeta",
  #{
    name: "Create message",
    group: "threads",
    beta: true,
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/threads/thread_abc123/messages \\
            -H "Content-Type: application/json" \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "OpenAI-Beta: assistants=v2" \\
            -d '{
                "role": "user",
                "content": "How does AI work? Explain it in simple terms."
              }'
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          message = client.beta.threads.messages.create(
              thread_id="thread_id",
              content="string",
              role="user",
          )
          print(message.id)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          async function main() {
            const threadMessages = await openai.beta.threads.messages.create(
              "thread_abc123",
              { role: "user", content: "How does AI work? Explain it in simple terms." }
            );
          
            console.log(threadMessages);
          }
          
          main();
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const message = await client.beta.threads.messages.create('thread_id', {
            content: 'string',
            role: 'user',
          });
          
          console.log(message.id);
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
          	message, err := client.Beta.Threads.Messages.New(
          		context.TODO(),
          		"thread_id",
          		openai.BetaThreadMessageNewParams{
          			Content: openai.BetaThreadMessageNewParamsContentUnion{
          				OfString: openai.String("string"),
          			},
          			Role: openai.BetaThreadMessageNewParamsRoleUser,
          		},
          	)
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", message.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.beta.threads.messages.Message;
          import com.openai.models.beta.threads.messages.MessageCreateParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  MessageCreateParams params = MessageCreateParams.builder()
                      .threadId("thread_id")
                      .content("string")
                      .role(MessageCreateParams.Role.USER)
                      .build();
                  Message message = client.beta().threads().messages().create(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          message = openai.beta.threads.messages.create("thread_id", content: "string", role: :user)
          
          puts(message)
          """,
      },
      response: """
        {
          "id": "msg_abc123",
          "object": "thread.message",
          "created_at": 1713226573,
          "assistant_id": null,
          "thread_id": "thread_abc123",
          "run_id": null,
          "role": "user",
          "content": [
            {
              "type": "text",
              "text": {
                "value": "How does AI work? Explain it in simple terms.",
                "annotations": []
              }
            }
          ],
          "attachments": [],
          "metadata": {}
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Threads.deleteMessage,
  "x-oaiMeta",
  #{
    name: "Delete message",
    group: "threads",
    beta: true,
    examples: #{
      request: #{
        curl: """
          curl -X DELETE https://api.openai.com/v1/threads/thread_abc123/messages/msg_abc123 \\
            -H "Content-Type: application/json" \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "OpenAI-Beta: assistants=v2"
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          message_deleted = client.beta.threads.messages.delete(
              message_id="message_id",
              thread_id="thread_id",
          )
          print(message_deleted.id)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          async function main() {
            const deletedMessage = await openai.beta.threads.messages.delete(
              "msg_abc123",
              { thread_id: "thread_abc123" }
            );
          
            console.log(deletedMessage);
          }
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const messageDeleted = await client.beta.threads.messages.delete('message_id', {
            thread_id: 'thread_id',
          });
          
          console.log(messageDeleted.id);
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
          	messageDeleted, err := client.Beta.Threads.Messages.Delete(
          		context.TODO(),
          		"thread_id",
          		"message_id",
          	)
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", messageDeleted.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.beta.threads.messages.MessageDeleteParams;
          import com.openai.models.beta.threads.messages.MessageDeleted;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  MessageDeleteParams params = MessageDeleteParams.builder()
                      .threadId("thread_id")
                      .messageId("message_id")
                      .build();
                  MessageDeleted messageDeleted = client.beta().threads().messages().delete(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          message_deleted = openai.beta.threads.messages.delete("message_id", thread_id: "thread_id")
          
          puts(message_deleted)
          """,
      },
      response: """
        {
          "id": "msg_abc123",
          "object": "thread.message.deleted",
          "deleted": true
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Threads.getMessage,
  "x-oaiMeta",
  #{
    name: "Retrieve message",
    group: "threads",
    beta: true,
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/threads/thread_abc123/messages/msg_abc123 \\
            -H "Content-Type: application/json" \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "OpenAI-Beta: assistants=v2"
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          message = client.beta.threads.messages.retrieve(
              message_id="message_id",
              thread_id="thread_id",
          )
          print(message.id)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          async function main() {
            const message = await openai.beta.threads.messages.retrieve(
              "msg_abc123",
              { thread_id: "thread_abc123" }
            );
          
            console.log(message);
          }
          
          main();
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const message = await client.beta.threads.messages.retrieve('message_id', {
            thread_id: 'thread_id',
          });
          
          console.log(message.id);
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
          	message, err := client.Beta.Threads.Messages.Get(
          		context.TODO(),
          		"thread_id",
          		"message_id",
          	)
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", message.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.beta.threads.messages.Message;
          import com.openai.models.beta.threads.messages.MessageRetrieveParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  MessageRetrieveParams params = MessageRetrieveParams.builder()
                      .threadId("thread_id")
                      .messageId("message_id")
                      .build();
                  Message message = client.beta().threads().messages().retrieve(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          message = openai.beta.threads.messages.retrieve("message_id", thread_id: "thread_id")
          
          puts(message)
          """,
      },
      response: """
        {
          "id": "msg_abc123",
          "object": "thread.message",
          "created_at": 1699017614,
          "assistant_id": null,
          "thread_id": "thread_abc123",
          "run_id": null,
          "role": "user",
          "content": [
            {
              "type": "text",
              "text": {
                "value": "How does AI work? Explain it in simple terms.",
                "annotations": []
              }
            }
          ],
          "attachments": [],
          "metadata": {}
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Threads.modifyMessage,
  "x-oaiMeta",
  #{
    name: "Modify message",
    group: "threads",
    beta: true,
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/threads/thread_abc123/messages/msg_abc123 \\
            -H "Content-Type: application/json" \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "OpenAI-Beta: assistants=v2" \\
            -d '{
                "metadata": {
                  "modified": "true",
                  "user": "abc123"
                }
              }'
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          message = client.beta.threads.messages.update(
              message_id="message_id",
              thread_id="thread_id",
          )
          print(message.id)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          async function main() {
            const message = await openai.beta.threads.messages.update(
              "thread_abc123",
              "msg_abc123",
              {
                metadata: {
                  modified: "true",
                  user: "abc123",
                },
              }
            }'
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const message = await client.beta.threads.messages.update('message_id', { thread_id: 'thread_id' });
          
          console.log(message.id);
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
          	message, err := client.Beta.Threads.Messages.Update(
          		context.TODO(),
          		"thread_id",
          		"message_id",
          		openai.BetaThreadMessageUpdateParams{},
          	)
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", message.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.beta.threads.messages.Message;
          import com.openai.models.beta.threads.messages.MessageUpdateParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  MessageUpdateParams params = MessageUpdateParams.builder()
                      .threadId("thread_id")
                      .messageId("message_id")
                      .build();
                  Message message = client.beta().threads().messages().update(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          message = openai.beta.threads.messages.update("message_id", thread_id: "thread_id")
          
          puts(message)
          """,
      },
      response: """
        {
          "id": "msg_abc123",
          "object": "thread.message",
          "created_at": 1699017614,
          "assistant_id": null,
          "thread_id": "thread_abc123",
          "run_id": null,
          "role": "user",
          "content": [
            {
              "type": "text",
              "text": {
                "value": "How does AI work? Explain it in simple terms.",
                "annotations": []
              }
            }
          ],
          "file_ids": [],
          "metadata": {
            "modified": "true",
            "user": "abc123"
          }
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Threads.listRuns,
  "x-oaiMeta",
  #{
    name: "List runs",
    group: "threads",
    beta: true,
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/threads/thread_abc123/runs \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "Content-Type: application/json" \\
            -H "OpenAI-Beta: assistants=v2"
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          page = client.beta.threads.runs.list(
              thread_id="thread_id",
          )
          page = page.data[0]
          print(page.id)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          async function main() {
            const runs = await openai.beta.threads.runs.list(
              "thread_abc123"
            );
          
            console.log(runs);
          }
          
          main();
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          // Automatically fetches more pages as needed.
          for await (const run of client.beta.threads.runs.list('thread_id')) {
            console.log(run.id);
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
          	page, err := client.Beta.Threads.Runs.List(
          		context.TODO(),
          		"thread_id",
          		openai.BetaThreadRunListParams{},
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
          import com.openai.models.beta.threads.runs.RunListPage;
          import com.openai.models.beta.threads.runs.RunListParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  RunListPage page = client.beta().threads().runs().list("thread_id");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          page = openai.beta.threads.runs.list("thread_id")
          
          puts(page)
          """,
      },
      response: """
        {
          "object": "list",
          "data": [
            {
              "id": "run_abc123",
              "object": "thread.run",
              "created_at": 1699075072,
              "assistant_id": "asst_abc123",
              "thread_id": "thread_abc123",
              "status": "completed",
              "started_at": 1699075072,
              "expires_at": null,
              "cancelled_at": null,
              "failed_at": null,
              "completed_at": 1699075073,
              "last_error": null,
              "model": "gpt-4o",
              "instructions": null,
              "incomplete_details": null,
              "tools": [
                {
                  "type": "code_interpreter"
                }
              ],
              "tool_resources": {
                "code_interpreter": {
                  "file_ids": [
                    "file-abc123",
                    "file-abc456"
                  ]
                }
              },
              "metadata": {},
              "usage": {
                "prompt_tokens": 123,
                "completion_tokens": 456,
                "total_tokens": 579
              },
              "temperature": 1.0,
              "top_p": 1.0,
              "max_prompt_tokens": 1000,
              "max_completion_tokens": 1000,
              "truncation_strategy": {
                "type": "auto",
                "last_messages": null
              },
              "response_format": "auto",
              "tool_choice": "auto",
              "parallel_tool_calls": true
            },
            {
              "id": "run_abc456",
              "object": "thread.run",
              "created_at": 1699063290,
              "assistant_id": "asst_abc123",
              "thread_id": "thread_abc123",
              "status": "completed",
              "started_at": 1699063290,
              "expires_at": null,
              "cancelled_at": null,
              "failed_at": null,
              "completed_at": 1699063291,
              "last_error": null,
              "model": "gpt-4o",
              "instructions": null,
              "incomplete_details": null,
              "tools": [
                {
                  "type": "code_interpreter"
                }
              ],
              "tool_resources": {
                "code_interpreter": {
                  "file_ids": [
                    "file-abc123",
                    "file-abc456"
                  ]
                }
              },
              "metadata": {},
              "usage": {
                "prompt_tokens": 123,
                "completion_tokens": 456,
                "total_tokens": 579
              },
              "temperature": 1.0,
              "top_p": 1.0,
              "max_prompt_tokens": 1000,
              "max_completion_tokens": 1000,
              "truncation_strategy": {
                "type": "auto",
                "last_messages": null
              },
              "response_format": "auto",
              "tool_choice": "auto",
              "parallel_tool_calls": true
            }
          ],
          "first_id": "run_abc123",
          "last_id": "run_abc456",
          "has_more": false
        }
        
        """,
    },
  }
);

@@extension(Azure.AI.Projects.Threads.listRuns, "x-ms-list", true);

@@extension(
  Azure.AI.Projects.Threads.createRun,
  "x-oaiMeta",
  #{
    name: "Create run",
    group: "threads",
    beta: true,
    examples: #[
      #{
        title: "Default",
        request: #{
          curl: """
            curl https://api.openai.com/v1/threads/thread_abc123/runs \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -H "Content-Type: application/json" \\
              -H "OpenAI-Beta: assistants=v2" \\
              -d '{
                "assistant_id": "asst_abc123"
              }'
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            for run in client.beta.threads.runs.create(
                thread_id="thread_id",
                assistant_id="assistant_id",
            ):
              print(run)
            """,
          javascript: """
            import OpenAI from "openai";
            
            const openai = new OpenAI();
            
            async function main() {
              const run = await openai.beta.threads.runs.create(
                "thread_abc123",
                { assistant_id: "asst_abc123" }
              );
            
              console.log(run);
            }
            
            main();
            
            """,
          `node.js`: """
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const run = await client.beta.threads.runs.create('thread_id', { assistant_id: 'assistant_id' });
            
            console.log(run.id);
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
            	run, err := client.Beta.Threads.Runs.New(
            		context.TODO(),
            		"thread_id",
            		openai.BetaThreadRunNewParams{
            			AssistantID: "assistant_id",
            		},
            	)
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", run.ID)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.beta.threads.runs.Run;
            import com.openai.models.beta.threads.runs.RunCreateParams;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    RunCreateParams params = RunCreateParams.builder()
                        .threadId("thread_id")
                        .assistantId("assistant_id")
                        .build();
                    Run run = client.beta().threads().runs().create(params);
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            run = openai.beta.threads.runs.create("thread_id", assistant_id: "assistant_id")
            
            puts(run)
            """,
        },
        response: """
          {
            "id": "run_abc123",
            "object": "thread.run",
            "created_at": 1699063290,
            "assistant_id": "asst_abc123",
            "thread_id": "thread_abc123",
            "status": "queued",
            "started_at": 1699063290,
            "expires_at": null,
            "cancelled_at": null,
            "failed_at": null,
            "completed_at": 1699063291,
            "last_error": null,
            "model": "gpt-4o",
            "instructions": null,
            "incomplete_details": null,
            "tools": [
              {
                "type": "code_interpreter"
              }
            ],
            "metadata": {},
            "usage": null,
            "temperature": 1.0,
            "top_p": 1.0,
            "max_prompt_tokens": 1000,
            "max_completion_tokens": 1000,
            "truncation_strategy": {
              "type": "auto",
              "last_messages": null
            },
            "response_format": "auto",
            "tool_choice": "auto",
            "parallel_tool_calls": true
          }
          
          """,
      },
      #{
        title: "Streaming",
        request: #{
          curl: """
            curl https://api.openai.com/v1/threads/thread_123/runs \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -H "Content-Type: application/json" \\
              -H "OpenAI-Beta: assistants=v2" \\
              -d '{
                "assistant_id": "asst_123",
                "stream": true
              }'
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            for run in client.beta.threads.runs.create(
                thread_id="thread_id",
                assistant_id="assistant_id",
            ):
              print(run)
            """,
          javascript: """
            import OpenAI from "openai";
            
            const openai = new OpenAI();
            
            async function main() {
              const stream = await openai.beta.threads.runs.create(
                "thread_123",
                { assistant_id: "asst_123", stream: true }
              );
            
              for await (const event of stream) {
                console.log(event);
              }
            }
            
            main();
            
            """,
          `node.js`: """
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const run = await client.beta.threads.runs.create('thread_id', { assistant_id: 'assistant_id' });
            
            console.log(run.id);
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
            	run, err := client.Beta.Threads.Runs.New(
            		context.TODO(),
            		"thread_id",
            		openai.BetaThreadRunNewParams{
            			AssistantID: "assistant_id",
            		},
            	)
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", run.ID)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.beta.threads.runs.Run;
            import com.openai.models.beta.threads.runs.RunCreateParams;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    RunCreateParams params = RunCreateParams.builder()
                        .threadId("thread_id")
                        .assistantId("assistant_id")
                        .build();
                    Run run = client.beta().threads().runs().create(params);
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            run = openai.beta.threads.runs.create("thread_id", assistant_id: "assistant_id")
            
            puts(run)
            """,
        },
        response: """
          event: thread.run.created
          data: {"id":"run_123","object":"thread.run","created_at":1710330640,"assistant_id":"asst_123","thread_id":"thread_123","status":"queued","started_at":null,"expires_at":1710331240,"cancelled_at":null,"failed_at":null,"completed_at":null,"required_action":null,"last_error":null,"model":"gpt-4o","instructions":null,"tools":[],"metadata":{},"temperature":1.0,"top_p":1.0,"max_completion_tokens":null,"max_prompt_tokens":null,"truncation_strategy":{"type":"auto","last_messages":null},"incomplete_details":null,"usage":null,"response_format":"auto","tool_choice":"auto","parallel_tool_calls":true}}
          
          event: thread.run.queued
          data: {"id":"run_123","object":"thread.run","created_at":1710330640,"assistant_id":"asst_123","thread_id":"thread_123","status":"queued","started_at":null,"expires_at":1710331240,"cancelled_at":null,"failed_at":null,"completed_at":null,"required_action":null,"last_error":null,"model":"gpt-4o","instructions":null,"tools":[],"metadata":{},"temperature":1.0,"top_p":1.0,"max_completion_tokens":null,"max_prompt_tokens":null,"truncation_strategy":{"type":"auto","last_messages":null},"incomplete_details":null,"usage":null,"response_format":"auto","tool_choice":"auto","parallel_tool_calls":true}}
          
          event: thread.run.in_progress
          data: {"id":"run_123","object":"thread.run","created_at":1710330640,"assistant_id":"asst_123","thread_id":"thread_123","status":"in_progress","started_at":1710330641,"expires_at":1710331240,"cancelled_at":null,"failed_at":null,"completed_at":null,"required_action":null,"last_error":null,"model":"gpt-4o","instructions":null,"tools":[],"metadata":{},"temperature":1.0,"top_p":1.0,"max_completion_tokens":null,"max_prompt_tokens":null,"truncation_strategy":{"type":"auto","last_messages":null},"incomplete_details":null,"usage":null,"response_format":"auto","tool_choice":"auto","parallel_tool_calls":true}}
          
          event: thread.run.step.created
          data: {"id":"step_001","object":"thread.run.step","created_at":1710330641,"run_id":"run_123","assistant_id":"asst_123","thread_id":"thread_123","type":"message_creation","status":"in_progress","cancelled_at":null,"completed_at":null,"expires_at":1710331240,"failed_at":null,"last_error":null,"step_details":{"type":"message_creation","message_creation":{"message_id":"msg_001"}},"usage":null}
          
          event: thread.run.step.in_progress
          data: {"id":"step_001","object":"thread.run.step","created_at":1710330641,"run_id":"run_123","assistant_id":"asst_123","thread_id":"thread_123","type":"message_creation","status":"in_progress","cancelled_at":null,"completed_at":null,"expires_at":1710331240,"failed_at":null,"last_error":null,"step_details":{"type":"message_creation","message_creation":{"message_id":"msg_001"}},"usage":null}
          
          event: thread.message.created
          data: {"id":"msg_001","object":"thread.message","created_at":1710330641,"assistant_id":"asst_123","thread_id":"thread_123","run_id":"run_123","status":"in_progress","incomplete_details":null,"incomplete_at":null,"completed_at":null,"role":"assistant","content":[],"metadata":{}}
          
          event: thread.message.in_progress
          data: {"id":"msg_001","object":"thread.message","created_at":1710330641,"assistant_id":"asst_123","thread_id":"thread_123","run_id":"run_123","status":"in_progress","incomplete_details":null,"incomplete_at":null,"completed_at":null,"role":"assistant","content":[],"metadata":{}}
          
          event: thread.message.delta
          data: {"id":"msg_001","object":"thread.message.delta","delta":{"content":[{"index":0,"type":"text","text":{"value":"Hello","annotations":[]}}]}}
          
          ...
          
          event: thread.message.delta
          data: {"id":"msg_001","object":"thread.message.delta","delta":{"content":[{"index":0,"type":"text","text":{"value":" today"}}]}}
          
          event: thread.message.delta
          data: {"id":"msg_001","object":"thread.message.delta","delta":{"content":[{"index":0,"type":"text","text":{"value":"?"}}]}}
          
          event: thread.message.completed
          data: {"id":"msg_001","object":"thread.message","created_at":1710330641,"assistant_id":"asst_123","thread_id":"thread_123","run_id":"run_123","status":"completed","incomplete_details":null,"incomplete_at":null,"completed_at":1710330642,"role":"assistant","content":[{"type":"text","text":{"value":"Hello! How can I assist you today?","annotations":[]}}],"metadata":{}}
          
          event: thread.run.step.completed
          data: {"id":"step_001","object":"thread.run.step","created_at":1710330641,"run_id":"run_123","assistant_id":"asst_123","thread_id":"thread_123","type":"message_creation","status":"completed","cancelled_at":null,"completed_at":1710330642,"expires_at":1710331240,"failed_at":null,"last_error":null,"step_details":{"type":"message_creation","message_creation":{"message_id":"msg_001"}},"usage":{"prompt_tokens":20,"completion_tokens":11,"total_tokens":31}}
          
          event: thread.run.completed
          data: {"id":"run_123","object":"thread.run","created_at":1710330640,"assistant_id":"asst_123","thread_id":"thread_123","status":"completed","started_at":1710330641,"expires_at":null,"cancelled_at":null,"failed_at":null,"completed_at":1710330642,"required_action":null,"last_error":null,"model":"gpt-4o","instructions":null,"tools":[],"metadata":{},"temperature":1.0,"top_p":1.0,"max_completion_tokens":null,"max_prompt_tokens":null,"truncation_strategy":{"type":"auto","last_messages":null},"incomplete_details":null,"usage":{"prompt_tokens":20,"completion_tokens":11,"total_tokens":31},"response_format":"auto","tool_choice":"auto","parallel_tool_calls":true}}
          
          event: done
          data: [DONE]
          
          """,
      },
      #{
        title: "Streaming with Functions",
        request: #{
          curl: """
            curl https://api.openai.com/v1/threads/thread_abc123/runs \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -H "Content-Type: application/json" \\
              -H "OpenAI-Beta: assistants=v2" \\
              -d '{
                "assistant_id": "asst_abc123",
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
                "stream": true
              }'
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            for run in client.beta.threads.runs.create(
                thread_id="thread_id",
                assistant_id="assistant_id",
            ):
              print(run)
            """,
          javascript: """
            import OpenAI from "openai";
            
            const openai = new OpenAI();
            
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
            
            async function main() {
              const stream = await openai.beta.threads.runs.create(
                "thread_abc123",
                {
                  assistant_id: "asst_abc123",
                  tools: tools,
                  stream: true
                }
              );
            
              for await (const event of stream) {
                console.log(event);
              }
            }
            
            main();
            
            """,
          `node.js`: """
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const run = await client.beta.threads.runs.create('thread_id', { assistant_id: 'assistant_id' });
            
            console.log(run.id);
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
            	run, err := client.Beta.Threads.Runs.New(
            		context.TODO(),
            		"thread_id",
            		openai.BetaThreadRunNewParams{
            			AssistantID: "assistant_id",
            		},
            	)
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", run.ID)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.beta.threads.runs.Run;
            import com.openai.models.beta.threads.runs.RunCreateParams;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    RunCreateParams params = RunCreateParams.builder()
                        .threadId("thread_id")
                        .assistantId("assistant_id")
                        .build();
                    Run run = client.beta().threads().runs().create(params);
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            run = openai.beta.threads.runs.create("thread_id", assistant_id: "assistant_id")
            
            puts(run)
            """,
        },
        response: """
          event: thread.run.created
          data: {"id":"run_123","object":"thread.run","created_at":1710348075,"assistant_id":"asst_123","thread_id":"thread_123","status":"queued","started_at":null,"expires_at":1710348675,"cancelled_at":null,"failed_at":null,"completed_at":null,"required_action":null,"last_error":null,"model":"gpt-4o","instructions":null,"tools":[],"metadata":{},"temperature":1.0,"top_p":1.0,"max_completion_tokens":null,"max_prompt_tokens":null,"truncation_strategy":{"type":"auto","last_messages":null},"incomplete_details":null,"usage":null,"response_format":"auto","tool_choice":"auto","parallel_tool_calls":true}}
          
          event: thread.run.queued
          data: {"id":"run_123","object":"thread.run","created_at":1710348075,"assistant_id":"asst_123","thread_id":"thread_123","status":"queued","started_at":null,"expires_at":1710348675,"cancelled_at":null,"failed_at":null,"completed_at":null,"required_action":null,"last_error":null,"model":"gpt-4o","instructions":null,"tools":[],"metadata":{},"temperature":1.0,"top_p":1.0,"max_completion_tokens":null,"max_prompt_tokens":null,"truncation_strategy":{"type":"auto","last_messages":null},"incomplete_details":null,"usage":null,"response_format":"auto","tool_choice":"auto","parallel_tool_calls":true}}
          
          event: thread.run.in_progress
          data: {"id":"run_123","object":"thread.run","created_at":1710348075,"assistant_id":"asst_123","thread_id":"thread_123","status":"in_progress","started_at":1710348075,"expires_at":1710348675,"cancelled_at":null,"failed_at":null,"completed_at":null,"required_action":null,"last_error":null,"model":"gpt-4o","instructions":null,"tools":[],"metadata":{},"temperature":1.0,"top_p":1.0,"max_completion_tokens":null,"max_prompt_tokens":null,"truncation_strategy":{"type":"auto","last_messages":null},"incomplete_details":null,"usage":null,"response_format":"auto","tool_choice":"auto","parallel_tool_calls":true}}
          
          event: thread.run.step.created
          data: {"id":"step_001","object":"thread.run.step","created_at":1710348076,"run_id":"run_123","assistant_id":"asst_123","thread_id":"thread_123","type":"message_creation","status":"in_progress","cancelled_at":null,"completed_at":null,"expires_at":1710348675,"failed_at":null,"last_error":null,"step_details":{"type":"message_creation","message_creation":{"message_id":"msg_001"}},"usage":null}
          
          event: thread.run.step.in_progress
          data: {"id":"step_001","object":"thread.run.step","created_at":1710348076,"run_id":"run_123","assistant_id":"asst_123","thread_id":"thread_123","type":"message_creation","status":"in_progress","cancelled_at":null,"completed_at":null,"expires_at":1710348675,"failed_at":null,"last_error":null,"step_details":{"type":"message_creation","message_creation":{"message_id":"msg_001"}},"usage":null}
          
          event: thread.message.created
          data: {"id":"msg_001","object":"thread.message","created_at":1710348076,"assistant_id":"asst_123","thread_id":"thread_123","run_id":"run_123","status":"in_progress","incomplete_details":null,"incomplete_at":null,"completed_at":null,"role":"assistant","content":[],"metadata":{}}
          
          event: thread.message.in_progress
          data: {"id":"msg_001","object":"thread.message","created_at":1710348076,"assistant_id":"asst_123","thread_id":"thread_123","run_id":"run_123","status":"in_progress","incomplete_details":null,"incomplete_at":null,"completed_at":null,"role":"assistant","content":[],"metadata":{}}
          
          event: thread.message.delta
          data: {"id":"msg_001","object":"thread.message.delta","delta":{"content":[{"index":0,"type":"text","text":{"value":"Hello","annotations":[]}}]}}
          
          ...
          
          event: thread.message.delta
          data: {"id":"msg_001","object":"thread.message.delta","delta":{"content":[{"index":0,"type":"text","text":{"value":" today"}}]}}
          
          event: thread.message.delta
          data: {"id":"msg_001","object":"thread.message.delta","delta":{"content":[{"index":0,"type":"text","text":{"value":"?"}}]}}
          
          event: thread.message.completed
          data: {"id":"msg_001","object":"thread.message","created_at":1710348076,"assistant_id":"asst_123","thread_id":"thread_123","run_id":"run_123","status":"completed","incomplete_details":null,"incomplete_at":null,"completed_at":1710348077,"role":"assistant","content":[{"type":"text","text":{"value":"Hello! How can I assist you today?","annotations":[]}}],"metadata":{}}
          
          event: thread.run.step.completed
          data: {"id":"step_001","object":"thread.run.step","created_at":1710348076,"run_id":"run_123","assistant_id":"asst_123","thread_id":"thread_123","type":"message_creation","status":"completed","cancelled_at":null,"completed_at":1710348077,"expires_at":1710348675,"failed_at":null,"last_error":null,"step_details":{"type":"message_creation","message_creation":{"message_id":"msg_001"}},"usage":{"prompt_tokens":20,"completion_tokens":11,"total_tokens":31}}
          
          event: thread.run.completed
          data: {"id":"run_123","object":"thread.run","created_at":1710348075,"assistant_id":"asst_123","thread_id":"thread_123","status":"completed","started_at":1710348075,"expires_at":null,"cancelled_at":null,"failed_at":null,"completed_at":1710348077,"required_action":null,"last_error":null,"model":"gpt-4o","instructions":null,"tools":[],"metadata":{},"temperature":1.0,"top_p":1.0,"max_completion_tokens":null,"max_prompt_tokens":null,"truncation_strategy":{"type":"auto","last_messages":null},"incomplete_details":null,"usage":{"prompt_tokens":20,"completion_tokens":11,"total_tokens":31},"response_format":"auto","tool_choice":"auto","parallel_tool_calls":true}}
          
          event: done
          data: [DONE]
          
          """,
      }
    ],
  }
);

@@extension(
  Azure.AI.Projects.Threads.getRun,
  "x-oaiMeta",
  #{
    name: "Retrieve run",
    group: "threads",
    beta: true,
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/threads/thread_abc123/runs/run_abc123 \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "OpenAI-Beta: assistants=v2"
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          run = client.beta.threads.runs.retrieve(
              run_id="run_id",
              thread_id="thread_id",
          )
          print(run.id)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          async function main() {
            const run = await openai.beta.threads.runs.retrieve(
              "run_abc123",
              { thread_id: "thread_abc123" }
            );
          
            console.log(run);
          }
          
          main();
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const run = await client.beta.threads.runs.retrieve('run_id', { thread_id: 'thread_id' });
          
          console.log(run.id);
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
          	run, err := client.Beta.Threads.Runs.Get(
          		context.TODO(),
          		"thread_id",
          		"run_id",
          	)
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", run.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.beta.threads.runs.Run;
          import com.openai.models.beta.threads.runs.RunRetrieveParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  RunRetrieveParams params = RunRetrieveParams.builder()
                      .threadId("thread_id")
                      .runId("run_id")
                      .build();
                  Run run = client.beta().threads().runs().retrieve(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          run = openai.beta.threads.runs.retrieve("run_id", thread_id: "thread_id")
          
          puts(run)
          """,
      },
      response: """
        {
          "id": "run_abc123",
          "object": "thread.run",
          "created_at": 1699075072,
          "assistant_id": "asst_abc123",
          "thread_id": "thread_abc123",
          "status": "completed",
          "started_at": 1699075072,
          "expires_at": null,
          "cancelled_at": null,
          "failed_at": null,
          "completed_at": 1699075073,
          "last_error": null,
          "model": "gpt-4o",
          "instructions": null,
          "incomplete_details": null,
          "tools": [
            {
              "type": "code_interpreter"
            }
          ],
          "metadata": {},
          "usage": {
            "prompt_tokens": 123,
            "completion_tokens": 456,
            "total_tokens": 579
          },
          "temperature": 1.0,
          "top_p": 1.0,
          "max_prompt_tokens": 1000,
          "max_completion_tokens": 1000,
          "truncation_strategy": {
            "type": "auto",
            "last_messages": null
          },
          "response_format": "auto",
          "tool_choice": "auto",
          "parallel_tool_calls": true
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Threads.modifyRun,
  "x-oaiMeta",
  #{
    name: "Modify run",
    group: "threads",
    beta: true,
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/threads/thread_abc123/runs/run_abc123 \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "Content-Type: application/json" \\
            -H "OpenAI-Beta: assistants=v2" \\
            -d '{
              "metadata": {
                "user_id": "user_abc123"
              }
            }'
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          run = client.beta.threads.runs.update(
              run_id="run_id",
              thread_id="thread_id",
          )
          print(run.id)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          async function main() {
            const run = await openai.beta.threads.runs.update(
              "run_abc123",
              {
                thread_id: "thread_abc123",
                metadata: {
                  user_id: "user_abc123",
                },
              }
            );
          
            console.log(run);
          }
          
          main();
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const run = await client.beta.threads.runs.update('run_id', { thread_id: 'thread_id' });
          
          console.log(run.id);
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
          	run, err := client.Beta.Threads.Runs.Update(
          		context.TODO(),
          		"thread_id",
          		"run_id",
          		openai.BetaThreadRunUpdateParams{},
          	)
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", run.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.beta.threads.runs.Run;
          import com.openai.models.beta.threads.runs.RunUpdateParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  RunUpdateParams params = RunUpdateParams.builder()
                      .threadId("thread_id")
                      .runId("run_id")
                      .build();
                  Run run = client.beta().threads().runs().update(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          run = openai.beta.threads.runs.update("run_id", thread_id: "thread_id")
          
          puts(run)
          """,
      },
      response: """
        {
          "id": "run_abc123",
          "object": "thread.run",
          "created_at": 1699075072,
          "assistant_id": "asst_abc123",
          "thread_id": "thread_abc123",
          "status": "completed",
          "started_at": 1699075072,
          "expires_at": null,
          "cancelled_at": null,
          "failed_at": null,
          "completed_at": 1699075073,
          "last_error": null,
          "model": "gpt-4o",
          "instructions": null,
          "incomplete_details": null,
          "tools": [
            {
              "type": "code_interpreter"
            }
          ],
          "tool_resources": {
            "code_interpreter": {
              "file_ids": [
                "file-abc123",
                "file-abc456"
              ]
            }
          },
          "metadata": {
            "user_id": "user_abc123"
          },
          "usage": {
            "prompt_tokens": 123,
            "completion_tokens": 456,
            "total_tokens": 579
          },
          "temperature": 1.0,
          "top_p": 1.0,
          "max_prompt_tokens": 1000,
          "max_completion_tokens": 1000,
          "truncation_strategy": {
            "type": "auto",
            "last_messages": null
          },
          "response_format": "auto",
          "tool_choice": "auto",
          "parallel_tool_calls": true
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Threads.cancelRun,
  "x-oaiMeta",
  #{
    name: "Cancel a run",
    group: "threads",
    beta: true,
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/threads/thread_abc123/runs/run_abc123/cancel \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "OpenAI-Beta: assistants=v2" \\
            -X POST
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          run = client.beta.threads.runs.cancel(
              run_id="run_id",
              thread_id="thread_id",
          )
          print(run.id)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          async function main() {
            const run = await openai.beta.threads.runs.cancel(
              "run_abc123",
              { thread_id: "thread_abc123" }
            );
          
            console.log(run);
          }
          
          main();
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const run = await client.beta.threads.runs.cancel('run_id', { thread_id: 'thread_id' });
          
          console.log(run.id);
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
          	run, err := client.Beta.Threads.Runs.Cancel(
          		context.TODO(),
          		"thread_id",
          		"run_id",
          	)
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", run.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.beta.threads.runs.Run;
          import com.openai.models.beta.threads.runs.RunCancelParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  RunCancelParams params = RunCancelParams.builder()
                      .threadId("thread_id")
                      .runId("run_id")
                      .build();
                  Run run = client.beta().threads().runs().cancel(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          run = openai.beta.threads.runs.cancel("run_id", thread_id: "thread_id")
          
          puts(run)
          """,
      },
      response: """
        {
          "id": "run_abc123",
          "object": "thread.run",
          "created_at": 1699076126,
          "assistant_id": "asst_abc123",
          "thread_id": "thread_abc123",
          "status": "cancelling",
          "started_at": 1699076126,
          "expires_at": 1699076726,
          "cancelled_at": null,
          "failed_at": null,
          "completed_at": null,
          "last_error": null,
          "model": "gpt-4o",
          "instructions": "You summarize books.",
          "tools": [
            {
              "type": "file_search"
            }
          ],
          "tool_resources": {
            "file_search": {
              "vector_store_ids": ["vs_123"]
            }
          },
          "metadata": {},
          "usage": null,
          "temperature": 1.0,
          "top_p": 1.0,
          "response_format": "auto",
          "tool_choice": "auto",
          "parallel_tool_calls": true
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Threads.listRunSteps,
  "x-oaiMeta",
  #{
    name: "List run steps",
    group: "threads",
    beta: true,
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/threads/thread_abc123/runs/run_abc123/steps \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "Content-Type: application/json" \\
            -H "OpenAI-Beta: assistants=v2"
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          page = client.beta.threads.runs.steps.list(
              run_id="run_id",
              thread_id="thread_id",
          )
          page = page.data[0]
          print(page.id)
          """,
        javascript: """
          import OpenAI from "openai";
          const openai = new OpenAI();
          
          async function main() {
            const runStep = await openai.beta.threads.runs.steps.list(
              "run_abc123",
              { thread_id: "thread_abc123" }
            );
            console.log(runStep);
          }
          
          main();
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          // Automatically fetches more pages as needed.
          for await (const runStep of client.beta.threads.runs.steps.list('run_id', {
            thread_id: 'thread_id',
          })) {
            console.log(runStep.id);
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
          	page, err := client.Beta.Threads.Runs.Steps.List(
          		context.TODO(),
          		"thread_id",
          		"run_id",
          		openai.BetaThreadRunStepListParams{},
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
          import com.openai.models.beta.threads.runs.steps.StepListPage;
          import com.openai.models.beta.threads.runs.steps.StepListParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  StepListParams params = StepListParams.builder()
                      .threadId("thread_id")
                      .runId("run_id")
                      .build();
                  StepListPage page = client.beta().threads().runs().steps().list(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          page = openai.beta.threads.runs.steps.list("run_id", thread_id: "thread_id")
          
          puts(page)
          """,
      },
      response: """
        {
          "object": "list",
          "data": [
            {
              "id": "step_abc123",
              "object": "thread.run.step",
              "created_at": 1699063291,
              "run_id": "run_abc123",
              "assistant_id": "asst_abc123",
              "thread_id": "thread_abc123",
              "type": "message_creation",
              "status": "completed",
              "cancelled_at": null,
              "completed_at": 1699063291,
              "expired_at": null,
              "failed_at": null,
              "last_error": null,
              "step_details": {
                "type": "message_creation",
                "message_creation": {
                  "message_id": "msg_abc123"
                }
              },
              "usage": {
                "prompt_tokens": 123,
                "completion_tokens": 456,
                "total_tokens": 579
              }
            }
          ],
          "first_id": "step_abc123",
          "last_id": "step_abc456",
          "has_more": false
        }
        
        """,
    },
  }
);

@@extension(Azure.AI.Projects.Threads.listRunSteps, "x-ms-list", true);

@@extension(
  Azure.AI.Projects.Threads.getRunStep,
  "x-oaiMeta",
  #{
    name: "Retrieve run step",
    group: "threads",
    beta: true,
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/threads/thread_abc123/runs/run_abc123/steps/step_abc123 \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "Content-Type: application/json" \\
            -H "OpenAI-Beta: assistants=v2"
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          run_step = client.beta.threads.runs.steps.retrieve(
              step_id="step_id",
              thread_id="thread_id",
              run_id="run_id",
          )
          print(run_step.id)
          """,
        javascript: """
          import OpenAI from "openai";
          const openai = new OpenAI();
          
          async function main() {
            const runStep = await openai.beta.threads.runs.steps.retrieve(
              "step_abc123",
              { thread_id: "thread_abc123", run_id: "run_abc123" }
            );
            console.log(runStep);
          }
          
          main();
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const runStep = await client.beta.threads.runs.steps.retrieve('step_id', {
            thread_id: 'thread_id',
            run_id: 'run_id',
          });
          
          console.log(runStep.id);
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
          	runStep, err := client.Beta.Threads.Runs.Steps.Get(
          		context.TODO(),
          		"thread_id",
          		"run_id",
          		"step_id",
          		openai.BetaThreadRunStepGetParams{},
          	)
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", runStep.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.beta.threads.runs.steps.RunStep;
          import com.openai.models.beta.threads.runs.steps.StepRetrieveParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  StepRetrieveParams params = StepRetrieveParams.builder()
                      .threadId("thread_id")
                      .runId("run_id")
                      .stepId("step_id")
                      .build();
                  RunStep runStep = client.beta().threads().runs().steps().retrieve(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          run_step = openai.beta.threads.runs.steps.retrieve("step_id", thread_id: "thread_id", run_id: "run_id")
          
          puts(run_step)
          """,
      },
      response: """
        {
          "id": "step_abc123",
          "object": "thread.run.step",
          "created_at": 1699063291,
          "run_id": "run_abc123",
          "assistant_id": "asst_abc123",
          "thread_id": "thread_abc123",
          "type": "message_creation",
          "status": "completed",
          "cancelled_at": null,
          "completed_at": 1699063291,
          "expired_at": null,
          "failed_at": null,
          "last_error": null,
          "step_details": {
            "type": "message_creation",
            "message_creation": {
              "message_id": "msg_abc123"
            }
          },
          "usage": {
            "prompt_tokens": 123,
            "completion_tokens": 456,
            "total_tokens": 579
          }
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Threads.submitToolOuputsToRun,
  "x-oaiMeta",
  #{
    name: "Submit tool outputs to run",
    group: "threads",
    beta: true,
    examples: #[
      #{
        title: "Default",
        request: #{
          curl: """
            curl https://api.openai.com/v1/threads/thread_123/runs/run_123/submit_tool_outputs \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -H "Content-Type: application/json" \\
              -H "OpenAI-Beta: assistants=v2" \\
              -d '{
                "tool_outputs": [
                  {
                    "tool_call_id": "call_001",
                    "output": "70 degrees and sunny."
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
            for run in client.beta.threads.runs.submit_tool_outputs(
                run_id="run_id",
                thread_id="thread_id",
                tool_outputs=[{}],
            ):
              print(run)
            """,
          javascript: """
            import OpenAI from "openai";
            
            const openai = new OpenAI();
            
            async function main() {
              const run = await openai.beta.threads.runs.submitToolOutputs(
                "run_123",
                {
                  thread_id: "thread_123",
                  tool_outputs: [
                    {
                      tool_call_id: "call_001",
                      output: "70 degrees and sunny.",
                    },
                  ],
                }
              );
            
              console.log(run);
            }
            
            main();
            
            """,
          `node.js`: """
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const run = await client.beta.threads.runs.submitToolOutputs('run_id', {
              thread_id: 'thread_id',
              tool_outputs: [{}],
            });
            
            console.log(run.id);
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
            	run, err := client.Beta.Threads.Runs.SubmitToolOutputs(
            		context.TODO(),
            		"thread_id",
            		"run_id",
            		openai.BetaThreadRunSubmitToolOutputsParams{
            			ToolOutputs: []openai.BetaThreadRunSubmitToolOutputsParamsToolOutput{{}},
            		},
            	)
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", run.ID)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.beta.threads.runs.Run;
            import com.openai.models.beta.threads.runs.RunSubmitToolOutputsParams;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    RunSubmitToolOutputsParams params = RunSubmitToolOutputsParams.builder()
                        .threadId("thread_id")
                        .runId("run_id")
                        .addToolOutput(RunSubmitToolOutputsParams.ToolOutput.builder().build())
                        .build();
                    Run run = client.beta().threads().runs().submitToolOutputs(params);
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            run = openai.beta.threads.runs.submit_tool_outputs("run_id", thread_id: "thread_id", tool_outputs: [{}])
            
            puts(run)
            """,
        },
        response: """
          {
            "id": "run_123",
            "object": "thread.run",
            "created_at": 1699075592,
            "assistant_id": "asst_123",
            "thread_id": "thread_123",
            "status": "queued",
            "started_at": 1699075592,
            "expires_at": 1699076192,
            "cancelled_at": null,
            "failed_at": null,
            "completed_at": null,
            "last_error": null,
            "model": "gpt-4o",
            "instructions": null,
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
            "metadata": {},
            "usage": null,
            "temperature": 1.0,
            "top_p": 1.0,
            "max_prompt_tokens": 1000,
            "max_completion_tokens": 1000,
            "truncation_strategy": {
              "type": "auto",
              "last_messages": null
            },
            "response_format": "auto",
            "tool_choice": "auto",
            "parallel_tool_calls": true
          }
          
          """,
      },
      #{
        title: "Streaming",
        request: #{
          curl: """
            curl https://api.openai.com/v1/threads/thread_123/runs/run_123/submit_tool_outputs \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -H "Content-Type: application/json" \\
              -H "OpenAI-Beta: assistants=v2" \\
              -d '{
                "tool_outputs": [
                  {
                    "tool_call_id": "call_001",
                    "output": "70 degrees and sunny."
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
            for run in client.beta.threads.runs.submit_tool_outputs(
                run_id="run_id",
                thread_id="thread_id",
                tool_outputs=[{}],
            ):
              print(run)
            """,
          javascript: """
            import OpenAI from "openai";
            
            const openai = new OpenAI();
            
            async function main() {
              const stream = await openai.beta.threads.runs.submitToolOutputs(
                "run_123",
                {
                  thread_id: "thread_123",
                  tool_outputs: [
                    {
                      tool_call_id: "call_001",
                      output: "70 degrees and sunny.",
                    },
                  ],
                }
              );
            
              for await (const event of stream) {
                console.log(event);
              }
            }
            
            main();
            
            """,
          `node.js`: """
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const run = await client.beta.threads.runs.submitToolOutputs('run_id', {
              thread_id: 'thread_id',
              tool_outputs: [{}],
            });
            
            console.log(run.id);
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
            	run, err := client.Beta.Threads.Runs.SubmitToolOutputs(
            		context.TODO(),
            		"thread_id",
            		"run_id",
            		openai.BetaThreadRunSubmitToolOutputsParams{
            			ToolOutputs: []openai.BetaThreadRunSubmitToolOutputsParamsToolOutput{{}},
            		},
            	)
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", run.ID)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.beta.threads.runs.Run;
            import com.openai.models.beta.threads.runs.RunSubmitToolOutputsParams;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    RunSubmitToolOutputsParams params = RunSubmitToolOutputsParams.builder()
                        .threadId("thread_id")
                        .runId("run_id")
                        .addToolOutput(RunSubmitToolOutputsParams.ToolOutput.builder().build())
                        .build();
                    Run run = client.beta().threads().runs().submitToolOutputs(params);
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            run = openai.beta.threads.runs.submit_tool_outputs("run_id", thread_id: "thread_id", tool_outputs: [{}])
            
            puts(run)
            """,
        },
        response: """
          event: thread.run.step.completed
          data: {"id":"step_001","object":"thread.run.step","created_at":1710352449,"run_id":"run_123","assistant_id":"asst_123","thread_id":"thread_123","type":"tool_calls","status":"completed","cancelled_at":null,"completed_at":1710352475,"expires_at":1710353047,"failed_at":null,"last_error":null,"step_details":{"type":"tool_calls","tool_calls":[{"id":"call_iWr0kQ2EaYMaxNdl0v3KYkx7","type":"function","function":{"name":"get_current_weather","arguments":"{"location":"San Francisco, CA","unit":"fahrenheit"}","output":"70 degrees and sunny."}}]},"usage":{"prompt_tokens":291,"completion_tokens":24,"total_tokens":315}}
          
          event: thread.run.queued
          data: {"id":"run_123","object":"thread.run","created_at":1710352447,"assistant_id":"asst_123","thread_id":"thread_123","status":"queued","started_at":1710352448,"expires_at":1710353047,"cancelled_at":null,"failed_at":null,"completed_at":null,"required_action":null,"last_error":null,"model":"gpt-4o","instructions":null,"tools":[{"type":"function","function":{"name":"get_current_weather","description":"Get the current weather in a given location","parameters":{"type":"object","properties":{"location":{"type":"string","description":"The city and state, e.g. San Francisco, CA"},"unit":{"type":"string","enum":["celsius","fahrenheit"]}},"required":["location"]}}}],"metadata":{},"temperature":1.0,"top_p":1.0,"max_completion_tokens":null,"max_prompt_tokens":null,"truncation_strategy":{"type":"auto","last_messages":null},"incomplete_details":null,"usage":null,"response_format":"auto","tool_choice":"auto","parallel_tool_calls":true}}
          
          event: thread.run.in_progress
          data: {"id":"run_123","object":"thread.run","created_at":1710352447,"assistant_id":"asst_123","thread_id":"thread_123","status":"in_progress","started_at":1710352475,"expires_at":1710353047,"cancelled_at":null,"failed_at":null,"completed_at":null,"required_action":null,"last_error":null,"model":"gpt-4o","instructions":null,"tools":[{"type":"function","function":{"name":"get_current_weather","description":"Get the current weather in a given location","parameters":{"type":"object","properties":{"location":{"type":"string","description":"The city and state, e.g. San Francisco, CA"},"unit":{"type":"string","enum":["celsius","fahrenheit"]}},"required":["location"]}}}],"metadata":{},"temperature":1.0,"top_p":1.0,"max_completion_tokens":null,"max_prompt_tokens":null,"truncation_strategy":{"type":"auto","last_messages":null},"incomplete_details":null,"usage":null,"response_format":"auto","tool_choice":"auto","parallel_tool_calls":true}}
          
          event: thread.run.step.created
          data: {"id":"step_002","object":"thread.run.step","created_at":1710352476,"run_id":"run_123","assistant_id":"asst_123","thread_id":"thread_123","type":"message_creation","status":"in_progress","cancelled_at":null,"completed_at":null,"expires_at":1710353047,"failed_at":null,"last_error":null,"step_details":{"type":"message_creation","message_creation":{"message_id":"msg_002"}},"usage":null}
          
          event: thread.run.step.in_progress
          data: {"id":"step_002","object":"thread.run.step","created_at":1710352476,"run_id":"run_123","assistant_id":"asst_123","thread_id":"thread_123","type":"message_creation","status":"in_progress","cancelled_at":null,"completed_at":null,"expires_at":1710353047,"failed_at":null,"last_error":null,"step_details":{"type":"message_creation","message_creation":{"message_id":"msg_002"}},"usage":null}
          
          event: thread.message.created
          data: {"id":"msg_002","object":"thread.message","created_at":1710352476,"assistant_id":"asst_123","thread_id":"thread_123","run_id":"run_123","status":"in_progress","incomplete_details":null,"incomplete_at":null,"completed_at":null,"role":"assistant","content":[],"metadata":{}}
          
          event: thread.message.in_progress
          data: {"id":"msg_002","object":"thread.message","created_at":1710352476,"assistant_id":"asst_123","thread_id":"thread_123","run_id":"run_123","status":"in_progress","incomplete_details":null,"incomplete_at":null,"completed_at":null,"role":"assistant","content":[],"metadata":{}}
          
          event: thread.message.delta
          data: {"id":"msg_002","object":"thread.message.delta","delta":{"content":[{"index":0,"type":"text","text":{"value":"The","annotations":[]}}]}}
          
          event: thread.message.delta
          data: {"id":"msg_002","object":"thread.message.delta","delta":{"content":[{"index":0,"type":"text","text":{"value":" current"}}]}}
          
          event: thread.message.delta
          data: {"id":"msg_002","object":"thread.message.delta","delta":{"content":[{"index":0,"type":"text","text":{"value":" weather"}}]}}
          
          ...
          
          event: thread.message.delta
          data: {"id":"msg_002","object":"thread.message.delta","delta":{"content":[{"index":0,"type":"text","text":{"value":" sunny"}}]}}
          
          event: thread.message.delta
          data: {"id":"msg_002","object":"thread.message.delta","delta":{"content":[{"index":0,"type":"text","text":{"value":"."}}]}}
          
          event: thread.message.completed
          data: {"id":"msg_002","object":"thread.message","created_at":1710352476,"assistant_id":"asst_123","thread_id":"thread_123","run_id":"run_123","status":"completed","incomplete_details":null,"incomplete_at":null,"completed_at":1710352477,"role":"assistant","content":[{"type":"text","text":{"value":"The current weather in San Francisco, CA is 70 degrees Fahrenheit and sunny.","annotations":[]}}],"metadata":{}}
          
          event: thread.run.step.completed
          data: {"id":"step_002","object":"thread.run.step","created_at":1710352476,"run_id":"run_123","assistant_id":"asst_123","thread_id":"thread_123","type":"message_creation","status":"completed","cancelled_at":null,"completed_at":1710352477,"expires_at":1710353047,"failed_at":null,"last_error":null,"step_details":{"type":"message_creation","message_creation":{"message_id":"msg_002"}},"usage":{"prompt_tokens":329,"completion_tokens":18,"total_tokens":347}}
          
          event: thread.run.completed
          data: {"id":"run_123","object":"thread.run","created_at":1710352447,"assistant_id":"asst_123","thread_id":"thread_123","status":"completed","started_at":1710352475,"expires_at":null,"cancelled_at":null,"failed_at":null,"completed_at":1710352477,"required_action":null,"last_error":null,"model":"gpt-4o","instructions":null,"tools":[{"type":"function","function":{"name":"get_current_weather","description":"Get the current weather in a given location","parameters":{"type":"object","properties":{"location":{"type":"string","description":"The city and state, e.g. San Francisco, CA"},"unit":{"type":"string","enum":["celsius","fahrenheit"]}},"required":["location"]}}}],"metadata":{},"temperature":1.0,"top_p":1.0,"max_completion_tokens":null,"max_prompt_tokens":null,"truncation_strategy":{"type":"auto","last_messages":null},"incomplete_details":null,"usage":{"prompt_tokens":20,"completion_tokens":11,"total_tokens":31},"response_format":"auto","tool_choice":"auto","parallel_tool_calls":true}}
          
          event: done
          data: [DONE]
          
          """,
      }
    ],
  }
);
