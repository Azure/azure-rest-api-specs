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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: BatchAccountIdentity;
}

@armResourceOperations
interface BatchAccounts {
  /**
   * Gets information about the specified Batch account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BatchAccount_Get")
  get is ArmResourceRead<BatchAccount>;

  /**
   * Creates a new Batch account with the specified parameters. Existing accounts cannot be updated with this API and should instead be updated with the Update Batch Account API.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("BatchAccount_Create")
  create is ArmResourceCreateOrReplaceAsync<
    BatchAccount,
    Response = ArmResourceUpdatedResponse<BatchAccount> | ArmAcceptedLroResponse,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates the properties of an existing Batch account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BatchAccount_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    BatchAccount,
    PatchModel = BatchAccountUpdateParameters
  >;

  /**
   * Deletes the specified Batch account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("BatchAccount_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    BatchAccount,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets information about the Batch accounts associated with the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BatchAccount_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<BatchAccount>;

  /**
   * Gets information about the Batch accounts associated with the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BatchAccount_List")
  list is ArmListBySubscription<BatchAccount>;

  /**
   * Synchronizes access keys for the auto-storage account configured for the specified Batch account, only if storage key authentication is being used.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BatchAccount_SynchronizeAutoStorageKeys")
  @action("syncAutoStorageKeys")
  synchronizeAutoStorageKeys is ArmResourceActionSync<
    BatchAccount,
    void,
    NoContentResponse
  >;

  /**
   * This operation applies only to Batch accounts with allowedAuthenticationModes containing 'SharedKey'. If the Batch account doesn't contain 'SharedKey' in its allowedAuthenticationMode, clients cannot use shared keys to authenticate, and must use another allowedAuthenticationModes instead. In this case, regenerating the keys will fail.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BatchAccount_RegenerateKey")
  @action("regenerateKeys")
  regenerateKey is ArmResourceActionSync<
    BatchAccount,
    BatchAccountRegenerateKeyParameters,
    ArmResponse<BatchAccountKeys>
  >;

  /**
   * This operation applies only to Batch accounts with allowedAuthenticationModes containing 'SharedKey'. If the Batch account doesn't contain 'SharedKey' in its allowedAuthenticationMode, clients cannot use shared keys to authenticate, and must use another allowedAuthenticationModes instead. In this case, getting the keys will fail.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BatchAccount_GetKeys")
  @action("listKeys")
  getKeys is ArmResourceActionSync<
    BatchAccount,
    void,
    ArmResponse<BatchAccountKeys>
  >;

  /**
   * Lists the endpoints that a Batch Compute Node under this Batch Account may call as part of Batch service administration. If you are deploying a Pool inside of a virtual network that you specify, you must make sure your network allows outbound access to these endpoints. Failure to allow access to these endpoints may cause Batch to mark the affected nodes as unusable. For more information about creating a pool inside of a virtual network, see https://learn.microsoft.com/azure/batch/batch-virtual-network.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("BatchAccount_ListOutboundNetworkDependenciesEndpoints")
  @get
  @list
  @action("outboundNetworkDependenciesEndpoints")
  listOutboundNetworkDependenciesEndpoints is ArmResourceActionSync<
    BatchAccount,
    void,
    ArmResponse<OutboundEnvironmentEndpointCollection>
  >;
}

@@maxLength(BatchAccount.name, 24);
@@minLength(BatchAccount.name, 3);
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
