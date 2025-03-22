import "./versions.tsp";
import "./jitsecuritygroupresources.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service(#{ title: "Azure CIS FRP" })
@doc("FICP Service")
@versioned(Microsoft.AzureCis.Versions)
namespace Microsoft.AzureCis;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Provisioning Mode")
model ProvisioningMode {
  @doc("Type of the provisioning mode, either \"Create\" or \"Delete\".")
  mode: string;
}

@doc("Provisioning status of the resource.")
union FicpProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Accepted State")
  Accepted: "Accepted",
}
