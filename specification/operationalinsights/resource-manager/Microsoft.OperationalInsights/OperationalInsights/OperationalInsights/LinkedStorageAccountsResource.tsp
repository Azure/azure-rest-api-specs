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

alias LinkedStorageAccountsOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Legacy.Provider;

    /**
     * The name of the workspace.
     */
    @path
    @segment("workspaces")
    @key("workspaceName")
    @minLength(4)
    @maxLength(63)
    @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
    workspaceName: string;
  },
  {
    /**
     * Linked storage accounts type.
     */
    @path
    @segment("linkedStorageAccounts")
    @key("dataSourceType")
    dataSourceType: DataSourceType;
  }
>;

@armResourceOperations(#{ omitTags: true })
interface LinkedStorageAccountsResources {
  /**
   * Gets all linked storage account of a specific data source type associated with the specified workspace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LinkedStorageAccounts_Get")
  @tag("LinkedStorageAccounts")
  get is LinkedStorageAccountsOps.Read<LinkedStorageAccountsResource>;

  /**
   * Create or Update a link relation between current workspace and a group of storage accounts of a specific data source type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("LinkedStorageAccounts_CreateOrUpdate")
  @tag("LinkedStorageAccounts")
  createOrUpdate is LinkedStorageAccountsOps.CreateOrUpdateSync<
    LinkedStorageAccountsResource,
    Response = ArmResourceUpdatedResponse<LinkedStorageAccountsResource>
  >;

  /**
   * Deletes all linked storage accounts of a specific data source type associated with the specified workspace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("LinkedStorageAccounts_Delete")
  @tag("LinkedStorageAccounts")
  delete is LinkedStorageAccountsOps.DeleteSync<
    LinkedStorageAccountsResource,
    Response = ArmDeletedResponse
  >;

  /**
   * Gets all linked storage accounts associated with the specified workspace, storage accounts will be sorted by their data source type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("LinkedStorageAccounts_ListByWorkspace")
  @tag("LinkedStorageAccounts")
  listByWorkspace is LinkedStorageAccountsOps.List<
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
