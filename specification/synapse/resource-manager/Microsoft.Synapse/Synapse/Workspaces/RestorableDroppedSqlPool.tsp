import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Synapse;
/**
 * A restorable dropped Sql pool
 */
@parentResource(Workspace)
model RestorableDroppedSqlPool
  is Azure.ResourceManager.ProxyResource<RestorableDroppedSqlPoolProperties> {
  ...ResourceNameParameter<
    Resource = RestorableDroppedSqlPool,
    KeyName = "restorableDroppedSqlPoolId",
    SegmentName = "restorableDroppedSqlPools",
    NamePattern = ""
  >;

  /**
   * The geo-location where the resource lives
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  location?: string;
}

@armResourceOperations
interface RestorableDroppedSqlPools {
  /**
   * Gets a deleted sql pool that can be restored
   */
  get is ArmResourceRead<RestorableDroppedSqlPool>;

  /**
   * Gets a list of deleted Sql pools that can be restored
   */
  listByWorkspace is ArmResourceListByParent<
    RestorableDroppedSqlPool,
    Response = ArmResponse<RestorableDroppedSqlPoolListResult>
  >;
}

@@doc(
  RestorableDroppedSqlPool.name,
  "The id of the deleted Sql Pool in the form of sqlPoolName,deletionTimeInFileTimeFormat"
);
@@doc(
  RestorableDroppedSqlPool.properties,
  "The properties of a restorable dropped Sql pool"
);
