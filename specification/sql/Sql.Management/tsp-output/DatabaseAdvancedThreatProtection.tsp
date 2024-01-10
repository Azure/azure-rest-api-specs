import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Sql;
@doc("A database Advanced Threat Protection.")
@parentResource(Database)
model DatabaseAdvancedThreatProtection
  is ProxyResource<AdvancedThreatProtectionProperties> {
  @doc("The name of the Advanced Threat Protection state.")
  @key("advancedThreatProtectionName")
  @segment("advancedThreatProtectionSettings")
  name: AdvancedThreatProtectionName;
}

@armResourceOperations
@projectedName("client", "DatabaseAdvancedThreatProtectionSettings")
interface DatabaseAdvancedThreatProtections_DatabaseAdvancedThreatProtectionSettings {
  @doc("Gets a database's Advanced Threat Protection state.")
  get is ArmResourceRead<DatabaseAdvancedThreatProtection>;

  @doc("Creates or updates a database's Advanced Threat Protection state.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<DatabaseAdvancedThreatProtection>;

  @doc("Gets a list of database's Advanced Threat Protection states.")
  listByDatabase is ArmResourceListByParent<DatabaseAdvancedThreatProtection>;
}
