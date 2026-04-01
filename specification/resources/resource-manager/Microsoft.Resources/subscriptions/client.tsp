import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Microsoft.Resources;

@@clientLocation(Subscriptions.checkZonePeers::parameters.subscriptionId,
  Subscriptions.checkZonePeers
);
@@clientLocation(Subscriptions.listLocations::parameters.subscriptionId,
  Subscriptions.listLocations
);
@@clientLocation(Subscriptions.get::parameters.subscriptionId,
  Subscriptions.get
);

@@clientName(Microsoft.Resources, "SubscriptionClient", "javascript,python");
@@clientLocation(checkResourceName, "SubscriptionClient", "go");
