import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./ApplicationInsightsComponent.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Insights;
/**
 * An Application Insights component linked storage accounts
 */
@parentResource(ApplicationInsightsComponent)
model ComponentLinkedStorageAccounts
  is ProxyResource<LinkedStorageAccountsProperties> {
  /**
   * The type of the Application Insights component data source for the linked storage account.
   */
  @path
  @key("storageType")
  @segment("linkedStorageAccounts")
  name: StorageType;
}

@armResourceOperations
@projectedName("client", "ComponentLinkedStorageAccounts")
interface ComponentLinkedStorageAccountsOperationGroup {
  /**
   * Returns the current linked storage settings for an Application Insights component.
   */
  get is ArmResourceRead<ComponentLinkedStorageAccounts>;

  /**
   * Replace current linked storage account for an Application Insights component.
   */
  createAndUpdate is ArmResourceCreateOrReplaceSync<ComponentLinkedStorageAccounts>;

  /**
   * Update linked storage accounts for an Application Insights component.
   */
  @parameterVisibility("read")
  update is ArmCustomPatchSync<
    ComponentLinkedStorageAccounts,
    ComponentLinkedStorageAccountsPatch
  >;

  /**
   * Delete linked storage accounts for an Application Insights component.
   */
  delete is ArmResourceDeleteSync<ComponentLinkedStorageAccounts>;
}

@@projectedName(ComponentLinkedStorageAccountsOperationGroup.createAndUpdate::parameters.resource,
  "json",
  "LinkedStorageAccountsProperties"
);
@@extension(ComponentLinkedStorageAccountsOperationGroup.createAndUpdate::parameters.resource,
  "x-ms-client-name",
  "LinkedStorageAccountsProperties"
);
@@doc(ComponentLinkedStorageAccountsOperationGroup.createAndUpdate::parameters.resource,
  "Properties that need to be specified to update linked storage accounts for an Application Insights component."
);
@@projectedName(ComponentLinkedStorageAccountsOperationGroup.update::parameters.properties,
  "json",
  "LinkedStorageAccountsProperties"
);
@@extension(ComponentLinkedStorageAccountsOperationGroup.update::parameters.properties,
  "x-ms-client-name",
  "LinkedStorageAccountsProperties"
);
@@doc(ComponentLinkedStorageAccountsOperationGroup.update::parameters.properties,
  "Properties that need to be specified to update a linked storage accounts for an Application Insights component."
);
