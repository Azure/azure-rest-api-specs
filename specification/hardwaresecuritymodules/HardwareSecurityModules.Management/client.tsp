import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Microsoft.HardwareSecurityModules;
using Azure.ClientGenerator.Core;

@@clientName(Microsoft.HardwareSecurityModules,
  "HardwareSecurityModulesMgmtClient",
  "python"
);
@@clientName(CloudHsmClusters.cloudHsmClusterBackupStatusGet, "GetCloudHsmClusterBackupStatus", "csharp");
@@clientName(CloudHsmClusters.cloudHsmClusterRestoreStatusGet, "GetCloudHsmClusterRestoreStatus", "csharp");
