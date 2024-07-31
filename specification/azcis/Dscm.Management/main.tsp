import "./versions.tsp";
import "./dstsapplication.tsp";
import "./dsmsallowlist.tsp";
import "./dstsserviceclientidentity.tsp";
import "./dsmsrootfolder.tsp";
import "./dstsserviceaccount.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Namespace types must use PascalCaseTypeSpec"
@armProviderNamespace
@service({
  title: "Azure CIS FRP",
})
@doc("dscm Service")
@versioned(Microsoft.AzureCis.Versions)
namespace Microsoft.AzureCis;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Provisioning status of the resource.")
union DscmProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Accepted State")
  Accepted: "Accepted",
}
