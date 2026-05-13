import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

using ApplicationInsightsCommonTypes;

namespace ComponentLinkedStorageAccountApi;
/**
 * An Application Insights component linked storage accounts
 */
model ComponentLinkedStorageAccounts
  is Azure.ResourceManager.ProxyResource<LinkedStorageAccountsProperties> {
  ...ResourceNameParameter<
    Resource = ComponentLinkedStorageAccounts,
    KeyName = "storageType",
    SegmentName = "linkedStorageAccounts",
    NamePattern = "",
    Type = StorageType
  >;
}

alias ComponentLinkedStorageAccountsOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** The name of the Application Insights component resource. */
    @segment("components")
    @key
    @path
    resourceName: string;
  },
  {
    /** The type of the Application Insights component data source for the linked storage account. */
    @segment("linkedStorageAccounts")
    @key
    @path
    storageType: StorageType;
  },
  ErrorType = ErrorResponseLinkedStorage
>;

@armResourceOperations(#{ omitTags: true })
interface ComponentLinkedStorageAccountsOperationGroup {
  /**
   * Returns the current linked storage settings for an Application Insights component.
   */
  get is ComponentLinkedStorageAccountsOps.Read<ComponentLinkedStorageAccounts>;

  /**
   * Replace current linked storage account for an Application Insights component.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createAndUpdate is ComponentLinkedStorageAccountsOps.CreateOrUpdateAsync<
    ComponentLinkedStorageAccounts,
    Response = ArmResourceUpdatedResponse<ComponentLinkedStorageAccounts>
  >;

  /**
   * Update linked storage accounts for an Application Insights component.
   */
  @patch(#{ implicitOptionality: false })
  update is ComponentLinkedStorageAccountsOps.CustomPatchSync<
    ComponentLinkedStorageAccounts,
    PatchModel = ComponentLinkedStorageAccountsPatch
  >;

  /**
   * Delete linked storage accounts for an Application Insights component.
   */
  delete is ComponentLinkedStorageAccountsOps.DeleteSync<ComponentLinkedStorageAccounts>;
}

@@doc(ComponentLinkedStorageAccounts.name,
  "The type of the Application Insights component data source for the linked storage account."
);
@@doc(ComponentLinkedStorageAccounts.properties,
  "The properties of the linked storage accounts."
);
@@doc(ComponentLinkedStorageAccountsOperationGroup.createAndUpdate::parameters.resource,
  "Properties that need to be specified to update linked storage accounts for an Application Insights component."
);
@@doc(ComponentLinkedStorageAccountsOperationGroup.update::parameters.properties,
  "Properties that need to be specified to update a linked storage accounts for an Application Insights component."
);
