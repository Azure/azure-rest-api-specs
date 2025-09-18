import "@typespec/http";
import "@typespec/openapi";
import "./models.tsp";
using TypeSpec.Http;
using TypeSpec.OpenAPI;
namespace OpenAI;
/****NOTE:** This endpoint requires an [admin API key](../admin-api-keys).

Organization owners can use this endpoint to view all permissions for a fine-tuned model checkpoint.*/
@summary("List checkpoint permissions")
@get
@route("/fine_tuning/checkpoints/{fine_tuned_model_checkpoint}/permissions")
@extension(
  "x-oaiMeta",
  #{
    name: "List checkpoint permissions",
    group: "fine-tuning",
    returns: "A list of fine-tuned model checkpoint [permission objects](https://platform.openai.com/docs/api-reference/fine-tuning/permission-object) for a fine-tuned model checkpoint.",
    examples: #{
      response: "{\n  \"object\": \"list\",\n  \"data\": [\n    {\n      \"object\": \"checkpoint.permission\",\n      \"id\": \"cp_zc4Q7MP6XxulcVzj4MZdwsAB\",\n      \"created_at\": 1721764867,\n      \"project_id\": \"proj_abGMw1llN8IrBb6SvvY5A1iH\"\n    },\n    {\n      \"object\": \"checkpoint.permission\",\n      \"id\": \"cp_enQCFmOTGj3syEpYVhBRLTSy\",\n      \"created_at\": 1721764800,\n      \"project_id\": \"proj_iqGMw1llN8IrBb6SvvY5A1oF\"\n    },\n  ],\n  \"first_id\": \"cp_zc4Q7MP6XxulcVzj4MZdwsAB\",\n  \"last_id\": \"cp_enQCFmOTGj3syEpYVhBRLTSy\",\n  \"has_more\": false\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/fine_tuning/checkpoints/ft:gpt-4o-mini-2024-07-18:org:weather:B7R9VjQd/permissions \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\"\n",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst permission = await client.fineTuning.checkpoints.permissions.retrieve('ft-AF1WoRqd3aJAHsqc9NY7iL8F');\n\nconsole.log(permission.first_id);",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\npermission = client.fine_tuning.checkpoints.permissions.retrieve(\n    fine_tuned_model_checkpoint=\"ft-AF1WoRqd3aJAHsqc9NY7iL8F\",\n)\nprint(permission.first_id)",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  permission, err := client.FineTuning.Checkpoints.Permissions.Get(\n    context.TODO(),\n    \"ft-AF1WoRqd3aJAHsqc9NY7iL8F\",\n    openai.FineTuningCheckpointPermissionGetParams{\n\n    },\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", permission.FirstID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.finetuning.checkpoints.permissions.PermissionRetrieveParams;\nimport com.openai.models.finetuning.checkpoints.permissions.PermissionRetrieveResponse;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        PermissionRetrieveResponse permission = client.fineTuning().checkpoints().permissions().retrieve(\"ft-AF1WoRqd3aJAHsqc9NY7iL8F\");\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\npermission = openai.fine_tuning.checkpoints.permissions.retrieve(\"ft-AF1WoRqd3aJAHsqc9NY7iL8F\")\n\nputs(permission)",
      },
    },
  }
)
@tag("Fine-tuning")
op listFineTuningCheckpointPermissions(
  /** The ID of the fine-tuned model checkpoint to get permissions for. */
  @path
  fine_tuned_model_checkpoint: string,

  /** The ID of the project to get permissions for. */
  @query(#{ explode: true })
  project_id?: string,

  /** Identifier for the last permission ID from the previous pagination request. */
  @query(#{ explode: true })
  after?: string,

  /** Number of permissions to retrieve. */
  @query(#{ explode: true })
  limit?: integer = 10,

  /** The order in which to retrieve permissions. */
  @query(#{ explode: true })
  order?: "ascending" | "descending" = "descending",
): ListFineTuningCheckpointPermissionResponse;

/****NOTE:** Calling this endpoint requires an [admin API key](../admin-api-keys).

This enables organization owners to share fine-tuned models with other projects in their organization.*/
@summary("Create checkpoint permissions")
@post
@route("/fine_tuning/checkpoints/{fine_tuned_model_checkpoint}/permissions")
@extension(
  "x-oaiMeta",
  #{
    name: "Create checkpoint permissions",
    group: "fine-tuning",
    returns: "A list of fine-tuned model checkpoint [permission objects](https://platform.openai.com/docs/api-reference/fine-tuning/permission-object) for a fine-tuned model checkpoint.",
    examples: #{
      response: "{\n  \"object\": \"list\",\n  \"data\": [\n    {\n      \"object\": \"checkpoint.permission\",\n      \"id\": \"cp_zc4Q7MP6XxulcVzj4MZdwsAB\",\n      \"created_at\": 1721764867,\n      \"project_id\": \"proj_abGMw1llN8IrBb6SvvY5A1iH\"\n    }\n  ],\n  \"first_id\": \"cp_zc4Q7MP6XxulcVzj4MZdwsAB\",\n  \"last_id\": \"cp_zc4Q7MP6XxulcVzj4MZdwsAB\",\n  \"has_more\": false\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/fine_tuning/checkpoints/ft:gpt-4o-mini-2024-07-18:org:weather:B7R9VjQd/permissions \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\"\n  -d '{\"project_ids\": [\"proj_abGMw1llN8IrBb6SvvY5A1iH\"]}'\n",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\n// Automatically fetches more pages as needed.\nfor await (const permissionCreateResponse of client.fineTuning.checkpoints.permissions.create(\n  'ft:gpt-4o-mini-2024-07-18:org:weather:B7R9VjQd',\n  { project_ids: ['string'] },\n)) {\n  console.log(permissionCreateResponse.id);\n}",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\npage = client.fine_tuning.checkpoints.permissions.create(\n    fine_tuned_model_checkpoint=\"ft:gpt-4o-mini-2024-07-18:org:weather:B7R9VjQd\",\n    project_ids=[\"string\"],\n)\npage = page.data[0]\nprint(page.id)",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  page, err := client.FineTuning.Checkpoints.Permissions.New(\n    context.TODO(),\n    \"ft:gpt-4o-mini-2024-07-18:org:weather:B7R9VjQd\",\n    openai.FineTuningCheckpointPermissionNewParams{\n      ProjectIDs: []string{\"string\"},\n    },\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", page)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.finetuning.checkpoints.permissions.PermissionCreatePage;\nimport com.openai.models.finetuning.checkpoints.permissions.PermissionCreateParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        PermissionCreateParams params = PermissionCreateParams.builder()\n            .fineTunedModelCheckpoint(\"ft:gpt-4o-mini-2024-07-18:org:weather:B7R9VjQd\")\n            .addProjectId(\"string\")\n            .build();\n        PermissionCreatePage page = client.fineTuning().checkpoints().permissions().create(params);\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\npage = openai.fine_tuning.checkpoints.permissions.create(\n  \"ft:gpt-4o-mini-2024-07-18:org:weather:B7R9VjQd\",\n  project_ids: [\"string\"]\n)\n\nputs(page)",
      },
    },
  }
)
@tag("Fine-tuning")
op createFineTuningCheckpointPermission(
  /** The ID of the fine-tuned model checkpoint to create a permission for. */
  @path
  fine_tuned_model_checkpoint: string,

  @body
  body: CreateFineTuningCheckpointPermissionRequest,
): ListFineTuningCheckpointPermissionResponse;

/****NOTE:** This endpoint requires an [admin API key](../admin-api-keys).

Organization owners can use this endpoint to delete a permission for a fine-tuned model checkpoint.*/
@summary("Delete checkpoint permission")
@delete
@route("/fine_tuning/checkpoints/{fine_tuned_model_checkpoint}/permissions/{permission_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Delete checkpoint permission",
    group: "fine-tuning",
    returns: "The deletion status of the fine-tuned model checkpoint [permission object](https://platform.openai.com/docs/api-reference/fine-tuning/permission-object).",
    examples: #{
      response: "{\n  \"object\": \"checkpoint.permission\",\n  \"id\": \"cp_zc4Q7MP6XxulcVzj4MZdwsAB\",\n  \"deleted\": true\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/fine_tuning/checkpoints/ft:gpt-4o-mini-2024-07-18:org:weather:B7R9VjQd/permissions/cp_zc4Q7MP6XxulcVzj4MZdwsAB \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\"\n",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst permission = await client.fineTuning.checkpoints.permissions.delete('cp_zc4Q7MP6XxulcVzj4MZdwsAB', {\n  fine_tuned_model_checkpoint: 'ft:gpt-4o-mini-2024-07-18:org:weather:B7R9VjQd',\n});\n\nconsole.log(permission.id);",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\npermission = client.fine_tuning.checkpoints.permissions.delete(\n    permission_id=\"cp_zc4Q7MP6XxulcVzj4MZdwsAB\",\n    fine_tuned_model_checkpoint=\"ft:gpt-4o-mini-2024-07-18:org:weather:B7R9VjQd\",\n)\nprint(permission.id)",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  permission, err := client.FineTuning.Checkpoints.Permissions.Delete(\n    context.TODO(),\n    \"ft:gpt-4o-mini-2024-07-18:org:weather:B7R9VjQd\",\n    \"cp_zc4Q7MP6XxulcVzj4MZdwsAB\",\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", permission.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.finetuning.checkpoints.permissions.PermissionDeleteParams;\nimport com.openai.models.finetuning.checkpoints.permissions.PermissionDeleteResponse;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        PermissionDeleteParams params = PermissionDeleteParams.builder()\n            .fineTunedModelCheckpoint(\"ft:gpt-4o-mini-2024-07-18:org:weather:B7R9VjQd\")\n            .permissionId(\"cp_zc4Q7MP6XxulcVzj4MZdwsAB\")\n            .build();\n        PermissionDeleteResponse permission = client.fineTuning().checkpoints().permissions().delete(params);\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\npermission = openai.fine_tuning.checkpoints.permissions.delete(\n  \"cp_zc4Q7MP6XxulcVzj4MZdwsAB\",\n  fine_tuned_model_checkpoint: \"ft:gpt-4o-mini-2024-07-18:org:weather:B7R9VjQd\"\n)\n\nputs(permission)",
      },
    },
  }
)
@tag("Fine-tuning")
op deleteFineTuningCheckpointPermission(
  /** The ID of the fine-tuned model checkpoint to delete a permission for. */
  @path
  fine_tuned_model_checkpoint: string,

  /** The ID of the fine-tuned model checkpoint permission to delete. */
  @path
  permission_id: string,
): DeleteFineTuningCheckpointPermissionResponse;

/** List your organization's fine-tuning jobs */
@summary("List fine-tuning jobs")
@get
@route("/fine_tuning/jobs")
@extension(
  "x-oaiMeta",
  #{
    name: "List fine-tuning jobs",
    group: "fine-tuning",
    returns: "A list of paginated [fine-tuning job](https://platform.openai.com/docs/api-reference/fine-tuning/object) objects.",
    examples: #{
      response: "{\n  \"object\": \"list\",\n  \"data\": [\n    {\n      \"object\": \"fine_tuning.job\",\n      \"id\": \"ftjob-abc123\",\n      \"model\": \"gpt-4o-mini-2024-07-18\",\n      \"created_at\": 1721764800,\n      \"fine_tuned_model\": null,\n      \"organization_id\": \"org-123\",\n      \"result_files\": [],\n      \"status\": \"queued\",\n      \"validation_file\": null,\n      \"training_file\": \"file-abc123\",\n      \"metadata\": {\n        \"key\": \"value\"\n      }\n    },\n    { ... },\n    { ... }\n  ], \"has_more\": true\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/fine_tuning/jobs?limit=2&metadata[key]=value \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\"\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\npage = client.fine_tuning.jobs.list()\npage = page.data[0]\nprint(page.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\n// Automatically fetches more pages as needed.\nfor await (const fineTuningJob of client.fineTuning.jobs.list()) {\n  console.log(fineTuningJob.id);\n}",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  page, err := client.FineTuning.Jobs.List(context.TODO(), openai.FineTuningJobListParams{\n\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", page)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.finetuning.jobs.JobListPage;\nimport com.openai.models.finetuning.jobs.JobListParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        JobListPage page = client.fineTuning().jobs().list();\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\npage = openai.fine_tuning.jobs.list\n\nputs(page)",
      },
    },
  }
)
@tag("Fine-tuning")
op listPaginatedFineTuningJobs(
  /** Identifier for the last job from the previous pagination request. */
  @query(#{ explode: true })
  after?: string,

  /** Number of fine-tuning jobs to retrieve. */
  @query(#{ explode: true })
  limit?: integer = 20,

  /** Optional metadata filter. To filter, use the syntax `metadata[k]=v`. Alternatively, set `metadata=null` to indicate no metadata. */
  @query(#{ explode: true })
  metadata?: Record<string> | null,
): ListPaginatedFineTuningJobsResponse;

/**Creates a fine-tuning job which begins the process of creating a new model from a given dataset.

Response includes details of the enqueued job including job status and the name of the fine-tuned models once complete.

[Learn more about fine-tuning](https://platform.openai.com/docs/guides/model-optimization)*/
@summary("Create fine-tuning job")
@post
@route("/fine_tuning/jobs")
@extension(
  "x-oaiMeta",
  #{
    name: "Create fine-tuning job",
    group: "fine-tuning",
    returns: "A [fine-tuning.job](https://platform.openai.com/docs/api-reference/fine-tuning/object) object.",
    examples: #[
      #{
        title: "Default",
        request: #{
          curl: "curl https://api.openai.com/v1/fine_tuning/jobs \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -d '{\n    \"training_file\": \"file-BK7bzQj3FfZFXr7DbL6xJwfo\",\n    \"model\": \"gpt-4o-mini\"\n  }'\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nfine_tuning_job = client.fine_tuning.jobs.create(\n    model=\"gpt-4o-mini\",\n    training_file=\"file-abc123\",\n)\nprint(fine_tuning_job.id)",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst fineTuningJob = await client.fineTuning.jobs.create({\n  model: 'gpt-4o-mini',\n  training_file: 'file-abc123',\n});\n\nconsole.log(fineTuningJob.id);",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  fineTuningJob, err := client.FineTuning.Jobs.New(context.TODO(), openai.FineTuningJobNewParams{\n    Model: openai.FineTuningJobNewParamsModelBabbage002,\n    TrainingFile: \"file-abc123\",\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", fineTuningJob.ID)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.finetuning.jobs.FineTuningJob;\nimport com.openai.models.finetuning.jobs.JobCreateParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        JobCreateParams params = JobCreateParams.builder()\n            .model(JobCreateParams.Model.BABBAGE_002)\n            .trainingFile(\"file-abc123\")\n            .build();\n        FineTuningJob fineTuningJob = client.fineTuning().jobs().create(params);\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nfine_tuning_job = openai.fine_tuning.jobs.create(model: :\"babbage-002\", training_file: \"file-abc123\")\n\nputs(fine_tuning_job)",
        },
        response: "{\n  \"object\": \"fine_tuning.job\",\n  \"id\": \"ftjob-abc123\",\n  \"model\": \"gpt-4o-mini-2024-07-18\",\n  \"created_at\": 1721764800,\n  \"fine_tuned_model\": null,\n  \"organization_id\": \"org-123\",\n  \"result_files\": [],\n  \"status\": \"queued\",\n  \"validation_file\": null,\n  \"training_file\": \"file-abc123\",\n  \"method\": {\n    \"type\": \"supervised\",\n    \"supervised\": {\n      \"hyperparameters\": {\n        \"batch_size\": \"auto\",\n        \"learning_rate_multiplier\": \"auto\",\n        \"n_epochs\": \"auto\",\n      }\n    }\n  },\n  \"metadata\": null\n}\n",
      },
      #{
        title: "Epochs",
        request: #{
          curl: "curl https://api.openai.com/v1/fine_tuning/jobs \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -d '{\n    \"training_file\": \"file-abc123\",\n    \"model\": \"gpt-4o-mini\",\n    \"method\": {\n      \"type\": \"supervised\",\n      \"supervised\": {\n        \"hyperparameters\": {\n          \"n_epochs\": 2\n        }\n      }\n    }\n  }'\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nfine_tuning_job = client.fine_tuning.jobs.create(\n    model=\"gpt-4o-mini\",\n    training_file=\"file-abc123\",\n)\nprint(fine_tuning_job.id)",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst fineTuningJob = await client.fineTuning.jobs.create({\n  model: 'gpt-4o-mini',\n  training_file: 'file-abc123',\n});\n\nconsole.log(fineTuningJob.id);",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  fineTuningJob, err := client.FineTuning.Jobs.New(context.TODO(), openai.FineTuningJobNewParams{\n    Model: openai.FineTuningJobNewParamsModelBabbage002,\n    TrainingFile: \"file-abc123\",\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", fineTuningJob.ID)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.finetuning.jobs.FineTuningJob;\nimport com.openai.models.finetuning.jobs.JobCreateParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        JobCreateParams params = JobCreateParams.builder()\n            .model(JobCreateParams.Model.BABBAGE_002)\n            .trainingFile(\"file-abc123\")\n            .build();\n        FineTuningJob fineTuningJob = client.fineTuning().jobs().create(params);\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nfine_tuning_job = openai.fine_tuning.jobs.create(model: :\"babbage-002\", training_file: \"file-abc123\")\n\nputs(fine_tuning_job)",
        },
        response: "{\n  \"object\": \"fine_tuning.job\",\n  \"id\": \"ftjob-abc123\",\n  \"model\": \"gpt-4o-mini\",\n  \"created_at\": 1721764800,\n  \"fine_tuned_model\": null,\n  \"organization_id\": \"org-123\",\n  \"result_files\": [],\n  \"status\": \"queued\",\n  \"validation_file\": null,\n  \"training_file\": \"file-abc123\",\n  \"hyperparameters\": {\n    \"batch_size\": \"auto\",\n    \"learning_rate_multiplier\": \"auto\",\n    \"n_epochs\": 2\n  },\n  \"method\": {\n    \"type\": \"supervised\",\n    \"supervised\": {\n      \"hyperparameters\": {\n        \"batch_size\": \"auto\",\n        \"learning_rate_multiplier\": \"auto\",\n        \"n_epochs\": 2\n      }\n    }\n  },\n  \"metadata\": null,\n  \"error\": {\n    \"code\": null,\n    \"message\": null,\n    \"param\": null\n  },\n  \"finished_at\": null,\n  \"seed\": 683058546,\n  \"trained_tokens\": null,\n  \"estimated_finish\": null,\n  \"integrations\": [],\n  \"user_provided_suffix\": null,\n  \"usage_metrics\": null,\n  \"shared_with_openai\": false\n}\n",
      },
      #{
        title: "DPO",
        request: #{
          curl: "curl https://api.openai.com/v1/fine_tuning/jobs \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -d '{\n    \"training_file\": \"file-abc123\",\n    \"validation_file\": \"file-abc123\",\n    \"model\": \"gpt-4o-mini\",\n    \"method\": {\n      \"type\": \"dpo\",\n      \"dpo\": {\n        \"hyperparameters\": {\n          \"beta\": 0.1\n        }\n      }\n    }\n  }'\n",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst fineTuningJob = await client.fineTuning.jobs.create({\n  model: 'gpt-4o-mini',\n  training_file: 'file-abc123',\n});\n\nconsole.log(fineTuningJob.id);",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nfine_tuning_job = client.fine_tuning.jobs.create(\n    model=\"gpt-4o-mini\",\n    training_file=\"file-abc123\",\n)\nprint(fine_tuning_job.id)",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  fineTuningJob, err := client.FineTuning.Jobs.New(context.TODO(), openai.FineTuningJobNewParams{\n    Model: openai.FineTuningJobNewParamsModelBabbage002,\n    TrainingFile: \"file-abc123\",\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", fineTuningJob.ID)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.finetuning.jobs.FineTuningJob;\nimport com.openai.models.finetuning.jobs.JobCreateParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        JobCreateParams params = JobCreateParams.builder()\n            .model(JobCreateParams.Model.BABBAGE_002)\n            .trainingFile(\"file-abc123\")\n            .build();\n        FineTuningJob fineTuningJob = client.fineTuning().jobs().create(params);\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nfine_tuning_job = openai.fine_tuning.jobs.create(model: :\"babbage-002\", training_file: \"file-abc123\")\n\nputs(fine_tuning_job)",
        },
        python: "from openai import OpenAI\nfrom openai.types.fine_tuning import DpoMethod, DpoHyperparameters\n\nclient = OpenAI()\n\nclient.fine_tuning.jobs.create(\n  training_file=\"file-abc\",\n  validation_file=\"file-123\",\n  model=\"gpt-4o-mini\",\n  method={\n    \"type\": \"dpo\",\n    \"dpo\": DpoMethod(\n      hyperparameters=DpoHyperparameters(beta=0.1)\n    )\n  }\n)\n",
        response: "{\n  \"object\": \"fine_tuning.job\",\n  \"id\": \"ftjob-abc\",\n  \"model\": \"gpt-4o-mini\",\n  \"created_at\": 1746130590,\n  \"fine_tuned_model\": null,\n  \"organization_id\": \"org-abc\",\n  \"result_files\": [],\n  \"status\": \"queued\",\n  \"validation_file\": \"file-123\",\n  \"training_file\": \"file-abc\",\n  \"method\": {\n    \"type\": \"dpo\",\n    \"dpo\": {\n      \"hyperparameters\": {\n        \"beta\": 0.1,\n        \"batch_size\": \"auto\",\n        \"learning_rate_multiplier\": \"auto\",\n        \"n_epochs\": \"auto\"\n      }\n    }\n  },\n  \"metadata\": null,\n  \"error\": {\n    \"code\": null,\n    \"message\": null,\n    \"param\": null\n  },\n  \"finished_at\": null,\n  \"hyperparameters\": null,\n  \"seed\": 1036326793,\n  \"estimated_finish\": null,\n  \"integrations\": [],\n  \"user_provided_suffix\": null,\n  \"usage_metrics\": null,\n  \"shared_with_openai\": false\n}\n",
      },
      #{
        title: "Reinforcement",
        request: #{
          curl: "curl https://api.openai.com/v1/fine_tuning/jobs \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -d '{\n    \"training_file\": \"file-abc\",\n    \"validation_file\": \"file-123\",\n    \"model\": \"o4-mini\",\n    \"method\": {\n      \"type\": \"reinforcement\",\n      \"reinforcement\": {\n        \"grader\": {\n          \"type\": \"string_check\",\n          \"name\": \"Example string check grader\",\n          \"input\": \"{{sample.output_text}}\",\n          \"reference\": \"{{item.label}}\",\n          \"operation\": \"eq\"\n        },\n        \"hyperparameters\": {\n          \"reasoning_effort\": \"medium\"\n        }\n      }\n    }\n  }'\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nfine_tuning_job = client.fine_tuning.jobs.create(\n    model=\"gpt-4o-mini\",\n    training_file=\"file-abc123\",\n)\nprint(fine_tuning_job.id)",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst fineTuningJob = await client.fineTuning.jobs.create({\n  model: 'gpt-4o-mini',\n  training_file: 'file-abc123',\n});\n\nconsole.log(fineTuningJob.id);",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  fineTuningJob, err := client.FineTuning.Jobs.New(context.TODO(), openai.FineTuningJobNewParams{\n    Model: openai.FineTuningJobNewParamsModelBabbage002,\n    TrainingFile: \"file-abc123\",\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", fineTuningJob.ID)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.finetuning.jobs.FineTuningJob;\nimport com.openai.models.finetuning.jobs.JobCreateParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        JobCreateParams params = JobCreateParams.builder()\n            .model(JobCreateParams.Model.BABBAGE_002)\n            .trainingFile(\"file-abc123\")\n            .build();\n        FineTuningJob fineTuningJob = client.fineTuning().jobs().create(params);\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nfine_tuning_job = openai.fine_tuning.jobs.create(model: :\"babbage-002\", training_file: \"file-abc123\")\n\nputs(fine_tuning_job)",
        },
        response: "{\n  \"object\": \"fine_tuning.job\",\n  \"id\": \"ftjob-abc123\",\n  \"model\": \"o4-mini\",\n  \"created_at\": 1721764800,\n  \"finished_at\": null,\n  \"fine_tuned_model\": null,\n  \"organization_id\": \"org-123\",\n  \"result_files\": [],\n  \"status\": \"validating_files\",\n  \"validation_file\": \"file-123\",\n  \"training_file\": \"file-abc\",\n  \"trained_tokens\": null,\n  \"error\": {},\n  \"user_provided_suffix\": null,\n  \"seed\": 950189191,\n  \"estimated_finish\": null,\n  \"integrations\": [],\n  \"method\": {\n    \"type\": \"reinforcement\",\n    \"reinforcement\": {\n      \"hyperparameters\": {\n        \"batch_size\": \"auto\",\n        \"learning_rate_multiplier\": \"auto\",\n        \"n_epochs\": \"auto\",\n        \"eval_interval\": \"auto\",\n        \"eval_samples\": \"auto\",\n        \"compute_multiplier\": \"auto\",\n        \"reasoning_effort\": \"medium\"\n      },\n      \"grader\": {\n        \"type\": \"string_check\",\n        \"name\": \"Example string check grader\",\n        \"input\": \"{{sample.output_text}}\",\n        \"reference\": \"{{item.label}}\",\n        \"operation\": \"eq\"\n      },\n      \"response_format\": null\n    }\n  },\n  \"metadata\": null,\n  \"usage_metrics\": null,\n  \"shared_with_openai\": false\n}\n      \n",
      },
      #{
        title: "Validation file",
        request: #{
          curl: "curl https://api.openai.com/v1/fine_tuning/jobs \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -d '{\n    \"training_file\": \"file-abc123\",\n    \"validation_file\": \"file-abc123\",\n    \"model\": \"gpt-4o-mini\"\n  }'\n",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nfine_tuning_job = client.fine_tuning.jobs.create(\n    model=\"gpt-4o-mini\",\n    training_file=\"file-abc123\",\n)\nprint(fine_tuning_job.id)",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst fineTuningJob = await client.fineTuning.jobs.create({\n  model: 'gpt-4o-mini',\n  training_file: 'file-abc123',\n});\n\nconsole.log(fineTuningJob.id);",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  fineTuningJob, err := client.FineTuning.Jobs.New(context.TODO(), openai.FineTuningJobNewParams{\n    Model: openai.FineTuningJobNewParamsModelBabbage002,\n    TrainingFile: \"file-abc123\",\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", fineTuningJob.ID)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.finetuning.jobs.FineTuningJob;\nimport com.openai.models.finetuning.jobs.JobCreateParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        JobCreateParams params = JobCreateParams.builder()\n            .model(JobCreateParams.Model.BABBAGE_002)\n            .trainingFile(\"file-abc123\")\n            .build();\n        FineTuningJob fineTuningJob = client.fineTuning().jobs().create(params);\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nfine_tuning_job = openai.fine_tuning.jobs.create(model: :\"babbage-002\", training_file: \"file-abc123\")\n\nputs(fine_tuning_job)",
        },
        response: "{\n  \"object\": \"fine_tuning.job\",\n  \"id\": \"ftjob-abc123\",\n  \"model\": \"gpt-4o-mini-2024-07-18\",\n  \"created_at\": 1721764800,\n  \"fine_tuned_model\": null,\n  \"organization_id\": \"org-123\",\n  \"result_files\": [],\n  \"status\": \"queued\",\n  \"validation_file\": \"file-abc123\",\n  \"training_file\": \"file-abc123\",\n  \"method\": {\n    \"type\": \"supervised\",\n    \"supervised\": {\n      \"hyperparameters\": {\n        \"batch_size\": \"auto\",\n        \"learning_rate_multiplier\": \"auto\",\n        \"n_epochs\": \"auto\",\n      }\n    }\n  },\n  \"metadata\": null\n}\n",
      },
      #{
        title: "W&B Integration",
        request: #{
          curl: "curl https://api.openai.com/v1/fine_tuning/jobs \\\n  -H \"Content-Type: application/json\" \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\" \\\n  -d '{\n    \"training_file\": \"file-abc123\",\n    \"validation_file\": \"file-abc123\",\n    \"model\": \"gpt-4o-mini\",\n    \"integrations\": [\n      {\n        \"type\": \"wandb\",\n        \"wandb\": {\n          \"project\": \"my-wandb-project\",\n          \"name\": \"ft-run-display-name\"\n          \"tags\": [\n            \"first-experiment\", \"v2\"\n          ]\n        }\n      }\n    ]\n  }'\n",
          `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst fineTuningJob = await client.fineTuning.jobs.create({\n  model: 'gpt-4o-mini',\n  training_file: 'file-abc123',\n});\n\nconsole.log(fineTuningJob.id);",
          python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nfine_tuning_job = client.fine_tuning.jobs.create(\n    model=\"gpt-4o-mini\",\n    training_file=\"file-abc123\",\n)\nprint(fine_tuning_job.id)",
          go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  fineTuningJob, err := client.FineTuning.Jobs.New(context.TODO(), openai.FineTuningJobNewParams{\n    Model: openai.FineTuningJobNewParamsModelBabbage002,\n    TrainingFile: \"file-abc123\",\n  })\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", fineTuningJob.ID)\n}\n",
          java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.finetuning.jobs.FineTuningJob;\nimport com.openai.models.finetuning.jobs.JobCreateParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        JobCreateParams params = JobCreateParams.builder()\n            .model(JobCreateParams.Model.BABBAGE_002)\n            .trainingFile(\"file-abc123\")\n            .build();\n        FineTuningJob fineTuningJob = client.fineTuning().jobs().create(params);\n    }\n}",
          ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nfine_tuning_job = openai.fine_tuning.jobs.create(model: :\"babbage-002\", training_file: \"file-abc123\")\n\nputs(fine_tuning_job)",
        },
        response: "{\n  \"object\": \"fine_tuning.job\",\n  \"id\": \"ftjob-abc123\",\n  \"model\": \"gpt-4o-mini-2024-07-18\",\n  \"created_at\": 1721764800,\n  \"fine_tuned_model\": null,\n  \"organization_id\": \"org-123\",\n  \"result_files\": [],\n  \"status\": \"queued\",\n  \"validation_file\": \"file-abc123\",\n  \"training_file\": \"file-abc123\",\n  \"integrations\": [\n    {\n      \"type\": \"wandb\",\n      \"wandb\": {\n        \"project\": \"my-wandb-project\",\n        \"entity\": None,\n        \"run_id\": \"ftjob-abc123\"\n      }\n    }\n  ],\n  \"method\": {\n    \"type\": \"supervised\",\n    \"supervised\": {\n      \"hyperparameters\": {\n        \"batch_size\": \"auto\",\n        \"learning_rate_multiplier\": \"auto\",\n        \"n_epochs\": \"auto\",\n      }\n    }\n  },\n  \"metadata\": null\n}\n",
      }
    ],
  }
)
@tag("Fine-tuning")
op createFineTuningJob(
  @body
  body: CreateFineTuningJobRequest,
): FineTuningJob;

/**Get info about a fine-tuning job.

[Learn more about fine-tuning](https://platform.openai.com/docs/guides/model-optimization)*/
@summary("Retrieve fine-tuning job")
@get
@route("/fine_tuning/jobs/{fine_tuning_job_id}")
@extension(
  "x-oaiMeta",
  #{
    name: "Retrieve fine-tuning job",
    group: "fine-tuning",
    returns: "The [fine-tuning](https://platform.openai.com/docs/api-reference/fine-tuning/object) object with the given ID.",
    examples: #{
      response: "{\n  \"object\": \"fine_tuning.job\",\n  \"id\": \"ftjob-abc123\",\n  \"model\": \"davinci-002\",\n  \"created_at\": 1692661014,\n  \"finished_at\": 1692661190,\n  \"fine_tuned_model\": \"ft:davinci-002:my-org:custom_suffix:7q8mpxmy\",\n  \"organization_id\": \"org-123\",\n  \"result_files\": [\n      \"file-abc123\"\n  ],\n  \"status\": \"succeeded\",\n  \"validation_file\": null,\n  \"training_file\": \"file-abc123\",\n  \"hyperparameters\": {\n      \"n_epochs\": 4,\n      \"batch_size\": 1,\n      \"learning_rate_multiplier\": 1.0\n  },\n  \"trained_tokens\": 5768,\n  \"integrations\": [],\n  \"seed\": 0,\n  \"estimated_finish\": 0,\n  \"method\": {\n    \"type\": \"supervised\",\n    \"supervised\": {\n      \"hyperparameters\": {\n        \"n_epochs\": 4,\n        \"batch_size\": 1,\n        \"learning_rate_multiplier\": 1.0\n      }\n    }\n  }\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/fine_tuning/jobs/ft-AF1WoRqd3aJAHsqc9NY7iL8F \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\"\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nfine_tuning_job = client.fine_tuning.jobs.retrieve(\n    \"ft-AF1WoRqd3aJAHsqc9NY7iL8F\",\n)\nprint(fine_tuning_job.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst fineTuningJob = await client.fineTuning.jobs.retrieve('ft-AF1WoRqd3aJAHsqc9NY7iL8F');\n\nconsole.log(fineTuningJob.id);",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  fineTuningJob, err := client.FineTuning.Jobs.Get(context.TODO(), \"ft-AF1WoRqd3aJAHsqc9NY7iL8F\")\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", fineTuningJob.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.finetuning.jobs.FineTuningJob;\nimport com.openai.models.finetuning.jobs.JobRetrieveParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        FineTuningJob fineTuningJob = client.fineTuning().jobs().retrieve(\"ft-AF1WoRqd3aJAHsqc9NY7iL8F\");\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nfine_tuning_job = openai.fine_tuning.jobs.retrieve(\"ft-AF1WoRqd3aJAHsqc9NY7iL8F\")\n\nputs(fine_tuning_job)",
      },
    },
  }
)
@tag("Fine-tuning")
op retrieveFineTuningJob(
  /** The ID of the fine-tuning job. */
  @path
  fine_tuning_job_id: string,
): FineTuningJob;

/** Immediately cancel a fine-tune job. */
@summary("Cancel fine-tuning")
@post
@route("/fine_tuning/jobs/{fine_tuning_job_id}/cancel")
@extension(
  "x-oaiMeta",
  #{
    name: "Cancel fine-tuning",
    group: "fine-tuning",
    returns: "The cancelled [fine-tuning](https://platform.openai.com/docs/api-reference/fine-tuning/object) object.",
    examples: #{
      response: "{\n  \"object\": \"fine_tuning.job\",\n  \"id\": \"ftjob-abc123\",\n  \"model\": \"gpt-4o-mini-2024-07-18\",\n  \"created_at\": 1721764800,\n  \"fine_tuned_model\": null,\n  \"organization_id\": \"org-123\",\n  \"result_files\": [],\n  \"status\": \"cancelled\",\n  \"validation_file\": \"file-abc123\",\n  \"training_file\": \"file-abc123\"\n}\n",
      request: #{
        curl: "curl -X POST https://api.openai.com/v1/fine_tuning/jobs/ftjob-abc123/cancel \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\"\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nfine_tuning_job = client.fine_tuning.jobs.cancel(\n    \"ft-AF1WoRqd3aJAHsqc9NY7iL8F\",\n)\nprint(fine_tuning_job.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst fineTuningJob = await client.fineTuning.jobs.cancel('ft-AF1WoRqd3aJAHsqc9NY7iL8F');\n\nconsole.log(fineTuningJob.id);",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  fineTuningJob, err := client.FineTuning.Jobs.Cancel(context.TODO(), \"ft-AF1WoRqd3aJAHsqc9NY7iL8F\")\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", fineTuningJob.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.finetuning.jobs.FineTuningJob;\nimport com.openai.models.finetuning.jobs.JobCancelParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        FineTuningJob fineTuningJob = client.fineTuning().jobs().cancel(\"ft-AF1WoRqd3aJAHsqc9NY7iL8F\");\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nfine_tuning_job = openai.fine_tuning.jobs.cancel(\"ft-AF1WoRqd3aJAHsqc9NY7iL8F\")\n\nputs(fine_tuning_job)",
      },
    },
  }
)
@tag("Fine-tuning")
op cancelFineTuningJob(
  /** The ID of the fine-tuning job to cancel. */
  @path
  fine_tuning_job_id: string,
): FineTuningJob;

/** List checkpoints for a fine-tuning job. */
@summary("List fine-tuning checkpoints")
@get
@route("/fine_tuning/jobs/{fine_tuning_job_id}/checkpoints")
@extension(
  "x-oaiMeta",
  #{
    name: "List fine-tuning checkpoints",
    group: "fine-tuning",
    returns: "A list of fine-tuning [checkpoint objects](https://platform.openai.com/docs/api-reference/fine-tuning/checkpoint-object) for a fine-tuning job.",
    examples: #{
      response: "{\n  \"object\": \"list\",\n  \"data\": [\n    {\n      \"object\": \"fine_tuning.job.checkpoint\",\n      \"id\": \"ftckpt_zc4Q7MP6XxulcVzj4MZdwsAB\",\n      \"created_at\": 1721764867,\n      \"fine_tuned_model_checkpoint\": \"ft:gpt-4o-mini-2024-07-18:my-org:custom-suffix:96olL566:ckpt-step-2000\",\n      \"metrics\": {\n        \"full_valid_loss\": 0.134,\n        \"full_valid_mean_token_accuracy\": 0.874\n      },\n      \"fine_tuning_job_id\": \"ftjob-abc123\",\n      \"step_number\": 2000\n    },\n    {\n      \"object\": \"fine_tuning.job.checkpoint\",\n      \"id\": \"ftckpt_enQCFmOTGj3syEpYVhBRLTSy\",\n      \"created_at\": 1721764800,\n      \"fine_tuned_model_checkpoint\": \"ft:gpt-4o-mini-2024-07-18:my-org:custom-suffix:7q8mpxmy:ckpt-step-1000\",\n      \"metrics\": {\n        \"full_valid_loss\": 0.167,\n        \"full_valid_mean_token_accuracy\": 0.781\n      },\n      \"fine_tuning_job_id\": \"ftjob-abc123\",\n      \"step_number\": 1000\n    }\n  ],\n  \"first_id\": \"ftckpt_zc4Q7MP6XxulcVzj4MZdwsAB\",\n  \"last_id\": \"ftckpt_enQCFmOTGj3syEpYVhBRLTSy\",\n  \"has_more\": true\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/fine_tuning/jobs/ftjob-abc123/checkpoints \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\"\n",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\n// Automatically fetches more pages as needed.\nfor await (const fineTuningJobCheckpoint of client.fineTuning.jobs.checkpoints.list(\n  'ft-AF1WoRqd3aJAHsqc9NY7iL8F',\n)) {\n  console.log(fineTuningJobCheckpoint.id);\n}",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\npage = client.fine_tuning.jobs.checkpoints.list(\n    fine_tuning_job_id=\"ft-AF1WoRqd3aJAHsqc9NY7iL8F\",\n)\npage = page.data[0]\nprint(page.id)",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  page, err := client.FineTuning.Jobs.Checkpoints.List(\n    context.TODO(),\n    \"ft-AF1WoRqd3aJAHsqc9NY7iL8F\",\n    openai.FineTuningJobCheckpointListParams{\n\n    },\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", page)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.finetuning.jobs.checkpoints.CheckpointListPage;\nimport com.openai.models.finetuning.jobs.checkpoints.CheckpointListParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        CheckpointListPage page = client.fineTuning().jobs().checkpoints().list(\"ft-AF1WoRqd3aJAHsqc9NY7iL8F\");\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\npage = openai.fine_tuning.jobs.checkpoints.list(\"ft-AF1WoRqd3aJAHsqc9NY7iL8F\")\n\nputs(page)",
      },
    },
  }
)
@tag("Fine-tuning")
op listFineTuningJobCheckpoints(
  /** The ID of the fine-tuning job to get checkpoints for. */
  @path
  fine_tuning_job_id: string,

  /** Identifier for the last checkpoint ID from the previous pagination request. */
  @query(#{ explode: true })
  after?: string,

  /** Number of checkpoints to retrieve. */
  @query(#{ explode: true })
  limit?: integer = 10,
): ListFineTuningJobCheckpointsResponse;

/** Get status updates for a fine-tuning job. */
@summary("List fine-tuning events")
@get
@route("/fine_tuning/jobs/{fine_tuning_job_id}/events")
@extension(
  "x-oaiMeta",
  #{
    name: "List fine-tuning events",
    group: "fine-tuning",
    returns: "A list of fine-tuning event objects.",
    examples: #{
      response: "{\n  \"object\": \"list\",\n  \"data\": [\n    {\n      \"object\": \"fine_tuning.job.event\",\n      \"id\": \"ft-event-ddTJfwuMVpfLXseO0Am0Gqjm\",\n      \"created_at\": 1721764800,\n      \"level\": \"info\",\n      \"message\": \"Fine tuning job successfully completed\",\n      \"data\": null,\n      \"type\": \"message\"\n    },\n    {\n      \"object\": \"fine_tuning.job.event\",\n      \"id\": \"ft-event-tyiGuB72evQncpH87xe505Sv\",\n      \"created_at\": 1721764800,\n      \"level\": \"info\",\n      \"message\": \"New fine-tuned model created: ft:gpt-4o-mini:openai::7p4lURel\",\n      \"data\": null,\n      \"type\": \"message\"\n    }\n  ],\n  \"has_more\": true\n}\n",
      request: #{
        curl: "curl https://api.openai.com/v1/fine_tuning/jobs/ftjob-abc123/events \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\"\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\npage = client.fine_tuning.jobs.list_events(\n    fine_tuning_job_id=\"ft-AF1WoRqd3aJAHsqc9NY7iL8F\",\n)\npage = page.data[0]\nprint(page.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\n// Automatically fetches more pages as needed.\nfor await (const fineTuningJobEvent of client.fineTuning.jobs.listEvents('ft-AF1WoRqd3aJAHsqc9NY7iL8F')) {\n  console.log(fineTuningJobEvent.id);\n}",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  page, err := client.FineTuning.Jobs.ListEvents(\n    context.TODO(),\n    \"ft-AF1WoRqd3aJAHsqc9NY7iL8F\",\n    openai.FineTuningJobListEventsParams{\n\n    },\n  )\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", page)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.finetuning.jobs.JobListEventsPage;\nimport com.openai.models.finetuning.jobs.JobListEventsParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        JobListEventsPage page = client.fineTuning().jobs().listEvents(\"ft-AF1WoRqd3aJAHsqc9NY7iL8F\");\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\npage = openai.fine_tuning.jobs.list_events(\"ft-AF1WoRqd3aJAHsqc9NY7iL8F\")\n\nputs(page)",
      },
    },
  }
)
@tag("Fine-tuning")
op listFineTuningEvents(
  /** The ID of the fine-tuning job to get events for. */
  @path
  fine_tuning_job_id: string,

  /** Identifier for the last event from the previous pagination request. */
  @query(#{ explode: true })
  after?: string,

  /** Number of events to retrieve. */
  @query(#{ explode: true })
  limit?: integer = 20,
): ListFineTuningJobEventsResponse;

/** Pause a fine-tune job. */
@summary("Pause fine-tuning")
@post
@route("/fine_tuning/jobs/{fine_tuning_job_id}/pause")
@extension(
  "x-oaiMeta",
  #{
    name: "Pause fine-tuning",
    group: "fine-tuning",
    returns: "The paused [fine-tuning](https://platform.openai.com/docs/api-reference/fine-tuning/object) object.",
    examples: #{
      response: "{\n  \"object\": \"fine_tuning.job\",\n  \"id\": \"ftjob-abc123\",\n  \"model\": \"gpt-4o-mini-2024-07-18\",\n  \"created_at\": 1721764800,\n  \"fine_tuned_model\": null,\n  \"organization_id\": \"org-123\",\n  \"result_files\": [],\n  \"status\": \"paused\",\n  \"validation_file\": \"file-abc123\",\n  \"training_file\": \"file-abc123\"\n}\n",
      request: #{
        curl: "curl -X POST https://api.openai.com/v1/fine_tuning/jobs/ftjob-abc123/pause \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\"\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nfine_tuning_job = client.fine_tuning.jobs.pause(\n    \"ft-AF1WoRqd3aJAHsqc9NY7iL8F\",\n)\nprint(fine_tuning_job.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst fineTuningJob = await client.fineTuning.jobs.pause('ft-AF1WoRqd3aJAHsqc9NY7iL8F');\n\nconsole.log(fineTuningJob.id);",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  fineTuningJob, err := client.FineTuning.Jobs.Pause(context.TODO(), \"ft-AF1WoRqd3aJAHsqc9NY7iL8F\")\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", fineTuningJob.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.finetuning.jobs.FineTuningJob;\nimport com.openai.models.finetuning.jobs.JobPauseParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        FineTuningJob fineTuningJob = client.fineTuning().jobs().pause(\"ft-AF1WoRqd3aJAHsqc9NY7iL8F\");\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nfine_tuning_job = openai.fine_tuning.jobs.pause(\"ft-AF1WoRqd3aJAHsqc9NY7iL8F\")\n\nputs(fine_tuning_job)",
      },
    },
  }
)
@tag("Fine-tuning")
op pauseFineTuningJob(
  /** The ID of the fine-tuning job to pause. */
  @path
  fine_tuning_job_id: string,
): FineTuningJob;

/** Resume a fine-tune job. */
@summary("Resume fine-tuning")
@post
@route("/fine_tuning/jobs/{fine_tuning_job_id}/resume")
@extension(
  "x-oaiMeta",
  #{
    name: "Resume fine-tuning",
    group: "fine-tuning",
    returns: "The resumed [fine-tuning](https://platform.openai.com/docs/api-reference/fine-tuning/object) object.",
    examples: #{
      response: "{\n  \"object\": \"fine_tuning.job\",\n  \"id\": \"ftjob-abc123\",\n  \"model\": \"gpt-4o-mini-2024-07-18\",\n  \"created_at\": 1721764800,\n  \"fine_tuned_model\": null,\n  \"organization_id\": \"org-123\",\n  \"result_files\": [],\n  \"status\": \"queued\",\n  \"validation_file\": \"file-abc123\",\n  \"training_file\": \"file-abc123\"\n}\n",
      request: #{
        curl: "curl -X POST https://api.openai.com/v1/fine_tuning/jobs/ftjob-abc123/resume \\\n  -H \"Authorization: Bearer $OPENAI_API_KEY\"\n",
        python: "from openai import OpenAI\n\nclient = OpenAI(\n    api_key=\"My API Key\",\n)\nfine_tuning_job = client.fine_tuning.jobs.resume(\n    \"ft-AF1WoRqd3aJAHsqc9NY7iL8F\",\n)\nprint(fine_tuning_job.id)",
        `node.js`: "import OpenAI from 'openai';\n\nconst client = new OpenAI({\n  apiKey: 'My API Key',\n});\n\nconst fineTuningJob = await client.fineTuning.jobs.resume('ft-AF1WoRqd3aJAHsqc9NY7iL8F');\n\nconsole.log(fineTuningJob.id);",
        go: "package main\n\nimport (\n  \"context\"\n  \"fmt\"\n\n  \"github.com/openai/openai-go\"\n  \"github.com/openai/openai-go/option\"\n)\n\nfunc main() {\n  client := openai.NewClient(\n    option.WithAPIKey(\"My API Key\"),\n  )\n  fineTuningJob, err := client.FineTuning.Jobs.Resume(context.TODO(), \"ft-AF1WoRqd3aJAHsqc9NY7iL8F\")\n  if err != nil {\n    panic(err.Error())\n  }\n  fmt.Printf(\"%+v\\n\", fineTuningJob.ID)\n}\n",
        java: "package com.openai.example;\n\nimport com.openai.client.OpenAIClient;\nimport com.openai.client.okhttp.OpenAIOkHttpClient;\nimport com.openai.models.finetuning.jobs.FineTuningJob;\nimport com.openai.models.finetuning.jobs.JobResumeParams;\n\npublic final class Main {\n    private Main() {}\n\n    public static void main(String[] args) {\n        OpenAIClient client = OpenAIOkHttpClient.fromEnv();\n\n        FineTuningJob fineTuningJob = client.fineTuning().jobs().resume(\"ft-AF1WoRqd3aJAHsqc9NY7iL8F\");\n    }\n}",
        ruby: "require \"openai\"\n\nopenai = OpenAI::Client.new(api_key: \"My API Key\")\n\nfine_tuning_job = openai.fine_tuning.jobs.resume(\"ft-AF1WoRqd3aJAHsqc9NY7iL8F\")\n\nputs(fine_tuning_job)",
      },
    },
  }
)
@tag("Fine-tuning")
op resumeFineTuningJob(
  /** The ID of the fine-tuning job to resume. */
  @path
  fine_tuning_job_id: string,
): FineTuningJob;
