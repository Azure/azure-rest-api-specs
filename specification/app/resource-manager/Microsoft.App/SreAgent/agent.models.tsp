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
  properties?: AgentPatchProperties;
}

/**
 * Agent specific properties for PATCH requests.
 *
 * PATCH request bodies must not include required properties and should not include read-only properties.
 */
model AgentPatchProperties {
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

  /** The upgrade channel of the agent */
  upgradeChannel?: UpgradeChannel;

  /** Agent identity configuration for accessing resources */
  agentIdentity?: AgentIdentityPatch;

  /** Default AI model configuration for the agent */
  defaultModel?: DefaultModel;

  /**
   * Virtual network configuration to update. Omission or an empty object preserves the subnet; null clears it.
   * To detach, clear the subnet and update sandbox egress in the same request so the resulting mode is not AzureVNet.
   * The detach example explicitly selects Limited.
   * The resulting subnet and AzureVNet egress mode must be configured together.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The existing API distinguishes null, which clears the subnet, from omission, which preserves it."
  vnetConfiguration?: VnetConfiguration | null;

  /**
   * Sandbox configuration to update. Omission or null preserves the stored configuration.
   * A supplied object merges its members with the stored configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The existing API accepts a null sandboxConfiguration in PATCH and preserves the stored configuration."
  sandboxConfiguration?: SandboxConfiguration | null;
}

/** Properties of the Agent */
model AgentProperties {
  /** Provisioning state of the Agent */
  @visibility(Lifecycle.Read)
  provisioningState?: AgentProvisioningState;

  /** The endpoint of the Agent */
  @visibility(Lifecycle.Read)
  agentEndpoint?: string;

  /** Outbound IP addresses reported for the Agent's provisioned networking resources. */
  @visibility(Lifecycle.Read)
  outboundIpAddresses?: string[];

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

  /** The upgrade channel of the agent */
  upgradeChannel?: UpgradeChannel;

  /** Agent identity configuration for accessing resources */
  agentIdentity?: AgentIdentity;

  /** Default AI model configuration for the agent */
  defaultModel?: DefaultModel;

  /**
   * Desired virtual network configuration. A subnet and AzureVNet egress mode must be configured together.
   * GET returns the desired subnet, or an object with a null subnetResourceId when detached.
   * Use PATCH for selective updates. Omitting networking settings from PUT can clear them or fail validation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The existing API accepts a null vnetConfiguration in create or replace requests."
  vnetConfiguration?: VnetConfiguration | null;

  /** Desired sandbox configuration. GET can return null when no configuration is stored. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The existing API accepts and returns a null sandboxConfiguration."
  sandboxConfiguration?: SandboxConfiguration | null;
}

/** Desired subnet configuration for the agent's sandbox. */
model VnetConfiguration {
  /**
   * Azure resource ID of the subnet used with AzureVNet egress mode, or null when detached.
   * In PATCH, omission preserves the subnet and null clears it.
   * Setting or replacing a subnet requires the resulting egress mode to be AzureVNet.
   * When clearing the subnet, also update sandbox egress in the same PATCH request so the resulting mode is not AzureVNet.
   * The detach example explicitly selects Limited.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The existing API returns null when detached and distinguishes null from omission in PATCH."
  subnetResourceId?:
    | armResourceIdentifier<[
        {
          type: "Microsoft.Network/virtualNetworks/subnets";
        }
      ]>
    | null;
}

/** Desired configuration for the agent's sandbox. */
model SandboxConfiguration {
  /**
   * Sandbox egress configuration. In PATCH, omission preserves egress and null clears it.
   * Clearing egress is invalid while a subnet remains configured.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The existing API accepts and returns null egress and distinguishes null from omission in PATCH."
  egress?: SandboxEgressConfiguration | null;

  /**
   * Packages to preinstall in the sandbox. In PATCH, omission preserves the package list.
   * A supplied array replaces the entire list; null clears it. An empty array selects no packages.
   * Each supplied package must include its name and package manager.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The existing API accepts and returns a null package list and distinguishes null from omission in PATCH."
  @maxItems(200)
  packages?: SandboxPackageSpec[] | null;
}

/** Desired outbound network configuration for the agent's sandbox. */
model SandboxEgressConfiguration {
  /**
   * Sandbox egress mode. AzureVNet requires a subnet, and a configured subnet requires AzureVNet.
   * In PATCH, omission preserves the mode and null clears it.
   * Clearing the mode is invalid while a subnet remains configured.
   * No unconditional default applies.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The existing API accepts and returns a null mode and distinguishes null from omission in PATCH."
  mode?: SandboxEgressMode | null;

  /**
   * Whether remote HTTP MCP servers can use the managed network path.
   * In PATCH, omission preserves the setting and null clears it.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The existing API accepts and returns a null HTTP MCP access setting and distinguishes null from omission in PATCH."
  allowHttpMcpServerNetworkAccess?: boolean | null;

  /**
   * Additional hostnames allowed on the managed network path.
   * Entries are DNS hostnames or leading wildcard patterns such as '*.example.com'; a bare '*' is invalid.
   * Each entry has at most 253 characters and each DNS label at most 63 characters.
   * Wildcard patterns must contain at least two labels after '*.'.
   * In PATCH, omission preserves the list, a supplied array replaces it, and null clears it.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The existing API accepts and returns a null allowed-host list and distinguishes null from omission in PATCH."
  @maxItems(100)
  allowedHosts?: SandboxAllowedHost[] | null;

  /**
   * Package registry identifiers allowed on the managed network path.
   * Supported identifiers are 'pypi', 'npmjs', 'nuget-org', and 'ubuntu', matched without regard to case.
   * In PATCH, omission preserves the list, a supplied array replaces it, and null clears it.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The existing API accepts and returns a null registry list and distinguishes null from omission in PATCH."
  allowedRegistries?: string[] | null;

  /**
   * Code repository provider identifiers allowed on the managed network path.
   * Supported identifiers are 'Github', 'GithubEnterprise', 'AzureDevOps', and 'GitLab', matched case-sensitively.
   * In PATCH, omission preserves the list, a supplied array replaces it, and null clears it.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The existing API accepts and returns a null code-repository list and distinguishes null from omission in PATCH."
  allowedCodeRepositories?: string[] | null;

  /**
   * Forward-proxy configuration for sandbox outbound requests.
   * Used only when forward-proxy support is enabled for the Agent and the egress mode is AzureVNet.
   * Supplying this configuration does not enable forward-proxy support.
   * In PATCH, omission preserves the configuration, null clears it, and a supplied object merges its members.
   * The resulting proxy configuration must have at least one nonempty endpoint.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The existing API accepts and returns a null proxy configuration and distinguishes null from omission in PATCH."
  httpProxy?: SandboxHttpProxyConfiguration | null;
}

/** A DNS hostname or a leading wildcard hostname pattern allowed on the managed network path. */
@minLength(1)
@maxLength(253)
@pattern("^(\\*\\.(?=[^.]+\\.))?[A-Za-z0-9]([A-Za-z0-9-]{0,61}[A-Za-z0-9])?(\\.[A-Za-z0-9]([A-Za-z0-9-]{0,61}[A-Za-z0-9])?)*$")
scalar SandboxAllowedHost extends string;

/** Forward-proxy endpoints and additional destinations that bypass the proxy. */
model SandboxHttpProxyConfiguration {
  /**
   * Proxy endpoint for HTTP destinations. Nonempty values must be an absolute http:// origin with a host.
   * Credentials, paths other than '/', query strings, fragments, and ports 0, 80, and 443 are not supported.
   * This endpoint applies only to HTTP destinations; there is no fallback to httpsUrl.
   * An empty value is allowed when httpsUrl is configured.
   * In PATCH, omission preserves the endpoint and null clears it.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The existing API accepts and returns a null HTTP proxy endpoint and distinguishes null from omission in PATCH."
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "The existing wire contract uses httpUrl."
  httpUrl?: string | null;

  /**
   * Proxy endpoint for HTTPS destinations. The proxy URL itself must use http:// for CONNECT tunneling.
   * Nonempty values must be an origin with a host and no credentials, path other than '/', query, or fragment.
   * Ports 0, 80, and 443 are not supported. There is no fallback to httpUrl.
   * An empty value is allowed when httpUrl is configured.
   * In PATCH, omission preserves the endpoint and null clears it.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The existing API accepts and returns a null HTTPS proxy endpoint and distinguishes null from omission in PATCH."
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "The existing wire contract uses httpsUrl."
  httpsUrl?: string | null;

  /**
   * Additional destinations that bypass the forward proxy.
   * Entries can be hostnames, leading-dot or '*.' suffix patterns, IP addresses, or CIDR blocks.
   * Hostnames and IP addresses can include a port from 1 through 65535; CIDR entries cannot include a port.
   * Empty entries and a bare '*' are invalid.
   * In PATCH, omission preserves the list, a supplied array replaces it, and null clears it.
   */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The existing API accepts and returns a null proxy-bypass list and distinguishes null from omission in PATCH."
  noProxy?: string[] | null;
}

/** A package to preinstall in the sandbox. Package arrays are replaced as a whole. */
model SandboxPackageSpec {
  /** Package name, optionally including a scope or namespace prefix. */
  @minLength(1)
  @maxLength(214)
  @pattern("^@?[A-Za-z0-9][A-Za-z0-9._-]*(/[A-Za-z0-9][A-Za-z0-9._-]*)?$")
  name: string;

  /** Optional package version or version constraint. Null leaves the version unspecified. */
  #suppress "@azure-tools/typespec-azure-core/no-nullable" "The existing API accepts and returns a null package version."
  @minLength(1)
  @maxLength(64)
  @pattern("^[A-Za-z0-9._+\\-~^<>=,*\\[\\]()]+$")
  version?: string | null;

  /** Package manager used to install the package. Values are case-sensitive. */
  packageManager: SandboxPackageManager;
}

/** Supported package managers for sandbox packages. */
union SandboxPackageManager {
  string,

  /** Python packages installed with pip. */
  Pip: "pip",

  /** JavaScript packages installed with npm. */
  Npm: "npm",

  /** .NET tools installed from NuGet. */
  Nuget: "nuget",
}

/** Supported modes for outbound network access from the agent's sandbox. */
union SandboxEgressMode {
  string,

  /** Allows sandbox egress without destination restrictions from this mode. */
  Unrestricted: "Unrestricted",

  /** Restricts sandbox egress to allowed destinations. */
  Limited: "Limited",

  /** Uses the configured virtual network subnet for sandbox egress. */
  AzureVNet: "AzureVNet",
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
  initialSponsorGroupId: string;
}

/** Agent identity configuration for PATCH requests */
model AgentIdentityPatch {
  /** Initial sponsor group ID (required for PUT but optional for PATCH) */
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
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "Name kept for backward compatibility"
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
