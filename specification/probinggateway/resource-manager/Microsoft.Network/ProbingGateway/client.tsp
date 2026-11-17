import "@azure-tools/typespec-client-generator-core";

import "./main.tsp";

using Azure.ClientGenerator.Core;

namespace Microsoft.Network {
  @@access(ProbingGateways.createTopologyReference, Access.internal);
}
