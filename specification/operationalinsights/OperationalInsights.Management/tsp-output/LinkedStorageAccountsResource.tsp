import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.OperationalInsights;
@doc("Linked storage accounts top level resource container.")
@parentResource(Workspace)
model LinkedStorageAccountsResource
  is ProxyResource<LinkedStorageAccountsProperties> {
  @doc("Linked storage accounts type.")
  @path
  @key("dataSourceType")
  @segment("linkedStorageAccounts")
  name: DataSourceType;
}

@armResourceOperations
interface LinkedStorageAccounts {
  @doc("Gets all linked storage account of a specific data source type associated with the specified workspace.")
  get is ArmResourceRead<LinkedStorageAccountsResource>;
  @doc("Create or Update a link relation between current workspace and a group of storage accounts of a specific data source type.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<LinkedStorageAccountsResource>;
  @doc("Deletes all linked storage accounts of a specific data source type associated with the specified workspace.")
  delete is ArmResourceDeleteSync<LinkedStorageAccountsResource>;
  @doc("Gets all linked storage accounts associated with the specified workspace, storage accounts will be sorted by their data source type.")
  listByWorkspace is ArmResourceListByParent<LinkedStorageAccountsResource>;
}
