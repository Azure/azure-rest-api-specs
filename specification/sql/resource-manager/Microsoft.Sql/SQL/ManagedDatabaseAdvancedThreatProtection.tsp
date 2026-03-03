import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ManagedDatabase.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A managed database Advanced Threat Protection.
 */
@parentResource(ManagedDatabase)
model ManagedDatabaseAdvancedThreatProtection
  is Azure.ResourceManager.ProxyResource<AdvancedThreatProtectionProperties> {
  ...ResourceNameParameter<
    Resource = ManagedDatabaseAdvancedThreatProtection,
    KeyName = "advancedThreatProtectionName",
    SegmentName = "advancedThreatProtectionSettings",
    NamePattern = "",
    Type = AdvancedThreatProtectionName
  >;
}

@armResourceOperations
interface ManagedDatabaseAdvancedThreatProtections {
  /**
   * Gets a managed database's Advanced Threat Protection state.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedDatabaseAdvancedThreatProtectionSettings_Get")
  get is ArmResourceRead<ManagedDatabaseAdvancedThreatProtection>;

  /**
   * Creates or updates a managed database's Advanced Threat Protection state.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedDatabaseAdvancedThreatProtectionSettings_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ManagedDatabaseAdvancedThreatProtection>;

  /**
   * Gets a list of managed database's Advanced Threat Protection states.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ManagedDatabaseAdvancedThreatProtectionSettings_ListByDatabase")
  listByDatabase is ArmResourceListByParent<ManagedDatabaseAdvancedThreatProtection>;
}

@@doc(ManagedDatabaseAdvancedThreatProtection.name,
  "The name of the Advanced Threat Protection state."
);
@@doc(ManagedDatabaseAdvancedThreatProtection.properties,
  "Resource properties."
);
@@doc(ManagedDatabaseAdvancedThreatProtections.createOrUpdate::parameters.resource,
  "The managed database Advanced Threat Protection state."
);
