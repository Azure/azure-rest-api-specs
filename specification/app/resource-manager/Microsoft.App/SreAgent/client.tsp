import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.App;

// Rename models whose names end with reserved suffixes that the .NET analyzer
// (AZC0030) disallows ('Collection', 'Parameter'). These renames only affect
// the generated C# type names.
@@clientName(AgentConnectorCollection, "AgentConnectorList", "csharp");
@@clientName(
  AgentSpaceConnectorCollection,
  "AgentSpaceConnectorList",
  "csharp"
);
@@clientName(GenevaActionParameter, "GenevaActionParameterInfo", "csharp");

// Boolean properties must use a verb prefix (BOOL001).
@@clientName(
  GenevaActionConfig.approvalRequired,
  "IsApprovalRequired",
  "csharp"
);
@@clientName(SupportedAgentModelProperties.default, "IsDefault", "csharp");
@@clientName(AgentIdentity.enabled, "IsEnabled", "csharp");

// Date/time properties should end with 'On' (DATE001).
@@clientName(
  AgentSpaceComplianceStatus.lastComplianceCheck,
  "LastComplianceCheckOn",
  "csharp"
);

// Add RP/domain context to otherwise-generic type names to avoid future
// breaking renames before GA (RESNAME001 / contextual naming).
@@clientName(Agent, "SreAgent", "csharp");
@@clientName(DefaultModel, "SreAgentDefaultModel", "csharp");

// ClientId is documented as a GUID; surface it as System.Guid in C# only,
// without changing the wire/spec type (Type mapping).
@@alternateType(AgentIdentity.clientId, Azure.Core.uuid, "csharp");
@@alternateType(GenevaActionsPolicy.clientId, Azure.Core.uuid, "csharp");
@@alternateType(GenevaActionsPolicyPatch.clientId, Azure.Core.uuid, "csharp");
@@alternateType(
  ApplicationInsightsConfiguration.appId,
  Azure.Core.uuid,
  "csharp"
);

// Add RP/domain context to otherwise-generic type names to avoid ambiguity in
// IntelliSense and future breaking renames (contextual naming).
@@clientName(ActionConfiguration, "AgentActionConfiguration", "csharp");
@@clientName(
  ConnectorProvisioningState,
  "AgentConnectorProvisioningState",
  "csharp"
);
@@clientName(
  IncidentManagementConfiguration,
  "AgentIncidentManagementConfiguration",
  "csharp"
);
@@clientName(
  KnowledgeGraphConfiguration,
  "AgentKnowledgeGraphConfiguration",
  "csharp"
);
@@clientName(UpgradeChannel, "AgentUpgradeChannel", "csharp");
