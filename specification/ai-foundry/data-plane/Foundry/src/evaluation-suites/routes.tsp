import "../common/models.tsp";
import "../servicepatterns.tsp";
import "./models.tsp";

namespace Azure.AI.Projects;
using Http;
using OpenAPI;
using Rest;
using TypeSpec.Versioning;

alias ListEvaluationSuiteVersionsParameters = {};

alias EvaluationSuiteFilterQueryParams = {
  @query("agentName")
  @doc("Filter by associated Foundry agent name (from target).")
  agentName?: string;
};

// ---------------------------------------------------------------------------
// CRUD operations (versioned asset pattern)
// ---------------------------------------------------------------------------

interface EvaluationSuites
  extends VersionedOperations<
      EvaluationSuiteVersion,
      InputParameters<EvaluationSuiteVersion, "evaluationSuiteVersion">,
      EvaluationSuiteFilterQueryParams,
      ListEvaluationSuiteVersionsParameters
    > {

  // POST /evaluationSuites/{name}/versions
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Create a new {name} with auto incremented version id", EvaluationSuiteVersion)
  @Rest.segment("versions")
  @post
  createEvaluationSuiteVersion is Azure.Core.Foundations.ResourceOperation<
    EvaluationSuiteVersion,
    ListEvaluationSuiteVersionsParameters,
    Azure.Core.Foundations.ResourceCreatedResponse<EvaluationSuiteVersion>
  >;

  // POST /evaluationSuites/{name}:run
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Run an evaluation using the suite's testing criteria and dataset.")
  @action("run")
  @post
  run is Azure.Core.Foundations.ResourceOperation<
    EvaluationSuiteVersion,
    EvaluationSuiteRunRequest,
    Azure.Core.Foundations.ResourceCreatedResponse<EvaluationSuiteRunResponse>
  >;
}

// ---------------------------------------------------------------------------
// Generate API (LRO jobs pattern — follows evaluator_generation_jobs)
// ---------------------------------------------------------------------------

const EvaluationSuiteGenerationJobsRequiredPreviews = #{
  conditional_previews: #[
    FoundryFeaturesOptInKeys.evaluations_v1_preview
  ],
};

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "OpenAI-based operations are not conventionally versioned"
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "OpenAI-based operations are definitionally non-standard"
#suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "LRO polling is handled by the client via Operation-Location"
@tag("EvaluationSuiteGenerationJobs")
interface EvaluationSuiteGenerationJobs {
  @summary("Creates an evaluation suite generation job.")
  @route("evaluation_suite_generation_jobs")
  @extension("x-ms-foundry-meta", EvaluationSuiteGenerationJobsRequiredPreviews)
  create is postJobPreview<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    EvaluationSuiteGenerationJob
  >;

  @summary("Get info about an evaluation suite generation job.")
  @route("evaluation_suite_generation_jobs/{jobId}")
  @extension("x-ms-foundry-meta", EvaluationSuiteGenerationJobsRequiredPreviews)
  get is queryJobStatusPreview<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    EvaluationSuiteGenerationJob
  >;

  @summary("Returns a list of evaluation suite generation jobs.")
  @route("evaluation_suite_generation_jobs")
  @extension("x-ms-foundry-meta", EvaluationSuiteGenerationJobsRequiredPreviews)
  list is listJobsPreview<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    EvaluationSuiteGenerationJob
  >;

  @summary("Cancels an evaluation suite generation job.")
  @route("evaluation_suite_generation_jobs/{jobId}:cancel")
  @extension("x-ms-foundry-meta", EvaluationSuiteGenerationJobsRequiredPreviews)
  cancel is cancelJobPreview<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    EvaluationSuiteGenerationJob
  >;

  @summary("Deletes an evaluation suite generation job.")
  @route("evaluation_suite_generation_jobs/{jobId}")
  @extension("x-ms-foundry-meta", EvaluationSuiteGenerationJobsRequiredPreviews)
  delete is deleteJobPreview<
    FoundryFeaturesOptInKeys.evaluations_v1_preview
  >;
}
