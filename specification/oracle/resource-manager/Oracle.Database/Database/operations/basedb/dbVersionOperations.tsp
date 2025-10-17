import "@azure-tools/typespec-azure-resource-manager";
import "../../models/basedb/dbVersion.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Oracle.Database;

@added(Versions.v20250701_preview)
@armResourceOperations
interface DbVersions extends OracleLocationBasedResource<DbVersion> {
  listByLocation is ArmResourceListByParent<
    DbVersion,
    Parameters = DbVersionFilter
  >;
}
