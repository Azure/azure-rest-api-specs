import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedDatabase.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
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
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a managed database's Advanced Threat Protection state.")
  @operationId("ManagedDatabaseAdvancedThreatProtectionSettings_Get")
  get is ArmResourceRead<ManagedDatabaseAdvancedThreatProtection>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates or updates a managed database's Advanced Threat Protection state.")
  @operationId("ManagedDatabaseAdvancedThreatProtectionSettings_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ManagedDatabaseAdvancedThreatProtection>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a list of managed database's Advanced Threat Protection states.")
  @operationId("ManagedDatabaseAdvancedThreatProtectionSettings_ListByDatabase")
  listByDatabase is ArmResourceListByParent<ManagedDatabaseAdvancedThreatProtection>;
}

@@projectedName(ManagedDatabaseAdvancedThreatProtections.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(ManagedDatabaseAdvancedThreatProtections.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(ManagedDatabaseAdvancedThreatProtections.createOrUpdate::parameters.resource,
  "The managed database Advanced Threat Protection state."
);
