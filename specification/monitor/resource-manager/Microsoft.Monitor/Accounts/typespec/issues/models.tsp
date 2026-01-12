import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";

using Azure.Core;
using Azure.ClientGenerator.Core;

#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations API is defined in a separate spec for Microsoft.Monitor namespace (specification/monitor/resource-manager/Microsoft.Monitor/Operations)"
namespace Microsoft.Monitor;

@doc("The type of entity that added data to the issue")
union AddedByType {
  @doc("The data was added manually by a user")
  Manual: "Manual",

  @doc("The data was added automatically")
  Automatic: "Automatic",

  string,
}

@doc("Details about the origin of the entity - the source that added it to the issue")
model Origin {
  @doc("The ID of the origin - for example, in case of 'Manual', the user ID/app ID, and in case of 'Automatic', the name of the automatic system")
  addedBy: string;

  @doc("The source of the origin - Manual or Automatic")
  addedByType: AddedByType;
}

@doc("The relevance status of the resource")
union Relevance {
  @doc("No relevance status for the resource")
  None: "None",

  @doc("The resource is relevant to the issue")
  Relevant: "Relevant",

  @doc("The resource is irrelevant to the issue")
  Irrelevant: "Irrelevant",

  string,
}

@doc("The execution state of the investigation")
union InvestigationExecutionRunState {
  @doc("The investigation execution didn't start")
  None: "None",

  @doc("The investigation execution is in progress")
  InProgress: "InProgress",

  @doc("The investigation execution completed successfully")
  Succeeded: "Succeeded",

  @doc("The investigation execution failed")
  Failed: "Failed",

  @doc("The investigation execution was canceled")
  Canceled: "Canceled",

  string,
}

@doc("Details about the execution of the investigation")
model InvestigationExecution {
  @doc("The state of the investigation execution")
  runState: InvestigationExecutionRunState;

  @doc("The time at which the investigation execution completed (in UTC)")
  completedAt?: utcDateTime;
}

@doc("A single scope of the investigation")
model InvestigationScope {
  @doc("The ID of the scope of the investigation - either an Azure alert ID or an Azure resource ID")
  id: armResourceIdentifier;

  @doc("The origin of the scope")
  origin: Origin;

  @doc("The relevance of the scope")
  relevance?: Relevance;
}

@doc("Parameters provided to start an investigation operation")
model StartInvestigationParameters {
  @doc("The impact time to use for this investigation - by default, the impact time from the issue is used (in UTC)")
  impactTime?: utcDateTime;

  @doc("The scope of the investigation (resources and alerts) - by default, the resources and alerts related to the issue are used. Note: this property is currently a placeholder and is not in use.")
  investigationScopes: InvestigationScope[];
}

@doc("Details about the investigation result")
model InvestigationResult {
  @doc("The identifier of the investigation")
  id: string;

  @doc("The origin of the investigation")
  origin: Origin;

  @doc("The creation time of the investigation (in UTC)")
  createdAt: utcDateTime;

  @doc("The last update time of the investigation (in UTC)")
  lastModifiedAt: utcDateTime;

  @doc("The execution details of the investigation")
  execution: InvestigationExecution;

  @doc("The parameters used to run the investigation")
  runParameters: RunParameters;

  @doc("The result of this investigation")
  result: string;
}

@@clientName(RunParameters, "RunParametersContent", "csharp");
@doc("The parameters used to run the investigation")
model RunParameters {
  @doc("The impact time to investigate (in UTC)")
  impactTime: utcDateTime;

  @doc("The alerts used to run the investigation")
  alerts: InvestigationScope[];

  @doc("The resources used to run the investigation")
  resources: InvestigationScope[];
}

@doc("Properties of the current investigation")
model InvestigationMetadata {
  @doc("The unique identifier of the investigation")
  id: uuid;

  @doc("The execution details of the investigation")
  execution: InvestigationExecution;

  @doc("The creation time of the investigation (in UTC)")
  createdAt: utcDateTime;

  @doc("The parameters that were used to start the investigation")
  runParameters: RunParameters;
}

@doc("Parameters provided to get the investigation result")
model FetchInvestigationResultParameters {
  @doc("The unique identifier of the investigation")
  investigationId: uuid;
}

@doc("The issue status")
union Status {
  @doc("The issue is new")
  New: "New",

  @doc("The issue is in progress")
  InProgress: "InProgress",

  @doc("The issue is mitigated")
  Mitigated: "Mitigated",

  @doc("The issue is closed")
  Closed: "Closed",

  @doc("The issue is canceled")
  Canceled: "Canceled",

  string,
}

@doc("The issue properties")
model IssuePayload {
  @doc("The issue title")
  title: string;

  @doc("The issue status")
  status: Status;

  @doc("The issue severity")
  severity: string;

  @visibility(Lifecycle.Read)
  @doc("The list of investigations in the issue")
  investigations: InvestigationMetadata[];

  @doc("The issue impact time (in UTC)")
  impactTime: utcDateTime;

  @visibility(Lifecycle.Read)
  @doc("The number of investigations in the issue")
  investigationsCount: int32;
}

@doc("Properties of an alert which is related to the issue")
model RelatedAlert {
  @doc("The alert ID")
  id: armResourceIdentifier;

  @doc("The alerts's relevance status")
  relevance: Relevance;

  @visibility(Lifecycle.Read)
  @doc("The source that related the alert to the issue")
  origin: Origin;

  @visibility(Lifecycle.Read)
  @doc("The time this relation was added to the issue (in UTC)")
  addedAt: utcDateTime;

  @visibility(Lifecycle.Read)
  @doc("The last update time of this relation (in UTC)")
  lastModifiedAt: utcDateTime;
}

@doc("A list of related alerts")
model RelatedAlerts {
  @doc("A list of related alerts")
  value: RelatedAlert[];
}

@doc("Properties of a resource which is related to the issue")
model RelatedResource {
  @doc("The resource ID")
  id: armResourceIdentifier;

  @doc("The resource's relevance status")
  relevance: Relevance;

  @visibility(Lifecycle.Read)
  @doc("The source that related the resource to the issue")
  origin: Origin;

  @visibility(Lifecycle.Read)
  @doc("The time this relation was added to the issue (in UTC)")
  addedAt: utcDateTime;

  @visibility(Lifecycle.Read)
  @doc("The last update time of this relation (in UTC)")
  lastModifiedAt: utcDateTime;
}

@doc("A list of related resources")
model RelatedResources {
  @doc("A list of related resources")
  value: RelatedResource[];
}

@@clientName(ListParameter, "ListParameterContent", "csharp");
@doc("Parameters for listing related entities")
model ListParameter {
  @doc("The filter to apply on the operation. For example, to filter by relevance, use \"$filter=relevance eq 'Relevant'\". Note: this property is currently a placeholder and is not in use.")
  filter?: string;
}
