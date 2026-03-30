import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
namespace Microsoft.Subscription;

@@clientName(Microsoft.Subscription, "SubscriptionClient", "python");
@@clientName(SubscriptionOperationGroup.acceptOwnership::parameters.body,
  "requestbody_body",
  "python"
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
