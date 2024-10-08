import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "../common.tsp";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Azure.AI.Client.Evaluations;

@doc("Evaluator Configuration")
model EvaluatorConfiguration {
  @doc("Identifier of the evaluator.")
  id: string;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "https://github.com/Azure/typespec-azure/issues/1217"
  @doc("Initialization parameters of the evaluator.")
  initParams?: Record<unknown>;

  @doc("Data parameters of the evaluator.")
  dataMapping?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Needed since suggestion is not supported to generate swagger in OpenAPIv2"
@doc("Abstract data class for input data configuration.")
@discriminator("type")
model InputData {
  @doc("Type of the data.")
  type: string;
}

@doc("Data Source for Application Insight.")
model AppInsightsConfiguration extends InputData {
  @visibility("read")
  type: "app_insights";

  @doc("LogAnalytic Workspace resourceID associated with AppInsights")
  resourceId: string;

  @doc("Query to fetch the data.")
  query: string;

  @doc("Service name.")
  serviceName: string
}

@doc("Dataset as source for evaluation.")
model Dataset extends InputData {
  @visibility("read")
  type: "dataset";

  @doc("Evaluation input data")
  @encodedName("application/json", "Uri")
  id: string;
}

@doc("Evaluation Definition")
model Evaluation {
  @doc("Identifier of the evaluation.")
  id?: string;

  @doc("Data for evaluation.")
  data: InputData;

  @doc("Display Name for evaluation. It helps to find evaluation easily in AI Studio. It does not need to be unique.")
  displayName?: string;

  @doc("Description of the evaluation. It can be used to store additional information about the evaluation and is mutable.")
  description?: string;

  @doc("Metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;

  @doc("Status of the evaluation. It is set by service and is read-only.")
  @visibility("read")
  status?: string;

  @doc("Evaluation's tags. Unlike properties, tags are fully mutable.")
  tags?: Record<string>;

  @doc("Evaluation's properties. Unlike tags, properties are add-only. Once added, a property cannot be removed.")
  properties?: Record<string>;

  @doc("Evaluators to be used for the evaluation.")
  evaluators: Record<EvaluatorConfiguration>;
}

@doc("Paged evaluation items")
@pagedResult
model PagedEvaluation {
  @doc("The list of Evaluations.")
  @extension("x-ms-identifiers", [])
  @items
  value: Evaluation[];

  @doc("The link to the next page of items")
  @nextLink
  nextLink?: ResourceLocation<Evaluation>;
}

@doc("Update Evaluation Request")
model UpdateEvaluationRequest {
  // Tags do we addition or overwrite?
  @doc("Tags to be updated.")
  tags: Record<string>;

  @doc("Display Name")
  displayName: string;

  @doc("Description")
  description: string;
}

#suppress "@azure-tools/typespec-providerhub/no-inline-model" "Need to create reponses correctly"
alias ResourceCreatedResponse<T extends TypeSpec.Reflection.Model> = TypeSpec.Http.Response<201> &
  T;

#suppress "@azure-tools/typespec-providerhub/no-inline-model" "Need to create reponses correctly"
alias OkResponse<T extends TypeSpec.Reflection.Model> = TypeSpec.Http.Response<200> &
  T;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "Need to add documentation"
@doc("Frequency of the schedule - day, week, month, hour, minute")
union Frequency {
    Month: "Month",
    Week:  "Week",
    Day: "Day",
    Hour: "Hour",
    Minute: "Minute",
    string
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Need to add documentation"
@doc("WeekDay of the schedule - Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday")
union WeekDays {
    Monday: "Monday",
    Tuesday: "Tuesday",
    Wednesday: "Wednesday",
    Thursday: "Thursday",
    Friday: "Friday",
    Saturday: "Saturday",
    Sunday: "Sunday",
    string
}

@doc("Recurrence Definition")
model Recurrence {
    @doc("The frequency to trigger schedule.")
    frequency: Frequency;

    @doc("Specifies schedule interval in conjunction with frequency")
    interval: int32;

    @doc("The recurrence schedule.")
    schedule: RecurrenceSchedule;
}

@doc("RecurrenceSchedule Definition")
model RecurrenceSchedule {
    @doc("List of hours for the schedule.")
    hours: int32[];

    @doc("List of minutes for the schedule.")
    minutes: int32[];

    @doc("List of days for the schedule.")
    weekDays: WeekDays[];

    @doc("List of month days for the schedule")
    monthDays: int32[];
}

@doc("SamplingStrategy Definition")
model SamplingStrategy {
    @doc("Sampling rate")
    rate: float32;
}

@doc("Evaluation Schedule Definition")
model EvaluationSchedule {
  ...Evaluation;

  @doc("Recurrence pattern for the evaluation.")
  recurrence?: Recurrence;

  @doc ("Cron expression for the evaluation.")
  cronExpression?: string;

  @doc("Sampling strategy for the evaluation.")
  samplingStrategy: SamplingStrategy;
}

@doc("Paged evaluation schedule items")
@pagedResult
model PagedEvaluationSchedule {
  @doc("The list of Evaluation Schedules.")
  @extension("x-ms-identifiers", [])
  @items
  value: EvaluationSchedule[];

  @doc("The link to the next page of items")
  @nextLink
  nextLink?: ResourceLocation<EvaluationSchedule>;
}