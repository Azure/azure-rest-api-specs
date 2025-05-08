import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

  // Client-specific naming overrides
  @@clientName(HealthResponse, "StoragePoolHealthInfo");
  @@clientName(ServiceInitializationData, "ServiceInitializationInfo");