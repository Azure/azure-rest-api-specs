import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/http";
import "@typespec/openapi";
import "./models.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RecoveryServices;

/**
 * The resource storage details.
 */
model BackupResourceConfigResource extends Resource {
  /**
   * BackupResourceConfigResource properties
   */
  properties?: BackupResourceConfig;
}

@tag("BackupResourceStorageConfigs")
interface BackupResourceConfigResources {
  /**
   * Fetches resource storage config.
   */
  @operationId("BackupResourceStorageConfigs_Get")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupstorageconfig/vaultstorageconfig")
  @get
  get(
    ...ApiVersionParameter,

    /**
     * The name of the recovery services vault.
     */
    @path vaultName: string,

    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,
  ): LegacyOkResponseBody<BackupResourceConfigResource> | NewErrorResponse;

  /**
   * Updates vault storage model type.
   */
  @operationId("BackupResourceStorageConfigs_Update")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupstorageconfig/vaultstorageconfig")
  @put
  update(
    ...ApiVersionParameter,

    /**
     * The name of the recovery services vault.
     */
    @path vaultName: string,

    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,

    /**
     * Vault storage config request
     */
    @body parameters: BackupResourceConfigResource,
  ): LegacyOkResponseBody<BackupResourceConfigResource> | NewErrorResponse;

  /**
   * Updates vault storage model type.
   */
  @operationId("BackupResourceStorageConfigs_patch")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.RecoveryServices/vaults/{vaultName}/backupstorageconfig/vaultstorageconfig")
  @patch(#{ implicitOptionality: false })
  patch(
    ...ApiVersionParameter,

    /**
     * The name of the recovery services vault.
     */
    @path vaultName: string,

    ...ResourceGroupParameter,
    ...SubscriptionIdParameter,

    /**
     * Vault storage config request
     */
    @body parameters: BackupResourceConfigResource,
  ): TypeSpec.Http.NoContentResponse | NewErrorResponse;
}
