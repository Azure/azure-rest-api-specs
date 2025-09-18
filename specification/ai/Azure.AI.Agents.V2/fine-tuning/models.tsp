import "@typespec/openapi";
import "../common/models.tsp";
import "../graders/models.tsp";
import "../chat/models.tsp";
using TypeSpec.OpenAPI;
namespace OpenAI;
model CreateFineTuningCheckpointPermissionRequest {
  /** The project identifiers to grant access to. */
  project_ids: string[];
}

model CreateFineTuningJobRequest {
  /**The name of the model to fine-tune. You can select one of the
  [supported models](https://platform.openai.com/docs/guides/fine-tuning#which-models-can-be-fine-tuned).*/
  @extension("x-oaiTypeLabel", "string")
  `model`:
    | string
    | "babbage-002"
    | "davinci-002"
    | "gpt-3.5-turbo"
    | "gpt-4o-mini";

  /**The ID of an uploaded file that contains training data.

  See [upload file](https://platform.openai.com/docs/api-reference/files/create) for how to upload a file.

  Your dataset must be formatted as a JSONL file. Additionally, you must upload your file with the purpose `fine-tune`.

  The contents of the file should differ depending on if the model uses the [chat](https://platform.openai.com/docs/api-reference/fine-tuning/chat-input), [completions](https://platform.openai.com/docs/api-reference/fine-tuning/completions-input) format, or if the fine-tuning method uses the [preference](https://platform.openai.com/docs/api-reference/fine-tuning/preference-input) format.

  See the [fine-tuning guide](https://platform.openai.com/docs/guides/model-optimization) for more details.*/
  training_file: string;

  /**The hyperparameters used for the fine-tuning job.
  This value is now deprecated in favor of `method`, and should be passed in under the `method` parameter.*/
  hyperparameters?: {
    batch_size?: "auto" | integer = "auto";
    learning_rate_multiplier?: "auto" | numeric;
    n_epochs?: "auto" | integer = "auto";
  };

  /**A string of up to 64 characters that will be added to your fine-tuned model name.

  For example, a `suffix` of "custom-model-name" would produce a model name like `ft:gpt-4o-mini:openai:custom-model-name:7p4lURel`.*/
  @maxLength(64)
  @minLength(1)
  suffix?: string | null;

  /**The ID of an uploaded file that contains validation data.

  If you provide this file, the data is used to generate validation
  metrics periodically during fine-tuning. These metrics can be viewed in
  the fine-tuning results file.
  The same data should not be present in both train and validation files.

  Your dataset must be formatted as a JSONL file. You must upload your file with the purpose `fine-tune`.

  See the [fine-tuning guide](https://platform.openai.com/docs/guides/model-optimization) for more details.*/
  validation_file?: string | null;

  /** A list of integrations to enable for your fine-tuning job. */
  integrations?: {
    @extension("x-stainless-const", true)
    type: "wandb";

    wandb: {
      project: string;
      name?: string | null;
      entity?: string | null;
      tags?: string[];
    };
  }[] | null;

  /**The seed controls the reproducibility of the job. Passing in the same seed and job parameters should produce the same results, but may differ in rare cases.
  If a seed is not specified, one will be generated for you.*/
  @maxValue(2147483647)
  @minValue(0)
  seed?: integer | null;

  method?: FineTuneMethod;
  metadata?: Metadata;
}

/** The method used for fine-tuning. */
model FineTuneMethod {
  /** The type of method. Is either `supervised`, `dpo`, or `reinforcement`. */
  type: "supervised" | "dpo" | "reinforcement";

  supervised?: FineTuneSupervisedMethod;
  dpo?: FineTuneDPOMethod;
  reinforcement?: FineTuneReinforcementMethod;
}

/** Configuration for the supervised fine-tuning method. */
model FineTuneSupervisedMethod {
  hyperparameters?: FineTuneSupervisedHyperparameters;
}

/** The hyperparameters used for the fine-tuning job. */
model FineTuneSupervisedHyperparameters {
  /** Number of examples in each batch. A larger batch size means that model parameters are updated less frequently, but with lower variance. */
  batch_size?: "auto" | integer = "auto";

  /** Scaling factor for the learning rate. A smaller learning rate may be useful to avoid overfitting. */
  learning_rate_multiplier?: "auto" | numeric;

  /** The number of epochs to train the model for. An epoch refers to one full cycle through the training dataset. */
  n_epochs?: "auto" | integer = "auto";
}

/** Configuration for the DPO fine-tuning method. */
model FineTuneDPOMethod {
  hyperparameters?: FineTuneDPOHyperparameters;
}

/** The hyperparameters used for the DPO fine-tuning job. */
model FineTuneDPOHyperparameters {
  /** The beta value for the DPO method. A higher beta value will increase the weight of the penalty between the policy and reference model. */
  beta?: "auto" | numeric;

  /** Number of examples in each batch. A larger batch size means that model parameters are updated less frequently, but with lower variance. */
  batch_size?: "auto" | integer = "auto";

  /** Scaling factor for the learning rate. A smaller learning rate may be useful to avoid overfitting. */
  learning_rate_multiplier?: "auto" | numeric;

  /** The number of epochs to train the model for. An epoch refers to one full cycle through the training dataset. */
  n_epochs?: "auto" | integer = "auto";
}

/** Configuration for the reinforcement fine-tuning method. */
model FineTuneReinforcementMethod {
  /** The grader used for the fine-tuning job. */
  grader:
    | GraderStringCheck
    | GraderTextSimilarity
    | GraderPython
    | GraderScoreModel
    | GraderMulti;

  hyperparameters?: FineTuneReinforcementHyperparameters;
}

/** The hyperparameters used for the reinforcement fine-tuning job. */
model FineTuneReinforcementHyperparameters {
  /** Number of examples in each batch. A larger batch size means that model parameters are updated less frequently, but with lower variance. */
  batch_size?: "auto" | integer = "auto";

  /** Scaling factor for the learning rate. A smaller learning rate may be useful to avoid overfitting. */
  learning_rate_multiplier?: "auto" | numeric;

  /** The number of epochs to train the model for. An epoch refers to one full cycle through the training dataset. */
  n_epochs?: "auto" | integer = "auto";

  /** Level of reasoning effort. */
  reasoning_effort?: "default" | "low" | "medium" | "high" = "default";

  /** Multiplier on amount of compute used for exploring search space during training. */
  compute_multiplier?: "auto" | numeric;

  /** The number of training steps between evaluation runs. */
  eval_interval?: "auto" | integer = "auto";

  /** Number of evaluation samples to generate per training step. */
  eval_samples?: "auto" | integer = "auto";
}

model DeleteFineTuningCheckpointPermissionResponse {
  /** The ID of the fine-tuned model checkpoint permission that was deleted. */
  id: string;

  /** The object type, which is always "checkpoint.permission". */
  @extension("x-stainless-const", true)
  object: "checkpoint.permission";

  /** Whether the fine-tuned model checkpoint permission was successfully deleted. */
  deleted: boolean;
}

model FineTuneChatCompletionRequestAssistantMessage {
  /** The contents of the assistant message. Required unless `tool_calls` or `function_call` is specified. */
  content?: string | ChatCompletionRequestAssistantMessageContentPart[] | null;

  /** The refusal message by the assistant. */
  refusal?: string | null;

  /** The role of the messages author, in this case `assistant`. */
  @extension("x-stainless-const", true)
  role: "assistant";

  /** An optional name for the participant. Provides the model information to differentiate between participants of the same role. */
  name?: string;

  /**Data about a previous audio response from the model.
  [Learn more](https://platform.openai.com/docs/guides/audio).*/
  audio?: {
    id: string;
  } | null;

  tool_calls?: (ChatCompletionMessageToolCall | ChatCompletionMessageCustomToolCall)[];

  /** Deprecated and replaced by `tool_calls`. The name and arguments of a function that should be called, as generated by the model. */
  function_call?: {
    arguments: string;
    name: string;
  } | null;

  /** Controls whether the assistant message is trained against (0 or 1) */
  weight?: 0 | 1;
}

/**The per-line training example of a fine-tuning input file for chat models using the supervised method.
Input messages may contain text or image content only. Audio and file input messages
are not currently supported for fine-tuning.*/
@extension(
  "x-oaiMeta",
  #{
    name: "Training format for chat models using the supervised method",
    example: "{\n  \"messages\": [\n    { \"role\": \"user\", \"content\": \"What is the weather in San Francisco?\" },\n    {\n      \"role\": \"assistant\",\n      \"tool_calls\": [\n        {\n          \"id\": \"call_id\",\n          \"type\": \"function\",\n          \"function\": {\n            \"name\": \"get_current_weather\",\n            \"arguments\": \"{\\\"location\\\": \\\"San Francisco, USA\\\", \\\"format\\\": \\\"celsius\\\"}\"\n          }\n        }\n      ]\n    }\n  ],\n  \"parallel_tool_calls\": false,\n  \"tools\": [\n    {\n      \"type\": \"function\",\n      \"function\": {\n        \"name\": \"get_current_weather\",\n        \"description\": \"Get the current weather\",\n        \"parameters\": {\n          \"type\": \"object\",\n          \"properties\": {\n            \"location\": {\n                \"type\": \"string\",\n                \"description\": \"The city and country, eg. San Francisco, USA\"\n            },\n            \"format\": { \"type\": \"string\", \"enum\": [\"celsius\", \"fahrenheit\"] }\n          },\n          \"required\": [\"location\", \"format\"]\n        }\n      }\n    }\n  ]\n}\n",
  }
)
model FineTuneChatRequestInput {
  @minItems(1)
  messages?: (
    | ChatCompletionRequestSystemMessage
    | ChatCompletionRequestUserMessage
    | FineTuneChatCompletionRequestAssistantMessage
    | ChatCompletionRequestToolMessage
    | ChatCompletionRequestFunctionMessage)[];

  /** A list of tools the model may generate JSON inputs for. */
  tools?: ChatCompletionTool[];

  parallel_tool_calls?: ParallelToolCalls;

  /** A list of functions the model may generate JSON inputs for. */
  @maxItems(128)
  @minItems(1)
  functions?: ChatCompletionFunctions[];
}

/**The per-line training example of a fine-tuning input file for chat models using the dpo method.
Input messages may contain text or image content only. Audio and file input messages
are not currently supported for fine-tuning.*/
@extension(
  "x-oaiMeta",
  #{
    name: "Training format for chat models using the preference method",
    example: "{\n  \"input\": {\n    \"messages\": [\n      { \"role\": \"user\", \"content\": \"What is the weather in San Francisco?\" }\n    ]\n  },\n  \"preferred_output\": [\n    {\n      \"role\": \"assistant\",\n      \"content\": \"The weather in San Francisco is 70 degrees Fahrenheit.\"\n    }\n  ],\n  \"non_preferred_output\": [\n    {\n      \"role\": \"assistant\",\n      \"content\": \"The weather in San Francisco is 21 degrees Celsius.\"\n    }\n  ]\n}\n",
  }
)
model FineTunePreferenceRequestInput {
  input?: {
    @minItems(1)
    messages?: (
      | ChatCompletionRequestSystemMessage
      | ChatCompletionRequestUserMessage
      | FineTuneChatCompletionRequestAssistantMessage
      | ChatCompletionRequestToolMessage
      | ChatCompletionRequestFunctionMessage)[];

    tools?: ChatCompletionTool[];
    parallel_tool_calls?: ParallelToolCalls;
  };

  /** The preferred completion message for the output. */
  @maxItems(1)
  preferred_output?: ChatCompletionRequestAssistantMessage[];

  /** The non-preferred completion message for the output. */
  @maxItems(1)
  non_preferred_output?: ChatCompletionRequestAssistantMessage[];
}

/**Per-line training example for reinforcement fine-tuning. Note that `messages` and `tools` are the only reserved keywords.
Any other arbitrary key-value data can be included on training datapoints and will be available to reference during grading under the `{{ item.XXX }}` template variable.
Input messages may contain text or image content only. Audio and file input messages
are not currently supported for fine-tuning.*/
@extension(
  "x-oaiMeta",
  #{
    name: "Training format for reasoning models using the reinforcement method",
    example: "{\n  \"messages\": [\n    {\n      \"role\": \"user\",\n      \"content\": \"Your task is to take a chemical in SMILES format and predict the number of hydrobond bond donors and acceptors according to Lipinkski's rule. CCN(CC)CCC(=O)c1sc(N)nc1C\"\n    },\n  ],\n  # Any other JSON data can be inserted into an example and referenced during RFT grading\n  \"reference_answer\": {\n    \"donor_bond_counts\": 5,\n    \"acceptor_bond_counts\": 7\n  }\n}\n",
  }
)
model FineTuneReinforcementRequestInput {
  @minItems(1)
  messages: (
    | ChatCompletionRequestDeveloperMessage
    | ChatCompletionRequestUserMessage
    | FineTuneChatCompletionRequestAssistantMessage
    | ChatCompletionRequestToolMessage)[];

  /** A list of tools the model may generate JSON inputs for. */
  tools?: ChatCompletionTool[];
}

/** The `checkpoint.permission` object represents a permission for a fine-tuned model checkpoint. */
@summary("FineTuningCheckpointPermission")
@extension(
  "x-oaiMeta",
  #{
    name: "The fine-tuned model checkpoint permission object",
    example: "{\n  \"object\": \"checkpoint.permission\",\n  \"id\": \"cp_zc4Q7MP6XxulcVzj4MZdwsAB\",\n  \"created_at\": 1712211699,\n  \"project_id\": \"proj_abGMw1llN8IrBb6SvvY5A1iH\"\n}\n",
  }
)
model FineTuningCheckpointPermission {
  /** The permission identifier, which can be referenced in the API endpoints. */
  id: string;

  /** The Unix timestamp (in seconds) for when the permission was created. */
  created_at: integer;

  /** The project identifier that the permission is for. */
  project_id: string;

  /** The object type, which is always "checkpoint.permission". */
  @extension("x-stainless-const", true)
  object: "checkpoint.permission";
}

@summary("Fine-Tuning Job Integration")
model FineTuningIntegration {
  /** The type of the integration being enabled for the fine-tuning job */
  @extension("x-stainless-const", true)
  type: "wandb";

  /**The settings for your integration with Weights and Biases. This payload specifies the project that
  metrics will be sent to. Optionally, you can set an explicit display name for your run, add tags
  to your run, and set a default entity (team, username, etc) to be associated with your run.*/
  wandb: {
    project: string;
    name?: string | null;
    entity?: string | null;
    tags?: string[];
  };
}

/** The `fine_tuning.job` object represents a fine-tuning job that has been created through the API. */
@summary("FineTuningJob")
@extension(
  "x-oaiMeta",
  #{
    name: "The fine-tuning job object",
    example: "{\n  \"object\": \"fine_tuning.job\",\n  \"id\": \"ftjob-abc123\",\n  \"model\": \"davinci-002\",\n  \"created_at\": 1692661014,\n  \"finished_at\": 1692661190,\n  \"fine_tuned_model\": \"ft:davinci-002:my-org:custom_suffix:7q8mpxmy\",\n  \"organization_id\": \"org-123\",\n  \"result_files\": [\n      \"file-abc123\"\n  ],\n  \"status\": \"succeeded\",\n  \"validation_file\": null,\n  \"training_file\": \"file-abc123\",\n  \"hyperparameters\": {\n      \"n_epochs\": 4,\n      \"batch_size\": 1,\n      \"learning_rate_multiplier\": 1.0\n  },\n  \"trained_tokens\": 5768,\n  \"integrations\": [],\n  \"seed\": 0,\n  \"estimated_finish\": 0,\n  \"method\": {\n    \"type\": \"supervised\",\n    \"supervised\": {\n      \"hyperparameters\": {\n        \"n_epochs\": 4,\n        \"batch_size\": 1,\n        \"learning_rate_multiplier\": 1.0\n      }\n    }\n  },\n  \"metadata\": {\n    \"key\": \"value\"\n  }\n}\n",
  }
)
model FineTuningJob {
  /** The object identifier, which can be referenced in the API endpoints. */
  id: string;

  /** The Unix timestamp (in seconds) for when the fine-tuning job was created. */
  created_at: integer;

  /** For fine-tuning jobs that have `failed`, this will contain more information on the cause of the failure. */
  error: {
    code: string;
    message: string;
    param: string | null;
  } | null;

  /** The name of the fine-tuned model that is being created. The value will be null if the fine-tuning job is still running. */
  fine_tuned_model: string | null;

  /** The Unix timestamp (in seconds) for when the fine-tuning job was finished. The value will be null if the fine-tuning job is still running. */
  finished_at: integer | null;

  /** The hyperparameters used for the fine-tuning job. This value will only be returned when running `supervised` jobs. */
  hyperparameters: {
    batch_size?: "auto" | integer | null;
    learning_rate_multiplier?: "auto" | numeric;
    n_epochs?: "auto" | integer = "auto";
  };

  /** The base model that is being fine-tuned. */
  `model`: string;

  /** The object type, which is always "fine_tuning.job". */
  @extension("x-stainless-const", true)
  object: "fine_tuning.job";

  /** The organization that owns the fine-tuning job. */
  organization_id: string;

  /** The compiled results file ID(s) for the fine-tuning job. You can retrieve the results with the [Files API](https://platform.openai.com/docs/api-reference/files/retrieve-contents). */
  result_files: string[];

  /** The current status of the fine-tuning job, which can be either `validating_files`, `queued`, `running`, `succeeded`, `failed`, or `cancelled`. */
  status:
    | "validating_files"
    | "queued"
    | "running"
    | "succeeded"
    | "failed"
    | "cancelled";

  /** The total number of billable tokens processed by this fine-tuning job. The value will be null if the fine-tuning job is still running. */
  trained_tokens: integer | null;

  /** The file ID used for training. You can retrieve the training data with the [Files API](https://platform.openai.com/docs/api-reference/files/retrieve-contents). */
  training_file: string;

  /** The file ID used for validation. You can retrieve the validation results with the [Files API](https://platform.openai.com/docs/api-reference/files/retrieve-contents). */
  validation_file: string | null;

  /** A list of integrations to enable for this fine-tuning job. */
  @maxItems(5)
  integrations?: FineTuningIntegration[];

  /** The seed used for the fine-tuning job. */
  seed: integer;

  /** The Unix timestamp (in seconds) for when the fine-tuning job is estimated to finish. The value will be null if the fine-tuning job is not running. */
  estimated_finish?: integer | null;

  method?: FineTuneMethod;
  metadata?: Metadata;
}

/** The `fine_tuning.job.checkpoint` object represents a model checkpoint for a fine-tuning job that is ready to use. */
@summary("FineTuningJobCheckpoint")
@extension(
  "x-oaiMeta",
  #{
    name: "The fine-tuning job checkpoint object",
    example: "{\n  \"object\": \"fine_tuning.job.checkpoint\",\n  \"id\": \"ftckpt_qtZ5Gyk4BLq1SfLFWp3RtO3P\",\n  \"created_at\": 1712211699,\n  \"fine_tuned_model_checkpoint\": \"ft:gpt-4o-mini-2024-07-18:my-org:custom_suffix:9ABel2dg:ckpt-step-88\",\n  \"fine_tuning_job_id\": \"ftjob-fpbNQ3H1GrMehXRf8cO97xTN\",\n  \"metrics\": {\n    \"step\": 88,\n    \"train_loss\": 0.478,\n    \"train_mean_token_accuracy\": 0.924,\n    \"valid_loss\": 10.112,\n    \"valid_mean_token_accuracy\": 0.145,\n    \"full_valid_loss\": 0.567,\n    \"full_valid_mean_token_accuracy\": 0.944\n  },\n  \"step_number\": 88\n}\n",
  }
)
model FineTuningJobCheckpoint {
  /** The checkpoint identifier, which can be referenced in the API endpoints. */
  id: string;

  /** The Unix timestamp (in seconds) for when the checkpoint was created. */
  created_at: integer;

  /** The name of the fine-tuned checkpoint model that is created. */
  fine_tuned_model_checkpoint: string;

  /** The step number that the checkpoint was created at. */
  step_number: integer;

  /** Metrics at the step number during the fine-tuning job. */
  metrics: {
    step?: numeric;
    train_loss?: numeric;
    train_mean_token_accuracy?: numeric;
    valid_loss?: numeric;
    valid_mean_token_accuracy?: numeric;
    full_valid_loss?: numeric;
    full_valid_mean_token_accuracy?: numeric;
  };

  /** The name of the fine-tuning job that this checkpoint was created from. */
  fine_tuning_job_id: string;

  /** The object type, which is always "fine_tuning.job.checkpoint". */
  @extension("x-stainless-const", true)
  object: "fine_tuning.job.checkpoint";
}

/** Fine-tuning job event object */
@extension(
  "x-oaiMeta",
  #{
    name: "The fine-tuning job event object",
    example: "{\n  \"object\": \"fine_tuning.job.event\",\n  \"id\": \"ftevent-abc123\"\n  \"created_at\": 1677610602,\n  \"level\": \"info\",\n  \"message\": \"Created fine-tuning job\",\n  \"data\": {},\n  \"type\": \"message\"\n}\n",
  }
)
model FineTuningJobEvent {
  /** The object type, which is always "fine_tuning.job.event". */
  @extension("x-stainless-const", true)
  object: "fine_tuning.job.event";

  /** The object identifier. */
  id: string;

  /** The Unix timestamp (in seconds) for when the fine-tuning job was created. */
  created_at: integer;

  /** The log level of the event. */
  level: "info" | "warn" | "error";

  /** The message of the event. */
  message: string;

  /** The type of event. */
  type?: "message" | "metrics";

  /** The data associated with the event. */
  data?: {};
}

model ListFineTuningCheckpointPermissionResponse {
  data: FineTuningCheckpointPermission[];

  @extension("x-stainless-const", true)
  object: "list";

  first_id?: string | null;
  last_id?: string | null;
  has_more: boolean;
}

model ListFineTuningJobCheckpointsResponse {
  data: FineTuningJobCheckpoint[];

  @extension("x-stainless-const", true)
  object: "list";

  first_id?: string | null;
  last_id?: string | null;
  has_more: boolean;
}

model ListFineTuningJobEventsResponse {
  data: FineTuningJobEvent[];

  @extension("x-stainless-const", true)
  object: "list";

  has_more: boolean;
}

model ListPaginatedFineTuningJobsResponse {
  data: FineTuningJob[];
  has_more: boolean;

  @extension("x-stainless-const", true)
  object: "list";
}
