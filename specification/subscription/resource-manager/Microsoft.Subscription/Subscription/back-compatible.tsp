import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Subscription;

@@clientLocation(SubscriptionAliasResponses.get, "Alias");
@@clientLocation(SubscriptionAliasResponses.create, "Alias");
@@clientName(SubscriptionAliasResponses.create::parameters.resource, "body");
@@clientLocation(SubscriptionAliasResponses.delete, "Alias");
@@clientLocation(SubscriptionAliasResponses.list, "Alias");

@@clientLocation(GetTenantPolicyResponses.getPolicyForTenant,
  "SubscriptionPolicy"
);
@@clientLocation(GetTenantPolicyResponses.addUpdatePolicyForTenant,
  "SubscriptionPolicy"
);
@@clientName(GetTenantPolicyResponses.addUpdatePolicyForTenant::parameters.resource,
  "body"
);
@@clientLocation(GetTenantPolicyResponses.listPolicyForTenant,
  "SubscriptionPolicy"
);

@@clientLocation(BillingAccountPoliciesResponses.getPolicy, "BillingAccount");

@@clientLocation(TargetDirectoryResults.getTargetDirectory, "Subscriptions");
@@clientLocation(TargetDirectoryResults.putTargetDirectory, "Subscriptions");
@@clientName(TargetDirectoryResults.putTargetDirectory::parameters.resource,
  "body"
);
@@clientLocation(TargetDirectoryResults.deleteTargetDirectory, "Subscriptions");
@@clientLocation(TargetDirectoryResults.listTargetDirectory, "Subscriptions");

@@clientLocation(SubscriptionOperationGroup.cancel, "Subscription");
@@clientLocation(SubscriptionOperationGroup.rename, "Subscription");
@@clientLocation(SubscriptionOperationGroup.enable, "Subscription");
@@clientLocation(SubscriptionOperationGroup.acceptOwnership, "Subscription");
@@clientLocation(SubscriptionOperationGroup.acceptOwnershipStatus,
  "Subscription"
);

@@clientLocation(SubscriptionOperationOperationGroup.get,
  "SubscriptionOperation"
);

@@clientLocation(SubscriptionsOperationGroup.acceptTargetDirectory,
  "Subscriptions"
);
@@clientLocation(SubscriptionsOperationGroup.targetDirectoryStatus,
  "Subscriptions"
);
