import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Microsoft.Search;
@doc("Describes an Azure Cognitive Search service and its current state.")
model SearchService is TrackedResource<SearchServiceProperties> {
  @doc("The name of the Azure Cognitive Search service associated with the specified resource group.")
  @key("searchServiceName")
  @segment("searchServices")
  name: string;

  ...Azure.ResourceManager.ManagedServiceIdentity;
  ...Azure.ResourceManager.ResourceSku;
}

@armResourceOperations
@projectedName("client", "Services")
interface SearchServices_Services {
  @doc("Gets the search service with the given name in the given resource group.")
  get is ArmResourceRead<
    SearchService,
    {
      ...BaseParameters<SearchService>;

      @doc("A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.")
      @header
      clientRequestId?: string;
    }
  >;

  @doc("Creates or updates a search service in the given resource group. If the search service already exists, all properties will be updated with the given values.")
  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    SearchService,
    {
      ...BaseParameters<SearchService>;

      @doc("A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.")
      @header
      clientRequestId?: string;
    }
  >;

  @doc("Updates an existing search service in the given resource group.")
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

  @doc("Deletes a search service in the given resource group, along with its associated resources.")
  delete is ArmResourceDeleteSync<
    SearchService,
    {
      ...BaseParameters<SearchService>;

      @doc("A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.")
      @header
      clientRequestId?: string;
    }
  >;

  @doc("Gets a list of all Search services in the given resource group.")
  listByResourceGroup is ArmResourceListByParent<
    SearchService,
    {
      ...BaseParameters<SearchService>;

      @doc("A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.")
      @header
      clientRequestId?: string;
    }
  >;

  @doc("Gets a list of all Search services in the given subscription.")
  listBySubscription is ArmListBySubscription<SearchService>;
}

@armResourceOperations
@projectedName("client", "AdminKeys")
interface SearchServices_AdminKeys {
  @doc("Gets the primary and secondary admin API keys for the specified Azure Cognitive Search service.")
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

  @doc("Regenerates either the primary or secondary admin API key. You can only regenerate one key at a time.")
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
}

@armResourceOperations
@projectedName("client", "QueryKeys")
interface SearchServices_QueryKeys {
  @doc("Generates a new query key for the specified search service. You can create up to 50 query keys per service.")
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

  @doc("Returns the list of query API keys for the given Azure Cognitive Search service.")
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
}

@armResourceOperations
@projectedName("client", "PrivateLinkResources")
interface SearchServices_PrivateLinkResources {
  @doc("Gets a list of all supported private link resource types for the given service.")
  // FIXME: PrivateLinkResources_ListSupported could not be converted to a resource operation
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Search/searchServices/{searchServiceName}/privateLinkResources")
  @get
  ListSupported is Azure.Core.Foundations.Operation<
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
