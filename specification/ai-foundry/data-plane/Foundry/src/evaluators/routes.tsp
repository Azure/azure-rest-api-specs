import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "./models.tsp";

namespace Azure.AI.Projects;
using Http;
using OpenAPI;
using Azure.Core;

alias ListEvaluatorsParameters = {
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-types" "Auto-suppressed warnings non-applicable rules during import."
  @doc("Filter evaluators by type. Possible values: 'all', 'custom', 'builtin'.")
  @Http.query
  type?: EvaluatorType | "all";

  @doc("A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 20.")
  @Http.query
  limit?: int32 = 20;
};

alias EvaluatorOkResponse = Azure.Core.Foundations.ResourceOkResponse<Evaluator> &
  EtagResponseEnvelope;

alias EvaluatorCreatedOrOkResponse =
  | (Azure.Core.Foundations.ResourceCreatedResponse<Evaluator> &
      EtagResponseEnvelope)
  | EvaluatorOkResponse;

alias ListEvaluatorDiagnosticsParameters = {
  ...OmitProperties<CommonPageQueryParameters, "order" | "limit">;

  @doc("The maximum number of lineage entries to return, between 1 and 100. The default is 20.")
  @minValue(1)
  @maxValue(100)
  @query
  limit?: int32 = 20;

  @doc("Sort completed diagnostics by `occurred_at`, then diagnostic identifier. The default is `desc`.")
  @query
  order?: PageOrder = "desc";

  @doc("Inclusive lower bound for the diagnostic occurrence time, expressed as Unix seconds.")
  @query
  start_time?: FoundryTimestamp;

  @doc("Inclusive upper bound for the diagnostic occurrence time, expressed as Unix seconds. Includes all entries occurring within that second.")
  @query
  end_time?: FoundryTimestamp;

  @doc("Filter lineage diagnostics by the exact published evaluator version.")
  @query
  evaluator_version?: EvaluatorVersionNumber;

  @doc("Filter completed diagnostics for one public rubric dimension identifier.")
  @minLength(1)
  @maxLength(128)
  @query
  dimension_id?: string;

  @doc("Filter by one or more completed diagnostic types by repeating the query parameter.")
  @minItems(1)
  @query(#{ explode: true })
  type?: EvaluatorDiagnosticType[];
};

@tag("Evaluators")
interface Evaluators {
  /** Creates the unnumbered current evaluator, or replaces it when the name already exists. Existing current state requires a matching `If-Match` ETag. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "The mutable current evaluator uses an explicit route and scoped conditional headers while published versions remain immutable."
  @summary("Create or update the current evaluator")
  @route("/evaluators/{name}")
  @put
  createOrUpdate is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      @doc("The evaluator name.")
      @path
      name: string;

      ...ConditionalRequestHeaders;

      @doc("The complete mutable evaluator state.")
      @bodyRoot
      evaluator: Evaluator;
    },
    EvaluatorCreatedOrOkResponse
  >;

  /** Returns the unnumbered current evaluator and its ETag. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "The mutable current evaluator uses an explicit route and scoped conditional headers while published versions remain immutable."
  @summary("Get the current evaluator")
  @route("/evaluators/{name}")
  @get
  get is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      @doc("The evaluator name.")
      @path
      name: string;

      ...ConditionalRequestHeaders;
    },
    EvaluatorOkResponse
  >;

  /** Removes the current evaluator and all of its published versions. A matching ETag is required when current state exists. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "The mutable current evaluator uses an explicit route and scoped conditional headers while published versions remain immutable."
  @summary("Delete an evaluator")
  @route("/evaluators/{name}")
  @delete
  delete is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      @doc("The evaluator name.")
      @path
      name: string;

      ...ConditionalRequestHeaders;
    },
    Http.NoContentResponse
  >;

  /** Lists unnumbered current evaluator resources. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "The mutable current evaluator collection is distinct from published versions."
  @summary("List current evaluators")
  @route("/evaluators")
  @get
  @list
  list is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    ListEvaluatorsParameters,
    Azure.Core.Page<Evaluator>
  >;

  /** Publishes the ETag-matched current evaluator as the next immutable numbered version. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Publishing is a service-specific resource action."
  @summary("Publish the current evaluator")
  @route("/evaluators/{name}:publish_version")
  @post
  publishVersion is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      @doc("The evaluator name.")
      @path
      name: string;

      ...ConditionalRequestHeaders;
      ...WithOperationId;
    },
    Azure.Core.Foundations.ResourceCreatedResponse<EvaluatorVersion>
  >;

  /** Returns immutable published versions for the specified evaluator. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Published evaluator versions use an evaluator-scoped explicit route."
  @summary("List published evaluator versions")
  @route("/evaluators/{name}/versions")
  @get
  @list
  listVersions is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      @doc("The evaluator name.")
      @path
      name: string;

      ...ListEvaluatorsParameters;
    },
    Azure.Core.Page<EvaluatorVersion>
  >;

  /**
   * Returns immutable publication lineage for the specified evaluator.
   *
   * Time, evaluator-version, dimension, and type filters are intersected.
   * Diagnostics are populated when a numbered evaluator version is published.
   * Editing mutable current state does not publish lineage.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Evaluator diagnostics are immutable completed resources with custom evaluator-scoped filtering."
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
    CompletedEvaluatorDiagnosticsPage
  >;

  /** Returns one completed evaluator diagnostic by its stable identifier. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Evaluator diagnostics use an evaluator-scoped immutable read route."
  @summary("Get an evaluator diagnostic")
  @route("/evaluators/{name}/diagnostics/{diagnostic_id}")
  @get
  @extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
  getDiagnostic is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      @doc("The evaluator name.")
      @path
      name: string;

      @doc("The stable completed diagnostic identifier.")
      @path
      diagnostic_id: string;
    },
    EvaluatorDiagnostic
  >;

  /** Retrieves the specified immutable published evaluator version. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Published evaluator versions use an evaluator-scoped explicit route."
  @summary("Get a published evaluator version")
  @route("/evaluators/{name}/versions/{version}")
  @get
  getVersion is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      @doc("The evaluator name.")
      @path
      name: string;

      @doc("The immutable published evaluator version.")
      @path
      version: EvaluatorVersionNumber;
    },
    Azure.Core.Foundations.ResourceOkResponse<EvaluatorVersion>
  >;

  /** Removes the specified immutable published version without changing current state. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Published evaluator versions use an evaluator-scoped explicit route."
  @summary("Delete a published evaluator version")
  @route("/evaluators/{name}/versions/{version}")
  @delete
  deleteVersion is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      @doc("The evaluator name.")
      @path
      name: string;

      @doc("The immutable published evaluator version.")
      @path
      version: EvaluatorVersionNumber;
    },
    Http.NoContentResponse
  >;

  /** Atomically replaces current evaluator state and publishes that exact state as the next immutable numbered version. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Direct version creation atomically updates current state and publishes a service-numbered version."
  @summary("Create a published evaluator version")
  @route("/evaluators/{name}/versions")
  @post
  createVersion is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      @doc("The evaluator name.")
      @path
      name: string;

      ...ConditionalRequestHeaders;
      ...WithOperationId;

      @doc("The complete evaluator state to make current and publish.")
      @bodyRoot
      evaluator: Evaluator;
    },
    Azure.Core.Foundations.ResourceCreatedResponse<EvaluatorVersion>
  >;

  /** Initiates or retrieves a pending upload for mutable current evaluator state. Publishing freezes the resulting immutable artifact identity. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Start a current evaluator pending upload")
  @post
  @route("/evaluators/{name}/startPendingUpload")
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

      @doc("The pending upload request parameters")
      @Http.bodyRoot
      pending_upload_request: PendingUploadRequest;
    },
    PendingUploadResponse
  >;

  /** Retrieves SAS credentials for a pending current evaluator upload. Publishing freezes the resulting immutable artifact identity. */
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version"
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Get current evaluator credentials")
  @post
  @route("/evaluators/{name}/credentials")
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
