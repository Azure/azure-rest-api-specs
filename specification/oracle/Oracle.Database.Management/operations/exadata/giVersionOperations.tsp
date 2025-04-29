import "../../models/exadata/giVersions.tsp";

using Azure.ResourceManager;
using Autorest;
using TypeSpec.Http;
using TypeSpec.Versioning;

namespace Oracle.Database;

@armResourceOperations
interface GiVersions extends OracleLocationBasedResource<GiVersion> {
  #suppress "Deprecated" "Backward compatibility"
  @removed(Versions.v20241201_preview)
  @sharedRoute
  @renamedFrom(Versions.v20241201_preview, "listByLocation")
  listByLocationDeprecated is ArmResourceListByParent<GiVersion>;

  @added(Versions.v20241201_preview)
  @sharedRoute
  listByLocation is ArmResourceListByParent<
    GiVersion,
    Parameters = GiVersionFilter
  >;
}

#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(GiVersions.listByLocationDeprecated,
  "./examples/giVersions_listByLocation.json",
  "List GiVersions by location"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(GiVersions.get,
  "./examples/giVersions_get.json",
  "Get a GiVersion by name"
);
