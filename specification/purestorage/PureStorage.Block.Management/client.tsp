import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace PureStorage.Block.Client {
  // Client-specific naming overrides
  @@clientName(PureStorage.Block.HealthResponse, "StoragePoolHealthInfo");
  @@clientName(PureStorage.Block.ServiceInitializationData, "ServiceInitializationInfo");
}