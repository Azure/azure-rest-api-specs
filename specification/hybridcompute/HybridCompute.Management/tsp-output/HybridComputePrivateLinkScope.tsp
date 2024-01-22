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

namespace Microsoft.HybridCompute;
/**
 * An Azure Arc PrivateLinkScope definition.
 */
model HybridComputePrivateLinkScope
  is TrackedResource<HybridComputePrivateLinkScopeProperties> {
  /**
   * The name of the Azure Arc PrivateLinkScope resource.
   */
  @pattern("[a-zA-Z0-9-_\\.]+")
  @path
  @key("scopeName")
  @segment("privateLinkScopes")
  name: string;
}

@armResourceOperations
interface HybridComputePrivateLinkScopes {
  /**
   * Returns a Azure Arc PrivateLinkScope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateLinkScopes_Get")
  get is ArmResourceRead<HybridComputePrivateLinkScope>;

  /**
   * Creates (or updates) a Azure Arc PrivateLinkScope. Note: You cannot specify a different value for InstrumentationKey nor AppId in the Put operation.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateLinkScopes_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<HybridComputePrivateLinkScope>;

  /**
   * Updates an existing PrivateLinkScope's tags. To update other fields use the CreateOrUpdate method.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("PrivateLinkScopes_UpdateTags")
  updateTags is ArmCustomPatchSync<HybridComputePrivateLinkScope, TagsResource>;

  /**
   * Deletes a Azure Arc PrivateLinkScope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateLinkScopes_Delete")
  delete is ArmResourceDeleteAsync<HybridComputePrivateLinkScope>;

  /**
   * Gets a list of Azure Arc PrivateLinkScopes within a resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateLinkScopes_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<HybridComputePrivateLinkScope>;

  /**
   * Gets a list of all Azure Arc PrivateLinkScopes within a subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateLinkScopes_List")
  list is ArmListBySubscription<HybridComputePrivateLinkScope>;
}

@@projectedName(HybridComputePrivateLinkScopes.createOrUpdate::parameters.resource,
  "json",
  "parameters"
);
@@extension(HybridComputePrivateLinkScopes.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "parameters"
);
@@doc(HybridComputePrivateLinkScopes.createOrUpdate::parameters.resource,
  "Properties that need to be specified to create or update a Azure Arc for Servers and Clusters PrivateLinkScope."
);
@@projectedName(HybridComputePrivateLinkScopes.updateTags::parameters.properties,
  "json",
  "PrivateLinkScopeTags"
);
@@extension(HybridComputePrivateLinkScopes.updateTags::parameters.properties,
  "x-ms-client-name",
  "PrivateLinkScopeTags"
);
@@doc(HybridComputePrivateLinkScopes.updateTags::parameters.properties,
  "Updated tag information to set into the PrivateLinkScope instance."
);
