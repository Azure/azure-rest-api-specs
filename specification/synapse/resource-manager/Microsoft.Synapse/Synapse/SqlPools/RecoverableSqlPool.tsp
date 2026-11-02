import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace SqlPools;
/**
 * A recoverable sql pool
 */
model RecoverableSqlPool
  is Azure.ResourceManager.ProxyResource<RecoverableSqlPoolProperties> {
  ...ResourceNameParameter<
    Resource = RecoverableSqlPool,
    KeyName = "sqlPoolName",
    SegmentName = "recoverableSqlPools",
    NamePattern = ""
  >;
}

alias RecoverableSqlPoolOps = Azure.ResourceManager.Legacy.LegacyOperations<
  WorkspaceParentParameters,
  {
    /** SQL pool name */
    @segment("recoverableSqlPools")
    @key
    @path
    sqlPoolName: string;
  }
>;

@armResourceOperations
interface RecoverableSqlPools {
  /**
   * Get recoverable sql pools for workspace managed sql server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkspaceManagedSqlServerRecoverableSqlPools_Get")
  get is RecoverableSqlPoolOps.Read<RecoverableSqlPool>;

  /**
   * Get list of recoverable sql pools for workspace managed sql server.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("WorkspaceManagedSqlServerRecoverableSqlPools_List")
  list is RecoverableSqlPoolOps.List<RecoverableSqlPool>;
}

@@doc(RecoverableSqlPool.name, "The name of the sql pool");
@@doc(
  RecoverableSqlPool.properties,
  "The properties of a recoverable sql pool"
);
