import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppConfiguration;
@doc("Deleted configuration store information with extended details.")
@locationResource
model DeletedAppConfigurationStore
  is ProxyResource<DeletedConfigurationStoreProperties> {
  @doc("The name of the configuration store.")
  @maxLength(50)
  @minLength(5)
  @pattern("^[a-zA-Z0-9_-]*$")
  @path
  @key("configStoreName")
  @segment("deletedConfigurationStores")
  name: string;
}

@armResourceOperations
interface DeletedAppConfigurationStores {
  @doc("Gets a deleted Azure app configuration store.")
  getDeleted is ArmResourceRead<DeletedAppConfigurationStore>;
  @doc("Gets information about the deleted configuration stores in a subscription.")
  listDeleted is ArmResourceListByParent<DeletedAppConfigurationStore>;
  @doc("Permanently deletes the specified configuration store.")
  purgeDeleted is ArmResourceActionAsync<
    DeletedAppConfigurationStore,
    void,
    void
  >;
}
