import "./models.tsp";

using TypeSpec.Http;

namespace Azure.AI.Projects;

alias SchedulesPreviewHeader = WithRequiredFoundryPreviewHeader<FoundryFeaturesOptInKeys.schedules_v1_preview>;

alias SchedulesFilterQueryParams = {
  @query("type")
  @doc("Filter by the type of schedule.")
  type?: ScheduleTaskType;

  @query("enabled")
  @doc("Filter by the enabled status.")
  enabled?: boolean;
};

alias SchedulesCreateOrUpdateParams = {
  ...SchedulesPreviewHeader;

  @doc("The resource instance.")
  @Http.bodyRoot
  @TypeSpec.OpenAPI.extension("x-ms-client-name", "resource")
  resource: Schedule;
};

@tag("Schedules")
interface Schedules {
  /** Deletes the specified schedule resource. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We need explicit definition for header support"
  @summary("Delete a schedule")
  @Http.delete
  delete is FoundryResourceOperation<
    Schedule,
    {
      ...SchedulesPreviewHeader;
    },
    Http.NoContentResponse
  >;

  /** Retrieves the specified schedule resource. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We need explicit definition for header support"
  @summary("Get a schedule")
  get is FoundryResourceOperation<
    Schedule,
    {
      ...SchedulesPreviewHeader;
    },
    Azure.Core.Foundations.ResourceOkResponse<Schedule>
  >;

  /** Returns schedules that match the supplied type and enabled filters. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We need explicit definition for header support"
  @summary("List schedules")
  @Rest.listsResource(Schedule)
  list is FoundryResourceList<
    Schedule,
    SchedulesFilterQueryParams & SchedulesPreviewHeader,
    Azure.Core.Page<Schedule>
  >;

  /** Creates a new schedule or updates an existing schedule with the supplied definition. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We need explicit definition for header support"
  @summary("Create or update a schedule")
  @Http.put
  createOrUpdate is FoundryResourceOperation<
    Schedule,
    SchedulesCreateOrUpdateParams,
    Azure.Core.Foundations.ResourceCreatedOrOkResponse<Schedule>
  >;

  /** Retrieves the specified run for a schedule. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @summary("Get a schedule run")
  @route("schedules/{schedule_id}/runs/{run_id}")
  @get
  getRun is FoundryDataPlaneOperation<
    {
      @path
      @doc("The unique identifier of the schedule.")
      schedule_id: string;

      @path
      @doc("The unique identifier of the schedule run.")
      run_id: string;

      ...SchedulesPreviewHeader;
    },
    OkResponse & ScheduleRun
  >;

  /** Returns schedule runs that match the supplied filters. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We need explicit definition for header support"
  @summary("List schedule runs")
  @Rest.listsResource(ScheduleRun)
  listRuns is FoundryResourceList<
    ScheduleRun,
    SchedulesFilterQueryParams & SchedulesPreviewHeader,
    Azure.Core.Page<ScheduleRun>
  >;
}
