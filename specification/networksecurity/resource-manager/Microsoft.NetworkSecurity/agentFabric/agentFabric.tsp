import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using Rest;
using Http;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.NetworkSecurity;

/** AgentFabric resource */
model AgentFabric is TrackedResource<AgentFabricProperties> {
  ...ResourceNameParameter<AgentFabric>;
}

/** Provisioning state of the resource */
union ProvisioningState {
  string,

  /** Resource provisioning succeeded */
  Succeeded: "Succeeded",

  /** Resource provisioning failed */
  Failed: "Failed",

  /** Resource provisioning was canceled */
  Canceled: "Canceled",
}

/** AgentFabric properties */
model AgentFabricProperties {
  /** The default policy groups to apply to all members of this fabric. */
  defaultPolicyGroups?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.NetworkSecurity/policyGroups";
    }
  ]>[];

  /** The provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface AgentFabrics {
  get is ArmResourceRead<AgentFabric>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<AgentFabric>;
  update is ArmTagsPatchSync<AgentFabric>;
  delete is ArmResourceDeleteSync<AgentFabric>;
  listByResourceGroup is ArmResourceListByParent<AgentFabric>;
  listBySubscription is ArmListBySubscription<AgentFabric>;
}

/** The workload type of a member. */
union WorkloadType {
  string,

  /** Foundry workload type */
  Foundry: "Foundry",

  /** Agent Fabric sandbox workload type */
  AgentFabricSandbox: "AgentFabricSandbox",
}

/** Base workload configuration for a member. */
@discriminator("type")
model WorkloadBase {
  /** The workload type. */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  type: WorkloadType;

  /** The unique identifier assigned to the workload by the resource provider. */
  @visibility(Lifecycle.Read)
  workloadId?: string;
}

/** Foundry workload configuration. */
model FoundryWorkload extends WorkloadBase {
  /** The workload type. */
  type: "Foundry";

  /** The ARM resource ID of the Foundry resource. */
  resourceId?: Azure.Core.armResourceIdentifier;
}

/** The image pull policy for a sandbox workload container image. */
union ImagePullPolicy {
  string,

  /** Always pull the image. */
  Always: "Always",

  /** Pull the image only if it is not already present on the host. */
  IfNotPresent: "IfNotPresent",
}

/** The container image to run for an Agent Fabric sandbox workload. */
model AgentFabricSandboxImage {
  /** The image reference URI (e.g., registry/repository:tag). */
  uri: string;

  /** The image content digest used to pin an exact image version. */
  digest?: string;

  /** The policy controlling when the image is pulled. */
  pullPolicy?: ImagePullPolicy;
}

/** The compute resources allocated to an Agent Fabric sandbox workload. */
model AgentFabricSandboxResources {
  /** The amount of CPU to allocate to the workload. */
  cpu: string;

  /** The amount of memory to allocate to the workload. */
  memory: string;

  /** The amount of disk to allocate to the workload. */
  disk?: string;
}

/** The Entra agent identity associated with an Agent Fabric sandbox workload. */
model AgentIdentity {
  /** The Azure tenant ID that owns the agent identity. */
  tenantId: string;

  /** The Entra agent ID representing the workload's identity. */
  agentId: string;
}

/** A network endpoint exposed by an Agent Fabric sandbox workload. */
model AgentFabricSandboxEndpoint {
  /** The name of the endpoint. */
  name: string;

  /** The port the endpoint listens on. */
  port: int32;
}

/** Agent Fabric sandbox workload configuration. */
model AgentFabricSandboxWorkload extends WorkloadBase {
  /** The workload type. */
  type: "AgentFabricSandbox";

  /** The container image to run for the workload. */
  image: AgentFabricSandboxImage;

  /** The compute resources allocated to the workload. */
  resources: AgentFabricSandboxResources;

  /** The Entra agent identity associated with the workload. */
  agentIdentity?: AgentIdentity;

  /** The network endpoints exposed by the workload. */
  @identifiers(#["name"])
  endpoints?: AgentFabricSandboxEndpoint[];

  /** The resolvable DNS name assigned to the workload. */
  domain: string;
}

/** Member resource */
@parentResource(AgentFabric)
model Member is ProxyResource<MemberProperties> {
  ...ResourceNameParameter<Member>;
}

/** Member properties */
model MemberProperties {
  /** The workload configuration of the member. */
  workload?: WorkloadBase;

  /** The provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface Members {
  get is ArmResourceRead<Member>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Member>;
  delete is ArmResourceDeleteSync<Member>;
  listByParent is ArmResourceListByParent<Member>;
}

/** The direction of network traffic for a policy. */
union PolicyDirection {
  string,

  /** Outbound traffic only. */
  Outbound: "Outbound",

  /** Inbound traffic only. */
  Inbound: "Inbound",

  /** Both inbound and outbound traffic. */
  Both: "Both",
}

/** The type of network security policy. */
union NetworkSecurityPolicyType {
  string,

  /** FQDN filtering policy type. */
  FqdnFiltering: "FqdnFiltering",

  /** URL filtering policy type. */
  UrlFiltering: "UrlFiltering",

  /** MCP server policy type. */
  Mcp: "Mcp",

  /** TLS inspection policy type. */
  TlsInspection: "TlsInspection",

  /** Content inspection policy type. */
  ContentInspection: "ContentInspection",
}

/** Base network security policy configuration. */
@discriminator("type")
model NetworkSecurityPolicyBase {
  /** The network security policy type. */
  type: NetworkSecurityPolicyType;
}

/** The type of source selector for an FQDN filtering policy. */
union FqdnFilteringSourceType {
  string,

  /** Select sources by workload ID patterns. */
  WorkloadIdPatterns: "WorkloadIdPatterns",

  /** Select sources by IP address prefixes in CIDR notation. */
  AddressPrefixes: "AddressPrefixes",
}

/** Selects the source(s) that an FQDN filtering policy applies to. */
@discriminator("type")
model FqdnFilteringSource {
  /** The type of source selector. */
  type: FqdnFilteringSourceType;
}

/** Selects FQDN filtering sources by workload ID patterns. */
model FqdnFilteringWorkloadIdPatternsSource extends FqdnFilteringSource {
  /** The type of source selector. */
  type: "WorkloadIdPatterns";

  /** The workload ID patterns that identify the source(s). */
  patterns: string[];
}

/** Selects FQDN filtering sources by IP address prefixes. */
model FqdnFilteringAddressPrefixesSource extends FqdnFilteringSource {
  /** The type of source selector. */
  type: "AddressPrefixes";

  /** The IP address prefixes, in CIDR notation, that identify the source(s). */
  prefixes: string[];
}

/** The type of destination selector for an FQDN filtering policy. */
union FqdnFilteringDestinationType {
  string,

  /** Select destinations by fully qualified domain names. */
  Fqdns: "Fqdns",
}

/** Selects the destination(s) that an FQDN filtering policy applies to. */
@discriminator("type")
model FqdnFilteringDestination {
  /** The type of destination selector. */
  type: FqdnFilteringDestinationType;
}

/** Selects FQDN filtering destinations by fully qualified domain names. */
model FqdnFilteringFqdnsDestination extends FqdnFilteringDestination {
  /** The type of destination selector. */
  type: "Fqdns";

  /** The fully qualified domain names that identify the destination(s). */
  fqdns: string[];
}

/** FQDN filtering network security policy. */
model FqdnFilteringPolicy extends NetworkSecurityPolicyBase {
  /** The network security policy type. */
  type: "FqdnFiltering";

  /** The name of the policy. */
  name?: string;

  /** The priority of the policy. */
  priority?: int32;

  /** The direction of traffic for the policy. */
  direction?: PolicyDirection;

  /** The ports for the policy. */
  ports?: int32[];

  /** The source details for the policy. */
  source: FqdnFilteringSource;

  /** The destination details for the policy. */
  destination?: FqdnFilteringDestination;
}

/** The action to take when a network security policy or rule matches traffic. */
union PolicyAction {
  string,

  /** Allow the matching traffic. */
  Allow: "Allow",

  /** Deny the matching traffic. */
  Deny: "Deny",
}

/** The HTTP method matched by a URL filtering rule. */
union HttpMethod {
  string,

  /** HTTP GET method. */
  Get: "GET",

  /** HTTP POST method. */
  Post: "POST",

  /** HTTP PUT method. */
  Put: "PUT",

  /** HTTP DELETE method. */
  Delete: "DELETE",

  /** HTTP PATCH method. */
  Patch: "PATCH",

  /** HTTP HEAD method. */
  Head: "HEAD",

  /** HTTP OPTIONS method. */
  Options: "OPTIONS",
}

/** A single rule within a URL filtering policy. */
model UrlFilteringRule {
  /** The name of the rule. */
  name: string;

  /** The priority of the rule. Rules are evaluated in ascending priority order. */
  priority: int32;

  /** The hostname matched by the rule. If omitted, the rule matches any hostname. */
  hostname?: string;

  /** The HTTP method matched by the rule. If omitted, the rule matches any method. */
  method?: HttpMethod;

  /** The URL paths matched by the rule. If omitted, the rule matches any path. */
  paths?: string[];

  /** The action to take when the rule matches. */
  action: PolicyAction;
}

/** The type of source selector for a URL filtering policy. */
union UrlFilteringSourceType {
  string,

  /** Select sources by workload ID patterns. */
  WorkloadIdPatterns: "WorkloadIdPatterns",

  /** Select sources by IP address prefixes in CIDR notation. */
  AddressPrefixes: "AddressPrefixes",
}

/** Selects the source(s) that a URL filtering policy applies to. */
@discriminator("type")
model UrlFilteringSource {
  /** The type of source selector. */
  type: UrlFilteringSourceType;
}

/** Selects URL filtering sources by workload ID patterns. */
model UrlFilteringWorkloadIdPatternsSource extends UrlFilteringSource {
  /** The type of source selector. */
  type: "WorkloadIdPatterns";

  /** The workload ID patterns that identify the source(s). */
  patterns: string[];
}

/** Selects URL filtering sources by IP address prefixes. */
model UrlFilteringAddressPrefixesSource extends UrlFilteringSource {
  /** The type of source selector. */
  type: "AddressPrefixes";

  /** The IP address prefixes, in CIDR notation, that identify the source(s). */
  prefixes: string[];
}

/** The type of destination selector for a URL filtering policy. */
union UrlFilteringDestinationType {
  string,

  /** Select destinations by workload ID patterns. */
  WorkloadIdPatterns: "WorkloadIdPatterns",

  /** Select destinations by IP address prefixes in CIDR notation. */
  AddressPrefixes: "AddressPrefixes",

  /** Select destinations by fully qualified domain names. */
  Fqdns: "Fqdns",
}

/** Selects the destination(s) that a URL filtering policy applies to. */
@discriminator("type")
model UrlFilteringDestination {
  /** The type of destination selector. */
  type: UrlFilteringDestinationType;
}

/** Selects URL filtering destinations by workload ID patterns. */
model UrlFilteringWorkloadIdPatternsDestination
  extends UrlFilteringDestination {
  /** The type of destination selector. */
  type: "WorkloadIdPatterns";

  /** The workload ID patterns that identify the destination(s). */
  patterns: string[];
}

/** Selects URL filtering destinations by IP address prefixes. */
model UrlFilteringAddressPrefixesDestination extends UrlFilteringDestination {
  /** The type of destination selector. */
  type: "AddressPrefixes";

  /** The IP address prefixes, in CIDR notation, that identify the destination(s). */
  prefixes: string[];
}

/** Selects URL filtering destinations by fully qualified domain names. */
model UrlFilteringFqdnsDestination extends UrlFilteringDestination {
  /** The type of destination selector. */
  type: "Fqdns";

  /** The fully qualified domain names that identify the destination(s). */
  fqdns: string[];
}

/** URL filtering network security policy. */
model UrlFilteringPolicy extends NetworkSecurityPolicyBase {
  /** The network security policy type. */
  type: "UrlFiltering";

  /** The default action to take when no rule in the policy matches. */
  defaultAction: PolicyAction;

  /** The source details for the policy. */
  source: UrlFilteringSource;

  /** The destination details for the policy. */
  destination?: UrlFilteringDestination;

  /** The list of URL filtering rules. */
  @identifiers(#["name"])
  rules: UrlFilteringRule[];
}

/** The type of source selector for an MCP policy. */
union McpPolicySourceType {
  string,

  /** Select sources by workload ID patterns. */
  WorkloadIdPatterns: "WorkloadIdPatterns",

  /** Select sources by IP address prefixes in CIDR notation. */
  AddressPrefixes: "AddressPrefixes",
}

/** Selects the source(s) that an MCP policy applies to. */
@discriminator("type")
model McpPolicySource {
  /** The type of source selector. */
  type: McpPolicySourceType;
}

/** Selects MCP policy sources by workload ID patterns. */
model McpPolicyWorkloadIdPatternsSource extends McpPolicySource {
  /** The type of source selector. */
  type: "WorkloadIdPatterns";

  /** The workload ID patterns that identify the source(s). */
  patterns: string[];
}

/** Selects MCP policy sources by IP address prefixes. */
model McpPolicyAddressPrefixesSource extends McpPolicySource {
  /** The type of source selector. */
  type: "AddressPrefixes";

  /** The IP address prefixes, in CIDR notation, that identify the source(s). */
  prefixes: string[];
}

/** The type of destination selector for an MCP policy. */
union McpPolicyDestinationType {
  string,

  /** Select destinations by workload ID patterns. */
  WorkloadIdPatterns: "WorkloadIdPatterns",

  /** Select destinations by IP address prefixes in CIDR notation. */
  AddressPrefixes: "AddressPrefixes",

  /** Select destinations by fully qualified domain names. */
  Fqdns: "Fqdns",
}

/** Selects the MCP server(s) that an MCP policy applies to. */
@discriminator("type")
model McpPolicyDestination {
  /** The type of destination selector. */
  type: McpPolicyDestinationType;
}

/** Selects MCP policy destinations by workload ID patterns. */
model McpPolicyWorkloadIdPatternsDestination extends McpPolicyDestination {
  /** The type of destination selector. */
  type: "WorkloadIdPatterns";

  /** The workload ID patterns that identify the destination(s). */
  patterns: string[];
}

/** Selects MCP policy destinations by IP address prefixes. */
model McpPolicyAddressPrefixesDestination extends McpPolicyDestination {
  /** The type of destination selector. */
  type: "AddressPrefixes";

  /** The IP address prefixes, in CIDR notation, that identify the destination(s). */
  prefixes: string[];
}

/** Selects MCP policy destinations by fully qualified domain names. */
model McpPolicyFqdnsDestination extends McpPolicyDestination {
  /** The type of destination selector. */
  type: "Fqdns";

  /** The fully qualified domain names that identify the destination(s). */
  fqdns: string[];
}

/** A single rule within an MCP policy. */
model McpRule {
  /** The action to take for the specified MCP tools. */
  action: PolicyAction;

  /** The MCP tool names that the rule applies to. */
  tools: string[];
}

/** MCP server network security policy. */
model McpPolicy extends NetworkSecurityPolicyBase {
  /** The network security policy type. */
  type: "Mcp";

  /** The default action to take when no rule in the policy matches. */
  defaultAction: PolicyAction;

  /** The source(s) that this policy applies to. */
  source: McpPolicySource;

  /** The MCP server(s) that this policy applies to. */
  destination: McpPolicyDestination;

  /** The list of MCP rules. */
  @identifiers(#[])
  rules: McpRule[];
}

/** The source of the certificate used for TLS inspection. */
union TlsInspectionCertificateMode {
  string,

  /** Certificate issued by an Azure-managed certificate authority. */
  AzureManagedCA: "AzureManagedCA",
}

/** Base certificate configuration for a TLS inspection policy. */
@discriminator("mode")
model TlsInspectionCertificateBase {
  /** The source mode of the TLS inspection certificate. */
  mode: TlsInspectionCertificateMode;
}

/** TLS inspection certificate issued by an Azure-managed certificate authority. */
model AzureManagedCaCertificate extends TlsInspectionCertificateBase {
  /** The source mode of the TLS inspection certificate. */
  mode: "AzureManagedCA";
}

/** The type of source selector for a TLS inspection policy. */
union TlsInspectionPolicySourceType {
  string,

  /** Select sources by workload ID patterns. */
  WorkloadIdPatterns: "WorkloadIdPatterns",
}

/** Selects the source(s) that a TLS inspection policy applies to. */
@discriminator("type")
model TlsInspectionPolicySource {
  /** The type of source selector. */
  type: TlsInspectionPolicySourceType;
}

/** Selects TLS inspection sources by workload ID patterns. */
model TlsInspectionPolicyWorkloadIdPatternsSource
  extends TlsInspectionPolicySource {
  /** The type of source selector. */
  type: "WorkloadIdPatterns";

  /** The workload ID patterns that identify the source(s). */
  patterns: string[];
}

/** TLS inspection network security policy. */
model TlsInspectionPolicy extends NetworkSecurityPolicyBase {
  /** The network security policy type. */
  type: "TlsInspection";

  /** The source details for the policy. */
  source: TlsInspectionPolicySource;

  /** The certificate configuration used for TLS inspection. */
  certificate: TlsInspectionCertificateBase;
}

/** The sensitivity level of content inspection. */
union ContentInspectionSensitivity {
  string,

  /** Low sensitivity. */
  Low: "Low",

  /** Medium sensitivity. */
  Medium: "Medium",

  /** High sensitivity. */
  High: "High",
}

/** The action to take when prompt injection is detected. */
union PromptInjectionOnDetection {
  string,

  /** Block the request or response and raise an alert. */
  BlockAndAlert: "BlockAndAlert",

  /** Raise an alert but allow the request or response to proceed. */
  Alert: "Alert",

  /** Remove the detected content and allow the request or response to proceed. */
  Sanitize: "Sanitize",
}

/** Prompt injection protection configuration. */
model PromptInjectionProtection {
  /** The sensitivity level of prompt injection detection. */
  sensitivity?: ContentInspectionSensitivity;

  /** The JSONPath expressions selecting the parts of the request body to scan for prompt injection. */
  promptLocations?: string[];

  /** The JSONPath expressions selecting the parts of the response body to scan for prompt injection. */
  responseLocations?: string[];

  /** The action to take when prompt injection is detected. */
  onDetection: PromptInjectionOnDetection;
}

/** The type of source selector for a content inspection policy. */
union ContentInspectionPolicySourceType {
  string,

  /** Select sources by workload ID patterns. */
  WorkloadIdPatterns: "WorkloadIdPatterns",

  /** Select sources by IP address prefixes in CIDR notation. */
  AddressPrefixes: "AddressPrefixes",
}

/** Selects the source(s) that a content inspection policy applies to. */
@discriminator("type")
model ContentInspectionPolicySource {
  /** The type of source selector. */
  type: ContentInspectionPolicySourceType;
}

/** Selects content inspection sources by workload ID patterns. */
model ContentInspectionPolicyWorkloadIdPatternsSource
  extends ContentInspectionPolicySource {
  /** The type of source selector. */
  type: "WorkloadIdPatterns";

  /** The workload ID patterns that identify the source(s). */
  patterns: string[];
}

/** Selects content inspection sources by IP address prefixes. */
model ContentInspectionPolicyAddressPrefixesSource
  extends ContentInspectionPolicySource {
  /** The type of source selector. */
  type: "AddressPrefixes";

  /** The IP address prefixes, in CIDR notation, that identify the source(s). */
  prefixes: string[];
}

/** Content inspection network security policy. */
model ContentInspectionPolicy extends NetworkSecurityPolicyBase {
  /** The network security policy type. */
  type: "ContentInspection";

  /** The source details for the policy. */
  source: ContentInspectionPolicySource;

  /** The prompt injection protection configuration. */
  promptInjectionProtection?: PromptInjectionProtection;
}

/** PolicyGroup resource. */
model PolicyGroup is TrackedResource<PolicyGroupProperties> {
  ...ResourceNameParameter<PolicyGroup>;
}

/** PolicyGroup properties. */
model PolicyGroupProperties {
  /** The display name of the policy group. */
  displayName?: string;

  /** The description of the policy group. */
  description?: string;

  /** The priority of the policy group. */
  priority?: int32;

  /** The list of network security policies. */
  @identifiers(#[])
  networkSecurityPolicies?: NetworkSecurityPolicyBase[];

  /** The provisioning state of the resource. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@armResourceOperations
interface PolicyGroups {
  get is ArmResourceRead<PolicyGroup>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<PolicyGroup>;
  update is ArmTagsPatchSync<PolicyGroup>;
  delete is ArmResourceDeleteSync<PolicyGroup>;
  listByResourceGroup is ArmResourceListByParent<PolicyGroup>;
  listBySubscription is ArmListBySubscription<PolicyGroup>;
}
