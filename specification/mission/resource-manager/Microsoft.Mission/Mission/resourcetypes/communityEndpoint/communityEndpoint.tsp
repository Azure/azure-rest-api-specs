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

@added(Microsoft.Mission.Versions.v2026_05_01_preview)
@doc("The direction of traffic for a Community Endpoint rule.")
union RuleDirection {
  string,

  @doc("Outbound traffic from the client enclave to the server destination.")
  Outbound: "Outbound",

  @doc("Inbound traffic from the server to the client enclave.")
  Inbound: "Inbound",
}

@added(Microsoft.Mission.Versions.v2026_05_01_preview)
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

  @doc("Synchronization succeeded on some destinations but failed on others.")
  PartiallySucceeded: "PartiallySucceeded",
}

@added(Microsoft.Mission.Versions.v2026_05_01_preview)
@doc("Status of synchronization to a specific destination Community Endpoint.")
model SyncDestinationStatus {
  @doc("The ARM resource ID of the destination Community Endpoint.")
  @visibility(Lifecycle.Read)
  destinationId: CommunityEndpointResourceId;

  @doc("The synchronization status for this destination.")
  @visibility(Lifecycle.Read)
  status: SyncStatus;

  @doc("The error message when synchronization to this destination fails.")
  @visibility(Lifecycle.Read)
  errorMessage?: string;

  @doc("The timestamp of the last successful synchronization to this destination.")
  @visibility(Lifecycle.Read)
  lastSyncTime?: utcDateTime;
}

@added(Microsoft.Mission.Versions.v2026_05_01_preview)
@doc("Information about the principal who performed the synchronization operation.")
model SyncPerformedBy {
  @doc("The object ID of the principal who configured synchronization.")
  @visibility(Lifecycle.Read)
  principalId: string;

  @doc("The type of principal that configured synchronization.")
  @visibility(Lifecycle.Read)
  principalType: string;

  @doc("The tenant ID of the principal.")
  @visibility(Lifecycle.Read)
  tenantId: string;

  @doc("The timestamp when synchronization was configured or last modified.")
  @visibility(Lifecycle.Read)
  performedAt: utcDateTime;

  @doc("The Azure Resource Manager correlation ID from the source update.")
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

  @added(Microsoft.Mission.Versions.v2026_05_01_preview)
  @doc("The direction of traffic for this rule.")
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

  @added(Microsoft.Mission.Versions.v2026_05_01_preview)
  @maxItems(100)
  @doc("Destination communities to synchronize this endpoint's rules to.")
  syncTo?: CommunityResourceId[];

  @added(Microsoft.Mission.Versions.v2026_05_01_preview)
  @doc("The source Community Endpoint that manages this endpoint through synchronization.")
  @visibility(Lifecycle.Read)
  syncFrom?: CommunityEndpointResourceId;

  @added(Microsoft.Mission.Versions.v2026_05_01_preview)
  @doc("The synchronization status of this Community Endpoint.")
  @visibility(Lifecycle.Read)
  syncStatus?: SyncStatus;

  @added(Microsoft.Mission.Versions.v2026_05_01_preview)
  @identifiers(#["destinationId"])
  @doc("The synchronization status for each destination Community Endpoint.")
  @visibility(Lifecycle.Read)
  syncDestinationStatuses?: SyncDestinationStatus[];

  @added(Microsoft.Mission.Versions.v2026_05_01_preview)
  @doc("The principal who last configured or modified synchronization.")
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
