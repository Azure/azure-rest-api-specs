import "./routes.tsp";
import "@typespec/openapi";
using TypeSpec.OpenAPI;
namespace Azure.AI.Projects;
@@extension(
  Azure.AI.Projects.Assistants.listAssistants,
  "x-oaiMeta",
  #{
    name: "List assistants",
    group: "assistants",
    examples: #{
      request: #{
        curl: """
          curl "https://api.openai.com/v1/assistants?order=desc&limit=20" \\
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
          page = client.beta.assistants.list()
          page = page.data[0]
          print(page.id)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          async function main() {
            const myAssistants = await openai.beta.assistants.list({
              order: "desc",
              limit: "20",
            });
          
            console.log(myAssistants.data);
          }
          
          main();
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          // Automatically fetches more pages as needed.
          for await (const assistant of client.beta.assistants.list()) {
            console.log(assistant.id);
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
          	page, err := client.Beta.Assistants.List(context.TODO(), openai.BetaAssistantListParams{})
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
          import com.openai.models.beta.assistants.AssistantListPage;
          import com.openai.models.beta.assistants.AssistantListParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  AssistantListPage page = client.beta().assistants().list();
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          page = openai.beta.assistants.list
          
          puts(page)
          """,
      },
      response: """
        {
          "object": "list",
          "data": [
            {
              "id": "asst_abc123",
              "object": "assistant",
              "created_at": 1698982736,
              "name": "Coding Tutor",
              "description": null,
              "model": "gpt-4o",
              "instructions": "You are a helpful assistant designed to make me better at coding!",
              "tools": [],
              "tool_resources": {},
              "metadata": {},
              "top_p": 1.0,
              "temperature": 1.0,
              "response_format": "auto"
            },
            {
              "id": "asst_abc456",
              "object": "assistant",
              "created_at": 1698982718,
              "name": "My Assistant",
              "description": null,
              "model": "gpt-4o",
              "instructions": "You are a helpful assistant designed to make me better at coding!",
              "tools": [],
              "tool_resources": {},
              "metadata": {},
              "top_p": 1.0,
              "temperature": 1.0,
              "response_format": "auto"
            },
            {
              "id": "asst_abc789",
              "object": "assistant",
              "created_at": 1698982643,
              "name": null,
              "description": null,
              "model": "gpt-4o",
              "instructions": null,
              "tools": [],
              "tool_resources": {},
              "metadata": {},
              "top_p": 1.0,
              "temperature": 1.0,
              "response_format": "auto"
            }
          ],
          "first_id": "asst_abc123",
          "last_id": "asst_abc789",
          "has_more": false
        }
        
        """,
    },
  }
);

@@extension(Azure.AI.Projects.Assistants.listAssistants, "x-ms-list", true);

@@extension(
  Azure.AI.Projects.Assistants.createAssistant,
  "x-oaiMeta",
  #{
    name: "Create assistant",
    group: "assistants",
    examples: #[
      #{
        title: "Code Interpreter",
        request: #{
          curl: """
            curl "https://api.openai.com/v1/assistants" \\
              -H "Content-Type: application/json" \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -H "OpenAI-Beta: assistants=v2" \\
              -d '{
                "instructions": "You are a personal math tutor. When asked a question, write and run Python code to answer the question.",
                "name": "Math Tutor",
                "tools": [{"type": "code_interpreter"}],
                "model": "gpt-4o"
              }'
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            assistant = client.beta.assistants.create(
                model="gpt-4o",
            )
            print(assistant.id)
            """,
          javascript: """
            import OpenAI from "openai";
            
            const openai = new OpenAI();
            
            async function main() {
              const myAssistant = await openai.beta.assistants.create({
                instructions:
                  "You are a personal math tutor. When asked a question, write and run Python code to answer the question.",
                name: "Math Tutor",
                tools: [{ type: "code_interpreter" }],
                model: "gpt-4o",
              });
            
              console.log(myAssistant);
            }
            
            main();
            """,
          `node.js`: """
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const assistant = await client.beta.assistants.create({ model: 'gpt-4o' });
            
            console.log(assistant.id);
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
            	assistant, err := client.Beta.Assistants.New(context.TODO(), openai.BetaAssistantNewParams{
            		Model: shared.ChatModelGPT4o,
            	})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", assistant.ID)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.ChatModel;
            import com.openai.models.beta.assistants.Assistant;
            import com.openai.models.beta.assistants.AssistantCreateParams;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    AssistantCreateParams params = AssistantCreateParams.builder()
                        .model(ChatModel.GPT_4O)
                        .build();
                    Assistant assistant = client.beta().assistants().create(params);
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            assistant = openai.beta.assistants.create(model: :"gpt-4o")
            
            puts(assistant)
            """,
        },
        response: """
          {
            "id": "asst_abc123",
            "object": "assistant",
            "created_at": 1698984975,
            "name": "Math Tutor",
            "description": null,
            "model": "gpt-4o",
            "instructions": "You are a personal math tutor. When asked a question, write and run Python code to answer the question.",
            "tools": [
              {
                "type": "code_interpreter"
              }
            ],
            "metadata": {},
            "top_p": 1.0,
            "temperature": 1.0,
            "response_format": "auto"
          }
          
          """,
      },
      #{
        title: "Files",
        request: #{
          curl: """
            curl https://api.openai.com/v1/assistants \\
              -H "Content-Type: application/json" \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -H "OpenAI-Beta: assistants=v2" \\
              -d '{
                "instructions": "You are an HR bot, and you have access to files to answer employee questions about company policies.",
                "tools": [{"type": "file_search"}],
                "tool_resources": {"file_search": {"vector_store_ids": ["vs_123"]}},
                "model": "gpt-4o"
              }'
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            assistant = client.beta.assistants.create(
                model="gpt-4o",
            )
            print(assistant.id)
            """,
          javascript: """
            import OpenAI from "openai";
            
            const openai = new OpenAI();
            
            async function main() {
              const myAssistant = await openai.beta.assistants.create({
                instructions:
                  "You are an HR bot, and you have access to files to answer employee questions about company policies.",
                name: "HR Helper",
                tools: [{ type: "file_search" }],
                tool_resources: {
                  file_search: {
                    vector_store_ids: ["vs_123"]
                  }
                },
                model: "gpt-4o"
              });
            
              console.log(myAssistant);
            }
            
            main();
            """,
          `node.js`: """
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const assistant = await client.beta.assistants.create({ model: 'gpt-4o' });
            
            console.log(assistant.id);
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
            	assistant, err := client.Beta.Assistants.New(context.TODO(), openai.BetaAssistantNewParams{
            		Model: shared.ChatModelGPT4o,
            	})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", assistant.ID)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.ChatModel;
            import com.openai.models.beta.assistants.Assistant;
            import com.openai.models.beta.assistants.AssistantCreateParams;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    AssistantCreateParams params = AssistantCreateParams.builder()
                        .model(ChatModel.GPT_4O)
                        .build();
                    Assistant assistant = client.beta().assistants().create(params);
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            assistant = openai.beta.assistants.create(model: :"gpt-4o")
            
            puts(assistant)
            """,
        },
        response: """
          {
            "id": "asst_abc123",
            "object": "assistant",
            "created_at": 1699009403,
            "name": "HR Helper",
            "description": null,
            "model": "gpt-4o",
            "instructions": "You are an HR bot, and you have access to files to answer employee questions about company policies.",
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
            "top_p": 1.0,
            "temperature": 1.0,
            "response_format": "auto"
          }
          
          """,
      }
    ],
  }
);

@@extension(
  Azure.AI.Projects.Assistants.deleteAssistant,
  "x-oaiMeta",
  #{
    name: "Delete assistant",
    group: "assistants",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/assistants/asst_abc123 \\
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
          assistant_deleted = client.beta.assistants.delete(
              "assistant_id",
          )
          print(assistant_deleted.id)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          async function main() {
            const response = await openai.beta.assistants.delete("asst_abc123");
          
            console.log(response);
          }
          main();
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const assistantDeleted = await client.beta.assistants.delete('assistant_id');
          
          console.log(assistantDeleted.id);
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
          	assistantDeleted, err := client.Beta.Assistants.Delete(context.TODO(), "assistant_id")
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", assistantDeleted.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.beta.assistants.AssistantDeleteParams;
          import com.openai.models.beta.assistants.AssistantDeleted;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  AssistantDeleted assistantDeleted = client.beta().assistants().delete("assistant_id");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          assistant_deleted = openai.beta.assistants.delete("assistant_id")
          
          puts(assistant_deleted)
          """,
      },
      response: """
        {
          "id": "asst_abc123",
          "object": "assistant.deleted",
          "deleted": true
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Assistants.getAssistant,
  "x-oaiMeta",
  #{
    name: "Retrieve assistant",
    group: "assistants",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/assistants/asst_abc123 \\
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
          assistant = client.beta.assistants.retrieve(
              "assistant_id",
          )
          print(assistant.id)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          async function main() {
            const myAssistant = await openai.beta.assistants.retrieve(
              "asst_abc123"
            );
          
            console.log(myAssistant);
          }
          
          main();
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const assistant = await client.beta.assistants.retrieve('assistant_id');
          
          console.log(assistant.id);
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
          	assistant, err := client.Beta.Assistants.Get(context.TODO(), "assistant_id")
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", assistant.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.beta.assistants.Assistant;
          import com.openai.models.beta.assistants.AssistantRetrieveParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  Assistant assistant = client.beta().assistants().retrieve("assistant_id");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          assistant = openai.beta.assistants.retrieve("assistant_id")
          
          puts(assistant)
          """,
      },
      response: """
        {
          "id": "asst_abc123",
          "object": "assistant",
          "created_at": 1699009709,
          "name": "HR Helper",
          "description": null,
          "model": "gpt-4o",
          "instructions": "You are an HR bot, and you have access to files to answer employee questions about company policies.",
          "tools": [
            {
              "type": "file_search"
            }
          ],
          "metadata": {},
          "top_p": 1.0,
          "temperature": 1.0,
          "response_format": "auto"
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Assistants.modifyAssistant,
  "x-oaiMeta",
  #{
    name: "Modify assistant",
    group: "assistants",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/assistants/asst_abc123 \\
            -H "Content-Type: application/json" \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "OpenAI-Beta: assistants=v2" \\
            -d '{
                "instructions": "You are an HR bot, and you have access to files to answer employee questions about company policies. Always response with info from either of the files.",
                "tools": [{"type": "file_search"}],
                "model": "gpt-4o"
              }'
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          assistant = client.beta.assistants.update(
              assistant_id="assistant_id",
          )
          print(assistant.id)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          async function main() {
            const myUpdatedAssistant = await openai.beta.assistants.update(
              "asst_abc123",
              {
                instructions:
                  "You are an HR bot, and you have access to files to answer employee questions about company policies. Always response with info from either of the files.",
                name: "HR Helper",
                tools: [{ type: "file_search" }],
                model: "gpt-4o"
              }
            );
          
            console.log(myUpdatedAssistant);
          }
          
          main();
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const assistant = await client.beta.assistants.update('assistant_id');
          
          console.log(assistant.id);
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
          	assistant, err := client.Beta.Assistants.Update(
          		context.TODO(),
          		"assistant_id",
          		openai.BetaAssistantUpdateParams{},
          	)
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", assistant.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.beta.assistants.Assistant;
          import com.openai.models.beta.assistants.AssistantUpdateParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  Assistant assistant = client.beta().assistants().update("assistant_id");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          assistant = openai.beta.assistants.update("assistant_id")
          
          puts(assistant)
          """,
      },
      response: """
        {
          "id": "asst_123",
          "object": "assistant",
          "created_at": 1699009709,
          "name": "HR Helper",
          "description": null,
          "model": "gpt-4o",
          "instructions": "You are an HR bot, and you have access to files to answer employee questions about company policies. Always response with info from either of the files.",
          "tools": [
            {
              "type": "file_search"
            }
          ],
          "tool_resources": {
            "file_search": {
              "vector_store_ids": []
            }
          },
          "metadata": {},
          "top_p": 1.0,
          "temperature": 1.0,
          "response_format": "auto"
        }
        
        """,
    },
  }
);
