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
 * A recoverable managed database resource.
 */
@parentResource(ManagedInstance)
model RecoverableManagedDatabase
  is Azure.ResourceManager.ProxyResource<RecoverableManagedDatabaseProperties> {
  ...ResourceNameParameter<
    Resource = RecoverableManagedDatabase,
    KeyName = "recoverableDatabaseName",
    SegmentName = "recoverableDatabases",
    NamePattern = ""
  >;
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
  listByInstance is ArmResourceListByParent<RecoverableManagedDatabase>;
}

@@doc(RecoverableManagedDatabase.name, "");
@@doc(RecoverableManagedDatabase.properties, "Resource properties.");
