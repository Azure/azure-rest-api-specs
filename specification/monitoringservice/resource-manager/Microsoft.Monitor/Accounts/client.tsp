import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Microsoft.Monitor;
using Azure.ClientGenerator.Core;

// Rename Origin model to avoid conflict with the Origin enum from
// common-types/v6/types.json (x-ms-enum on Operation.origin).
@@clientName(Microsoft.Monitor.Origin, "IssueOrigin", "python");
@@clientName(Microsoft.Monitor.Origin, "IssueOrigin", "csharp");
@@clientName(Microsoft.Monitor.Origin, "IssueOrigin", "go");
