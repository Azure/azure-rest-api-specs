import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "./models.tsp";
import "../evaluation-runs/models.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

/** Filters supported by the existing suite list operation. */
alias EvaluationSuiteFilterQueryParams = {
  /** Filter by associated Foundry agent name. */
  @query("agent_name")
  agent_name?: string;
};

/** Additional parameters for listing suite versions. */
alias ListEvaluationSuiteVersionsParameters = {};

/** Operations for evaluation-suite versions. */
@removed(Versions.v1)
interface EvaluationSuites
  extends VersionedOperations<
      EvaluationSuiteVersion,
      InputParameters<EvaluationSuiteVersion, "evaluationSuiteVersion">,
      EvaluationSuiteFilterQueryParams,
      ListEvaluationSuiteVersionsParameters
    > {
  /** Creates a suite version with a service-generated version identifier. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing suite preview operation."
  @summary("Create an evaluation suite version")
  @post
  @route("/evaluation_suites/{name}/versions")
  @extension("x-ms-foundry-meta", EvaluationSuitesRequiredPreviews)
  createEvaluationSuiteVersion is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** The suite name. */
      @path name: string;

      /** The suite version to create. */
      @bodyRoot evaluationSuiteVersion: EvaluationSuiteVersion;
    },
    Response<201> & EvaluationSuiteVersion
  >;

  /** Runs a suite using the existing evaluation preview. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing suite preview operation."
  @summary("Run an evaluation suite")
  @post
  @route("/evaluation_suites/{name}:run")
  @extension("x-ms-foundry-meta", EvaluationSuitesRequiredPreviews)
  run is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** The suite name. */
      @path name: string;

      /** The existing preview run parameters. */
      @body body: EvaluationSuiteRunRequest;
    },
    Response<201> & EvaluationSuiteRunResponse
  >;
}

/** Stable jobs and published versions return an ETag for conditional mutations. */
alias EvalJobWithEtag<T extends TypeSpec.Reflection.Model> = T & {
  /** Current resource version for use with If-Match. */
  @header("ETag") etag: string;
};

/** Operations for stable EvalJobs and immutable configuration versions. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundry preview operations use the project-standard feature-header and error-envelope template."
@tag("EvalJobs")
@removed(Versions.v1)
interface EvalJobs {
  /** Lists named EvalJobs. */
  @summary("List EvalJobs")
  @get
  @list
  @route("/evaluation-jobs")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  list is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    CommonPageQueryParameters,
    AgentsPagedResult<EvalJob>
  >;

  /** Creates a stable EvalJob before its first version is published. */
  @summary("Create an EvalJob")
  @post
  @route("/evaluation-jobs")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  create is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** The stable name and optional metadata. */
      @bodyRoot evaluation_job: EvalJob;
    },
    Response<201> & EvalJobWithEtag<EvalJob>
  >;

  /** Retrieves the current definition of a named EvalJob. */
  @summary("Get an EvalJob")
  @get
  @route("/evaluation-jobs/{name}")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  get is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** The EvalJob name. */
      @path name: string;
    },
    OkResponse & EvalJobWithEtag<EvalJob>
  >;

  /** Updates only stable metadata; published configurations remain unchanged. */
  @summary("Update an EvalJob")
  @patch
  @route("/evaluation-jobs/{name}")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  update is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** Stable EvalJob name. */
      @path name: string;

      /** ETag of the stable job to update. */
      @header("If-Match") if_match: string;

      /** Stable description or metadata changes. */
      @body body: EvalJobUpdate;
    },
    OkResponse & EvalJobWithEtag<EvalJob>
  >;

  /** Soft-deletes the job without changing already admitted runs. */
  @summary("Delete an EvalJob")
  @delete
  @route("/evaluation-jobs/{name}")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  delete is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** Stable EvalJob name. */
      @path name: string;

      /** ETag of the job to delete. */
      @header("If-Match") if_match: string;
    },
    NoContentResponse
  >;

  /** Publishes a configuration bound to a validated Dataset version and digest. */
  @summary("Create an EvalJob version")
  @post
  @route("/evaluation-jobs/{name}/versions")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  createVersion is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** Stable EvalJob name. */
      @path name: string;

      /** Job settings to publish; version assignment remains under review. */
      @bodyRoot job_definition: EvalJobDefinition;
    },
    Response<201> & EvalJobWithEtag<EvalJobVersion>
  >;

  /** Lists published configuration versions. */
  @summary("List EvalJob versions")
  @get
  @list
  @route("/evaluation-jobs/{name}/versions")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  listVersions is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** Stable EvalJob name. */
      @path name: string;

      ...CommonPageQueryParameters;
    },
    AgentsPagedResult<EvalJobVersion>
  >;

  /** Retrieves an exact published configuration. */
  @summary("Get an EvalJob version")
  @get
  @route("/evaluation-jobs/{name}/versions/{version}")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  getVersion is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** Stable EvalJob name. */
      @path name: string;

      /** Exact configuration version. */
      @path version: string;
    },
    OkResponse & EvalJobWithEtag<EvalJobVersion>
  >;

  /** Soft-deletes one configuration version without changing prior runs. */
  @summary("Delete an EvalJob version")
  @delete
  @route("/evaluation-jobs/{name}/versions/{version}")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  deleteVersion is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** Stable EvalJob name. */
      @path name: string;

      /** Exact version to delete. */
      @path version: string;

      /** ETag of this version. */
      @header("If-Match") if_match: string;
    },
    NoContentResponse
  >;

  /** Lists the job's runs across all published versions. */
  @summary("List an EvalJob's runs")
  @get
  @list
  @route("/evaluation-jobs/{name}/runs")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  listRuns is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** Stable EvalJob name. */
      @path name: string;

      /** Optional execution-status filter. */
      @query status?: EvaluationRunStatus;

      ...CommonPageQueryParameters;
    },
    AgentsPagedResult<FoundryEvalRun>
  >;
}

/** Operations for the existing evaluation-suite generation preview. */
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "OpenAI-based operations are not conventionally versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "OpenAI-based operations are definitionally non-standard"
@tag("EvaluationSuiteGenerationJobs")
@removed(Versions.v1)
interface EvaluationSuiteGenerationJobs {
  /** Creates a job to generate an evaluation suite. */
  @summary("Create an evaluation suite generation job")
  @route("evaluation_suite_generation_jobs")
  @extension("x-ms-foundry-meta", EvaluationSuiteGenerationJobsRequiredPreviews)
  @pollingOperation(EvaluationSuiteGenerationJobs.get)
  create is postJobPreview<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    EvaluationSuiteGenerationJob
  >;

  /** Retrieves a suite-generation job and its current status. */
  @summary("Get an evaluation suite generation job")
  @route("evaluation_suite_generation_jobs/{jobId}")
  @extension("x-ms-foundry-meta", EvaluationSuiteGenerationJobsRequiredPreviews)
  get is queryJobStatusPreview<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    EvaluationSuiteGenerationJob
  >;

  /** Lists suite-generation jobs in the project. */
  @summary("List evaluation suite generation jobs")
  @route("evaluation_suite_generation_jobs")
  @extension("x-ms-foundry-meta", EvaluationSuiteGenerationJobsRequiredPreviews)
  list is listJobsPreview<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    EvaluationSuiteGenerationJob
  >;

  /** Requests cancellation of a queued or running suite-generation job. */
  @summary("Cancel an evaluation suite generation job")
  @route("evaluation_suite_generation_jobs/{jobId}:cancel")
  @extension("x-ms-foundry-meta", EvaluationSuiteGenerationJobsRequiredPreviews)
  cancel is cancelJobPreview<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    EvaluationSuiteGenerationJob
  >;

  /** Deletes a suite-generation job. */
  @summary("Delete an evaluation suite generation job")
  @route("evaluation_suite_generation_jobs/{jobId}")
  @extension("x-ms-foundry-meta", EvaluationSuiteGenerationJobsRequiredPreviews)
  delete is deleteJobPreview<FoundryFeaturesOptInKeys.evaluations_v1_preview>;
}
