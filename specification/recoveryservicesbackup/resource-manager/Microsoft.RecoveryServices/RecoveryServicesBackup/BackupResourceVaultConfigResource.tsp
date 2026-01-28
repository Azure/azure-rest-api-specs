import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Legacy;
using TypeSpec.Http;

namespace Microsoft.RecoveryServices;
/**
 * Backup resource vault config details.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Legacy TrackedResourceWithOptionalLocation for back compatibility"
@singleton("vaultconfig")
@parentResource(VaultResource)
model BackupResourceVaultConfigResource
  is TrackedResourceWithOptionalLocation<BackupResourceVaultConfig> {
  ...ResourceNameParameter<
    Resource = BackupResourceVaultConfigResource,
    KeyName = "backupconfig",
    SegmentName = "backupconfig",
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
interface BackupResourceVaultConfigs {
  /**
   * Fetches resource vault config.
   */
  get is ArmResourceRead<BackupResourceVaultConfigResource>;

  /**
   * Updates vault security config.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  put is ArmResourceCreateOrReplaceSync<
    BackupResourceVaultConfigResource,
    Parameters = {
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
      #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
