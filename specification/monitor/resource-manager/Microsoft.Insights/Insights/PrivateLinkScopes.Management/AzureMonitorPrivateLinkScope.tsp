import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Insights;
/**
 * An Azure Monitor PrivateLinkScope definition.
 */
model AzureMonitorPrivateLinkScope
  is Azure.ResourceManager.TrackedResource<
    AzureMonitorPrivateLinkScopeProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = AzureMonitorPrivateLinkScope,
    KeyName = "scopeName",
    SegmentName = "privateLinkScopes",
    NamePattern = ""
  >;
}

@armResourceOperations(#{ omitTags: true })
interface AzureMonitorPrivateLinkScopes {
  /**
   * Returns a Azure Monitor PrivateLinkScope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateLinkScopes_Get")
  get is ArmResourceRead<AzureMonitorPrivateLinkScope>;

  /**
   * Creates (or updates) a Azure Monitor PrivateLinkScope. Note: You cannot specify a different value for InstrumentationKey nor AppId in the Put operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateLinkScopes_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AzureMonitorPrivateLinkScope>;

  /**
   * Updates an existing PrivateLinkScope's tags. To update other fields use the CreateOrUpdate method.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateLinkScopes_UpdateTags")
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    AzureMonitorPrivateLinkScope,
    PatchModel = TagsResource
  >;

  /**
   * Deletes a Azure Monitor PrivateLinkScope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateLinkScopes_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<AzureMonitorPrivateLinkScope>;

  /**
   * Gets a list of Azure Monitor PrivateLinkScopes within a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateLinkScopes_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<AzureMonitorPrivateLinkScope>;

  /**
   * Gets a list of all Azure Monitor PrivateLinkScopes within a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateLinkScopes_List")
  list is ArmListBySubscription<AzureMonitorPrivateLinkScope>;
}

@@doc(AzureMonitorPrivateLinkScope.name,
  "The name of the Azure Monitor PrivateLinkScope resource."
);
@@doc(AzureMonitorPrivateLinkScope.properties,
  "Properties that define a Azure Monitor PrivateLinkScope resource."
);
@@doc(AzureMonitorPrivateLinkScopes.createOrUpdate::parameters.resource,
  "Properties that need to be specified to create or update a Azure Monitor PrivateLinkScope."
);
@@doc(AzureMonitorPrivateLinkScopes.updateTags::parameters.properties,
  "Updated tag information to set into the PrivateLinkScope instance."
);
