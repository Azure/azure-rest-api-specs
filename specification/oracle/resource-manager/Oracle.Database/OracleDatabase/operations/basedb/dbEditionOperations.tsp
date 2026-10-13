import "@azure-tools/typespec-azure-resource-manager";
import "../../models/basedb/dbEdition.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Oracle.Database;

@added(Versions.v20260401_preview)
@armResourceOperations
interface DatabaseEditions
  extends OracleLocationBasedResource<DatabaseEdition> {
  listByLocation is ArmResourceListByParent<DatabaseEdition>;
}
