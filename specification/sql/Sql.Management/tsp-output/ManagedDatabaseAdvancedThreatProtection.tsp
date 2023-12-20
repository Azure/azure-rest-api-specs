import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedDatabase.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Sql;
@doc("A managed database Advanced Threat Protection.")
@parentResource(ManagedDatabase)
model ManagedDatabaseAdvancedThreatProtection
  is ProxyResource<AdvancedThreatProtectionProperties> {
  @doc("The name of the Advanced Threat Protection state.")
  @path
  @key("advancedThreatProtectionName")
  @segment("advancedThreatProtectionSettings")
  name: AdvancedThreatProtectionName;
}

@armResourceOperations
interface ManagedDatabaseAdvancedThreatProtections {
  @doc("Gets a managed database's Advanced Threat Protection state.")
  get is ArmResourceRead<ManagedDatabaseAdvancedThreatProtection>;
  @doc("Creates or updates a managed database's Advanced Threat Protection state.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ManagedDatabaseAdvancedThreatProtection>;
  @doc("Gets a list of managed database's Advanced Threat Protection states.")
  listByDatabase is ArmResourceListByParent<ManagedDatabaseAdvancedThreatProtection>;
}
