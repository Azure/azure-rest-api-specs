import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Microsoft.OnlineExperimentation;

@@clientName(Microsoft.OnlineExperimentation,
  "OnlineExperimentationMgmtClient",
  "java"
);

@@clientName(Microsoft.OnlineExperimentation,
  "OnlineExperimentationMgmtClient",
  "python"
);

// CSharp
@@clientName(Azure.ResourceManager.ResourceProvisioningState,
  "OnlineExperimentationProvisioningState",
  "csharp"
);
@@alternateType(OnlineExperimentationWorkspaceProperties.workspaceId,
  uuid,
  "csharp"
);
