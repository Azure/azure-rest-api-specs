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
/**
 * A managed database Advanced Threat Protection.
 */
@parentResource(ManagedDatabase)
model ManagedDatabaseAdvancedThreatProtection
  is ProxyResource<AdvancedThreatProtectionProperties> {
  /**
   * The name of the Advanced Threat Protection state.
   */
  @path
  @key("advancedThreatProtectionName")
  @segment("advancedThreatProtectionSettings")
  name: AdvancedThreatProtectionName;
}

@armResourceOperations
interface ManagedDatabaseAdvancedThreatProtections {
  /**
   * Gets a managed database's Advanced Threat Protection state.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedDatabaseAdvancedThreatProtectionSettings_Get")
  get is ArmResourceRead<ManagedDatabaseAdvancedThreatProtection>;

  /**
   * Creates or updates a managed database's Advanced Threat Protection state.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ManagedDatabaseAdvancedThreatProtectionSettings_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ManagedDatabaseAdvancedThreatProtection>;

  /**
   * Gets a list of managed database's Advanced Threat Protection states.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
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
