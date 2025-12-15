import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@typespec/versioning";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.BareMetal;

/**
 * Placement of the SDN Appliance
 */
union SdnAppliancePlacement {
  string,

  /**
   * T1 device
   */
  T1: "T1",

  /**
   * T2 device
   */
  T2: "T2",

  /**
   * Across T2 device
   */
  AcrossT2: "AcrossT2",
}

/**
 * The current provisioning state.
 */
union ProvisioningState {
  string,

  @doc("is creating")
  Creating: "Creating",

  @doc("is deleting")
  Deleting: "Deleting",

  @doc("is succeeded")
  Succeeded: "Succeeded",

  @doc("is failed")
  Failed: "Failed",

  @doc("is canceled")
  Canceled: "Canceled",
}

/**
 * The current provisioning state for a peering link.
 */
union PeeringLinkProvisioningState {
  string,

  @doc("is succeeded")
  Succeeded: "Succeeded",

  @doc("is failed")
  Failed: "Failed",

  @doc("is removed")
  Removed: "Removed",
}

/**
 * Status of the route to virtualNetwork.
 */
union RouteToVirtualNetworkOperationStatus {
  string,

  @doc("is succeeded")
  succeeded: "succeeded",

  @doc("is failed")
  failed: "failed",
}

/**
 * Type of operation.
 */
union RoutesToVirtualNetworkOperationType {
  string,

  @doc("is create operation")
  create: "create",

  @doc("is delete operation")
  delete: "delete",
}

@doc("A location resource")
@subscriptionResource
model Location is ProxyResource<LocationProperties> {
  @doc("A location in a subscription")
  @pattern("^[-\\w\\._]+$")
  @key("location")
  @path
  @segment("locations")
  name: string;
}

@doc("location provisioning state")
union LocationProvisioningState {
  string,
  ResourceProvisioningState,
}

@doc("The properties of a location resource")
model LocationProperties {
  @doc("The provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: LocationProvisioningState;
}

/**
 * Model representing a BareMetal Connection object.
 */
model BareMetalConnection is TrackedResource<BareMetalConnectionProperties> {
  /**
   * The name of the BareMetal Connection. The name is case insensitive.
   */
  @maxLength(63)
  @minLength(3)
  @pattern("^[-\\w\\._\\(\\)]+$")
  @path
  @key("connectionName")
  @segment("bareMetalConnections")
  @visibility(Lifecycle.Read)
  name: string;

  /**
   * Resource Etag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Can not change existing defination"
  etag?: string;
}

/**
 * Basic BareMetal Connection properties needed for the request and response.
 */
model BareMetalConnectionProperties {
  /**
   * IPv4 address to be allocated in the subnet of the associated BareMetal Connection.
   */
  ipAddress: string;

  /**
   * VLAN ID assigned to the subnet of the associated BareMetal Connection.  Assigned by resource provider.
   */
  @visibility(Lifecycle.Read)
  vlanId?: string;

  /**
   * ID of the baremetal device in GUID format.
   */
  deviceId: string;

  /**
   * The baremetal-delegated subnet resource ID.
   */
  #suppress "deprecated" "Can not change existing defination"
  subnetResourceId: ResourceIdentifier;

  /**
   * The current provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Model representing a BareMetal Connection object.
 */
model BareMetalConnectionUpdate {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Type exists as previously approved by ARM"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}

/**
 * Network Interface Attachment resource.
 */
@added(Versions.v2025_08_01_preview)
model NetworkInterfaceAttachment
  is TrackedResource<NetworkInterfaceAttachmentProperties> {
  /**
   * The name of the Network Interface Attachment resource.
   */
  @maxLength(72)
  @minLength(3)
  @pattern("^[-\\w\\._\\(\\)]+$")
  @path
  @key("networkInterfaceAttachmentName")
  @segment("networkInterfaceAttachments")
  @visibility(Lifecycle.Read)
  name: string;
}

/**
 * Properties for creating Network Interface Attachment via PUT.
 */
@added(Versions.v2025_08_01_preview)
model NetworkInterfaceAttachmentCreateProperties {
  /** Subnet resource id. */
  subnetResourceId: Azure.Core.armResourceIdentifier<[]>;

  /** Single digit physical AZ in string format (e.g., "1"). */
  @pattern("^[0-9]$")
  sddcPhysicalAz: string;

  /** SDDC identifier (GUID). */
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  sddcId: string;
}

/**
 * IP configuration under an anchor NIC.
 */
@added(Versions.v2025_08_01_preview)
model NetworkInterfaceIpConfiguration {
  /** Private IP address in CIDR. */
  @pattern("^(([0-9]{1,3}\\.){3}[0-9]{1,3}|([a-fA-F0-9:]+))(\\/([0-9]{1,3}))?$")
  privateIpAddress: string;

  /** IP version. */
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Maintaining compatibility with current SDKs."
  privateIpAddressVersion: "IPv4" | "IPv6" | string;

  /** Whether this is primary. */
  primary: boolean;
}

/**
 * Anchor NIC entry.
 */
@added(Versions.v2025_08_01_preview)
model NetworkInterface {
  /** NIC ARM resource id. */
  id: Azure.Core.armResourceIdentifier<[]>;

  /** IP configurations (1-1024). */
  @minItems(1)
  @identifiers(#[])
  ipConfigurations: NetworkInterfaceIpConfiguration[];
}

/**
 * Full properties of Network Interface Attachment.
 */
@added(Versions.v2025_08_01_preview)
model NetworkInterfaceAttachmentProperties
  is NetworkInterfaceAttachmentCreateProperties {
  /** BGP NICs (always exactly 2, read-only). */
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#["id"])
  bgpNics?: NetworkInterface[];

  /** Anchor NICs. Not provided in PUT request body (service populates after create). Returned in all responses. */
  @visibility(Lifecycle.Read)
  @Azure.ResourceManager.identifiers(#["id"])
  anchorNics?: NetworkInterface[];

  /** Provisioning state. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * PATCH model for Network Interface Attachment (anchor NICs + tags).
 */
@added(Versions.v2025_08_01_preview)
model NetworkInterfaceAttachmentPatchModel {
  /** Resource tags. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Patch tags object"
  @visibility(Lifecycle.Read, Lifecycle.Update)
  tags?: Record<string>;

  /** Updatable properties. */
  properties?: NetworkInterfaceAttachmentPatchProperties;
}

/** Properties updatable via PATCH. */
@added(Versions.v2025_08_01_preview)
model NetworkInterfaceAttachmentPatchProperties {
  /** Anchor NICs (minimum 1). */
  anchorNics?: NetworkInterface[];
}

/**
 * Custom Page for Clusters
 */
model ClusterPage<T extends {}> {
  /**
   * Items on this page
   */
  @pageItems
  @Azure.ResourceManager.identifiers(#[])
  clusters: T[];
}

/**
 * List of cluster properties
 */
model ClusterList is ClusterPage<ClusterProperties>;

/**
 * Cluster object representation
 */
model ClusterProperties {
  /**
   * Name of the cluster
   */
  @visibility(Lifecycle.Read)
  clusterName?: string;

  /**
   * Number of Virtual Routing and Forwarding currently on the cluster
   */
  @visibility(Lifecycle.Read)
  vrfCount?: int32;

  /**
   * Max number of Virtual Routing and Forwarding for the cluster
   */
  @visibility(Lifecycle.Read)
  vrfLimit?: int32;

  /**
   * Number of routes currently on the cluster
   */
  @visibility(Lifecycle.Read)
  routeCount?: int32;

  /**
   * Max number of routes for the cluster
   */
  @visibility(Lifecycle.Read)
  routeLimit?: int32;

  /**
   * Potential number of routes for the cluster
   */
  @visibility(Lifecycle.Read)
  allocatedRoutes?: int32;

  /**
   * Alias of the T2 device
   */
  @visibility(Lifecycle.Read)
  tier2Alias?: string;

  /**
   * Placement of the SDN Appliance
   */
  @visibility(Lifecycle.Read)
  sdnAppliancePlacement?: SdnAppliancePlacement;

  /**
   * True if Rotterdam, else False
   */
  @visibility(Lifecycle.Read)
  sdnApplianceEnabled?: boolean;

  /**
   * AvailabilityZone of the cluster in string format
   */
  @visibility(Lifecycle.Read)
  availabilityZone?: string;

  /**
   * Physical index of current availability zone
   */
  @visibility(Lifecycle.Read)
  physicalZoneIndex?: int32;

  /**
   * Route limits for cache enabled clusters
   */
  @visibility(Lifecycle.Read)
  allocatedRoutesLimit?: int32;

  /**
   * Timestamp when the current values were retrieved from the cluster
   */
  @visibility(Lifecycle.Read)
  lastUpdated?: string;
}

/**
 * Update Routes on VirtualNetwork Object.
 */
model UpdateRoutesOnVirtualNetwork {
  /**
   * Update Routes on Virtual Network Properties Object.
   */
  properties?: UpdateRoutesOnVirtualNetworkProperties;
}

/**
 * Update Routes on VirtualNetwork Properties.
 */
model UpdateRoutesOnVirtualNetworkProperties {
  /**
   * List of Routes that needs to updated for VirtualNetwork.
   */
  @Azure.ResourceManager.identifiers(#["vnetId", "routeAddress"])
  routesToVirtualNetwork: RoutesToVirtualNetworkOperationsProperties[];

  /**
   * Type of operation.
   */
  operationType: RoutesToVirtualNetworkOperationType;
}

/**
 * Routes to VirtualNetwork Operations Properties.
 */
model RoutesToVirtualNetworkOperationsProperties {
  /**
   * Vnet Id in GUID format.
   */
  vnetId: string;

  /**
   * Route Address in IP Address format.
   */
  routeAddress: string;

  /**
   * Next Hop Network Interface Id in GUID format.
   */
  nextHopNetworkInterfaceId?: string;

  /**
   * Logical Container Id in GUID format.
   */
  logicalContainerId: string;

  /**
   * AvailabilityZone in string format.
   */
  availabilityZone: string;

  /**
   * Status of the route.
   */
  @visibility(Lifecycle.Read)
  status?: RouteToVirtualNetworkOperationStatus;

  /**
   * The error detail.
   */
  @visibility(Lifecycle.Read)
  error?: Azure.ResourceManager.Foundations.ErrorDetail;
}

/**
 * Model representing a Peering Setting object.
 */
model PeeringSetting is TrackedResource<PeeringSettingProperties> {
  /**
   * The name of the Peering Setting. The name is case insensitive.
   */
  @maxLength(101)
  @minLength(36)
  @pattern("^[-\\w\\._\\(\\)]+$")
  @path
  @key("peeringSettingName")
  @segment("peeringSettings")
  @visibility(Lifecycle.Read)
  name: string;

  /**
   * Resource Etag.
   */
  ...EntityTagProperty;
}

/**
 * Basic Peering Setting properties needed for the request and response.
 */
model PeeringSettingProperties {
  /**
   * Linked Resources in a source vnet.
   */
  linkedResources: string[];

  /**
   * Source vnet ID in the following format: "Source/VNET/ARM/Resource/ID"
   */
  virtualNetworkId: string;

  /**
   * Source vnet GUID.
   */
  virtualNetworkGuid: string;

  /**
   * Peering links from a source vnet to remote vnet(s).
   */
  @Azure.ResourceManager.identifiers(#[])
  remotePeeringLinks: RemotePeeringLink[];

  /**
   * The current provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/**
 * Model representing a Remote Peering Link
 */
model RemotePeeringLink {
  /**
   * Remote vnet ID in the following format: "Remote/VNET/ARM/Resource/ID"
   */
  remoteVirtualNetworkId: string;

  /**
   * The current provisioning state for a peering link.
   */
  @visibility(Lifecycle.Read)
  autoSyncProvisioningStatus?: PeeringLinkProvisioningState;
}

/**
 * Updated peering setting object
 */
model PeeringSettingUpdate {
  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Type exists as previously approved by ARM"
  @visibility(Lifecycle.Read, Lifecycle.Create, Lifecycle.Update)
  tags?: Record<string>;
}
