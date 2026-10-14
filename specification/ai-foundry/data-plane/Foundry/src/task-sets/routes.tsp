import "./models.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

// Open question (Eval 2.0 spec): page /task_sets/{name}/versions/{version}/tasks,
// add GET .../tasks/{taskId}, and allow base_version + upsert_tasks/remove_task_ids
// on createVersion to publish a new version. Never mutate pinned versions.

/** Operations for immutable TaskSet versions. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundry preview operations use the project-standard feature-header and error-envelope template."
@tag("TaskSets")
@removed(Versions.v1)
interface TaskSets {
  /** Lists the latest version of each task set. */
  @summary("List task sets")
  @get
  @list
  @route("/task_sets")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  list is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    CommonPageQueryParameters,
    AgentsPagedResult<TaskSetVersion>
  >;

  /** Creates a task set if absent, or appends a version only when its complete definition changes. */
  @summary("Reconcile a task set")
  @post
  @route("/task_sets/{name}")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  reconcile is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** The stable task-set name. */
      @path name: string;

      /** The complete definition to publish if changed. */
      @bodyRoot task_set: TaskSetDefinition;
    },
    Foundations.ResourceCreatedOrOkResponse<TaskSetVersion>
  >;

  /** Always appends a task-set version with a service-assigned identifier. */
  @summary("Create a task-set version")
  @post
  @route("/task_sets/{name}/versions")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  createVersion is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** The task-set name. */
      @path name: string;

      /** The task-set version to create. */
      @bodyRoot task_set: TaskSetDefinition;
    },
    Response<201> & TaskSetVersion
  >;

  /** Lists all versions of a task set. */
  @summary("List task-set versions")
  @get
  @list
  @route("/task_sets/{name}/versions")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  listVersions is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** The task-set name. */
      @path name: string;

      ...CommonPageQueryParameters;
    },
    AgentsPagedResult<TaskSetVersion>
  >;

  /** Retrieves an exact task-set version. */
  @summary("Get a task-set version")
  @get
  @route("/task_sets/{name}/versions/{version}")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  getVersion is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** The task-set name. */
      @path name: string;

      /** The exact version identifier. */
      @path version: string;
    },
    OkResponse & TaskSetVersion
  >;
}
