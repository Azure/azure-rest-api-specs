import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ManagedOps;

@@clientName(Microsoft.ManagedOps, "ManagedOpsMgmtClient", "python");
@@clientName(ManagedOps, "ManagedOperations", "csharp");
@@clientName(AzureMonitorInformation,
  "ManagedOpsAzureMonitorInformation",
  "csharp"
);
@@clientName(ChangeTrackingInformation,
  "ManagedOpsChangeTrackingInformation",
  "csharp"
);
@@clientName(EnablementState, "ManagedOpsEnablementStatus", "csharp");
@@clientName(ProvisioningState, "ManagedOpsProvisioningState", "csharp");
@@clientName(ServiceInformation, "ManagedOpsServiceInformation", "csharp");
@@clientName(DesiredConfiguration, "ManagedOpsDesiredConfiguration", "csharp");
@@clientName(DesiredConfigurationUpdate,
  "ManagedOpsDesiredConfigurationUpdate",
  "csharp"
);
@@clientName(DesiredEnablementState,
  "ManagedOpsDesiredEnablementState",
  "csharp"
);
