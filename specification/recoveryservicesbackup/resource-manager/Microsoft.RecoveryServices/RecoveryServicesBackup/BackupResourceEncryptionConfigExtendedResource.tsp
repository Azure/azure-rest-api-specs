import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Legacy;
using TypeSpec.Http;

namespace Microsoft.RecoveryServices;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Empty documentation for back compatibility"
@singleton("backupResourceEncryptionConfig")
@parentResource(VaultResource)
@doc("")
model BackupResourceEncryptionConfigExtendedResource
  is ProxyResource<BackupResourceEncryptionConfigExtended> {
  ...ResourceNameParameter<
    Resource = BackupResourceEncryptionConfigExtendedResource,
    KeyName = "backupEncryptionConfig",
    SegmentName = "backupEncryptionConfigs",
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Empty documentation for back compatibility"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Backward compatibility"
@doc("")
model BackupResourceEncryptionConfigResource extends Foundations.Resource {
  /** The properties of the backup resource encryption config */
  properties?: BackupResourceEncryptionConfig;

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
  update is Legacy.CreateOrReplaceSync<
    BackupResourceEncryptionConfigExtendedResource,
    BackupResourceEncryptionConfigResource,
    Response = OkResponse
  >;
}

@@doc(BackupResourceEncryptionConfigExtendedResource.name, "");
@@doc(BackupResourceEncryptionConfigExtendedResource.properties,
  "The properties of the backup resource encryption config extended resource"
);
@@doc(BackupResourceEncryptionConfigs.update::parameters.resource,
  "Vault encryption input config request"
);
