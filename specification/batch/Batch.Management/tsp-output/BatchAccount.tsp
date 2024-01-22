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

namespace Microsoft.Batch;
/**
 * Contains information about an Azure Batch account.
 */
model BatchAccount is ProxyResource<BatchAccountProperties> {
  /**
   * The name of the Batch account.
   */
  @maxLength(24)
  @minLength(3)
  @pattern("^[a-zA-Z0-9]+$")
  @path
  @key("accountName")
  @segment("batchAccounts")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface BatchAccounts {
  /**
   * Gets information about the specified Batch account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BatchAccount_Get")
  get is ArmResourceRead<BatchAccount>;

  /**
   * Creates a new Batch account with the specified parameters. Existing accounts cannot be updated with this API and should instead be updated with the Update Batch Account API.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BatchAccount_Create")
  create is ArmResourceCreateOrReplaceAsync<
    BatchAccount,
    BaseParameters<BatchAccount>,
    ArmLroLocationHeader
  >;

  /**
   * Updates the properties of an existing Batch account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("BatchAccount_Update")
  update is ArmCustomPatchSync<BatchAccount, BatchAccountUpdateParameters>;

  /**
   * Deletes the specified Batch account.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BatchAccount_Delete")
  delete is ArmResourceDeleteAsync<
    BatchAccount,
    BaseParameters<BatchAccount>,
    ArmLroLocationHeader
  >;

  /**
   * Gets information about the Batch accounts associated with the specified resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BatchAccount_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<BatchAccount>;

  /**
   * Gets information about the Batch accounts associated with the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BatchAccount_List")
  list is ArmListBySubscription<BatchAccount>;

  /**
   * Synchronizes access keys for the auto-storage account configured for the specified Batch account, only if storage key authentication is being used.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BatchAccount_SynchronizeAutoStorageKeys")
  synchronizeAutoStorageKeys is ArmResourceActionNoContentSync<
    BatchAccount,
    void
  >;

  /**
   * This operation applies only to Batch accounts with allowedAuthenticationModes containing 'SharedKey'. If the Batch account doesn't contain 'SharedKey' in its allowedAuthenticationMode, clients cannot use shared keys to authenticate, and must use another allowedAuthenticationModes instead. In this case, regenerating the keys will fail.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BatchAccount_RegenerateKey")
  regenerateKey is ArmResourceActionSync<
    BatchAccount,
    BatchAccountRegenerateKeyParameters,
    BatchAccountKeys
  >;

  /**
   * This operation applies only to Batch accounts with allowedAuthenticationModes containing 'SharedKey'. If the Batch account doesn't contain 'SharedKey' in its allowedAuthenticationMode, clients cannot use shared keys to authenticate, and must use another allowedAuthenticationModes instead. In this case, getting the keys will fail.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BatchAccount_GetKeys")
  getKeys is ArmResourceActionSync<BatchAccount, void, BatchAccountKeys>;

  /**
   * Lists the endpoints that a Batch Compute Node under this Batch Account may call as part of Batch service administration. If you are deploying a Pool inside of a virtual network that you specify, you must make sure your network allows outbound access to these endpoints. Failure to allow access to these endpoints may cause Batch to mark the affected nodes as unusable. For more information about creating a pool inside of a virtual network, see https://docs.microsoft.com/en-us/azure/batch/batch-virtual-network.
   */
  // FIXME: BatchAccount_ListOutboundNetworkDependenciesEndpoints could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("BatchAccount_ListOutboundNetworkDependenciesEndpoints")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Batch/batchAccounts/{accountName}/outboundNetworkDependenciesEndpoints")
  @get
  listOutboundNetworkDependenciesEndpoints is Azure.Core.Foundations.Operation<
    {
      /**
       * The name of the resource group that contains the Batch account.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the Batch account.
       */
      @maxLength(24)
      @minLength(3)
      @pattern("^[a-zA-Z0-9]+$")
      @path
      accountName: string;

      /**
       * The Azure subscription ID. This is a GUID-formatted string (e.g. 00000000-0000-0000-0000-000000000000)
       */
      @path
      subscriptionId: string;
    },
    OutboundEnvironmentEndpointCollection
  >;
}

@@projectedName(BatchAccounts.create::parameters.resource,
  "json",
  "parameters"
);
@@extension(BatchAccounts.create::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(BatchAccounts.create::parameters.resource,
  "Additional parameters for account creation."
);
@@projectedName(BatchAccounts.update::parameters.properties,
  "json",
  "parameters"
);
@@extension(BatchAccounts.update::parameters.properties,
  "x-ms-client-name",
  "parameters"
);
@@doc(BatchAccounts.update::parameters.properties,
  "Additional parameters for account update."
);
@@projectedName(BatchAccounts.regenerateKey::parameters.body,
  "json",
  "parameters"
);
@@extension(BatchAccounts.regenerateKey::parameters.body,
  "x-ms-client-name",
  "parameters"
);
@@doc(BatchAccounts.regenerateKey::parameters.body,
  "The type of key to regenerate."
);
