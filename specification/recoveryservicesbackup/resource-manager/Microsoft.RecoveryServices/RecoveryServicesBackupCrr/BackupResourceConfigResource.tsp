import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;
/**
 * The resource storage details.
 */
@parentResource(VaultResource)
@singleton("vaultstorageconfig")
model BackupResourceConfigResource is ProxyResource<BackupResourceConfig> {
  ...ResourceNameParameter<
    Resource = BackupResourceConfigResource,
    KeyName = "backupstorageconfig",
    SegmentName = "backupstorageconfig",
    NamePattern = ""
  >;

  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  /** The geo-location where the resource lives */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Optional location"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: Azure.Core.azureLocation;

  /**
   * Optional ETag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  eTag?: string;
}

@armResourceOperations
interface BackupResourceConfigResources {
  /**
   * Fetches resource storage config.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BackupResourceStorageConfigs_Get")
  get is ArmResourceRead<BackupResourceConfigResource>;

  /**
   * Updates vault storage model type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("BackupResourceStorageConfigs_Update")
  update is ArmResourceCreateOrReplaceSync<
    BackupResourceConfigResource,
    Response = ArmResourceUpdatedResponse<BackupResourceConfigResource>
  >;

  /**
   * Updates vault storage model type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BackupResourceStorageConfigs_patch")
  @patch(#{ implicitOptionality: false })
  patch is ArmCustomPatchSync<
    BackupResourceConfigResource,
    PatchModel = BackupResourceConfigResource,
    Response = ArmNoContentResponse
  >;
}

@@doc(BackupResourceConfigResource.name, "");
@@doc(
  BackupResourceConfigResource.properties,
  "BackupResourceConfigResource properties"
);
@@doc(
  BackupResourceConfigResources.update::parameters.resource,
  "Vault storage config request"
);
@@doc(
  BackupResourceConfigResources.patch::parameters.properties,
  "Vault storage config request"
);
