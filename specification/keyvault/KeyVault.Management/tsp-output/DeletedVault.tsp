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
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@locationResource
@Azure.ResourceManager.Private.armResourceInternal(DeletedVaultProperties)
@includeInapplicableMetadataInPayload(false)
model DeletedVault extends ProxyResourceBase {
  /**
   * The name of the vault.
   */
  @path
  @key("vaultName")
  @segment("deletedVaults")
  name: string;

  /**
   * Properties of the vault
   */
  @extension("x-ms-client-flatten", true)
  properties?: DeletedVaultProperties;
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
  @operationId("Vaults_PurgeDeleted")
  purgeDeleted is ArmResourceActionAsync<DeletedVault, void, void>;
}
