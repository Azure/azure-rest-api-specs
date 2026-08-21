import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

// The Go emitter does not support inline union types (string | Record<unknown>).
// Use @@alternateType scoped to "go" to replace them with Record<unknown> for Go SDK only.
@@alternateType(
  Microsoft.Edge.SchemaVersionProperties.value,
  Record<unknown>,
  "go"
);

@@alternateType(
  Microsoft.Edge.ConfigTemplateSchemaProperties.value,
  Record<unknown>,
  "go"
);

@@alternateType(
  Microsoft.Edge.ConfigTemplateVersionProperties.configurations,
  Record<unknown>,
  "go"
);

@@alternateType(
  Microsoft.Edge.SolutionSchemaProperties.value,
  Record<unknown>,
  "go"
);

@@alternateType(
  Microsoft.Edge.SolutionTemplateVersionProperties.configurations,
  Record<unknown>,
  "go"
);

@@alternateType(
  Microsoft.Edge.SolutionVersionProperties.configuration,
  Record<unknown>,
  "go"
);

@@alternateType(
  Microsoft.Edge.SolutionVersionProperties.targetLevelConfiguration,
  Record<unknown>,
  "go"
);
