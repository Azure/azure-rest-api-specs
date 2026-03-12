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

@@clientName(Microsoft.Subscription.SubscriptionAliasResponse,
  "PutAliasResponse",
  "java"
);
@@clientName(Microsoft.Subscription.SubscriptionAliasResponseProperties,
  "PutAliasResponseProperties",
  "java"
);

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
