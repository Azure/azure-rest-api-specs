import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.SignalRService;

// Client name mappings to match the existing Java SDK naming conventions
@@clientName(NetworkACL, "NetworkAcl", "java");
@@clientName(PrivateEndpointACL, "PrivateEndpointAcl", "java");
@@clientName(ACLAction, "AclAction", "java");

// Property name mappings to maintain backward compatibility
@@clientName(SignalRProperties.externalIP, "externalIp", "java");
@@clientName(SignalRProperties.hostName, "hostname", "java");
@@clientName(SignalRProperties.hostNamePrefix, "hostnamePrefix", "java");
