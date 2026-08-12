import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Microsoft.Resources;

@@clientLocation(
  Subscriptions.checkZonePeers::parameters.subscriptionId,
  Subscriptions.checkZonePeers
);
@@clientLocation(
  Subscriptions.listLocations::parameters.subscriptionId,
  Subscriptions.listLocations
);
@@clientLocation(
  Subscriptions.get::parameters.subscriptionId,
  Subscriptions.get
);

@@clientName(Microsoft.Resources, "SubscriptionClient", "javascript,python");
@@clientLocation(checkResourceName, "SubscriptionClient", "go");

@@clientName(Microsoft.Resources, "SubscriptionClient", "java");
@@alternateType(
  CloudError.error,
  Azure.ResourceManager.CommonTypes.ErrorDetail,
  "java"
);
@@clientLocation(checkResourceName, "ResourceNames", "java");
@@scope(Operations.list, "!java");
