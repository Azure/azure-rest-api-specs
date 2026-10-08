import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./commontypes.tsp";

using Azure.Core;
using Azure.ResourceManager;
using TypeSpec.Versioning;

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
   * Virtual network configuration to update. Omission or an empty object preserves the subnet; JSON merge-patch null clears it.
   * To detach, clear the subnet and update sandbox egress in the same request so the resulting mode is not AzureVNet.
   * The detach example explicitly selects Limited.
   * The resulting subnet and AzureVNet egress mode must be configured together.
   */
  @added(Versions.v2026_07_01)
  vnetConfiguration?: VnetConfiguration;

  /**
   * Sandbox configuration to update. Omission preserves the stored configuration.
   * JSON merge-patch null clears it, and a supplied object merges its members with the stored configuration.
   */
  @added(Versions.v2026_07_01)
  sandboxConfiguration?: SandboxConfiguration;
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
  @added(Versions.v2026_07_01)
  @visibility(Lifecycle.Read)
  outboundIpAddresses?: string[];

  /** The running state of the Agent */
  @visibility(Lifecycle.Read)
  runningState?: string;

  /** The power state of the Agent */
  @visibility(Lifecycle.Read)
  powerState?: AgentPowerState;

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
   * Use PATCH for selective updates. Omitting networking settings from PUT can clear them or fail validation.
   */
  @added(Versions.v2026_07_01)
  vnetConfiguration?: VnetConfiguration;

  /**
   * Desired sandbox configuration. PUT represents the complete desired configuration and does not preserve an existing
   * value when this property is omitted.
   * Use PATCH to preserve the stored configuration while updating other properties.
   */
  @added(Versions.v2026_07_01)
  sandboxConfiguration?: SandboxConfiguration;
}

/** Desired subnet configuration for the agent's sandbox. */
@added(Versions.v2026_07_01)
model VnetConfiguration {
  /**
   * Azure resource ID of the subnet used with AzureVNet egress mode.
   * In PATCH, omission preserves the subnet and JSON merge-patch null clears it.
   * Setting or replacing a subnet requires the resulting egress mode to be AzureVNet.
   * When clearing the subnet, also update sandbox egress in the same PATCH request so the resulting mode is not AzureVNet.
   * The detach example explicitly selects Limited.
   */
  subnetResourceId?: armResourceIdentifier<[
    {
      type: "Microsoft.Network/virtualNetworks/subnets";
    }
  ]>;
}

/** Desired configuration for the agent's sandbox. */
@added(Versions.v2026_07_01)
model SandboxConfiguration {
  /**
   * Sandbox egress configuration. In PATCH, omission preserves egress and JSON merge-patch null clears it.
   * Clearing egress is invalid while a subnet remains configured.
   */
  egress?: SandboxEgressConfiguration;

  /**
   * Packages to preinstall in the sandbox. In PATCH, omission preserves the package list.
   * A supplied array replaces the entire list; JSON merge-patch null clears it. An empty array selects no packages.
   * Each supplied package must include its name and package manager.
   */
  @identifiers(#["name", "packageManager"])
  @maxItems(200)
  packages?: SandboxPackageSpec[];
}

/** Desired outbound network configuration for the agent's sandbox. */
@added(Versions.v2026_07_01)
model SandboxEgressConfiguration {
  /**
   * Sandbox egress mode. AzureVNet requires a subnet, and a configured subnet requires AzureVNet.
   * In PATCH, omission preserves the mode and JSON merge-patch null clears it.
   * Clearing the mode is invalid while a subnet remains configured.
   * No unconditional default applies.
   */
  mode?: SandboxEgressMode;

  /**
   * Whether remote HTTP MCP servers can use the managed network path.
   * In PATCH, omission preserves the setting and JSON merge-patch null clears it.
   */
  allowHttpMcpServerNetworkAccess?: boolean;

  /**
   * Additional hostnames allowed on the managed network path.
   * Entries are DNS hostnames or leading wildcard patterns such as '*.example.com'; a bare '*' is invalid.
   * Each entry has at most 253 characters and each DNS label at most 63 characters.
   * Wildcard patterns must contain at least two labels after '*.'.
   * In PATCH, omission preserves the list, a supplied array replaces it, and JSON merge-patch null clears it.
   */
  @maxItems(100)
  allowedHosts?: SandboxAllowedHost[];

  /**
   * Package registry identifiers allowed on the managed network path. Values are matched without regard to case.
   * In PATCH, omission preserves the list, a supplied array replaces it, and JSON merge-patch null clears it.
   */
  allowedRegistries?: SandboxRegistry[];

  /**
   * Code repository provider identifiers allowed on the managed network path. Values are matched case-sensitively.
   * In PATCH, omission preserves the list, a supplied array replaces it, and JSON merge-patch null clears it.
   */
  allowedCodeRepositories?: SandboxCodeRepository[];

  /**
   * Forward-proxy configuration for sandbox outbound requests.
   * Used only when forward-proxy support is enabled for the Agent and the egress mode is AzureVNet.
   * Supplying this configuration does not enable forward-proxy support.
   * In PATCH, omission preserves the configuration, JSON merge-patch null clears it, and a supplied object merges its members.
   * The resulting proxy configuration must include httpsUrl.
   */
  httpProxy?: SandboxHttpProxyConfiguration;
}

/** A DNS hostname or a leading wildcard hostname pattern allowed on the managed network path. */
@added(Versions.v2026_07_01)
@minLength(1)
@maxLength(253)
@pattern("^(\\*\\.(?=[^.]+\\.))?[A-Za-z0-9]([A-Za-z0-9-]{0,61}[A-Za-z0-9])?(\\.[A-Za-z0-9]([A-Za-z0-9-]{0,61}[A-Za-z0-9])?)*$")
scalar SandboxAllowedHost extends string;

/**
 * A destination that bypasses the forward proxy.
 * The value is an exact IPv4 address, a DNS hostname, or a DNS suffix prefixed with '.' or '*.'.
 */
@added(Versions.v2026_07_01)
@minLength(1)
@maxLength(253)
@pattern("^(?:(?:25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)(?:\\.(?:25[0-5]|2[0-4]\\d|1\\d\\d|[1-9]?\\d)){3}|(?:\\*\\.|\\.)?(?=.{1,253}$)(?=.*[A-Za-z_])(?:[A-Za-z0-9_](?:[A-Za-z0-9_-]{0,61}[A-Za-z0-9_])?)(?:\\.(?:[A-Za-z0-9_](?:[A-Za-z0-9_-]{0,61}[A-Za-z0-9_])?))*)$")
scalar SandboxNoProxyEntry extends string;

/** Forward-proxy endpoints and additional destinations that bypass the proxy. */
@added(Versions.v2026_07_01)
model SandboxHttpProxyConfiguration {
  /**
   * Optional proxy endpoint used for HTTP destinations. When set, it must be the same proxy origin as httpsUrl;
   * different HTTP and HTTPS proxies are not supported.
   * The value must be an absolute http:// origin with a host. Credentials, paths other than '/', query strings,
   * fragments, and ports 0, 80, and 443 are not supported.
   * In PATCH, omission preserves the endpoint and JSON merge-patch null clears it.
   */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "The existing wire contract uses httpUrl."
  httpUrl?: url;

  /**
   * Proxy endpoint used for HTTPS destinations and CONNECT tunneling. Required whenever a proxy configuration is stored.
   * The proxy URL itself must use http:// for CONNECT tunneling and must be an origin with a host.
   * Credentials, paths other than '/', query strings, fragments, and ports 0, 80, and 443 are not supported.
   * In PATCH, omission preserves the endpoint.
   */
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "The existing wire contract uses httpsUrl."
  httpsUrl?: url;

  /**
   * Additional destinations that bypass the forward proxy.
   * Entries can be DNS hostnames, leading-dot or '*.' suffix patterns, or exact IPv4 addresses.
   * CIDR blocks, IPv6 addresses, ports, empty entries, and a bare '*' are invalid.
   * In PATCH, omission preserves the list, a supplied array replaces it, and JSON merge-patch null clears it.
   */
  noProxy?: SandboxNoProxyEntry[];
}

/** A package to preinstall in the sandbox. Package arrays are replaced as a whole. */
@added(Versions.v2026_07_01)
model SandboxPackageSpec {
  /** Package name, optionally including a scope or namespace prefix. */
  @minLength(1)
  @maxLength(214)
  @pattern("^@?[A-Za-z0-9][A-Za-z0-9._-]*(/[A-Za-z0-9][A-Za-z0-9._-]*)?$")
  name: string;

  /** Optional package version or version constraint. Omit it to leave the version unspecified. */
  @minLength(1)
  @maxLength(64)
  @pattern("^[A-Za-z0-9._+\\-~^<>=,*\\[\\]()]+$")
  version?: string;

  /** Package manager used to install the package. Values are case-sensitive. */
  packageManager: SandboxPackageManager;
}

/** Supported package managers for sandbox packages. */
@added(Versions.v2026_07_01)
union SandboxPackageManager {
  string,

  /** Python packages installed with pip. */
  Pip: "pip",

  /** JavaScript packages installed with npm. */
  Npm: "npm",

  /** .NET tools installed from NuGet. */
  Nuget: "nuget",
}

/** Package registries that can be allowed on the managed network path. */
@added(Versions.v2026_07_01)
union SandboxRegistry {
  string,

  /** The Python Package Index. */
  Pypi: "pypi",

  /** The public npm registry. */
  Npmjs: "npmjs",

  /** The public NuGet gallery. */
  NugetOrg: "nuget-org",

  /** Ubuntu package archives. */
  Ubuntu: "ubuntu",
}

/** Code repository providers that can be allowed on the managed network path. */
@added(Versions.v2026_07_01)
union SandboxCodeRepository {
  string,

  /** Repositories hosted on GitHub.com. */
  Github: "Github",

  /** Repositories hosted on GitHub Enterprise. */
  GithubEnterprise: "GithubEnterprise",

  /** Repositories hosted in Azure DevOps. */
  AzureDevOps: "AzureDevOps",

  /** Repositories hosted on GitLab. */
  GitLab: "GitLab",
}

/** Supported modes for outbound network access from the agent's sandbox. */
@added(Versions.v2026_07_01)
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
