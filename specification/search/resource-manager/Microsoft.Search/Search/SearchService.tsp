import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Search;
/**
 * Describes an Azure AI Search service and its current state.
 */
model SearchService
  is Azure.ResourceManager.TrackedResource<SearchServiceProperties> {
  ...ResourceNameParameter<
    Resource = SearchService,
    KeyName = "searchServiceName",
    SegmentName = "searchServices",
    NamePattern = "^(?=.{2,60}$)[a-z0-9][a-z0-9]+(-[a-z0-9]+)*$"
  >;

  /**
   * The SKU of the search service, which determines price tier and capacity limits. This property is required when creating a new search service.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://azure.microsoft.com/documentation/articles/search-sku-tier/")
  sku?: Sku;

  /**
   * The identity of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: Identity;
}

alias AdminKeysParentParameters = {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ResourceGroupParameter;

  /** The name of the Azure AI Search service associated with the specified resource group. */
  @path
  @segment("searchServices")
  @key
  @pattern("^(?=.{2,60}$)[a-z0-9][a-z0-9]+(-[a-z0-9]+)*$")
  searchServiceName: string;
};

alias AdminKeysParameters = {
  /**
   * Specifies which key to regenerate. Valid values include 'primary' and 'secondary'.
   */
  @path
  @segment("regenerateAdminKey")
  keyKind: AdminKeyKind;
};

alias AdminKeysOps = Azure.ResourceManager.Legacy.RoutedOperations<
  AdminKeysParentParameters,
  AdminKeysParameters,
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Search/searchServices/{searchServiceName}/regenerateAdminKey",
  }
>;

alias QueryKeysParentParameters = {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ResourceGroupParameter;

  /** The name of the Azure AI Search service associated with the specified resource group. */
  @path
  @segment("searchServices")
  @key
  @pattern("^(?=.{2,60}$)[a-z0-9][a-z0-9]+(-[a-z0-9]+)*$")
  searchServiceName: string;
};

alias QueryKeysParameters = {
  /**
   * The name of the new query API key.
   */
  @path
  name: string;
};

alias QueryKeysOps = Azure.ResourceManager.Legacy.RoutedOperations<
  QueryKeysParentParameters,
  QueryKeysParameters,
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/microsoft.Search/searchServices/{searchServiceName}/createQueryKey",
  }
>;

alias QueryKeysDeleteParentParameters = {
  ...ApiVersionParameter;
  ...SubscriptionIdParameter;
  ...ResourceGroupParameter;

  /** The name of the Azure AI Search service associated with the specified resource group. */
  @path
  @segment("searchServices")
  @key
  @pattern("^(?=.{2,60}$)[a-z0-9][a-z0-9]+(-[a-z0-9]+)*$")
  searchServiceName: string;
};

alias QueryKeysDeleteParameters = {
  /**
   * The query key to be deleted. Query keys are identified by value, not by name.
   */
  @path
  key: string;
};

alias QueryKeysDeleteOps = Azure.ResourceManager.Legacy.RoutedOperations<
  QueryKeysDeleteParentParameters,
  QueryKeysDeleteParameters,
  ResourceRoute = #{
    route: "/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Search/searchServices/{searchServiceName}/deleteQueryKey/",
  }
>;

@armResourceOperations(#{ allowStaticRoutes: true })
interface SearchServices {
  /**
   * Gets the search service with the given name in the given resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://aka.ms/search-manage")
  get is ArmResourceRead<
    SearchService,
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
   * Creates or updates a search service in the given resource group. If the search service already exists, all properties will be updated with the given values.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://aka.ms/search-manage")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    SearchService,
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
    LroHeaders = ArmLroLocationHeader<FinalResult = SearchService> &
      Azure.Core.Foundations.RetryAfterHeader,
    Error = CloudError
  >;

  /**
   * Updates an existing search service in the given resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @patch(#{ implicitOptionality: false })
  @externalDocs("https://aka.ms/search-manage")
  update is ArmCustomPatchSync<
    SearchService,
    PatchModel = SearchServiceUpdate,
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
   * Deletes a search service in the given resource group, along with its associated resources.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://aka.ms/search-manage")
  delete is ArmResourceDeleteSync<
    SearchService,
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
    Response = OkResponse | NoContentResponse | NotFoundResponse,
    Error = CloudError
  >;

  /**
   * Gets a list of all Search services in the given resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://aka.ms/search-manage")
  listByResourceGroup is ArmResourceListByParent<
    SearchService,
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
    Response = SearchServiceListResult,
    Error = CloudError
  >;

  /**
   * Gets a list of all Search services in the given subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://aka.ms/search-manage")
  listBySubscription is ArmListBySubscription<
    SearchService,
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
    Response = SearchServiceListResult,
    Error = CloudError
  >;

  /**
   * Gets the primary and secondary admin API keys for the specified Azure AI Search service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("listAdminKeys")
  @externalDocs("https://aka.ms/search-manage")
  adminKeysGet is ArmResourceActionSync<
    SearchService,
    void,
    ArmResponse<AdminKeyResult>,
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
   * Regenerates either the primary or secondary admin API key. You can only regenerate one key at a time.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @externalDocs("https://aka.ms/search-manage")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Search/searchServices/{searchServiceName}/regenerateAdminKey/{keyKind}")
  regenerate is AdminKeysOps.ActionSync<
    SearchService,
    void,
    ArmResponse<AdminKeyResult>,
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
    OverrideErrorType = CloudError
  >;

  /**
   * Generates a new query key for the specified search service. You can create up to 50 query keys per service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @post
  @externalDocs("https://aka.ms/search-manage")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Search/searchServices/{searchServiceName}/createQueryKey/{name}")
  create is QueryKeysOps.CreateOrUpdateSync<
    SearchService,
    Request = void,
    Response = ArmResponse<QueryKey>,
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
    OverrideErrorType = CloudError
  >;

  /**
   * Returns the list of query API keys for the given Azure AI Search service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @action("listQueryKeys")
  @externalDocs("https://aka.ms/search-manage")
  @list
  listBySearchService is ArmResourceActionSync<
    SearchService,
    void,
    ArmResponse<ListQueryKeysResult>,
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
   * Deletes the specified query key. Unlike admin keys, query keys are not regenerated. The process for regenerating a query key is to delete and then recreate it.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @delete
  @externalDocs("https://aka.ms/search-manage")
  queryKeysDelete is QueryKeysDeleteOps.ActionSync<
    SearchService,
    void,
    OkResponse | NoContentResponse | NotFoundResponse,
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
    OverrideErrorType = CloudError
  >;

  /**
   * Upgrades the Azure AI Search service to the latest version available.
   */
  upgrade is ArmResourceActionAsync<
    SearchService,
    void,
    Response = SearchService,
    Error = CloudError
  >;

  /**
   * Gets a list of all supported private link resource types for the given service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @operationId("PrivateLinkResources_ListSupported")
  @externalDocs("https://aka.ms/search-manage")
  @get
  @action("privateLinkResources")
  @list
  listSupported is ArmResourceActionSync<
    SearchService,
    void,
    ArmResponse<PrivateLinkResourcesResult>,
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
}

@@doc(SearchService.name,
  "The name of the Azure AI Search service associated with the specified resource group."
);
@@doc(SearchService.properties, "Properties of the search service.");
@@doc(SearchServices.createOrUpdate::parameters.resource,
  "The definition of the search service to create or update."
);
@@doc(SearchServices.update::parameters.properties,
  "The definition of the search service to update."
);
