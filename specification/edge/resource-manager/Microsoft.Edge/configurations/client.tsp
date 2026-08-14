import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

// The Go emitter does not support inline union types (string | Record<unknown>).
// Use @@alternateType scoped to "go" to replace them with Record<unknown> for Go SDK only.
@@alternateType(
  Microsoft.Edge.DynamicConfigurationVersionProperties.values,
  Record<unknown>,
  "go"
);
