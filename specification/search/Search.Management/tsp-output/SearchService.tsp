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

namespace Microsoft.Search;
/**
 * Describes an Azure Cognitive Search service and its current state.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@includeInapplicableMetadataInPayload(false)
@Azure.ResourceManager.Private.armResourceInternal(SearchServiceProperties)
model SearchService extends TrackedResourceBase {
  /**
   * The name of the Azure Cognitive Search service associated with the specified resource group.
   */
  @path
  @key("searchServiceName")
  @segment("searchServices")
  @visibility("read")
  name: string;

  /**
   * Properties of the search service.
   */
  @extension("x-ms-client-flatten", true)
  properties?: SearchServiceProperties;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface SearchServices {
  /**
   * Gets the search service with the given name in the given resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Services_Get")
  get is ArmResourceRead<
    SearchService,
    {
      ...BaseParameters<SearchService>;

      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      @header
      clientRequestId?: string;
    }
  >;

  /**
   * Creates or updates a search service in the given resource group. If the search service already exists, all properties will be updated with the given values.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Services_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    SearchService,
    {
      ...BaseParameters<SearchService>;

      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      @header
      clientRequestId?: string;
    }
  >;

  /**
   * Updates an existing search service in the given resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @parameterVisibility("read")
  @operationId("Services_Update")
  update is ArmCustomPatchSync<
    SearchService,
    SearchServiceUpdate,
    {
      ...BaseParameters<SearchService>;

      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      @header
      clientRequestId?: string;
    }
  >;

  /**
   * Deletes a search service in the given resource group, along with its associated resources.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Services_Delete")
  delete is ArmResourceDeleteSync<
    SearchService,
    {
      ...BaseParameters<SearchService>;

      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      @header
      clientRequestId?: string;
    }
  >;

  /**
   * Gets a list of all Search services in the given resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Services_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    SearchService,
    {
      ...BaseParameters<SearchService>;

      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      @header
      clientRequestId?: string;
    }
  >;

  /**
   * Gets a list of all Search services in the given subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Services_ListBySubscription")
  listBySubscription is ArmListBySubscription<SearchService>;

  /**
   * Gets the primary and secondary admin API keys for the specified Azure Cognitive Search service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AdminKeys_Get")
  get is ArmResourceActionSync<
    SearchService,
    void,
    AdminKeyResult,
    {
      ...BaseParameters<SearchService>;

      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      @header
      clientRequestId?: string;
    }
  >;

  /**
   * Regenerates either the primary or secondary admin API key. You can only regenerate one key at a time.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("AdminKeys_Regenerate")
  regenerate is ArmResourceActionSync<
    SearchService,
    void,
    AdminKeyResult,
    {
      ...BaseParameters<SearchService>;

      /**
       * Specifies which key to regenerate. Valid values include 'primary' and 'secondary'.
       */
      @path
      keyKind: AdminKeyKind;

      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      @header
      clientRequestId?: string;
    }
  >;

  /**
   * Generates a new query key for the specified search service. You can create up to 50 query keys per service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("QueryKeys_Create")
  create is ArmResourceActionSync<
    SearchService,
    void,
    QueryKey,
    {
      ...BaseParameters<SearchService>;

      /**
       * The name of the new query API key.
       */
      @path
      name: string;

      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      @header
      clientRequestId?: string;
    }
  >;

  /**
   * Returns the list of query API keys for the given Azure Cognitive Search service.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("QueryKeys_ListBySearchService")
  listBySearchService is ArmResourceActionSync<
    SearchService,
    void,
    ListQueryKeysResult,
    {
      ...BaseParameters<SearchService>;

      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      @header
      clientRequestId?: string;
    }
  >;

  /**
   * Checks whether or not the given search service name is available for use. Search service names must be globally unique since they are part of the service URI (https://&lt;name&gt;.search.windows.net).
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Services_CheckNameAvailability")
  checkNameAvailability is checkGlobalNameAvailability<
    CheckNameAvailabilityInput,
    CheckNameAvailabilityOutput
  >;

  /**
   * Gets a list of all supported private link resource types for the given service.
   */
  // FIXME: PrivateLinkResources_ListSupported could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateLinkResources_ListSupported")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Search/searchServices/{searchServiceName}/privateLinkResources")
  @get
  listSupported is Azure.Core.Foundations.Operation<
    {
      /**
       * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
       */
      @header
      clientRequestId?: string;

      /**
       * The unique identifier for a Microsoft Azure subscription. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      subscriptionId: string;

      /**
       * The name of the resource group within the current subscription. You can obtain this value from the Azure Resource Manager API or the portal.
       */
      @path
      resourceGroupName: string;

      /**
       * The name of the Azure Cognitive Search service associated with the specified resource group.
       */
      @path
      searchServiceName: string;
    },
    PrivateLinkResourcesResult
  >;
}

@@projectedName(SearchServices.createOrUpdate::parameters.resource,
  "json",
  "service"
);
@@extension(SearchServices.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "service"
);
@@doc(SearchServices.createOrUpdate::parameters.resource,
  "The definition of the search service to create or update."
);
@@projectedName(SearchServices.update::parameters.properties,
  "json",
  "service"
);
@@extension(SearchServices.update::parameters.properties,
  "x-ms-client-name",
  "service"
);
@@doc(SearchServices.update::parameters.properties,
  "The definition of the search service to update."
);
