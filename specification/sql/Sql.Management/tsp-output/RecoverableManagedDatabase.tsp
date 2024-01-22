import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A recoverable managed database resource.
 */
@parentResource(ManagedInstance)
model RecoverableManagedDatabase
  is ProxyResource<RecoverableManagedDatabaseProperties> {
  @path
  @key("recoverableDatabaseName")
  @segment("recoverableDatabases")
  name: string;
}

@armResourceOperations
interface RecoverableManagedDatabases {
  /**
   * Gets a recoverable managed database.
   */
  get is ArmResourceRead<RecoverableManagedDatabase>;

  /**
   * Gets a list of recoverable managed databases.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("RecoverableManagedDatabases_ListByInstance")
  listByInstance is ArmResourceListByParent<RecoverableManagedDatabase>;
}
