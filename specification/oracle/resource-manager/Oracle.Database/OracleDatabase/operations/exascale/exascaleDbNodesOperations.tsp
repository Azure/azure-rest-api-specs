import "@azure-tools/typespec-azure-resource-manager";
import "../../models/exascale/exascaleDbNode.tsp";

using Azure.ResourceManager;
using TypeSpec.Versioning;
using Autorest;

namespace Oracle.Database;

#suppress "@azure-tools/typespec-client-generator-core/csharp-use-standard-acronyms" "Name kept for backward compatibility"
@added(Versions.v20241201_preview)
@armResourceOperations
interface ExascaleDbNodes extends OracleReadOnlyResource<ExascaleDbNode> {
  listByParent is ArmResourceListByParent<ExascaleDbNode>;

  @doc("VM actions on DbNode of ExadbVmCluster by the provided filter")
  action is ArmResourceActionAsync<
    ExascaleDbNode,
    DbNodeAction,
    DbActionResponse
  >;
}
