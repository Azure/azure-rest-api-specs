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

@singleton("backupResourceEncryptionConfig")
@parentResource(VaultResource)
model BackupResourceEncryptionConfigExtendedResource
  is Azure.ResourceManager.TrackedResource<BackupResourceEncryptionConfigExtended> {
  ...ResourceNameParameter<
    Resource = BackupResourceEncryptionConfigExtendedResource,
    KeyName = "backupEncryptionConfig",
    SegmentName = "backupEncryptionConfigs",
    NamePattern = ""
  >;
}

@singleton("backupResourceEncryptionConfig")
@parentResource(VaultResource)
model BackupResourceEncryptionConfigResource
  is Azure.ResourceManager.TrackedResource<BackupResourceEncryptionConfig> {
  ...ResourceNameParameter<
    Resource = BackupResourceEncryptionConfigResource,
    KeyName = "backupEncryptionConfig",
    SegmentName = "backupEncryptionConfigs",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "For backward compatibility"
@armResourceOperations
interface BackupResourceEncryptionConfigs {
  /**
   * Fetches Vault Encryption config.
   */
  get is ArmResourceRead<BackupResourceEncryptionConfigExtendedResource>;

  /**
   * Updates Vault encryption config.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
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
