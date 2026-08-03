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
  @pattern("^[a-zA-Z0-9-]{3,24}$")
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
  @armResourceCreateOrUpdate(Vault)
  @put
  createOrUpdate(
    ...ResourceInstanceParameters<Vault,BaseParameters<VaultCreateOrUpdateParameters>>,
    @doc("Parameters to create or update the vault")
    @body
    resource : VaultCreateOrUpdateParameters
  ): ArmResponse<Vault>
  | ArmResourceCreatedSyncResponse<Vault>
  | ErrorResponse;
  // createOrUpdate is ArmResourceCreateOrReplaceAsync<Vault>;

  /**
   * Update a key vault in the specified subscription.
   */
  //@parameterVisibility("read")
  @armResourceUpdate(Vault)
  @patch
  update(
    ...ResourceInstanceParameters<Vault,BaseParameters<VaultPatchParameters>>,
    @doc("Parameters to patch the vault")
    @body
    properties: VaultPatchParameters
  ): ArmResponse<Vault>
  | ArmResourceCreatedSyncResponse<Vault> //201
  | ErrorResponse;

  /**
   * Deletes the specified Azure key vault.
   */
  delete is ArmResourceDeleteSync<Vault>;

  /**
   * The List operation gets information about the vaults associated with the subscription and within the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Vaults_ListByResourceGroup")
  @segment("vaults")
  listByResourceGroup (
    ...ResourceParentParameters<Vault, BaseParameters<Vault>>,
      /**
       * Maximum number of results to return.
       */    
    @query("$top")
    $top?: int32;
  ): TResourceListResult<Vault>
  | ErrorResponse;

  /**
   * The List operation gets information about the vaults associated with the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Vaults_ListBySubscription")
  @segment("vaults")
  listBySubscription (
    ...ResourceParentParameters<Vault, SubscriptionBaseParameters>;
      /**
       * Maximum number of results to return.
       */    
    @query("$top")
    $top?: int32;
  ): TResourceListResult<Vault>
  | ErrorResponse;

  /**
   * Checks that the vault name is valid and is not already in use.
   */
  checkNameAvailability is checkGlobalNameAvailability<
    VaultCheckNameAvailabilityParameters,
    CheckNameAvailabilityResult
  >;

}

@armResourceOperations
interface PrivateLinkResources{
    /**
   * Gets the private link resources supported for the key vault.
   */
  // FIXME: PrivateLinkResources_ListByVault could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateLinkResources_ListByVault")
  @segment("privateLinkResources")
  @armResourceRead(Vault)
  @get
  listByVault
  (
    ...ResourceInstanceParameters<Vault, BaseParameters<Vault>>,
  ) : ArmResponse<PrivateLinkResourceListResult> | ErrorResponse
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
