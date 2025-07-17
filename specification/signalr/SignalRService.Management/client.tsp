import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;

// Client name mappings to match the existing Java SDK naming conventions
@@clientName(Microsoft.SignalRService.NetworkACL, "NetworkAcl", "java");
@@clientName(Microsoft.SignalRService.PrivateEndpointACL,
  "PrivateEndpointAcl",
  "java"
);
@@clientName(Microsoft.SignalRService.ACLAction, "AclAction", "java");
