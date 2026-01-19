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

#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(DbSystemShapes.listByLocationDeprecated,
  "./examples/dbSystemShapes_listByLocation.json",
  "List DbSystemShapes by location"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(DbSystemShapes.listByLocation,
  "./examples/dbSystemShapes_listByLocation.json",
  "List DbSystemShapes by location"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(DbSystemShapes.get,
  "./examples/dbSystemShapes_get.json",
  "Get a DbSystemShape by name"
);
