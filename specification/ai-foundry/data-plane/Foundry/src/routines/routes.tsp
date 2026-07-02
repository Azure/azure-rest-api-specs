import "../common/models.tsp";
import "../servicepatterns.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

@tag("Routines")
interface Routines {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Create or update a routine.")
  @operationId("createOrUpdateRoutine")
  @put
  @route("/routines/{routine_name}")
  @extension("x-ms-foundry-meta", RoutineRequiredPreviews)
  createOrUpdateRoutine is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.routines_v1_preview,
    CreateOrUpdateRoutineParameters,
    Routine
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Retrieve a routine.")
  @operationId("getRoutine")
  @get
  @route("/routines/{routine_name}")
  @extension("x-ms-foundry-meta", RoutineRequiredPreviews)
  getRoutine is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.routines_v1_preview,
    GetRoutineParameters,
    Routine
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Enable a routine.")
  @operationId("enableRoutine")
  @post
  @route("/routines/{routine_name}:enable")
  @extension("x-ms-foundry-meta", RoutineRequiredPreviews)
  enableRoutine is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.routines_v1_preview,
    EnableRoutineParameters,
    Routine
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Disable a routine.")
  @operationId("disableRoutine")
  @post
  @route("/routines/{routine_name}:disable")
  @extension("x-ms-foundry-meta", RoutineRequiredPreviews)
  disableRoutine is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.routines_v1_preview,
    DisableRoutineParameters,
    Routine
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("List routines.")
  @operationId("listRoutines")
  @get
  @list
  @route("/routines")
  @extension("x-ms-foundry-meta", RoutineRequiredPreviews)
  listRoutines is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.routines_v1_preview,
    ListRoutinesParameters,
    RoutineListResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Delete a routine.")
  @operationId("deleteRoutine")
  @delete
  @route("/routines/{routine_name}")
  @extension("x-ms-foundry-meta", RoutineRequiredPreviews)
  deleteRoutine is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.routines_v1_preview,
    DeleteRoutineParameters,
    NoContentResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("List prior runs for a routine.")
  @operationId("listRoutineRuns")
  @get
  @list
  @route("/routines/{routine_name}/runs")
  @extension("x-ms-foundry-meta", RoutineRequiredPreviews)
  listRoutineRuns is FoundryDataPlanePreviewOperation<
    FoundryFeaturesOptInKeys.routines_v1_preview,
    ListRoutineRunsParameters,
    RoutineRunsResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Queue an asynchronous routine dispatch.")
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
