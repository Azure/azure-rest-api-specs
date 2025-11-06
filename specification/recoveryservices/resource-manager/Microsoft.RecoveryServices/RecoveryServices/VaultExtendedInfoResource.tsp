import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Vault.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;
/**
 * Vault extended information.
 */
@singleton("vaultExtendedInfo")
@parentResource(Vault)
model VaultExtendedInfoResource
  is Azure.ResourceManager.ProxyResource<VaultExtendedInfo> {
  ...ResourceNameParameter<
    Resource = VaultExtendedInfoResource,
    KeyName = "extendedInformation",
    SegmentName = "extendedInformation",
    NamePattern = ""
  >;

  /**
   * etag for the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  etag?: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface VaultExtendedInfoResources {
  /**
   * Get the vault extended info.
   */
  get is ArmResourceRead<VaultExtendedInfoResource, Error = CloudError>;

  /**
   * Create vault extended info.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    VaultExtendedInfoResource,
    Response = ArmResourceUpdatedResponse<VaultExtendedInfoResource>,
    Error = CloudError
  >;

  /**
   * Update vault extended info.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    VaultExtendedInfoResource,
    PatchModel = VaultExtendedInfoResource,
    Error = CloudError
  >;
}

@@doc(VaultExtendedInfoResource.name, "");
@@doc(VaultExtendedInfoResource.properties, "Vault extended information.");
@@doc(VaultExtendedInfoResources.createOrUpdate::parameters.resource,
  "Details of ResourceExtendedInfo"
);
@@doc(VaultExtendedInfoResources.update::parameters.properties,
  "Details of ResourceExtendedInfo"
);
