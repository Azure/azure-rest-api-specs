import "@typespec/http";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

// ============================================================================
// Foundry Data Plane Operation Infrastructure
// ============================================================================

alias FoundryDataPlaneApiVersionParameter = {
  @doc("The API version to use for this operation.")
  @query("api-version")
  apiVersion: string;
};

alias FoundryDataPlaneAzureTraits = Azure.Core.Traits.SupportsClientRequestId &
  Azure.Core.Traits.NoRepeatableRequests &
  Azure.Core.Traits.NoConditionalRequests &
  FoundryDataPlaneApiVersionParameter;

alias FoundryAzureOperations<ExtraTraits> = Azure.Core.ResourceOperations<ExtraTraits &
  FoundryDataPlaneAzureTraits>;

#suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" ""
#suppress "@azure-tools/typespec-azure-core/no-response-body" ""
op FoundryDataPlaneOperation<
  Params extends Reflection.Model,
  Response,
  ErrorResponse = ApiErrorResponse
>(...Params, ...FoundryDataPlaneApiVersionParameter): Response | ErrorResponse;

// ---- Feature opt-in keys & preview headers ----

/** Feature opt-in keys for agent definition operations supporting hosted or workflow agents. */
union AgentDefinitionOptInKeys {
  hosted_agents_v1_preview: "HostedAgents=V1Preview",
  workflow_agents_v1_preview: "WorkflowAgents=V1Preview",
  container_agents_v1_preview: "ContainerAgents=V1Preview",
  agent_endpoint_v1_preview: "AgentEndpoints=V1Preview",

  @removed(Versions.v1)
  code_agents_v1_preview: "CodeAgents=V1Preview",
}

union FoundryFeaturesOptInKeys {
  skills_v1_preview: "Skills=V1Preview",
  evaluations_v1_preview: "Evaluations=V1Preview",
  schedules_v1_preview: "Schedules=V1Preview",
  red_teams_v1_preview: "RedTeams=V1Preview",
  insights_v1_preview: "Insights=V1Preview",
  memory_stores_v1_preview: "MemoryStores=V1Preview",
  toolboxes_v1_preview: "Toolboxes=V1Preview",
}

alias WithRequiredFoundryPreviewHeader<RequiredPreviewOptInHeader extends FoundryFeaturesOptInKeys | AgentDefinitionOptInKeys> = {
  /**
   * A feature flag opt-in required when using preview operations or modifying persisted preview resources.
   */
  @header("Foundry-Features")
  foundry_features: RequiredPreviewOptInHeader;
};

alias WithConditionalFoundryPreviewHeader<OptionalPreviewOptInHeader extends FoundryFeaturesOptInKeys | AgentDefinitionOptInKeys> = {
  /**
   * A feature flag opt-in required when using preview operations or modifying persisted preview resources.
   */
  @header("Foundry-Features")
  foundry_features?: OptionalPreviewOptInHeader;
};

#suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" ""
#suppress "@azure-tools/typespec-azure-core/no-response-body" ""
op FoundryDataPlanePreviewOperation<
  AreaPreviewLabel extends FoundryFeaturesOptInKeys | AgentDefinitionOptInKeys,
  Params extends Reflection.Model,
  Response,
  ErrorResponse = ApiErrorResponse
> is FoundryDataPlaneOperation<
  {
    ...WithConditionalFoundryPreviewHeader<AreaPreviewLabel>;
    ...Params;
  },
  Response,
  ErrorResponse
>;

#suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" ""
#suppress "@azure-tools/typespec-azure-core/no-response-body" ""
op FoundryDataPlaneRequiredPreviewOperation<
  AreaPreviewLabel extends FoundryFeaturesOptInKeys | AgentDefinitionOptInKeys,
  Params extends Reflection.Model,
  Response,
  ErrorResponse = ApiErrorResponse
> is FoundryDataPlaneOperation<
  {
    ...WithRequiredFoundryPreviewHeader<AreaPreviewLabel>;
    ...Params;
  },
  Response,
  ErrorResponse
>;

// ============================================================================
// Pagination
// ============================================================================

@doc("The response data for a requested list of items.")
model AgentsPagedResult<T> {
  /** The requested list of items. */
  @pageItems
  data: T[];

  /** The first ID represented in this list. */
  first_id?: string;

  /** The last ID represented in this list. */
  @continuationToken
  last_id?: string;

  /** A value indicating whether there are additional values available not captured in this list. */
  has_more: boolean;
}

alias PageLimitQueryParameter = {
  /**
   * A limit on the number of objects to be returned. Limit can range between 1 and 100, and the
   * default is 20.
   */
  @query limit?: int32 = 20;
};

union PageOrder {
  "asc",
  "desc",
}

alias PageOrderQueryParameter = {
  /**
   * Sort order by the `created_at` timestamp of the objects. `asc` for ascending order and`desc`
   * for descending order.
   */
  @query order?: PageOrder;
};

alias PageAfterQueryParameter = {
  /**
   * A cursor for use in pagination. `after` is an object ID that defines your place in the list.
   * For instance, if you make a list request and receive 100 objects, ending with obj_foo, your
   * subsequent call can include after=obj_foo in order to fetch the next page of the list.
   */
  @query @continuationToken after?: string;
};

alias PageBeforeQueryParameter = {
  /**
   * A cursor for use in pagination. `before` is an object ID that defines your place in the list.
   * For instance, if you make a list request and receive 100 objects, ending with obj_foo, your
   * subsequent call can include before=obj_foo in order to fetch the previous page of the list.
   */
  @query before?: string;
};

alias CommonPageQueryParameters = {
  ...PageLimitQueryParameter;
  ...PageOrderQueryParameter;
  ...PageAfterQueryParameter;
  ...PageBeforeQueryParameter;
};

// ============================================================================
// Versioned Resource Operations
// ============================================================================

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
model JobLike<
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
@post
op postJob<TJob extends TypeSpec.Reflection.Model> is FoundryDataPlaneOperation<
  {
    /** The job to create. */
    @body body: TJob;
  },
  JobCreatedResponse<TJob>
>;

/** Get a job by ID with an optional Retry-After header for polling guidance. */
@get
op queryJobStatus<TJob extends TypeSpec.Reflection.Model> is FoundryDataPlaneOperation<
  {
    /** The ID of the job. */
    @path jobId: string;
  },
  JobStatusResponse<TJob>
>;

/** List jobs with cursor-based pagination and optional filters. */
@get @list op listJobs<
  TJob extends TypeSpec.Reflection.Model,
  TFilterParams extends TypeSpec.Reflection.Model = {}
> is FoundryDataPlaneOperation<
  {
    ...CommonPageQueryParameters;
    ...TFilterParams;
  },
  AgentsPagedResult<TJob>
>;

/** Cancel a running job. Returns 200 with the updated job. */
@post
op cancelJob<TJob extends TypeSpec.Reflection.Model> is FoundryDataPlaneOperation<
  {
    /** The ID of the job to cancel. */
    @path jobId: string;
  },
  OkResponse & TJob
>;

/** Delete a job. Returns 204 No Content. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Job templates are project-standard operations"
@delete
op deleteJob<TJob extends TypeSpec.Reflection.Model> is FoundryDataPlaneOperation<
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
  TJob extends TypeSpec.Reflection.Model
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
  TJob extends TypeSpec.Reflection.Model
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
  TFilterParams extends TypeSpec.Reflection.Model = {}
> is FoundryDataPlanePreviewOperation<
  AreaPreviewLabel,
  {
    ...CommonPageQueryParameters;
    ...TFilterParams;
  },
  AgentsPagedResult<TJob>
>;

/** Cancel a running job (preview). Returns 200 with the updated job. */
@post op cancelJobPreview<
  AreaPreviewLabel extends FoundryFeaturesOptInKeys | AgentDefinitionOptInKeys,
  TJob extends TypeSpec.Reflection.Model
> is FoundryDataPlanePreviewOperation<
  AreaPreviewLabel,
  {
    /** The ID of the job to cancel. */
    @path jobId: string;
  },
  OkResponse & TJob
>;

/** Delete a job (preview). Returns 204 No Content. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Job templates are project-standard operations"
@delete
op deleteJobPreview<AreaPreviewLabel extends FoundryFeaturesOptInKeys | AgentDefinitionOptInKeys> is FoundryDataPlanePreviewOperation<
  AreaPreviewLabel,
  {
    /** The ID of the job to delete. */
    @path jobId: string;
  },
  NoContentResponse
>;

// ============================================================================
// Types and traits shared by multiple service patterns
// ============================================================================

@encode(DateTimeKnownEncoding.unixTimestamp, int32)
scalar FoundryTimestamp extends utcDateTime;
