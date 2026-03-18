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

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations(#{ omitTags: true })
interface ManagedDatabaseAdvancedThreatProtections {
  /**
   * Gets a managed database's Advanced Threat Protection state.
   */
  @tag("ManagedDatabaseAdvancedThreatProtectionSettings")
  get is ArmResourceRead<ManagedDatabaseAdvancedThreatProtection>;

  /**
   * Creates or updates a managed database's Advanced Threat Protection state.
   */
  @tag("ManagedDatabaseAdvancedThreatProtectionSettings")
  createOrUpdate is ArmResourceCreateOrReplaceSync<ManagedDatabaseAdvancedThreatProtection>;

  /**
   * Gets a list of managed database's Advanced Threat Protection states.
   */
  @tag("ManagedDatabaseAdvancedThreatProtectionSettings")
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
