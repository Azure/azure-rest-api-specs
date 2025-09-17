import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Azure.ClientGenerator.Core;
using Microsoft.ServiceBus;

@@clientName(Microsoft.ServiceBus, "ServiceBusManagementClient", "javascript");

@@clientName(NetworkRuleIPAction, "NetworkRuleIpAction", "java");
