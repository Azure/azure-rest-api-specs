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

namespace Microsoft.Insights;
/**
 * An Azure Monitor PrivateLinkScope definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(
  AzureMonitorPrivateLinkScopeProperties
)
model AzureMonitorPrivateLinkScope extends TrackedResourceBase {
  /**
   * The name of the Azure Monitor PrivateLinkScope resource.
   */
  @path
  @key("scopeName")
  @segment("privateLinkScopes")
  @visibility("read")
  name: string;

  /**
   * Properties that define a Azure Monitor PrivateLinkScope resource.
   */
  @extension("x-ms-client-flatten", true)
  properties: AzureMonitorPrivateLinkScopeProperties;
}

@armResourceOperations
interface AzureMonitorPrivateLinkScopes {
  /**
   * Returns a Azure Monitor PrivateLinkScope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateLinkScopes_Get")
  get is ArmResourceRead<AzureMonitorPrivateLinkScope>;

  /**
   * Creates (or updates) a Azure Monitor PrivateLinkScope. Note: You cannot specify a different value for InstrumentationKey nor AppId in the Put operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateLinkScopes_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<AzureMonitorPrivateLinkScope>;

  /**
   * Updates an existing PrivateLinkScope's tags. To update other fields use the CreateOrUpdate method.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("PrivateLinkScopes_UpdateTags")
  updateTags is ArmCustomPatchSync<AzureMonitorPrivateLinkScope, TagsResource>;

  /**
   * Deletes a Azure Monitor PrivateLinkScope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateLinkScopes_Delete")
  delete is ArmResourceDeleteAsync<AzureMonitorPrivateLinkScope>;

  /**
   * Gets a list of Azure Monitor PrivateLinkScopes within a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateLinkScopes_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<AzureMonitorPrivateLinkScope>;

  /**
   * Gets a list of all Azure Monitor PrivateLinkScopes within a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateLinkScopes_List")
  list is ArmListBySubscription<AzureMonitorPrivateLinkScope>;
}

@@projectedName(AzureMonitorPrivateLinkScopes.createOrUpdate::parameters.resource,
  "json",
  "AzureMonitorPrivateLinkScopePayload"
);
@@extension(AzureMonitorPrivateLinkScopes.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "AzureMonitorPrivateLinkScopePayload"
);
@@doc(AzureMonitorPrivateLinkScopes.createOrUpdate::parameters.resource,
  "Properties that need to be specified to create or update a Azure Monitor PrivateLinkScope."
);
@@projectedName(AzureMonitorPrivateLinkScopes.updateTags::parameters.properties,
  "json",
  "PrivateLinkScopeTags"
);
@@extension(AzureMonitorPrivateLinkScopes.updateTags::parameters.properties,
  "x-ms-client-name",
  "PrivateLinkScopeTags"
);
@@doc(AzureMonitorPrivateLinkScopes.updateTags::parameters.properties,
  "Updated tag information to set into the PrivateLinkScope instance."
);
