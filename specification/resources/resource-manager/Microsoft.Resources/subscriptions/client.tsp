import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

namespace Microsoft.Resources;

@@Azure.ClientGenerator.Core.clientLocation(Subscriptions.checkZonePeers::parameters.subscriptionId,
  Subscriptions.checkZonePeers
);
