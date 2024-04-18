import "../versions.tsp";
import "./dsmsallowlist.tsp";
import "./dstsserviceaccount.tsp";
import "./dstsapplication.tsp";
import "./dsmsrootfolder.tsp";
import "./dstsserviceclientidentity.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

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
