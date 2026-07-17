import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
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

@armResourceOperations(#{ omitTags: true })
interface AzureBareMetalInstances {
  /**
   * Gets an Azure Bare Metal Instance for the specified subscription, resource group, and instance name.
   */
  @summary("Gets an Azure Bare Metal Instance.")
  @tag("Bare Metal Instances")
  get is ArmResourceRead<AzureBareMetalInstance>;

  /**
   * Creates an Azure Bare Metal Instance for the specified subscription, resource group, and instance name.
   */
  @tag("Bare Metal Instances")
  create is ArmResourceCreateOrReplaceSync<AzureBareMetalInstance>;

  /**
   * Patches the Tags field of a Azure Bare Metal Instance for the specified subscription, resource group, and instance name.
   */
  @summary("Patches the Tags field of a Azure Bare Metal Instance.")
  @tag("Bare Metal Instances")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<AzureBareMetalInstance, PatchModel = Tags>;

  /**
   * Deletes an Azure Bare Metal Instance for the specified subscription, resource group, and instance name.
   */
  @tag("Bare Metal Instances")
  delete is ArmResourceDeleteSync<AzureBareMetalInstance>;

  /**
   * Gets a list of Azure Bare Metal Instances in the specified subscription and resource group. The operations returns various properties of each Azure Bare Metal Instance.
   */
  @summary("Gets a list of Azure Bare Metal Instances in the specified subscription and resource group.")
  @tag("Bare Metal Instances")
  listByResourceGroup is ArmResourceListByParent<
    AzureBareMetalInstance,
    Response = ArmResponse<AzureBareMetalInstancesListResult>
  >;

  /**
   * Returns a list of Azure Bare Metal Instances in the specified subscription. The operations returns various properties of each Azure Bare Metal Instance.
   */
  @summary("Returns a list of Azure Bare Metal Instances in the specified subscription.")
  @tag("Bare Metal Instances")
  listBySubscription is ArmListBySubscription<
    AzureBareMetalInstance,
    Response = ArmResponse<AzureBareMetalInstancesListResult>
  >;

  /**
   * The operation to start an Azure Bare Metal instance
   */
  @summary("Start a Bare Metal Instance.")
  @tag("Bare Metal Instances")
  start is ArmResourceActionAsyncBase<
    AzureBareMetalInstance,
    void,
    ArmAcceptedLroResponse<
      "Start request accepted.",
      LroHeaders = ArmLroLocationHeader<FinalResult = OperationStatus>
    > | ArmResponse<OperationStatus>,
    BaseParameters = DefaultBaseParameters<AzureBareMetalInstance>
  >;

  /**
   * The operation to restart an Azure Bare Metal Instance
   */
  @summary("Restart a Bare Metal Instance.")
  @tag("Bare Metal Instances")
  restart is ArmResourceActionAsyncBase<
    AzureBareMetalInstance,
    ForceState,
    ArmAcceptedLroResponse<
      "Restart request accepted.",
      LroHeaders = ArmLroLocationHeader<FinalResult = OperationStatus>
    > | ArmResponse<OperationStatus>,
    BaseParameters = DefaultBaseParameters<AzureBareMetalInstance>,
    OptionalRequestBody = true
  >;

  /**
   * The operation to shutdown an Azure Bare Metal Instance
   */
  @summary("Shutdown a Bare Metal Instance.")
  @tag("Bare Metal Instances")
  shutdown is ArmResourceActionAsyncBase<
    AzureBareMetalInstance,
    void,
    ArmAcceptedLroResponse<
      "Shutdown request accepted.",
      LroHeaders = ArmLroLocationHeader<FinalResult = OperationStatus>
    > | ArmResponse<OperationStatus>,
    BaseParameters = DefaultBaseParameters<AzureBareMetalInstance>
  >;
}

@@doc(AzureBareMetalInstance.name,
  "Name of the Azure Bare Metal Instance, also known as the ResourceName."
);
@@doc(AzureBareMetalInstance.properties, "AzureBareMetal instance properties");
@@doc(AzureBareMetalInstances.update::parameters.properties,
  "Request body that only contains the new Tags field"
);
@@doc(AzureBareMetalInstances.restart::parameters.body,
  "When set to 'active', this parameter empowers the server with the ability to forcefully terminate and halt any existing processes that may be running on the server"
);
