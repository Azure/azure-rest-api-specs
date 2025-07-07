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

@armResourceOperations
interface BackupResourceVaultConfigResources {
  /**
   * Fetches resource vault config.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BackupResourceVaultConfigs_Get")
  get is ArmResourceRead<BackupResourceVaultConfigResource>;

  /**
   * Updates vault security config.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("BackupResourceVaultConfigs_Put")
  put is ArmResourceCreateOrReplaceSync<
    BackupResourceVaultConfigResource,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @header
      `x-ms-authorization-auxiliary`?: string;
    },
    Response = ArmResourceUpdatedResponse<BackupResourceVaultConfigResource>
  >;

  /**
   * Updates vault security config.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("BackupResourceVaultConfigs_Update")
  update is ArmCustomPatchSync<
    BackupResourceVaultConfigResource,
    PatchModel = BackupResourceVaultConfigResource,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "For backward compatibility"
      @header
      `x-ms-authorization-auxiliary`?: string;
    }
  >;
}

@@doc(BackupResourceVaultConfigResource.name, "");
@@doc(BackupResourceVaultConfigResource.properties,
  "BackupResourceVaultConfigResource properties"
);
@@doc(BackupResourceVaultConfigResources.put::parameters.resource,
  "resource config request"
);
@@doc(BackupResourceVaultConfigResources.update::parameters.properties,
  "resource config request"
);
