import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";

import "../main.tsp";

namespace Azure.OpenAI;

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

/** A list of Batch errors. */
@added(ServiceApiVersions.v2024_07_01_Preview)
model BatchErrorList {
  @doc("""
    The object type, which is always `list`.
    """)
  object: "list";

  /** The list of Batch error data. */
  data?: BatchErrorDatum[];
}
/** A Datum containing information about a Batch Error. */
@added(ServiceApiVersions.v2024_07_01_Preview)
model BatchErrorDatum {
  /** An error code identifying the error type. */
  code?: string;

  /** A human-readable message providing more details about the error. */
  message?: string;

  /** The name of the parameter that caused the error, if applicable. */
  param?: string;

  /** The line number of the input file where the error occurred, if applicable. */
  line?: int32;
}

/** Defines the request to create a batch. */
@added(ServiceApiVersions.v2024_07_01_Preview)
model BatchCreateRequest {
  /** The API endpoint used by the batch. */
  endpoint: string;

  /** The ID of the input file for the batch. */
  @minLength(1)
  @encodedName("application/json", "input_file_id")
  inputFileId: string;

  /** The time frame within which the batch should be processed. */
  @encodedName("application/json", "completion_window")
  completionWindow: string;

  /** A set of key-value pairs that can be attached to the batch. This can be useful for storing additional information about the batch in a structured format. */
  metadata?: Record<string>;
}

/** The requested new batch job. */
@added(ServiceApiVersions.v2024_07_01_Preview)
model BatchCreateResponse {
  // Customization note: the status code in OpenAI is 200.
  // Reference: https://github.com/openai/openai-openapi/blob/423e672461b3d17f9829711e4a858e777252f077/openapi.yaml#L6903-L6909
  /**
   * The status code indicating a successful batch creation response.
   */
  @statusCode
  statusCode: 201;

  ...Batch;
}

/** The status of a batch. */
union BatchStatus {
  /** The input file is being validated before the batch can begin. */
  validating: "validating",

  /** The input file has failed the validation process. */
  failed: "failed",

  /** The input file was successfully validated and the batch is currently being executed. */
  in_progress: "in_progress",

  /** The batch has completed and the results are being prepared. */
  finalizing: "finalizing",

  /** The batch has been completed and the results are ready. */
  completed: "completed",

  /** The batch was not able to complete within the 24-hour time window. */
  expired: "expired",

  /** Cancellation of the batch has been initiated. */
  cancelling: "cancelling",

  /** The batch was cancelled. */
  cancelled: "cancelled",

  string,
}

/** The Batch object. */
@added(ServiceApiVersions.v2024_07_01_Preview)
model Batch {
  /** The id assigned to the Batch. */
  id: string;

  /** The object type, which is always `batch`. */
  object: "batch";

  /** The OpenAI API endpoint used by the batch. */
  endpoint?: string;

  /** The list of Batch errors. */
  errors?: BatchErrorList;

  /** The ID of the input file for the batch. */
  @minLength(1)
  @encodedName("application/json", "input_file_id")
  inputFileId: string;

  /** The time frame within which the batch should be processed. */
  @encodedName("application/json", "completion_window")
  completionWindow?: string;

  /** The current status of the batch. */
  status?: BatchStatus;

  /** The ID of the file containing the outputs of successfully executed requests. */
  @encodedName("application/json", "output_file_id")
  outputFileId?: string;

  /** The ID of the file containing the outputs of requests with errors. */
  @encodedName("application/json", "error_file_id")
  errorFileId?: string;

  /** The Unix timestamp (in seconds) for when the batch was created. */
  @encodedName("application/json", "created_at")
  @encode("unixTimestamp", int32)
  createdAt?: utcDateTime;

  /** The Unix timestamp (in seconds) for when the batch started processing. */
  @encodedName("application/json", "in_progress_at")
  @encode("unixTimestamp", int32)
  inProgressAt?: utcDateTime;

  /** The Unix timestamp (in seconds) for when the batch will expire. */
  @encodedName("application/json", "expires_at")
  @encode("unixTimestamp", int32)
  expiresAt?: utcDateTime;

  /** The Unix timestamp (in seconds) for when the batch started finalizing. */
  @encodedName("application/json", "finalizing_at")
  @encode("unixTimestamp", int32)
  finalizingAt?: utcDateTime;

  /** The Unix timestamp (in seconds) for when the batch was completed. */
  @encodedName("application/json", "completed_at")
  @encode("unixTimestamp", int32)
  completedAt?: utcDateTime;

  /** The Unix timestamp (in seconds) for when the batch failed. */
  @encodedName("application/json", "failed_at")
  @encode("unixTimestamp", int32)
  failedAt?: utcDateTime;

  /** The Unix timestamp (in seconds) for when the batch expired. */
  @encodedName("application/json", "expired_at")
  @encode("unixTimestamp", int32)
  expiredAt?: utcDateTime;

  /** The Unix timestamp (in seconds) for when the batch started cancelling. */
  @encodedName("application/json", "cancelling_at")
  @encode("unixTimestamp", int32)
  cancellingAt?: utcDateTime;

  /** The Unix timestamp (in seconds) for when the batch was cancelled. */
  @encodedName("application/json", "cancelled_at")
  @encode("unixTimestamp", int32)
  cancelledAt?: utcDateTime;

  /** The request counts for different statuses within the batch. */
  @encodedName("application/json", "request_counts")
  requestCounts?: {
    /** Total number of requests in the batch. */
    total?: int32;

    /** Number of requests that have been completed successfully. */
    completed?: int32;

    /** Number of requests that have failed. */
    failed?: int32;
  };

  /** A set of key-value pairs that can be attached to the batch. This can be useful for storing additional information about the batch in a structured format. */
  metadata?: Record<string>;
}

/** The per-line object of the batch input file */
@added(ServiceApiVersions.v2024_07_01_Preview)
model BatchRequestInput {
  /** A developer-provided per-request id that will be used to match outputs to inputs. Must be unique for each request in a batch. */
  @encodedName("application/json", "custom_id")
  customId?: string;

  @doc("""
    The HTTP method to be used for the request. Currently only `POST` is supported.
    """)
  method?: "POST";

  @doc("""
    The OpenAI API relative URL to be used for the request. Currently `/v1/chat/completions`, `/v1/embeddings`, and `/v1/completions` are supported.
    """)
  url?: url;
}

/** The per-line object of the batch output and error files */
@added(ServiceApiVersions.v2024_07_01_Preview)
model BatchRequestOutput {
  /** The Id of the request. */
  id?: string;

  /** A developer-provided per-request id that will be used to match outputs to inputs. */
  @encodedName("application/json", "custom_id")
  customId?: string;

  /** The http response */
  response?: {
    /** The HTTP status code of the response */
    @encodedName("application/json", "status_code")
    statusCode?: int32;

    /** An unique identifier for the OpenAI API request. Please include this request ID when contacting support. */
    @encodedName("application/json", "request_id")
    requestId?: string;

    /** The JSON body of the response */
    body?: Record<string>;
  };

  /** For requests that failed with a non-HTTP error, this will contain more information on the cause of the failure. */
  error?: {
    /** A machine-readable error code. */
    code?: string;

    /** A human-readable error message. */
    message?: string;
  };
}
