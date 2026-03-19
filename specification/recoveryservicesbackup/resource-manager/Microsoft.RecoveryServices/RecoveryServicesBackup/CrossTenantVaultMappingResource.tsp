import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Legacy;
using TypeSpec.Versioning;

namespace Microsoft.RecoveryServices;

/**
 * Cross tenant vault mapping resource.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy TrackedResourceWithOptionalLocation for back compatibility"
@added(Versions.v2026_03_01_preview)
@parentResource(VaultResource)
model CrossTenantVaultMappingResource
  is TrackedResourceWithOptionalLocation<CrossTenantVaultMapping> {
  ...ResourceNameParameter<
    Resource = CrossTenantVaultMappingResource,
    KeyName = "crossTenantVaultMappingName",
    SegmentName = "crossTenantVaultMappings",
    NamePattern = ""
  >;

  /**
   * Optional ETag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  eTag?: string;
}

@armResourceOperations
interface CrossTenantVaultMappingOperations {
  /**
   * Gets the cross tenant vault mapping.
   */
  @added(Versions.v2026_03_01_preview)
  get is ArmResourceRead<CrossTenantVaultMappingResource>;

  /**
   * Creates or updates the cross tenant vault mapping.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @added(Versions.v2026_03_01_preview)
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    CrossTenantVaultMappingResource,
    Response = ArmResourceUpdatedResponse<CrossTenantVaultMappingResource>
  >;

  /**
   * Deletes the cross tenant vault mapping.
   */
  @added(Versions.v2026_03_01_preview)
  delete is ArmResourceDeleteSync<CrossTenantVaultMappingResource>;
}

@armResourceOperations
interface CrossTenantVaultMappings {
  /**
   * Lists the cross tenant vault mappings under vault.
   */
  @added(Versions.v2026_03_01_preview)
  @list
  list is ArmResourceListByParent<
    CrossTenantVaultMappingResource,
    Response = ArmResponse<CrossTenantVaultMappingResourceList>
  >;
}
