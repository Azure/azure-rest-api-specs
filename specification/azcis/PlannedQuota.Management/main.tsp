import "./versions.tsp";
import "./plannedquota.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Namespace types must use PascalCaseTypeSpec"
@armProviderNamespace
@service({
  title: "Azure CIS FRP",
})
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
