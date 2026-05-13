import "../common/models.tsp";
import "../servicepatterns.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

alias RoutinesPreviewHeader = WithRequiredFoundryPreviewHeader<FoundryFeaturesOptInKeys.routines_v1_preview>;

@tag("Routines")
interface Routines {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Create or update a routine.")
  @operationId("createOrUpdateRoutine")
  @put
  @route("/routines/{routineName}")
  @extension("x-ms-foundry-meta", RoutineRequiredPreviews)
  createOrUpdateRoutine is FoundryDataPlaneOperation<
    CreateOrUpdateRoutineParameters & RoutinesPreviewHeader,
    Routine
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Retrieve a routine.")
  @operationId("getRoutine")
  @get
  @route("/routines/{routineName}")
  @extension("x-ms-foundry-meta", RoutineRequiredPreviews)
  getRoutine is FoundryDataPlaneOperation<
    GetRoutineParameters & RoutinesPreviewHeader,
    Routine
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("List routines.")
  @operationId("listRoutines")
  @get
  @route("/routines")
  @extension("x-ms-foundry-meta", RoutineRequiredPreviews)
  listRoutines is FoundryDataPlaneOperation<
    ListRoutinesParameters & RoutinesPreviewHeader,
    RoutineListResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Delete a routine.")
  @operationId("deleteRoutine")
  @delete
  @route("/routines/{routineName}")
  @extension("x-ms-foundry-meta", RoutineRequiredPreviews)
  deleteRoutine is FoundryDataPlaneOperation<
    DeleteRoutineParameters & RoutinesPreviewHeader,
    NoContentResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("List prior runs for a routine.")
  @operationId("listRoutineRuns")
  @get
  @route("/routines/{routineName}/runs")
  @extension("x-ms-foundry-meta", RoutineRequiredPreviews)
  listRoutineRuns is FoundryDataPlaneOperation<
    ListRoutineRunsParameters & RoutinesPreviewHeader,
    RoutineRunsResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Queue an asynchronous routine dispatch.")
  @operationId("dispatchRoutineAsync")
  @post
  @route("/routines/{routineName}:dispatchAsync")
  @extension("x-ms-foundry-meta", RoutineRequiredPreviews)
  dispatchRoutineAsync is FoundryDataPlaneOperation<
    DispatchRoutineAsyncParameters & RoutinesPreviewHeader,
    DispatchRoutineResponse
  >;
}
