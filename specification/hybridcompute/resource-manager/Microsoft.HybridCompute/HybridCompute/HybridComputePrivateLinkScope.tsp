import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.HybridCompute;
/**
 * An Azure Arc PrivateLinkScope definition.
 */
model HybridComputePrivateLinkScope
  is Azure.ResourceManager.TrackedResource<HybridComputePrivateLinkScopeProperties> {
  ...ResourceNameParameter<
    Resource = HybridComputePrivateLinkScope,
    KeyName = "scopeName",
    SegmentName = "privateLinkScopes",
    NamePattern = "[a-zA-Z0-9-_\\.]+"
  >;
}

@armResourceOperations(#{ omitTags: true })
interface HybridComputePrivateLinkScopes {
  /**
   * Returns a Azure Arc PrivateLinkScope.
   */
  get is ArmResourceRead<HybridComputePrivateLinkScope>;

  /**
   * Creates (or updates) a Azure Arc PrivateLinkScope. Note: You cannot specify a different value for InstrumentationKey nor AppId in the Put operation.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<HybridComputePrivateLinkScope>;

  /**
   * Updates an existing PrivateLinkScope's tags. To update other fields use the CreateOrUpdate method.
   */
  @patch(#{ implicitOptionality: false })
  updateTags is ArmCustomPatchSync<
    HybridComputePrivateLinkScope,
    PatchModel = TagsResource
  >;

  /**
   * Deletes a Azure Arc PrivateLinkScope.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  delete is ArmResourceDeleteWithoutOkAsync<
    HybridComputePrivateLinkScope,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = HybridComputePrivateLinkScope> &
      Azure.Core.Foundations.RetryAfterHeader> | ArmDeletedNoContentResponse
  >;

  /**
   * Gets a list of Azure Arc PrivateLinkScopes within a resource group.
   */
  listByResourceGroup is ArmResourceListByParent<HybridComputePrivateLinkScope>;

  /**
   * Gets a list of all Azure Arc PrivateLinkScopes within a subscription.
   */
  list is ArmListBySubscription<HybridComputePrivateLinkScope>;
}

@@doc(HybridComputePrivateLinkScope.name,
  "The name of the Azure Arc PrivateLinkScope resource."
);
@@doc(HybridComputePrivateLinkScope.properties,
  "Properties that define a Azure Arc PrivateLinkScope resource."
);
@@doc(HybridComputePrivateLinkScopes.createOrUpdate::parameters.resource,
  "Properties that need to be specified to create or update a Azure Arc for Servers and Clusters PrivateLinkScope."
);
@@doc(HybridComputePrivateLinkScopes.updateTags::parameters.properties,
  "Updated tag information to set into the PrivateLinkScope instance."
);
