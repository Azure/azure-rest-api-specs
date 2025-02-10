import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Azure.ResourceManager;
using Azure.Core;

namespace Microsoft.AppSecurity;

@doc("The provisioning state of a resource type")
@lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  @doc("Provisioning the resource is in progress")
  Provisioning: "Provisioning",

  @doc("Resource is being updated")
  Updating: "Updating",

  @doc("Resource is being deleted")
  Deleting: "Deleting",

  @doc("The change request has been accepted")
  Accepted: "Accepted",
}

@doc("Describes whether an object (a policy, a custom rule, a managed rule set or other objects) is enabled or disabled")
union EnabledState {
  string,

  @doc("The object is enabled")
  Enabled: "Enabled",

  @doc("The object is disabled")
  Disabled: "Disabled",
}

@doc("The type of the endpoint")
union EndpointType {
  string,

  @doc("application gateway endpoints, which are under Microsoft.Network/applicationGateways")
  ApplicationGateway: "ApplicationGateway",

  @doc("FrontDoor endpoints, which are under Microsoft.Cdn/profiles")
  FrontDoor: "FrontDoor",
}
