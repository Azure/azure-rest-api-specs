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
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(ManagedInstance)
@Azure.ResourceManager.Legacy.feature(Features.RecoverableManagedDatabases)
model RecoverableManagedDatabase
  is Azure.ResourceManager.ProxyResource<RecoverableManagedDatabaseProperties> {
  ...ResourceNameParameter<
    Resource = RecoverableManagedDatabase,
    KeyName = "recoverableDatabaseName",
    SegmentName = "recoverableDatabases",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
@Azure.ResourceManager.Legacy.feature(Features.RecoverableManagedDatabases)
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
