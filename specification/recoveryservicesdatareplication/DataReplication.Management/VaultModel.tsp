import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DataReplication;
/**
 * Vault model.
 */
model VaultModel
  is Azure.ResourceManager.TrackedResource<VaultModelProperties> {
  ...ResourceNameParameter<
    Resource = VaultModel,
    KeyName = "vaultName",
    SegmentName = "replicationVaults",
    NamePattern = "^[a-zA-Z0-9]*$"
  >;
  ...Azure.ResourceManager.ManagedServiceIdentityProperty;
}

#suppress "@azure-tools/typespec-azure-core/no-openapi"
@@OpenAPI.extension(Vault.create::parameters.resource,
  "x-ms-client-name",
  "body"
);
#suppress "@azure-tools/typespec-azure-core/no-openapi"
@@OpenAPI.extension(Vault.update::parameters.properties,
  "x-ms-client-name",
  "body"
);

@armResourceOperations
interface Vault {
  /**
   * Gets the details of the vault.
   */
  get is ArmResourceRead<VaultModel>;

  /**
   * Creates the vault.
   */
  create is ArmResourceCreateOrReplaceAsync<VaultModel>;

  /**
   * Performs update on the vault.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<VaultModel, VaultModelUpdate>;

  /**
   * Removes the vault.
   */
  delete is ArmResourceDeleteWithoutOkAsync<VaultModel>;

  /**
   * Gets the list of vaults in the given subscription and resource group.
   */
  list is ArmResourceListByParent<
    VaultModel,
    {
      ...Azure.ResourceManager.Foundations.BaseParameters<VaultModel>;

      /**
       * Continuation token from the previous call.
       */
      @query("continuationToken")
      continuationToken?: string;
    }
  >;

  /**
   * Gets the list of vaults in the given subscription.
   */
  listBySubscription is ArmListBySubscription<VaultModel>;
}

@@doc(VaultModel.name, "The vault name.");
@@doc(Vault.create::parameters.resource, "Vault properties.");
@@doc(Vault.update::parameters.properties, "Vault properties.");
