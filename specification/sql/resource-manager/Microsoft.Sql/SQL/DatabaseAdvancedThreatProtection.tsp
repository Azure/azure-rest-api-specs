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

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations(#{ omitTags: true })
interface DatabaseAdvancedThreatProtections {
  /**
   * Gets a database's Advanced Threat Protection state.
   */
  @tag("DatabaseAdvancedThreatProtectionSettings")
  get is ArmResourceRead<DatabaseAdvancedThreatProtection>;

  /**
   * Creates or updates a database's Advanced Threat Protection state.
   */
  @tag("DatabaseAdvancedThreatProtectionSettings")
  createOrUpdate is ArmResourceCreateOrReplaceSync<DatabaseAdvancedThreatProtection>;

  /**
   * Gets a list of database's Advanced Threat Protection states.
   */
  @tag("DatabaseAdvancedThreatProtectionSettings")
  listByDatabase is ArmResourceListByParent<DatabaseAdvancedThreatProtection>;
}

@@doc(DatabaseAdvancedThreatProtection.name,
  "The name of the Advanced Threat Protection state."
);
@@doc(DatabaseAdvancedThreatProtection.properties, "Resource properties.");
@@doc(DatabaseAdvancedThreatProtections.createOrUpdate::parameters.resource,
  "The database Advanced Threat Protection state."
);
