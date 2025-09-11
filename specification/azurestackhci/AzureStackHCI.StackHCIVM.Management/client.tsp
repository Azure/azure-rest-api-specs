import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.AzureStackHCI, "AzureStackHCIVmClient", "python");
@@clientName(Microsoft.AzureStackHCI, "AzureStackHciVmMgmtClient", "java");
@@clientName(Microsoft.AzureStackHCI,
  "AzureStackHCIVMManagementClient",
  "javascript"
);
@@clientName(Microsoft.AzureStackHCI,
  "AzureStackHCIVMManagementClient",
  "csharp"
);
@@clientName(Route, "AzureStackHCIVMNetworkingRoute", "csharp");
@@clientName(Subnet, "AzureStackHCIVMNetworkingSubnet", "csharp");
@@clientName(Status, "AzureStackHCIVMStatus", "csharp");
@@clientName(StatusType, "AzureStackHCIVStatusType", "csharp");
@@clientName(SecurityType, "AzureStackHCIVMSecurityType", "csharp");
@@clientName(IPPool, "AzureStackHCIVMNeworkingIPPool", "csharp");
