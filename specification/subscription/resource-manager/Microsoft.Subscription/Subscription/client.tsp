import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
namespace Microsoft.Subscription;

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

@@Azure.ClientGenerator.Core.clientInitialization(SubscriptionsOperationGroup,
  {
    parameters: Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
  }
);

@@Azure.ClientGenerator.Core.clientInitialization(TargetDirectoryResults,
  {
    parameters: Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
  }
);
