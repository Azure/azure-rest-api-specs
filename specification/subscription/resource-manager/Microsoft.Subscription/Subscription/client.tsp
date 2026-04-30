import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
namespace Microsoft.Subscription;

@@clientName(Microsoft.Subscription, "SubscriptionClient", "python");

// The interface 'SubscriptionOperationGroup' is mapped to a client named 'Subscription'
// (the 'OperationGroup' suffix is stripped). That collides with the package's last
// namespace segment ('Azure.ResourceManager.Subscription') and causes the C# generator
// to escape the namespace as '_Subscription'. Rename the client for the C# scope to
// avoid the collision; the operations remain in the same namespace.
@@clientName(SubscriptionOperationGroup, "SubscriptionAction", "csharp");
@@clientName(SubscriptionOperationOperationGroup, "SubscriptionOperation", "csharp");
@@clientName(SubscriptionsOperationGroup, "Subscriptions", "csharp");

// back-compatible.tsp moves SubscriptionOperationGroup.* into a client literally
// named "Subscription", which collides with the namespace last segment. Override
// these placements for the C# scope so the resulting client is not named
// "Subscription".
@@clientLocation(SubscriptionOperationGroup.cancel, "SubscriptionAction", "csharp");
@@clientLocation(SubscriptionOperationGroup.rename, "SubscriptionAction", "csharp");
@@clientLocation(SubscriptionOperationGroup.enable, "SubscriptionAction", "csharp");
@@clientLocation(SubscriptionOperationGroup.acceptOwnership,
  "SubscriptionAction",
  "csharp"
);
@@clientLocation(SubscriptionOperationGroup.acceptOwnershipStatus,
  "SubscriptionAction",
  "csharp"
);
@@clientName(SubscriptionOperationGroup.acceptOwnership::parameters.body,
  "requestbody_body",
  "python"
);

// C# customizations to preserve GA SDK class names from the previous AutoRest mapping.
@@clientName(SubscriptionAliasResponse, "SubscriptionAlias", "csharp");
@@clientName(SubscriptionAliasResponseProperties,
  "SubscriptionAliasProperties",
  "csharp"
);
@@clientName(BillingAccountPoliciesResponse, "BillingAccountPolicy", "csharp");
@@clientName(BillingAccountPoliciesResponseProperties,
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
@@clientName(PutAliasRequestAdditionalProperties,
  "SubscriptionAliasAdditionalProperties",
  "csharp"
);
@@clientName(ServiceTenantResponse, "ServiceTenant", "csharp");
@@clientName(Workload, "SubscriptionWorkload", "csharp");

// Property name + type mappings to preserve GA SDK property surfaces.
@@clientName(SubscriptionAliasResponseProperties.acceptOwnershipUrl,
  "acceptOwnershipUri",
  "csharp"
);
@@alternateType(SubscriptionAliasResponseProperties.acceptOwnershipUrl,
  url,
  "csharp"
);
@@clientName(SubscriptionAliasResponseProperties.createdTime,
  "createdOn",
  "csharp"
);
@@alternateType(SubscriptionAliasResponseProperties.createdTime,
  utcDateTime,
  "csharp"
);

// Avoid AZC0030: model names ending in 'Request' / Resolve to GA names where possible.
@@clientName(AcceptOwnershipRequest, "AcceptOwnershipContent", "csharp");
@@clientName(PutAliasRequest, "SubscriptionAliasCreateOrUpdateContent", "csharp");
@@clientName(PutAliasRequestProperties,
  "SubscriptionAliasCreateOrUpdateProperties",
  "csharp"
);
@@clientName(PutTenantPolicyRequestProperties,
  "TenantPolicyCreateOrUpdateContent",
  "csharp"
);
@@clientName(TargetDirectoryRequest, "TargetDirectoryContent", "csharp");
@@clientName(TargetDirectoryRequestProperties,
  "TargetDirectoryProperties",
  "csharp"
);

// Disambiguate list operations whose generated rest method name collides with the corresponding GET.
// (Move them to a separate client group so they end up in their own rest-operations file.)
@@clientLocation(GetTenantPolicyResponses.listPolicyForTenant,
  "TenantPolicies",
  "csharp"
);
@@clientLocation(TargetDirectoryResults.listTargetDirectory,
  "TargetDirectoryList",
  "csharp"
);

@@Azure.ClientGenerator.Core.clientLocation(SubscriptionOperationGroup.cancel::parameters.subscriptionId,
  SubscriptionOperationGroup.cancel
);
@@Azure.ClientGenerator.Core.clientLocation(SubscriptionOperationGroup.rename::parameters.subscriptionId,
  SubscriptionOperationGroup.rename
);
@@Azure.ClientGenerator.Core.clientLocation(SubscriptionOperationGroup.enable::parameters.subscriptionId,
  SubscriptionOperationGroup.enable
);
@@Azure.ClientGenerator.Core.clientLocation(SubscriptionOperationGroup.acceptOwnership::parameters.subscriptionId,
  SubscriptionOperationGroup.acceptOwnership
);
@@Azure.ClientGenerator.Core.clientLocation(SubscriptionOperationGroup.acceptOwnershipStatus::parameters.subscriptionId,
  SubscriptionOperationGroup.acceptOwnershipStatus
);

@@Azure.ClientGenerator.Core.clientLocation(SubscriptionsOperationGroup.acceptTargetDirectory::parameters.subscriptionId,
  SubscriptionsOperationGroup.acceptTargetDirectory
);
@@Azure.ClientGenerator.Core.clientLocation(SubscriptionsOperationGroup.targetDirectoryStatus::parameters.subscriptionId,
  SubscriptionsOperationGroup.targetDirectoryStatus
);

@@clientLocation(Microsoft.Subscription.SubscriptionOperationGroup.cancel,
  "Subscriptions",
  "java"
);
@@clientLocation(Microsoft.Subscription.SubscriptionOperationGroup.rename,
  "Subscriptions",
  "java"
);
@@clientLocation(Microsoft.Subscription.SubscriptionOperationGroup.enable,
  "Subscriptions",
  "java"
);
@@clientLocation(Microsoft.Subscription.SubscriptionOperationGroup.acceptOwnership,
  "Subscriptions",
  "java"
);
@@clientLocation(Microsoft.Subscription.SubscriptionOperationGroup.acceptOwnershipStatus,
  "Subscriptions",
  "java"
);

@@Azure.ClientGenerator.Core.clientLocation(GetTargetDirectoryBaseParameters.subscriptionId,
  TargetDirectoryResults.getTargetDirectory
);
@@Azure.ClientGenerator.Core.clientLocation(PutTargetDirectoryBaseParameters.subscriptionId,
  TargetDirectoryResults.putTargetDirectory
);
@@Azure.ClientGenerator.Core.clientLocation(DeleteTargetDirectoryBaseParameters.subscriptionId,
  TargetDirectoryResults.deleteTargetDirectory
);
@@Azure.ClientGenerator.Core.clientLocation(ListTargetDirectoryBaseParameters.subscriptionId,
  TargetDirectoryResults.listTargetDirectory
);
