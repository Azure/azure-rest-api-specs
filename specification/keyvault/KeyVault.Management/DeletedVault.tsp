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
  getDeleted is ArmResourceRead<DeletedVault, Error = CloudError>;

  /**
   * Permanently deletes the specified vault. aka Purges the deleted Azure key vault.
   */
  @action("purge")
  purgeDeleted is ArmResourceActionAsyncBase<
    DeletedVault,
    void,
    Response = OkResponse | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader &
      Azure.Core.Foundations.RetryAfterHeader>,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters,
    Error = CloudError
  >;
}

@@doc(DeletedVault.name, "The name of the vault.");
@@doc(DeletedVault.properties, "Properties of the vault");
