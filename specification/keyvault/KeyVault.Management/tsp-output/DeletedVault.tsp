import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.KeyVault;
/**
 * Deleted vault information with extended details.
 */
@locationResource
model DeletedVault is ProxyResource<DeletedVaultProperties> {
  /**
   * The name of the key vault.
   */
  @path
  @key("vaultName")
  @segment("deletedVaults")
  name: string;
    /**
   * The resource ID for the deleted key vault.
   */
    @visibility("read")
    id?: string;
  
    /**
     * The name of the key vault.
     */
    @visibility("read")
    vaultName?: string;
  
    /**
     * The resource type of the key vault.
     */
    @visibility("read")
    type?: string;
}

@armResourceOperations
interface DeletedVaults {
  /**
   * Gets the deleted Azure key vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Vaults_GetDeleted")
  getDeleted is ArmResourceRead<DeletedVault>;

  /**
   * Permanently deletes the specified vault. aka Purges the deleted Azure key vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @extension("x-ms-long-running-operation", true)
  @operationId("Vaults_PurgeDeleted")
  @segment("purge")
  @post
  purge(
    ...ResourceInstanceParameters<DeletedVault,BaseParameters<DeletedVault>>
  ): ArmResponse<DeletedVault>
  | ArmAcceptedResponse<"Vault is being purged.">
  | ErrorResponse;

  /**
   * Gets information about the deleted vaults in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Vaults_ListDeleted")
  listDeleted is ArmResourceListByParent<
    DeletedVault,
    {
      ...ApiVersionParameter,
      ...SubscriptionIdParameter;
    }
  >;
}
