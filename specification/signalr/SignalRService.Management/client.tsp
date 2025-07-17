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

// Property name mappings to maintain backward compatibility
@@clientName(Microsoft.SignalRService.SignalRProperties.externalIP,
  "externalIp",
  "java"
);
@@clientName(Microsoft.SignalRService.SignalRProperties.hostName,
  "hostname",
  "java"
);
@@clientName(Microsoft.SignalRService.SignalRProperties.hostNamePrefix,
  "hostnamePrefix",
  "java"
);
