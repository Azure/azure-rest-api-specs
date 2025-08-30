import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core.Traits;

namespace Azure.AI.Projects;

alias ScheduleServiceTraits = SupportsClientRequestId &
  NoRepeatableRequests &
  NoConditionalRequests; // NoRetryRequests suppresses @azure-tools/typespec-azure-core/conditional-requests-trait-missing

alias ScheduleOperations = Azure.Core.ResourceOperations<ScheduleServiceTraits>;

@added(Versions.v2025_07_31_preview)
@removed(Versions.v1)
interface Schedules {
  @doc("Delete a schedule.")
  delete is ScheduleOperations.ResourceDelete<Schedule>;

  @doc("Get a schedule by id.")
  get is ScheduleOperations.ResourceRead<Schedule>;

  @doc("List all schedules.")
  list is ScheduleOperations.ResourceList<Schedule>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Creates a schedule run.")
  @put
  createOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("Schedule resource")
      @body
      Schedule: Schedule;
    },
    ResourceCreatedResponse<Schedule>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Creates a schedule run event.")
  @post
  @route("schedules/{scheduleId}/runEvent")
  createRunEvent is Azure.Core.Foundations.Operation<
    {
      @doc("Identifier of the schedule.")
      @path
      scheduleId: string;

      @doc("Schedule run event")
      @body
      ScheduleEvent: ScheduleRunEvent;
    },
    Http.Response<204>
  >;
}
