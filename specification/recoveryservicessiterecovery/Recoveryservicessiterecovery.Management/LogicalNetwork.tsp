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
 * Logical network data model.
 */
@parentResource(Fabric)
model LogicalNetwork
  is Azure.ResourceManager.ProxyResource<LogicalNetworkProperties> {
  ...ResourceNameParameter<
    Resource = LogicalNetwork,
    KeyName = "logicalNetworkName",
    SegmentName = "replicationLogicalNetworks",
    NamePattern = ""
  >;
}

@armResourceOperations
interface LogicalNetworks {
  /**
   * Gets the details of a logical network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationLogicalNetworks_Get")
  get is ArmResourceRead<LogicalNetwork>;

  /**
   * Lists all the logical networks of the Azure Site Recovery fabric.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationLogicalNetworks_ListByReplicationFabrics")
  listByReplicationFabrics is ArmResourceListByParent<
    LogicalNetwork,
    Response = ArmResponse<LogicalNetworkCollection>
  >;
}

@@doc(LogicalNetwork.name, "Logical network name.");
@@doc(LogicalNetwork.properties, "The Logical Network Properties.");
