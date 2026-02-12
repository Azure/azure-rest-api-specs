import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A database Advanced Threat Protection.
 */
@parentResource(Database)
model DatabaseAdvancedThreatProtection
  is Azure.ResourceManager.ProxyResource<AdvancedThreatProtectionProperties> {
  ...ResourceNameParameter<
    Resource = DatabaseAdvancedThreatProtection,
    KeyName = "advancedThreatProtectionName",
    SegmentName = "advancedThreatProtectionSettings",
    NamePattern = "",
    Type = AdvancedThreatProtectionName
  >;
}

@armResourceOperations
interface DatabaseAdvancedThreatProtections {
  /**
   * Gets a database's Advanced Threat Protection state.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DatabaseAdvancedThreatProtectionSettings_Get")
  get is ArmResourceRead<DatabaseAdvancedThreatProtection>;

  /**
   * Creates or updates a database's Advanced Threat Protection state.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DatabaseAdvancedThreatProtectionSettings_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<DatabaseAdvancedThreatProtection>;

  /**
   * Gets a list of database's Advanced Threat Protection states.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DatabaseAdvancedThreatProtectionSettings_ListByDatabase")
  listByDatabase is ArmResourceListByParent<DatabaseAdvancedThreatProtection>;
}

@@doc(DatabaseAdvancedThreatProtection.name,
  "The name of the Advanced Threat Protection state."
);
@@doc(DatabaseAdvancedThreatProtection.properties, "Resource properties.");
@@doc(DatabaseAdvancedThreatProtections.createOrUpdate::parameters.resource,
  "The database Advanced Threat Protection state."
);
