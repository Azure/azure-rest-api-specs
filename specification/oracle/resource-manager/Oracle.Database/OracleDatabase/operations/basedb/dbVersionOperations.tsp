import "@azure-tools/typespec-azure-resource-manager";
import "../../models/basedb/dbVersion.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Oracle.Database;

#suppress "@azure-tools/typespec-client-generator-core/csharp-use-standard-acronyms" "Name kept for backward compatibility"
@added(Versions.v20250701_preview)
@armResourceOperations
interface DbVersions extends OracleLocationBasedResource<DbVersion> {
  listByLocation is ArmResourceListByParent<
    DbVersion,
    Parameters = DbVersionFilter
  >;
}
