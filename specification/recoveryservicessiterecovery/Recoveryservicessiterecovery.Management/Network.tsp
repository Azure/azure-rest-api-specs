import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Fabric.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;
/**
 * Network model.
 */
@parentResource(Fabric)
model Network is Azure.ResourceManager.ProxyResource<NetworkProperties> {
  ...ResourceNameParameter<
    Resource = Network,
    KeyName = "networkName",
    SegmentName = "replicationNetworks",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Networks {
  /**
   * Gets the details of a network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationNetworks_Get")
  get is ArmResourceRead<Network>;

  /**
   * Lists the networks available for a fabric.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationNetworks_ListByReplicationFabrics")
  listByReplicationFabrics is ArmResourceListByParent<
    Network,
    Response = ArmResponse<NetworkCollection>
  >;
}

@@doc(Network.name, "Primary network name.");
@@doc(Network.properties, "The Network Properties.");
