import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";

using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.HealthcareInterop;

@doc("The provisioning state of a resource.")
@lroStatus
union ProvisioningLROState {
  string,
  ResourceProvisioningState,

  @doc("The resource create request has been accepted")
  Accepted: "Accepted",

  @doc("The resource is being provisioned")
  Provisioning: "Provisioning",

  @doc("The resource is updating")
  Updating: "Updating",

  @doc("The resource is being deleted")
  Deleting: "Deleting",
}
