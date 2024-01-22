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
 * Deleted configuration store information with extended details.
 */
@locationResource
model DeletedConfigurationStore
  is ProxyResource<DeletedConfigurationStoreProperties> {
  /**
   * The name of the configuration store.
   */
  @maxLength(50)
  @minLength(5)
  @pattern("^[a-zA-Z0-9_-]*$")
  @path
  @key("configStoreName")
  @segment("deletedConfigurationStores")
  name: string;
}

@armResourceOperations
interface DeletedConfigurationStores {
  /**
   * Gets a deleted Azure app configuration store.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConfigurationStores_GetDeleted")
  getDeleted is ArmResourceRead<DeletedConfigurationStore>;

  /**
   * Gets information about the deleted configuration stores in a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConfigurationStores_ListDeleted")
  listDeleted is ArmResourceListByParent<DeletedConfigurationStore>;

  /**
   * Permanently deletes the specified configuration store.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("ConfigurationStores_PurgeDeleted")
  purgeDeleted is ArmResourceActionAsync<DeletedConfigurationStore, void, void>;
}
