import "./models.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

/** Optional filters for task-run list operations. */
model EvaluationTaskRunListParameters {
  /** Filters task runs by execution status. */
  @query status?: JobStatus;

  /** Filters task runs by evaluated pass outcome. */
  @query passed?: boolean;

  ...CommonPageQueryParameters;
}

/** Operations for durable evaluation runs. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundry preview operations use the project-standard feature-header and error-envelope template."
@tag("EvaluationRuns")
@removed(Versions.v1)
interface EvaluationRuns {
  /** Creates and starts an evaluation run. */
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "LRO polling is handled by the client through Operation-Location."
  @summary("Create an evaluation run")
  @post
  @route("/evaluation_runs")
  @pollingOperation(EvaluationRuns.get)
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  create is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      ...WithOperationId;

      /** The immutable evaluation-run inputs. */
      @body request: EvaluationRunCreateContent;
    },
    JobCreatedResponse<EvaluationRun>
  >;

  /** Retrieves an evaluation run and its current status. */
  @summary("Get an evaluation run")
  @get
  @route("/evaluation_runs/{runId}")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  get is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** The evaluation-run identifier. */
      @path runId: string;
    },
    JobStatusResponse<EvaluationRun>
  >;

  /** Lists evaluation runs in the project. */
  @summary("List evaluation runs")
  @get
  @list
  @route("/evaluation_runs")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  list is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    CommonPageQueryParameters,
    AgentsPagedResult<EvaluationRun>
  >;

  /** Requests cancellation of a queued or in-progress evaluation run. */
  @summary("Cancel an evaluation run")
  @post
  @route("/evaluation_runs/{runId}:cancel")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  cancel is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** The evaluation-run identifier. */
      @path runId: string;
    },
    OkResponse & EvaluationRun
  >;

  /** Deletes a terminal evaluation-run record. */
  @summary("Delete an evaluation run")
  @delete
  @route("/evaluation_runs/{runId}")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  delete is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** The evaluation-run identifier. */
      @path runId: string;
    },
    NoContentResponse
  >;

  /** Lists task runs contained by an evaluation run. */
  @summary("List evaluation task runs")
  @get
  @list
  @route("/evaluation_runs/{runId}/task_runs")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  listTaskRuns is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** The parent evaluation-run identifier. */
      @path runId: string;

      ...EvaluationTaskRunListParameters;
    },
    AgentsPagedResult<EvaluationTaskRun>
  >;

  /** Retrieves one task run and its retained evidence metadata. */
  @summary("Get an evaluation task run")
  @get
  @route("/evaluation_runs/{runId}/task_runs/{taskRunId}")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  getTaskRun is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** The parent evaluation-run identifier. */
      @path runId: string;

      /** The task-run identifier. */
      @path taskRunId: string;
    },
    OkResponse & EvaluationTaskRun
  >;

  /** Retrieves the normalized ATIF trajectory for a task run. */
  @summary("Get an evaluation task-run trajectory")
  @get
  @route("/evaluation_runs/{runId}/task_runs/{taskRunId}/trajectory")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  getTaskRunTrajectory is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** The parent evaluation-run identifier. */
      @path runId: string;

      /** The task-run identifier. */
      @path taskRunId: string;
    },
    OkResponse & EvaluationTrajectory
  >;

  /** Streams retained artifact content for a task run. */
  @summary("Download an evaluation task-run artifact")
  @get
  @route("/evaluation_runs/{runId}/task_runs/{taskRunId}/artifacts/{artifactId}/content")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  downloadTaskRunArtifact is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** The parent evaluation-run identifier. */
      @path runId: string;

      /** The task-run identifier. */
      @path taskRunId: string;

      /** The artifact identifier. */
      @path artifactId: string;
    },
    OkResponse & {
      /** The artifact media type. */
      @header("Content-Type") content_type: string;

      /** The artifact bytes. */
      @body content: bytes;
    }
  >;
}
