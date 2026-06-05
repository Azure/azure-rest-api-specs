import "./routes.tsp";
import "@typespec/openapi";
using TypeSpec.OpenAPI;
namespace Azure.AI.Projects;
@@extension(
  Azure.AI.Projects.VectorStores.listVectorStores,
  "x-oaiMeta",
  #{
    name: "List vector stores",
    group: "vector_stores",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/vector_stores \\
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
          page = client.vector_stores.list()
          page = page.data[0]
          print(page.id)
          """,
        javascript: """
          import OpenAI from "openai";
          const openai = new OpenAI();
          
          async function main() {
            const vectorStores = await openai.vectorStores.list();
            console.log(vectorStores);
          }
          
          main();
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          // Automatically fetches more pages as needed.
          for await (const vectorStore of client.vectorStores.list()) {
            console.log(vectorStore.id);
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
          	page, err := client.VectorStores.List(context.TODO(), openai.VectorStoreListParams{})
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
          import com.openai.models.vectorstores.VectorStoreListPage;
          import com.openai.models.vectorstores.VectorStoreListParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  VectorStoreListPage page = client.vectorStores().list();
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          page = openai.vector_stores.list
          
          puts(page)
          """,
      },
      response: """
        {
          "object": "list",
          "data": [
            {
              "id": "vs_abc123",
              "object": "vector_store",
              "created_at": 1699061776,
              "name": "Support FAQ",
              "description": "Contains commonly asked questions and answers, organized by topic.",
              "bytes": 139920,
              "file_counts": {
                "in_progress": 0,
                "completed": 3,
                "failed": 0,
                "cancelled": 0,
                "total": 3
              }
            },
            {
              "id": "vs_abc456",
              "object": "vector_store",
              "created_at": 1699061776,
              "name": "Support FAQ v2",
              "description": null,
              "bytes": 139920,
              "file_counts": {
                "in_progress": 0,
                "completed": 3,
                "failed": 0,
                "cancelled": 0,
                "total": 3
              }
            }
          ],
          "first_id": "vs_abc123",
          "last_id": "vs_abc456",
          "has_more": false
        }
        
        """,
    },
  }
);

@@extension(Azure.AI.Projects.VectorStores.listVectorStores, "x-ms-list", true);

@@extension(
  Azure.AI.Projects.VectorStores.createVectorStore,
  "x-oaiMeta",
  #{
    name: "Create vector store",
    group: "vector_stores",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/vector_stores \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "Content-Type: application/json" \\
            -H "OpenAI-Beta: assistants=v2" \\
            -d '{
              "name": "Support FAQ"
            }'
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          vector_store = client.vector_stores.create()
          print(vector_store.id)
          """,
        javascript: """
          import OpenAI from "openai";
          const openai = new OpenAI();
          
          async function main() {
            const vectorStore = await openai.vectorStores.create({
              name: "Support FAQ"
            });
            console.log(vectorStore);
          }
          
          main();
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const vectorStore = await client.vectorStores.create();
          
          console.log(vectorStore.id);
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
          	vectorStore, err := client.VectorStores.New(context.TODO(), openai.VectorStoreNewParams{})
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", vectorStore.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.vectorstores.VectorStore;
          import com.openai.models.vectorstores.VectorStoreCreateParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  VectorStore vectorStore = client.vectorStores().create();
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          vector_store = openai.vector_stores.create
          
          puts(vector_store)
          """,
      },
      response: """
        {
          "id": "vs_abc123",
          "object": "vector_store",
          "created_at": 1699061776,
          "name": "Support FAQ",
          "description": "Contains commonly asked questions and answers, organized by topic.",
          "bytes": 139920,
          "file_counts": {
            "in_progress": 0,
            "completed": 3,
            "failed": 0,
            "cancelled": 0,
            "total": 3
          }
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.VectorStores.deleteVectorStore,
  "x-oaiMeta",
  #{
    name: "Delete vector store",
    group: "vector_stores",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/vector_stores/vs_abc123 \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "Content-Type: application/json" \\
            -H "OpenAI-Beta: assistants=v2" \\
            -X DELETE
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          vector_store_deleted = client.vector_stores.delete(
              "vector_store_id",
          )
          print(vector_store_deleted.id)
          """,
        javascript: """
          import OpenAI from "openai";
          const openai = new OpenAI();
          
          async function main() {
            const deletedVectorStore = await openai.vectorStores.delete(
              "vs_abc123"
            );
            console.log(deletedVectorStore);
          }
          
          main();
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const vectorStoreDeleted = await client.vectorStores.delete('vector_store_id');
          
          console.log(vectorStoreDeleted.id);
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
          	vectorStoreDeleted, err := client.VectorStores.Delete(context.TODO(), "vector_store_id")
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", vectorStoreDeleted.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.vectorstores.VectorStoreDeleteParams;
          import com.openai.models.vectorstores.VectorStoreDeleted;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  VectorStoreDeleted vectorStoreDeleted = client.vectorStores().delete("vector_store_id");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          vector_store_deleted = openai.vector_stores.delete("vector_store_id")
          
          puts(vector_store_deleted)
          """,
      },
      response: """
        {
          id: "vs_abc123",
          object: "vector_store.deleted",
          deleted: true
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.VectorStores.getVectorStore,
  "x-oaiMeta",
  #{
    name: "Retrieve vector store",
    group: "vector_stores",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/vector_stores/vs_abc123 \\
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
          vector_store = client.vector_stores.retrieve(
              "vector_store_id",
          )
          print(vector_store.id)
          """,
        javascript: """
          import OpenAI from "openai";
          const openai = new OpenAI();
          
          async function main() {
            const vectorStore = await openai.vectorStores.retrieve(
              "vs_abc123"
            );
            console.log(vectorStore);
          }
          
          main();
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const vectorStore = await client.vectorStores.retrieve('vector_store_id');
          
          console.log(vectorStore.id);
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
          	vectorStore, err := client.VectorStores.Get(context.TODO(), "vector_store_id")
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", vectorStore.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.vectorstores.VectorStore;
          import com.openai.models.vectorstores.VectorStoreRetrieveParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  VectorStore vectorStore = client.vectorStores().retrieve("vector_store_id");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          vector_store = openai.vector_stores.retrieve("vector_store_id")
          
          puts(vector_store)
          """,
      },
      response: """
        {
          "id": "vs_abc123",
          "object": "vector_store",
          "created_at": 1699061776
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.VectorStores.modifyVectorStore,
  "x-oaiMeta",
  #{
    name: "Modify vector store",
    group: "vector_stores",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/vector_stores/vs_abc123 \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "Content-Type: application/json" \\
            -H "OpenAI-Beta: assistants=v2"
            -d '{
              "name": "Support FAQ"
            }'
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          vector_store = client.vector_stores.update(
              vector_store_id="vector_store_id",
          )
          print(vector_store.id)
          """,
        javascript: """
          import OpenAI from "openai";
          const openai = new OpenAI();
          
          async function main() {
            const vectorStore = await openai.vectorStores.update(
              "vs_abc123",
              {
                name: "Support FAQ"
              }
            );
            console.log(vectorStore);
          }
          
          main();
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const vectorStore = await client.vectorStores.update('vector_store_id');
          
          console.log(vectorStore.id);
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
          	vectorStore, err := client.VectorStores.Update(
          		context.TODO(),
          		"vector_store_id",
          		openai.VectorStoreUpdateParams{},
          	)
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", vectorStore.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.vectorstores.VectorStore;
          import com.openai.models.vectorstores.VectorStoreUpdateParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  VectorStore vectorStore = client.vectorStores().update("vector_store_id");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          vector_store = openai.vector_stores.update("vector_store_id")
          
          puts(vector_store)
          """,
      },
      response: """
        {
          "id": "vs_abc123",
          "object": "vector_store",
          "created_at": 1699061776,
          "name": "Support FAQ",
          "description": "Contains commonly asked questions and answers, organized by topic.",
          "bytes": 139920,
          "file_counts": {
            "in_progress": 0,
            "completed": 3,
            "failed": 0,
            "cancelled": 0,
            "total": 3
          }
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.VectorStores.createVectorStoreFileBatch,
  "x-oaiMeta",
  #{
    name: "Create vector store file batch",
    group: "vector_stores",
    description: """
      Attaches multiple files to a vector store in one request. This is the recommended approach for multi-file ingestion, especially because per-vector-store file attach writes are rate-limited (300 requests/minute shared with `/vector_stores/{vector_store_id}/files`).
      
      """,
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/vector_stores/vs_abc123/file_batches \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -H "Content-Type: application/json \\
              -H "OpenAI-Beta: assistants=v2" \\
              -d '{
                "files": [
                  {
                    "file_id": "file-abc123",
                    "attributes": {"category": "finance"}
                  },
                  {
                    "file_id": "file-abc456",
                    "chunking_strategy": {
                      "type": "static",
                      "max_chunk_size_tokens": 1200,
                      "chunk_overlap_tokens": 200
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
          vector_store_file_batch = client.vector_stores.file_batches.create(
              vector_store_id="vs_abc123",
          )
          print(vector_store_file_batch.id)
          """,
        javascript: """
          import OpenAI from "openai";
          const openai = new OpenAI();
          
          async function main() {
            const myVectorStoreFileBatch = await openai.vectorStores.fileBatches.create(
              "vs_abc123",
              {
                files: [
                  {
                    file_id: "file-abc123",
                    attributes: { category: "finance" },
                  },
                  {
                    file_id: "file-abc456",
                    chunking_strategy: {
                      type: "static",
                      max_chunk_size_tokens: 1200,
                      chunk_overlap_tokens: 200,
                    },
                  },
                ]
              }
            );
            console.log(myVectorStoreFileBatch);
          }
          
          main();
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const vectorStoreFileBatch = await client.vectorStores.fileBatches.create('vs_abc123');
          
          console.log(vectorStoreFileBatch.id);
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
          	vectorStoreFileBatch, err := client.VectorStores.FileBatches.New(
          		context.TODO(),
          		"vs_abc123",
          		openai.VectorStoreFileBatchNewParams{},
          	)
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", vectorStoreFileBatch.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.vectorstores.filebatches.FileBatchCreateParams;
          import com.openai.models.vectorstores.filebatches.VectorStoreFileBatch;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  VectorStoreFileBatch vectorStoreFileBatch = client.vectorStores().fileBatches().create("vs_abc123");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          vector_store_file_batch = openai.vector_stores.file_batches.create("vs_abc123")
          
          puts(vector_store_file_batch)
          """,
      },
      response: """
        {
          "id": "vsfb_abc123",
          "object": "vector_store.file_batch",
          "created_at": 1699061776,
          "vector_store_id": "vs_abc123",
          "status": "in_progress",
          "file_counts": {
            "in_progress": 1,
            "completed": 1,
            "failed": 0,
            "cancelled": 0,
            "total": 0,
          }
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.VectorStores.getVectorStoreFileBatch,
  "x-oaiMeta",
  #{
    name: "Retrieve vector store file batch",
    group: "vector_stores",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/vector_stores/vs_abc123/file_batches/vsfb_abc123 \\
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
          vector_store_file_batch = client.vector_stores.file_batches.retrieve(
              batch_id="vsfb_abc123",
              vector_store_id="vs_abc123",
          )
          print(vector_store_file_batch.id)
          """,
        javascript: """
          import OpenAI from "openai";
          const openai = new OpenAI();
          
          async function main() {
            const vectorStoreFileBatch = await openai.vectorStores.fileBatches.retrieve(
              "vsfb_abc123",
              { vector_store_id: "vs_abc123" }
            );
            console.log(vectorStoreFileBatch);
          }
          
          main();
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const vectorStoreFileBatch = await client.vectorStores.fileBatches.retrieve('vsfb_abc123', {
            vector_store_id: 'vs_abc123',
          });
          
          console.log(vectorStoreFileBatch.id);
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
          	vectorStoreFileBatch, err := client.VectorStores.FileBatches.Get(
          		context.TODO(),
          		"vs_abc123",
          		"vsfb_abc123",
          	)
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", vectorStoreFileBatch.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.vectorstores.filebatches.FileBatchRetrieveParams;
          import com.openai.models.vectorstores.filebatches.VectorStoreFileBatch;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  FileBatchRetrieveParams params = FileBatchRetrieveParams.builder()
                      .vectorStoreId("vs_abc123")
                      .batchId("vsfb_abc123")
                      .build();
                  VectorStoreFileBatch vectorStoreFileBatch = client.vectorStores().fileBatches().retrieve(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          vector_store_file_batch = openai.vector_stores.file_batches.retrieve("vsfb_abc123", vector_store_id: "vs_abc123")
          
          puts(vector_store_file_batch)
          """,
      },
      response: """
        {
          "id": "vsfb_abc123",
          "object": "vector_store.file_batch",
          "created_at": 1699061776,
          "vector_store_id": "vs_abc123",
          "status": "in_progress",
          "file_counts": {
            "in_progress": 1,
            "completed": 1,
            "failed": 0,
            "cancelled": 0,
            "total": 0,
          }
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.VectorStores.cancelVectorStoreFileBatch,
  "x-oaiMeta",
  #{
    name: "Cancel vector store file batch",
    group: "vector_stores",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/vector_stores/vs_abc123/files_batches/vsfb_abc123/cancel \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "Content-Type: application/json" \\
            -H "OpenAI-Beta: assistants=v2" \\
            -X POST
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          vector_store_file_batch = client.vector_stores.file_batches.cancel(
              batch_id="batch_id",
              vector_store_id="vector_store_id",
          )
          print(vector_store_file_batch.id)
          """,
        javascript: """
          import OpenAI from "openai";
          const openai = new OpenAI();
          
          async function main() {
            const deletedVectorStoreFileBatch = await openai.vectorStores.fileBatches.cancel(
              "vsfb_abc123",
              { vector_store_id: "vs_abc123" }
            );
            console.log(deletedVectorStoreFileBatch);
          }
          
          main();
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const vectorStoreFileBatch = await client.vectorStores.fileBatches.cancel('batch_id', {
            vector_store_id: 'vector_store_id',
          });
          
          console.log(vectorStoreFileBatch.id);
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
          	vectorStoreFileBatch, err := client.VectorStores.FileBatches.Cancel(
          		context.TODO(),
          		"vector_store_id",
          		"batch_id",
          	)
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", vectorStoreFileBatch.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.vectorstores.filebatches.FileBatchCancelParams;
          import com.openai.models.vectorstores.filebatches.VectorStoreFileBatch;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  FileBatchCancelParams params = FileBatchCancelParams.builder()
                      .vectorStoreId("vector_store_id")
                      .batchId("batch_id")
                      .build();
                  VectorStoreFileBatch vectorStoreFileBatch = client.vectorStores().fileBatches().cancel(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          vector_store_file_batch = openai.vector_stores.file_batches.cancel("batch_id", vector_store_id: "vector_store_id")
          
          puts(vector_store_file_batch)
          """,
      },
      response: """
        {
          "id": "vsfb_abc123",
          "object": "vector_store.file_batch",
          "created_at": 1699061776,
          "vector_store_id": "vs_abc123",
          "status": "in_progress",
          "file_counts": {
            "in_progress": 12,
            "completed": 3,
            "failed": 0,
            "cancelled": 0,
            "total": 15,
          }
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.VectorStores.listFilesInVectorStoreBatch,
  "x-oaiMeta",
  #{
    name: "List vector store files in a batch",
    group: "vector_stores",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/vector_stores/vs_abc123/files_batches/vsfb_abc123/files \\
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
          page = client.vector_stores.file_batches.list_files(
              batch_id="batch_id",
              vector_store_id="vector_store_id",
          )
          page = page.data[0]
          print(page.id)
          """,
        javascript: """
          import OpenAI from "openai";
          const openai = new OpenAI();
          
          async function main() {
            const vectorStoreFiles = await openai.vectorStores.fileBatches.listFiles(
              "vsfb_abc123",
              { vector_store_id: "vs_abc123" }
            );
            console.log(vectorStoreFiles);
          }
          
          main();
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          // Automatically fetches more pages as needed.
          for await (const vectorStoreFile of client.vectorStores.fileBatches.listFiles('batch_id', {
            vector_store_id: 'vector_store_id',
          })) {
            console.log(vectorStoreFile.id);
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
          	page, err := client.VectorStores.FileBatches.ListFiles(
          		context.TODO(),
          		"vector_store_id",
          		"batch_id",
          		openai.VectorStoreFileBatchListFilesParams{},
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
          import com.openai.models.vectorstores.filebatches.FileBatchListFilesPage;
          import com.openai.models.vectorstores.filebatches.FileBatchListFilesParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  FileBatchListFilesParams params = FileBatchListFilesParams.builder()
                      .vectorStoreId("vector_store_id")
                      .batchId("batch_id")
                      .build();
                  FileBatchListFilesPage page = client.vectorStores().fileBatches().listFiles(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          page = openai.vector_stores.file_batches.list_files("batch_id", vector_store_id: "vector_store_id")
          
          puts(page)
          """,
      },
      response: """
        {
          "object": "list",
          "data": [
            {
              "id": "file-abc123",
              "object": "vector_store.file",
              "created_at": 1699061776,
              "vector_store_id": "vs_abc123"
            },
            {
              "id": "file-abc456",
              "object": "vector_store.file",
              "created_at": 1699061776,
              "vector_store_id": "vs_abc123"
            }
          ],
          "first_id": "file-abc123",
          "last_id": "file-abc456",
          "has_more": false
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.VectorStores.listFilesInVectorStoreBatch,
  "x-ms-list",
  true
);

@@extension(
  Azure.AI.Projects.VectorStores.listVectorStoreFiles,
  "x-oaiMeta",
  #{
    name: "List vector store files",
    group: "vector_stores",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/vector_stores/vs_abc123/files \\
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
          page = client.vector_stores.files.list(
              vector_store_id="vector_store_id",
          )
          page = page.data[0]
          print(page.id)
          """,
        javascript: """
          import OpenAI from "openai";
          const openai = new OpenAI();
          
          async function main() {
            const vectorStoreFiles = await openai.vectorStores.files.list(
              "vs_abc123"
            );
            console.log(vectorStoreFiles);
          }
          
          main();
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          // Automatically fetches more pages as needed.
          for await (const vectorStoreFile of client.vectorStores.files.list('vector_store_id')) {
            console.log(vectorStoreFile.id);
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
          	page, err := client.VectorStores.Files.List(
          		context.TODO(),
          		"vector_store_id",
          		openai.VectorStoreFileListParams{},
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
          import com.openai.models.vectorstores.files.FileListPage;
          import com.openai.models.vectorstores.files.FileListParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  FileListPage page = client.vectorStores().files().list("vector_store_id");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          page = openai.vector_stores.files.list("vector_store_id")
          
          puts(page)
          """,
      },
      response: """
        {
          "object": "list",
          "data": [
            {
              "id": "file-abc123",
              "object": "vector_store.file",
              "created_at": 1699061776,
              "vector_store_id": "vs_abc123"
            },
            {
              "id": "file-abc456",
              "object": "vector_store.file",
              "created_at": 1699061776,
              "vector_store_id": "vs_abc123"
            }
          ],
          "first_id": "file-abc123",
          "last_id": "file-abc456",
          "has_more": false
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.VectorStores.listVectorStoreFiles,
  "x-ms-list",
  true
);

@@extension(
  Azure.AI.Projects.VectorStores.createVectorStoreFile,
  "x-oaiMeta",
  #{
    name: "Create vector store file",
    group: "vector_stores",
    description: """
      Attaches one file to a vector store. File attach writes are rate-limited per vector store (300 requests/minute shared with `/vector_stores/{vector_store_id}/file_batches`), so use file batches when uploading multiple files.
      
      """,
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/vector_stores/vs_abc123/files \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -H "Content-Type: application/json" \\
              -H "OpenAI-Beta: assistants=v2" \\
              -d '{
                "file_id": "file-abc123"
              }'
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          vector_store_file = client.vector_stores.files.create(
              vector_store_id="vs_abc123",
              file_id="file_id",
          )
          print(vector_store_file.id)
          """,
        javascript: """
          import OpenAI from "openai";
          const openai = new OpenAI();
          
          async function main() {
            const myVectorStoreFile = await openai.vectorStores.files.create(
              "vs_abc123",
              {
                file_id: "file-abc123"
              }
            );
            console.log(myVectorStoreFile);
          }
          
          main();
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const vectorStoreFile = await client.vectorStores.files.create('vs_abc123', { file_id: 'file_id' });
          
          console.log(vectorStoreFile.id);
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
          	vectorStoreFile, err := client.VectorStores.Files.New(
          		context.TODO(),
          		"vs_abc123",
          		openai.VectorStoreFileNewParams{
          			FileID: "file_id",
          		},
          	)
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", vectorStoreFile.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.vectorstores.files.FileCreateParams;
          import com.openai.models.vectorstores.files.VectorStoreFile;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  FileCreateParams params = FileCreateParams.builder()
                      .vectorStoreId("vs_abc123")
                      .fileId("file_id")
                      .build();
                  VectorStoreFile vectorStoreFile = client.vectorStores().files().create(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          vector_store_file = openai.vector_stores.files.create("vs_abc123", file_id: "file_id")
          
          puts(vector_store_file)
          """,
      },
      response: """
        {
          "id": "file-abc123",
          "object": "vector_store.file",
          "created_at": 1699061776,
          "usage_bytes": 1234,
          "vector_store_id": "vs_abcd",
          "status": "completed",
          "last_error": null
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.VectorStores.deleteVectorStoreFile,
  "x-oaiMeta",
  #{
    name: "Delete vector store file",
    group: "vector_stores",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/vector_stores/vs_abc123/files/file-abc123 \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "Content-Type: application/json" \\
            -H "OpenAI-Beta: assistants=v2" \\
            -X DELETE
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          vector_store_file_deleted = client.vector_stores.files.delete(
              file_id="file_id",
              vector_store_id="vector_store_id",
          )
          print(vector_store_file_deleted.id)
          """,
        javascript: """
          import OpenAI from "openai";
          const openai = new OpenAI();
          
          async function main() {
            const deletedVectorStoreFile = await openai.vectorStores.files.delete(
              "file-abc123",
              { vector_store_id: "vs_abc123" }
            );
            console.log(deletedVectorStoreFile);
          }
          
          main();
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const vectorStoreFileDeleted = await client.vectorStores.files.delete('file_id', {
            vector_store_id: 'vector_store_id',
          });
          
          console.log(vectorStoreFileDeleted.id);
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
          	vectorStoreFileDeleted, err := client.VectorStores.Files.Delete(
          		context.TODO(),
          		"vector_store_id",
          		"file_id",
          	)
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", vectorStoreFileDeleted.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.vectorstores.files.FileDeleteParams;
          import com.openai.models.vectorstores.files.VectorStoreFileDeleted;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  FileDeleteParams params = FileDeleteParams.builder()
                      .vectorStoreId("vector_store_id")
                      .fileId("file_id")
                      .build();
                  VectorStoreFileDeleted vectorStoreFileDeleted = client.vectorStores().files().delete(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          vector_store_file_deleted = openai.vector_stores.files.delete("file_id", vector_store_id: "vector_store_id")
          
          puts(vector_store_file_deleted)
          """,
      },
      response: """
        {
          id: "file-abc123",
          object: "vector_store.file.deleted",
          deleted: true
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.VectorStores.getVectorStoreFile,
  "x-oaiMeta",
  #{
    name: "Retrieve vector store file",
    group: "vector_stores",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/vector_stores/vs_abc123/files/file-abc123 \\
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
          vector_store_file = client.vector_stores.files.retrieve(
              file_id="file-abc123",
              vector_store_id="vs_abc123",
          )
          print(vector_store_file.id)
          """,
        javascript: """
          import OpenAI from "openai";
          const openai = new OpenAI();
          
          async function main() {
            const vectorStoreFile = await openai.vectorStores.files.retrieve(
              "file-abc123",
              { vector_store_id: "vs_abc123" }
            );
            console.log(vectorStoreFile);
          }
          
          main();
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const vectorStoreFile = await client.vectorStores.files.retrieve('file-abc123', {
            vector_store_id: 'vs_abc123',
          });
          
          console.log(vectorStoreFile.id);
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
          	vectorStoreFile, err := client.VectorStores.Files.Get(
          		context.TODO(),
          		"vs_abc123",
          		"file-abc123",
          	)
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", vectorStoreFile.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.vectorstores.files.FileRetrieveParams;
          import com.openai.models.vectorstores.files.VectorStoreFile;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  FileRetrieveParams params = FileRetrieveParams.builder()
                      .vectorStoreId("vs_abc123")
                      .fileId("file-abc123")
                      .build();
                  VectorStoreFile vectorStoreFile = client.vectorStores().files().retrieve(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          vector_store_file = openai.vector_stores.files.retrieve("file-abc123", vector_store_id: "vs_abc123")
          
          puts(vector_store_file)
          """,
      },
      response: """
        {
          "id": "file-abc123",
          "object": "vector_store.file",
          "created_at": 1699061776,
          "vector_store_id": "vs_abcd",
          "status": "completed",
          "last_error": null
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.VectorStores.updateVectorStoreFileAttributes,
  "x-oaiMeta",
  #{
    name: "Update vector store file attributes",
    group: "vector_stores",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/vector_stores/{vector_store_id}/files/{file_id} \\
            -H "Authorization: Bearer $OPENAI_API_KEY" \\
            -H "Content-Type: application/json" \\
            -d '{"attributes": {"key1": "value1", "key2": 2}}'
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const vectorStoreFile = await client.vectorStores.files.update('file-abc123', {
            vector_store_id: 'vs_abc123',
            attributes: { foo: 'string' },
          });
          
          console.log(vectorStoreFile.id);
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          vector_store_file = client.vector_stores.files.update(
              file_id="file-abc123",
              vector_store_id="vs_abc123",
              attributes={
                  "foo": "string"
              },
          )
          print(vector_store_file.id)
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
          	vectorStoreFile, err := client.VectorStores.Files.Update(
          		context.TODO(),
          		"vs_abc123",
          		"file-abc123",
          		openai.VectorStoreFileUpdateParams{
          			Attributes: map[string]openai.VectorStoreFileUpdateParamsAttributeUnion{
          				"foo": {
          					OfString: openai.String("string"),
          				},
          			},
          		},
          	)
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", vectorStoreFile.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.core.JsonValue;
          import com.openai.models.vectorstores.files.FileUpdateParams;
          import com.openai.models.vectorstores.files.VectorStoreFile;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  FileUpdateParams params = FileUpdateParams.builder()
                      .vectorStoreId("vs_abc123")
                      .fileId("file-abc123")
                      .attributes(FileUpdateParams.Attributes.builder()
                          .putAdditionalProperty("foo", JsonValue.from("string"))
                          .build())
                      .build();
                  VectorStoreFile vectorStoreFile = client.vectorStores().files().update(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          vector_store_file = openai.vector_stores.files.update(
            "file-abc123",
            vector_store_id: "vs_abc123",
            attributes: {foo: "string"}
          )
          
          puts(vector_store_file)
          """,
      },
      response: """
        {
          "id": "file-abc123",
          "object": "vector_store.file",
          "usage_bytes": 1234,
          "created_at": 1699061776,
          "vector_store_id": "vs_abcd",
          "status": "completed",
          "last_error": null,
          "chunking_strategy": {...},
          "attributes": {"key1": "value1", "key2": 2}
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.VectorStores.retrieveVectorStoreFileContent,
  "x-oaiMeta",
  #{
    name: "Retrieve vector store file content",
    group: "vector_stores",
    examples: #{
      request: #{
        curl: """
          curl \\
          https://api.openai.com/v1/vector_stores/vs_abc123/files/file-abc123/content \\
          -H "Authorization: Bearer $OPENAI_API_KEY"
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          // Automatically fetches more pages as needed.
          for await (const fileContentResponse of client.vectorStores.files.content('file-abc123', {
            vector_store_id: 'vs_abc123',
          })) {
            console.log(fileContentResponse.text);
          }
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          page = client.vector_stores.files.content(
              file_id="file-abc123",
              vector_store_id="vs_abc123",
          )
          page = page.data[0]
          print(page.text)
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
          	page, err := client.VectorStores.Files.Content(
          		context.TODO(),
          		"vs_abc123",
          		"file-abc123",
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
          import com.openai.models.vectorstores.files.FileContentPage;
          import com.openai.models.vectorstores.files.FileContentParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  FileContentParams params = FileContentParams.builder()
                      .vectorStoreId("vs_abc123")
                      .fileId("file-abc123")
                      .build();
                  FileContentPage page = client.vectorStores().files().content(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          page = openai.vector_stores.files.content("file-abc123", vector_store_id: "vs_abc123")
          
          puts(page)
          """,
      },
      response: """
        {
          "file_id": "file-abc123",
          "filename": "example.txt",
          "attributes": {"key": "value"},
          "content": [
            {"type": "text", "text": "..."},
            ...
          ]
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.VectorStores.searchVectorStore,
  "x-oaiMeta",
  #{
    name: "Search vector store",
    group: "vector_stores",
    examples: #{
      request: #{
        curl: """
          curl -X POST \\
          https://api.openai.com/v1/vector_stores/vs_abc123/search \\
          -H "Authorization: Bearer $OPENAI_API_KEY" \\
          -H "Content-Type: application/json" \\
          -d '{"query": "What is the return policy?", "filters": {...}}'
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          // Automatically fetches more pages as needed.
          for await (const vectorStoreSearchResponse of client.vectorStores.search('vs_abc123', {
            query: 'string',
          })) {
            console.log(vectorStoreSearchResponse.file_id);
          }
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          page = client.vector_stores.search(
              vector_store_id="vs_abc123",
              query="string",
          )
          page = page.data[0]
          print(page.file_id)
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
          	page, err := client.VectorStores.Search(
          		context.TODO(),
          		"vs_abc123",
          		openai.VectorStoreSearchParams{
          			Query: openai.VectorStoreSearchParamsQueryUnion{
          				OfString: openai.String("string"),
          			},
          		},
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
          import com.openai.models.vectorstores.VectorStoreSearchPage;
          import com.openai.models.vectorstores.VectorStoreSearchParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  VectorStoreSearchParams params = VectorStoreSearchParams.builder()
                      .vectorStoreId("vs_abc123")
                      .query("string")
                      .build();
                  VectorStoreSearchPage page = client.vectorStores().search(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          page = openai.vector_stores.search("vs_abc123", query: "string")
          
          puts(page)
          """,
      },
      response: """
        {
          "object": "vector_store.search_results.page",
          "search_query": "What is the return policy?",
          "data": [
            {
              "file_id": "file_123",
              "filename": "document.pdf",
              "score": 0.95,
              "attributes": {
                "author": "John Doe",
                "date": "2023-01-01"
              },
              "content": [
                {
                  "type": "text",
                  "text": "Relevant chunk"
                }
              ]
            },
            {
              "file_id": "file_456",
              "filename": "notes.txt",
              "score": 0.89,
              "attributes": {
                "author": "Jane Smith",
                "date": "2023-01-02"
              },
              "content": [
                {
                  "type": "text",
                  "text": "Sample text content from the vector store."
                }
              ]
            }
          ],
          "has_more": false,
          "next_page": null
        }
        
        """,
    },
  }
);
