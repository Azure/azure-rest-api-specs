import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core.Traits;

namespace Azure.AI.Projects;

alias ScheduleServiceTraits = SupportsClientRequestId &
  NoRepeatableRequests &
  NoConditionalRequests; // NoRetryRequests suppresses @azure-tools/typespec-azure-core/conditional-requests-trait-missing

alias ScheduleOperations = Azure.Core.ResourceOperations<ScheduleServiceTraits>;
alias ScheduleRunOperations = Azure.Core.ResourceOperations<ScheduleServiceTraits>;
alias SchedulesFilterQueryParamsTraits = {
  @query("type")
  @doc("Filter by the type of schedule.")
  type?: ScheduleTaskType;

  @query("enabled")
  @doc("Filter by the enabled status.")
  enabled?: boolean;
};

@added(Versions.v2025_11_15_preview)
@removed(Versions.v1)
interface Schedules {
  @doc("Delete a schedule.")
  delete is ScheduleOperations.ResourceDelete<Schedule>;

  @doc("Get a schedule by id.")
  get is ScheduleOperations.ResourceRead<Schedule>;

  @doc("List all schedules.")
  list is ScheduleOperations.ResourceList<
    Schedule,
    SchedulesFilterQueryParamsTraits
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Create or update a schedule by id.")
  @Http.put
  createOrUpdate is Azure.Core.Foundations.ResourceOperation<
    Schedule,
    {
      @doc("Schedule resource")
      @Http.bodyRoot
      Schedule: Schedule;
    },
    Azure.Core.Foundations.ResourceCreatedOrOkResponse<Schedule>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Get a schedule run by id.")
  @route("schedules/{scheduleId}/runs/{runId}")
  getRun is Azure.Core.Foundations.Operation<
    {
      @doc("Identifier of the schedule.")
      @path
      scheduleId: string;

      @doc("Identifier of the schedule run.")
      @path
      runId: string;
    },
    OkResponse<ScheduleRun>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("List all schedule runs.")
  @route("schedules/{scheduleId}/runs")
  listRuns is Azure.Core.Foundations.Operation<
    {
      @doc("Identifier of the schedule.")
      @path
      scheduleId: string;
    },
    Azure.Core.Page<ScheduleRun>
  >;
}
