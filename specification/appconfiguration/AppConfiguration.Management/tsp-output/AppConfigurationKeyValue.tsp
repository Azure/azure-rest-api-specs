import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./AppConfigurationStore.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.AppConfiguration;
@doc("The key-value resource along with all resource properties.")
@parentResource(AppConfigurationStore)
model AppConfigurationKeyValue is ProxyResource<KeyValueProperties> {
  @doc("Identifier of key and label combination. Key and label are joined by $ character. Label is optional.")
  @path
  @key("keyValueName")
  @segment("keyValues")
  name: string;
}

@armResourceOperations
interface AppConfigurationKeyValues {
  @doc("Gets the properties of the specified key-value.")
  get is ArmResourceRead<AppConfigurationKeyValue>;
  @doc("Creates a key-value.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AppConfigurationKeyValue>;
  @doc("Deletes a key-value.")
  delete is ArmResourceDeleteAsync<AppConfigurationKeyValue>;
  @doc("Lists the key-values for a given configuration store.")
  listByConfigurationStore is ArmResourceListByParent<
    AppConfigurationKeyValue,
    {
      ...BaseParameters<AppConfigurationKeyValue>;

      @doc("A skip token is used to continue retrieving items after an operation returns a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls.")
      @query("$skipToken")
      $skipToken?: string;
    }
  >;
}
