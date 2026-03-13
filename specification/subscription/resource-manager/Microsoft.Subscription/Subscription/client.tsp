import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
namespace Microsoft.Subscription;

@@clientLocation(Azure.ResourceManager.SubscriptionIdParameter.subscriptionId,
  SubscriptionOperationGroup.acceptOwnership
);
@@clientLocation(Azure.ResourceManager.SubscriptionIdParameter.subscriptionId,
  SubscriptionOperationGroup.acceptOwnershipStatus
);

@@clientLocation(CanceledSubscriptionId.subscriptionId,
  SubscriptionOperationGroup.rename
);
@@clientLocation(CanceledSubscriptionId.subscriptionId,
  SubscriptionOperationGroup.enable
);
@@clientLocation(CanceledSubscriptionId.subscriptionId,
  SubscriptionOperationGroup.cancel
);

@@clientName(Microsoft.Subscription, "SubscriptionClient", "python");

@@clientLocation(Microsoft.Subscription.SubscriptionOperationGroup.cancel,
  "SubscriptionOperation",
  "java"
);
@@clientLocation(Microsoft.Subscription.SubscriptionOperationGroup.rename,
  "SubscriptionOperation",
  "java"
);
@@clientLocation(Microsoft.Subscription.SubscriptionOperationGroup.enable,
  "SubscriptionOperation",
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

// Route cancel/rename/enable/acceptOwnership/acceptOwnershipStatus to "SubscriptionOperation"
// for Java to keep them on models.SubscriptionOperations (matching old SDK)
@@clientLocation(Microsoft.Subscription.SubscriptionOperationGroup.cancel,
  "SubscriptionOperation",
  "java"
);
@@clientLocation(Microsoft.Subscription.SubscriptionOperationGroup.rename,
  "SubscriptionOperation",
  "java"
);
@@clientLocation(Microsoft.Subscription.SubscriptionOperationGroup.enable,
  "SubscriptionOperation",
  "java"
);
@@clientLocation(Microsoft.Subscription.SubscriptionOperationGroup.acceptOwnership,
  "SubscriptionOperation",
  "java"
);
@@clientLocation(Microsoft.Subscription.SubscriptionOperationGroup.acceptOwnershipStatus,
  "SubscriptionOperation",
  "java"
);

@@clientName(Microsoft.Subscription.ServiceTenantResponse,
  "TenantIdDescription",
  "java"
);
