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
 * A Geo backup policy.
 */
@parentResource(Database)
model GeoBackupPolicy
  is Azure.ResourceManager.ProxyResource<GeoBackupPolicyProperties> {
  ...ResourceNameParameter<
    Resource = GeoBackupPolicy,
    KeyName = "geoBackupPolicyName",
    SegmentName = "geoBackupPolicies",
    NamePattern = "",
    Type = GeoBackupPolicyName
  >;

  /**
   * Backup policy location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  location?: string;

  /**
   * Kind of geo backup policy.  This is metadata used for the Azure portal experience.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  kind?: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface GeoBackupPolicies {
  /**
   * Gets a Geo backup policy for the given database resource.
   */
  get is ArmResourceRead<GeoBackupPolicy>;

  /**
   * Create or update a database default Geo backup policy.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<GeoBackupPolicy>;

  /**
   * Gets a list of Geo backup policies for the given database resource.
   */
  list is ArmResourceListByParent<GeoBackupPolicy>;
}

@@doc(GeoBackupPolicy.name,
  "The name of the Geo backup policy. This should always be 'Default'."
);
@@doc(GeoBackupPolicy.properties, "Resource properties.");
@@doc(GeoBackupPolicies.createOrUpdate::parameters.resource,
  "The required parameters for creating or updating the geo backup policy."
);
