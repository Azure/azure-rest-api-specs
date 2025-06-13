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
  get is ArmResourceRead<Vault>;

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
      LroHeaders = ArmLroLocationHeader &
        Azure.Core.Foundations.RetryAfterHeader
    >,
    ErrorResponse
  >;

  /**
   * Update a key vault in the specified subscription.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    Vault,
    PatchModel = VaultPatchParameters,
    Response = ArmResponse<Vault> | ArmResourceCreatedSyncResponse<Vault>
  >;

  /**
   * Deletes the specified Azure key vault.
   */
  delete is ArmResourceDeleteSync<Vault>;

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
    }
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
  @action("{operationKind}")
  updateAccessPolicy is ArmResourceActionSync<
    Vault,
    VaultAccessPolicyParameters,
    ArmResponse<VaultAccessPolicyParameters> | ArmCreatedResponse<VaultAccessPolicyParameters>,
    Parameters = {
      /**
       * Name of the operation
       */
      @path
      @segment("accessPolicies")
      operationKind: AccessPolicyUpdateKind;
    },
    Error = CloudError
  >;

  /**
   * Gets the private link resources supported for the key vault.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("privateLinkResources")
  @operationId("PrivateLinkResources_ListByVault")
  listByVault is ArmResourceActionSync<
    Vault,
    void,
    ArmResponse<PrivateLinkResourceListResult>
  >;
}

@@doc(Vault.name, "The name of the vault.");
@@doc(Vault.properties, "Properties of the vault");
@@doc(Vaults.createOrUpdate::parameters.resource,
  "Parameters to create or update the vault"
);
@@doc(Vaults.updateAccessPolicy::parameters.body,
  "Access policy to merge into the vault"
);
