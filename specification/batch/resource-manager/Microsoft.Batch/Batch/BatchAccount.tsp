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
model BatchAccount
  is Azure.ResourceManager.TrackedResource<BatchAccountProperties> {
  ...ResourceNameParameter<
    Resource = BatchAccount,
    KeyName = "accountName",
    SegmentName = "batchAccounts",
    NamePattern = "^[a-zA-Z0-9]+$"
  >;

  /**
   * The identity of the Batch account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: BatchAccountIdentity;
}

@armResourceOperations
@tag("BatchAccount")
interface BatchAccounts {
  /**
   * Gets information about the specified Batch account.
   */
  get is ArmResourceRead<BatchAccount, Error = CloudError>;

  /**
   * Creates a new Batch account with the specified parameters. Existing accounts cannot be updated with this API and should instead be updated with the Update Batch Account API.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  create is Legacy.CreateOrReplaceAsync<
    BatchAccount,
    Request = BatchAccountCreateParameters,
    Response = ArmResourceUpdatedResponse<BatchAccount> | ArmAcceptedLroResponse<LroHeaders = ArmLroLocationHeader<FinalResult = BatchAccount> &
      Azure.Core.Foundations.RetryAfterHeader>,
    Error = CloudError
  >;

  /**
   * Updates the properties of an existing Batch account.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    BatchAccount,
    PatchModel = BatchAccountUpdateParameters,
    Error = CloudError
  >;

  /**
   * Deletes the specified Batch account.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    BatchAccount,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets information about the Batch accounts associated with the specified resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    BatchAccount,
    Response = BatchAccountListResult,
    Error = CloudError
  >;

  /**
   * Gets information about the Batch accounts associated with the subscription.
   */
  list is ArmListBySubscription<
    BatchAccount,
    Response = BatchAccountListResult,
    Error = CloudError
  >;

  /**
   * Synchronizes access keys for the auto-storage account configured for the specified Batch account, only if storage key authentication is being used.
   */
  @action("syncAutoStorageKeys")
  synchronizeAutoStorageKeys is ArmResourceActionSync<
    BatchAccount,
    void,
    NoContentResponse,
    Error = CloudError
  >;

  /**
   * This operation applies only to Batch accounts with allowedAuthenticationModes containing 'SharedKey'. If the Batch account doesn't contain 'SharedKey' in its allowedAuthenticationMode, clients cannot use shared keys to authenticate, and must use another allowedAuthenticationModes instead. In this case, regenerating the keys will fail.
   */
  @action("regenerateKeys")
  regenerateKey is ArmResourceActionSync<
    BatchAccount,
    BatchAccountRegenerateKeyParameters,
    ArmResponse<BatchAccountKeys>,
    Error = CloudError
  >;

  /**
   * This operation applies only to Batch accounts with allowedAuthenticationModes containing 'SharedKey'. If the Batch account doesn't contain 'SharedKey' in its allowedAuthenticationMode, clients cannot use shared keys to authenticate, and must use another allowedAuthenticationModes instead. In this case, getting the keys will fail.
   */
  @action("listKeys")
  getKeys is ArmResourceActionSync<
    BatchAccount,
    void,
    ArmResponse<BatchAccountKeys>,
    Error = CloudError
  >;

  /**
   * Lists the endpoints that a Batch Compute Node under this Batch Account may call as part of Batch service administration. If you are deploying a Pool inside of a virtual network that you specify, you must make sure your network allows outbound access to these endpoints. Failure to allow access to these endpoints may cause Batch to mark the affected nodes as unusable. For more information about creating a pool inside of a virtual network, see https://learn.microsoft.com/azure/batch/batch-virtual-network.
   */
  @get
  @list
  @action("outboundNetworkDependenciesEndpoints")
  listOutboundNetworkDependenciesEndpoints is ArmResourceActionSync<
    BatchAccount,
    void,
    ArmResponse<OutboundEnvironmentEndpointCollection>,
    Error = CloudError
  >;
}

@@maxLength(BatchAccount.name, 24);
@@minLength(BatchAccount.name, 3);
@@doc(BatchAccount.name,
  "A name for the Batch account which must be unique within the region. Batch account names must be between 3 and 24 characters in length and must use only numbers and lowercase letters. This name is used as part of the DNS name that is used to access the Batch service in the region in which the account is created. For example: http://accountname.region.batch.azure.com/."
);
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
