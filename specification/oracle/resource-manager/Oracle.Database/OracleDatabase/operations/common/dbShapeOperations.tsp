import "@azure-tools/typespec-azure-resource-manager";
import "../../models/common/dbShape.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Oracle.Database;

@added(Versions.v20260401_preview)
@armResourceOperations
interface DatabaseSystemShapeResources
  extends OracleLocationBasedResource<DatabaseSystemShape> {
  @sharedRoute
  listByLocation is ArmResourceListByParent<
    DatabaseSystemShape,
    Parameters = DatabaseSystemShapeFilter
  >;
}
