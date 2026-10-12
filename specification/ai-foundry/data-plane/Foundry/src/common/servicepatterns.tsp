import "@typespec/http";

import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-foundry-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Microsoft.Foundry.Core;

namespace Azure.AI.Projects;

// ============================================================================
// Foundry Data Plane Operation Infrastructure
// ============================================================================

alias FoundryDataPlaneAzureTraits = Azure.Core.Traits.SupportsClientRequestId &
  Azure.Core.Traits.NoRepeatableRequests &
  Azure.Core.Traits.NoConditionalRequests &
  FoundryDataPlaneApiVersionParameter;

alias FoundryAzureOperations<ExtraTraits> = Azure.Core.ResourceOperations<
  ExtraTraits & FoundryDataPlaneAzureTraits,
  global.AzureRangeErrorResponse
>;

alias FoundryStandardResourceOperations = Azure.Core.ResourceOperations<
  Azure.Core.Traits.NoConditionalRequests &
    Azure.Core.Traits.NoRepeatableRequests &
    Azure.Core.Traits.NoClientRequestId,
  global.AzureRangeErrorResponse
>;

op FoundryOperation<
  Params extends Reflection.Model,
  Response,
  Traits extends Reflection.Model = {}
> is Azure.Core.Foundations.Operation<
  Params,
  Response,
  Traits,
  global.AzureRangeErrorResponse
>;

#suppress "@azure-tools/typespec-azure-core/no-response-body" ""
op FoundryResourceOperation<
  Resource extends Reflection.Model,
  Params extends Reflection.Model,
  Response,
  Traits extends Reflection.Model = {}
> is Azure.Core.Foundations.ResourceOperation<
  Resource,
  Params,
  Response,
  Traits,
  global.AzureRangeErrorResponse
>;

op FoundryResourceList<
  Resource extends Reflection.Model,
  Params extends Reflection.Model,
  Response extends Reflection.Model,
  Traits extends Reflection.Model = {}
> is Azure.Core.Foundations.ResourceList<
  Resource,
  Params,
  Response,
  Traits,
  global.AzureRangeErrorResponse
>;

#suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" ""
#suppress "@azure-tools/typespec-azure-core/no-response-body" ""
op FoundryDataPlaneOperation<
  Params extends Reflection.Model,
  Response,
  ErrorResponse = ApiErrorResponse
>(...Params, ...FoundryDataPlaneApiVersionParameter):
  | Response
  | global.AzureRangeErrorResponse<ErrorResponse>;

// ---- Feature opt-in keys & preview headers ----

/** Feature opt-in keys for agent definition operations supporting conditional preview features. */
#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "API review requires this input-only opt-in contract to accept only the declared feature keys; arbitrary string opt-ins are not supported."
union AgentDefinitionOptInKeys {
  workflow_agents_v1_preview: "WorkflowAgents=V1Preview",
  external_agents_v1_preview: "ExternalAgents=V1Preview",
  draft_agents_v1_preview: "DraftAgents=V1Preview",
  voice_agents_v1_preview: "VoiceAgents=V1Preview",
  digital_worker_v1_preview: "DigitalWorker=V1Preview",
  github_copilot_v1_preview: "GitHubCopilot=V1Preview",
  skills_v1_preview: "Skills=V1Preview",

  @removed(Versions.v1)
  hosted_agents_v1_preview: "HostedAgents=V1Preview",

  @removed(Versions.v1)
  container_agents_v1_preview: "ContainerAgents=V1Preview",
}

#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "API review requires this input-only opt-in contract to accept only the declared feature keys; arbitrary string opt-ins are not supported."
union FoundryFeaturesOptInKeys {
  evaluations_v1_preview: "Evaluations=V1Preview",
  schedules_v1_preview: "Schedules=V1Preview",
  red_teams_v1_preview: "RedTeams=V1Preview",
  insights_v1_preview: "Insights=V1Preview",
  agent_insights_v1_preview: "AgentInsights=V1Preview",
  memory_stores_v1_preview: "MemoryStores=V1Preview",
  routines_v2_preview: "Routines=V2Preview",
  skills_v1_preview: "Skills=V1Preview",
  data_generation_jobs_v1_preview: "DataGenerationJobs=V1Preview",
  models_v1_preview: "Models=V1Preview",
  model_router_controls_v1_preview: "ModelRouterControls=V1Preview",
  finetuning_sessions_v1_preview: "FineTuningSessions=V1Preview",
}

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

// AgentsPagedResult, PagedResultWithNextLink, PageLimitQueryParameter, PageOrder,
// PageOrderQueryParameter, PageAfterQueryParameter, PageBeforeQueryParameter, and
// CommonPageQueryParameters are now referenced directly from Microsoft.Foundry.Core
// via the `using` directive above.

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
  @summary("List versions")
  @doc("List all versions of the given {name}", TEntityType)
  @Rest.action("versions")
  @Rest.actionSeparator("/")
  @get
  @list
  listVersions is FoundryStandardResourceOperations.ResourceAction<
    TEntityType,
    TListVersionsParameters,
    Azure.Core.Page<TEntityType>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Suppress `Operation should be defined using a signature from the Azure.Core namespace.`"
  @summary("List latest versions")
  @doc("List the latest version of each {name}", TEntityType)
  @Rest.listsResource(TEntityType)
  listLatest is FoundryResourceList<
    TEntityType,
    TListLatestParameters,
    Azure.Core.Page<TEntityType>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Suppress `Operation should be defined using a signature from the Azure.Core namespace.`"
  @summary("Get a version")
  @doc(
    "Get the specific version of the {name}. The service returns 404 Not Found error if the {name} does not exist.",
    TEntityType
  )
  getVersion is FoundryResourceOperation<
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
  @summary("Delete a version")
  @doc(
    "Delete the specific version of the {name}. The service returns 204 No Content if the {name} was deleted successfully or if the {name} does not exist.",
    TEntityType
  )
  @delete
  deleteVersion is FoundryResourceOperation<
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
  @summary("Create or update a version")
  @doc(
    "Create a new or update an existing {name} with the given version id",
    TEntityType
  )
  @patch
  createOrUpdateVersion is FoundryResourceOperation<
    TEntityType,
    TInputParameters,
    Azure.Core.Foundations.ResourceCreatedOrOkResponse<TEntityType>
  >;
}

// ============================================================================
// Long-Running Job Infrastructure
// ============================================================================

// JobStatus, JobCreatedResponse, JobStatusResponse, and WithOperationId are now
// referenced directly from Microsoft.Foundry.Core via the `using` directive above.

// ---- Operation templates ----

/** Create a new job. Returns 201 Created. Accepts an optional Operation-Id header for idempotent retries. */
#suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "LRO polling is handled by the client via Operation-Location"
@post
op postJob<TJob extends TypeSpec.Reflection.Model> is FoundryDataPlaneOperation<
  {
    ...WithOperationId;

    /** The job to create. */
    @body job: TJob;
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

/** Create a new job (preview). Includes optional Foundry-Features header and Operation-Id for idempotent retries. */
#suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "LRO polling is handled by the client via Operation-Location"
@post op postJobPreview<
  AreaPreviewLabel extends FoundryFeaturesOptInKeys | AgentDefinitionOptInKeys,
  TJob extends TypeSpec.Reflection.Model
> is FoundryDataPlanePreviewOperation<
  AreaPreviewLabel,
  {
    ...WithOperationId;

    /** The job to create. */
    @body job: TJob;
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
op deleteJobPreview<
  AreaPreviewLabel extends FoundryFeaturesOptInKeys | AgentDefinitionOptInKeys
> is FoundryDataPlanePreviewOperation<
  AreaPreviewLabel,
  {
    /** The ID of the job to delete. */
    @path jobId: string;
  },
  NoContentResponse
>;

// FoundryTimestamp, FoundryDurationSeconds, and FoundryDurationMilliseconds are
// now referenced directly from Microsoft.Foundry.Core via the `using` directive above.
