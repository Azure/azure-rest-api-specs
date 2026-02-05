import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Legacy;
using TypeSpec.Http;

namespace Microsoft.KeyVault;
/**
 * Resource information with extended details.
 */
model Vault is Azure.ResourceManager.ProxyResource<VaultProperties, false> {
  ...ResourceNameParameter<
    Resource = Vault,
    KeyName = "vaultName",
    SegmentName = "vaults",
    NamePattern = ""
  >;

  /** Azure location of the key vault resource. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  location?: azureLocation;

  /** Tags assigned to the key vault resource. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}
alias VaultsParentParameter = {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ResourceGroupParameter;

  /**
   * Name of the vault
   */
  @path
  @segment("vaults")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  vaultName: string;
};

alias VaultsParameter = {
  /**
   * Name of the operation
   */
  @path
  @segment("accessPolicies")
  operationKind: AccessPolicyUpdateKind;
};

alias VaultsOps = Azure.ResourceManager.Legacy.RoutedOperations<
  VaultsParentParameter,
  VaultsParameter,
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.KeyVault/vaults/{vaultName}/accessPolicies/{operationKind}",
  }
>;

@armResourceOperations(#{ allowStaticRoutes: true })
interface Vaults {
  /**
   * Gets the specified Azure key vault.
   */
  get is ArmResourceRead<Vault, Error = CloudError>;

  /**
   * Create or update a key vault in the specified subscription.
   */
  createOrUpdate is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    Vault,
    Request = VaultCreateOrUpdateParameters,
    Response = Vault | ArmResourceCreatedResponse<
      Vault,
      LroHeaders = ArmLroLocationHeader<FinalResult = Vault> &
        Azure.Core.Foundations.RetryAfterHeader
    >,
    Error = CloudError
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
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.KeyVault/vaults/{vaultName}/accessPolicies/{operationKind}")
  updateAccessPolicy is VaultsOps.ActionSync<
    Vault,
    Request = VaultAccessPolicyParameters,
    Response = ArmResponse<VaultAccessPolicyParameters> | ArmResourceCreatedSyncResponse<VaultAccessPolicyParameters>,
    OverrideErrorType = CloudError
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
@@doc(Vaults.updateAccessPolicy::parameters.body,
  "Access policy to merge into the vault"
);
