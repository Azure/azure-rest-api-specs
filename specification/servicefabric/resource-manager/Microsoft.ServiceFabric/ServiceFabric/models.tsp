import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ServiceFabric;

union ClusterVersionsEnvironment {
  string,

  /**
   * Windows
   */
  Windows: "Windows",

  /**
   * Linux
   */
  Linux: "Linux",
}

/**
 * Describes a node type in the cluster, each node type represents sub set of nodes in the cluster.
 */
model NodeTypeDescription {
  /**
   * The name of the node type.
   */
  name: string;

  /**
   * The placement tags applied to nodes in the node type, which can be used to indicate where certain services (workload) should run.
   */
  placementProperties?: Record<string>;

  /**
   * The capacity tags applied to the nodes in the node type, the cluster resource manager uses these tags to understand how much resource a node has.
   */
  capacities?: Record<string>;

  /**
   * The TCP cluster management endpoint port.
   */
  clientConnectionEndpointPort: int32;

  /**
   * The HTTP cluster management endpoint port.
   */
  httpGatewayEndpointPort: int32;

  /**
   * The durability level of the node type. Learn about [DurabilityLevel](https://docs.microsoft.com/azure/service-fabric/service-fabric-cluster-capacity).
   *
   *   - Bronze - No privileges. This is the default.
   *   - Silver - The infrastructure jobs can be paused for a duration of 10 minutes per UD.
   *   - Gold - The infrastructure jobs can be paused for a duration of 2 hours per UD. Gold durability can be enabled only on full node VM skus like D15_V2, G5 etc.
   *
   */
  durabilityLevel?: DurabilityLevel;

  /**
   * The range of ports from which cluster assigned port to Service Fabric applications.
   */
  applicationPorts?: EndpointRangeDescription;

  /**
   * The range of ephemeral ports that nodes in this node type should be configured with.
   */
  ephemeralPorts?: EndpointRangeDescription;

  /**
   * The node type on which system services will run. Only one node type should be marked as primary. Primary node type cannot be deleted or changed for existing clusters.
   */
  isPrimary: boolean;

  /**
   * VMInstanceCount should be 1 to n, where n indicates the number of VM instances corresponding to this nodeType. VMInstanceCount = 0 can be done only in these scenarios: NodeType is a secondary nodeType. Durability = Bronze or Durability >= Bronze and InfrastructureServiceManager = true. If VMInstanceCount = 0, implies the VMs for this nodeType will not be used for the initial cluster size computation.
   */
  @maxValue(2147483647)
  vmInstanceCount: int32;

  /**
   * The endpoint used by reverse proxy.
   */
  reverseProxyEndpointPort?: int32;

  /**
   * Indicates if the node type can only host Stateless workloads.
   */
  isStateless?: boolean;

  /**
   * Indicates if the node type is enabled to support multiple zones.
   */
  multipleAvailabilityZones?: boolean;

  /**
   * The port used for token-auth based HTTPS connections to the cluster. Cannot be set to the same port as HttpGatewayEndpoint.
   */
  httpGatewayTokenAuthEndpointPort?: int32;
}

/**
 * Port range details
 */
model EndpointRangeDescription {
  /**
   * Starting port of a range of ports
   */
  startPort: int32;

  /**
   * End port of a range of ports
   */
  endPort: int32;
}

/**
 * The resource model definition.
 */
model Resource {
  /**
   * Azure resource identifier.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Azure resource name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Azure resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Azure resource location.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location: string;

  /**
   * Azure resource tags.
   */
  tags?: Record<string>;

  /**
   * Azure resource etag.
   */
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * Metadata pertaining to creation and last modification of the resource.
 */
model SystemData {
  /**
   * The identity that created the resource.
   */
  createdBy?: string;

  /**
   * The type of identity that created the resource.
   */
  createdByType?: string;

  /**
   * The timestamp of resource creation (UTC).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * The identity that last modified the resource.
   */
  lastModifiedBy?: string;

  /**
   * The type of identity that last modified the resource.
   */
  lastModifiedByType?: string;

  /**
   * The timestamp of resource last modification (UTC).
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;
}

/**
 * The structure of the error.
 */
@error
model ErrorModel {
  /**
   * The error details.
   */
  error?: ErrorModelError;
}

/**
 * The error details.
 */
model ErrorModelError {
  /**
   * The error code.
   */
  code?: string;

  /**
   * The error message.
   */
  message?: string;
}

/**
 * Available operation list result
 */
model OperationResult {
  /**
   * The name of the operation.
   */
  name?: string;

  /**
   * Indicates whether the operation is a data action
   */
  isDataAction?: boolean;

  /**
   * The object that represents the operation.
   */
  display?: AvailableOperationDisplay;

  /**
   * Origin result
   */
  origin?: string;

  /**
   * The URL to use for getting the next set of results.
   */
  nextLink?: string;
}

/**
 * Operation supported by the Service Fabric resource provider
 */
model AvailableOperationDisplay {
  /**
   * The name of the provider.
   */
  provider?: string;

  /**
   * The resource on which the operation is performed
   */
  resource?: string;

  /**
   * The operation that can be performed.
   */
  operation?: string;

  /**
   * Operation description
   */
  description?: string;
}

/**
 * The resource model definition for proxy-only resource.
 */
model ProxyResource {
  /**
   * Azure resource identifier.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Azure resource name.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * Azure resource type.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * It will be deprecated in New API, resource location depends on the parent resource.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * Azure resource tags.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  tags?: Record<string>;

  /**
   * Azure resource etag.
   */
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}
