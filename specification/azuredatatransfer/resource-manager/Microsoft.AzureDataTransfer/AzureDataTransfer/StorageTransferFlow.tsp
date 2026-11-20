import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.storagetransferflow.tsp";

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

@versioned(Versions)
namespace Microsoft.AzureDataTransfer;
/**
 * The storage flow resource definition.
 */
@added(Versions.v2026_06_29_preview)
model StorageTransferFlow is Azure.ResourceManager.TrackedResource<
  StorageTransferFlowProperties,
  false
> {
  ...ResourceNameParameter<
    Resource = StorageTransferFlow,
    KeyName = "storageTransferFlowName",
    SegmentName = "storageTransferFlows",
    NamePattern = "^[a-zA-Z0-9-]{3,64}$"
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@added(Versions.v2026_06_29_preview)
@armResourceOperations
interface StorageTransferFlows {
  /**
   * Gets StorageTransferFlow resource.
   */
  get is ArmResourceRead<StorageTransferFlow>;

  /**
   * Creates or updates the StorageTransferFlow resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<StorageTransferFlow>;

  /**
   * Updates the StorageTransferFlow resource.
   */
  @patch(#{ implicitOptionality: false })
  @added(Versions.v2026_06_29_preview)
  update is ArmCustomPatchAsync<
    StorageTransferFlow,
    PatchModel = StorageTransferFlowsPatch
  >;

  /**
   * Gets storage transfer flows in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<StorageTransferFlow>;

  /**
   * Gets storage transfer flows in a subscription.
   */
  listBySubscription is ArmListBySubscription<StorageTransferFlow>;

  /**
   * Deletes the storage transfer flow resource.
   */
  delete is ArmResourceDeleteWithoutOkAsync<StorageTransferFlow>;

  /**
   * Stops data transfer through the specified storage transfer flow.
   */
  disableTransfer is ArmResourceActionAsync<
    StorageTransferFlow,
    void,
    StorageTransferFlow
  >;

  /**
   * Starts (or resumes) data transfer through the specified storage transfer flow. The transfer flow must be approved and linked.
   */
  enableTransfer is ArmResourceActionAsync<
    StorageTransferFlow,
    void,
    StorageTransferFlow
  >;

  /**
   * Pairs this storage transfer flow with the storage transfer flow identified by its remoteTransferFlowResourceId on the other side of the pipeline. Once both sides are linked and approved, data can be transferred between them.
   */
  linkRemoteFlow is ArmResourceActionAsync<
    StorageTransferFlow,
    void,
    StorageTransferFlow
  >;
}

@@maxLength(StorageTransferFlow.name, 64);
@@minLength(StorageTransferFlow.name, 3);
@@doc(
  StorageTransferFlow.name,
  "The name for the StorageTransferFlow to perform the operation on."
);
@@doc(StorageTransferFlow.properties, "Properties of StorageTransferFlow");
@@doc(
  StorageTransferFlows.createOrUpdate::parameters.resource,
  "StorageTransferFlow body"
);
@@doc(
  StorageTransferFlows.update::parameters.properties,
  "StorageTransferFlow body"
);

@@clientName(
  StorageTransferFlows.createOrUpdate::parameters.resource,
  "storageTransferFlow"
);
@@clientName(
  StorageTransferFlows.update::parameters.properties,
  "storageTransferFlow"
);
