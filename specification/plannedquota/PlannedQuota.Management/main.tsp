import "./versions.tsp";
import "./plannedquota.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Namespace types must use PascalCaseTypeSpec"
@armProviderNamespace
@service(#{ title: "Azure Planned Quota" })
@doc("Planned Quota Provider")
@versioned(Microsoft.PlannedQuota.Versions)
namespace Microsoft.PlannedQuota;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Provisioning status of the resource.")
union PlannedQuotaProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Accepted State")
  Accepted: "Accepted",
}
