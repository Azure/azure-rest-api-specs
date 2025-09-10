import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.Monitor;

@doc("Represents an SLI resource within the ProviderHub.")
model Sli is ProxyResource<SliResource> {
  @doc("Name of the SLI that is given by the user.")
  @pattern("^[a-zA-Z0-9-_()~]{3,64}$")
  @key("sliName")
  @segment("slis")
  @path
  name: string;

  ...ManagedServiceIdentityProperty;
}

@doc("Defines the root level properties of an SLI resource.")
model SliResource {
  @visibility(Lifecycle.Read)
  @doc("Indicates the provisioning status of the last operation.")
  provisioningState?: ProvisioningState;

  @doc("A user-provided description of the SLI, with a maximum length of 1000 characters.")
  @pattern("^.{3,1000}$")
  description: string;

  @doc("Specifies the category of the SLI, used to classify signals such as Availability and Latency.")
  category: Category;

  @doc("Determines how the SLI is evaluated—either based on request counts or time windows.")
  evaluationType: EvaluationType;

  @visibility(Lifecycle.Read)
  @doc("Indicates the current execution status of the SLI resource in ARM responses.")
  executionState: ExecutionState;

  @doc("Destination AMW accounts.")
  @OpenAPI.extension("x-ms-identifiers", #["resourceId"])
  destinationAmwAccounts: AmwAccount[];

  @visibility(Lifecycle.Read)
  @doc("The destination Azure Monitor Workspace (AMW) accounts where the SLI emits metrics.")
  @OpenAPI.extension("x-ms-identifiers", #["metricNamespace", "metricName"])
  destinationMetrics: Metric[];

  @doc("Defines the SLO baseline associated with the SLI.")
  baselineProperties: BaselineProperties;

  @visibility(Lifecycle.Read)
  @doc("The streaming rule Id associated with the Sli resource.")
  streamingRuleId: string;

  @visibility(Lifecycle.Read)
  @doc("The streaming rule last updated timestamp associated with the Sli resource.")
  streamingRuleLastUpdatedTimestamp: string;

  @doc("A flag to determine whether alert is enabled.")
  enableAlert: boolean;

  @doc("Defines the SLI properties associated with the SLI.")
  sliProperties: SliProperties;
}

@doc("Represents the current execution state of an SLI.")
model ExecutionState {
  @doc("The execution state value.")
  state: string;

  @doc("A descriptive message related to the execution state.")
  message?: string;
}

@doc("Represents an Azure Monitor Workspace (AMW) account used for emitting metrics.")
model AmwAccount {
  @doc("The ARM resource ID of the account where metrics are emitted.")
  resourceId: string;

  @doc("The ARM resource ID of the managed identity with access to the source account.")
  identity: string;
}

@doc("Defines a metric in the destination AMW account.")
model Metric {
  @doc("The namespace of the metric.")
  metricNamespace: string;

  @doc("The name of the metric.")
  metricName: string;
}

@doc("Defines the category of an SLI")
union Category {
  @doc("Indicates availability-related metrics.")
  "Availability",

  @doc("Indicates latency-related metrics.")
  "Latency",

  string,
}

@doc("Specifies how the SLI is evaluated.")
union EvaluationType {
  @doc("Evaluates SLI based on time windows.")
  "WindowBased",

  @doc("Evaluates SLI based on request counts.")
  "RequestBased",

  string,
}

@doc("Represents the provisioning state of the SLI resource.")
@Azure.Core.lroStatus
union ProvisioningState {
  ResourceProvisioningState,
}
alias ServiceGroupRoute = "/providers/Microsoft.Management/serviceGroups";

@doc("ServiceGroup as parameter")
model ServiceGroupBaseParameters {
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @doc("The name of the service group.")
  serviceGroupName: string;
}

@doc("ServiceGroup as parameter")
model ServiceGroupParameters is ServiceGroupBaseParameters {
  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter;
}

@doc("Defines operations for managing SLI resources.")
@armResourceOperations(Sli)
interface Slis {
  @doc("Gets an SLI resource.")
  @route(ServiceGroupRoute)
  get is ArmResourceRead<Sli, ServiceGroupParameters>;

  @doc("Creates or updates an SLI resource.")
  @route(ServiceGroupRoute)
  createOrUpdate is ArmResourceCreateOrReplaceSync<Sli, ServiceGroupParameters>;

  @doc("Deletes an SLI resource.")
  @route(ServiceGroupRoute)
  delete is ArmResourceDeleteSync<Sli, ServiceGroupParameters>;

  @doc("Lists all SLI resources under a parent resource.")
  @route(ServiceGroupRoute)
  listByParent is ArmResourceListByParent<Sli, ServiceGroupParameters>;

  /**
  POST Actions
  */
  @route(ServiceGroupRoute)
  @armResourceAction(Sli)
  @post
  @doc("Returns preview data for the signal.")
  signalPreview is ArmResourceActionSync<
    Sli,
    Signal,
    void,
    ServiceGroupParameters
  >;
}
