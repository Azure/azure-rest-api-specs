import "@typespec/http";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;

namespace Azure.AI.Projects;

@doc("Defines the request parameters for the createOrUpdateVersion operations.")
model InputParameters<
  TEntityType extends Reflection.Model,
  TBodyName extends valueof string = "body"
> {
  @doc("The {name} to create or update.", TEntityType)
  @bodyRoot
  @clientName(TBodyName)
  body: TEntityType;

  @doc("Content type for patch")
  @header("Content-Type")
  contentType: "application/merge-patch+json";

  @doc(
    "The specific version id of the {name} to create or update.",
    TEntityType
  )
  @Rest.segment("versions")
  @path
  version: string;
}

@Rest.autoRoute
interface VersionedOperations<
  TEntityType extends Reflection.Model,
  TInputParameters extends Reflection.Model,
  TListLatestParameters extends Reflection.Model = {},
  TListVersionsParameters extends Reflection.Model = {}
> {
  #suppress "@azure-tools/typespec-azure-core/verb-conflict" "We are using the resource action as a building block."
  @doc("List all versions of the given {name}", TEntityType)
  @Rest.action("versions")
  @Rest.actionSeparator("/")
  @get
  @list
  listVersions is Azure.Core.StandardResourceOperations.ResourceAction<
    TEntityType,
    TListVersionsParameters,
    Azure.Core.Page<TEntityType>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Suppress `Operation should be defined using a signature from the Azure.Core namespace.`"
  @doc("List the latest version of each {name}", TEntityType)
  @Rest.listsResource(TEntityType)
  listLatest is Azure.Core.Foundations.ResourceList<
    TEntityType,
    TListLatestParameters,
    Azure.Core.Page<TEntityType>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Suppress `Operation should be defined using a signature from the Azure.Core namespace.`"
  @doc(
    "Get the specific version of the {name}. The service returns 404 Not Found error if the {name} does not exist.",
    TEntityType
  )
  getVersion is Azure.Core.Foundations.ResourceOperation<
    TEntityType,
    {
      @doc("The specific version id of the {name} to retrieve.", TEntityType)
      @Rest.segment("versions")
      @path
      version: string;
    },
    Azure.Core.Foundations.ResourceOkResponse<TEntityType>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Suppress `Operation should be defined using a signature from the Azure.Core namespace.`"
  @doc(
    "Delete the specific version of the {name}. The service returns 204 No Content if the {name} was deleted successfully or if the {name} does not exist.",
    TEntityType
  )
  @delete
  deleteVersion is Azure.Core.Foundations.ResourceOperation<
    TEntityType,
    {
      @doc("The version of the {name} to delete.", TEntityType)
      @Rest.segment("versions")
      @path
      version: string;
    },
    NoContentResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Suppress `Operation should be defined using a signature from the Azure.Core namespace.`"
  @doc(
    "Create a new or update an existing {name} with the given version id",
    TEntityType
  )
  @patch
  createOrUpdateVersion is Azure.Core.Foundations.ResourceOperation<
    TEntityType,
    TInputParameters,
    Azure.Core.Foundations.ResourceCreatedOrOkResponse<TEntityType>
  >;
}

// ============================================================================
// Long-Running Job Infrastructure
// ============================================================================

/** Extensible status values shared by Foundry jobs. */
union JobStatus {
  string,

  /** Job is waiting to start. */
  queued: "queued",

  /** Job is actively processing. */
  in_progress: "in_progress",

  /** Job completed successfully. */
  succeeded: "succeeded",

  /** Job failed. */
  failed: "failed",

  /** Job was canceled by the caller. */
  canceled: "canceled",
}

/**
 * Base shape for every Foundry async job.
 *
 * @template TResult  Data produced on success (use `never` if none).
 * @template TInputs  Caller-supplied configuration (use `never` if none).
 * @template TStatus  Status union (defaults to `JobStatus`).
 */
model JobLike<TResult = never, TInputs = never, TStatus extends string = JobStatus> {
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
  status: TStatus;

  /** Error details — populated only on failure. */
  @visibility(Lifecycle.Read)
  error?: ApiError;
}

/** Response envelope for job creation: 201 + Operation-Location + Location headers. */
alias JobCreatedResponse<TJob extends TypeSpec.Reflection.Model> = Response<201> &
  TJob & {
    /** URL to poll for the job status. */
    @header("Operation-Location")
    operationLocation: string;

    /** URL of the created job resource. */
    @header("Location")
    location: string;
  };

/** Response envelope for job status polling: body + optional Retry-After header. */
alias JobStatusResponse<TJob extends TypeSpec.Reflection.Model> = TJob & {
  /** Recommended number of seconds to wait before polling again. */
  @header("Retry-After")
  retryAfter?: int32;
};

// ---- Operation templates ----

/** Create a new job. Returns 201 + Operation-Location + Location headers. */
#suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "LRO polling is handled by the client via Operation-Location"
@post op postJob<TJob extends TypeSpec.Reflection.Model> is FoundryDataPlaneOperation<
  {
    /** The job to create. */
    @body body: TJob;
  },
  JobCreatedResponse<TJob>
>;

/** Get a job by ID with an optional Retry-After header for polling guidance. */
@get op queryJobStatus<TJob extends TypeSpec.Reflection.Model> is FoundryDataPlaneOperation<
  {
    /** The ID of the job. */
    @path jobId: string;
  },
  JobStatusResponse<TJob>
>;

/** List jobs with cursor-based pagination and optional filters. */
@get @list op listJobs<
  TJob extends TypeSpec.Reflection.Model,
  TFilterParams extends TypeSpec.Reflection.Model = {},
> is FoundryDataPlaneOperation<
  {
    ...CommonPageQueryParameters;
    ...TFilterParams;
  },
  AgentsPagedResult<TJob>
>;

/** Cancel a running job. Returns the updated job. */
@post op cancelJob<TJob extends TypeSpec.Reflection.Model> is FoundryDataPlaneOperation<
  {
    /** The ID of the job to cancel. */
    @path jobId: string;
  },
  TJob
>;

/** Delete a job. Returns 204 No Content. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Job templates are project-standard operations"
@delete op deleteJob is FoundryDataPlaneOperation<
  {
    /** The ID of the job to delete. */
    @path jobId: string;
  },
  NoContentResponse
>;

// ---- Preview operation templates ----

/** Create a new job (preview). Includes optional Foundry-Features header. */
#suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "LRO polling is handled by the client via Operation-Location"
@post op postJobPreview<
  AreaPreviewLabel extends FoundryFeaturesOptInKeys | AgentDefinitionOptInKeys,
  TJob extends TypeSpec.Reflection.Model,
> is FoundryDataPlanePreviewOperation<
  AreaPreviewLabel,
  {
    /** The job to create. */
    @body body: TJob;
  },
  JobCreatedResponse<TJob>
>;

/** Get a job by ID (preview). Includes optional Foundry-Features header. */
@get op queryJobStatusPreview<
  AreaPreviewLabel extends FoundryFeaturesOptInKeys | AgentDefinitionOptInKeys,
  TJob extends TypeSpec.Reflection.Model,
> is FoundryDataPlanePreviewOperation<
  AreaPreviewLabel,
  {
    /** The ID of the job. */
    @path jobId: string;
  },
  JobStatusResponse<TJob>
>;

/** List jobs with cursor-based pagination (preview). Includes optional Foundry-Features header. */
@get @list op listJobsPreview<
  AreaPreviewLabel extends FoundryFeaturesOptInKeys | AgentDefinitionOptInKeys,
  TJob extends TypeSpec.Reflection.Model,
  TFilterParams extends TypeSpec.Reflection.Model = {},
> is FoundryDataPlanePreviewOperation<
  AreaPreviewLabel,
  {
    ...CommonPageQueryParameters;
    ...TFilterParams;
  },
  AgentsPagedResult<TJob>
>;

/** Cancel a running job (preview). Includes optional Foundry-Features header. */
@post op cancelJobPreview<
  AreaPreviewLabel extends FoundryFeaturesOptInKeys | AgentDefinitionOptInKeys,
  TJob extends TypeSpec.Reflection.Model,
> is FoundryDataPlanePreviewOperation<
  AreaPreviewLabel,
  {
    /** The ID of the job to cancel. */
    @path jobId: string;
  },
  TJob
>;

/** Delete a job (preview). Includes optional Foundry-Features header. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Job templates are project-standard operations"
@delete op deleteJobPreview<
  AreaPreviewLabel extends FoundryFeaturesOptInKeys | AgentDefinitionOptInKeys,
> is FoundryDataPlanePreviewOperation<
  AreaPreviewLabel,
  {
    /** The ID of the job to delete. */
    @path jobId: string;
  },
  NoContentResponse
>;
