import "@azure-tools/typespec-azure-resource-manager";
import "../../models/exadata/dbServers.tsp";

using Azure.ResourceManager;
using Autorest;
using TypeSpec.Versioning;

namespace Oracle.Database;

@armResourceOperations
interface DbServers extends OracleReadOnlyResource<DbServer> {
  listByParent is ArmResourceListByParent<DbServer>;
}
