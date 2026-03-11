import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.Subscription, "SubscriptionClient", "python");

@@clientName(Microsoft.Subscription.SubscriptionAliasResponse,
  "PutAliasResponse",
  "java"
);
@@clientName(Microsoft.Subscription.SubscriptionAliasResponseProperties,
  "PutAliasResponseProperties",
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
