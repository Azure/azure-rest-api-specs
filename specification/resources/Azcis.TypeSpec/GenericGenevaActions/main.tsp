import "../versions.tsp";
import "./genericgenevaactions.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Namespace types must use PascalCaseTypeSpec"
@armProviderNamespace
@service({
  title: "Foundational ARM Client",
})
@doc("GenericGenevaActions Provider")
@versioned(Microsoft.AzureCIS.Versions)
namespace Microsoft.AzureCIS;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Provisioning status of the resource.")
enum GenericGenevaActionsProvisioningState {
  ...ResourceProvisioningState,

  @doc("Accepted State")
  Accepted,
}
