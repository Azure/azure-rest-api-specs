import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Monitor;

@@clientName(
  Azure.ResourceManager.CommonTypes.Origin,
  "ArmOrigin",
  "python,go"
);

@@clientName(
  Azure.ResourceManager.ResourceProvisioningState,
  "MonitorAgentProvisioningState",
  "csharp"
);
@@clientName(OperationEntry, "ObservabilityAgentOperationInfo", "csharp");
@@clientName(OperationMode, "ObservabilityAgentOperationMode", "csharp");
@@clientName(OperationType, "ObservabilityAgentOperationType", "csharp");
@@clientName(ObservabilityAgentResource, "ObservabilityAgent", "csharp");
@@clientName(ObservabilityAgentProperties.enabled, "IsEnabled", "csharp");
@@clientName(
  ObservabilityAgentPropertiesUpdate,
  "ObservabilityAgentPatchProperties",
  "csharp"
);
@@clientName(ObservabilityAgentPropertiesUpdate.enabled, "IsEnabled", "csharp");
