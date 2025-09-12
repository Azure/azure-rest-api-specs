import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.RecoveryServices;

#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@singleton("backupResourceEncryptionConfig")
@parentResource(VaultResource)
@Azure.ResourceManager.Private.armResourceInternal(
  BackupResourceEncryptionConfigExtended
)
@Azure.ResourceManager.Legacy.customAzureResource
@Http.Private.includeInapplicableMetadataInPayload(false)
model BackupResourceEncryptionConfigExtendedResource extends Resource {
  ...ResourceNameParameter<
    Resource = BackupResourceEncryptionConfigExtendedResource,
    KeyName = "backupEncryptionConfig",
    SegmentName = "backupEncryptionConfigs",
    NamePattern = ""
  >;

  /**
   * BackupResourceEncryptionConfigExtendedResource properties
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: BackupResourceEncryptionConfigExtended;
}

#suppress "@azure-tools/typespec-azure-core/no-private-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@singleton("backupResourceEncryptionConfig")
@parentResource(VaultResource)
@Azure.ResourceManager.Private.armResourceInternal(
  BackupResourceEncryptionConfig
)
@Azure.ResourceManager.Legacy.customAzureResource
@Http.Private.includeInapplicableMetadataInPayload(false)
model BackupResourceEncryptionConfigResource extends Resource {
  ...ResourceNameParameter<
    Resource = BackupResourceEncryptionConfigResource,
    KeyName = "backupEncryptionConfig",
    SegmentName = "backupEncryptionConfigs",
    NamePattern = ""
  >;

  /**
   * BackupResourceEncryptionConfigResource properties
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: BackupResourceEncryptionConfig;
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
@@doc(BackupResourceEncryptionConfigs.update::parameters.resource,
  "Vault encryption input config request"
);

@@doc(BackupResourceEncryptionConfigResource.name, "");
