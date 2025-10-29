import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";

import "./versions.tsp";
import "./plannedquota.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;

@armProviderNamespace
@service(#{ title: "Microsoft.Lionrock" })
@doc("Microsoft.Lionrock resource providers API.")
@versioned(Microsoft.Lionrock.Versions)
namespace Microsoft.Lionrock;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Provisioning status of the resource.")
union LionrockProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Accepted State")
  Accepted: "Accepted",
}
