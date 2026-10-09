import "./models.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Azure.AI.Projects;

// Open question (Eval 2.0 spec): page /task_sets/{name}/versions/{version}/tasks,
// add GET .../tasks/{taskId}, and allow base_version + upsert_tasks/remove_task_ids
// on createVersion to publish a new version. Never mutate pinned versions.

/** Operations for immutable evaluation task-set versions. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Foundry preview operations use the project-standard feature-header and error-envelope template."
@tag("EvaluationTaskSets")
@removed(Versions.v1)
interface EvaluationTaskSets {
  /** Lists the latest version of each task set. */
  @summary("List evaluation task sets")
  @get
  @list
  @route("/task_sets")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  list is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    CommonPageQueryParameters,
    AgentsPagedResult<EvaluationTaskSetVersion>
  >;

  /** Creates a task-set version with a service-generated version identifier. */
  @summary("Create an evaluation task-set version")
  @post
  @route("/task_sets/{name}/versions")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  createVersion is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** The task-set name. */
      @path name: string;

      /** The task-set version to create. */
      @bodyRoot task_set: EvaluationTaskSetVersion;
    },
    Response<201> & EvaluationTaskSetVersion
  >;

  /** Creates an explicitly versioned task set or verifies that an existing version has the same definition. */
  @summary("Create or verify an evaluation task-set version")
  @put
  @route("/task_sets/{name}/versions/{version}")
  @extension("x-ms-foundry-meta", EvaluationServiceV2RequiredPreviews)
  createOrReplaceVersion is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.evaluations_v1_preview,
    {
      /** The task-set name. */
      @path name: string;

      /** The exact version identifier. */
      @path version: string;

      /** The task-set version to create or reconcile. */
      @bodyRoot task_set: EvaluationTaskSetVersion;
    },
    Foundations.ResourceCreatedOrOkResponse<EvaluationTaskSetVersion>
  >;

  /** Lists all versions of a task set. */
  @summary("List evaluation task-set versions")
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
    AgentsPagedResult<EvaluationTaskSetVersion>
  >;

  /** Retrieves an exact task-set version. */
  @summary("Get an evaluation task-set version")
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
    OkResponse & EvaluationTaskSetVersion
  >;
}
