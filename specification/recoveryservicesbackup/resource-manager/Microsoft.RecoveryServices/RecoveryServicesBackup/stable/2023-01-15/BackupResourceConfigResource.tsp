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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "Backward compatibility for optional ETag"
  eTag?: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "Faithful migration: BackupResourceConfigResource is a read-only/singleton proxy resource; the original stable/2023-01-15 contract intentionally has no delete operation."
@tag("BackupResourceStorageConfigs")
@armResourceOperations(#{ omitTags: true })
interface BackupResourceStorageConfigs {
  /**
   * Fetches resource storage config.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @errorsDoc("Error response describing why the operation failed.")
  get is ArmResourceRead<
    BackupResourceConfigResource,
    Error = NewErrorResponse
  >;

  /**
   * Updates vault storage model type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @errorsDoc("Error response describing why the operation failed.")
  update is ArmResourceCreateOrReplaceSync<
    BackupResourceConfigResource,
    Response = ArmResourceUpdatedResponse<BackupResourceConfigResource>,
    Error = NewErrorResponse
  >;

  /**
   * Updates vault storage model type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @errorsDoc("Error response describing why the operation failed.")
  @operationId("BackupResourceStorageConfigs_patch")
  @patch(#{ implicitOptionality: false })
  patch is ArmCustomPatchSync<
    BackupResourceConfigResource,
    PatchModel = BackupResourceConfigResource,
    Response = ArmNoContentResponse,
    Error = NewErrorResponse
  >;
}

@@doc(BackupResourceConfigResource.name, "");
@@doc(
  BackupResourceConfigResource.properties,
  "BackupResourceConfigResource properties"
);
@@doc(
  BackupResourceStorageConfigs.update::parameters.resource,
  "Vault storage config request"
);
@@doc(
  BackupResourceStorageConfigs.patch::parameters.properties,
  "Vault storage config request"
);
