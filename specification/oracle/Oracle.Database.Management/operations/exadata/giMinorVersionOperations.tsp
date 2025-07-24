import "../../models/exadata/giMinorVersions.tsp";

using Azure.ResourceManager;
using Autorest;
using TypeSpec.Versioning;

namespace Oracle.Database;

@added(Versions.v20241201_preview)
@armResourceOperations
interface GiMinorVersions {
  listByParent is ArmResourceListByParent<
    GiMinorVersion,
    Parameters = GiMinorVersionFilter
  >;
  get is ArmResourceRead<GiMinorVersion>;
}
