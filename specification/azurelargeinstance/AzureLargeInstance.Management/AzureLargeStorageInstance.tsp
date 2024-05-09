import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using Azure.ClientGenerator.Core;

namespace Microsoft.AzureLargeInstance;
@doc("""
AzureLargeStorageInstance info on Azure (ARM properties and
AzureLargeStorageInstance properties)
""")
model AzureLargeStorageInstance
  is TrackedResource<AzureLargeStorageInstanceProperties> {
  @doc("Name of the AzureLargeStorageInstance.")
  @pattern(".*")
  @path
  @key("azureLargeStorageInstanceName")
  @segment("azureLargeStorageInstances")
  name: string;
}

@armResourceOperations
@clientName("AzureLargeStorageInstance")
interface AzureLargeStorageInstances {
  @doc("""
Gets an Azure Large Storage instance for the specified subscription, resource
group, and instance name.
""")
  get is ArmResourceRead<AzureLargeStorageInstance>;
  @doc("""
Patches the Tags field of a Azure Large Storage Instance for the specified
subscription, resource group, and instance name.
""")
  update is ArmCustomPatchSync<AzureLargeStorageInstance>;
  @doc("""
Gets a list of AzureLargeStorageInstances in the specified subscription and
resource group. The operations returns various properties of each Azure
LargeStorage instance.
""")
  listByResourceGroup is ArmResourceListByParent<AzureLargeStorageInstance>;
  @doc("""
Gets a list of AzureLargeStorageInstances in the specified subscription. The
operations returns various properties of each Azure LargeStorage instance.
""")
  listBySubscription is ArmListBySubscription<AzureLargeStorageInstance>;
}

@@encodedName(AzureLargeStorageInstances.update::parameters.properties,
  "application/json",
  "tagsParameter"
);
