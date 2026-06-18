import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "./models.tsp";

namespace Azure.AI.Projects;
using Http;
using OpenAPI;
using TypeSpec.Versioning;

alias ListEvaluationSuiteVersionsParameters = {};

alias EvaluationSuiteFilterQueryParams = {
  @query("agent_name")
  @doc("Filter by associated Foundry agent name (from target).")
  agent_name?: string;
};

// ---------------------------------------------------------------------------
// CRUD operations (versioned asset pattern)
// ---------------------------------------------------------------------------

const EvaluationSuitesRequiredPreviews = #{
  required_previews: #[FoundryFeaturesOptInKeys.evaluations_v1_preview],
};

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
  @doc(
    "Create a new {name} with auto incremented version id",
    EvaluationSuiteVersion
  )
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
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Run an evaluation suite")
  @doc("Runs an evaluation using the suite's testing criteria and dataset.")
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

const EvaluationSuiteGenerationJobsRequiredPreviews = #{
  conditional_previews: #[FoundryFeaturesOptInKeys.evaluations_v1_preview],
};

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "OpenAI-based operations are not conventionally versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "OpenAI-based operations are definitionally non-standard"
#suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "LRO polling is handled by the client via Operation-Location"
@tag("EvaluationSuiteGenerationJobs")
@removed(Versions.v1)
interface EvaluationSuiteGenerationJobs {
  @summary("Create an evaluation suite generation job")
  @route("evaluation_suite_generation_jobs")
  @extension("x-ms-foundry-meta", EvaluationSuiteGenerationJobsRequiredPreviews)
  create is postJobPreview<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    EvaluationSuiteGenerationJob
  >;

  @summary("Get an evaluation suite generation job")
  @route("evaluation_suite_generation_jobs/{jobId}")
  @extension("x-ms-foundry-meta", EvaluationSuiteGenerationJobsRequiredPreviews)
  get is queryJobStatusPreview<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    EvaluationSuiteGenerationJob
  >;

  @summary("List evaluation suite generation jobs")
  @route("evaluation_suite_generation_jobs")
  @extension("x-ms-foundry-meta", EvaluationSuiteGenerationJobsRequiredPreviews)
  list is listJobsPreview<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    EvaluationSuiteGenerationJob
  >;

  @summary("Cancel an evaluation suite generation job")
  @route("evaluation_suite_generation_jobs/{jobId}:cancel")
  @extension("x-ms-foundry-meta", EvaluationSuiteGenerationJobsRequiredPreviews)
  cancel is cancelJobPreview<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    EvaluationSuiteGenerationJob
  >;

  @summary("Delete an evaluation suite generation job")
  @route("evaluation_suite_generation_jobs/{jobId}")
  @extension("x-ms-foundry-meta", EvaluationSuiteGenerationJobsRequiredPreviews)
  delete is deleteJobPreview<FoundryFeaturesOptInKeys.evaluations_v1_preview>;
}
