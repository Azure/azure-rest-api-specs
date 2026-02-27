import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";

import "./versions.tsp";
import "./plannedquota.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;

@armProviderNamespace
@service(#{ title: "Azure CIS FRP" })
@doc("Planned Quota Provider")
@versioned(Microsoft.AzureCis.Versions)
namespace Microsoft.AzureCis;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Provisioning status of the resource.")
union PlannedQuotaProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Accepted State")
  Accepted: "Accepted",
}
