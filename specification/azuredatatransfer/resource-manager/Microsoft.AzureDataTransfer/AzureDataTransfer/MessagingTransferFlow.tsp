import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.messagingtransferflow.tsp";

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

@versioned(Versions)
namespace Microsoft.AzureDataTransfer;
/**
 * The messaging transfer flow resource definition.
 */
@added(Versions.v2026_06_29_preview)
model MessagingTransferFlow is Azure.ResourceManager.TrackedResource<
  MessagingTransferFlowProperties,
  false
> {
  ...ResourceNameParameter<
    Resource = MessagingTransferFlow,
    KeyName = "messagingTransferFlowName",
    SegmentName = "messagingTransferFlows",
    NamePattern = "^[a-zA-Z0-9-]{3,64}$"
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

@added(Versions.v2026_06_29_preview)
@armResourceOperations
interface MessagingTransferFlows {
  /**
   * Gets the MessagingTransferFlow resource.
   */
  get is ArmResourceRead<MessagingTransferFlow>;

  /**
   * Creates or updates the MessagingTransferFlow resource.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<MessagingTransferFlow>;

  /**
   * Updates the MessagingTransferFlow resource.
   */
  @patch(#{ implicitOptionality: false })
  @added(Versions.v2026_06_29_preview)
  update is ArmCustomPatchAsync<
    MessagingTransferFlow,
    PatchModel = MessagingTransferFlowsPatch
  >;

  /**
   * Gets messaging transfer flows in a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<MessagingTransferFlow>;

  /**
   * Gets messaging transfer flows in a subscription.
   */
  listBySubscription is ArmListBySubscription<MessagingTransferFlow>;

  /**
   * Deletes the MessagingTransferFlow resource.
   */
  delete is ArmResourceDeleteWithoutOkAsync<MessagingTransferFlow>;

  /**
   * Disables the specified MessagingTransferFlow.
   */
  disable is ArmResourceActionAsync<
    MessagingTransferFlow,
    void,
    MessagingTransferFlow
  >;

  /**
   * Enables the specified MessagingTransferFlow.
   */
  enable is ArmResourceActionAsync<
    MessagingTransferFlow,
    void,
    MessagingTransferFlow
  >;

  /**
   * Links the messaging transfer flow to the remote messaging transfer flow identified by its remoteTransferFlowResourceId property.
   */
  link is ArmResourceActionAsync<
    MessagingTransferFlow,
    void,
    MessagingTransferFlow
  >;
}

@@maxLength(MessagingTransferFlow.name, 64);
@@minLength(MessagingTransferFlow.name, 3);
@@doc(
  MessagingTransferFlow.name,
  "The name for the MessagingTransferFlow to perform the operation on."
);
@@doc(MessagingTransferFlow.properties, "Properties of MessagingTransferFlow");
@@doc(
  MessagingTransferFlows.createOrUpdate::parameters.resource,
  "MessagingTransferFlow body"
);
@@doc(
  MessagingTransferFlows.update::parameters.properties,
  "MessagingTransferFlow body"
);

@@clientName(
  MessagingTransferFlows.createOrUpdate::parameters.resource,
  "MessagingTransferFlow"
);
@@clientName(
  MessagingTransferFlows.update::parameters.properties,
  "MessagingTransferFlow"
);
