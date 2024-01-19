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

namespace Microsoft.AppConfiguration;
@doc("The configuration store along with all resource properties. The Configuration Store will have all information to begin utilizing it.")
model ConfigurationStore is TrackedResource<ConfigurationStoreProperties> {
  @doc("The name of the configuration store.")
  @maxLength(50)
  @minLength(5)
  @pattern("^[a-zA-Z0-9_-]*$")
  @path
  @key("configStoreName")
  @segment("configurationStores")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface ConfigurationStores {
  @doc("Gets the properties of the specified configuration store.")
  get is ArmResourceRead<ConfigurationStore>;

  @doc("Creates a configuration store with the specified parameters.")
  create is ArmResourceCreateOrUpdateAsync<ConfigurationStore>;

  @doc("Updates a configuration store with the specified parameters.")
  update is ArmCustomPatchAsync<
    ConfigurationStore,
    ConfigurationStoreUpdateParameters
  >;

  @doc("Deletes a configuration store.")
  delete is ArmResourceDeleteAsync<ConfigurationStore>;

  @doc("Lists the configuration stores for a given resource group.")
  listByResourceGroup is ArmResourceListByParent<
    ConfigurationStore,
    {
      ...BaseParameters<ConfigurationStore>;

      @doc("A skip token is used to continue retrieving items after an operation returns a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls.")
      @query("$skipToken")
      $skipToken?: string;
    }
  >;

  @doc("Lists the configuration stores for a given subscription.")
  list is ArmListBySubscription<ConfigurationStore>;

  @doc("Lists the access key for the specified configuration store.")
  listKeys is ArmResourceActionSync<
    ConfigurationStore,
    void,
    ApiKeyListResult,
    {
      ...BaseParameters<ConfigurationStore>;

      @doc("A skip token is used to continue retrieving items after an operation returns a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls.")
      @query("$skipToken")
      $skipToken?: string;
    }
  >;

  @doc("Regenerates an access key for the specified configuration store.")
  regenerateKey is ArmResourceActionSync<
    ConfigurationStore,
    RegenerateKeyParameters,
    ApiKey
  >;
}

@@projectedName(ConfigurationStores.create::parameters.resource,
  "json",
  "configStoreCreationParameters"
);
@@extension(ConfigurationStores.create::parameters.resource,
  "x-ms-client-name",
  "configStoreCreationParameters"
);
@@doc(ConfigurationStores.create::parameters.resource,
  "The parameters for creating a configuration store."
);
@@projectedName(ConfigurationStores.update::parameters.properties,
  "json",
  "configStoreUpdateParameters"
);
@@extension(ConfigurationStores.update::parameters.properties,
  "x-ms-client-name",
  "configStoreUpdateParameters"
);
@@doc(ConfigurationStores.update::parameters.properties,
  "The parameters for updating a configuration store."
);
@@projectedName(ConfigurationStores.regenerateKey::parameters.body,
  "json",
  "regenerateKeyParameters"
);
@@extension(ConfigurationStores.regenerateKey::parameters.body,
  "x-ms-client-name",
  "regenerateKeyParameters"
);
@@doc(ConfigurationStores.regenerateKey::parameters.body,
  "The parameters for regenerating an access key."
);
