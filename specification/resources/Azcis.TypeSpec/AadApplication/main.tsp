import "../versions.tsp";
import "./aadapplication.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Namespace types must use PascalCaseTypeSpec"
@armProviderNamespace
@service({
  title: "Foundational ARM Client",
})
@doc("https://eng.ms/docs/products/azcis-resource-provisioning/template-user-guide/resources/aad-application")
@versioned(Microsoft.AzureCIS.Versions)
namespace Microsoft.AzureCIS;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Provisioning status of the resource.")
enum AadApplicationProvisioningState {
  ...ResourceProvisioningState,

  @doc("Accepted State")
  Accepted,
}
