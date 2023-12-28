import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./ApplicationInsightsComponent.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.ApplicationInsights;
@doc("An Application Insights component linked storage accounts")
@parentResource(ApplicationInsightsComponent)
model ComponentLinkedStorageAccounts
  is ProxyResource<LinkedStorageAccountsProperties> {
  @doc("The type of the Application Insights component data source for the linked storage account.")
  @key("storageType")
  @segment("linkedStorageAccounts")
  name: StorageType;
}

@armResourceOperations
interface ComponentLinkedStorageAccounts {
  @doc("Returns the current linked storage settings for an Application Insights component.")
  get is ArmResourceRead<ComponentLinkedStorageAccounts>;
  @doc("Replace current linked storage account for an Application Insights component.")
  createAndUpdate is ArmResourceCreateOrReplaceSync<ComponentLinkedStorageAccounts>;
  @doc("Update linked storage accounts for an Application Insights component.")
  update is ArmCustomPatchSync<
    ComponentLinkedStorageAccounts,
    ComponentLinkedStorageAccountsPatch
  >;
  @doc("Delete linked storage accounts for an Application Insights component.")
  delete is ArmResourceDeleteSync<ComponentLinkedStorageAccounts>;
}
