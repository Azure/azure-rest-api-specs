import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";
using Azure.ClientGenerator.Core;
using Microsoft.DataBoxEdge;

@@clientName(DataBoxEdgeSku, "AvailableDataBoxEdgeSku", "csharp");

// Java specific mitigations for breaking changes
@@clientName(SSLStatus, "SslStatus", "java");
@@clientName(NetworkAdapterDHCPStatus, "NetworkAdapterDhcpStatus", "java");
@@clientName(NetworkAdapterRDMAStatus, "NetworkAdapterRdmaStatus", "java");
@@clientName(ARMBaseModel, "ArmBaseModel", "java");
@@clientName(RefreshDetails.lastCompletedRefreshJobTimeInUTC,
  "lastCompletedRefreshJobTimeInUtc",
  "java"
);
@@clientName(StorageAccountCredentialProperties.userName, "username", "java");
@@clientName(Microsoft.DataBoxEdge,
  "DataBoxEdgeManagementClient",
  "javascript"
);
