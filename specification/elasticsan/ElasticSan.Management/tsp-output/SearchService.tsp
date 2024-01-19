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
@doc("Describes an Azure Cognitive Search service and its current state.")
model SearchService is TrackedResource<SearchServiceProperties> {
  @doc("The name of the Azure Cognitive Search service associated with the specified resource group.")
  @path
  @key("searchServiceName")
  @segment("searchServices")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
interface SearchServices {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the search service with the given name in the given resource group.")
  @operationId("Services_Get")
  get is ArmResourceRead<
    SearchService,
    {
      ...BaseParameters<SearchService>;

      @doc("A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.")
      @header
      clientRequestId?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Creates or updates a search service in the given resource group. If the search service already exists, all properties will be updated with the given values.")
  @operationId("Services_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    SearchService,
    {
      ...BaseParameters<SearchService>;

      @doc("A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.")
      @header
      clientRequestId?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Updates an existing search service in the given resource group.")
  @operationId("Services_Update")
  update is ArmCustomPatchSync<
    SearchService,
    SearchServiceUpdate,
    {
      ...BaseParameters<SearchService>;

      @doc("A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.")
      @header
      clientRequestId?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes a search service in the given resource group, along with its associated resources.")
  @operationId("Services_Delete")
  delete is ArmResourceDeleteSync<
    SearchService,
    {
      ...BaseParameters<SearchService>;

      @doc("A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.")
      @header
      clientRequestId?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a list of all Search services in the given resource group.")
  @operationId("Services_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    SearchService,
    {
      ...BaseParameters<SearchService>;

      @doc("A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.")
      @header
      clientRequestId?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets a list of all Search services in the given subscription.")
  @operationId("Services_ListBySubscription")
  listBySubscription is ArmListBySubscription<SearchService>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the primary and secondary admin API keys for the specified Azure Cognitive Search service.")
  @operationId("AdminKeys_Get")
  get is ArmResourceActionSync<
    SearchService,
    void,
    AdminKeyResult,
    {
      ...BaseParameters<SearchService>;

      @doc("A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.")
      @header
      clientRequestId?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Regenerates either the primary or secondary admin API key. You can only regenerate one key at a time.")
  @operationId("AdminKeys_Regenerate")
  regenerate is ArmResourceActionSync<
    SearchService,
    void,
    AdminKeyResult,
    {
      ...BaseParameters<SearchService>;

      @doc("Specifies which key to regenerate. Valid values include 'primary' and 'secondary'.")
      @path
      keyKind: AdminKeyKind;

      @doc("A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.")
      @header
      clientRequestId?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Generates a new query key for the specified search service. You can create up to 50 query keys per service.")
  @operationId("QueryKeys_Create")
  create is ArmResourceActionSync<
    SearchService,
    void,
    QueryKey,
    {
      ...BaseParameters<SearchService>;

      @doc("The name of the new query API key.")
      @path
      name: string;

      @doc("A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.")
      @header
      clientRequestId?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Returns the list of query API keys for the given Azure Cognitive Search service.")
  @operationId("QueryKeys_ListBySearchService")
  listBySearchService is ArmResourceActionSync<
    SearchService,
    void,
    ListQueryKeysResult,
    {
      ...BaseParameters<SearchService>;

      @doc("A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.")
      @header
      clientRequestId?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Checks whether or not the given search service name is available for use. Search service names must be globally unique since they are part of the service URI (https://&lt;name&gt;.search.windows.net).")
  @operationId("Services_CheckNameAvailability")
  checkNameAvailability is checkGlobalNameAvailability<
    CheckNameAvailabilityInput,
    CheckNameAvailabilityOutput
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateLinkResources_ListSupported")
  @doc("Gets a list of all supported private link resource types for the given service.")
  // FIXME: PrivateLinkResources_ListSupported could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Search/searchServices/{searchServiceName}/privateLinkResources")
  @get
  listSupported is Azure.Core.Foundations.Operation<
    {
      @doc("A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.")
      @header
      clientRequestId?: string;

      @doc("The unique identifier for a Microsoft Azure subscription. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group within the current subscription. You can obtain this value from the Azure Resource Manager API or the portal.")
      @path
      resourceGroupName: string;

      @doc("The name of the Azure Cognitive Search service associated with the specified resource group.")
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
