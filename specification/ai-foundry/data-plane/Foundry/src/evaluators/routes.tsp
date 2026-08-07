import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "./models.tsp";

namespace Azure.AI.Projects;
using Http;
using OpenAPI;
using Azure.Core;

alias EvaluatorsPreviewHeader = WithRequiredFoundryPreviewHeader<FoundryFeaturesOptInKeys.evaluations_v1_preview>;

alias ListEvaluatorVersionsParameters = {
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Auto-suppressed warnings non-applicable rules during import."
  @doc("Filter evaluators by type. Possible values: 'all', 'custom', 'builtin'.")
  @Http.query
  type?: EvaluatorType | "all";

  @doc("A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 20.")
  @Http.query
  limit?: int32 = 20;
};

/** Query parameters for listing evaluator diagnostic events. */
alias ListEvaluatorDiagnosticsParameters = {
  ...PageLimitQueryParameter;

  @doc("Sort order by `occurred_at` and then event ID. The default is `desc` so an unbounded request returns the newest events first.")
  @Http.query
  order?: PageOrder = "desc";

  ...PageAfterQueryParameter;
  ...PageBeforeQueryParameter;

  @doc("Inclusive lower bound for the event occurrence time.")
  @Http.query
  start_time?: utcDateTime;

  @doc("Inclusive upper bound for the event occurrence time.")
  @Http.query
  end_time?: utcDateTime;

  @doc("Inclusive lower evaluator-version bound. Supply an exact version identifier returned by the evaluator APIs; the service applies evaluator-version ordering rather than lexical ordering.")
  @Http.query
  from_version?: string;

  @doc("Inclusive upper evaluator-version bound. Supply an exact version identifier returned by the evaluator APIs; the service applies evaluator-version ordering rather than lexical ordering.")
  @Http.query
  to_version?: string;

  @doc("Filter events for one public rubric dimension identifier. If a caller changes an identifier, query the prior and new identifiers separately because the change is recorded as removal plus addition.")
  @Http.query
  dimension_id?: string;

  @doc("Filter events that apply to one canonical functional evaluator state.")
  @Http.query
  @pattern("^[0-9a-f]{64}$")
  content_hash?: string;

  @doc("Filter by one or more event categories by repeating the query parameter.")
  @Http.query(#{ explode: true })
  event_type?: EvaluatorDiagnosticEventType[];
};

@tag("Evaluators")
interface Evaluators {
  // GET /evaluators/{name}/versions
  /** Returns the available versions for the specified evaluator. */
  #suppress "@azure-tools/typespec-azure-core/verb-conflict" "Resource action used as a building block."
  @summary("List evaluator versions")
  @Rest.action("versions")
  @Rest.actionSeparator("/")
  @Http.get
  @list
  listVersions is FoundryStandardResourceOperations.ResourceAction<
    EvaluatorVersion,
    ListEvaluatorVersionsParameters & EvaluatorsPreviewHeader,
    Azure.Core.Page<EvaluatorVersion>
  >;

  // GET /evaluators
  /** Lists the latest version of each evaluator. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("List latest evaluator versions")
  @Rest.listsResource(EvaluatorVersion)
  listLatestVersions is FoundryResourceList<
    EvaluatorVersion,
    ListEvaluatorVersionsParameters & EvaluatorsPreviewHeader,
    Azure.Core.Page<EvaluatorVersion>
  >;

  /**
   * Returns append-only diagnostic events for the specified evaluator.
   *
   * Time, version, dimension, content-hash, and event-type filters are intersected.
   * Time and version bounds are inclusive. Version bounds use evaluator-version
   * ordering rather than lexical ordering. Repeat `event_type` to select multiple
   * event categories.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Evaluator diagnostics are an append-only event collection rather than a standard resource collection."
  @summary("List evaluator diagnostics")
  @route("/evaluators/{name}/diagnostics")
  @get
  @list
  @extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
  listDiagnostics is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      @doc("The evaluator name.")
      @path
      name: string;

      ...ListEvaluatorDiagnosticsParameters;
    },
    AgentsPagedResult<EvaluatorDiagnosticEvent>
  >;

  // GET /evaluators/{name}/versions/{version}
  /** Retrieves the specified evaluator version, returning 404 if it does not exist. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Get an evaluator version")
  getVersion is FoundryResourceOperation<
    EvaluatorVersion,
    {
      ...EvaluatorsPreviewHeader;

      @doc(
        "The specific version id of the {name} to retrieve.",
        EvaluatorVersion
      )
      @Rest.segment("versions")
      @Http.path
      version: string;
    },
    Azure.Core.Foundations.ResourceOkResponse<EvaluatorVersion>
  >;

  // DELETE /evaluators/{name}/versions/{version}
  /** Removes the specified evaluator version. Returns 204 whether the version existed or not. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Delete an evaluator version")
  @Http.delete
  deleteVersion is FoundryResourceOperation<
    EvaluatorVersion,
    {
      ...EvaluatorsPreviewHeader;

      @doc("The version of the {name} to delete.", EvaluatorVersion)
      @Rest.segment("versions")
      @Http.path
      version: string;
    },
    Http.NoContentResponse
  >;

  // POST /evaluators/{evaluatorName}/versions
  /** Creates a new evaluator version with an auto-incremented version identifier. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Create an evaluator version")
  @Rest.segment("versions")
  @Http.post
  createVersion is FoundryResourceOperation<
    EvaluatorVersion,
    {
      ...EvaluatorsPreviewHeader;

      @Http.bodyRoot
      evaluator_version: EvaluatorVersion;
    },
    Azure.Core.Foundations.ResourceCreatedResponse<EvaluatorVersion>
  >;

  // PATCH /evaluators/{evaluatorName}/versions/{version}
  /** Updates the specified evaluator version in place. */
  #suppress "@azure-tools/typespec-azure-core/no-response-body"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Update an evaluator version")
  @Http.patch(#{ implicitOptionality: true })
  updateVersion is FoundryResourceOperation<
    EvaluatorVersion,
    {
      ...EvaluatorsPreviewHeader;

      @doc("The version of the {name} to update.", EvaluatorVersion)
      @Rest.segment("versions")
      @Http.path
      version: string;

      @doc("Evaluator resource")
      @Http.bodyRoot
      evaluator_version: EvaluatorVersion;
    },
    Azure.Core.Foundations.ResourceOkResponse<EvaluatorVersion>
  >;

  /** Initiates a new pending upload or retrieves an existing one for the specified evaluator version. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Start a pending upload")
  @post
  @route("/evaluators/{name}/versions/{version}/startPendingUpload")
  @extension(
    "x-ms-foundry-meta",
    #{ required_previews: #[FoundryFeaturesOptInKeys.evaluations_v1_preview] }
  )
  startPendingUpload is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** The name path parameter. */
      @path
      name: string;

      @doc("The specific version id of the EvaluatorVersion to operate on.")
      @Rest.segment("versions")
      @Http.path
      version: string;

      @doc("The pending upload request parameters")
      @Http.bodyRoot
      pending_upload_request: PendingUploadRequest;
    },
    PendingUploadResponse
  >;

  /** Retrieves SAS credentials for accessing the storage account associated with the specified evaluator version. */
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Get evaluator credentials")
  @post
  @route("/evaluators/{name}/versions/{version}/credentials")
  @extension(
    "x-ms-foundry-meta",
    #{ required_previews: #[FoundryFeaturesOptInKeys.evaluations_v1_preview] }
  )
  getCredentials is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** The name path parameter. */
      @path
      name: string;

      @doc("The credential request parameters")
      @Http.bodyRoot
      credential_request: EvaluatorCredentialRequest;

      @doc("The specific version id of the EvaluatorVersion to operate on.")
      @Rest.segment("versions")
      @Http.path
      version: string;
    },
    AssetCredentialResponse
  >;
}

// ============================================================================
// Evaluator Generation Jobs (LRO — follows DataGenerationJobs pattern)
// ============================================================================

const EvaluatorGenerationJobsRequiredPreviews = #{
  required_previews: #[FoundryFeaturesOptInKeys.evaluations_v1_preview],
};

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "OpenAI-based operations are not conventionally versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "OpenAI-based operations are definitionally non-standard"
@tag("EvaluatorGenerationJobs")
interface EvaluatorGenerationJobs {
  /**
   * Creates an evaluator generation job. The service generates rubric-based evaluator
   * definitions from the provided source materials asynchronously.
   */
  @summary("Create an evaluator generation job")
  @route("evaluator_generation_jobs")
  @extension("x-ms-foundry-meta", EvaluatorGenerationJobsRequiredPreviews)
  @pollingOperation(EvaluatorGenerationJobs.get)
  create is postJobPreview<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    EvaluatorGenerationJob
  >;

  /**
   * Gets the details of an evaluator generation job by its ID.
   */
  @summary("Get an evaluator generation job")
  @route("evaluator_generation_jobs/{jobId}")
  @extension("x-ms-foundry-meta", EvaluatorGenerationJobsRequiredPreviews)
  get is queryJobStatusPreview<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    EvaluatorGenerationJob
  >;

  /**
   * Returns a list of evaluator generation jobs. The List API has up to a few
   * seconds of propagation delay, so a recently created job may not appear
   * immediately; use the Get evaluator generation job API with the job ID to
   * retrieve a specific job without delay.
   */
  @summary("List evaluator generation jobs")
  @route("evaluator_generation_jobs")
  @extension("x-ms-foundry-meta", EvaluatorGenerationJobsRequiredPreviews)
  list is listJobsPreview<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    EvaluatorGenerationJob
  >;

  /**
   * Cancels an evaluator generation job by its ID.
   */
  @summary("Cancel an evaluator generation job")
  @route("evaluator_generation_jobs/{jobId}:cancel")
  @extension("x-ms-foundry-meta", EvaluatorGenerationJobsRequiredPreviews)
  cancel is cancelJobPreview<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    EvaluatorGenerationJob
  >;

  /**
   * Deletes an evaluator generation job by its ID. Deletes the job record only;
   * the generated evaluator (if any) is preserved.
   */
  @summary("Delete an evaluator generation job")
  @route("evaluator_generation_jobs/{jobId}")
  @extension("x-ms-foundry-meta", EvaluatorGenerationJobsRequiredPreviews)
  delete is deleteJobPreview<FoundryFeaturesOptInKeys.evaluations_v1_preview>;
}
