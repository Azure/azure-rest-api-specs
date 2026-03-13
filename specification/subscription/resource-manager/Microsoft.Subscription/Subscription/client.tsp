import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
namespace Microsoft.Subscription;

@@clientLocation(SubscriptionIdParameter.subscriptionId,
  SubscriptionOperationGroup.acceptOwnership
);
@@clientLocation(SubscriptionIdParameter.subscriptionId,
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
  "java,javascript"
);
@@clientLocation(Microsoft.Subscription.SubscriptionOperationGroup.rename,
  "SubscriptionOperation",
  "java,javascript"
);
@@clientLocation(Microsoft.Subscription.SubscriptionOperationGroup.enable,
  "SubscriptionOperation",
  "java,javascript"
);
@@clientLocation(Microsoft.Subscription.SubscriptionOperationGroup.acceptOwnership,
  "Subscriptions",
  "java,javascript"
);
@@clientLocation(Microsoft.Subscription.SubscriptionOperationGroup.acceptOwnershipStatus,
  "Subscriptions",
  "java,javascript"
);
