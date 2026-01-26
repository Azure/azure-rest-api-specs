import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

// Rename DiscoveryStorage to ManagedStorage for Go SDK to avoid collision with Storage type
// after the Go emitter removes the "Discovery" prefix
@@clientName(Microsoft.Discovery.DiscoveryStorage,
  "DiscoveryManagedStorage",
  "go"
);
