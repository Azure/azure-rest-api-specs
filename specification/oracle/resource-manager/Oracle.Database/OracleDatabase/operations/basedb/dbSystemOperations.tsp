import "@azure-tools/typespec-azure-resource-manager";
import "../../models/basedb/dbSystem.tsp";

using Azure.ResourceManager;
using Autorest;
using TypeSpec.Versioning;
namespace Oracle.Database;

#suppress "@azure-tools/typespec-client-generator-core/csharp-use-standard-acronyms" "Name kept for backward compatibility"
@added(Versions.v20250701_preview)
@armResourceOperations(DbSystem)
interface DbSystems
  extends OracleTrackedResource<DbSystem, DbSystemProperties> {}
