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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: AzureBareMetalStorageInstanceIdentity;
}

@armResourceOperations
interface AzureBareMetalStorageInstances {
  /**
   * Gets an Azure Bare Metal Storage instance for the specified subscription, resource group, and instance name.
   */
  get is ArmResourceRead<AzureBareMetalStorageInstance>;

  /**
   * Creates an Azure Bare Metal Storage Instance for the specified subscription, resource group, and instance name.
   */
  create is ArmResourceCreateOrReplaceSync<AzureBareMetalStorageInstance>;

  /**
   * Patches the Tags field of a Azure BareMetalStorage instance for the specified subscription, resource group, and instance name.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    AzureBareMetalStorageInstance,
    PatchModel = AzureBareMetalStorageInstanceBody
  >;

  /**
   * Deletes an Azure Bare Metal Storage Instance for the specified subscription, resource group, and instance name.
   */
  delete is ArmResourceDeleteSync<AzureBareMetalStorageInstance>;

  /**
   * Gets a list of AzureBareMetalStorage instances in the specified subscription and resource group. The operations returns various properties of each Azure Bare Metal Instance.
   */
  listByResourceGroup is ArmResourceListByParent<AzureBareMetalStorageInstance>;

  /**
   * Gets a list of AzureBareMetalStorage instances in the specified subscription. The operations returns various properties of each Azure Bare Metal Instance.
   */
  listBySubscription is ArmListBySubscription<AzureBareMetalStorageInstance>;
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
@@summary(AzureBareMetalStorageInstances.listByResourceGroup,
  "Gets a list of Azure Bare Metal Storage instances in the specified subscription and resource group."
);
@@summary(AzureBareMetalStorageInstances.listBySubscription,
  "Gets a list of Azure Bare Metal Storage instances in the specified subscription."
);
@@summary(AzureBareMetalStorageInstances.get,
  "Gets an Azure Bare Metal Storage instance."
);
@@summary(AzureBareMetalStorageInstances.create,
  "Create an azure bare metal storage resource."
);
@@summary(AzureBareMetalStorageInstances.update,
  "Patches the Tags field of a Azure BareMetalStorage instance."
);
@@summary(AzureBareMetalStorageInstances.delete,
  "Delete an AzureBareMetalStorageInstance."
);
