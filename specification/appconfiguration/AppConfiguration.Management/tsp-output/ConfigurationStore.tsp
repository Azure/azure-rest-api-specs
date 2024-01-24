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
/**
 * The configuration store along with all resource properties. The Configuration Store will have all information to begin utilizing it.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(ConfigurationStoreProperties)
@includeInapplicableMetadataInPayload(false)
model ConfigurationStore extends TrackedResourceBase {
  /**
   * The name of the configuration store.
   */
  @maxLength(50)
  @minLength(5)
  @pattern("^[a-zA-Z0-9_-]*$")
  @path
  @key("configStoreName")
  @segment("configurationStores")
  name: string;

  /**
   * The properties of a configuration store.
   */
  @extension("x-ms-client-flatten", true)
  properties?: ConfigurationStoreProperties;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface ConfigurationStores {
  /**
   * Gets the properties of the specified configuration store.
   */
  get is ArmResourceRead<ConfigurationStore>;

  /**
   * Creates a configuration store with the specified parameters.
   */
  create is ArmResourceCreateOrReplaceAsync<ConfigurationStore>;

  /**
   * Updates a configuration store with the specified parameters.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchAsync<
    ConfigurationStore,
    ConfigurationStoreUpdateParameters
  >;

  /**
   * Deletes a configuration store.
   */
  delete is ArmResourceDeleteAsync<ConfigurationStore>;

  /**
   * Lists the configuration stores for a given resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConfigurationStores_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    ConfigurationStore,
    {
      ...BaseParameters<ConfigurationStore>;

      /**
       * A skip token is used to continue retrieving items after an operation returns a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls.
       */
      @query("$skipToken")
      $skipToken?: string;
    }
  >;

  /**
   * Lists the configuration stores for a given subscription.
   */
  list is ArmListBySubscription<ConfigurationStore>;

  /**
   * Lists the access key for the specified configuration store.
   */
  listKeys is ArmResourceActionSync<
    ConfigurationStore,
    void,
    ApiKeyListResult,
    {
      ...BaseParameters<ConfigurationStore>;

      /**
       * A skip token is used to continue retrieving items after an operation returns a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls.
       */
      @query("$skipToken")
      $skipToken?: string;
    }
  >;

  /**
   * Regenerates an access key for the specified configuration store.
   */
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
