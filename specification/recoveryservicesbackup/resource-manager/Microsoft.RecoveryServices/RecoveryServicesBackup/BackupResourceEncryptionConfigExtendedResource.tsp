import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Legacy;
using TypeSpec.Http;

namespace Microsoft.RecoveryServices;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy TrackedResourceWithOptionalLocation for back compatibility"
@singleton("backupResourceEncryptionConfig")
@parentResource(VaultResource)
@doc("")
model BackupResourceEncryptionConfigExtendedResource
  is TrackedResourceWithOptionalLocation<BackupResourceEncryptionConfigExtended> {
  ...ResourceNameParameter<
    Resource = BackupResourceEncryptionConfigExtendedResource,
    KeyName = "backupEncryptionConfig",
    SegmentName = "backupEncryptionConfigs",
    NamePattern = ""
  >;

  /**
   * Optional ETag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  eTag?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy TrackedResourceWithOptionalLocation for back compatibility"
@singleton("backupResourceEncryptionConfig")
@parentResource(VaultResource)
@doc("")
model BackupResourceEncryptionConfigResource
  is TrackedResourceWithOptionalLocation<BackupResourceEncryptionConfig> {
  ...ResourceNameParameter<
    Resource = BackupResourceEncryptionConfigResource,
    KeyName = "backupEncryptionConfig",
    SegmentName = "backupEncryptionConfigs",
    NamePattern = ""
  >;

  /**
   * Optional ETag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  eTag?: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface BackupResourceEncryptionConfigs {
  /**
   * Fetches Vault Encryption config.
   */
  get is ArmResourceRead<BackupResourceEncryptionConfigExtendedResource>;

  /**
   * Updates Vault encryption config.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  update is ArmResourceCreateOrReplaceSync<
    BackupResourceEncryptionConfigResource,
    Response = OkResponse
  >;
}

@@doc(BackupResourceEncryptionConfigExtendedResource.name, "");
@@doc(BackupResourceEncryptionConfigExtendedResource.properties,
  "BackupResourceEncryptionConfigExtendedResource properties"
);
@@doc(BackupResourceEncryptionConfigs.update::parameters.resource,
  "Vault encryption input config request"
);

@@doc(BackupResourceEncryptionConfigResource.name, "");
@@doc(BackupResourceEncryptionConfigResource.properties,
  "BackupResourceEncryptionConfigResource properties"
);
