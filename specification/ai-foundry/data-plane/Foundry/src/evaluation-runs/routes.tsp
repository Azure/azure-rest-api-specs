import "./models.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

/** Optional filters for task-run list operations. */
model EvalTaskRunListParameters {
  /** Filters task runs by execution status. */
  @query status?: EvaluationTaskRunStatus;

  /** Filters task runs by evaluated pass outcome. */
  @query passed?: boolean;

  ...CommonPageQueryParameters;
}

/** Operations for durable EvalRuns. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundry preview operations use the project-standard feature-header and error-envelope template."
@tag("EvalRuns")
@removed(Versions.v1)
interface EvalRuns {
  /** Creates and starts an evaluation run. */
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "LRO polling is handled by the client through Operation-Location."
  @summary("Create an evaluation run")
  @post
  @route("/evaluation-runs")
  @pollingOperation(EvalRuns.get)
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  create is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      ...WithOperationId;

      /** Exact named EvalJob version to run. */
      @body request: EvalRunFromJob;
    },
    JobCreatedResponse<FoundryEvalRun>
  >;

  /** Retrieves an evaluation run and its current status. */
  @summary("Get an evaluation run")
  @get
  @route("/evaluation-runs/{run_id}")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  get is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** The evaluation-run identifier. */
      @path run_id: string;
    },
    JobStatusResponse<FoundryEvalRun>
  >;

  /** Lists evaluation runs in the project. */
  @summary("List evaluation runs")
  @get
  @list
  @route("/evaluation-runs")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  list is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    CommonPageQueryParameters,
    AgentsPagedResult<FoundryEvalRun>
  >;

  /** Requests cancellation of a queued or in-progress evaluation run. */
  @summary("Cancel an evaluation run")
  @post
  @route("/evaluation-runs/{run_id}:cancel")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  cancel is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** The evaluation-run identifier. */
      @path run_id: string;
    },
    OkResponse & FoundryEvalRun
  >;

  /** Deletes a terminal evaluation-run record. */
  @summary("Delete an evaluation run")
  @delete
  @route("/evaluation-runs/{run_id}")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  delete is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** The evaluation-run identifier. */
      @path run_id: string;
    },
    NoContentResponse
  >;

  /** Reads the captured job, Dataset digest, resolved target, and execution defaults. */
  @summary("Get an evaluation run's resolved configuration")
  @get
  @route("/evaluation-runs/{run_id}/resolvedConfiguration")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  getResolvedConfiguration is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** Parent evaluation-run identifier. */
      @path run_id: string;
    },
    OkResponse & EvalRunResolvedConfiguration
  >;

  /** Lists task runs contained by an evaluation run. */
  @summary("List evaluation task runs")
  @get
  @list
  @route("/evaluation-runs/{run_id}/task-runs")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  listTaskRuns is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** The parent evaluation-run identifier. */
      @path run_id: string;

      ...EvalTaskRunListParameters;
    },
    AgentsPagedResult<EvalTaskRun>
  >;

  /** Retrieves one task run and its retained evidence metadata. */
  @summary("Get an evaluation task run")
  @get
  @route("/evaluation-runs/{run_id}/task-runs/{task_run_id}")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  getTaskRun is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** The parent evaluation-run identifier. */
      @path run_id: string;

      /** The task-run identifier. */
      @path task_run_id: string;
    },
    OkResponse & EvalTaskRun
  >;

  /** Retrieves the normalized ATIF trajectory for a task run. */
  @summary("Get an evaluation task-run trajectory")
  @get
  @route("/evaluation-runs/{run_id}/task-runs/{task_run_id}/trajectory")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  getTaskRunTrajectory is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** The parent evaluation-run identifier. */
      @path run_id: string;

      /** The task-run identifier. */
      @path task_run_id: string;
    },
    OkResponse & EvaluationTrajectory
  >;
}
