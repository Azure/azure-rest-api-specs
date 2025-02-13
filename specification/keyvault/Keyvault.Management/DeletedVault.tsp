import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.KeyVault;
/**
 * Deleted vault information with extended details.
 */
@subscriptionResource
@parentResource(SubscriptionLocationResource)
model DeletedVault
  is Azure.ResourceManager.ProxyResource<DeletedVaultProperties> {
  ...ResourceNameParameter<
    Resource = DeletedVault,
    KeyName = "vaultName",
    SegmentName = "deletedVaults",
    NamePattern = ""
  >;
}

@armResourceOperations
interface DeletedVaults {
  /**
   * Gets the deleted Azure key vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Vaults_GetDeleted")
  getDeleted is ArmResourceRead<
    DeletedVault,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Permanently deletes the specified vault. aka Purges the deleted Azure key vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("purge")
  @operationId("Vaults_PurgeDeleted")
  purgeDeleted is ArmResourceActionAsync<
    DeletedVault,
    void,
    OkResponse,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;
}

@@doc(DeletedVault.name, "The name of the vault.");
@@doc(DeletedVault.properties, "Properties of the vault");
