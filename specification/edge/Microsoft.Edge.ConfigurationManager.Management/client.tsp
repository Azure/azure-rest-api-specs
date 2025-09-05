import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Azure.Core;
using Microsoft.Edge;

@@clientName(Microsoft.Edge, "WorkloadOrchestrationMgmtClient", "python");
@@clientName(Microsoft.Edge,
  "WorkloadOrchestrationManagementClient",
  "javascript"
);

@@clientName(BulkPublishSolutionParameter,
  "BulkPublishSolutionContent",
  "csharp"
);
@@clientName(InstallSolutionParameter, "InstallSolutionContent", "csharp");
@@clientName(BulkDeploySolutionParameter,
  "BulkDeploySolutionContent",
  "csharp"
);
@@clientName(RemoveRevisionParameter, "RemoveRevisionContent", "csharp");
@@clientName(RemoveVersionResponse, "RemoveVersionResult", "csharp");
@@clientName(SolutionDependencyParameter,
  "SolutionDependencyContent",
  "csharp"
);
@@clientName(SolutionTemplateParameter, "SolutionTemplateContent", "csharp");
@@clientName(TaskOption, "TaskConfig", "csharp");
@@clientName(UninstallSolutionParameter, "UninstallSolutionContent", "csharp");
@@clientName(UpdateExternalValidationStatusParameter,
  "UpdateExternalValidationStatusContent",
  "csharp"
);
@@clientName(SolutionVersionParameter, "SolutionVersionContent", "csharp");
@@clientName(VersionParameter, "VersionContent", "csharp");
@@clientName(DeployJobParameter, "DeployJobContent", "csharp");
