import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";

using Azure.ResourceManager;
using TypeSpec.Versioning;
using Azure.Core;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@doc("Community Endpoint Protocol Enum")
union CommunityEndpointProtocol {
  string,

  @doc("CommunityEndpointProtocol Type ANY")
  ANY: "ANY",

  @doc("CommunityEndpointProtocol Type TCP")
  TCP: "TCP",

  @doc("CommunityEndpointProtocol Type UDP")
  UDP: "UDP",

  @doc("CommunityEndpointProtocol Type ICMP")
  ICMP: "ICMP",

  @doc("CommunityEndpointProtocol Type ESP")
  ESP: "ESP",

  @doc("CommunityEndpointProtocol Type AH")
  AH: "AH",

  @doc("CommunityEndpointProtocol Type HTTPS")
  HTTPS: "HTTPS",

  @doc("CommunityEndpointProtocol Type HTTP")
  HTTP: "HTTP",
}

@doc("Destination Type Enum")
union DestinationType {
  string,

  @doc("DestinationType Type FQDN")
  FQDN: "FQDN",

  @doc("DestinationType Type FQDNTag")
  FQDNTag: "FQDNTag",

  @doc("DestinationType Type IPAddress")
  IPAddress: "IPAddress",

  @doc("DestinationType Type PrivateNetwork")
  PrivateNetwork: "PrivateNetwork",

  @added(Microsoft.Mission.Versions.v2025_11_01_preview)
  @doc("DestinationType Type ServiceTag")
  ServiceTag: "ServiceTag",
}

@added(Microsoft.Mission.Versions.v2026_10_01_preview)
@doc("The direction of traffic for a Community Endpoint rule.")
union RuleDirection {
  string,

  @doc("Outbound traffic from the client enclave to the server destination (default).")
  Outbound: "Outbound",

  @doc("Inbound traffic from the server to the client enclave.")
  Inbound: "Inbound",
}

@added(Microsoft.Mission.Versions.v2026_10_01_preview)
@doc("The synchronization status of a Community Endpoint.")
union SyncStatus {
  string,

  @doc("Synchronization is not configured for this endpoint.")
  NotConfigured: "NotConfigured",

  @doc("Synchronization completed successfully on all destinations.")
  Succeeded: "Succeeded",

  @doc("Synchronization is currently in progress.")
  InProgress: "InProgress",

  @doc("Synchronization failed on all destinations.")
  Failed: "Failed",

  @doc("Synchronization succeeded on some destinations but failed on others. Check syncDestinationStatuses for per-destination details.")
  PartiallySucceeded: "PartiallySucceeded",
}

@added(Microsoft.Mission.Versions.v2026_10_01_preview)
@doc("Status of synchronization to a specific destination Community Endpoint.")
model SyncDestinationStatus {
  @doc("ARM resource ID of the destination Community Endpoint.")
  @visibility(Lifecycle.Read)
  destinationId: CommunityEndpointResourceId;

  @doc("The synchronization status for this destination.")
  @visibility(Lifecycle.Read)
  status: SyncStatus;

  @doc("Error message if the sync to this destination failed.")
  @visibility(Lifecycle.Read)
  errorMessage?: string;

  @doc("Timestamp of the last successful sync to this destination.")
  @visibility(Lifecycle.Read)
  lastSyncTime?: utcDateTime;
}

@added(Microsoft.Mission.Versions.v2026_10_01_preview)
@doc("Information about the principal who performed the sync operation.")
model SyncPerformedBy {
  @doc("Object ID of the user principal who configured syncTo.")
  @visibility(Lifecycle.Read)
  principalId: string;

  @doc("The type of principal (e.g., User, ServicePrincipal).")
  @visibility(Lifecycle.Read)
  principalType: string;

  @doc("Tenant ID of the principal.")
  @visibility(Lifecycle.Read)
  tenantId: string;

  @doc("Timestamp when the syncTo was configured or last modified.")
  @visibility(Lifecycle.Read)
  performedAt: utcDateTime;

  @doc("ARM correlation ID from the source PUT that set up syncTo.")
  @visibility(Lifecycle.Read)
  correlationId: string;
}

@doc("Base type for destination rules.")
model CommunityEndpointDestinationRule {
  @doc("Destination Type.")
  destinationType?: DestinationType;

  @doc("Protocols. Options specified by Endpoint Protocol Enum.")
  protocols?: CommunityEndpointProtocol[];

  @doc("Transit Hub Resource Id.")
  transitHubResourceId?: TransitHubResourceId;

  @added(Microsoft.Mission.Versions.v2026_10_01_preview)
  @doc("The direction of traffic for this rule. Defaults to Outbound if not specified.")
  direction?: RuleDirection = RuleDirection.Outbound;

  ...EndpointRuleBase;
}

@doc("Community Endpoint Resource properties")
model CommunityEndpointProperties {
  @identifiers(#[])
  @doc("Community Endpoint Rule Collection.")
  ruleCollection: CommunityEndpointDestinationRule[];

  @doc("List of resource ids created by community endpoint.")
  @visibility(Lifecycle.Read)
  @typeChangedFrom(Microsoft.Mission.Versions.v2025_05_01_preview, string[])
  resourceCollection?: armResourceIdentifier[];

  @doc("Provisioning State.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @removed(Microsoft.Mission.Versions.v2024_12_01_preview)
  @doc("Whether approval is needed for the connection (True or False).")
  approvalRequired?: boolean;

  @added(Microsoft.Mission.Versions.v2025_11_01_preview)
  @doc("Whether update mode is automatic or manual.")
  updateMode?: UpdateMode;

  @added(Microsoft.Mission.Versions.v2026_10_01_preview)
  @doc("Array of ARM resource IDs of destination communities to synchronize this endpoint's rules to. The RP creates and manages the destination CEPs automatically within each community. Maximum 100 destinations per source endpoint.")
  @maxItems(100)
  syncTo?: CommunityResourceId[];

  @added(Microsoft.Mission.Versions.v2026_10_01_preview)
  @doc("ARM resource ID of the source Community Endpoint that manages this endpoint's rules via synchronization. This property is read-only and set by the RP on destination CEPs created by the sync process.")
  @visibility(Lifecycle.Read)
  syncFrom?: CommunityEndpointResourceId;

  @added(Microsoft.Mission.Versions.v2026_10_01_preview)
  @doc("The synchronization status of this Community Endpoint. Tracks sync state independently of provisioningState.")
  @visibility(Lifecycle.Read)
  syncStatus?: SyncStatus;

  @added(Microsoft.Mission.Versions.v2026_10_01_preview)
  @doc("Per-destination synchronization status. Only populated on source CEPs that have syncTo configured.")
  @visibility(Lifecycle.Read)
  @identifiers(#["destinationId"])
  syncDestinationStatuses?: SyncDestinationStatus[];

  @added(Microsoft.Mission.Versions.v2026_10_01_preview)
  @doc("Information about the principal who last configured or modified syncTo. Set by the RP and surfaced for audit transparency.")
  @visibility(Lifecycle.Read)
  syncPerformedBy?: SyncPerformedBy;
}

@doc("Community Endpoint patchable Properties")
model CommunityEndpointPatchProperties
  is UpdateableProperties<OmitDefaults<CommunityEndpointProperties>>;

@doc("Community Endpoint Patch Resource")
model CommunityEndpointPatchModel {
  @doc("Community Endpoint Patch properties")
  properties?: CommunityEndpointPatchProperties;

  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
}
