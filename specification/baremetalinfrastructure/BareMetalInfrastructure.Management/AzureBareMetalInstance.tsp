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
 * AzureBareMetal instance info on Azure (ARM properties and AzureBareMetal properties)
 */
model AzureBareMetalInstance
  is Azure.ResourceManager.TrackedResource<AzureBareMetalInstanceProperties> {
  ...ResourceNameParameter<
    Resource = AzureBareMetalInstance,
    KeyName = "azureBareMetalInstanceName",
    SegmentName = "bareMetalInstances",
    NamePattern = "^[a-zA-Z0-9]+$"
  >;
}

@armResourceOperations
interface AzureBareMetalInstances {
  /**
   * Gets an Azure Bare Metal Instance for the specified subscription, resource group, and instance name.
   */
  get is ArmResourceRead<AzureBareMetalInstance>;

  /**
   * Creates an Azure Bare Metal Instance for the specified subscription, resource group, and instance name.
   */
  create is ArmResourceCreateOrReplaceSync<AzureBareMetalInstance>;

  /**
   * Patches the Tags field of a Azure Bare Metal Instance for the specified subscription, resource group, and instance name.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<AzureBareMetalInstance, PatchModel = Tags>;

  /**
   * Deletes an Azure Bare Metal Instance for the specified subscription, resource group, and instance name.
   */
  delete is ArmResourceDeleteSync<AzureBareMetalInstance>;

  /**
   * Gets a list of Azure Bare Metal Instances in the specified subscription and resource group. The operations returns various properties of each Azure Bare Metal Instance.
   */
  listByResourceGroup is ArmResourceListByParent<AzureBareMetalInstance>;

  /**
   * Returns a list of Azure Bare Metal Instances in the specified subscription. The operations returns various properties of each Azure Bare Metal Instance.
   */
  listBySubscription is ArmListBySubscription<AzureBareMetalInstance>;

  /**
   * The operation to start an Azure Bare Metal instance
   */
  start is ArmResourceActionAsync<
    AzureBareMetalInstance,
    void,
    ArmResponse<OperationStatus>
  >;

  /**
   * The operation to restart an Azure Bare Metal Instance
   */
  restart is ArmResourceActionAsync<
    AzureBareMetalInstance,
    {
      /**
       * When set to 'active', this parameter empowers the server with the ability to forcefully terminate and halt any existing processes that may be running on the server
       */
      @bodyRoot
      forceParameter?: ForceState;
    },
    ArmResponse<OperationStatus>
  >;

  /**
   * The operation to shutdown an Azure Bare Metal Instance
   */
  shutdown is ArmResourceActionAsync<
    AzureBareMetalInstance,
    void,
    ArmResponse<OperationStatus>
  >;
}

@@doc(AzureBareMetalInstance.name,
  "Name of the Azure Bare Metal Instance, also known as the ResourceName."
);
@@doc(AzureBareMetalInstance.properties, "AzureBareMetal instance properties");
@@doc(AzureBareMetalInstances.update::parameters.properties,
  "Request body that only contains the new Tags field"
);
@@summary(AzureBareMetalInstances.listBySubscription,
  "Returns a list of Azure Bare Metal Instances in the specified subscription."
);
@@summary(AzureBareMetalInstances.listByResourceGroup,
  "Gets a list of Azure Bare Metal Instances in the specified subscription and resource group."
);
@@summary(AzureBareMetalInstances.get, "Gets an Azure Bare Metal Instance.");
@@summary(AzureBareMetalInstances.update,
  "Patches the Tags field of a Azure Bare Metal Instance."
);
@@summary(AzureBareMetalInstances.restart, "Restart a Bare Metal Instance.");
@@summary(AzureBareMetalInstances.shutdown, "Shutdown a Bare Metal Instance.");
@@summary(AzureBareMetalInstances.start, "Start a Bare Metal Instance.");
