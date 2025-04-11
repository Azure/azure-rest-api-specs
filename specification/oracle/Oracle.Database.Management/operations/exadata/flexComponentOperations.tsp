import "../../models/exadata/flexComponents.tsp";

using TypeSpec.Versioning;
using Azure.ResourceManager;
using Autorest;

namespace Oracle.Database;

@added(Versions.v20250101_preview)
@armResourceOperations
interface FlexComponents {
  get is ArmResourceRead<FlexComponent>;
  listByParent is ArmResourceListByParent<
    FlexComponent,
    Parameters = FlexComponentsFilter
  >;
}
