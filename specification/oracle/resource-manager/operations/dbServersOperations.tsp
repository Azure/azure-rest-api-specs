import "@azure-tools/typespec-azure-resource-manager";
import "../models/dbServers.tsp";

using Azure.ResourceManager;
using Autorest;
using TypeSpec.Versioning;

namespace Oracle.Database;

@armResourceOperations
interface DbServers extends OracleReadOnlyResource<DbServer> {
  // TODO: Swagger generator bug, cannot be extracted to interface
  @example("./examples/dbServers_listByParent.json", "List DbServers by Exadata Infrastructure")
}

@@example(DbServers.get, "./examples/dbServers_get.json", "Get DbServer by parent");
