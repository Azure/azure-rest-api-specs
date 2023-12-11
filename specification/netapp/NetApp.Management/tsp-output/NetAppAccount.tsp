import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.NetApp;
@doc("NetApp account resource")
model NetAppAccount is TrackedResource<AccountProperties> {
  @doc("The name of the NetApp account")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9\\-_]{0,127}$")
  @path
  @key("accountName")
  @segment("netAppAccounts")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
}

@armResourceOperations
interface NetAppAccounts {
  @doc("Get the NetApp account")
  get is ArmResourceRead<NetAppAccount>;
  @doc("Create or update the specified NetApp account within the resource group")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<NetAppAccount>;
  @doc("Patch the specified NetApp account")
  update is ArmResourcePatchAsync<NetAppAccount, AccountProperties>;
  @doc("Delete the specified NetApp account")
  delete is ArmResourceDeleteWithoutOkAsync<NetAppAccount>;
  @doc("List and describe all NetApp accounts in the resource group.")
  list is ArmResourceListByParent<NetAppAccount>;
  @doc("List and describe all NetApp accounts in the subscription.")
  listBySubscription is ArmListBySubscription<NetAppAccount>;
  @doc("Renew identity credentials that are used to authenticate to key vault, for customer-managed key encryption. If encryption.identity.principalId does not match identity.principalId, running this operation will fix it.")
  renewCredentials is ArmResourceActionAsync<NetAppAccount, {}, {}>;
  @summary("Describe all volume groups")
  @doc("List all volume groups for given account")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.NetApp/netAppAccounts/{accountName}/volumeGroups")
  @get
  ListByNetAppAccount is Azure.Core.Foundations.Operation<
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
