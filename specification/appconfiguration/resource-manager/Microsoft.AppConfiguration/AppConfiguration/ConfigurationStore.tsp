import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AppConfiguration;
/**
 * The configuration store along with all resource properties. The Configuration Store will have all information to begin utilizing it.
 */
model ConfigurationStore
  is Azure.ResourceManager.TrackedResource<ConfigurationStoreProperties> {
  ...ResourceNameParameter<
    Resource = ConfigurationStore,
    KeyName = "configStoreName",
    SegmentName = "configurationStores",
    NamePattern = "^[a-zA-Z0-9_-]*$"
  >;

  /**
   * The managed identity information, if configured.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: ResourceIdentity;

  /**
   * The sku of the configuration store.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku: Sku;
}

alias ConfigurationStoresDeleteLroHeader = {
  ...ArmCombinedLroHeaders;
  ...Azure.Core.Foundations.RetryAfterHeader;
};

@armResourceOperations
interface ConfigurationStores {
  /**
   * Gets the properties of the specified configuration store.
   */
  get is ArmResourceRead<ConfigurationStore>;

  /**
   * Creates a configuration store with the specified parameters.
   */
  create is ArmResourceCreateOrReplaceAsync<
    ConfigurationStore,
    LroHeaders = ArmLroLocationHeader<FinalResult = ConfigurationStore> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates a configuration store with the specified parameters.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    ConfigurationStore,
    PatchModel = ConfigurationStoreUpdateParameters,
    Response = ArmResponse<ConfigurationStore> | ArmResourceCreatedResponse<
      ConfigurationStore,
      LroHeaders = ArmLroLocationHeader<FinalResult = ConfigurationStore> &
        Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * Deletes a configuration store.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is ArmResourceDeleteWithoutOkAsync<
    ConfigurationStore,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<LroHeaders = ConfigurationStoresDeleteLroHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Lists the configuration stores for a given resource group.
   */
  listByResourceGroup is ArmResourceListByParent<
    ConfigurationStore,
    Parameters = {
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
  list is ArmListBySubscription<
    ConfigurationStore,
    Parameters = {
      /**
       * A skip token is used to continue retrieving items after an operation returns a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skipToken parameter that specifies a starting point to use for subsequent calls.
       */
      @query("$skipToken")
      $skipToken?: string;
    }
  >;

  /**
   * Lists the access key for the specified configuration store.
   */
  @list
  listKeys is ArmResourceActionSync<
    ConfigurationStore,
    void,
    ArmResponse<ApiKeyListResult>,
    Parameters = {
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
    ArmResponse<ApiKey>
  >;
}

@@maxLength(ConfigurationStore.name, 50);
@@minLength(ConfigurationStore.name, 5);
@@doc(ConfigurationStore.name, "The name of the configuration store.");
@@doc(ConfigurationStore.properties,
  "The properties of a configuration store."
);
@@doc(ConfigurationStores.create::parameters.resource,
  "The parameters for creating a configuration store."
);
@@doc(ConfigurationStores.update::parameters.properties,
  "The parameters for updating a configuration store."
);
@@doc(ConfigurationStores.regenerateKey::parameters.body,
  "The parameters for regenerating an access key."
);
@@doc(ConfigurationStoresDeleteLroHeader.location,
  "URL to query for the operation result"
);
@@doc(ConfigurationStoresDeleteLroHeader.azureAsyncOperation,
  "URL to query for status of the operation."
);
