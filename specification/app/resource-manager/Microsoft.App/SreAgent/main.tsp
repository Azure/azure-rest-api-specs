import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "./commontypes.tsp";
import "./agent.tsp";
import "./agentconnector.tsp";
import "./agentspace.tsp";
import "./agentspaceconnector.tsp";
import "./supportedagentmodel.tsp";
import "./debugsession.tsp";

using Versioning;
using Azure.ResourceManager;

/** Microsoft.App Resource Provider management API. */
#suppress "@azure-tools/typespec-azure-resource-manager/missing-operations-endpoint" "Operations Api is defined in other files."
@armProviderNamespace("Microsoft.App")
@service(#{ title: "Microsoft.App SreAgent management service" })
@versioned(Microsoft.App.Versions)
namespace Microsoft.App;

/** The available API versions. */
enum Versions {
  /** 2026-01-01 version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_01_01: "2026-01-01",

  /** 2026-06-01-preview version */
  @armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v6)
  v2026_06_01_preview: "2026-06-01-preview",
}

// The 2026-06-01-preview version is an isolated preview that exposes only the
// `startDebugSession` provider-level action. Every resource type, operation
// group, and model introduced in the 2026-01-01 stable version is therefore
// removed from the preview so its generated swagger contains only the debug
// session action. These augmentations do not affect the stable 2026-01-01
// swagger, where all of the types below remain present.

// Operation groups (interfaces)
@@removed(Agents, Versions.v2026_06_01_preview);
@@removed(AgentsConnectors, Versions.v2026_06_01_preview);
@@removed(AgentSpaces, Versions.v2026_06_01_preview);
@@removed(AgentSpacesConnectors, Versions.v2026_06_01_preview);
@@removed(SupportedAgentModels, Versions.v2026_06_01_preview);

// Resource types
@@removed(Agent, Versions.v2026_06_01_preview);
@@removed(AgentConnector, Versions.v2026_06_01_preview);
@@removed(AgentSpace, Versions.v2026_06_01_preview);
@@removed(AgentSpaceConnector, Versions.v2026_06_01_preview);
@@removed(SupportedAgentModel, Versions.v2026_06_01_preview);

// Shared/common models
@@removed(ResourceTags, Versions.v2026_06_01_preview);
@@removed(Connector, Versions.v2026_06_01_preview);
@@removed(ConnectorProvisioningState, Versions.v2026_06_01_preview);

// Agent models
@@removed(AgentPatch, Versions.v2026_06_01_preview);
@@removed(AgentPatchProperties, Versions.v2026_06_01_preview);
@@removed(AgentProperties, Versions.v2026_06_01_preview);
@@removed(AgentProvisioningState, Versions.v2026_06_01_preview);
@@removed(AgentPowerState, Versions.v2026_06_01_preview);
@@removed(UpgradeChannel, Versions.v2026_06_01_preview);
@@removed(AgentIdentity, Versions.v2026_06_01_preview);
@@removed(AgentIdentityPatch, Versions.v2026_06_01_preview);
@@removed(DefaultModel, Versions.v2026_06_01_preview);
@@removed(KnowledgeGraphConfiguration, Versions.v2026_06_01_preview);
@@removed(ActionConfiguration, Versions.v2026_06_01_preview);
@@removed(AgentMode, Versions.v2026_06_01_preview);
@@removed(AgentAccessLevel, Versions.v2026_06_01_preview);
@@removed(IncidentManagementConfiguration, Versions.v2026_06_01_preview);
@@removed(LogConfiguration, Versions.v2026_06_01_preview);
@@removed(ApplicationInsightsConfiguration, Versions.v2026_06_01_preview);

// Agent connector models
@@removed(AgentConnectorCollection, Versions.v2026_06_01_preview);
@@removed(AgentConnectorProperties, Versions.v2026_06_01_preview);

// Agent space models
@@removed(AgentSpacePatch, Versions.v2026_06_01_preview);
@@removed(AgentSpacePatchProperties, Versions.v2026_06_01_preview);
@@removed(AgentSpaceProperties, Versions.v2026_06_01_preview);
@@removed(AgentSpaceProvisioningState, Versions.v2026_06_01_preview);
@@removed(AgentSpaceComplianceStatus, Versions.v2026_06_01_preview);
@@removed(AgentSpacePolicies, Versions.v2026_06_01_preview);
@@removed(AgentSpacePoliciesPatch, Versions.v2026_06_01_preview);
@@removed(GenevaActionsPolicy, Versions.v2026_06_01_preview);
@@removed(GenevaActionsPolicyPatch, Versions.v2026_06_01_preview);
@@removed(GenevaActionAuthenticationMode, Versions.v2026_06_01_preview);
@@removed(GenevaActionConfig, Versions.v2026_06_01_preview);
@@removed(GenevaActionParameter, Versions.v2026_06_01_preview);

// Agent space connector models
@@removed(AgentSpaceConnectorCollection, Versions.v2026_06_01_preview);
@@removed(AgentSpaceConnectorProperties, Versions.v2026_06_01_preview);

// Supported agent model
@@removed(SupportedAgentModelProperties, Versions.v2026_06_01_preview);
