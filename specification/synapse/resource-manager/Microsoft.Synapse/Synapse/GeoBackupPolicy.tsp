import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SqlPool.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Synapse;
/**
 * A database geo backup policy.
 */
@parentResource(SqlPool)
model GeoBackupPolicy is Azure.ResourceManager.ProxyResource<
  GeoBackupPolicyProperties,
  false
> {
  ...ResourceNameParameter<
    Resource = GeoBackupPolicy,
    KeyName = "geoBackupPolicyName",
    SegmentName = "geoBackupPolicies",
    NamePattern = "",
    Type = GeoBackupPolicyName
  >;

  /**
   * Kind of geo backup policy.  This is metadata used for the Azure portal experience.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  kind?: string;

  /**
   * Backup policy location.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  @visibility(Lifecycle.Read)
  location?: string;
}

@armResourceOperations
interface GeoBackupPolicies {
  /**
   * Get the specified SQL pool geo backup policy
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlPoolGeoBackupPolicies_Get")
  get is ArmResourceRead<GeoBackupPolicy>;

  /**
   * Updates a SQL Pool geo backup policy.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlPoolGeoBackupPolicies_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<GeoBackupPolicy>;

  /**
   * Get list of SQL pool geo backup policies
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SqlPoolGeoBackupPolicies_List")
  list is ArmResourceListByParent<
    GeoBackupPolicy,
    Response = ArmResponse<GeoBackupPolicyListResult>
  >;
}

@@doc(GeoBackupPolicy.name, "The name of the geo backup policy.");
@@doc(GeoBackupPolicy.properties, "The properties of the geo backup policy.");
@@doc(
  GeoBackupPolicies.createOrUpdate::parameters.resource,
  "The required parameters for creating or updating the geo backup policy."
);
