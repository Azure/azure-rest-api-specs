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
 * Resource information with extended details.
 */
model Vault is TrackedResource<VaultProperties> {
  /**
   * The name of the vault.
   */
  @path
  @key("vaultName")
  @segment("vaults")
  name: string;
}

@armResourceOperations
interface Vaults {
  /**
   * Gets the specified Azure key vault.
   */
  get is ArmResourceRead<Vault>;

  /**
   * Create or update a key vault in the specified subscription.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Vault>;

  /**
   * Update a key vault in the specified subscription.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<Vault, VaultPatchParameters>;

  /**
   * Deletes the specified Azure key vault.
   */
  delete is ArmResourceDeleteSync<Vault>;

  /**
   * The List operation gets information about the vaults associated with the subscription and within the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Vaults_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    Vault,
    {
      ...BaseParameters<Vault>;

      /**
       * Maximum number of results to return.
       */
      @query("$top")
      $top?: int32;
    }
  >;

  /**
   * The List operation gets information about the vaults associated with the subscription.
   */
  listBySubscription is ArmListBySubscription<Vault>;

  /**
   * Checks that the vault name is valid and is not already in use.
   */
  checkNameAvailability is checkGlobalNameAvailability<
    VaultCheckNameAvailabilityParameters,
    CheckNameAvailabilityResult
  >;

  /**
   * Gets the private link resources supported for the key vault.
   */
  // FIXME: PrivateLinkResources_ListByVault could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateLinkResources_ListByVault")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.KeyVault/vaults/{vaultName}/privateLinkResources")
  @get
  listByVault is Azure.Core.Foundations.Operation<
    {
      /**
       * Subscription credentials which uniquely identify Microsoft Azure subscription. The subscription ID forms part of the URI for every service call.
       */
      @path
      subscriptionId: string;

      /**
       * Name of the resource group that contains the key vault.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the key vault.
       */
      @pattern("^[a-zA-Z0-9-]{3,24}$")
      @path
      vaultName: string;
    },
    PrivateLinkResourceListResult
  >;
}

@@projectedName(Vaults.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(Vaults.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(Vaults.createOrUpdate::parameters.resource,
  "Parameters to create or update the vault"
);
@@projectedName(Vaults.update::parameters.properties, "json", "parameters");
@@extension(Vaults.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(Vaults.update::parameters.properties, "Parameters to patch the vault");
