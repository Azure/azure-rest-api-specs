import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";

import "./genevalogsaccounts.tsp";
import "./versions.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;

@armProviderNamespace
@service(#{ title: "Azure CIS FRP" })
@doc("Geneva Logs Provider")
@versioned(Microsoft.AzureCis.Versions)
namespace Microsoft.AzureCis;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Provisioning status of the resource.")
union GenevaLogsProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Accepted State")
  Accepted: "Accepted",
}
