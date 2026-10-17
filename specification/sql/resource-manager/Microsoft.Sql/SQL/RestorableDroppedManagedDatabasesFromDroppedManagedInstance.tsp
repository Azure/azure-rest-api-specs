import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "@typespec/versioning";
import "./RestorableDroppedManagedDatabase.tsp";
import "./RestorableDroppedManagedInstancesByLocation.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.Sql;

alias RestorableDroppedManagedDatabaseFromDroppedManagedInstanceIdParameter = {
  /**
   * The restorable dropped database identifier, in the format 'databaseName,lastRestorablePoint',
   * where lastRestorablePoint is a Windows FILETIME value.
   */
  @path
  @segment("restorableDroppedManagedDatabases")
  @key
  restorableDroppedDatabaseId: string;
};

alias RestorableDroppedManagedDatabaseFromDroppedManagedInstanceOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...RestorableDroppedManagedInstanceLocationParameters;
    ...RestorableDroppedManagedInstanceIdParameter;
  },
  RestorableDroppedManagedDatabaseFromDroppedManagedInstanceIdParameter,
  ResourceName = "RestorableDroppedManagedDatabase"
>;

/**
 * Discovers restorable databases under a dropped managed instance.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Feature metadata is required to emit this operation group as a separate Swagger file."
@added(Versions.v2026_11_01_preview)
@armResourceOperations
@Azure.ResourceManager.Legacy.feature(
  Features.RestorableDroppedManagedDatabasesFromDroppedManagedInstance
)
interface RestorableDroppedManagedDatabasesFromDroppedManagedInstance {
  /** Gets a restorable database under a dropped managed instance. */
  get is RestorableDroppedManagedDatabaseFromDroppedManagedInstanceOps.Read<RestorableDroppedManagedDatabase>;

  /** Gets restorable databases under a dropped managed instance. */
  listByDroppedManagedInstance is RestorableDroppedManagedDatabaseFromDroppedManagedInstanceOps.List<RestorableDroppedManagedDatabase>;
}
