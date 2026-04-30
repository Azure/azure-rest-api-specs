import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.BareMetalInfrastructure;
/**
 * AzureBareMetalStorageInstance info on Azure (ARM properties and AzureBareMetalStorage properties)
 */
model AzureBareMetalStorageInstance
  is Azure.ResourceManager.TrackedResource<AzureBareMetalStorageInstanceProperties> {
  ...ResourceNameParameter<
    Resource = AzureBareMetalStorageInstance,
    KeyName = "azureBareMetalStorageInstanceName",
    SegmentName = "bareMetalStorageInstances",
    NamePattern = ".*"
  >;

  /**
   * The identity of Azure Bare Metal Storage Instance, if configured.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Existing property from original swagger"
  identity?: AzureBareMetalStorageInstanceIdentity;
}

@armResourceOperations(#{ omitTags: true })
interface AzureBareMetalStorageInstances {
  /**
   * Gets an Azure Bare Metal Storage instance for the specified subscription, resource group, and instance name.
   */
  @summary("Gets an Azure Bare Metal Storage instance.")
  @tag("Bare Metal Storage Instances")
  get is ArmResourceRead<AzureBareMetalStorageInstance>;

  /**
   * Creates an Azure Bare Metal Storage Instance for the specified subscription, resource group, and instance name.
   */
  @summary("Create an azure bare metal storage resource.")
  @tag("Bare Metal Storage Instances")
  create is ArmResourceCreateOrReplaceSync<AzureBareMetalStorageInstance>;

  /**
   * Patches the Tags field of a Azure BareMetalStorage instance for the specified subscription, resource group, and instance name.
   */
  @summary("Patches the Tags field of a Azure BareMetalStorage instance.")
  @tag("BareMetalInfrastructure")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    AzureBareMetalStorageInstance,
    PatchModel = AzureBareMetalStorageInstanceBody
  >;

  /**
   * Deletes an Azure Bare Metal Storage Instance for the specified subscription, resource group, and instance name.
   */
  @summary("Delete an AzureBareMetalStorageInstance.")
  @tag("Bare Metal Storage Instances")
  delete is ArmResourceDeleteSync<AzureBareMetalStorageInstance>;

  /**
   * Gets a list of AzureBareMetalStorage instances in the specified subscription and resource group. The operations returns various properties of each Azure Bare Metal Instance.
   */
  @summary("Gets a list of Azure Bare Metal Storage instances in the specified subscription and resource group.")
  @tag("Bare Metal Storage Instances")
  listByResourceGroup is ArmResourceListByParent<
    AzureBareMetalStorageInstance,
    Response = ArmResponse<AzureBareMetalStorageInstancesListResult>
  >;

  /**
   * Gets a list of AzureBareMetalStorage instances in the specified subscription. The operations returns various properties of each Azure Bare Metal Instance.
   */
  @summary("Gets a list of Azure Bare Metal Storage instances in the specified subscription.")
  @tag("Bare Metal Storage Instances")
  listBySubscription is ArmListBySubscription<
    AzureBareMetalStorageInstance,
    Response = ArmResponse<AzureBareMetalStorageInstancesListResult>
  >;
}

@@doc(AzureBareMetalStorageInstance.name,
  "Name of the Azure Bare Metal Storage Instance, also known as the ResourceName."
);
@@doc(AzureBareMetalStorageInstance.properties,
  "AzureBareMetalStorageInstance properties"
);
@@doc(AzureBareMetalStorageInstances.create::parameters.resource,
  "request body for put call"
);
@@doc(AzureBareMetalStorageInstances.update::parameters.properties,
  "Request body that only contains the Tags and Identity Field"
);
