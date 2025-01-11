import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./privateAccess.models.tsp";
import "./common.models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.OpenAPI;

namespace Microsoft.Chaos;
/**
 * The private endpoint connection resource.
 */
@parentResource(PrivateAccess)
@removed(Versions.v2025_02_01)
model PrivateEndpointConnection
  is Azure.ResourceManager.ProxyResource<PrivateEndpointConnectionProperties> {
  ...ResourceNameParameter<
    Resource = PrivateEndpointConnection,
    KeyName = "privateEndpointConnectionName",
    SegmentName = "privateEndpointConnections",
    NamePattern = "^[^<>%&:?#/\\\\]+$"
  >;
}

/**
 * Properties of the private endpoint connection.
 */
@removed(Versions.v2025_02_01)
model PrivateEndpointConnectionProperties {
  /**
   * The group ids for the private endpoint resource.
   */
  @visibility("read")
  groupIds?: string[];

  /**
   * The private endpoint resource.
   */
  privateEndpoint?: PrivateEndpoint;

  /**
   * A collection of information about the state of the connection between service consumer and provider.
   */
  privateLinkServiceConnectionState: PrivateLinkServiceConnectionState;

  /**
   * The provisioning state of the private endpoint connection resource.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * The private endpoint resource.
 */
@removed(Versions.v2025_02_01)
model PrivateEndpoint {
  /**
   * The ARM identifier for private endpoint.
   */
  @visibility("read")
  id?: string;
}

/**
 * A collection of information about the state of the connection between service consumer and provider.
 */
@removed(Versions.v2025_02_01)
model PrivateLinkServiceConnectionState {
  /**
   * Indicates whether the connection has been Approved/Rejected/Removed by the owner of the service.
   */
  status?: PrivateEndpointServiceConnectionStatus;

  /**
   * The reason for approval/rejection of the connection.
   */
  description?: string;

  /**
   * A message indicating if changes on the service provider require any updates on the consumer.
   */
  actionsRequired?: string;
}

/**
 * The private endpoint connection status.
 */
@removed(Versions.v2025_02_01)
union PrivateEndpointServiceConnectionStatus {
  string,

  /**
   * Pending status.
   */
  Pending: "Pending",

  /**
   * Approved status.
   */
  Approved: "Approved",

  /**
   * Rejected status.
   */
  Rejected: "Rejected",
}

/**
 * A list of private link resources
 */
@removed(Versions.v2025_02_01)
model PrivateEndpointConnectionListResult
  is Azure.Core.Page<PrivateEndpointConnection>;

/**
 * A private link resource.
 */
@removed(Versions.v2025_02_01)
model PrivateLinkResource
  is Azure.ResourceManager.TrackedResource<
    PrivateLinkResourceProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = PrivateLinkResource,
    KeyName = "privateLinkName",
    SegmentName = "privateLinkResources",
    NamePattern = "^[^<>%&:?#/\\\\]+$"
  >;
}

/**
 * Properties of a private link resource.
 */
@removed(Versions.v2025_02_01)
model PrivateLinkResourceProperties {
  /**
   * The private link resource group id.
   */
  @visibility("read")
  groupId?: string;

  /**
   * The private link resource required member names.
   */
  @visibility("read")
  requiredMembers?: string[];

  /**
   * The private link resource private link DNS zone name.
   */
  requiredZoneNames?: string[];

  /**
   * Resource provisioning state. Not currently in use.
   */
  @visibility("read")
  provisioningState?: ProvisioningState;
}

/**
 * A list of private link resources
 */
@removed(Versions.v2025_02_01)
model PrivateLinkResourceListResult is Azure.Core.Page<PrivateLinkResource>;
