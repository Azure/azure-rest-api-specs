import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Azure.AI.Projects;

@doc("Metadata pertaining to creation and last modification of the resource.")
model SystemData {
  @visibility(Lifecycle.Read)
  @doc("The timestamp the resource was created at.")
  createdAt?: utcDateTime;

  @visibility(Lifecycle.Read)
  @doc("The identity that created the resource.")
  createdBy?: string;

  @visibility(Lifecycle.Read)
  @doc("The identity type that created the resource.")
  createdByType?: string;

  @visibility(Lifecycle.Read)
  @doc("The timestamp of resource last modification (UTC)")
  lastModifiedAt?: utcDateTime;
}

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

@doc("Data Source for Application Insights.")
model ApplicationInsightsConfiguration extends InputData {
  @visibility(Lifecycle.Read)
  type: "app_insights";

  @doc("LogAnalytic Workspace resourceID associated with ApplicationInsights")
  resourceId: string;

  @doc("Query to fetch the data.")
  query: string;

  @doc("Service name.")
  serviceName?: string;

  @doc("Connection String to connect to ApplicationInsights.")
  connectionString?: string;
}

@doc("Dataset as source for evaluation.")
model Dataset extends InputData {
  @visibility(Lifecycle.Read)
  type: "dataset";

  @doc("Evaluation input data")
  id: string;
}

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Needed since suggestion is not supported to generate swagger in OpenAPIv2"
@doc("Abstract class for model configuration.")
@discriminator("type")
model TargetModelConfig {
  @doc("Type of the model configuration.")
  type: string;
}

@doc("Azure OpenAI model configuration. The API version would be selected by the service for querying the model.")
model AOAIModelConfig extends TargetModelConfig {
  @visibility(Lifecycle.Read)
  type: "AOAI";

  @doc("Endpoint targetURI for AOAI model.")
  azureEndpoint: string;

  @doc("API Key for AOAI model.")
  apiKey: string;

  @doc("Deployment name for AOAI model.")
  azureDeployment: string;
}

@doc("MaaS model configuration. The API version would be selected by the service for querying the model.")
model MAASModelConfig extends TargetModelConfig {
  @visibility(Lifecycle.Read)
  type: "MAAS";

  @doc("Endpoint targetURI for MAAS model.")
  azureEndpoint: string;

  @doc("API Key for MAAS model.")
  apiKey: string;
}

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Needed since suggestion is not supported to generate swagger in OpenAPIv2"
@doc("Target for the evaluation process.")
model EvaluationTarget {
  @doc("System message related to the evaluation target.")
  systemMessage: string;

  @doc("Model configuration for the evaluation.")
  modelConfig: TargetModelConfig;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "Needed since value type is not fixed"
  @doc("A dictionary of parameters for the model.")
  modelParams?: Record<unknown>;
}

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Needed since suggestion is not supported to generate swagger in OpenAPIv2"
@doc("Abstract data class for input data configuration.")
@discriminator("type")
model Trigger {
  @doc("Type of the trigger.")
  type: string;
}

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Needed since suggestion is not supported to generate swagger in OpenAPIv2"
@doc("Recurrence Trigger Definition")
model RecurrenceTrigger extends Trigger {
  @visibility(Lifecycle.Read)
  type: "Recurrence";

  @doc("The frequency to trigger schedule.")
  frequency: Frequency;

  @doc("Specifies schedule interval in conjunction with frequency")
  interval: int32;

  @doc("The recurrence schedule.")
  schedule?: RecurrenceSchedule;
}

#suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "Needed since suggestion is not supported to generate swagger in OpenAPIv2"
@doc("Cron Trigger Definition")
model CronTrigger extends Trigger {
  @visibility(Lifecycle.Read)
  type: "Cron";

  @doc("Cron expression for the trigger.")
  expression: string;
}

@doc("Evaluation Definition")
@resource("runs")
model Evaluation {
  @key("id")
  @visibility(Lifecycle.Read)
  @doc("Identifier of the evaluation.")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
  @maxLength(254)
  id: string;

  @doc("Data for evaluation.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  data: InputData;

  @doc("Evaluation target specifying the model config and parameters")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  target?: EvaluationTarget;

  @doc("Display Name for evaluation. It helps to find the evaluation easily in AI Foundry. It does not need to be unique.")
  displayName?: string;

  @doc("Description of the evaluation. It can be used to store additional information about the evaluation and is mutable.")
  description?: string;

  @doc("Metadata containing createdBy and modifiedBy information.")
  @visibility(Lifecycle.Read)
  systemData?: SystemData;

  @doc("Status of the evaluation. It is set by service and is read-only.")
  @visibility(Lifecycle.Read)
  status?: string;

  @doc("Evaluation's tags. Unlike properties, tags are fully mutable.")
  tags?: Record<string>;

  @doc("Evaluation's properties. Unlike tags, properties are add-only. Once added, a property cannot be removed.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  properties?: Record<string>;

  @doc("Evaluators to be used for the evaluation.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  evaluators: Record<EvaluatorConfiguration>;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Need to add documentation"
@doc("Frequency of the schedule - day, week, month, hour, minute")
union Frequency {
  Month: "Month",
  Week: "Week",
  Day: "Day",
  Hour: "Hour",
  Minute: "Minute",
  string,
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
  string,
}

@doc("RecurrenceSchedule Definition")
model RecurrenceSchedule {
  @doc("List of hours for the schedule.")
  hours: int32[];

  @doc("List of minutes for the schedule.")
  minutes: int32[];

  @doc("List of days for the schedule.")
  weekDays?: WeekDays[];

  @doc("List of month days for the schedule")
  monthDays?: int32[];
}

@doc("Evaluation Schedule Definition")
// NoteNote: I modeled ScheduledEvaluation as a type of Evaluation. But can also be modeled as a separate Schedule entity. We can discuss
@resource("schedules")
model EvaluationSchedule {
  @key("name")
  @visibility(Lifecycle.Read)
  @doc("Name of the schedule, which also serves as the unique identifier for the evaluation")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-_]*$")
  @maxLength(254)
  name: string;

  @doc("Data for evaluation.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  data: ApplicationInsightsConfiguration;

  @doc("Description of the evaluation. It can be used to store additional information about the evaluation and is mutable.")
  description?: string;

  @doc("Metadata containing createdBy and modifiedBy information.")
  @visibility(Lifecycle.Read)
  systemData?: SystemData;

  @doc("Provisioning State of the evaluation. It is set by service and is read-only.")
  @visibility(Lifecycle.Read)
  provisioningState?: string;

  @doc("Evaluation's tags. Unlike properties, tags are fully mutable.")
  tags?: Record<string>;

  @doc("Evaluation's properties. Unlike tags, properties are add-only. Once added, a property cannot be removed.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  properties?: Record<string>;

  @doc("Enabled status of the evaluation. It is set by service and is read-only.")
  @visibility(Lifecycle.Read)
  isEnabled?: string;

  @doc("Evaluators to be used for the evaluation.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  evaluators: Record<EvaluatorConfiguration>;

  @doc("Trigger for the evaluation.")
  trigger: Trigger;
}

// Define the response model with status code 201
// Needed since run is Operations.ResourceCollectionAction<Evaluation, {}, Evaluation>; returns 200 status code
@doc("Response model for create evaluation")
model CreatedEvaluationResponse {
  @doc("HTTP status code")
  @statusCode
  status: 201;

  @body
  @doc("Evaluation created")
  evaluation: Evaluation;
}
