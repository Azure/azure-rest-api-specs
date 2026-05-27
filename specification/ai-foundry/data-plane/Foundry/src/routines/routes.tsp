import "../common/models.tsp";
import "../servicepatterns.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Azure.AI.Projects;

@tag("Routines")
interface Routines {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Creates or update a routine.")
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
  @doc("Retrieves a routine.")
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
  @doc("Enables a routine.")
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
  @doc("Disables a routine.")
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
  @doc("Lists routines.")
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

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Deletes a routine.")
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
  @doc("Lists prior runs for a routine.")
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

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "not yet an Azure operation"
  @doc("Queues an asynchronous routine dispatch.")
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
