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
@@clientName(ObservabilityAgentResource, "ObservabilityAgent", "csharp");
@@clientName(
  ObservabilityAgentProperties.autonomousOperationsEnabled,
  "IsAutonomousOperationsEnabled",
  "csharp"
);
@@clientName(
  ObservabilityAgentPropertiesUpdate,
  "ObservabilityAgentPatchProperties",
  "csharp"
);
@@clientName(
  ObservabilityAgentPropertiesUpdate.autonomousOperationsEnabled,
  "IsAutonomousOperationsEnabled",
  "csharp"
);
