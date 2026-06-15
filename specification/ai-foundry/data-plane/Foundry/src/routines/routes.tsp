import "../common/models.tsp";
import "../common/servicepatterns.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

@tag("Routines")
interface Routines {
  /** Creates a new routine or replaces an existing routine with the supplied definition. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Create or update a routine")
  @operationId("createOrUpdateRoutine")
  @put
  @route("/routines/{routine_name}")
  @extension("x-ms-foundry-meta", RoutineRequiredPreviews)
  createOrUpdateRoutine is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.routines_v1_preview,
    CreateOrUpdateRoutineParameters,
    Routine
  >;

  /** Retrieves the specified routine and its current configuration. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Get a routine")
  @operationId("getRoutine")
  @get
  @route("/routines/{routine_name}")
  @extension("x-ms-foundry-meta", RoutineRequiredPreviews)
  getRoutine is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.routines_v1_preview,
    GetRoutineParameters,
    Routine
  >;

  /** Enables the specified routine so it can be dispatched. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Enable a routine")
  @operationId("enableRoutine")
  @post
  @route("/routines/{routine_name}:enable")
  @extension("x-ms-foundry-meta", RoutineRequiredPreviews)
  enableRoutine is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.routines_v1_preview,
    EnableRoutineParameters,
    Routine
  >;

  /** Disables the specified routine so it no longer runs. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Disable a routine")
  @operationId("disableRoutine")
  @post
  @route("/routines/{routine_name}:disable")
  @extension("x-ms-foundry-meta", RoutineRequiredPreviews)
  disableRoutine is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.routines_v1_preview,
    DisableRoutineParameters,
    Routine
  >;

  /** Returns the routines available in the current project. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("List routines")
  @operationId("listRoutines")
  @get
  @list
  @route("/routines")
  @extension("x-ms-foundry-meta", RoutineRequiredPreviews)
  listRoutines is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.routines_v1_preview,
    ListRoutinesParameters,
    AgentsPagedResult<Routine>
  >;

  /** Deletes the specified routine. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Delete a routine")
  @operationId("deleteRoutine")
  @delete
  @route("/routines/{routine_name}")
  @extension("x-ms-foundry-meta", RoutineRequiredPreviews)
  deleteRoutine is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.routines_v1_preview,
    DeleteRoutineParameters,
    NoContentResponse
  >;

  /** Returns prior runs recorded for the specified routine. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("List prior runs for a routine")
  @operationId("listRoutineRuns")
  @get
  @list
  @route("/routines/{routine_name}/runs")
  @extension("x-ms-foundry-meta", RoutineRequiredPreviews)
  listRoutineRuns is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.routines_v1_preview,
    ListRoutineRunsParameters,
    AgentsPagedResult<RoutineRun>
  >;

  /** Queues an asynchronous dispatch for the specified routine. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @summary("Queue an asynchronous routine dispatch")
  @operationId("dispatchRoutineAsync")
  @post
  @route("/routines/{routine_name}:dispatch_async")
  @extension("x-ms-foundry-meta", RoutineRequiredPreviews)
  dispatchRoutineAsync is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.routines_v1_preview,
    DispatchRoutineAsyncParameters,
    DispatchRoutineResponse
  >;
}
