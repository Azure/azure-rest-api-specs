import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Subscription;
using Azure.ResourceManager;

@@clientName(Microsoft.Subscription, "SubscriptionClient", "python");

/**
 * override for SubscriptionOperationGroup.acceptOwnershipStatus
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op subscriptionAcceptOwnershipStatus(
  ...ApiVersionParameter,
  ...SubscriptionActionScope,
  ...Azure.ResourceManager.Legacy.Provider,
  subscriptionId: Azure.Core.uuid,
  body: void,
): AcceptOwnershipStatusResponse | Azure.ResourceManager.CommonTypes.ErrorResponse;

@@override(SubscriptionOperationGroup.acceptOwnershipStatus,
  subscriptionAcceptOwnershipStatus,
  "javascript"
);

/**
 * override for SubscriptionOperationGroup.AcceptOwnership
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op subscriptionAcceptOwnership(
  ...ApiVersionParameter,
  ...SubscriptionActionScope,
  ...Azure.ResourceManager.Legacy.Provider,
  subscriptionId: Azure.Core.uuid,
  body: AcceptOwnershipRequest,
): ArmAcceptedResponse & ArmLroLocationHeader;

@@override(SubscriptionOperationGroup.acceptOwnership,
  subscriptionAcceptOwnership,
  "javascript"
);

/**
 * override for SubscriptionOperationGroup.cancel
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op subscriptionCancel(
  ...ApiVersionParameter,
  subscriptionId: Azure.Core.uuid,
  ...SubscriptionActionScope,
  ...Azure.ResourceManager.Legacy.Provider,
  body: void,
): CanceledSubscriptionId | Azure.ResourceManager.CommonTypes.ErrorResponse;

@@override(SubscriptionOperationGroup.cancel, subscriptionCancel, "javascript");

/**
 * override for SubscriptionOperationGroup.enable
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op subscriptionEnable(
  ...ApiVersionParameter,
  subscriptionId: Azure.Core.uuid,
  ...SubscriptionActionScope,
  ...Azure.ResourceManager.Legacy.Provider,
  body: void,
): EnabledSubscriptionId | Azure.ResourceManager.CommonTypes.ErrorResponse;

@@override(SubscriptionOperationGroup.enable, subscriptionEnable, "javascript");

/**
 * override for SubscriptionOperationGroup.rename
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "customization"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "override"
op subscriptionRename(
  ...ApiVersionParameter,
  subscriptionId: Azure.Core.uuid,
  ...SubscriptionActionScope,
  ...Azure.ResourceManager.Legacy.Provider,
  body: SubscriptionName,
): RenamedSubscriptionId | Azure.ResourceManager.CommonTypes.ErrorResponse;

@@override(SubscriptionOperationGroup.rename, subscriptionRename, "javascript");
