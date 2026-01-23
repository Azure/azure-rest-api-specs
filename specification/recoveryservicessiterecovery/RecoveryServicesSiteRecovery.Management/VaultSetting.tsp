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
 * Vault setting.
 */
model VaultSetting
  is Azure.ResourceManager.ProxyResource<VaultSettingProperties> {
  ...ResourceNameParameter<
    Resource = VaultSetting,
    KeyName = "vaultSettingName",
    SegmentName = "replicationVaultSettings",
    NamePattern = ""
  >;

  /**
   * Resource Location
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  location?: string;
}

@armResourceOperations
interface VaultSettings {
  /**
   * Gets the vault setting. This includes the Migration Hub connection settings.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationVaultSetting_Get")
  @summary("Gets the vault setting.")
  get is ArmResourceRead<VaultSetting>;

  /**
   * The operation to configure vault setting.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("ReplicationVaultSetting_Create")
  @summary("Updates vault setting. A vault setting object is a singleton per vault and it is always present by default.")
  create is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    VaultSetting,
    Request = VaultSettingCreationInput,
    Response = ArmResourceUpdatedResponse<VaultSetting>,
    LroHeaders = ArmLroLocationHeader<FinalResult = VaultSetting> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Gets the list of vault setting. This includes the Migration Hub connection settings.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ReplicationVaultSetting_List")
  @summary("Gets the list of vault setting.")
  list is ArmResourceListByParent<
    VaultSetting,
    Response = ArmResponse<VaultSettingCollection>
  >;
}

@@doc(VaultSetting.name, "Vault setting name.");
@@doc(VaultSetting.properties, "The vault setting properties.");
@@doc(VaultSettings.create::parameters.resource,
  "Vault setting creation input."
);
