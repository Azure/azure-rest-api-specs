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
 * Backup resource vault config details.
 */
@singleton("vaultconfig")
@parentResource(VaultResource)
model BackupResourceVaultConfigResource
  is Azure.ResourceManager.TrackedResource<BackupResourceVaultConfig> {
  ...ResourceNameParameter<
    Resource = BackupResourceVaultConfigResource,
    KeyName = "backupconfig",
    SegmentName = "backupconfig",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "For backward compatibility"
@armResourceOperations
interface BackupResourceVaultConfigs {
  /**
   * Fetches resource vault config.
   */
  get is ArmResourceRead<BackupResourceVaultConfigResource>;

  /**
   * Updates vault security config.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  put is ArmResourceCreateOrReplaceSync<
    BackupResourceVaultConfigResource,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
      @header
      `x-ms-authorization-auxiliary`?: string;
    },
    Response = ArmResourceUpdatedResponse<BackupResourceVaultConfigResource>
  >;

  /**
   * Updates vault security config.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    BackupResourceVaultConfigResource,
    PatchModel = BackupResourceVaultConfigResource,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      #suppress "@azure-tools/typespec-azure-core/casing-style" "For backward compatibility"
      @header
      `x-ms-authorization-auxiliary`?: string;
    }
  >;
}

@@doc(BackupResourceVaultConfigResource.name, "");
@@doc(BackupResourceVaultConfigResource.properties,
  "BackupResourceVaultConfigResource properties"
);
@@doc(BackupResourceVaultConfigs.put::parameters.resource,
  "resource config request"
);
@@doc(BackupResourceVaultConfigs.update::parameters.properties,
  "resource config request"
);
