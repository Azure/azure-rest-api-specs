import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "../evaluation-jobs/routes.tsp";
import "./models.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

/** Plain filters for listing EvaluationRuns; combined filters must all match. */
alias EvaluationRunListFilters = {
  /** Returns only Runs in this status. */
  @query status?: EvaluationRunStatus;

  /** Returns only Runs of the current Job with this name. */
  @query evaluation_job?: string;
};

/** Operations for EvaluationRuns and their TaskRuns. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundry preview operations use the project-standard feature-header and error-envelope template."
@tag("EvaluationRuns")
@removed(Versions.v1)
interface EvaluationRuns {
  /** Creates a Run in `queued` status; an equivalent `Operation-Id` retry returns the original Run with `201`. */
  #suppress "@azure-tools/typespec-azure-core/long-running-polling-operation-required" "Clients poll the Location URL."
  @summary("Create an EvaluationRun")
  @post
  @route("/evaluation_runs")
  @pollingOperation(EvaluationRuns.get)
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  create is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      ...WithOperationId;

      /** A direct definition or a saved Job reference. */
      @body request: EvaluationRunCreateRequest;
    },
    CreatedResponse &
      WithEvaluationETag<EvaluationRun> & {
        /** URL to poll for the Run status. */
        @header("Operation-Location") operationLocation: string;

        /** URL of the created Run. */
        @header("Location") location: string;
      }
  >;

  /** Retrieves a Run and its current status. */
  @summary("Get an EvaluationRun")
  @get
  @route("/evaluation_runs/{run_id}")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  get is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** The Run ID. */
      @path run_id: string;
    },
    WithEvaluationETag<JobStatusResponse<EvaluationRun>>
  >;

  /** Lists Runs in the project, including Runs of deleted Jobs. */
  @summary("List EvaluationRuns")
  @get
  @list
  @route("/evaluation_runs")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  list is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      ...CommonPageQueryParameters;
      ...EvaluationRunListFilters;
    },
    AgentsPagedResult<EvaluationRun>
  >;

  /** Requests cancellation of a queued or in-progress Run and returns its current `cancelling` or `cancelled` view. */
  @summary("Cancel an EvaluationRun")
  @post
  @route("/evaluation_runs/{run_id}:cancel")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  cancel is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** The Run ID. */
      @path run_id: string;
    },
    OkResponse & WithEvaluationETag<EvaluationRun>
  >;

  /** Deletes a terminal Run. */
  @summary("Delete an EvaluationRun")
  @delete
  @route("/evaluation_runs/{run_id}")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  delete is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** The Run ID. */
      @path run_id: string;

      /** The Run's current ETag. */
      @header("If-Match") if_match: string;
    },
    NoContentResponse
  >;

  /** Retrieves the configuration, judges and dependencies the Run retained at creation. */
  @summary("Get an EvaluationRun's resolved configuration")
  @get
  @route("/evaluation_runs/{run_id}/resolved_configuration")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  getResolvedConfiguration is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** The Run ID. */
      @path run_id: string;
    },
    ResolvedRunConfiguration
  >;

  /** Lists a Run's TaskRuns in selection order. */
  @summary("List TaskRuns")
  @get
  @list
  @route("/evaluation_runs/{run_id}/task_runs")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  listTaskRuns is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** The parent Run ID. */
      @path run_id: string;

      ...PageLimitQueryParameter;
      ...PageAfterQueryParameter;
      ...PageBeforeQueryParameter;
    },
    AgentsPagedResult<TaskRun>
  >;

  /** Retrieves one TaskRun. */
  @summary("Get a TaskRun")
  @get
  @route("/evaluation_runs/{run_id}/task_runs/{task_run_id}")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  getTaskRun is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** The parent Run ID. */
      @path run_id: string;

      /** The TaskRun ID. */
      @path task_run_id: string;
    },
    TaskRun
  >;
}
