import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.ClientGenerator.Core.Legacy;
using Azure.Core;
namespace Microsoft.Subscription;

@@clientName(Microsoft.Subscription, "SubscriptionClient", "python");
@@clientName(
  SubscriptionOperationGroup.acceptOwnership::parameters.body,
  "requestbody_body",
  "python"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@flattenProperty(PutAliasRequest.properties, "csharp");

@@scope(SubscriptionOperationOperationGroup.get, "!csharp"); // Get operation status is not needed in SDK which has this functionality in in core lib.
@@scope(GetTenantPolicyResponses.listPolicyForTenant, "!csharp"); // Singleton, no need to have list operation in sdk.
@@scope(TargetDirectoryResults.listTargetDirectory, "!csharp"); // Singleton, no need to have list operation in sdk.

@@clientName(SubscriptionAliasResponse, "SubscriptionAlias", "csharp");
@@clientName(
  SubscriptionAliasResponseProperties,
  "SubscriptionAliasProperties",
  "csharp"
);
@@clientName(BillingAccountPoliciesResponse, "BillingAccountPolicy", "csharp");
@@clientName(
  BillingAccountPoliciesResponseProperties,
  "BillingAccountPolicyProperties",
  "csharp"
);
@@clientName(GetTenantPolicyResponse, "TenantPolicy", "csharp");
@@clientName(TenantPolicy, "TenantPolicyProperties", "csharp");
@@clientName(GetTenantPolicyListResponse, "TenantPoliciesResult", "csharp");
@@clientName(AcceptOwnershipStatusResponse, "AcceptOwnershipStatus", "csharp");
@@clientName(AcceptOwnership, "AcceptOwnershipState", "csharp");
@@clientName(Provisioning, "AcceptOwnershipProvisioningState", "csharp");
@@clientName(ProvisioningState, "SubscriptionProvisioningState", "csharp");
@@clientName(
  PutAliasRequestAdditionalProperties,
  "SubscriptionAliasAdditionalProperties",
  "csharp"
);
@@clientName(ServiceTenantResponse, "ServiceTenant", "csharp");
@@clientName(Workload, "SubscriptionWorkload", "csharp");
@@clientName(
  SubscriptionAliasResponseProperties.acceptOwnershipUrl,
  "acceptOwnershipUri",
  "csharp"
);
@@alternateType(
  SubscriptionAliasResponseProperties.acceptOwnershipUrl,
  url,
  "csharp"
);
@@clientName(
  SubscriptionAliasResponseProperties.createdTime,
  "createdOn",
  "csharp"
);
@@alternateType(
  SubscriptionAliasResponseProperties.createdTime,
  utcDateTime,
  "csharp"
);
@@clientName(AcceptOwnershipRequest, "AcceptOwnershipContent", "csharp");
@@clientName(
  PutAliasRequest,
  "SubscriptionAliasCreateOrUpdateContent",
  "csharp"
);
@@clientName(
  PutTenantPolicyRequestProperties,
  "TenantPolicyCreateOrUpdateContent",
  "csharp"
);
@@clientName(TargetDirectoryRequest, "TargetDirectoryContent", "csharp");
@@clientName(
  TargetDirectoryRequestProperties,
  "TargetDirectoryProperties",
  "csharp"
);
@@clientName(
  SubscriptionOperationGroup.acceptOwnership,
  "AcceptSubscriptionOwnership",
  "csharp"
);
@@clientName(
  SubscriptionOperationGroup.acceptOwnershipStatus,
  "GetAcceptOwnershipStatus",
  "csharp"
);
@@clientName(SubscriptionOperationGroup.cancel, "CancelSubscription", "csharp");
@@clientName(SubscriptionOperationGroup.rename, "RenameSubscription", "csharp");
@@clientName(SubscriptionOperationGroup.enable, "EnableSubscription", "csharp");
@@alternateType(
  TargetDirectoryRequestProperties.destinationOwnerId,
  uuid,
  "csharp"
);
@@alternateType(
  TargetDirectoryRequestProperties.destinationOwnerId,
  uuid,
  "csharp"
);
@@alternateType(
  TargetDirectoryRequestProperties.destinationTenantId,
  uuid,
  "csharp"
);
@@alternateType(
  TargetDirectoryResultProperties.destinationTenantId,
  uuid,
  "csharp"
);
@@alternateType(
  TargetDirectoryResultProperties.destinationOwnerId,
  uuid,
  "csharp"
);
@@alternateType(TargetDirectoryResultProperties.sourceOwnerId, uuid, "csharp");
@@alternateType(TargetDirectoryResultProperties.sourceTenantId, uuid, "csharp");
@@clientName(
  SubscriptionName.subscriptionName,
  "SubscriptionNameValue",
  "csharp"
);

@@clientLocation(
  SubscriptionOperationGroup.cancel::parameters.subscriptionId,
  SubscriptionOperationGroup.cancel
);
@@clientLocation(
  SubscriptionOperationGroup.rename::parameters.subscriptionId,
  SubscriptionOperationGroup.rename
);
@@clientLocation(
  SubscriptionOperationGroup.enable::parameters.subscriptionId,
  SubscriptionOperationGroup.enable
);
@@clientLocation(
  SubscriptionOperationGroup.acceptOwnership::parameters.subscriptionId,
  SubscriptionOperationGroup.acceptOwnership
);
@@clientLocation(
  SubscriptionOperationGroup.acceptOwnershipStatus::parameters.subscriptionId,
  SubscriptionOperationGroup.acceptOwnershipStatus
);

@@clientLocation(
  SubscriptionsOperationGroup.acceptTargetDirectory::parameters.subscriptionId,
  SubscriptionsOperationGroup.acceptTargetDirectory
);
@@clientLocation(
  SubscriptionsOperationGroup.targetDirectoryStatus::parameters.subscriptionId,
  SubscriptionsOperationGroup.targetDirectoryStatus
);

@@clientLocation(
  Microsoft.Subscription.SubscriptionOperationGroup.cancel,
  "Subscriptions",
  "java"
);
@@clientLocation(
  Microsoft.Subscription.SubscriptionOperationGroup.rename,
  "Subscriptions",
  "java"
);
@@clientLocation(
  Microsoft.Subscription.SubscriptionOperationGroup.enable,
  "Subscriptions",
  "java"
);
@@clientLocation(
  Microsoft.Subscription.SubscriptionOperationGroup.acceptOwnership,
  "Subscriptions",
  "java"
);
@@clientLocation(
  Microsoft.Subscription.SubscriptionOperationGroup.acceptOwnershipStatus,
  "Subscriptions",
  "java"
);

@@clientLocation(
  GetTargetDirectoryBaseParameters.subscriptionId,
  TargetDirectoryResults.getTargetDirectory
);
@@clientLocation(
  PutTargetDirectoryBaseParameters.subscriptionId,
  TargetDirectoryResults.putTargetDirectory
);
@@clientLocation(
  DeleteTargetDirectoryBaseParameters.subscriptionId,
  TargetDirectoryResults.deleteTargetDirectory
);
@@clientLocation(
  ListTargetDirectoryBaseParameters.subscriptionId,
  TargetDirectoryResults.listTargetDirectory
);
