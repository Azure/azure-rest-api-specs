import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Database.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Sql;
/**
 * A database Advanced Threat Protection.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Database)
@includeInapplicableMetadataInPayload(false)
model DatabaseAdvancedThreatProtection extends ProxyResource {
  /**
   * The name of the Advanced Threat Protection state.
   */
  @path
  @key("advancedThreatProtectionName")
  @segment("advancedThreatProtectionSettings")
  @visibility("read")
  name: AdvancedThreatProtectionName;

  /**
   * SystemData of AdvancedThreatProtectionResource.
   */
  @visibility("read")
  systemData?: SystemData;

  /**
   * Resource properties.
   */
  @extension("x-ms-client-flatten", true)
  properties?: AdvancedThreatProtectionProperties;
}

@armResourceOperations
interface DatabaseAdvancedThreatProtections {
  /**
   * Gets a database's Advanced Threat Protection state.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DatabaseAdvancedThreatProtectionSettings_Get")
  get is ArmResourceRead<DatabaseAdvancedThreatProtection>;

  /**
   * Creates or updates a database's Advanced Threat Protection state.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DatabaseAdvancedThreatProtectionSettings_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<DatabaseAdvancedThreatProtection>;

  /**
   * Gets a list of database's Advanced Threat Protection states.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("DatabaseAdvancedThreatProtectionSettings_ListByDatabase")
  listByDatabase is ArmResourceListByParent<DatabaseAdvancedThreatProtection>;
}

@@projectedName(DatabaseAdvancedThreatProtections.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(DatabaseAdvancedThreatProtections.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(DatabaseAdvancedThreatProtections.createOrUpdate::parameters.resource,
  "The database Advanced Threat Protection state."
);
