import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Subscription;

@@clientLocation(SubscriptionAliasResponses.get, "Alias", "!csharp");
@@clientLocation(SubscriptionAliasResponses.create, "Alias", "!csharp");
@@clientName(SubscriptionAliasResponses.create::parameters.resource, "body");
@@clientLocation(SubscriptionAliasResponses.delete, "Alias", "!csharp");
@@clientLocation(SubscriptionAliasResponses.list, "Alias", "!csharp");

@@clientLocation(
  GetTenantPolicyResponses.getPolicyForTenant,
  "SubscriptionPolicy",
  "!csharp"
);
@@clientLocation(
  GetTenantPolicyResponses.addUpdatePolicyForTenant,
  "SubscriptionPolicy",
  "!csharp"
);
@@clientName(
  GetTenantPolicyResponses.addUpdatePolicyForTenant::parameters.resource,
  "body"
);
@@clientLocation(
  GetTenantPolicyResponses.listPolicyForTenant,
  "SubscriptionPolicy",
  "!csharp"
);

@@clientLocation(
  BillingAccountPoliciesResponses.getPolicy,
  "BillingAccount",
  "!csharp"
);

@@clientLocation(
  TargetDirectoryResults.getTargetDirectory,
  "Subscriptions",
  "!csharp"
);
@@clientLocation(
  TargetDirectoryResults.putTargetDirectory,
  "Subscriptions",
  "!csharp"
);
@@clientName(
  TargetDirectoryResults.putTargetDirectory::parameters.resource,
  "body"
);
@@clientLocation(
  TargetDirectoryResults.deleteTargetDirectory,
  "Subscriptions",
  "!csharp"
);
@@clientLocation(
  TargetDirectoryResults.listTargetDirectory,
  "Subscriptions",
  "!csharp"
);

@@clientLocation(SubscriptionOperationGroup.cancel, "Subscription", "!csharp");
@@clientLocation(SubscriptionOperationGroup.rename, "Subscription", "!csharp");
@@clientLocation(SubscriptionOperationGroup.enable, "Subscription", "!csharp");
@@clientLocation(
  SubscriptionOperationGroup.acceptOwnership,
  "Subscription",
  "!csharp"
);
@@clientLocation(
  SubscriptionOperationGroup.acceptOwnershipStatus,
  "Subscription",
  "!csharp"
);

@@clientLocation(
  SubscriptionOperationOperationGroup.get,
  "SubscriptionOperation",
  "!csharp"
);

@@clientLocation(
  SubscriptionsOperationGroup.acceptTargetDirectory,
  "Subscriptions",
  "!csharp"
);
@@clientLocation(
  SubscriptionsOperationGroup.targetDirectoryStatus,
  "Subscriptions",
  "!csharp"
);
