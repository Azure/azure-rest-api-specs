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
