import "../versions.tsp";
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
  title: "Foundational ARM Client",
})
@doc("dscm Service")
@versioned(Microsoft.AzureCIS.Versions)
namespace Microsoft.AzureCIS;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Provisioning status of the resource.")
enum DscmProvisioningState {
  ...ResourceProvisioningState,

  @doc("Accepted State")
  Accepted,
}
