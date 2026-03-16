import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
namespace Microsoft.Subscription;

@@clientName(Microsoft.Subscription, "SubscriptionClient", "python");

@@Azure.ClientGenerator.Core.clientLocation(SubscriptionOperationGroup.acceptOwnership::parameters.subscriptionId,
  SubscriptionOperationGroup.acceptOwnership
);
@@Azure.ClientGenerator.Core.clientLocation(SubscriptionOperationGroup.acceptOwnershipStatus::parameters.subscriptionId,
  SubscriptionOperationGroup.acceptOwnershipStatus
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
