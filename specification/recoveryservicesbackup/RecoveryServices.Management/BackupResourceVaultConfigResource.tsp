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
#suppress "@azure-tools/typespec-azure-core/no-private-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
@singleton("vaultconfig")
@parentResource(VaultResource)
@Azure.ResourceManager.Private.armResourceInternal(BackupResourceVaultConfig)
@Azure.ResourceManager.Legacy.customAzureResource
@Http.Private.includeInapplicableMetadataInPayload(false)
model BackupResourceVaultConfigResource extends Resource {
  ...ResourceNameParameter<
    Resource = BackupResourceVaultConfigResource,
    KeyName = "backupconfig",
    SegmentName = "backupconfig",
    NamePattern = ""
  >;

  /**
   * BackupResourceVaultConfigResource properties
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  properties?: BackupResourceVaultConfig;
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
@@doc(BackupResourceVaultConfigs.put::parameters.resource,
  "resource config request"
);
@@doc(BackupResourceVaultConfigs.update::parameters.properties,
  "resource config request"
);
