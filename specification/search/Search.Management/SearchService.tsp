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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  sku?: Sku;

  /**
   * The identity of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
  identity?: Identity;
}

@armResourceOperations
interface SearchServices {
  /**
   * Gets the search service with the given name in the given resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Services_Get")
  get is ArmResourceRead<
    SearchService,
    Parameters = {
      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      #suppress "@azure-tools/typespec-azure-core/no-format"
      @format("uuid")
      @header
      clientRequestId?: string;
    }
  >;

  /**
   * Creates or updates a search service in the given resource group. If the search service already exists, all properties will be updated with the given values.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Services_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    SearchService,
    Parameters = {
      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      #suppress "@azure-tools/typespec-azure-core/no-format"
      @format("uuid")
      @header
      clientRequestId?: string;
    },
    LroHeaders = ArmLroLocationHeader<FinalResult = SearchService> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates an existing search service in the given resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Services_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    SearchService,
    PatchModel = SearchServiceUpdate,
    Parameters = {
      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      #suppress "@azure-tools/typespec-azure-core/no-format"
      @format("uuid")
      @header
      clientRequestId?: string;
    }
  >;

  /**
   * Deletes a search service in the given resource group, along with its associated resources.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Services_Delete")
  delete is ArmResourceDeleteSync<
    SearchService,
    Parameters = {
      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      #suppress "@azure-tools/typespec-azure-core/no-format"
      @format("uuid")
      @header
      clientRequestId?: string;
    }
  >;

  /**
   * Gets a list of all Search services in the given resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Services_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    SearchService,
    Parameters = {
      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      #suppress "@azure-tools/typespec-azure-core/no-format"
      @format("uuid")
      @header
      clientRequestId?: string;
    }
  >;

  /**
   * Gets a list of all Search services in the given subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Services_ListBySubscription")
  listBySubscription is ArmListBySubscription<
    SearchService,
    Parameters = {
      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      #suppress "@azure-tools/typespec-azure-core/no-format"
      @format("uuid")
      @header
      clientRequestId?: string;
    }
  >;

  /**
   * Gets the primary and secondary admin API keys for the specified Azure AI Search service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AdminKeys_Get")
  @action("listAdminKeys")
  adminKeysGet is ArmResourceActionSync<
    SearchService,
    void,
    ArmResponse<AdminKeyResult>,
    Parameters = {
      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      #suppress "@azure-tools/typespec-azure-core/no-format"
      @format("uuid")
      @header
      clientRequestId?: string;
    }
  >;

  /**
   * Regenerates either the primary or secondary admin API key. You can only regenerate one key at a time.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("AdminKeys_Regenerate")
  @action("{keyKind}")
  regenerate is ArmResourceActionSync<
    SearchService,
    void,
    ArmResponse<AdminKeyResult>,
    Parameters = {
      /**
       * Specifies which key to regenerate. Valid values include 'primary' and 'secondary'.
       */
      @path
      keyKind: AdminKeyKind;

      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      #suppress "@azure-tools/typespec-azure-core/no-format"
      @format("uuid")
      @header
      clientRequestId?: string;
    }
  >;

  /**
   * Generates a new query key for the specified search service. You can create up to 50 query keys per service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("QueryKeys_Create")
  @action("{name}")
  create is ArmResourceActionSync<
    SearchService,
    void,
    ArmResponse<QueryKey>,
    Parameters = {
      /**
       * The name of the new query API key.
       */
      @path
      name: string;

      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      #suppress "@azure-tools/typespec-azure-core/no-format"
      @format("uuid")
      @header
      clientRequestId?: string;
    }
  >;

  /**
   * Returns the list of query API keys for the given Azure AI Search service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("QueryKeys_ListBySearchService")
  @action("listQueryKeys")
  listBySearchService is ArmResourceActionSync<
    SearchService,
    void,
    ArmResponse<ListQueryKeysResult>,
    Parameters = {
      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      #suppress "@azure-tools/typespec-azure-core/no-format"
      @format("uuid")
      @header
      clientRequestId?: string;
    }
  >;

  /**
   * Deletes the specified query key. Unlike admin keys, query keys are not regenerated. The process for regenerating a query key is to delete and then recreate it.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("QueryKeys_Delete")
  @delete
  @action("{key}")
  queryKeysDelete is ArmResourceActionSync<
    SearchService,
    void,
    OkResponse | NoContentResponse,
    Parameters = {
      /**
       * The query key to be deleted. Query keys are identified by value, not by name.
       */
      @path
      key: string;

      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      #suppress "@azure-tools/typespec-azure-core/no-format"
      @format("uuid")
      @header
      clientRequestId?: string;
    }
  >;

  /**
   * Upgrades the Azure AI Search service to the latest version available.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Services_Upgrade")
  upgrade is ArmResourceActionAsync<
    SearchService,
    void,
    ArmResponse<SearchService>
  >;

  /**
   * Gets a list of all supported private link resource types for the given service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateLinkResources_ListSupported")
  @get
  @action("privateLinkResources")
  listSupported is ArmResourceActionSync<
    SearchService,
    void,
    ArmResponse<PrivateLinkResourcesResult>,
    Parameters = {
      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      #suppress "@azure-tools/typespec-azure-core/no-format"
      @format("uuid")
      @header
      clientRequestId?: string;
    }
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
