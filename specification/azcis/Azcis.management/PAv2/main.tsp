import "../versions.tsp";
import "./pushagentv2account.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Namespace types must use PascalCaseTypeSpec"
@armProviderNamespace
@service({
  title: "Foundational ARM Client",
})
@doc("PushAgentV2Account Provider")
@versioned(Microsoft.AzureCIS.Versions)
namespace Microsoft.AzureCIS;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Provisioning status of the resource.")
enum PushAgentV2AccountProvisioningState {
  ...ResourceProvisioningState,

  @doc("Accepted State")
  Accepted,
}
