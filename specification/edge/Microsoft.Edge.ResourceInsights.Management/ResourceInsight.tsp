import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/versioning";
import "@typespec/rest";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;

namespace Microsoft.Edge;

@doc("ResourceInsight resource")
model ResourceInsight
  is Azure.ResourceManager.ExtensionResource<ResourceInsightProperties> {
  ...ResourceNameParameter<ResourceInsight, NamePattern = "^default$">;
}

@@path(ResourceUriParameter.resourceUri, "scope");
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "TODO: Using private decorator is NOT allowed, this should be removed"
@@Azure.ResourceManager.CommonTypes.Private.armCommonParameter(ResourceUriParameter.resourceUri,
  "ScopeParameter",
  Azure.ResourceManager.CommonTypes.Versions.v5
);

@@doc(Azure.ResourceManager.ResourceUriParameter.resourceUri,
  "The scope of the operation or resource. Valid scopes is resource (format: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/[{parentResourcePath}/]{resourceType}/{resourceName}'"
);

@doc("ResourceInsight operations")
@armResourceOperations
interface ResourceInsights {
  @doc("Get ResourceInsight resource by name")
  get is ArmResourceRead<ResourceInsight>;

  @doc("List all ResourceInsight resources")
  list is ArmResourceListByParent<ResourceInsight>;
}

@doc("Connectivity status enum")
union ConnectivityStatusEnum {
  string,

  @doc("The device is in Connected state")
  Connected: "Connected",

  @doc("The device was not recently connected")
  NotRecentlyConnected: "NotRecentlyConnected",

  @doc("The device needs attention")
  NeedsAttention: "NeedsAttention",

  @added(Versions.v2026_04_01_preview)
  @doc("The device is in Disconnected state and replaces NotRecentlyConnected")
  Disconnected: "Disconnected",

  @added(Versions.v2026_04_01_preview)
  @doc("The device is in transition")
  InProgress: "InProgress",

  @added(Versions.v2026_04_01_preview)
  @doc("The device is pending initial setup completion")
  FinishSetup: "FinishSetup",
}

@doc("Update status enum")
union UpdateStatus {
  string,

  @doc("The device is in Unknown state")
  Unknown: "Unknown",

  @doc("The device is in Update state")
  UpdateAvailable: "UpdateAvailable",

  @doc("The device is in UptoDate state")
  UptoDate: "UptoDate",

  @doc("The device is in UpdateInProgress state")
  UpdateInProgress: "UpdateInProgress",

  @doc("The device is in NeedsAttention state")
  NeedsAttention: "NeedsAttention",
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "ResourceProvisioningState is not needed since this resource is created via ARB and directly pushed to ARG"
@doc("Resource Insight properties")
model ResourceInsightProperties {
  @doc("The connectivity status")
  connectivity?: Connectivity;

  @doc("The update status")
  update?: Update;
}

@doc("ResourceInsights Connectivity")
model Connectivity {
  @doc("The connectivity status")
  status?: ConnectivityStatusEnum;

  @doc("The event received time")
  eventReceivedTime?: utcDateTime;
}

@doc("ResourceInsights Update")
model Update {
  @doc("The update status")
  status?: UpdateStatus;

  @doc("The event received time")
  eventReceivedTime?: utcDateTime;
}
