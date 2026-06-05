import "./routes.tsp";
import "@typespec/openapi";
using TypeSpec.OpenAPI;
namespace Azure.AI.Projects;
@@extension(
  Azure.AI.Projects.FineTuning.listFineTuningCheckpointPermissions,
  "x-oaiMeta",
  #{
    name: "List checkpoint permissions",
    group: "fine-tuning",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/fine_tuning/checkpoints/ft:gpt-4o-mini-2024-07-18:org:weather:B7R9VjQd/permissions \\
            -H "Authorization: Bearer $OPENAI_API_KEY"
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const permission = await client.fineTuning.checkpoints.permissions.retrieve(
            'ft-AF1WoRqd3aJAHsqc9NY7iL8F',
          );
          
          console.log(permission.first_id);
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          permission = client.fine_tuning.checkpoints.permissions.retrieve(
              fine_tuned_model_checkpoint="ft-AF1WoRqd3aJAHsqc9NY7iL8F",
          )
          print(permission.first_id)
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
          	permission, err := client.FineTuning.Checkpoints.Permissions.Get(
          		context.TODO(),
          		"ft-AF1WoRqd3aJAHsqc9NY7iL8F",
          		openai.FineTuningCheckpointPermissionGetParams{},
          	)
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", permission.FirstID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.finetuning.checkpoints.permissions.PermissionRetrieveParams;
          import com.openai.models.finetuning.checkpoints.permissions.PermissionRetrieveResponse;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  PermissionRetrieveResponse permission = client.fineTuning().checkpoints().permissions().retrieve("ft-AF1WoRqd3aJAHsqc9NY7iL8F");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          permission = openai.fine_tuning.checkpoints.permissions.retrieve("ft-AF1WoRqd3aJAHsqc9NY7iL8F")
          
          puts(permission)
          """,
      },
      response: """
        {
          "object": "list",
          "data": [
            {
              "object": "checkpoint.permission",
              "id": "cp_zc4Q7MP6XxulcVzj4MZdwsAB",
              "created_at": 1721764867,
              "project_id": "proj_abGMw1llN8IrBb6SvvY5A1iH"
            },
            {
              "object": "checkpoint.permission",
              "id": "cp_enQCFmOTGj3syEpYVhBRLTSy",
              "created_at": 1721764800,
              "project_id": "proj_iqGMw1llN8IrBb6SvvY5A1oF"
            },
          ],
          "first_id": "cp_zc4Q7MP6XxulcVzj4MZdwsAB",
          "last_id": "cp_enQCFmOTGj3syEpYVhBRLTSy",
          "has_more": false
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.FineTuning.listFineTuningCheckpointPermissions,
  "x-ms-list",
  true
);

@@extension(
  Azure.AI.Projects.FineTuning.createFineTuningCheckpointPermission,
  "x-oaiMeta",
  #{
    name: "Create checkpoint permissions",
    group: "fine-tuning",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/fine_tuning/checkpoints/ft:gpt-4o-mini-2024-07-18:org:weather:B7R9VjQd/permissions \\
            -H "Authorization: Bearer $OPENAI_API_KEY"
            -d '{"project_ids": ["proj_abGMw1llN8IrBb6SvvY5A1iH"]}'
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          // Automatically fetches more pages as needed.
          for await (const permissionCreateResponse of client.fineTuning.checkpoints.permissions.create(
            'ft:gpt-4o-mini-2024-07-18:org:weather:B7R9VjQd',
            { project_ids: ['string'] },
          )) {
            console.log(permissionCreateResponse.id);
          }
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          page = client.fine_tuning.checkpoints.permissions.create(
              fine_tuned_model_checkpoint="ft:gpt-4o-mini-2024-07-18:org:weather:B7R9VjQd",
              project_ids=["string"],
          )
          page = page.data[0]
          print(page.id)
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
          	page, err := client.FineTuning.Checkpoints.Permissions.New(
          		context.TODO(),
          		"ft:gpt-4o-mini-2024-07-18:org:weather:B7R9VjQd",
          		openai.FineTuningCheckpointPermissionNewParams{
          			ProjectIDs: []string{"string"},
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
          import com.openai.models.finetuning.checkpoints.permissions.PermissionCreatePage;
          import com.openai.models.finetuning.checkpoints.permissions.PermissionCreateParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  PermissionCreateParams params = PermissionCreateParams.builder()
                      .fineTunedModelCheckpoint("ft:gpt-4o-mini-2024-07-18:org:weather:B7R9VjQd")
                      .addProjectId("string")
                      .build();
                  PermissionCreatePage page = client.fineTuning().checkpoints().permissions().create(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          page = openai.fine_tuning.checkpoints.permissions.create(
            "ft:gpt-4o-mini-2024-07-18:org:weather:B7R9VjQd",
            project_ids: ["string"]
          )
          
          puts(page)
          """,
      },
      response: """
        {
          "object": "list",
          "data": [
            {
              "object": "checkpoint.permission",
              "id": "cp_zc4Q7MP6XxulcVzj4MZdwsAB",
              "created_at": 1721764867,
              "project_id": "proj_abGMw1llN8IrBb6SvvY5A1iH"
            }
          ],
          "first_id": "cp_zc4Q7MP6XxulcVzj4MZdwsAB",
          "last_id": "cp_zc4Q7MP6XxulcVzj4MZdwsAB",
          "has_more": false
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.FineTuning.deleteFineTuningCheckpointPermission,
  "x-oaiMeta",
  #{
    name: "Delete checkpoint permission",
    group: "fine-tuning",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/fine_tuning/checkpoints/ft:gpt-4o-mini-2024-07-18:org:weather:B7R9VjQd/permissions/cp_zc4Q7MP6XxulcVzj4MZdwsAB \\
            -H "Authorization: Bearer $OPENAI_API_KEY"
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const permission = await client.fineTuning.checkpoints.permissions.delete(
            'cp_zc4Q7MP6XxulcVzj4MZdwsAB',
            { fine_tuned_model_checkpoint: 'ft:gpt-4o-mini-2024-07-18:org:weather:B7R9VjQd' },
          );
          
          console.log(permission.id);
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          permission = client.fine_tuning.checkpoints.permissions.delete(
              permission_id="cp_zc4Q7MP6XxulcVzj4MZdwsAB",
              fine_tuned_model_checkpoint="ft:gpt-4o-mini-2024-07-18:org:weather:B7R9VjQd",
          )
          print(permission.id)
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
          	permission, err := client.FineTuning.Checkpoints.Permissions.Delete(
          		context.TODO(),
          		"ft:gpt-4o-mini-2024-07-18:org:weather:B7R9VjQd",
          		"cp_zc4Q7MP6XxulcVzj4MZdwsAB",
          	)
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", permission.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.finetuning.checkpoints.permissions.PermissionDeleteParams;
          import com.openai.models.finetuning.checkpoints.permissions.PermissionDeleteResponse;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  PermissionDeleteParams params = PermissionDeleteParams.builder()
                      .fineTunedModelCheckpoint("ft:gpt-4o-mini-2024-07-18:org:weather:B7R9VjQd")
                      .permissionId("cp_zc4Q7MP6XxulcVzj4MZdwsAB")
                      .build();
                  PermissionDeleteResponse permission = client.fineTuning().checkpoints().permissions().delete(params);
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          permission = openai.fine_tuning.checkpoints.permissions.delete(
            "cp_zc4Q7MP6XxulcVzj4MZdwsAB",
            fine_tuned_model_checkpoint: "ft:gpt-4o-mini-2024-07-18:org:weather:B7R9VjQd"
          )
          
          puts(permission)
          """,
      },
      response: """
        {
          "object": "checkpoint.permission",
          "id": "cp_zc4Q7MP6XxulcVzj4MZdwsAB",
          "deleted": true
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.FineTuning.listPaginatedFineTuningJobs,
  "x-oaiMeta",
  #{
    name: "List fine-tuning jobs",
    group: "fine-tuning",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/fine_tuning/jobs?limit=2&metadata[key]=value \\
            -H "Authorization: Bearer $OPENAI_API_KEY"
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          page = client.fine_tuning.jobs.list()
          page = page.data[0]
          print(page.id)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          async function main() {
            const list = await openai.fineTuning.jobs.list();
          
            for await (const fineTune of list) {
              console.log(fineTune);
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
          for await (const fineTuningJob of client.fineTuning.jobs.list()) {
            console.log(fineTuningJob.id);
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
          	page, err := client.FineTuning.Jobs.List(context.TODO(), openai.FineTuningJobListParams{})
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
          import com.openai.models.finetuning.jobs.JobListPage;
          import com.openai.models.finetuning.jobs.JobListParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  JobListPage page = client.fineTuning().jobs().list();
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          page = openai.fine_tuning.jobs.list
          
          puts(page)
          """,
      },
      response: """
        {
          "object": "list",
          "data": [
            {
              "object": "fine_tuning.job",
              "id": "ftjob-abc123",
              "model": "gpt-4o-mini-2024-07-18",
              "created_at": 1721764800,
              "fine_tuned_model": null,
              "organization_id": "org-123",
              "result_files": [],
              "status": "queued",
              "validation_file": null,
              "training_file": "file-abc123",
              "metadata": {
                "key": "value"
              }
            },
            { ... },
            { ... }
          ], "has_more": true
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.FineTuning.listPaginatedFineTuningJobs,
  "x-ms-list",
  true
);

@@extension(
  Azure.AI.Projects.FineTuning.createFineTuningJob,
  "x-oaiMeta",
  #{
    name: "Create fine-tuning job",
    group: "fine-tuning",
    examples: #[
      #{
        title: "Default",
        request: #{
          curl: """
            curl https://api.openai.com/v1/fine_tuning/jobs \\
              -H "Content-Type: application/json" \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -d '{
                "training_file": "file-BK7bzQj3FfZFXr7DbL6xJwfo",
                "model": "gpt-4o-mini"
              }'
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            fine_tuning_job = client.fine_tuning.jobs.create(
                model="gpt-4o-mini",
                training_file="file-abc123",
            )
            print(fine_tuning_job.id)
            """,
          javascript: """
            import OpenAI from "openai";
            
            const openai = new OpenAI();
            
            async function main() {
              const fineTune = await openai.fineTuning.jobs.create({
                training_file: "file-abc123"
              });
            
              console.log(fineTune);
            }
            
            main();
            
            """,
          `node.js`: """
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const fineTuningJob = await client.fineTuning.jobs.create({
              model: 'gpt-4o-mini',
              training_file: 'file-abc123',
            });
            
            console.log(fineTuningJob.id);
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
            	fineTuningJob, err := client.FineTuning.Jobs.New(context.TODO(), openai.FineTuningJobNewParams{
            		Model:        openai.FineTuningJobNewParamsModelGPT4oMini,
            		TrainingFile: "file-abc123",
            	})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", fineTuningJob.ID)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.finetuning.jobs.FineTuningJob;
            import com.openai.models.finetuning.jobs.JobCreateParams;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    JobCreateParams params = JobCreateParams.builder()
                        .model(JobCreateParams.Model.GPT_4O_MINI)
                        .trainingFile("file-abc123")
                        .build();
                    FineTuningJob fineTuningJob = client.fineTuning().jobs().create(params);
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            fine_tuning_job = openai.fine_tuning.jobs.create(model: :"gpt-4o-mini", training_file: "file-abc123")
            
            puts(fine_tuning_job)
            """,
        },
        response: """
          {
            "object": "fine_tuning.job",
            "id": "ftjob-abc123",
            "model": "gpt-4o-mini-2024-07-18",
            "created_at": 1721764800,
            "fine_tuned_model": null,
            "organization_id": "org-123",
            "result_files": [],
            "status": "queued",
            "validation_file": null,
            "training_file": "file-abc123",
            "method": {
              "type": "supervised",
              "supervised": {
                "hyperparameters": {
                  "batch_size": "auto",
                  "learning_rate_multiplier": "auto",
                  "n_epochs": "auto",
                }
              }
            },
            "metadata": null
          }
          
          """,
      },
      #{
        title: "Epochs",
        request: #{
          curl: """
            curl https://api.openai.com/v1/fine_tuning/jobs \\
              -H "Content-Type: application/json" \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -d '{
                "training_file": "file-abc123",
                "model": "gpt-4o-mini",
                "method": {
                  "type": "supervised",
                  "supervised": {
                    "hyperparameters": {
                      "n_epochs": 2
                    }
                  }
                }
              }'
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            fine_tuning_job = client.fine_tuning.jobs.create(
                model="gpt-4o-mini",
                training_file="file-abc123",
            )
            print(fine_tuning_job.id)
            """,
          javascript: """
            import OpenAI from "openai";
            import { SupervisedMethod, SupervisedHyperparameters } from "openai/resources/fine-tuning/methods";
            
            const openai = new OpenAI();
            
            async function main() {
              const fineTune = await openai.fineTuning.jobs.create({
                training_file: "file-abc123",
                model: "gpt-4o-mini",
                method: {
                  type: "supervised",
                  supervised: {
                    hyperparameters: {
                      n_epochs: 2
                    }
                  }
                }
              });
            
              console.log(fineTune);
            }
            
            main();
            
            """,
          `node.js`: """
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const fineTuningJob = await client.fineTuning.jobs.create({
              model: 'gpt-4o-mini',
              training_file: 'file-abc123',
            });
            
            console.log(fineTuningJob.id);
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
            	fineTuningJob, err := client.FineTuning.Jobs.New(context.TODO(), openai.FineTuningJobNewParams{
            		Model:        openai.FineTuningJobNewParamsModelGPT4oMini,
            		TrainingFile: "file-abc123",
            	})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", fineTuningJob.ID)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.finetuning.jobs.FineTuningJob;
            import com.openai.models.finetuning.jobs.JobCreateParams;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    JobCreateParams params = JobCreateParams.builder()
                        .model(JobCreateParams.Model.GPT_4O_MINI)
                        .trainingFile("file-abc123")
                        .build();
                    FineTuningJob fineTuningJob = client.fineTuning().jobs().create(params);
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            fine_tuning_job = openai.fine_tuning.jobs.create(model: :"gpt-4o-mini", training_file: "file-abc123")
            
            puts(fine_tuning_job)
            """,
        },
        response: """
          {
            "object": "fine_tuning.job",
            "id": "ftjob-abc123",
            "model": "gpt-4o-mini",
            "created_at": 1721764800,
            "fine_tuned_model": null,
            "organization_id": "org-123",
            "result_files": [],
            "status": "queued",
            "validation_file": null,
            "training_file": "file-abc123",
            "hyperparameters": {
              "batch_size": "auto",
              "learning_rate_multiplier": "auto",
              "n_epochs": 2
            },
            "method": {
              "type": "supervised",
              "supervised": {
                "hyperparameters": {
                  "batch_size": "auto",
                  "learning_rate_multiplier": "auto",
                  "n_epochs": 2
                }
              }
            },
            "metadata": null,
            "error": {
              "code": null,
              "message": null,
              "param": null
            },
            "finished_at": null,
            "seed": 683058546,
            "trained_tokens": null,
            "estimated_finish": null,
            "integrations": [],
            "user_provided_suffix": null,
            "usage_metrics": null,
            "shared_with_openai": false
          }
          
          """,
      },
      #{
        title: "DPO",
        request: #{
          curl: """
            curl https://api.openai.com/v1/fine_tuning/jobs \\
              -H "Content-Type: application/json" \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -d '{
                "training_file": "file-abc123",
                "validation_file": "file-abc123",
                "model": "gpt-4o-mini",
                "method": {
                  "type": "dpo",
                  "dpo": {
                    "hyperparameters": {
                      "beta": 0.1
                    }
                  }
                }
              }'
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            fine_tuning_job = client.fine_tuning.jobs.create(
                model="gpt-4o-mini",
                training_file="file-abc123",
            )
            print(fine_tuning_job.id)
            """,
          `node.js`: """
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const fineTuningJob = await client.fineTuning.jobs.create({
              model: 'gpt-4o-mini',
              training_file: 'file-abc123',
            });
            
            console.log(fineTuningJob.id);
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
            	fineTuningJob, err := client.FineTuning.Jobs.New(context.TODO(), openai.FineTuningJobNewParams{
            		Model:        openai.FineTuningJobNewParamsModelGPT4oMini,
            		TrainingFile: "file-abc123",
            	})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", fineTuningJob.ID)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.finetuning.jobs.FineTuningJob;
            import com.openai.models.finetuning.jobs.JobCreateParams;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    JobCreateParams params = JobCreateParams.builder()
                        .model(JobCreateParams.Model.GPT_4O_MINI)
                        .trainingFile("file-abc123")
                        .build();
                    FineTuningJob fineTuningJob = client.fineTuning().jobs().create(params);
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            fine_tuning_job = openai.fine_tuning.jobs.create(model: :"gpt-4o-mini", training_file: "file-abc123")
            
            puts(fine_tuning_job)
            """,
        },
        response: """
          {
            "object": "fine_tuning.job",
            "id": "ftjob-abc",
            "model": "gpt-4o-mini",
            "created_at": 1746130590,
            "fine_tuned_model": null,
            "organization_id": "org-abc",
            "result_files": [],
            "status": "queued",
            "validation_file": "file-123",
            "training_file": "file-abc",
            "method": {
              "type": "dpo",
              "dpo": {
                "hyperparameters": {
                  "beta": 0.1,
                  "batch_size": "auto",
                  "learning_rate_multiplier": "auto",
                  "n_epochs": "auto"
                }
              }
            },
            "metadata": null,
            "error": {
              "code": null,
              "message": null,
              "param": null
            },
            "finished_at": null,
            "hyperparameters": null,
            "seed": 1036326793,
            "estimated_finish": null,
            "integrations": [],
            "user_provided_suffix": null,
            "usage_metrics": null,
            "shared_with_openai": false
          }
          
          """,
      },
      #{
        title: "Reinforcement",
        request: #{
          curl: """
            curl https://api.openai.com/v1/fine_tuning/jobs \\
              -H "Content-Type: application/json" \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -d '{
                "training_file": "file-abc",
                "validation_file": "file-123",
                "model": "o4-mini",
                "method": {
                  "type": "reinforcement",
                  "reinforcement": {
                    "grader": {
                      "type": "string_check",
                      "name": "Example string check grader",
                      "input": "{{sample.output_text}}",
                      "reference": "{{item.label}}",
                      "operation": "eq"
                    },
                    "hyperparameters": {
                      "reasoning_effort": "medium"
                    }
                  }
                }
              }'
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            fine_tuning_job = client.fine_tuning.jobs.create(
                model="gpt-4o-mini",
                training_file="file-abc123",
            )
            print(fine_tuning_job.id)
            """,
          `node.js`: """
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const fineTuningJob = await client.fineTuning.jobs.create({
              model: 'gpt-4o-mini',
              training_file: 'file-abc123',
            });
            
            console.log(fineTuningJob.id);
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
            	fineTuningJob, err := client.FineTuning.Jobs.New(context.TODO(), openai.FineTuningJobNewParams{
            		Model:        openai.FineTuningJobNewParamsModelGPT4oMini,
            		TrainingFile: "file-abc123",
            	})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", fineTuningJob.ID)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.finetuning.jobs.FineTuningJob;
            import com.openai.models.finetuning.jobs.JobCreateParams;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    JobCreateParams params = JobCreateParams.builder()
                        .model(JobCreateParams.Model.GPT_4O_MINI)
                        .trainingFile("file-abc123")
                        .build();
                    FineTuningJob fineTuningJob = client.fineTuning().jobs().create(params);
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            fine_tuning_job = openai.fine_tuning.jobs.create(model: :"gpt-4o-mini", training_file: "file-abc123")
            
            puts(fine_tuning_job)
            """,
        },
        response: """
          {
            "object": "fine_tuning.job",
            "id": "ftjob-abc123",
            "model": "o4-mini",
            "created_at": 1721764800,
            "finished_at": null,
            "fine_tuned_model": null,
            "organization_id": "org-123",
            "result_files": [],
            "status": "validating_files",
            "validation_file": "file-123",
            "training_file": "file-abc",
            "trained_tokens": null,
            "error": {},
            "user_provided_suffix": null,
            "seed": 950189191,
            "estimated_finish": null,
            "integrations": [],
            "method": {
              "type": "reinforcement",
              "reinforcement": {
                "hyperparameters": {
                  "batch_size": "auto",
                  "learning_rate_multiplier": "auto",
                  "n_epochs": "auto",
                  "eval_interval": "auto",
                  "eval_samples": "auto",
                  "compute_multiplier": "auto",
                  "reasoning_effort": "medium"
                },
                "grader": {
                  "type": "string_check",
                  "name": "Example string check grader",
                  "input": "{{sample.output_text}}",
                  "reference": "{{item.label}}",
                  "operation": "eq"
                },
                "response_format": null
              }
            },
            "metadata": null,
            "usage_metrics": null,
            "shared_with_openai": false
          }
          
          
          """,
      },
      #{
        title: "Validation file",
        request: #{
          curl: """
            curl https://api.openai.com/v1/fine_tuning/jobs \\
              -H "Content-Type: application/json" \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -d '{
                "training_file": "file-abc123",
                "validation_file": "file-abc123",
                "model": "gpt-4o-mini"
              }'
            
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            fine_tuning_job = client.fine_tuning.jobs.create(
                model="gpt-4o-mini",
                training_file="file-abc123",
            )
            print(fine_tuning_job.id)
            """,
          javascript: """
            import OpenAI from "openai";
            
            const openai = new OpenAI();
            
            async function main() {
              const fineTune = await openai.fineTuning.jobs.create({
                training_file: "file-abc123",
                validation_file: "file-abc123"
              });
            
              console.log(fineTune);
            }
            
            main();
            
            """,
          `node.js`: """
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const fineTuningJob = await client.fineTuning.jobs.create({
              model: 'gpt-4o-mini',
              training_file: 'file-abc123',
            });
            
            console.log(fineTuningJob.id);
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
            	fineTuningJob, err := client.FineTuning.Jobs.New(context.TODO(), openai.FineTuningJobNewParams{
            		Model:        openai.FineTuningJobNewParamsModelGPT4oMini,
            		TrainingFile: "file-abc123",
            	})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", fineTuningJob.ID)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.finetuning.jobs.FineTuningJob;
            import com.openai.models.finetuning.jobs.JobCreateParams;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    JobCreateParams params = JobCreateParams.builder()
                        .model(JobCreateParams.Model.GPT_4O_MINI)
                        .trainingFile("file-abc123")
                        .build();
                    FineTuningJob fineTuningJob = client.fineTuning().jobs().create(params);
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            fine_tuning_job = openai.fine_tuning.jobs.create(model: :"gpt-4o-mini", training_file: "file-abc123")
            
            puts(fine_tuning_job)
            """,
        },
        response: """
          {
            "object": "fine_tuning.job",
            "id": "ftjob-abc123",
            "model": "gpt-4o-mini-2024-07-18",
            "created_at": 1721764800,
            "fine_tuned_model": null,
            "organization_id": "org-123",
            "result_files": [],
            "status": "queued",
            "validation_file": "file-abc123",
            "training_file": "file-abc123",
            "method": {
              "type": "supervised",
              "supervised": {
                "hyperparameters": {
                  "batch_size": "auto",
                  "learning_rate_multiplier": "auto",
                  "n_epochs": "auto",
                }
              }
            },
            "metadata": null
          }
          
          """,
      },
      #{
        title: "W&B Integration",
        request: #{
          curl: """
            curl https://api.openai.com/v1/fine_tuning/jobs \\
              -H "Content-Type: application/json" \\
              -H "Authorization: Bearer $OPENAI_API_KEY" \\
              -d '{
                "training_file": "file-abc123",
                "validation_file": "file-abc123",
                "model": "gpt-4o-mini",
                "integrations": [
                  {
                    "type": "wandb",
                    "wandb": {
                      "project": "my-wandb-project",
                      "name": "ft-run-display-name"
                      "tags": [
                        "first-experiment", "v2"
                      ]
                    }
                  }
                ]
              }'
            
            """,
          `node.js`: """
            import OpenAI from 'openai';
            
            const client = new OpenAI({
              apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
            });
            
            const fineTuningJob = await client.fineTuning.jobs.create({
              model: 'gpt-4o-mini',
              training_file: 'file-abc123',
            });
            
            console.log(fineTuningJob.id);
            """,
          python: """
            import os
            from openai import OpenAI
            
            client = OpenAI(
                api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
            )
            fine_tuning_job = client.fine_tuning.jobs.create(
                model="gpt-4o-mini",
                training_file="file-abc123",
            )
            print(fine_tuning_job.id)
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
            	fineTuningJob, err := client.FineTuning.Jobs.New(context.TODO(), openai.FineTuningJobNewParams{
            		Model:        openai.FineTuningJobNewParamsModelGPT4oMini,
            		TrainingFile: "file-abc123",
            	})
            	if err != nil {
            		panic(err.Error())
            	}
            	fmt.Printf("%+v
            ", fineTuningJob.ID)
            }
            
            """,
          java: """
            package com.openai.example;
            
            import com.openai.client.OpenAIClient;
            import com.openai.client.okhttp.OpenAIOkHttpClient;
            import com.openai.models.finetuning.jobs.FineTuningJob;
            import com.openai.models.finetuning.jobs.JobCreateParams;
            
            public final class Main {
                private Main() {}
            
                public static void main(String[] args) {
                    OpenAIClient client = OpenAIOkHttpClient.fromEnv();
            
                    JobCreateParams params = JobCreateParams.builder()
                        .model(JobCreateParams.Model.GPT_4O_MINI)
                        .trainingFile("file-abc123")
                        .build();
                    FineTuningJob fineTuningJob = client.fineTuning().jobs().create(params);
                }
            }
            """,
          ruby: """
            require "openai"
            
            openai = OpenAI::Client.new(api_key: "My API Key")
            
            fine_tuning_job = openai.fine_tuning.jobs.create(model: :"gpt-4o-mini", training_file: "file-abc123")
            
            puts(fine_tuning_job)
            """,
        },
        response: """
          {
            "object": "fine_tuning.job",
            "id": "ftjob-abc123",
            "model": "gpt-4o-mini-2024-07-18",
            "created_at": 1721764800,
            "fine_tuned_model": null,
            "organization_id": "org-123",
            "result_files": [],
            "status": "queued",
            "validation_file": "file-abc123",
            "training_file": "file-abc123",
            "integrations": [
              {
                "type": "wandb",
                "wandb": {
                  "project": "my-wandb-project",
                  "entity": None,
                  "run_id": "ftjob-abc123"
                }
              }
            ],
            "method": {
              "type": "supervised",
              "supervised": {
                "hyperparameters": {
                  "batch_size": "auto",
                  "learning_rate_multiplier": "auto",
                  "n_epochs": "auto",
                }
              }
            },
            "metadata": null
          }
          
          """,
      }
    ],
  }
);

@@extension(
  Azure.AI.Projects.FineTuning.retrieveFineTuningJob,
  "x-oaiMeta",
  #{
    name: "Retrieve fine-tuning job",
    group: "fine-tuning",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/fine_tuning/jobs/ft-AF1WoRqd3aJAHsqc9NY7iL8F \\
            -H "Authorization: Bearer $OPENAI_API_KEY"
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          fine_tuning_job = client.fine_tuning.jobs.retrieve(
              "ft-AF1WoRqd3aJAHsqc9NY7iL8F",
          )
          print(fine_tuning_job.id)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          async function main() {
            const fineTune = await openai.fineTuning.jobs.retrieve("ftjob-abc123");
          
            console.log(fineTune);
          }
          
          main();
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const fineTuningJob = await client.fineTuning.jobs.retrieve('ft-AF1WoRqd3aJAHsqc9NY7iL8F');
          
          console.log(fineTuningJob.id);
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
          	fineTuningJob, err := client.FineTuning.Jobs.Get(context.TODO(), "ft-AF1WoRqd3aJAHsqc9NY7iL8F")
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", fineTuningJob.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.finetuning.jobs.FineTuningJob;
          import com.openai.models.finetuning.jobs.JobRetrieveParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  FineTuningJob fineTuningJob = client.fineTuning().jobs().retrieve("ft-AF1WoRqd3aJAHsqc9NY7iL8F");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          fine_tuning_job = openai.fine_tuning.jobs.retrieve("ft-AF1WoRqd3aJAHsqc9NY7iL8F")
          
          puts(fine_tuning_job)
          """,
      },
      response: """
        {
          "object": "fine_tuning.job",
          "id": "ftjob-abc123",
          "model": "davinci-002",
          "created_at": 1692661014,
          "finished_at": 1692661190,
          "fine_tuned_model": "ft:davinci-002:my-org:custom_suffix:7q8mpxmy",
          "organization_id": "org-123",
          "result_files": [
              "file-abc123"
          ],
          "status": "succeeded",
          "validation_file": null,
          "training_file": "file-abc123",
          "hyperparameters": {
              "n_epochs": 4,
              "batch_size": 1,
              "learning_rate_multiplier": 1.0
          },
          "trained_tokens": 5768,
          "integrations": [],
          "seed": 0,
          "estimated_finish": 0,
          "method": {
            "type": "supervised",
            "supervised": {
              "hyperparameters": {
                "n_epochs": 4,
                "batch_size": 1,
                "learning_rate_multiplier": 1.0
              }
            }
          }
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.FineTuning.cancelFineTuningJob,
  "x-oaiMeta",
  #{
    name: "Cancel fine-tuning",
    group: "fine-tuning",
    examples: #{
      request: #{
        curl: """
          curl -X POST https://api.openai.com/v1/fine_tuning/jobs/ftjob-abc123/cancel \\
            -H "Authorization: Bearer $OPENAI_API_KEY"
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          fine_tuning_job = client.fine_tuning.jobs.cancel(
              "ft-AF1WoRqd3aJAHsqc9NY7iL8F",
          )
          print(fine_tuning_job.id)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          async function main() {
            const fineTune = await openai.fineTuning.jobs.cancel("ftjob-abc123");
          
            console.log(fineTune);
          }
          main();
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const fineTuningJob = await client.fineTuning.jobs.cancel('ft-AF1WoRqd3aJAHsqc9NY7iL8F');
          
          console.log(fineTuningJob.id);
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
          	fineTuningJob, err := client.FineTuning.Jobs.Cancel(context.TODO(), "ft-AF1WoRqd3aJAHsqc9NY7iL8F")
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", fineTuningJob.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.finetuning.jobs.FineTuningJob;
          import com.openai.models.finetuning.jobs.JobCancelParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  FineTuningJob fineTuningJob = client.fineTuning().jobs().cancel("ft-AF1WoRqd3aJAHsqc9NY7iL8F");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          fine_tuning_job = openai.fine_tuning.jobs.cancel("ft-AF1WoRqd3aJAHsqc9NY7iL8F")
          
          puts(fine_tuning_job)
          """,
      },
      response: """
        {
          "object": "fine_tuning.job",
          "id": "ftjob-abc123",
          "model": "gpt-4o-mini-2024-07-18",
          "created_at": 1721764800,
          "fine_tuned_model": null,
          "organization_id": "org-123",
          "result_files": [],
          "status": "cancelled",
          "validation_file": "file-abc123",
          "training_file": "file-abc123"
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.FineTuning.listFineTuningJobCheckpoints,
  "x-oaiMeta",
  #{
    name: "List fine-tuning checkpoints",
    group: "fine-tuning",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/fine_tuning/jobs/ftjob-abc123/checkpoints \\
            -H "Authorization: Bearer $OPENAI_API_KEY"
          
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          // Automatically fetches more pages as needed.
          for await (const fineTuningJobCheckpoint of client.fineTuning.jobs.checkpoints.list(
            'ft-AF1WoRqd3aJAHsqc9NY7iL8F',
          )) {
            console.log(fineTuningJobCheckpoint.id);
          }
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          page = client.fine_tuning.jobs.checkpoints.list(
              fine_tuning_job_id="ft-AF1WoRqd3aJAHsqc9NY7iL8F",
          )
          page = page.data[0]
          print(page.id)
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
          	page, err := client.FineTuning.Jobs.Checkpoints.List(
          		context.TODO(),
          		"ft-AF1WoRqd3aJAHsqc9NY7iL8F",
          		openai.FineTuningJobCheckpointListParams{},
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
          import com.openai.models.finetuning.jobs.checkpoints.CheckpointListPage;
          import com.openai.models.finetuning.jobs.checkpoints.CheckpointListParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  CheckpointListPage page = client.fineTuning().jobs().checkpoints().list("ft-AF1WoRqd3aJAHsqc9NY7iL8F");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          page = openai.fine_tuning.jobs.checkpoints.list("ft-AF1WoRqd3aJAHsqc9NY7iL8F")
          
          puts(page)
          """,
      },
      response: """
        {
          "object": "list",
          "data": [
            {
              "object": "fine_tuning.job.checkpoint",
              "id": "ftckpt_zc4Q7MP6XxulcVzj4MZdwsAB",
              "created_at": 1721764867,
              "fine_tuned_model_checkpoint": "ft:gpt-4o-mini-2024-07-18:my-org:custom-suffix:96olL566:ckpt-step-2000",
              "metrics": {
                "full_valid_loss": 0.134,
                "full_valid_mean_token_accuracy": 0.874
              },
              "fine_tuning_job_id": "ftjob-abc123",
              "step_number": 2000
            },
            {
              "object": "fine_tuning.job.checkpoint",
              "id": "ftckpt_enQCFmOTGj3syEpYVhBRLTSy",
              "created_at": 1721764800,
              "fine_tuned_model_checkpoint": "ft:gpt-4o-mini-2024-07-18:my-org:custom-suffix:7q8mpxmy:ckpt-step-1000",
              "metrics": {
                "full_valid_loss": 0.167,
                "full_valid_mean_token_accuracy": 0.781
              },
              "fine_tuning_job_id": "ftjob-abc123",
              "step_number": 1000
            }
          ],
          "first_id": "ftckpt_zc4Q7MP6XxulcVzj4MZdwsAB",
          "last_id": "ftckpt_enQCFmOTGj3syEpYVhBRLTSy",
          "has_more": true
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.FineTuning.listFineTuningJobCheckpoints,
  "x-ms-list",
  true
);

@@extension(
  Azure.AI.Projects.FineTuning.listFineTuningEvents,
  "x-oaiMeta",
  #{
    name: "List fine-tuning events",
    group: "fine-tuning",
    examples: #{
      request: #{
        curl: """
          curl https://api.openai.com/v1/fine_tuning/jobs/ftjob-abc123/events \\
            -H "Authorization: Bearer $OPENAI_API_KEY"
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          page = client.fine_tuning.jobs.list_events(
              fine_tuning_job_id="ft-AF1WoRqd3aJAHsqc9NY7iL8F",
          )
          page = page.data[0]
          print(page.id)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          async function main() {
            const list = await openai.fineTuning.list_events(id="ftjob-abc123", limit=2);
          
            for await (const fineTune of list) {
              console.log(fineTune);
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
          for await (const fineTuningJobEvent of client.fineTuning.jobs.listEvents(
            'ft-AF1WoRqd3aJAHsqc9NY7iL8F',
          )) {
            console.log(fineTuningJobEvent.id);
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
          	page, err := client.FineTuning.Jobs.ListEvents(
          		context.TODO(),
          		"ft-AF1WoRqd3aJAHsqc9NY7iL8F",
          		openai.FineTuningJobListEventsParams{},
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
          import com.openai.models.finetuning.jobs.JobListEventsPage;
          import com.openai.models.finetuning.jobs.JobListEventsParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  JobListEventsPage page = client.fineTuning().jobs().listEvents("ft-AF1WoRqd3aJAHsqc9NY7iL8F");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          page = openai.fine_tuning.jobs.list_events("ft-AF1WoRqd3aJAHsqc9NY7iL8F")
          
          puts(page)
          """,
      },
      response: """
        {
          "object": "list",
          "data": [
            {
              "object": "fine_tuning.job.event",
              "id": "ft-event-ddTJfwuMVpfLXseO0Am0Gqjm",
              "created_at": 1721764800,
              "level": "info",
              "message": "Fine tuning job successfully completed",
              "data": null,
              "type": "message"
            },
            {
              "object": "fine_tuning.job.event",
              "id": "ft-event-tyiGuB72evQncpH87xe505Sv",
              "created_at": 1721764800,
              "level": "info",
              "message": "New fine-tuned model created: ft:gpt-4o-mini:openai::7p4lURel",
              "data": null,
              "type": "message"
            }
          ],
          "has_more": true
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.FineTuning.listFineTuningEvents,
  "x-ms-list",
  true
);

@@extension(
  Azure.AI.Projects.FineTuning.pauseFineTuningJob,
  "x-oaiMeta",
  #{
    name: "Pause fine-tuning",
    group: "fine-tuning",
    examples: #{
      request: #{
        curl: """
          curl -X POST https://api.openai.com/v1/fine_tuning/jobs/ftjob-abc123/pause \\
            -H "Authorization: Bearer $OPENAI_API_KEY"
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          fine_tuning_job = client.fine_tuning.jobs.pause(
              "ft-AF1WoRqd3aJAHsqc9NY7iL8F",
          )
          print(fine_tuning_job.id)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          async function main() {
            const fineTune = await openai.fineTuning.jobs.pause("ftjob-abc123");
          
            console.log(fineTune);
          }
          main();
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const fineTuningJob = await client.fineTuning.jobs.pause('ft-AF1WoRqd3aJAHsqc9NY7iL8F');
          
          console.log(fineTuningJob.id);
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
          	fineTuningJob, err := client.FineTuning.Jobs.Pause(context.TODO(), "ft-AF1WoRqd3aJAHsqc9NY7iL8F")
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", fineTuningJob.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.finetuning.jobs.FineTuningJob;
          import com.openai.models.finetuning.jobs.JobPauseParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  FineTuningJob fineTuningJob = client.fineTuning().jobs().pause("ft-AF1WoRqd3aJAHsqc9NY7iL8F");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          fine_tuning_job = openai.fine_tuning.jobs.pause("ft-AF1WoRqd3aJAHsqc9NY7iL8F")
          
          puts(fine_tuning_job)
          """,
      },
      response: """
        {
          "object": "fine_tuning.job",
          "id": "ftjob-abc123",
          "model": "gpt-4o-mini-2024-07-18",
          "created_at": 1721764800,
          "fine_tuned_model": null,
          "organization_id": "org-123",
          "result_files": [],
          "status": "paused",
          "validation_file": "file-abc123",
          "training_file": "file-abc123"
        }
        
        """,
    },
  }
);

@@extension(
  Azure.AI.Projects.FineTuning.resumeFineTuningJob,
  "x-oaiMeta",
  #{
    name: "Resume fine-tuning",
    group: "fine-tuning",
    examples: #{
      request: #{
        curl: """
          curl -X POST https://api.openai.com/v1/fine_tuning/jobs/ftjob-abc123/resume \\
            -H "Authorization: Bearer $OPENAI_API_KEY"
          
          """,
        python: """
          import os
          from openai import OpenAI
          
          client = OpenAI(
              api_key=os.environ.get("OPENAI_API_KEY"),  # This is the default and can be omitted
          )
          fine_tuning_job = client.fine_tuning.jobs.resume(
              "ft-AF1WoRqd3aJAHsqc9NY7iL8F",
          )
          print(fine_tuning_job.id)
          """,
        javascript: """
          import OpenAI from "openai";
          
          const openai = new OpenAI();
          
          async function main() {
            const fineTune = await openai.fineTuning.jobs.resume("ftjob-abc123");
          
            console.log(fineTune);
          }
          main();
          """,
        `node.js`: """
          import OpenAI from 'openai';
          
          const client = new OpenAI({
            apiKey: process.env['OPENAI_API_KEY'], // This is the default and can be omitted
          });
          
          const fineTuningJob = await client.fineTuning.jobs.resume('ft-AF1WoRqd3aJAHsqc9NY7iL8F');
          
          console.log(fineTuningJob.id);
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
          	fineTuningJob, err := client.FineTuning.Jobs.Resume(context.TODO(), "ft-AF1WoRqd3aJAHsqc9NY7iL8F")
          	if err != nil {
          		panic(err.Error())
          	}
          	fmt.Printf("%+v
          ", fineTuningJob.ID)
          }
          
          """,
        java: """
          package com.openai.example;
          
          import com.openai.client.OpenAIClient;
          import com.openai.client.okhttp.OpenAIOkHttpClient;
          import com.openai.models.finetuning.jobs.FineTuningJob;
          import com.openai.models.finetuning.jobs.JobResumeParams;
          
          public final class Main {
              private Main() {}
          
              public static void main(String[] args) {
                  OpenAIClient client = OpenAIOkHttpClient.fromEnv();
          
                  FineTuningJob fineTuningJob = client.fineTuning().jobs().resume("ft-AF1WoRqd3aJAHsqc9NY7iL8F");
              }
          }
          """,
        ruby: """
          require "openai"
          
          openai = OpenAI::Client.new(api_key: "My API Key")
          
          fine_tuning_job = openai.fine_tuning.jobs.resume("ft-AF1WoRqd3aJAHsqc9NY7iL8F")
          
          puts(fine_tuning_job)
          """,
      },
      response: """
        {
          "object": "fine_tuning.job",
          "id": "ftjob-abc123",
          "model": "gpt-4o-mini-2024-07-18",
          "created_at": 1721764800,
          "fine_tuned_model": null,
          "organization_id": "org-123",
          "result_files": [],
          "status": "queued",
          "validation_file": "file-abc123",
          "training_file": "file-abc123"
        }
        
        """,
    },
  }
);
