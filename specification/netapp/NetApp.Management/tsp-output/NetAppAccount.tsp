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

namespace Microsoft.NetApp;
/**
 * NetApp account resource
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(AccountProperties)
model NetAppAccount extends TrackedResourceBase {
  /**
   * The name of the NetApp account
   */
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,127}$")
  @path
  @key("accountName")
  @segment("netAppAccounts")
  @visibility("read")
  name: string;

  /**
   * A unique read-only string that changes whenever the resource is updated.
   */
  @visibility("read")
  etag?: string;

  /**
   * NetApp Account properties
   */
  @extension("x-ms-client-flatten", true)
  properties?: AccountProperties;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface NetAppAccounts {
  /**
   * Get the NetApp account
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Accounts_Get")
  get is ArmResourceRead<NetAppAccount>;

  /**
   * Create or update the specified NetApp account within the resource group
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Accounts_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    NetAppAccount,
    BaseParameters<NetAppAccount>,
    ArmAsyncOperationHeader
  >;

  /**
   * Patch the specified NetApp account
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Accounts_Update")
  update is ArmCustomPatchAsync<
    NetAppAccount,
    NetAppAccountPatch,
    BaseParameters<NetAppAccount>,
    ArmLroLocationHeader
  >;

  /**
   * Delete the specified NetApp account
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Accounts_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    NetAppAccount,
    BaseParameters<NetAppAccount>,
    ArmLroLocationHeader
  >;

  /**
   * List and describe all NetApp accounts in the resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Accounts_List")
  list is ArmResourceListByParent<NetAppAccount>;

  /**
   * List and describe all NetApp accounts in the subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Accounts_ListBySubscription")
  listBySubscription is ArmListBySubscription<NetAppAccount>;

  /**
   * Renew identity credentials that are used to authenticate to key vault, for customer-managed key encryption. If encryption.identity.principalId does not match identity.principalId, running this operation will fix it.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Accounts_RenewCredentials")
  renewCredentials is ArmResourceActionAsync<
    NetAppAccount,
    void,
    void,
    BaseParameters<NetAppAccount>,
    ArmAsyncOperationHeader
  >;

  /**
   * List all volume groups for given account
   */
  // FIXME: VolumeGroups_ListByNetAppAccount could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("VolumeGroups_ListByNetAppAccount")
  @summary("Describe all volume groups")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetApp/netAppAccounts/{accountName}/volumeGroups")
  @get
  listByNetAppAccount is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the NetApp account
       */
      @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,127}$")
      @path
      accountName: string;
    },
    VolumeGroupList
  >;
}

@@projectedName(NetAppAccounts.createOrUpdate::parameters.resource,
  "json",
  "body"
);
@@extension(NetAppAccounts.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "body"
);
@@doc(NetAppAccounts.createOrUpdate::parameters.resource,
  "NetApp Account object supplied in the body of the operation."
);
@@projectedName(NetAppAccounts.update::parameters.properties, "json", "body");
@@extension(NetAppAccounts.update::parameters.properties,
  "x-ms-client-name",
  "body"
);
@@doc(NetAppAccounts.update::parameters.properties,
  "NetApp Account object supplied in the body of the operation."
);
