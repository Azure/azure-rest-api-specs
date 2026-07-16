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
 * A recoverable sql pool
 */
@parentResource(Workspace)
model RecoverableSqlPool
  is Azure.ResourceManager.ProxyResource<RecoverableSqlPoolProperties> {
  ...ResourceNameParameter<
    Resource = RecoverableSqlPool,
    KeyName = "sqlPoolName",
    SegmentName = "recoverableSqlPools",
    NamePattern = ""
  >;
}

@armResourceOperations
interface RecoverableSqlPools {
  /**
   * Get recoverable sql pools for workspace managed sql server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkspaceManagedSqlServerRecoverableSqlPools_Get")
  get is ArmResourceRead<RecoverableSqlPool>;

  /**
   * Get list of recoverable sql pools for workspace managed sql server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkspaceManagedSqlServerRecoverableSqlPools_List")
  list is ArmResourceListByParent<RecoverableSqlPool>;
}

@@doc(RecoverableSqlPool.name, "The name of the sql pool");
@@doc(
  RecoverableSqlPool.properties,
  "The properties of a recoverable sql pool"
);
