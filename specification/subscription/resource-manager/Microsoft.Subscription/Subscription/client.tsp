import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
namespace Microsoft.Subscription;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SubscriptionIdClientOptions {
  ...SubscriptionIdParameter;
}

@@clientInitialization(Microsoft.Subscription,
  {
    parameters: SubscriptionIdClientOptions,
  }
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SubscriptionIdOptionalClientOptions {
  @visibility(Lifecycle.Read)
  subscriptionId?: string;
}

@@clientInitialization(Microsoft.Subscription,
  {
    parameters: SubscriptionIdOptionalClientOptions,
  }
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
