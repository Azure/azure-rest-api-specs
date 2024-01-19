import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OperationalInsights;
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
interface LinkedStorageAccountsResources {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets all linked storage account of a specific data source type associated with the specified workspace.")
  @operationId("LinkedStorageAccounts_Get")
  get is ArmResourceRead<LinkedStorageAccountsResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Create or Update a link relation between current workspace and a group of storage accounts of a specific data source type.")
  @operationId("LinkedStorageAccounts_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<LinkedStorageAccountsResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes all linked storage accounts of a specific data source type associated with the specified workspace.")
  @operationId("LinkedStorageAccounts_Delete")
  delete is ArmResourceDeleteSync<LinkedStorageAccountsResource>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets all linked storage accounts associated with the specified workspace, storage accounts will be sorted by their data source type.")
  @operationId("LinkedStorageAccounts_ListByWorkspace")
  listByWorkspace is ArmResourceListByParent<LinkedStorageAccountsResource>;
}

@@projectedName(LinkedStorageAccountsResources.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(LinkedStorageAccountsResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(LinkedStorageAccountsResources.createOrUpdate::parameters.resource,
  "The parameters required to create or update linked storage accounts."
);
