import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedInstance.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A restorable dropped managed database resource.
 */
@parentResource(ManagedInstance)
model RestorableDroppedManagedDatabase
  is Azure.ResourceManager.TrackedResource<RestorableDroppedManagedDatabaseProperties> {
  ...ResourceNameParameter<
    Resource = RestorableDroppedManagedDatabase,
    KeyName = "restorableDroppedDatabaseId",
    SegmentName = "restorableDroppedDatabases",
    NamePattern = ""
  >;
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
  listByInstance is ArmResourceListByParent<RestorableDroppedManagedDatabase>;
}

@@doc(RestorableDroppedManagedDatabase.name, "");
@@doc(RestorableDroppedManagedDatabase.properties, "Resource properties.");
