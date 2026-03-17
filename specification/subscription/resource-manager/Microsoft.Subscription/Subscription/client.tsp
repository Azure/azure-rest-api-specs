import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
namespace Microsoft.Subscription;

@@clientName(Microsoft.Subscription, "SubscriptionClient", "python");

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

@@clientLocation(SubscriptionOperationGroup.cancel, "Subscriptions", "java");
@@clientLocation(SubscriptionOperationGroup.rename, "Subscriptions", "java");
@@clientLocation(SubscriptionOperationGroup.enable, "Subscriptions", "java");
@@clientLocation(SubscriptionOperationGroup.acceptOwnership,
  "Subscriptions",
  "java"
);
@@clientLocation(SubscriptionOperationGroup.acceptOwnershipStatus,
  "Subscriptions",
  "java"
);
