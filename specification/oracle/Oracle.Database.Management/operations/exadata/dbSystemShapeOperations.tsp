import "../../models/exadata/dbSystemShapes.tsp";

using Azure.ResourceManager;
using Autorest;
using TypeSpec.Versioning;
using TypeSpec.Http;

namespace Oracle.Database;

@armResourceOperations
interface DbSystemShapes extends OracleLocationBasedResource<DbSystemShape> {
  #suppress "Deprecated" "Backward compatibility"
  @removed(Versions.v20241201_preview)
  @sharedRoute
  @renamedFrom(Versions.v20241201_preview, "listByLocation")
  listByLocationDeprecated is ArmResourceListByParent<DbSystemShape>;

  @added(Versions.v20241201_preview)
  @sharedRoute
  listByLocation is ArmResourceListByParent<
    DbSystemShape,
    Parameters = DbSystemShapeFilter
  >;
}
