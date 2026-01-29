import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./commontypes.tsp";

using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.App;

/** Agent Space update model */
model AgentSpacePatch {
  ...ResourceTags;

  /** Managed identities for the Agent Space */
  ...ManagedServiceIdentityProperty;

  /** Agent Space specific properties */
  properties?: AgentSpaceProperties;
}

/** Agent Space specific properties */
model AgentSpaceProperties {
  /** Provisioning state of the Agent Space */
  @visibility(Lifecycle.Read)
  provisioningState?: AgentSpaceProvisioningState;

  /** Current number of agents in the Agent Space */
  @visibility(Lifecycle.Read)
  currentAgentCount?: int32;

  /** List of agents referencing the Agent Space */
  @visibility(Lifecycle.Read)
  memberAgents?: string[];

  /** Timestamp of the last policy propagation to agents in this Agent Space */
  @visibility(Lifecycle.Read)
  lastPolicyPropagation?: utcDateTime;

  /** Compliance status of the Agent Space */
  @visibility(Lifecycle.Read)
  complianceStatus?: AgentSpaceComplianceStatus;

  /** Description of the Agent Space */
  description?: string;

  /** Policy configurations for the Agent Space */
  policies?: AgentSpacePolicies;

  /** Maximum number of agents allowed in the Agent Space */
  maxAgentCount?: int32;

  /** Universal unique ID (UUID) of the Service Tree associated with this Agent Space */
  serviceTreeId?: string;
}

/** Provisioning state of the Agent Space */
@lroStatus
union AgentSpaceProvisioningState {
  string,
  ResourceProvisioningState,

  /** The Agent Space is being provisioned */
  InProgress: "InProgress",

  /** The Agent Space provisioning succeeded */
  Succeeded: "Succeeded",

  /** The Agent Space provisioning failed */
  Failed: "Failed",

  /** The Agent Space provisioning was canceled */
  Canceled: "Canceled",

  /** The Agent Space is being deleted */
  Deleting: "Deleting",
}

/** Compliance status of the Agent Space */
model AgentSpaceComplianceStatus {
  /** Indicates whether the Agent Space is compliant */
  isCompliant?: boolean;

  /** List of compliance issues found in the Agent Space */
  complianceIssues?: string[];

  /** Timestamp of the last compliance check */
  lastComplianceCheck?: utcDateTime;
}

/** Policy configurations for an Agent Space */
model AgentSpacePolicies {
  /** Configuration for Geneva Actions policy */
  genevaActionsConfiguration?: GenevaActionsPolicy;
}

/** Geneva Actions policy configuration for Agent Space */
model GenevaActionsPolicy {
  /** ACIS (Azure Container Instance Service) endpoint URL */
  acisEndpoint?: string;

  /** Client ID for authentication */
  clientId?: string;

  /** Subject name of the certificate used for authentication */
  certificateSubjectName?: string;

  /** Authentication mode for Geneva Actions */
  authenticationMode?: GenevaActionAuthenticationMode;

  /** Name of the Geneva extension */
  extensionName?: string;

  /** Collection of allowed Geneva actions */
  @identifiers(#["actionName", "extension"])
  allowedActions?: GenevaActionConfig[];

  /** Subject alternative name of the certificate used for authentication */
  certificateSubjectAlternativeName?: string;
}

/** Geneva Action authentication mode */
union GenevaActionAuthenticationMode {
  string,

  /** OAuth authentication mode */
  OAuth: "OAuth",

  /** WS-Trust authentication mode */
  @encodedName("application/json", "WS-Trust")
  WSTrust: "WS-Trust",
}

/** Configuration for a Geneva action */
model GenevaActionConfig {
  /** Name of the Geneva action */
  actionName?: string;

  /** Extension associated with the action */
  extension?: string;

  /** Parameters for the Geneva action */
  actionParameters?: GenevaActionParameter[];

  /** Indicates whether approval is required for this action */
  approvalRequired?: boolean;
}

/** Parameter for a Geneva action */
model GenevaActionParameter {
  /** Name of the parameter */
  name?: string;

  /** Type of the parameter */
  type?: string;
}
