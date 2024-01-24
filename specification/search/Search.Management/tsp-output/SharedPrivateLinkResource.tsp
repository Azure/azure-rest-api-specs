import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SearchService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Search;
/**
 * Describes a Shared Private Link Resource managed by the Azure Cognitive Search service.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@parentResource(SearchService)
@Azure.ResourceManager.Private.armResourceInternal(
  SharedPrivateLinkResourceProperties
)
@includeInapplicableMetadataInPayload(false)
model SharedPrivateLinkResource extends ProxyResourceBase {
  /**
   * The name of the shared private link resource managed by the Azure Cognitive Search service within the specified resource group.
   */
  @path
  @key("sharedPrivateLinkResourceName")
  @segment("sharedPrivateLinkResources")
  name: string;

  /**
   * Describes the properties of a Shared Private Link Resource managed by the Azure Cognitive Search service.
   */
  @extension("x-ms-client-flatten", true)
  properties?: SharedPrivateLinkResourceProperties;
}

@armResourceOperations
interface SharedPrivateLinkResources {
  /**
   * Gets the details of the shared private link resource managed by the search service in the given resource group.
   */
  get is ArmResourceRead<
    SharedPrivateLinkResource,
    {
      ...BaseParameters<SharedPrivateLinkResource>;

      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      @header
      clientRequestId?: string;
    }
  >;

  /**
   * Initiates the creation or update of a shared private link resource managed by the search service in the given resource group.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    SharedPrivateLinkResource,
    {
      ...BaseParameters<SharedPrivateLinkResource>;

      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      @header
      clientRequestId?: string;
    },
    ArmAsyncOperationHeader
  >;

  /**
   * Initiates the deletion of the shared private link resource from the search service.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    SharedPrivateLinkResource,
    {
      ...BaseParameters<SharedPrivateLinkResource>;

      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      @header
      clientRequestId?: string;
    },
    ArmAsyncOperationHeader
  >;

  /**
   * Gets a list of all shared private link resources managed by the given service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("SharedPrivateLinkResources_ListByService")
  listByService is ArmResourceListByParent<
    SharedPrivateLinkResource,
    {
      ...BaseParameters<SharedPrivateLinkResource>;

      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      @header
      clientRequestId?: string;
    }
  >;
}

@@projectedName(SharedPrivateLinkResources.createOrUpdate::parameters.resource,
  "json",
  "sharedPrivateLinkResource"
);
@@extension(SharedPrivateLinkResources.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "sharedPrivateLinkResource"
);
@@doc(SharedPrivateLinkResources.createOrUpdate::parameters.resource,
  "The definition of the shared private link resource to create or update."
);
