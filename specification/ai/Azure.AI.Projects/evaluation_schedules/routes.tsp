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

@added(Versions.v2025_07_31_preview)
interface EvaluationSchedules {
  @doc("Delete a schedule.")
  delete is ScheduleOperations.ResourceDelete<EvaluationSchedule>;

  @doc("Get a schedule by id.")
  get is ScheduleOperations.ResourceRead<EvaluationSchedule>;

  @doc("List all schedules.")
  list is ScheduleOperations.ResourceList<EvaluationSchedule>;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Create or update a schedule by id.")
  @Http.put
  createOrUpdate is Azure.Core.Foundations.ResourceOperation<
    EvaluationSchedule,
    {
      @doc("Schedule resource")
      @Http.bodyRoot
      Schedule: EvaluationSchedule;
    },
    Azure.Core.Foundations.ResourceCreatedOrOkResponse<EvaluationSchedule>
  >;

  #suppress "@azure-tools/typespec-azure-core/use-standard-operations"
  @doc("Get a schedule run by id.")
  @route("evaluation_schedules/{scheduleId}/runs/{runId}")
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

  @doc("Creates a schedule run event.")
  @post
  @Rest.actionSeparator("/")
  @Rest.action("runEvent")
  createRunEvent is ScheduleOperations.ResourceAction<
    EvaluationSchedule,
    {
      @doc("Schedule run event")
      @body
      ScheduleEvent: EvaluationScheduleRunEvent;
    },
    Http.NoContentResponse
  >;
}
