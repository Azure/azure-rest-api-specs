import "../common/models.tsp";
import "../servicepatterns.tsp";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;

namespace Azure.AI.Projects;

alias RoutinesPreviewHeader = WithRequiredFoundryPreviewHeader<FoundryFeaturesOptInKeys.routines_v1_preview>;

@tag("Routines")
interface Routines {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We need explicit definition for header support"
  @doc("Create or update a routine.")
  @Http.put
  createOrUpdate is Azure.Core.Foundations.ResourceOperation<
    Routine,
    {
      ...RoutinesPreviewHeader;

      @doc("The routine to create or update.")
      @Http.bodyRoot
      @TypeSpec.OpenAPI.extension("x-ms-client-name", "resource")
      resource: Routine;
    },
    Azure.Core.Foundations.ResourceCreatedOrOkResponse<Routine>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We need explicit definition for header support"
  @doc("Get a routine by name.")
  get is Azure.Core.Foundations.ResourceOperation<
    Routine,
    {
      ...RoutinesPreviewHeader;
    },
    Azure.Core.Foundations.ResourceOkResponse<Routine>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We need explicit definition for header support"
  @doc("List all routines.")
  @Rest.listsResource(Routine)
  list is Azure.Core.Foundations.ResourceList<
    Routine,
    {
      @query("continuationToken")
      @doc("Continuation token from a previous list response.")
      continuationToken?: string;
    } & RoutinesPreviewHeader,
    Azure.Core.Page<Routine>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We need explicit definition for header support"
  @doc("Delete a routine.")
  @Http.delete
  delete is Azure.Core.Foundations.ResourceOperation<
    Routine,
    {
      ...RoutinesPreviewHeader;
    },
    Http.NoContentResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We need explicit definition for header support"
  @doc("Synchronously dispatch a routine. Returns after the downstream action completes.")
  @route("routines/{routine_name}:dispatch")
  @post
  dispatch is FoundryDataPlaneOperation<
    {
      @path
      @doc("The name of the routine to dispatch.")
      routine_name: string;

      ...RoutinesPreviewHeader;

      @Http.bodyRoot
      @doc("Optional dispatch request payload.")
      body?: DispatchRoutineRequest;
    },
    DispatchRoutineResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We need explicit definition for header support"
  @doc("Asynchronously dispatch a routine. Returns immediately after enqueueing the action.")
  @route("routines/{routine_name}:dispatchAsync")
  @post
  dispatchAsync is FoundryDataPlaneOperation<
    {
      @path
      @doc("The name of the routine to dispatch.")
      routine_name: string;

      ...RoutinesPreviewHeader;

      @Http.bodyRoot
      @doc("Dispatch request payload.")
      body: DispatchRoutineRequest;
    },
    DispatchRoutineResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We need explicit definition for header support"
  @doc("List execution history for a routine.")
  @route("routines/{routine_name}/runs")
  @get
  listRuns is FoundryDataPlaneOperation<
    {
      @path
      @doc("The name of the routine.")
      routine_name: string;

      @query("filter")
      @doc("OData-style filter expression.")
      filter?: string;

      @query(#{ name: "orderBy", explode: true })
      @doc("One or more ordering expressions.")
      orderBy?: string[];

      @query("maxResults")
      @doc("Maximum number of results to return per page.")
      maxResults?: int32;

      @query("pageToken")
      @doc("Continuation token from a previous list response.")
      pageToken?: string;

      ...RoutinesPreviewHeader;
    },
    RoutineRunsResponse
  >;
}
