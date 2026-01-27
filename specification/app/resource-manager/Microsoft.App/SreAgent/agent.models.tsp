import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./commontypes.tsp";

using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.App;

/** Agent update model */
model AgentPatch {
  ...ResourceTags;

  /** Managed identities for the Agent */
  ...ManagedServiceIdentityProperty;

  /** Agent specific properties */
  properties?: AgentProperties;
}

/** Properties of the Agent */
model AgentProperties {
  /** Provisioning state of the Agent */
  @visibility(Lifecycle.Read)
  provisioningState?: AgentProvisioningState;

  /** The endpoint of the Agent */
  @visibility(Lifecycle.Read)
  agentEndpoint?: string;

  /** The running state of the Agent */
  @visibility(Lifecycle.Read)
  runningState?: string;

  /** The power state of the Agent */
  @visibility(Lifecycle.Read)
  powerState?: AgentPowerState;

  /** The agent space ID referenced by the agent */
  agentSpaceId?: armResourceIdentifier<[
    {
      type: "Microsoft.App/agentSpaces";
    }
  ]>;

  /** Knowledge graph configuration for agent */
  knowledgeGraphConfiguration?: KnowledgeGraphConfiguration;

  /** Configuration for action */
  actionConfiguration?: ActionConfiguration;

  /** Log configurations */
  logConfiguration?: LogConfiguration;

  /** Incident management configurations */
  incidentManagementConfiguration?: IncidentManagementConfiguration;

  /** The list of user permissions for the agent */
  @identifiers(#["objectId", "tenantId", "role"])
  permissions?: UserIdentityPermission[];

  /** The upgrade channel of the agent */
  upgradeChannel?: UpgradeChannel;

  /** Agent identity configuration for accessing resources */
  agentIdentity?: AgentIdentity;

  /** Default AI model configuration for the agent */
  defaultModel?: DefaultModel;
}

/** Provisioning state of the Agent */
@lroStatus
union AgentProvisioningState {
  string,
  ResourceProvisioningState,

  /** The Agent is being provisioned */
  InProgress: "InProgress",

  /** The Agent provisioning succeeded */
  Succeeded: "Succeeded",

  /** The Agent provisioning failed */
  Failed: "Failed",

  /** The Agent provisioning was canceled */
  Canceled: "Canceled",

  /** The Agent is being deleted */
  Deleting: "Deleting",
}

/** Power state of the Agent */
union AgentPowerState {
  string,

  /** The Agent is running */
  Running: "Running",

  /** The Agent is stopped */
  Stopped: "Stopped",
}

/** Upgrade channel for Agent */
union UpgradeChannel {
  string,

  /** Preview upgrade channel */
  Preview: "Preview",

  /** Stable upgrade channel */
  Stable: "Stable",
}

/** Agent identity configuration */
model AgentIdentity {
  /** Indicates whether the agent identity is enabled */
  @visibility(Lifecycle.Read)
  enabled?: boolean;

  /** Client ID (GUID) for the agent identity */
  @visibility(Lifecycle.Read)
  clientId?: string;

  /** Initial sponsor group ID (required for agent identity) */
  initialSponsorGroupId?: string;
}

/** Default AI model configuration */
model DefaultModel {
  /** AI provider name (e.g., MicrosoftFoundry, Anthropic) */
  provider?: string;

  /** Model name (e.g., gpt-5, claude-opus-4-5, claude-sonnet-4-5) */
  name?: string;
}

/** Knowledge graph configuration for agent */
model KnowledgeGraphConfiguration {
  /** The identity used to access the knowledge graph */
  identity?: armResourceIdentifier;

  /** The list of resources managed by agent */
  managedResources?: armResourceIdentifier[];
}

/** Configuration for action */
model ActionConfiguration {
  /** The identity used by the action */
  identity?: armResourceIdentifier;

  /** The mode of the action */
  mode?: AgentMode;

  /** The access level of the action */
  accessLevel?: AgentAccessLevel;
}

/** Agent mode */
union AgentMode {
  string,

  /** Write actions are executed automatically without user approval */
  Autonomous: "Autonomous",

  /** Write actions require user approval before execution */
  Review: "Review",

  /** No write actions are executed */
  ReadOnly: "ReadOnly",
}

/** Agent access level */
union AgentAccessLevel {
  string,

  /** Agent has read-only permissions on managed resource groups */
  Low: "Low",

  /** Agent can take approved actions on resources using its own managed identity */
  High: "High",
}

/** Incident Management Configurations */
model IncidentManagementConfiguration {
  /** The type of incident management system */
  type?: string;

  /** The name of the connection */
  connectionName?: string;

  /** The URL of the connection */
  connectionUrl?: string;

  /** The key for the connection */
  @secret
  connectionKey?: string;

  /** The user for the connection */
  oboUser?: string;
}

/** Log Configurations */
model LogConfiguration {
  /** Application Insights Configuration */
  applicationInsightsConfiguration?: ApplicationInsightsConfiguration;
}

/** Application Insights Configuration */
model ApplicationInsightsConfiguration {
  /** The Application ID for the Application Insights resource */
  appId?: string;

  /** The connection string for the Application Insights resource */
  @secret
  connectionString?: string;
}

/** User identity permission properties */
model UserIdentityPermission {
  /** The display name of the user */
  displayName?: string;

  /** The object ID of the user identity */
  objectId?: string;

  /** The tenant ID of the user identity */
  tenantId?: string;

  /** The role assigned to the user */
  role?: UserIdentityPermissionRole;
}

/** User identity permission role */
union UserIdentityPermissionRole {
  string,

  /** Author role */
  Author: "Author",

  /** Standard user role */
  StandardUser: "StandardUser",

  /** Reader role */
  Reader: "Reader",
}

/** Collection of usage information */
model UsageCollection {
  /**
   * The list of usage records.
   */
  @pageItems
  value?: UsageInfo[];

  /**
   * The URI that can be used to request the next list of usage records.
   */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/** Usage information for an Agent */
model UsageInfo {
  /** The unit of measurement */
  unit?: string;

  /** The current usage value */
  currentValue?: float64;

  /** The usage limit */
  limit?: float64;

  /** Usage name */
  name?: UsageName;
}

/** Usage name information */
model UsageName {
  /** The usage name value */
  value?: string;

  /** The localized usage name */
  localizedValue?: string;
}

/** Collection of daily usage information */
model DailyUsageCollection {
  /** The list of daily usage records. */
  @pageItems
  value: DailyUsageInfo[];

  /** The URI to request the next page of results. */
  @nextLink
  @visibility(Lifecycle.Read)
  nextLink?: string;
}

/** Daily usage information for an Agent */
model DailyUsageInfo {
  /** The date of the usage */
  date?: plainDate;

  /** Usage name */
  name?: UsageName;

  /** The usage value for the day */
  value?: float64;
}
