import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";
import "./SearchService.tsp";

using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Search;

/**
 * Describes a linked service connection managed by the Azure AI Search service.
 */
@added(Versions.v2026_09_01_preview)
@parentResource(SearchService)
model LinkedService is Azure.ResourceManager.ProxyResource<LinkedServiceProperties> {
  ...ResourceNameParameter<
    Resource = LinkedService,
    KeyName = "connectionName",
    SegmentName = "linkedServices",
    NamePattern = ""
  >;
}

@added(Versions.v2026_09_01_preview)
@armResourceOperations
interface LinkedServices {
  /**
   * Gets the details of a linked service connection managed by the search service in the given resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://aka.ms/search-manage")
  get is ArmResourceRead<
    LinkedService,
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
   * Creates or updates a linked service connection managed by the search service in the given resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://aka.ms/search-manage")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    LinkedService,
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
    Response = ArmResourceCreatedResponse<LinkedService> | ArmResourceUpdatedResponse<LinkedService>,
    Error = CloudError
  >;

  /**
   * Initiates the deletion of the linked service connection from the search service.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://aka.ms/search-manage")
  delete is ArmResourceDeleteWithoutOkAsync<
    LinkedService,
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
    Response =
      | ArmAcceptedLroResponse<LroHeaders = ArmAsyncOperationHeader<FinalResult = void> &
          Azure.Core.Foundations.RetryAfterHeader>
      | NoContentResponse,
    Error = CloudError
  >;

  /**
   * Gets a list of all linked service connections managed by the given service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://aka.ms/search-manage")
  listByService is ArmResourceListByParent<
    LinkedService,
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
    Response = LinkedServiceListResult,
    Error = CloudError
  >;
}

@@doc(
  LinkedService.name,
  "The name of the linked service connection managed by the Azure AI Search service within the specified resource group."
);
@@doc(
  LinkedService.properties,
  "Describes the properties of a linked service connection managed by the Azure AI Search service."
);
@@doc(
  LinkedServices.createOrUpdate::parameters.resource,
  "The definition of the linked service connection to create or update."
);
