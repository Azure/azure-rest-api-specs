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
@doc("NetApp account resource")
model NetAppAccount is TrackedResource<AccountProperties> {
  @doc("The name of the NetApp account")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,127}$")
  @path
  @key("accountName")
  @segment("netAppAccounts")
  name: string;

  @doc("A unique read-only string that changes whenever the resource is updated.")
  @visibility("read")
  etag?: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface NetAppAccounts {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get the NetApp account")
  @operationId("Accounts_Get")
  get is ArmResourceRead<NetAppAccount>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or update the specified NetApp account within the resource group")
  @operationId("Accounts_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    NetAppAccount,
    BaseParameters<NetAppAccount>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Patch the specified NetApp account")
  @operationId("Accounts_Update")
  update is ArmCustomPatchAsync<
    NetAppAccount,
    NetAppAccountPatch,
    BaseParameters<NetAppAccount>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Delete the specified NetApp account")
  @operationId("Accounts_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    NetAppAccount,
    BaseParameters<NetAppAccount>,
    ArmLroLocationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List and describe all NetApp accounts in the resource group.")
  @operationId("Accounts_List")
  list is ArmResourceListByParent<NetAppAccount>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List and describe all NetApp accounts in the subscription.")
  @operationId("Accounts_ListBySubscription")
  listBySubscription is ArmListBySubscription<NetAppAccount>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Renew identity credentials that are used to authenticate to key vault, for customer-managed key encryption. If encryption.identity.principalId does not match identity.principalId, running this operation will fix it.")
  @operationId("Accounts_RenewCredentials")
  renewCredentials is ArmResourceActionAsync<
    NetAppAccount,
    void,
    void,
    BaseParameters<NetAppAccount>,
    ArmAsyncOperationHeader
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("VolumeGroups_ListByNetAppAccount")
  @summary("Describe all volume groups")
  @doc("List all volume groups for given account")
  // FIXME: VolumeGroups_ListByNetAppAccount could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetApp/netAppAccounts/{accountName}/volumeGroups")
  @get
  listByNetAppAccount is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the NetApp account")
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
