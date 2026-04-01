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
 * The resource model definition for proxy-only resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ResourceManager.Legacy.customAzureResource
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
  @visibility(Lifecycle.Create, Lifecycle.Read)
  location?: string;

  /**
   * Azure resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Create, Lifecycle.Read)
  tags?: Record<string>;

  /**
   * Azure resource etag.
   */
  @visibility(Lifecycle.Read)
  etag?: string;

  /**
   * Metadata pertaining to creation and last modification of the resource.
   */
  systemData?: Azure.ResourceManager.Foundations.SystemData;
}

/**
 * Describes the result of the request to list Service Fabric resource provider operations.
 */
model OperationListResult {
  /**
   * List of operations supported by the Service Fabric resource provider.
   */
  @pageItems
  value?: OperationResult[];

  /**
   * URL to get the next set of operation list results if there are any.
   */
  @nextLink
  nextLink?: string;
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

/**
 * Describes the managed identities for an Azure resource.
 */
model ManagedIdentity {
  /**
   * The principal id of the managed identity. This property will only be provided for a system assigned identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The tenant id of the managed identity. This property will only be provided for a system assigned identity.
   */
  @visibility(Lifecycle.Read)
  tenantId?: string;

  /**
   * The type of managed identity for the resource.
   */
  type?: ManagedIdentityType;

  /**
   * The list of user identities associated with the resource. The user identity dictionary key references will be ARM resource ids in the form:
   * '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.ManagedIdentity/userAssignedIdentities/{identityName}'.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "servicefabric is a brownfield resource with existing APIs that use Record types"
  userAssignedIdentities?: Record<UserAssignedIdentity>;
}

/**
 * The type of managed identity for the resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ManagedIdentityType {
  /**
   * Indicates that system assigned identity is associated with the resource.
   */
  SystemAssigned: "SystemAssigned",

  /**
   * Indicates that user assigned identity is associated with the resource.
   */
  UserAssigned: "UserAssigned",

  /**
   * Indicates that both system assigned and user assigned identity are associated with the resource.
   */
  SystemAssignedUserAssigned: "SystemAssigned, UserAssigned",

  /**
   * Indicates that no identity is associated with the resource.
   */
  None: "None",
}

/**
 * Describes a user assigned identity.
 */
model UserAssignedIdentity {
  /**
   * The principal id of user assigned identity.
   */
  @visibility(Lifecycle.Read)
  principalId?: string;

  /**
   * The client id of user assigned identity.
   */
  @visibility(Lifecycle.Read)
  clientId?: string;
}
