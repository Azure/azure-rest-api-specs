import "@azure-tools/typespec-azure-resource-manager";
import "../../../models/exadata/dbServers.tsp";

using Azure.ResourceManager;
using Autorest;
using TypeSpec.Versioning;

namespace Oracle.Database;

@armResourceOperations
interface DbServers extends OracleReadOnlyResource<DbServer> {
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
  @Autorest.example(
    "./examples/dbServers_listByParent.json",
    "List DbServers by Exadata Infrastructure"
  )
  listByCloudExadataInfrastructure is ArmResourceListByParent<DbServer>;
}

#suppress "@azure-tools/typespec-azure-core/no-openapi" "TODO FIX - DO NOT COPY - BAD PATTERN"
@@Autorest.example(DbServers.get,
  "./examples/dbServers_get.json",
  "Get DbServer by parent"
);
