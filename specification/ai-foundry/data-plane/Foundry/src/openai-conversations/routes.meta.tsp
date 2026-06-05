import "./routes.tsp";
import "@typespec/openapi";
using TypeSpec.OpenAPI;
namespace Azure.AI.Projects;
@@extension(
  Azure.AI.Projects.Conversations.listConversationItems,
  "x-oaiMeta",
  #{
    name: "List items",
    group: "conversations",
    path: "list-items",
    examples: #{
      request: #{
        curl: """
          curl "https://api.openai.com/v1/conversations/conv_123/items?limit=10" \\
            -H "Authorization: Bearer $OPENAI_API_KEY"
          
          """,
        javascript: """
          import OpenAI from "openai";
          const client = new OpenAI();
          
          const items = await client.conversations.items.list("conv_123", { limit: 10 });
          console.log(items.data);
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          page = client.conversations.items.list(
              conversation_id="conv_123",
          )
          page = page.data[0]
          print(page)
          """,
        csharp: """
          using System;
          using OpenAI.Conversations;
          
          OpenAIConversationClient client = new(
              apiKey: Environment.GetEnvironmentVariable("OPENAI_API_KEY")
          );
          
          ConversationItemList items = client.ConversationItems.List(
              conversationId: "conv_123",
              new ListConversationItemsOptions { Limit = 10 }
          );
          Console.WriteLine(items.Data.Count);
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          // Automatically fetches more pages as needed.
          for await (const conversationItem of client.conversations.items.list('conv_123')) {
            console.log(conversationItem);
          }
          """,
        go: """
          package main
          
          import (
          	"context"
          	"fmt"
          
          	"github.com/openai/openai-go"
          	"github.com/openai/openai-go/conversations"
          	"github.com/openai/openai-go/option"
          )
          
          func main() {
          	client := openai.NewClient(
          		option.WithAPIKey("My API Key"),
          	)
          	page, err := client.Conversations.Items.List(
          		context.TODO(),
          		"conv_123",
          		conversations.ItemListParams{},
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
          import com.openai.models.conversations.items.ItemListPage;
          import com.openai.models.conversations.items.ItemListParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  ItemListPage page = client.conversations().items().list("conv_123");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          page = openai.conversations.items.list("conv_123")
          
          puts(page)
          """,
      },
      response: """
        {
          "object": "list",
          "data": [
            {
              "type": "message",
              "id": "msg_abc",
              "status": "completed",
              "role": "user",
              "content": [
                {"type": "input_text", "text": "Hello!"}
              ]
            }
          ],
          "first_id": "msg_abc",
          "last_id": "msg_abc",
          "has_more": false
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Conversations.listConversationItems,
  "x-ms-list",
  true
);

@@extension(
  Azure.AI.Projects.Conversations.createConversationItems,
  "x-oaiMeta",
  #{
    name: "Create items",
    group: "conversations",
    path: "create-item",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/conversations/conv_123/items \\
            -H "Content-Type: application/json" \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -d '{
              "items": [
                {
                  "type": "message",
                  "role": "user",
                  "content": [
                    {"type": "input_text", "text": "Hello!"}
                  ]
                },
                {
                  "type": "message",
                  "role": "user",
                  "content": [
                    {"type": "input_text", "text": "How are you?"}
                  ]
                }
              ]
            }'
          
          """,
        javascript: """
          import OpenAI from "openai";
          const client = new OpenAI();
          
          const items = await client.conversations.items.create(
            "conv_123",
            {
              items: [
                {
                  type: "message",
                  role: "user",
                  content: [{ type: "input_text", text: "Hello!" }],
                },
                {
                  type: "message",
                  role: "user",
                  content: [{ type: "input_text", text: "How are you?" }],
                },
              ],
            }
          );
          console.log(items.data);
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          conversation_item_list = client.conversations.items.create(
              conversation_id="conv_123",
              items=[{
                  "content": "string",
                  "role": "user",
                  "type": "message",
              }],
          )
          print(conversation_item_list.first_id)
          """,
        csharp: """
          using System;
          using System.Collections.Generic;
          using OpenAI.Conversations;
          
          OpenAIConversationClient client = new(
              apiKey: Environment.GetEnvironmentVariable("OPENAI_API_KEY")
          );
          
          ConversationItemList created = client.ConversationItems.Create(
              conversationId: "conv_123",
              new CreateConversationItemsOptions
              {
                  Items = new List<ConversationItem>
                  {
                      new ConversationMessage
                      {
                          Role = "user",
                          Content =
                          {
                              new ConversationInputText { Text = "Hello!" }
                          }
                      },
                      new ConversationMessage
                      {
                          Role = "user",
                          Content =
                          {
                              new ConversationInputText { Text = "How are you?" }
                          }
                      }
                  }
              }
          );
          Console.WriteLine(created.Data.Count);
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const conversationItemList = await client.conversations.items.create('conv_123', {
            items: [
              {
                content: 'string',
                role: 'user',
                type: 'message',
              },
            ],
          });
          
          console.log(conversationItemList.first_id);
          """,
        go: """
          package main
          
          import (
          	"context"
          	"fmt"
          
          	"github.com/openai/openai-go"
          	"github.com/openai/openai-go/conversations"
          	"github.com/openai/openai-go/option"
          	"github.com/openai/openai-go/responses"
          )
          
          func main() {
          	client := openai.NewClient(
          		option.WithAPIKey("My API Key"),
          	)
          	conversationItemList, err := client.Conversations.Items.New(
          		context.TODO(),
          		"conv_123",
          		conversations.ItemNewParams{
          			Items: []responses.ResponseInputItemUnionParam{{
          				OfMessage: &responses.EasyInputMessageParam{
          					Content: responses.EasyInputMessageContentUnionParam{
          						OfString: openai.String("string"),
          					},
          					Role: responses.EasyInputMessageRoleUser,
          					Type: responses.EasyInputMessageTypeMessage,
          				},
          			}},
          		},
          	)
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", conversationItemList.FirstID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.conversations.items.ConversationItemList;
          import com.openai.models.conversations.items.ItemCreateParams;
          import com.openai.models.responses.EasyInputMessage;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  ItemCreateParams params = ItemCreateParams.builder()
                      .conversationId("conv_123")
                      .addItem(EasyInputMessage.builder()
                          .content("string")
                          .role(EasyInputMessage.Role.USER)
                          .type(EasyInputMessage.Type.MESSAGE)
                          .build())
                      .build();
                  ConversationItemList conversationItemList = client.conversations().items().create(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          conversation_item_list = openai.conversations.items.create("conv_123", items: [{content: "string", role: :user, type: :message}])
          
          puts(conversation_item_list)
          """,
      },
      response: """
        {
          "object": "list",
          "data": [
            {
              "type": "message",
              "id": "msg_abc",
              "status": "completed",
              "role": "user",
              "content": [
                {"type": "input_text", "text": "Hello!"}
              ]
            },
            {
              "type": "message",
              "id": "msg_def",
              "status": "completed",
              "role": "user",
              "content": [
                {"type": "input_text", "text": "How are you?"}
              ]
            }
          ],
          "first_id": "msg_abc",
          "last_id": "msg_def",
          "has_more": false
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Conversations.deleteConversationItem,
  "x-oaiMeta",
  #{
    name: "Delete an item",
    group: "conversations",
    path: "delete-item",
    examples: #{
      request: #{
        curl: """
          curl -X DELETE https://api.openai.com/v1/conversations/conv_123/items/msg_abc \\
            -H "Authorization: Bearer $OPENAI_API_KEY"
          
          """,
        javascript: """
          import OpenAI from "openai";
          const client = new OpenAI();
          
          const conversation = await client.conversations.items.delete(
            "conv_123",
            "msg_abc"
          );
          console.log(conversation);
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          conversation = client.conversations.items.delete(
              item_id="msg_abc",
              conversation_id="conv_123",
          )
          print(conversation.id)
          """,
        csharp: """
          using System;
          using OpenAI.Conversations;
          
          OpenAIConversationClient client = new(
              apiKey: Environment.GetEnvironmentVariable("OPENAI_API_KEY")
          );
          
          Conversation conversation = client.ConversationItems.Delete(
              conversationId: "conv_123",
              itemId: "msg_abc"
          );
          Console.WriteLine(conversation.Id);
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const conversation = await client.conversations.items.delete('msg_abc', {
            conversation_id: 'conv_123',
          });
          
          console.log(conversation.id);
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
          	conversation, err := client.Conversations.Items.Delete(
          		context.TODO(),
          		"conv_123",
          		"msg_abc",
          	)
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", conversation.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.conversations.Conversation;
          import com.openai.models.conversations.items.ItemDeleteParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  ItemDeleteParams params = ItemDeleteParams.builder()
                      .conversationId("conv_123")
                      .itemId("msg_abc")
                      .build();
                  Conversation conversation = client.conversations().items().delete(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          conversation = openai.conversations.items.delete("msg_abc", conversation_id: "conv_123")
          
          puts(conversation)
          """,
      },
      response: """
        {
          "id": "conv_123",
          "object": "conversation",
          "created_at": 1741900000,
          "metadata": {"topic": "demo"}
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Conversations.getConversationItem,
  "x-oaiMeta",
  #{
    name: "Retrieve an item",
    group: "conversations",
    path: "get-item",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/conversations/conv_123/items/msg_abc \\
            -H "Authorization: Bearer $OPENAI_API_KEY"
          
          """,
        javascript: """
          import OpenAI from "openai";
          const client = new OpenAI();
          
          const item = await client.conversations.items.retrieve(
            "conv_123",
            "msg_abc"
          );
          console.log(item);
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          conversation_item = client.conversations.items.retrieve(
              item_id="msg_abc",
              conversation_id="conv_123",
          )
          print(conversation_item)
          """,
        csharp: """
          using System;
          using OpenAI.Conversations;
          
          OpenAIConversationClient client = new(
              apiKey: Environment.GetEnvironmentVariable("OPENAI_API_KEY")
          );
          
          ConversationItem item = client.ConversationItems.Get(
              conversationId: "conv_123",
              itemId: "msg_abc"
          );
          Console.WriteLine(item.Id);
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const conversationItem = await client.conversations.items.retrieve('msg_abc', {
            conversation_id: 'conv_123',
          });
          
          console.log(conversationItem);
          """,
        go: """
          package main
          
          import (
          	"context"
          	"fmt"
          
          	"github.com/openai/openai-go"
          	"github.com/openai/openai-go/conversations"
          	"github.com/openai/openai-go/option"
          )
          
          func main() {
          	client := openai.NewClient(
          		option.WithAPIKey("My API Key"),
          	)
          	conversationItem, err := client.Conversations.Items.Get(
          		context.TODO(),
          		"conv_123",
          		"msg_abc",
          		conversations.ItemGetParams{},
          	)
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", conversationItem)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.conversations.items.ConversationItem;
          import com.openai.models.conversations.items.ItemRetrieveParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  ItemRetrieveParams params = ItemRetrieveParams.builder()
                      .conversationId("conv_123")
                      .itemId("msg_abc")
                      .build();
                  ConversationItem conversationItem = client.conversations().items().retrieve(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          conversation_item = openai.conversations.items.retrieve("msg_abc", conversation_id: "conv_123")
          
          puts(conversation_item)
          """,
      },
      response: """
        {
          "type": "message",
          "id": "msg_abc",
          "status": "completed",
          "role": "user",
          "content": [
            {"type": "input_text", "text": "Hello!"}
          ]
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Conversations.createConversation,
  "x-oaiMeta",
  #{
    name: "Create a conversation",
    group: "conversations",
    path: "create",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/conversations \\
            -H "Content-Type: application/json" \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -d '{
              "metadata": {"topic": "demo"},
              "items": [
                {
                  "type": "message",
                  "role": "user",
                  "content": "Hello!"
                }
              ]
            }'
          
          """,
        javascript: """
          import OpenAI from "openai";
          const client = new OpenAI();
          
          const conversation = await client.conversations.create({
            metadata: { topic: "demo" },
            items: [
              { type: "message", role: "user", content: "Hello!" }
            ],
          });
          console.log(conversation);
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          conversation = client.conversations.create()
          print(conversation.id)
          """,
        csharp: """
          using System;
          using System.Collections.Generic;
          using OpenAI.Conversations;
          
          OpenAIConversationClient client = new(
              apiKey: Environment.GetEnvironmentVariable("OPENAI_API_KEY")
          );
          
          Conversation conversation = client.CreateConversation(
              new CreateConversationOptions
              {
                  Metadata = new Dictionary<string, string>
                  {
                      { "topic", "demo" }
                  },
                  Items =
                  {
                      new ConversationMessageInput
                      {
                          Role = "user",
                          Content = "Hello!",
                      }
                  }
              }
          );
          Console.WriteLine(conversation.Id);
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const conversation = await client.conversations.create();
          
          console.log(conversation.id);
          """,
        go: """
          package main
          
          import (
          	"context"
          	"fmt"
          
          	"github.com/openai/openai-go"
          	"github.com/openai/openai-go/conversations"
          	"github.com/openai/openai-go/option"
          )
          
          func main() {
          	client := openai.NewClient(
          		option.WithAPIKey("My API Key"),
          	)
          	conversation, err := client.Conversations.New(context.TODO(), conversations.ConversationNewParams{})
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", conversation.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.conversations.Conversation;
          import com.openai.models.conversations.ConversationCreateParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  Conversation conversation = client.conversations().create();
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          conversation = openai.conversations.create
          
          puts(conversation)
          """,
      },
      response: """
        {
          "id": "conv_123",
          "object": "conversation",
          "created_at": 1741900000,
          "metadata": {"topic": "demo"}
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Conversations.deleteConversation,
  "x-oaiMeta",
  #{
    name: "Delete a conversation",
    group: "conversations",
    path: "delete",
    examples: #{
      request: #{
        curl: """
          curl -X DELETE https://api.openai.com/v1/conversations/conv_123 \\
            -H "Authorization: Bearer $OPENAI_API_KEY"
          
          """,
        javascript: """
          import OpenAI from "openai";
          const client = new OpenAI();
          
          const deleted = await client.conversations.delete("conv_123");
          console.log(deleted);
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          conversation_deleted_resource = client.conversations.delete(
              "conv_123",
          )
          print(conversation_deleted_resource.id)
          """,
        csharp: """
          using System;
          using OpenAI.Conversations;
          
          OpenAIConversationClient client = new(
              apiKey: Environment.GetEnvironmentVariable("OPENAI_API_KEY")
          );
          
          DeletedConversation deleted = client.DeleteConversation("conv_123");
          Console.WriteLine(deleted.Id);
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const conversationDeletedResource = await client.conversations.delete('conv_123');
          
          console.log(conversationDeletedResource.id);
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
          	conversationDeletedResource, err := client.Conversations.Delete(context.TODO(), "conv_123")
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", conversationDeletedResource.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.conversations.ConversationDeleteParams;
          import com.openai.models.conversations.ConversationDeletedResource;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  ConversationDeletedResource conversationDeletedResource = client.conversations().delete("conv_123");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          conversation_deleted_resource = openai.conversations.delete("conv_123")
          
          puts(conversation_deleted_resource)
          """,
      },
      response: """
        {
          "id": "conv_123",
          "object": "conversation.deleted",
          "deleted": true
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Conversations.getConversation,
  "x-oaiMeta",
  #{
    name: "Retrieve a conversation",
    group: "conversations",
    path: "retrieve",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/conversations/conv_123 \\
            -H "Authorization: Bearer $OPENAI_API_KEY"
          
          """,
        javascript: """
          import OpenAI from "openai";
          const client = new OpenAI();
          
          const conversation = await client.conversations.retrieve("conv_123");
          console.log(conversation);
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          conversation = client.conversations.retrieve(
              "conv_123",
          )
          print(conversation.id)
          """,
        csharp: """
          using System;
          using OpenAI.Conversations;
          
          OpenAIConversationClient client = new(
              apiKey: Environment.GetEnvironmentVariable("OPENAI_API_KEY")
          );
          
          Conversation conversation = client.GetConversation("conv_123");
          Console.WriteLine(conversation.Id);
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const conversation = await client.conversations.retrieve('conv_123');
          
          console.log(conversation.id);
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
          	conversation, err := client.Conversations.Get(context.TODO(), "conv_123")
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", conversation.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.conversations.Conversation;
          import com.openai.models.conversations.ConversationRetrieveParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  Conversation conversation = client.conversations().retrieve("conv_123");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          conversation = openai.conversations.retrieve("conv_123")
          
          puts(conversation)
          """,
      },
      response: """
        {
          "id": "conv_123",
          "object": "conversation",
          "created_at": 1741900000,
          "metadata": {"topic": "demo"}
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.Conversations.updateConversation,
  "x-oaiMeta",
  #{
    name: "Update a conversation",
    group: "conversations",
    path: "update",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/conversations/conv_123 \\
            -H "Content-Type: application/json" \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -d '{
              "metadata": {"topic": "project-x"}
            }'
          
          """,
        javascript: """
          import OpenAI from "openai";
          const client = new OpenAI();
          
          const updated = await client.conversations.update(
            "conv_123",
            { metadata: { topic: "project-x" } }
          );
          console.log(updated);
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          conversation = client.conversations.update(
              conversation_id="conv_123",
              metadata={
                  "foo": "string"
              },
          )
          print(conversation.id)
          """,
        csharp: """
          using System;
          using System.Collections.Generic;
          using OpenAI.Conversations;
          
          OpenAIConversationClient client = new(
              apiKey: Environment.GetEnvironmentVariable("OPENAI_API_KEY")
          );
          
          Conversation updated = client.UpdateConversation(
              conversationId: "conv_123",
              new UpdateConversationOptions
              {
                  Metadata = new Dictionary<string, string>
                  {
                      { "topic", "project-x" }
                  }
              }
          );
          Console.WriteLine(updated.Id);
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const conversation = await client.conversations.update('conv_123', { metadata: { foo: 'string' } });
          
          console.log(conversation.id);
          """,
        go: """
          package main
          
          import (
          	"context"
          	"fmt"
          
          	"github.com/openai/openai-go"
          	"github.com/openai/openai-go/conversations"
          	"github.com/openai/openai-go/option"
          	"github.com/openai/openai-go/shared"
          )
          
          func main() {
          	client := openai.NewClient(
          		option.WithAPIKey("My API Key"),
          	)
          	conversation, err := client.Conversations.Update(
          		context.TODO(),
          		"conv_123",
          		conversations.ConversationUpdateParams{
          			Metadata: shared.Metadata{
          				"foo": "string",
          			},
          		},
          	)
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", conversation.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.core.JsonValue;
          import com.openai.models.conversations.Conversation;
          import com.openai.models.conversations.ConversationUpdateParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  ConversationUpdateParams params = ConversationUpdateParams.builder()
                      .conversationId("conv_123")
                      .metadata(ConversationUpdateParams.Metadata.builder()
                          .putAdditionalProperty("foo", JsonValue.from("string"))
                          .build())
                      .build();
                  Conversation conversation = client.conversations().update(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          conversation = openai.conversations.update("conv_123", metadata: {foo: "string"})
          
          puts(conversation)
          """,
      },
      response: """
        {
          "id": "conv_123",
          "object": "conversation",
          "created_at": 1741900000,
          "metadata": {"topic": "project-x"}
        }
        
        """,
    },
  }
);
