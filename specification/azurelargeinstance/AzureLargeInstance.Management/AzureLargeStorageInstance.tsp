import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
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

  @removed(Versions.v2024_08_01_preview)
  @doc("""
  Patches the Tags field of a Azure Large Storage Instance for the specified
  subscription, resource group, and instance name.
  """)
  update is ArmCustomPatchSync<AzureLargeStorageInstance>;

  @added(Versions.v2024_08_01_preview)
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" ""
  @doc("""
    Patches the Tags field of a Azure Large Storage Instance for the specified
    subscription, resource group, and instance name.
    """)
  update is ArmCustomPatchSync<
    AzureLargeStorageInstance,
    AzureLargeStorageInstancePatchBody
  >;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "Legacy"
  @added(Versions.v2024_08_01_preview)
  @doc("""
    Creates an Azure Large Storage Instance for the specified subscription,
    resource group, and instance name.
    """)
  @armResourceCreateOrUpdate(AzureLargeStorageInstance)
  @put
  create is Azure.ResourceManager.Foundations.ArmCreateOperation<
    ResourceInstanceParameters<
      AzureLargeStorageInstance,
      Azure.ResourceManager.Foundations.BaseParameters<AzureLargeStorageInstance>
    >,
    AzureLargeStorageInstance,
    ArmResponse<AzureLargeStorageInstance>,
    ErrorResponse
  >;

  @added(Versions.v2024_08_01_preview)
  @armResourceDelete(AzureLargeStorageInstance)
  @doc("""
    Deletes an Azure Large Storage Instance for the specified subscription,
    resource group, and instance name.
    """)
  delete is ArmResourceDeleteSync<AzureLargeStorageInstance>;

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

@removed(Versions.v2024_08_01_preview)
@@encodedName(AzureLargeStorageInstances.update::parameters.properties,
  "application/json",
  "tagsParameter"
);

@added(Versions.v2024_08_01_preview)
@@encodedName(AzureLargeStorageInstances.update::parameters.properties,
  "application/json",
  "azureLargeStorageInstanceBodyParameter"
);
