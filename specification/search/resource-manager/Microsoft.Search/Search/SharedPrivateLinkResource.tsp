import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./SearchService.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Search;
/**
 * Describes a shared private link resource managed by the Azure AI Search service.
 */
@parentResource(SearchService)
model SharedPrivateLinkResource
  is Azure.ResourceManager.ProxyResource<SharedPrivateLinkResourceProperties> {
  ...ResourceNameParameter<
    Resource = SharedPrivateLinkResource,
    KeyName = "sharedPrivateLinkResourceName",
    SegmentName = "sharedPrivateLinkResources",
    NamePattern = ""
  >;
}

@armResourceOperations
interface SharedPrivateLinkResources {
  /**
   * Gets the details of the shared private link resource managed by the search service in the given resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://aka.ms/search-manage")
  get is ArmResourceRead<
    SharedPrivateLinkResource,
    Parameters = {
      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @format("uuid")
      @header("x-ms-client-request-id")
      @OpenAPI.extension(
        "x-ms-parameter-grouping",
        #{ name: "search-management-request-options" }
      )
      @OpenAPI.extension("x-ms-client-request-id", true)
      clientRequestId?: string;
    },
    Error = CloudError
  >;

  /**
   * Initiates the creation or update of a shared private link resource managed by the search service in the given resource group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://aka.ms/search-manage")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    SharedPrivateLinkResource,
    Parameters = {
      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @format("uuid")
      @header("x-ms-client-request-id")
      @OpenAPI.extension(
        "x-ms-parameter-grouping",
        #{ name: "search-management-request-options" }
      )
      @OpenAPI.extension("x-ms-client-request-id", true)
      clientRequestId?: string;
    },
    Response = ArmResourceUpdatedResponse<SharedPrivateLinkResource> | ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = SharedPrivateLinkResource>>,
    Error = CloudError
  >;

  /**
   * Initiates the deletion of the shared private link resource from the search service.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://aka.ms/search-manage")
  delete is ArmResourceDeleteWithoutOkAsync<
    SharedPrivateLinkResource,
    Parameters = {
      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @format("uuid")
      @header("x-ms-client-request-id")
      @OpenAPI.extension(
        "x-ms-parameter-grouping",
        #{ name: "search-management-request-options" }
      )
      @OpenAPI.extension("x-ms-client-request-id", true)
      clientRequestId?: string;
    },
    Response = ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader> | NoContentResponse | NotFoundResponse,
    Error = CloudError
  >;

  /**
   * Gets a list of all shared private link resources managed by the given service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://aka.ms/search-manage")
  listByService is ArmResourceListByParent<
    SharedPrivateLinkResource,
    Parameters = {
      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @format("uuid")
      @header("x-ms-client-request-id")
      @OpenAPI.extension(
        "x-ms-parameter-grouping",
        #{ name: "search-management-request-options" }
      )
      @OpenAPI.extension("x-ms-client-request-id", true)
      clientRequestId?: string;
    },
    Response = SharedPrivateLinkResourceListResult,
    Error = CloudError
  >;
}

@@doc(SharedPrivateLinkResource.name,
  "The name of the shared private link resource managed by the Azure AI Search service within the specified resource group."
);
@@doc(SharedPrivateLinkResource.properties,
  "Describes the properties of a shared private link resource managed by the Azure AI Search service."
);
@@doc(SharedPrivateLinkResources.createOrUpdate::parameters.resource,
  "The definition of the shared private link resource to create or update."
);
