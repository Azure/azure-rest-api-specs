import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./StorageAccount.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Storage;
@doc("The local user associated with the storage accounts.")
@parentResource(StorageAccount)
model StorageAccountLocalUser is ProxyResource<LocalUserProperties> {
  @doc("The name of local user. The username must contain lowercase letters and numbers only. It must be unique only within the storage account.")
  @maxLength(64)
  @minLength(3)
  @path
  @key("username")
  @segment("localUsers")
  name: string;
}

@armResourceOperations
interface StorageAccountLocalUsers {
  @doc("Get the local user of the storage account by username.")
  get is ArmResourceRead<StorageAccountLocalUser>;
  @doc("Create or update the properties of a local user associated with the storage account")
  createOrUpdate is ArmResourceCreateOrReplaceSync<StorageAccountLocalUser>;
  @doc("Deletes the local user associated with the specified storage account.")
  delete is ArmResourceDeleteSync<StorageAccountLocalUser>;
  @doc("List the local users associated with the storage account.")
  list is ArmResourceListByParent<StorageAccountLocalUser>;
  @doc("List SSH authorized keys and shared key of the local user.")
  listKeys is ArmResourceActionSync<
    StorageAccountLocalUser,
    void,
    LocalUserKeys
  >;
  @doc("Regenerate the local user SSH password.")
  regeneratePassword is ArmResourceActionSync<
    StorageAccountLocalUser,
    void,
    LocalUserRegeneratePasswordResult
  >;
}
