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
@parentResource(Vault)
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location?: string;
}

alias VaultOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;
  },
  {
    /** The name of the recovery services vault. */
    @path
    @segment("vaults")
    @key
    resourceName: string;
  },
  ErrorType = never
>;

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@armResourceOperations
interface VaultSettings {
  /**
   * Gets the vault setting. This includes the Migration Hub connection settings.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets the vault setting.")
  get is ArmResourceRead<VaultSetting, Error = never>;

  /**
   * The operation to configure vault setting.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Updates vault setting. A vault setting object is a singleton per vault and it is always present by default.")
  create is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    VaultSetting,
    Request = VaultSettingCreationInput,
    Response = ArmResourceUpdatedResponse<VaultSetting> & {
      ...ArmLroLocationHeader<FinalResult = VaultSetting>;
      ...Azure.Core.Foundations.RetryAfterHeader;
    },
    Error = never
  >;

  /**
   * Gets the list of vault setting. This includes the Migration Hub connection settings.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Gets the list of vault setting.")
  @action("replicationVaultSettings")
  @list
  @get
  list is VaultOps.ActionSync<
    VaultSetting,
    void,
    Response = ArmResponse<VaultSettingCollection>
  >;
}

@@doc(VaultSetting.name, "Vault setting name.");
@@doc(VaultSetting.properties, "The vault setting properties.");
@@doc(VaultSettings.create::parameters.resource,
  "Vault setting creation input."
);
