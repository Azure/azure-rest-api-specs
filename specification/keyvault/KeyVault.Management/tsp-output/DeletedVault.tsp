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
@includeInapplicableMetadataInPayload(false)
model DeletedVault {
  /**
   * The name of the vault.
   */
  @path
  @key("vaultName")
  @segment("deletedVaults")
  @visibility("read")
  name: string;

  /**
   * The resource ID for the deleted key vault.
   */
  @visibility("read")
  id?: string;

  /**
   * The resource type of the key vault.
   */
  @visibility("read")
  type?: string;

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
