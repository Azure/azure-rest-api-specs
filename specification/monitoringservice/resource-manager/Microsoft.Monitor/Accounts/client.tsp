import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Microsoft.Monitor;
using Azure.ClientGenerator.Core;

// Rename the Origin enum (from common-types Operation.origin) to avoid
// conflict with the Origin model in issues/models.tsp.
// The Python SDK emitter raises:
//   ValueError: We have models and enums sharing the following names: Origin
@@clientName(Azure.ResourceManager.CommonTypes.Origin,
  "OperationOrigin",
  "python"
);
