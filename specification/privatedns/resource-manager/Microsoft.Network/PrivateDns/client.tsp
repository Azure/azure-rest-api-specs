import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Azure.ClientGenerator.Core;

@@clientName(Microsoft.Network, "PrivateDnsManagementClient", "javascript");
@@clientName(Microsoft.Network, "PrivateDnsManagementClient", "java");
