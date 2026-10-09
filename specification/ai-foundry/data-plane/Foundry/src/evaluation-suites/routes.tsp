import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "./models.tsp";

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

  /** Creates a task-set-based suite at an exact version, or verifies an identical existing version. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundry preview operation with an exact version and feature header."
  @summary("Create or verify an evaluation-suite version")
  @put
  @route("/evaluation_suites/{name}/versions/{version}")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  createOrReplaceVersion is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** The suite name. */
      @path name: string;

      /** The exact version identifier. */
      @path version: string;

      /** The task-set-based suite definition. */
      @bodyRoot evaluation_suite: EvaluationSuiteVersion;
    },
    Foundations.ResourceCreatedOrOkResponse<EvaluationSuiteVersion>
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

/** Operations for the existing evaluation-suite generation preview. */
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing OpenAI-based suite operations are not conventionally versioned."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing OpenAI-based suite operations use the shared job pattern."
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
