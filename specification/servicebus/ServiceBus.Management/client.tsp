import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Azure.ClientGenerator.Core;
using Microsoft.ServiceBus;

@@clientName(Microsoft.ServiceBus, "ServiceBusManagementClient", "javascript");

@@clientName(NetworkRuleIPAction, "NetworkRuleIpAction", "java");

// Fix TLS version naming changes for Go SDK compatibility
@@clientName(TlsVersion.`1.0`, "One0", "go");
@@clientName(TlsVersion.`1.1`, "One1", "go");
@@clientName(TlsVersion.`1.2`, "One2", "go");
