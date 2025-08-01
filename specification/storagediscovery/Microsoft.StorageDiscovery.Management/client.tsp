import "./main.tsp";
import "./workspace.tsp";
import "./report.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.StorageDiscovery;

// suppress report operations
@@scope(StorageDiscoveryWorkspaces.report,
  "!(python,javascript,go,java,csharp)"
);
@@scope(Report.get, "!(python,javascript,go,java,csharp)");
@@scope(Report.generateReport, "!(python,javascript,go,java,csharp)");
@@scope(Report.listByResourceGroup, "!(python,javascript,go,java,csharp)");
@@scope(Report.listBySubscription, "!(python,javascript,go,java,csharp)");

@@clientName(Microsoft.StorageDiscovery,
  "StorageDiscoveryMgmtClient",
  "python"
);

@@clientName(Azure.ResourceManager.ResourceProvisioningState,
  "StorageDiscoveryProvisioningState",
  "csharp"
);
