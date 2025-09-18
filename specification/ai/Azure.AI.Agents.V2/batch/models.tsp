import "@typespec/openapi";
import "../common/models.tsp";
using TypeSpec.OpenAPI;
namespace OpenAI;
@extension(
  "x-oaiMeta",
  #{
    name: "The batch object",
    example: "{\n  \"id\": \"batch_abc123\",\n  \"object\": \"batch\",\n  \"endpoint\": \"/v1/completions\",\n  \"errors\": null,\n  \"input_file_id\": \"file-abc123\",\n  \"completion_window\": \"24h\",\n  \"status\": \"completed\",\n  \"output_file_id\": \"file-cvaTdG\",\n  \"error_file_id\": \"file-HOWS94\",\n  \"created_at\": 1711471533,\n  \"in_progress_at\": 1711471538,\n  \"expires_at\": 1711557933,\n  \"finalizing_at\": 1711493133,\n  \"completed_at\": 1711493163,\n  \"failed_at\": null,\n  \"expired_at\": null,\n  \"cancelling_at\": null,\n  \"cancelled_at\": null,\n  \"request_counts\": {\n    \"total\": 100,\n    \"completed\": 95,\n    \"failed\": 5\n  },\n  \"metadata\": {\n    \"customer_id\": \"user_123456789\",\n    \"batch_description\": \"Nightly eval job\",\n  }\n}\n",
  }
)
model Batch {
  id: string;

  /** The object type, which is always `batch`. */
  @extension("x-stainless-const", true)
  object: "batch";

  /** The OpenAI API endpoint used by the batch. */
  endpoint: string;

  errors?: {
    object?: string;
    data?: BatchError[];
  };

  /** The ID of the input file for the batch. */
  input_file_id: string;

  /** The time frame within which the batch should be processed. */
  completion_window: string;

  /** The current status of the batch. */
  status:
    | "validating"
    | "failed"
    | "in_progress"
    | "finalizing"
    | "completed"
    | "expired"
    | "cancelling"
    | "cancelled";

  /** The ID of the file containing the outputs of successfully executed requests. */
  output_file_id?: string;

  /** The ID of the file containing the outputs of requests with errors. */
  error_file_id?: string;

  /** The Unix timestamp (in seconds) for when the batch was created. */
  created_at: integer;

  /** The Unix timestamp (in seconds) for when the batch started processing. */
  in_progress_at?: integer;

  /** The Unix timestamp (in seconds) for when the batch will expire. */
  expires_at?: integer;

  /** The Unix timestamp (in seconds) for when the batch started finalizing. */
  finalizing_at?: integer;

  /** The Unix timestamp (in seconds) for when the batch was completed. */
  completed_at?: integer;

  /** The Unix timestamp (in seconds) for when the batch failed. */
  failed_at?: integer;

  /** The Unix timestamp (in seconds) for when the batch expired. */
  expired_at?: integer;

  /** The Unix timestamp (in seconds) for when the batch started cancelling. */
  cancelling_at?: integer;

  /** The Unix timestamp (in seconds) for when the batch was cancelled. */
  cancelled_at?: integer;

  request_counts?: BatchRequestCounts;
  metadata?: Metadata;
}

model BatchError {
  /** An error code identifying the error type. */
  code?: string;

  /** A human-readable message providing more details about the error. */
  message?: string;

  /** The name of the parameter that caused the error, if applicable. */
  param?: string | null;

  /** The line number of the input file where the error occurred, if applicable. */
  line?: integer | null;
}

/** The request counts for different statuses within the batch. */
model BatchRequestCounts {
  /** Total number of requests in the batch. */
  total: integer;

  /** Number of requests that have been completed successfully. */
  completed: integer;

  /** Number of requests that have failed. */
  failed: integer;
}

/** The expiration policy for the output and/or error file that are generated for a batch. */
@summary("File expiration policy")
model BatchFileExpirationAfter {
  /** Anchor timestamp after which the expiration policy applies. Supported anchors: `created_at`. Note that the anchor is the file creation time, not the time the batch is created. */
  @extension("x-stainless-const", true)
  anchor: "created_at";

  /** The number of seconds after the anchor time that the file will expire. Must be between 3600 (1 hour) and 2592000 (30 days). */
  @maxValue(2592000)
  @minValue(3600)
  seconds: integer;
}

/** The per-line object of the batch input file */
@extension(
  "x-oaiMeta",
  #{
    name: "The request input object",
    example: "{\"custom_id\": \"request-1\", \"method\": \"POST\", \"url\": \"/v1/chat/completions\", \"body\": {\"model\": \"gpt-4o-mini\", \"messages\": [{\"role\": \"system\", \"content\": \"You are a helpful assistant.\"}, {\"role\": \"user\", \"content\": \"What is 2+2?\"}]}}\n",
  }
)
model BatchRequestInput {
  /** A developer-provided per-request id that will be used to match outputs to inputs. Must be unique for each request in a batch. */
  custom_id?: string;

  /** The HTTP method to be used for the request. Currently only `POST` is supported. */
  @extension("x-stainless-const", true)
  method?: "POST";

  /** The OpenAI API relative URL to be used for the request. Currently `/v1/chat/completions`, `/v1/embeddings`, and `/v1/completions` are supported. */
  url?: string;
}

/** The per-line object of the batch output and error files */
@extension(
  "x-oaiMeta",
  #{
    name: "The request output object",
    example: "{\"id\": \"batch_req_wnaDys\", \"custom_id\": \"request-2\", \"response\": {\"status_code\": 200, \"request_id\": \"req_c187b3\", \"body\": {\"id\": \"chatcmpl-9758Iw\", \"object\": \"chat.completion\", \"created\": 1711475054, \"model\": \"gpt-4o-mini\", \"choices\": [{\"index\": 0, \"message\": {\"role\": \"assistant\", \"content\": \"2 + 2 equals 4.\"}, \"finish_reason\": \"stop\"}], \"usage\": {\"prompt_tokens\": 24, \"completion_tokens\": 15, \"total_tokens\": 39}, \"system_fingerprint\": null}}, \"error\": null}\n",
  }
)
model BatchRequestOutput {
  id?: string;

  /** A developer-provided per-request id that will be used to match outputs to inputs. */
  custom_id?: string;

  response?: {
    status_code?: integer;
    request_id?: string;

    @extension("x-oaiTypeLabel", "map")
    body?: {};
  } | null;

  /** For requests that failed with a non-HTTP error, this will contain more information on the cause of the failure. */
  error?: {
    code?: string;
    message?: string;
  } | null;
}

model ListBatchesResponse {
  data: Batch[];
  first_id?: string;
  last_id?: string;
  has_more: boolean;

  @extension("x-stainless-const", true)
  object: "list";
}
