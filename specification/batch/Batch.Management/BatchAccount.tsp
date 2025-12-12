import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Batch;
/**
 * Contains information about an Azure Batch account.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-no-key" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-custom-resource-usage-discourage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model BatchAccount extends AzureResource {
  properties?: BatchAccountProperties;

  /**
   * The identity of the Batch account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: BatchAccountIdentity;
}

alias BatchAccountOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider<BatchAccount>;
  },
  {
    /** The name of the Batch account. */
    @path
    @segment("batchAccounts")
    @key
    @pattern("^[a-zA-Z0-9]+$")
    @maxLength(24)
    @minLength(3)
    accountName: string;
  },
  ErrorType = CloudError
>;

@armResourceOperations
interface BatchAccounts {
  /**
   * Gets information about the specified Batch account.
   */
  get is BatchAccountOps.Read<BatchAccount>;

  /**
   * Creates a new Batch account with the specified parameters. Existing accounts cannot be updated with this API and should instead be updated with the Update Batch Account API.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  create is BatchAccountOps.CreateOrUpdateAsync<
    BatchAccount,
    Request = BatchAccountCreateParameters,
    Response = ArmResourceUpdatedResponse<BatchAccount> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = BatchAccount> &
      Azure.Core.Foundations.RetryAfterHeader>
  >;

  /**
   * Updates the properties of an existing Batch account.
   */
  @patch(#{ implicitOptionality: false })
  update is BatchAccountOps.CustomPatchSync<
    BatchAccount,
    PatchModel = BatchAccountUpdateParameters
  >;

  /**
   * Deletes the specified Batch account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is BatchAccountOps.DeleteWithoutOkAsync<
    BatchAccount,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets information about the Batch accounts associated with the specified resource group.
   */
  listByResourceGroup is BatchAccountOps.List<
    BatchAccount,
    Response = BatchAccountListResult
  >;

  /**
   * Gets information about the Batch accounts associated with the subscription.
   */
  @action("batchAccounts")
  list is ArmListBySubscription<
    BatchAccount,
    Response = BatchAccountListResult,
    Error = CloudError
  >;

  /**
   * Synchronizes access keys for the auto-storage account configured for the specified Batch account, only if storage key authentication is being used.
   */
  @action("syncAutoStorageKeys")
  synchronizeAutoStorageKeys is BatchAccountOps.ActionSync<
    BatchAccount,
    void,
    NoContentResponse
  >;

  /**
   * This operation applies only to Batch accounts with allowedAuthenticationModes containing 'SharedKey'. If the Batch account doesn't contain 'SharedKey' in its allowedAuthenticationMode, clients cannot use shared keys to authenticate, and must use another allowedAuthenticationModes instead. In this case, regenerating the keys will fail.
   */
  @action("regenerateKeys")
  regenerateKey is BatchAccountOps.ActionSync<
    BatchAccount,
    BatchAccountRegenerateKeyParameters,
    ArmResponse<BatchAccountKeys>
  >;

  /**
   * This operation applies only to Batch accounts with allowedAuthenticationModes containing 'SharedKey'. If the Batch account doesn't contain 'SharedKey' in its allowedAuthenticationMode, clients cannot use shared keys to authenticate, and must use another allowedAuthenticationModes instead. In this case, getting the keys will fail.
   */
  @action("listKeys")
  getKeys is BatchAccountOps.ActionSync<
    BatchAccount,
    void,
    ArmResponse<BatchAccountKeys>
  >;

  /**
   * Lists the endpoints that a Batch Compute Node under this Batch Account may call as part of Batch service administration. If you are deploying a Pool inside of a virtual network that you specify, you must make sure your network allows outbound access to these endpoints. Failure to allow access to these endpoints may cause Batch to mark the affected nodes as unusable. For more information about creating a pool inside of a virtual network, see https://learn.microsoft.com/azure/batch/batch-virtual-network.
   */
  @get
  @list
  @action("outboundNetworkDependenciesEndpoints")
  listOutboundNetworkDependenciesEndpoints is BatchAccountOps.ActionSync<
    BatchAccount,
    void,
    ArmResponse<OutboundEnvironmentEndpointCollection>
  >;
}

@@doc(BatchAccount.name, "The name of the Batch account.");
@@doc(BatchAccount.properties, "The properties associated with the account.");
@@doc(BatchAccounts.create::parameters.resource,
  "Additional parameters for account creation."
);
@@doc(BatchAccounts.update::parameters.properties,
  "Additional parameters for account update."
);
@@doc(BatchAccounts.regenerateKey::parameters.body,
  "The type of key to regenerate."
);
@@summary(BatchAccounts.getKeys,
  "Gets the account keys for the specified Batch account."
);
@@summary(BatchAccounts.regenerateKey,
  "Regenerates the specified account key for the Batch account."
);
