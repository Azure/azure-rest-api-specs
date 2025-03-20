import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * Database restore points.
 */
@parentResource(Database)
model RestorePoint is ProxyResource<RestorePointProperties> {
  /**
   * The name of the restore point.
   */
  @path
  @key("restorePointName")
  @segment("restorePoints")
  name: string;
}

@armResourceOperations
interface RestorePoints {
  /**
   * Gets a restore point.
   */
  get is ArmResourceRead<RestorePoint>;

  /**
   * Deletes a restore point.
   */
  delete is ArmResourceDeleteSync<RestorePoint>;

  /**
   * Gets a list of database restore points.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("RestorePoints_ListByDatabase")
  listByDatabase is ArmResourceListByParent<RestorePoint>;
}
