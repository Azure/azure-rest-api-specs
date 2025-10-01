import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/versioning";

import "./versions.tsp";
import "./plannedquota.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Namespace types must use PascalCaseTypeSpec"
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
