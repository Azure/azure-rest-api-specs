import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ConfigurationStore.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppConfiguration;
@doc("The key-value resource along with all resource properties.")
@parentResource(ConfigurationStore)
model KeyValue is ProxyResource<KeyValueProperties> {
  @doc("Identifier of key and label combination. Key and label are joined by $ character. Label is optional.")
  @path
  @key("keyValueName")
  @segment("keyValues")
  name: string;
}

@armResourceOperations
interface KeyValues {
  @doc("Gets the properties of the specified key-value.")
  get is ArmResourceRead<KeyValue>;

  @doc("Creates a key-value.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<KeyValue>;

  @doc("Deletes a key-value.")
  delete is ArmResourceDeleteAsync<KeyValue>;

  @doc("Lists the key-values for a given configuration store.")
  listByConfigurationStore is ArmResourceListByParent<
    KeyValue,
    {
      ...BaseParameters<KeyValue>;

      @doc("A skip token is used to continue retrieving items after an operation returns a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls.")
      @query("$skipToken")
      $skipToken?: string;
    }
  >;
}

@@projectedName(KeyValues.createOrUpdate::parameters.resource,
  "json",
  "keyValueParameters"
);
@@extension(KeyValues.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "keyValueParameters"
);
@@doc(KeyValues.createOrUpdate::parameters.resource,
  "The parameters for creating a key-value."
);
