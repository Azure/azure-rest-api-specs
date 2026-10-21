import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "./models.tsp";

namespace Azure.AI.Projects;
using Http;
using OpenAPI;
using TypeSpec.Versioning;
using Azure.Core;

alias ListEvaluationSuiteVersionsParameters = {};

alias EvaluationSuiteFilterQueryParams = {
  /** The agent name query parameter. */
  @query("agent_name")
  @doc("Filter by associated Foundry agent name (from target).")
  agent_name?: string;
};

// ---------------------------------------------------------------------------
// CRUD operations (versioned asset pattern)
// ---------------------------------------------------------------------------

@removed(Versions.v1)
interface EvaluationSuites
  extends VersionedOperations<
      EvaluationSuiteVersion,
      InputParameters<EvaluationSuiteVersion, "evaluationSuiteVersion">,
      EvaluationSuiteFilterQueryParams,
      ListEvaluationSuiteVersionsParameters
    > {
  // POST /evaluation_suites/{name}/versions
  /** Creates a new evaluation suite version with an auto-incremented version identifier. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Create an evaluation suite version")
  @post
  @route("/evaluation_suites/{name}/versions")
  @extension("x-ms-foundry-meta", EvaluationSuitesRequiredPreviews)
  createEvaluationSuiteVersion is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      @doc("The name of the evaluation suite.")
      @path
      name: string;

      @doc("The evaluation suite version to create.")
      @bodyRoot
      evaluationSuiteVersion: EvaluationSuiteVersion;
    },
    Response<201> & EvaluationSuiteVersion
  >;

  // POST /evaluation_suites/{name}:run
  /** Runs an evaluation using the suite's testing criteria and dataset. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Run an evaluation suite")
  @post
  @route("/evaluation_suites/{name}:run")
  @extension("x-ms-foundry-meta", EvaluationSuitesRequiredPreviews)
  run is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      @doc("The name of the evaluation suite.")
      @path
      name: string;

      @doc("The run request parameters.")
      @body
      body: EvaluationSuiteRunRequest;
    },
    Response<201> & EvaluationSuiteRunResponse
  >;
}

// ---------------------------------------------------------------------------
// Generate API (LRO jobs pattern — follows evaluator_generation_jobs)
// ---------------------------------------------------------------------------

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "OpenAI-based operations are not conventionally versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "OpenAI-based operations are definitionally non-standard"
@tag("EvaluationSuiteGenerationJobs")
@removed(Versions.v1)
interface EvaluationSuiteGenerationJobs {
  /** Creates an evaluation suite generation job and returns the queued job. */
  @summary("Create an evaluation suite generation job")
  @route("evaluation_suite_generation_jobs")
  @extension("x-ms-foundry-meta", EvaluationSuiteGenerationJobsRequiredPreviews)
  @pollingOperation(EvaluationSuiteGenerationJobs.get)
  create is postJobPreview<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    EvaluationSuiteGenerationJob
  >;

  /** Retrieves an evaluation suite generation job by its identifier. */
  @summary("Get an evaluation suite generation job")
  @route("evaluation_suite_generation_jobs/{jobId}")
  @extension("x-ms-foundry-meta", EvaluationSuiteGenerationJobsRequiredPreviews)
  get is queryJobStatusPreview<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    EvaluationSuiteGenerationJob
  >;

  /** Lists evaluation suite generation jobs for the project. */
  @summary("List evaluation suite generation jobs")
  @route("evaluation_suite_generation_jobs")
  @extension("x-ms-foundry-meta", EvaluationSuiteGenerationJobsRequiredPreviews)
  list is listJobsPreview<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    EvaluationSuiteGenerationJob
  >;

  /** Requests cancellation of a running or queued evaluation suite generation job. */
  @summary("Cancel an evaluation suite generation job")
  @route("evaluation_suite_generation_jobs/{jobId}:cancel")
  @extension("x-ms-foundry-meta", EvaluationSuiteGenerationJobsRequiredPreviews)
  cancel is cancelJobPreview<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    EvaluationSuiteGenerationJob
  >;

  /** Deletes an evaluation suite generation job by its identifier. */
  @summary("Delete an evaluation suite generation job")
  @route("evaluation_suite_generation_jobs/{jobId}")
  @extension("x-ms-foundry-meta", EvaluationSuiteGenerationJobsRequiredPreviews)
  delete is deleteJobPreview<FoundryFeaturesOptInKeys.evaluations_v1_preview>;
}
