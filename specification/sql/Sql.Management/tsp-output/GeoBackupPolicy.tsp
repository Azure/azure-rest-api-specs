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
 * A database geo backup policy.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(Database)
@includeInapplicableMetadataInPayload(false)
model GeoBackupPolicy extends ProxyResource {
  /**
   * The name of the geo backup policy.
   */
  @path
  @key("geoBackupPolicyName")
  @segment("geoBackupPolicies")
  @visibility("read")
  name: GeoBackupPolicyName;

  /**
   * Kind of geo backup policy.  This is metadata used for the Azure portal experience.
   */
  @visibility("read")
  kind?: string;

  /**
   * Backup policy location.
   */
  @visibility("read")
  location?: string;

  /**
   * The properties of the geo backup policy.
   */
  @extension("x-ms-client-flatten", true)
  properties: GeoBackupPolicyProperties;
}

@armResourceOperations
interface GeoBackupPolicies {
  /**
   * Gets a geo backup policy.
   */
  get is ArmResourceRead<GeoBackupPolicy>;

  /**
   * Updates a database geo backup policy.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<GeoBackupPolicy>;

  /**
   * Returns a list of geo backup policies.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("GeoBackupPolicies_ListByDatabase")
  listByDatabase is ArmResourceListByParent<GeoBackupPolicy>;
}

@@projectedName(GeoBackupPolicies.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(GeoBackupPolicies.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(GeoBackupPolicies.createOrUpdate::parameters.resource,
  "The required parameters for creating or updating the geo backup policy."
);
