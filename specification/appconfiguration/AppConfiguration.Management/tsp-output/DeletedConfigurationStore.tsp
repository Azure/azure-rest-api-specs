import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.AppConfiguration;
@doc("Deleted configuration store information with extended details.")
@locationResource
model DeletedConfigurationStore
  is ProxyResource<DeletedConfigurationStoreProperties> {
  @doc("The name of the configuration store.")
  @maxLength(50)
  @minLength(5)
  @pattern("^[a-zA-Z0-9_-]*$")
  @key("configStoreName")
  @segment("deletedConfigurationStores")
  name: string;
}

@armResourceOperations
@projectedName("client", "ConfigurationStores")
interface DeletedConfigurationStores_ConfigurationStores {
  @doc("Gets a deleted Azure app configuration store.")
  getDeleted is ArmResourceRead<DeletedConfigurationStore>;

  @doc("Gets information about the deleted configuration stores in a subscription.")
  listDeleted is ArmResourceListByParent<DeletedConfigurationStore>;

  @doc("Permanently deletes the specified configuration store.")
  purgeDeleted is ArmResourceActionAsync<DeletedConfigurationStore, void, void>;
}
