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
 * Deleted configuration store information with extended details.
 */
@subscriptionResource
model DeletedConfigurationStore
  is Azure.ResourceManager.ProxyResource<DeletedConfigurationStoreProperties> {
  ...ResourceNameParameter<
    Resource = DeletedConfigurationStore,
    KeyName = "configStoreName",
    SegmentName = "deletedConfigurationStores",
    NamePattern = "^[a-zA-Z0-9_-]*$"
  >;
}

@armResourceOperations
interface DeletedConfigurationStores {
  /**
   * Gets a deleted Azure app configuration store.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConfigurationStores_GetDeleted")
  getDeleted is ArmResourceRead<
    DeletedConfigurationStore,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;

  /**
   * Permanently deletes the specified configuration store.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ConfigurationStores_PurgeDeleted")
  @action("purge")
  purgeDeleted is ArmResourceActionAsync<
    DeletedConfigurationStore,
    void,
    OkResponse | NoContentResponse,
    BaseParameters = Azure.ResourceManager.Foundations.SubscriptionBaseParameters
  >;
}

@@maxLength(DeletedConfigurationStore.name, 50);
@@minLength(DeletedConfigurationStore.name, 5);
@@doc(DeletedConfigurationStore.name, "The name of the configuration store.");
@@doc(DeletedConfigurationStore.properties,
  "Properties of the deleted configuration store"
);
