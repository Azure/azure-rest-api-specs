import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./AzureMonitorPrivateLinkScope.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Insights;
/**
 * A private link scoped resource
 */
@parentResource(AzureMonitorPrivateLinkScope)
model ScopedResource
  is Azure.ResourceManager.ProxyResource<ScopedResourceProperties> {
  ...ResourceNameParameter<
    Resource = ScopedResource,
    KeyName = "name",
    SegmentName = "scopedResources",
    NamePattern = ""
  >;
}

@armResourceOperations(#{ omitTags: true })
interface ScopedResources {
  /**
   * Gets a scoped resource in a private link scope.
   */
  @tag("PrivateLinkScopedResources")
  get is ArmResourceRead<ScopedResource>;

  /**
   * Add an Azure monitor scoped resource in the private link scope.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("PrivateLinkScopedResources")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    ScopedResource,
    Response = ArmResourceUpdatedResponse<ScopedResource> | ArmResourceCreatedResponse<
      ScopedResource,
      ArmLroLocationHeader<FinalResult = ScopedResource> &
        Azure.Core.Foundations.RetryAfterHeader
    > | ArmAcceptedLroResponse
  >;

  /**
   * Deletes an Azure monitor scoped resource with a given name.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("PrivateLinkScopedResources")
  delete is ArmResourceDeleteWithoutOkAsync<
    ScopedResource,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Gets all scoped resources on a private link scope.
   */
  @tag("PrivateLinkScopedResources")
  listByPrivateLinkScope is ArmResourceListByParent<
    ScopedResource,
    Parameters = {
      /**
       * The kind of the private link resource. Not specifying a kind will return scoped resources of all kinds.
       */
      @query("kind")
      kind?: string;
    }
  >;
}

@@doc(ScopedResource.name, "The name of the scoped resource object.");
@@doc(ScopedResource.properties, "Resource properties.");
@@doc(ScopedResources.createOrUpdate::parameters.resource, "");
