import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Automanage;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Automanage configuration profile properties.")
model ConfigurationProfileProperties {
  @doc("configuration dictionary of the configuration profile.")
  configuration?: Record<unknown>;
}

@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model Resource {
  @doc("Fully qualified resource ID for the resource. Ex - /subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}")
  @visibility("read")
  id?: string;

  @doc("The name of the resource")
  @visibility("read")
  name?: string;

  @doc("The type of the resource. E.g. \"Microsoft.Compute/virtualMachines\" or \"Microsoft.Storage/storageAccounts\"")
  @visibility("read")
  type?: string;
}

@doc("Definition of the configuration profile.")
model ConfigurationProfileUpdate extends UpdateResource {
  @doc("Properties of the configuration profile.")
  properties?: ConfigurationProfileProperties;
}

@doc("Represents an update resource")
model UpdateResource {
  @doc("The tags of the resource.")
  tags?: Record<string>;
}

@doc("Automanage configuration profile assignment properties.")
model ConfigurationProfileAssignmentProperties {
  @doc("The Automanage configurationProfile ARM Resource URI.")
  configurationProfile?: string;

  @doc("The target VM resource URI")
  @visibility("read")
  targetId?: string;

  @doc("The status of onboarding, which only appears in the response.")
  @visibility("read")
  status?: string;
}

@doc("Data related to the report detail.")
model AssignmentReportProperties {
  @doc("Start time of the configuration profile assignment processing.")
  startTime?: string;

  @doc("End time of the configuration profile assignment processing.")
  endTime?: string;

  @doc("Last modified time of the configuration profile assignment processing.")
  @visibility("read")
  lastModifiedTime?: string;

  @doc("Duration of the configuration profile assignment processing.")
  @visibility("read")
  duration?: duration;

  @doc("Type of the configuration profile assignment processing (Initial/Consistency).")
  @visibility("read")
  type?: string;

  @doc("The status of the configuration profile assignment.")
  @visibility("read")
  status?: string;

  @doc("The configurationProfile linked to the assignment.")
  @visibility("read")
  configurationProfile?: string;

  @doc("List of resources processed by the configuration profile assignment.")
  @visibility("read")
  resources?: ReportResource[];

  @doc("Error message, if any, returned by the configuration profile assignment processing.")
  @visibility("read")
  error?: ErrorDetail;

  @doc("Version of the report format")
  @visibility("read")
  reportFormatVersion?: string;
}

@doc("Details about the resource processed by the configuration profile assignment")
model ReportResource {
  @doc("Name of the resource.")
  @visibility("read")
  name?: string;

  @doc("ARM id of the resource.")
  @visibility("read")
  id?: string;

  @doc("Type of the resource.")
  @visibility("read")
  type?: string;

  @doc("Status of the resource.")
  @visibility("read")
  status?: string;

  @doc("Error message, if any, returned when deploying the resource.")
  @visibility("read")
  error?: ErrorDetail;
}

@doc("The list of ServicePrincipals.")
@pagedResult
model ServicePrincipalListResult {
  @doc("The list of servicePrincipals.")
  @items
  value?: ServicePrincipal[];
}

@doc("The Service Principal Id for the subscription.")
model ServicePrincipal extends ProxyResource {
  @doc("The Service Principal properties for the subscription")
  properties?: ServicePrincipalProperties;

  @doc("Azure Resource Manager metadata containing createdBy and modifiedBy information.")
  @visibility("read")
  systemData?: SystemData;
}

@doc("The Service Principal properties for the subscription.")
model ServicePrincipalProperties {
  @doc("The Service Principal Id for the subscription.")
  @visibility("read")
  servicePrincipalId?: string;

  @doc("Returns the contributor RBAC Role exist or not for the Service Principal Id.")
  @visibility("read")
  authorizationSet?: boolean;
}
