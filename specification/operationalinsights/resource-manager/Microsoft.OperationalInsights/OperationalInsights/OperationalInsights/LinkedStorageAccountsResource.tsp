import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Workspace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.OperationalInsights;
/**
 * Linked storage accounts top level resource container.
 */
@parentResource(Workspace)
model LinkedStorageAccountsResource
  is Azure.ResourceManager.ProxyResource<
    LinkedStorageAccountsProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = LinkedStorageAccountsResource,
    KeyName = "dataSourceType",
    SegmentName = "linkedStorageAccounts",
    NamePattern = ""
  >;
}

@armResourceOperations
interface LinkedStorageAccountsResources {
  /**
   * Gets all linked storage account of a specific data source type associated with the specified workspace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LinkedStorageAccounts_Get")
  get is ArmResourceRead<LinkedStorageAccountsResource>;

  /**
   * Create or Update a link relation between current workspace and a group of storage accounts of a specific data source type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("LinkedStorageAccounts_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    LinkedStorageAccountsResource,
    Response = ArmResourceUpdatedResponse<LinkedStorageAccountsResource>
  >;

  /**
   * Deletes all linked storage accounts of a specific data source type associated with the specified workspace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("LinkedStorageAccounts_Delete")
  delete is ArmResourceDeleteSync<
    LinkedStorageAccountsResource,
    Response = ArmDeletedResponse
  >;

  /**
   * Gets all linked storage accounts associated with the specified workspace, storage accounts will be sorted by their data source type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LinkedStorageAccounts_ListByWorkspace")
  listByWorkspace is ArmResourceListByParent<
    LinkedStorageAccountsResource,
    Response = ArmResponse<LinkedStorageAccountsListResult>
  >;
}

@@doc(LinkedStorageAccountsResource.name, "Linked storage accounts type.");
@@doc(LinkedStorageAccountsResource.properties,
  "Linked storage accounts properties."
);
@@doc(LinkedStorageAccountsResources.createOrUpdate::parameters.resource,
  "The parameters required to create or update linked storage accounts."
);
