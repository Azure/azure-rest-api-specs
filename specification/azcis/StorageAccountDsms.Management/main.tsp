import "./versions.tsp";
import "./storageaccountdsms.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;

@armProviderNamespace
@service(#{ title: "Azure CIS FRP" })
@doc("https://eng.ms/docs/products/azcis-resource-provisioning/template-user-guide/resources/storage-account")
@versioned(Microsoft.AzureCis.Versions)
namespace Microsoft.AzureCis;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Provisioning status of the resource.")
union StorageAccountDsmsProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("Accepted State")
  Accepted: "Accepted",
}
