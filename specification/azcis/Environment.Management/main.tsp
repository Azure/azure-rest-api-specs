import "../versions.tsp";
import "./autopilotenvironment.tsp";
import "./autopilotmachinefunction.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service(#{ title: "Azure CIS FRP" })
@doc("Autopilot Environment Provider")
@versioned(Microsoft.AzureCis.Versions)
namespace Microsoft.AzureCis;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Provisioning status of the resource.")
union EnvironmentProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("The resource create request has been accepted")
  Accepted: "Accepted",
}
