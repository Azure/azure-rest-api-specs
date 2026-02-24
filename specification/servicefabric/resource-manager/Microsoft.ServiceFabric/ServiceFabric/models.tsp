import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.ServiceFabric;

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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "servicefabric is a brownfield resource with existing APIs that use Record types"
  placementProperties?: Record<string>;

  /**
   * The capacity tags applied to the nodes in the node type, the cluster resource manager uses these tags to understand how much resource a node has.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "servicefabric is a brownfield resource with existing APIs that use Record types"
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
  @minValue(0)
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
