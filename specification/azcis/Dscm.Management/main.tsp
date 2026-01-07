import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";

import "./versions.tsp";
import "./dstsmodels.tsp";
import "./dsmsallowlist.tsp";
import "./dsmsrootfolder.tsp";
import "./dstsapplication.tsp";
import "./dstsserviceaccount.tsp";
import "./dstsserviceaccountgroup.tsp";
import "./dstsserviceclientidentity.tsp";
import "./dstsmanagedserviceclientidentitygroup.tsp";
import "./dstssubjectnamebasedserviceclientidentitygroup.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;

@armProviderNamespace
@service(#{ title: "dSCM Service" })
@doc("https://eng.ms/docs/products/azcis-resource-provisioning/template-user-guide/resources/dscm")
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
