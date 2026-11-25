import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "./models.tsp";
import "./diagnostics.tsp";

namespace Azure.AI.Projects;
using Http;
using OpenAPI;
using Azure.Core;
using TypeSpec.Versioning;

alias ListEvaluatorVersionsParameters = {
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-types" "Auto-suppressed warnings non-applicable rules during import."
  @doc("Filter evaluators by type. Possible values: 'all', 'custom', 'builtin'.")
  @Http.query
  type?: EvaluatorType | "all";

  @doc("A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 20.")
  @Http.query
  limit?: int32 = 20;
};

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
  /**
   * Returns immutable publication lineage for the specified evaluator.
   *
   * Time, evaluator-version, dimension, and type filters are intersected.
   * Returns recorded changes from completed evaluator version writes.
   * Historical backfill and diagnostic calculation jobs are not included.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Evaluator diagnostics are immutable completed resources with custom evaluator-scoped filtering."
  @summary("List evaluator diagnostics")
  @route("/evaluators/{name}/diagnostics")
  @get
  @list
  @extension("x-ms-foundry-meta", EvaluatorDiagnosticsRequiredPreviews)
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
    ListEvaluatorVersionsParameters,
    Azure.Core.Page<EvaluatorVersion>
  >;

  // GET /evaluators
  /** Lists the latest version of each evaluator. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("List latest evaluator versions")
  @Rest.listsResource(EvaluatorVersion)
  listLatestVersions is FoundryResourceList<
    EvaluatorVersion,
    ListEvaluatorVersionsParameters,
    Azure.Core.Page<EvaluatorVersion>
  >;

  // GET /evaluators/{name}/versions/{version}
  /** Retrieves the specified evaluator version, returning 404 if it does not exist. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Get an evaluator version")
  getVersion is FoundryResourceOperation<
    EvaluatorVersion,
    {
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
      @doc("Required when calibration_job_id is supplied; omitted for ordinary version creation.")
      @added(Versions.v1)
      @header("Foundry-Features")
      foundry_features?: FoundryFeaturesOptInKeys.evaluations_v1_preview;

      @doc("Successful calibration job whose unchanged proposal is being saved. The service requires the preview header, checks that the job succeeded and belongs to this evaluator, and verifies that the submitted definition matches its proposal before recording provenance. An edited proposal returns 400; omit this parameter to save without evidence.")
      @added(Versions.v1)
      @extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
      @query
      calibration_job_id?: string;

      @Http.bodyRoot
      evaluator_version: EvaluatorVersion;
    },
    Azure.Core.Foundations.ResourceCreatedResponse<EvaluatorVersion>
  >;

  /** Checks an evaluator version against human reviewers on a completed run without tuning or calling a model. The service checks access before consulting a caller-partitioned cache. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Agreement is a synchronous evaluator-version action."
  @added(Versions.v1)
  @summary("Check evaluator agreement with reviewers")
  @route("/evaluators/{name}/versions/{version}:check_agreement")
  @post
  @extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
  @extension(
    "x-ms-examples",
    #{
      CheckAgreement: #{
        $ref: "../../examples/v1/Evaluators_checkAgreement.json",
      },
    }
  )
  checkAgreement is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      @doc("Evaluator name.")
      @path
      name: string;

      @doc("Evaluator version.")
      @path
      version: string;

      @doc("Bypass the agreement cache when true.")
      @query
      refresh?: boolean = false;

      @doc("Run and reviewer-label sources to compare.")
      @body
      agreement: EvaluatorAgreementCheckInputs;
    },
    EvaluatorAgreementCheckResult
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
  startPendingUpload is FoundryDataPlaneOperation<
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
  getCredentials is FoundryDataPlaneOperation<
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

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "OpenAI-based operations are not conventionally versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "OpenAI-based operations are definitionally non-standard"
@tag("EvaluatorGenerationJobs")
interface EvaluatorGenerationJobs {
  /**
   * Creates an evaluator generation job. The service generates rubric-based evaluator
   * definitions from the provided source materials asynchronously.
   */
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "LRO polling is handled by the client via Operation-Location"
  @summary("Create an evaluator generation job")
  @route("evaluator_generation_jobs")
  @pollingOperation(EvaluatorGenerationJobs.get)
  @post
  create is FoundryDataPlaneOperation<
    {
      ...WithOperationId;

      /** The evaluator generation job inputs to create. */
      @body job: EvaluatorGenerationInputs;
    },
    JobCreatedResponse<EvaluatorGenerationJob>
  >;

  /**
   * Gets the details of an evaluator generation job by its ID.
   */
  @summary("Get an evaluator generation job")
  @route("evaluator_generation_jobs/{jobId}")
  get is queryJobStatus<EvaluatorGenerationJob>;

  /**
   * Returns a list of evaluator generation jobs. The List API has up to a few
   * seconds of propagation delay, so a recently created job may not appear
   * immediately; use the Get evaluator generation job API with the job ID to
   * retrieve a specific job without delay.
   */
  @summary("List evaluator generation jobs")
  @route("evaluator_generation_jobs")
  list is listJobs<EvaluatorGenerationJob>;

  /**
   * Cancels an evaluator generation job by its ID.
   */
  @summary("Cancel an evaluator generation job")
  @route("evaluator_generation_jobs/{jobId}:cancel")
  cancel is cancelJob<EvaluatorGenerationJob>;

  /**
   * Deletes an evaluator generation job by its ID. Deletes the job record only;
   * the generated evaluator (if any) is preserved.
   */
  @summary("Delete an evaluator generation job")
  @route("evaluator_generation_jobs/{jobId}")
  delete is deleteJob<EvaluatorGenerationJob>;
}

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Foundry job operations use the project's api-version parameter."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Calibration jobs use the shared Foundry job patterns."
@added(Versions.v1)
@tag("Evaluators")
interface EvaluatorCalibrationJobs {
  /** Starts a calibration job. Reusing an Operation-Id with the same body returns the original job; reusing it with a different body returns 409. No evaluator is saved until a caller separately adopts the proposal. */
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "LRO polling is handled via Operation-Location."
  @summary("Create an evaluator calibration job")
  @route("evaluator_calibration_jobs")
  @post
  @extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
  @extension(
    "x-ms-examples",
    #{
      CreateCalibrationJob: #{
        $ref: "../../examples/v1/EvaluatorCalibrationJobs_createCalibrationJob.json",
      },
      TracesAndDataset: #{
        $ref: "../../examples/v1/EvaluatorCalibrationJobs_createCalibrationJob_TracesAndDataset.json",
      },
      Upload: #{
        $ref: "../../examples/v1/EvaluatorCalibrationJobs_createCalibrationJob_Upload.json",
      },
      InvalidBooleanOptions: #{
        $ref: "../../examples/v1/EvaluatorCalibrationJobs_createCalibrationJob_BooleanInvalid.json",
      },
    }
  )
  @pollingOperation(EvaluatorCalibrationJobs.getCalibrationJob)
  @finalOperation(
    EvaluatorCalibrationJobs.getCalibrationJob,
    {
      jobId: ResponseProperty<"id">,
    }
  )
  createCalibrationJob is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      ...WithOperationId;

      @doc("Calibration job inputs.")
      @body
      job: EvaluatorCalibrationJob;
    },
    JobCreatedResponse<EvaluatorCalibrationJob>
  >;

  /** Gets a job and its proposal after success. Jobs and inline uploaded items expire after 30 days. */
  @summary("Get an evaluator calibration job")
  @route("evaluator_calibration_jobs/{jobId}")
  @extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
  @extension(
    "x-ms-examples",
    #{
      GetCalibrationJob: #{
        $ref: "../../examples/v1/EvaluatorCalibrationJobs_getCalibrationJob.json",
      },
    }
  )
  getCalibrationJob is queryJobStatusPreview<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    EvaluatorCalibrationJob,
    {
      @doc("The job identifier.")
      @path
      jobId: string;
    },
    JobStatusResponse<EvaluatorCalibrationJob>,
    WithRequiredFoundryPreviewHeader<FoundryFeaturesOptInKeys.evaluations_v1_preview>
  >;

  /** Lists calibration jobs for the project, optionally filtered by evaluator name. */
  @summary("List evaluator calibration jobs")
  @route("evaluator_calibration_jobs")
  @get
  @list
  @extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
  @extension(
    "x-ms-examples",
    #{
      ListCalibrationJobs: #{
        $ref: "../../examples/v1/EvaluatorCalibrationJobs_listCalibrationJobs.json",
      },
    }
  )
  listCalibrationJobs is FoundryDataPlaneRequiredPreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      ...CommonPageQueryParameters;

      @doc("Filter by evaluator name.")
      @query
      evaluator_name?: string;
    },
    AgentsPagedResult<EvaluatorCalibrationJob>
  >;

  /** Cancels a queued or running job. An already finished job is returned unchanged. */
  @summary("Cancel an evaluator calibration job")
  @route("evaluator_calibration_jobs/{jobId}:cancel")
  @extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
  @extension(
    "x-ms-examples",
    #{
      CancelCalibrationJob: #{
        $ref: "../../examples/v1/EvaluatorCalibrationJobs_cancelCalibrationJob.json",
      },
    }
  )
  cancelCalibrationJob is cancelJobPreview<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    EvaluatorCalibrationJob,
    {
      @doc("The job identifier.")
      @path
      jobId: string;
    },
    OkResponse & EvaluatorCalibrationJob,
    WithRequiredFoundryPreviewHeader<FoundryFeaturesOptInKeys.evaluations_v1_preview>
  >;

  /** Deletes a finished job and its proposal. A queued or running job returns 409; a previously saved evaluator version and its calibration evidence are unaffected. */
  @summary("Delete an evaluator calibration job")
  @route("evaluator_calibration_jobs/{jobId}")
  @extension("x-ms-foundry-meta", EvaluatorsRequiredPreviews)
  @extension(
    "x-ms-examples",
    #{
      DeleteCalibrationJob: #{
        $ref: "../../examples/v1/EvaluatorCalibrationJobs_deleteCalibrationJob.json",
      },
    }
  )
  deleteCalibrationJob is deleteJobPreview<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      @doc("The job identifier.")
      @path
      jobId: string;
    },
    NoContentResponse,
    WithRequiredFoundryPreviewHeader<FoundryFeaturesOptInKeys.evaluations_v1_preview>
  >;
}
