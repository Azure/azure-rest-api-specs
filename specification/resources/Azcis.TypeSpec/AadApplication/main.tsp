import "./aadapplication.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

#suppress "@azure-tools/typespec-azure-core/casing-style" "The names of Namespace types must use PascalCaseTypeSpec"
@armProviderNamespace
@service({
  title: "Foundational ARM Client",
  version: "2023-08-22-preview",
})
@doc("https://eng.ms/docs/products/azcis-resource-provisioning/template-user-guide/resources/aad-application")
@useDependency(Azure.ResourceManager.Versions.v1_0_Preview_1)
namespace Microsoft.AzureCIS;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Provisioning status of the resource.")
enum AadApplicationProvisioningState {
  ...ResourceProvisioningState,

  @doc("Accepted State")
  Accepted,
}
