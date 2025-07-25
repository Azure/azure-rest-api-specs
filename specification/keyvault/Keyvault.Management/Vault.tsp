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
 * Resource information with extended details.
 */
model Vault is Azure.ResourceManager.TrackedResource<VaultProperties, false> {
  ...ResourceNameParameter<
    Resource = Vault,
    KeyName = "vaultName",
    SegmentName = "vaults",
    NamePattern = ""
  >;
}

@armResourceOperations
interface Vaults {
  /**
   * Gets the specified Azure key vault.
   */
  get is ArmResourceRead<Vault, Error = CloudError>;

  /**
   * Create or update a key vault in the specified subscription.
   */
  @armResourceCreateOrUpdate(Vault)
  createOrUpdate is Azure.ResourceManager.Foundations.ArmCreateOperation<
    ResourceInstanceParameters<
      Vault,
      Azure.ResourceManager.Foundations.DefaultBaseParameters<Vault>
    >,
    VaultCreateOrUpdateParameters,
    Vault | ArmResourceCreatedResponse<
      Vault,
      LroHeaders = ArmLroLocationHeader<FinalResult = Vault> &
        Azure.Core.Foundations.RetryAfterHeader
    >,
    CloudError
  >;

  /**
   * Update a key vault in the specified subscription.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    Vault,
    PatchModel = VaultPatchParameters,
    Response = ArmResponse<Vault> | ArmResourceCreatedSyncResponse<Vault>,
    Error = CloudError
  >;

  /**
   * Deletes the specified Azure key vault.
   */
  delete is ArmResourceDeleteSync<Vault, Error = CloudError>;

  /**
   * The List operation gets information about the vaults associated with the subscription and within the specified resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    Vault,
    Parameters = {
      /**
       * Maximum number of results to return.
       */
      @query("$top")
      $top?: int32;
    },
    Error = CloudError
  >;

  /**
   * The List operation gets information about the vaults associated with the subscription.
   */
  listBySubscription is ArmListBySubscription<
    Vault,
    Parameters = {
      /**
       * Maximum number of results to return.
       */
      @query("$top")
      $top?: int32;
    },
    Error = CloudError
  >;

  /**
   * Update access policies in a key vault in the specified subscription.
   */
  @put
  updateAccessPolicy is Azure.ResourceManager.Foundations.ArmCreateOperation<
    {
      ...ApiVersionParameter;
      ...SubscriptionIdParameter;
      ...ResourceGroupParameter;
      ...Azure.ResourceManager.Legacy.Provider;

      /**
       * Name of the vault
       */
      @path
      @segment("vaults")
      @pattern("^[a-zA-Z0-9-]{3,24}$")
      vaultName: string;

      /**
       * Name of the operation
       */
      @path
      @segment("accessPolicies")
      operationKind: AccessPolicyUpdateKind;
    },
    VaultAccessPolicyParameters,
    ArmResponse<VaultAccessPolicyParameters> | ArmResourceCreatedSyncResponse<VaultAccessPolicyParameters>,
    CloudError
  >;

  /**
   * Gets the private link resources supported for the key vault.
   */
  @get
  @action("privateLinkResources")
  listByVault is ArmResourceActionSync<
    Vault,
    void,
    ArmResponse<PrivateLinkResourceListResult>,
    Error = CloudError
  >;
}

@@doc(Vault.name, "The name of the vault.");
@@doc(Vault.properties, "Properties of the vault");
@@doc(Vaults.createOrUpdate::parameters.resource,
  "Parameters to create or update the vault"
);
@@doc(Vaults.update::parameters.properties, "Parameters to patch the vault");
@@doc(Vaults.updateAccessPolicy::parameters.resource,
  "Access policy to merge into the vault"
);
