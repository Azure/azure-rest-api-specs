import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Microsoft.Resources;

@@clientLocation(Subscriptions.checkZonePeers::parameters.subscriptionId,
  Subscriptions.checkZonePeers
);
@@clientName(Microsoft.Resources, "SubscriptionClient", "javascript");
