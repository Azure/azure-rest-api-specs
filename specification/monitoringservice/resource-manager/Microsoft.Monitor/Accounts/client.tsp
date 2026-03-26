import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Microsoft.Monitor;
using Azure.ClientGenerator.Core;

// Rename Origin model to avoid conflict with the Origin enum from
// common-types/v6/types.json (x-ms-enum on Operation.origin).
// The Python SDK emitter raises:
//   ValueError: We have models and enums sharing the following names: Origin
@@clientName(Microsoft.Monitor.Origin, "IssueOrigin", "python");
