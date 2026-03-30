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
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We need explicit definition for header support"
  @doc("Delete a schedule.")
  @Http.delete
  delete is Azure.Core.Foundations.ResourceOperation<
    Schedule,
    {
      ...SchedulesPreviewHeader;
    },
    Http.NoContentResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We need explicit definition for header support"
  @doc("Get a schedule by id.")
  get is Azure.Core.Foundations.ResourceOperation<
    Schedule,
    {
      ...SchedulesPreviewHeader;
    },
    Azure.Core.Foundations.ResourceOkResponse<Schedule>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We need explicit definition for header support"
  @doc("List all schedules.")
  @Rest.listsResource(Schedule)
  list is Azure.Core.Foundations.ResourceList<
    Schedule,
    SchedulesFilterQueryParams & SchedulesPreviewHeader,
    Azure.Core.Page<Schedule>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We need explicit definition for header support"
  @doc("Create or update operation template.")
  @Http.put
  createOrUpdate is Azure.Core.Foundations.ResourceOperation<
    Schedule,
    SchedulesCreateOrUpdateParams,
    Azure.Core.Foundations.ResourceCreatedOrOkResponse<Schedule>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Get a schedule run by id.")
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
    OkResponse<ScheduleRun>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "We need explicit definition for header support"
  @doc("List all schedule runs.")
  @Rest.listsResource(ScheduleRun)
  listRuns is Azure.Core.Foundations.ResourceList<
    ScheduleRun,
    SchedulesFilterQueryParams & SchedulesPreviewHeader,
    Azure.Core.Page<ScheduleRun>
  >;
}
