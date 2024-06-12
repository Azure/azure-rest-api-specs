import "@azure-tools/typespec-azure-resource-manager";
import "../../../models/exadata/dbNodes.tsp";

using Azure.ResourceManager;
using Autorest;
using TypeSpec.Versioning;

namespace Oracle.Database;

@armResourceOperations
interface DbNodes extends OracleReadOnlyResource<DbNode> {
  // TODO: Swagger generator bug, cannot be extracted to interface
  @example("./examples/dbNodes_listByParent.json", "List DbNodes by VM Cluster")
  listByParent is ArmResourceListByParent<DbNode>;

  @doc("VM actions on DbNode of VM Cluster by the provided filter")
  @example(
    "./examples/dbNodes_action.json",
    "VM actions on DbNodes of VM Cluster"
  )
  action is ArmResourceActionAsync<DbNode, DbNodeAction, DbNode>;
}

@@example(DbNodes.get, "./examples/dbNodes_get.json", "Get DbNode");
