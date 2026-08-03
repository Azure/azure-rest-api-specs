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
 * A restorable dropped managed database resource.
 */
@parentResource(ManagedInstance)
model RestorableDroppedManagedDatabase
  is TrackedResource<RestorableDroppedManagedDatabaseProperties> {
  @path
  @key("restorableDroppedDatabaseId")
  @segment("restorableDroppedDatabases")
  name: string;
}

@armResourceOperations
interface RestorableDroppedManagedDatabases {
  /**
   * Gets a restorable dropped managed database.
   */
  get is ArmResourceRead<RestorableDroppedManagedDatabase>;

  /**
   * Gets a list of restorable dropped managed databases.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("RestorableDroppedManagedDatabases_ListByInstance")
  listByInstance is ArmResourceListByParent<RestorableDroppedManagedDatabase>;
}
