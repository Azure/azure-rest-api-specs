import "./models.tsp";

using TypeSpec.Http;
using Azure.Core.Traits;

namespace Azure.AI.Projects;

alias ScheduleServiceTraits = SupportsClientRequestId &
  NoRepeatableRequests &
  NoConditionalRequests; // NoRetryRequests suppresses @azure-tools/typespec-azure-core/conditional-requests-trait-missing

alias ScheduleRunOperations = Azure.Core.ResourceOperations<ScheduleServiceTraits>;
alias SchedulesFilterQueryParams = {
  @query("type")
  @doc("Filter by the type of schedule.")
  type?: ScheduleTaskType;

  @query("enabled")
  @doc("Filter by the enabled status.")
  enabled?: boolean;
};

alias ScheduleOps = FoundryAzureOperations<WithRequiredFoundryPreviewHeader<FoundryFeaturesOptInKeys.schedules_v1_preview>>;

@tag("Schedules")
interface Schedules {

  // BUG: This operation (see OpenAPI3 file) is missing the "Foundry-Features" header.
  @doc("Delete a schedule.")
  delete is ScheduleOps.ResourceDelete<Schedule>;

  // BUG: This operation (see OpenAPI3 file) is missing the "Foundry-Features" header.
  @doc("Get a schedule by id.")
  get is ScheduleOps.ResourceRead<Schedule>;

  // BUG: This operation (see OpenAPI3 file) is missing the "Foundry-Features" header.
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("List all schedules.")
  list is ScheduleOps.ResourceList<Schedule, SchedulesFilterQueryParams>;

  // BUG: This operation (see OpenAPI3 file) is missing the "Foundry-Features" header.
  #suppress "@azure-tools/typespec-azure-core/verb-conflict" ""
  @put
  createOrUpdate is ScheduleOps.ResourceCreateOrUpdate<Schedule>;

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

      ...WithRequiredFoundryPreviewHeader<FoundryFeaturesOptInKeys.schedules_v1_preview>;
    },
    OkResponse<ScheduleRun>
  >;

  // BUG: This operation (see OpenAPI3 file) is missing the "Foundry-Features" header.
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("List all schedule runs.")
  listRuns is ScheduleRunOperations.ResourceList<
    ScheduleRun,
    SchedulesFilterQueryParams &
      WithRequiredFoundryPreviewHeader<FoundryFeaturesOptInKeys.schedules_v1_preview>
  >;
}
