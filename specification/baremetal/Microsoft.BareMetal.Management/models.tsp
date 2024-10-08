import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.BareMetal;

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
 * The current provisioning state for a peering setting.
 */
union PeeringSettingProvisioningState {
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

  @doc("is removed")
  Removed: "Removed",

  @doc("is accepted")
  Accepted: "Accepted",
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
  @visibility("read")
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
  @visibility("read")
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
  @visibility("read")
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
  @visibility("read")
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
  @visibility("read", "create", "update")
  tags?: Record<string>;
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
  @OpenAPI.extension("x-ms-identifiers", ["vnetId", "routeAddress"])
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
  @visibility("read")
  status?: RouteToVirtualNetworkOperationStatus;

  /**
   * The error detail.
   */
  @visibility("read")
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
  @segment("peeringSetting")
  @visibility("read")
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
   * Tenant Ids in a source vnet.
   */
  tenantIds: string[];

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
  @OpenAPI.extension("x-ms-identifiers", [])
  remotePeeringLinks: RemotePeeringLink[];

  /**
   * The current provisioning state.
   */
  @visibility("read")
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
   * The current provisioning state for a peering setting.
   */
  @visibility("read")
  provisioningState?: PeeringSettingProvisioningState;
}

/**
 * Updated peering setting object
 */
model PeeringSettingUpdate {
  /**
   * Properties of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/OBJECT_ADDITIONAL_PROPERTIES" "properties is a managed property."
  properties?: PeeringSettingProperties;

  /**
   * Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Type exists as previously approved by ARM"
  @visibility("read", "create", "update")
  tags?: Record<string>;

  /**
   * Location of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/OBJECT_ADDITIONAL_PROPERTIES" "location is a managed property."
  @visibility("read")
  location?: string;
}
