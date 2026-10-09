using TypeSpec.Http;
using Azure.Core;

namespace Microsoft.Foundry.Core;

/** Extensible status values shared by Foundry jobs. */
union JobStatus {
  string,

  /** Job is waiting to start. */
  queued: "queued",

  /** Job is actively processing. */
  in_progress: "in_progress",

  /** Job completed successfully. */
  @lroSucceeded
  succeeded: "succeeded",

  /** Job failed. */
  @lroFailed
  failed: "failed",

  /** Job was cancelled by the caller. */
  @lroCanceled
  cancelled: "cancelled",
}

/**
 * Base shape for every Foundry async job.
 *
 * @template TError Service-owned error details.
 * @template TResult Data produced on success (use `never` if none).
 * @template TInputs Caller-supplied configuration (use `never` if none).
 * @template TStatus Status union (defaults to `JobStatus`).
 */
model JobLike<
  TError,
  TResult = never,
  TInputs = never,
  TStatus extends string = JobStatus
> {
  /** Server-assigned unique identifier. */
  @visibility(Lifecycle.Read)
  id: string;

  /** Caller-supplied inputs. */
  inputs?: TInputs;

  /** Result produced on success. */
  @visibility(Lifecycle.Read)
  result?: TResult;

  /** Current lifecycle status. */
  @visibility(Lifecycle.Read)
  @lroStatus
  status: TStatus;

  /** Error details — populated only on failure. */
  @visibility(Lifecycle.Read)
  error?: TError;
}

/** Response envelope for job creation: 201 + Operation-Location + Location headers. */
alias JobCreatedResponse<TJob extends Reflection.Model> = Response<201> &
  TJob & {
    /** URL to poll for the job status. */
    @header("Operation-Location")
    operationLocation: string;

    /** URL of the created job resource. */
    @header("Location")
    location: string;
  };

/** Response envelope for job status polling: body + optional Retry-After header. */
alias JobStatusResponse<TJob extends Reflection.Model> = TJob & {
  /** Recommended number of seconds to wait before polling again. */
  @header("Retry-After")
  retryAfter?: int32;
};

/** Optional Operation-Id header for idempotent job creation retries. */
alias WithOperationId = {
  /** Client-generated unique ID for idempotent retries. When absent, the server creates the job unconditionally. */
  @header("Operation-Id")
  operationId?: string;
};

/** Approved Foundry job lifecycle signatures. */
namespace StandardOperations {
  /**
   * Create a new job. Returns 201 Created. Accepts an optional Operation-Id header for idempotent retries.
   * @template TJob The job resource shape.
   * @template TErrorResponse The error response shape.
   */
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "LRO polling is handled by the client via Operation-Location"
  @post
  op PostJob<
    TJob extends Reflection.Model,
    TErrorResponse
  > is Foundations.Operation<
    {
      ...WithOperationId;

      /** The job to create. */
      @body body: TJob;
    },
    JobCreatedResponse<TJob>,
    TErrorResponse
  >;

  /**
   * Get a job by ID with an optional Retry-After header for polling guidance.
   * @template TJob The job resource shape.
   * @template TErrorResponse The error response shape.
   */
  @get
  op QueryJobStatus<
    TJob extends Reflection.Model,
    TErrorResponse
  > is Foundations.Operation<
    {
      /** The ID of the job. */
      @path jobId: string;
    },
    JobStatusResponse<TJob>,
    TErrorResponse
  >;

  /**
   * List jobs with cursor-based pagination and optional filters.
   * @template TJob The job resource shape.
   * @template TErrorResponse The error response shape.
   * @template TFilterParams Additional list filter query parameters.
   * @template TPage The paged result shape.
   */
  @get
  @list
  op ListJobs<
    TJob extends Reflection.Model,
    TErrorResponse,
    TFilterParams extends Reflection.Model = {},
    TPage extends Reflection.Model = AgentsPagedResult<TJob>
  > is Foundations.Operation<
    {
      ...CommonPageQueryParameters;
      ...TFilterParams;
    },
    TPage,
    TErrorResponse
  >;

  /**
   * Cancel a running job. Returns 200 with the updated job.
   * @template TJob The job resource shape.
   * @template TErrorResponse The error response shape.
   */
  @post
  op CancelJob<
    TJob extends Reflection.Model,
    TErrorResponse
  > is Foundations.Operation<
    {
      /** The ID of the job to cancel. */
      @path jobId: string;
    },
    OkResponse & TJob,
    TErrorResponse
  >;

  /**
   * Delete a job. Returns 204 No Content.
   * @template TErrorResponse The error response shape.
   */
  @delete
  op DeleteJob<TErrorResponse> is Foundations.Operation<
    {
      /** The ID of the job to delete. */
      @path jobId: string;
    },
    NoContentResponse,
    TErrorResponse
  >;

  /**
   * Create a new job (preview). Includes optional Foundry-Features header and Operation-Id for idempotent retries.
   * @template TPreviewParameters The preview feature opt-in parameters.
   * @template TJob The job resource shape.
   * @template TErrorResponse The error response shape.
   */
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "LRO polling is handled by the client via Operation-Location"
  @post
  op PostJobPreview<
    TPreviewParameters extends Reflection.Model,
    TJob extends Reflection.Model,
    TErrorResponse
  > is Foundations.PreviewOperation<
    TPreviewParameters,
    {
      ...WithOperationId;

      /** The job to create. */
      @body job: TJob;
    },
    JobCreatedResponse<TJob>,
    TErrorResponse
  >;

  /**
   * Get a job by ID (preview). Includes optional Foundry-Features header.
   * @template TPreviewParameters The preview feature opt-in parameters.
   * @template TJob The job resource shape.
   * @template TErrorResponse The error response shape.
   */
  @get
  op QueryJobStatusPreview<
    TPreviewParameters extends Reflection.Model,
    TJob extends Reflection.Model,
    TErrorResponse
  > is Foundations.PreviewOperation<
    TPreviewParameters,
    {
      /** The ID of the job. */
      @path jobId: string;
    },
    JobStatusResponse<TJob>,
    TErrorResponse
  >;

  /**
   * List jobs with cursor-based pagination (preview). Includes optional Foundry-Features header.
   * @template TPreviewParameters The preview feature opt-in parameters.
   * @template TJob The job resource shape.
   * @template TErrorResponse The error response shape.
   * @template TFilterParams Additional list filter query parameters.
   * @template TPage The paged result shape.
   */
  @get
  @list
  op ListJobsPreview<
    TPreviewParameters extends Reflection.Model,
    TJob extends Reflection.Model,
    TErrorResponse,
    TFilterParams extends Reflection.Model = {},
    TPage extends Reflection.Model = AgentsPagedResult<TJob>
  > is Foundations.PreviewOperation<
    TPreviewParameters,
    {
      ...CommonPageQueryParameters;
      ...TFilterParams;
    },
    TPage,
    TErrorResponse
  >;

  /**
   * Cancel a running job (preview). Returns 200 with the updated job.
   * @template TPreviewParameters The preview feature opt-in parameters.
   * @template TJob The job resource shape.
   * @template TErrorResponse The error response shape.
   */
  @post
  op CancelJobPreview<
    TPreviewParameters extends Reflection.Model,
    TJob extends Reflection.Model,
    TErrorResponse
  > is Foundations.PreviewOperation<
    TPreviewParameters,
    {
      /** The ID of the job to cancel. */
      @path jobId: string;
    },
    OkResponse & TJob,
    TErrorResponse
  >;

  /**
   * Delete a job (preview). Returns 204 No Content.
   * @template TPreviewParameters The preview feature opt-in parameters.
   * @template TErrorResponse The error response shape.
   */
  @delete
  op DeleteJobPreview<
    TPreviewParameters extends Reflection.Model,
    TErrorResponse
  > is Foundations.PreviewOperation<
    TPreviewParameters,
    {
      /** The ID of the job to delete. */
      @path jobId: string;
    },
    NoContentResponse,
    TErrorResponse
  >;
}
