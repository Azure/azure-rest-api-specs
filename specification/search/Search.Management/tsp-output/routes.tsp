import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace SearchManagementClient;

interface OperationsOperations {
  @doc("Lists all of the available REST API operations of the Microsoft.Search provider.")
  @route("/providers/Microsoft.Search/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationListResult>;
}

interface AdminKeysOperations {
  @doc("""
Gets the primary and secondary admin API keys for the specified Azure Cognitive
Search service.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Search/searchServices/{searchServiceName}/listAdminKeys")
  @post
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("""
The name of the resource group within the current subscription. You can obtain
this value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("""
The name of the Azure Cognitive Search service associated with the specified
resource group.
""")
      @path
      searchServiceName: string;

      @doc("""
A client-generated GUID value that identifies this request. If specified, this
will be included in response information as a way to track the request.
""")
      @header
      `x-ms-client-request-id`: string;

      @doc("""
The unique identifier for a Microsoft Azure subscription. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      subscriptionId: string;
    },
    AdminKeyResult
  >;

  @doc("""
Regenerates either the primary or secondary admin API key. You can only
regenerate one key at a time.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Search/searchServices/{searchServiceName}/regenerateAdminKey/{keyKind}")
  @post
  Regenerate is Azure.Core.Foundations.Operation<
    {
      @doc("""
The name of the resource group within the current subscription. You can obtain
this value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("""
The name of the Azure Cognitive Search service associated with the specified
resource group.
""")
      @path
      searchServiceName: string;

      @doc("""
Specifies which key to regenerate. Valid values include 'primary' and
'secondary'.
""")
      @path
      keyKind: AdminKeyKind;

      @doc("""
A client-generated GUID value that identifies this request. If specified, this
will be included in response information as a way to track the request.
""")
      @header
      `x-ms-client-request-id`: string;

      @doc("""
The unique identifier for a Microsoft Azure subscription. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      subscriptionId: string;
    },
    AdminKeyResult
  >;
}

interface QueryKeysOperations {
  @doc("""
Generates a new query key for the specified search service. You can create up
to 50 query keys per service.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Search/searchServices/{searchServiceName}/createQueryKey/{name}")
  @post
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("""
The name of the resource group within the current subscription. You can obtain
this value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("""
The name of the Azure Cognitive Search service associated with the specified
resource group.
""")
      @path
      searchServiceName: string;

      @doc("The name of the new query API key.")
      @path
      name: string;

      @doc("""
A client-generated GUID value that identifies this request. If specified, this
will be included in response information as a way to track the request.
""")
      @header
      `x-ms-client-request-id`: string;

      @doc("""
The unique identifier for a Microsoft Azure subscription. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      subscriptionId: string;
    },
    QueryKey
  >;

  @doc("Returns the list of query API keys for the given Azure Cognitive Search service.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Search/searchServices/{searchServiceName}/listQueryKeys")
  @post
  ListBySearchService is Azure.Core.Foundations.Operation<
    {
      @doc("""
The name of the resource group within the current subscription. You can obtain
this value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("""
The name of the Azure Cognitive Search service associated with the specified
resource group.
""")
      @path
      searchServiceName: string;

      @doc("""
A client-generated GUID value that identifies this request. If specified, this
will be included in response information as a way to track the request.
""")
      @header
      `x-ms-client-request-id`: string;

      @doc("""
The unique identifier for a Microsoft Azure subscription. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      subscriptionId: string;
    },
    ListQueryKeysResult
  >;

  @doc("""
Deletes the specified query key. Unlike admin keys, query keys are not
regenerated. The process for regenerating a query key is to delete and then
recreate it.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Search/searchServices/{searchServiceName}/deleteQueryKey/{key}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("""
The name of the resource group within the current subscription. You can obtain
this value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("""
The name of the Azure Cognitive Search service associated with the specified
resource group.
""")
      @path
      searchServiceName: string;

      @doc("The query key to be deleted. Query keys are identified by value, not by name.")
      @path
      key: string;

      @doc("""
A client-generated GUID value that identifies this request. If specified, this
will be included in response information as a way to track the request.
""")
      @header
      `x-ms-client-request-id`: string;

      @doc("""
The unique identifier for a Microsoft Azure subscription. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      subscriptionId: string;
    },
    void
  >;
}

interface ServicesOperations {
  @doc("""
Creates or updates a search service in the given resource group. If the search
service already exists, all properties will be updated with the given values.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Search/searchServices/{searchServiceName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("""
The name of the resource group within the current subscription. You can obtain
this value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("""
The name of the Azure Cognitive Search service to create or update. Search
service names must only contain lowercase letters, digits or dashes, cannot use
dash as the first two or last one characters, cannot contain consecutive
dashes, and must be between 2 and 60 characters in length. Search service names
must be globally unique since they are part of the service URI
(https://<name>.search.windows.net). You cannot change the service name after
the service is created.
""")
      @path
      searchServiceName: string;

      @doc("""
A client-generated GUID value that identifies this request. If specified, this
will be included in response information as a way to track the request.
""")
      @header
      `x-ms-client-request-id`: string;

      @doc("""
The unique identifier for a Microsoft Azure subscription. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      subscriptionId: string;

      @doc("The definition of the search service to create or update.")
      @body
      service: SearchService;
    },
    SearchService
  >;

  @doc("Updates an existing search service in the given resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Search/searchServices/{searchServiceName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("""
The name of the resource group within the current subscription. You can obtain
this value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("The name of the Azure Cognitive Search service to update.")
      @path
      searchServiceName: string;

      @doc("""
A client-generated GUID value that identifies this request. If specified, this
will be included in response information as a way to track the request.
""")
      @header
      `x-ms-client-request-id`: string;

      @doc("""
The unique identifier for a Microsoft Azure subscription. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      subscriptionId: string;

      @doc("The definition of the search service to update.")
      @body
      service: SearchServiceUpdate;
    },
    SearchService
  >;

  @doc("Gets the search service with the given name in the given resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Search/searchServices/{searchServiceName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("""
The name of the resource group within the current subscription. You can obtain
this value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("""
The name of the Azure Cognitive Search service associated with the specified
resource group.
""")
      @path
      searchServiceName: string;

      @doc("""
A client-generated GUID value that identifies this request. If specified, this
will be included in response information as a way to track the request.
""")
      @header
      `x-ms-client-request-id`: string;

      @doc("""
The unique identifier for a Microsoft Azure subscription. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      subscriptionId: string;
    },
    SearchService
  >;

  @doc("""
Deletes a search service in the given resource group, along with its associated
resources.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Search/searchServices/{searchServiceName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("""
The name of the resource group within the current subscription. You can obtain
this value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("""
The name of the Azure Cognitive Search service associated with the specified
resource group.
""")
      @path
      searchServiceName: string;

      @doc("""
A client-generated GUID value that identifies this request. If specified, this
will be included in response information as a way to track the request.
""")
      @header
      `x-ms-client-request-id`: string;

      @doc("""
The unique identifier for a Microsoft Azure subscription. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Gets a list of all Search services in the given resource group.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Search/searchServices")
  @get
  ListByResourceGroup is Azure.Core.Foundations.Operation<
    {
      @doc("""
The name of the resource group within the current subscription. You can obtain
this value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("""
A client-generated GUID value that identifies this request. If specified, this
will be included in response information as a way to track the request.
""")
      @header
      `x-ms-client-request-id`: string;

      @doc("""
The unique identifier for a Microsoft Azure subscription. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      subscriptionId: string;
    },
    SearchServiceListResult
  >;

  @doc("Gets a list of all Search services in the given subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Search/searchServices")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("""
A client-generated GUID value that identifies this request. If specified, this
will be included in response information as a way to track the request.
""")
      @header
      `x-ms-client-request-id`: string;

      @doc("""
The unique identifier for a Microsoft Azure subscription. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      subscriptionId: string;
    },
    SearchServiceListResult
  >;

  @doc("""
Checks whether or not the given search service name is available for use.
Search service names must be globally unique since they are part of the service
URI (https://<name>.search.windows.net).
""")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Search/checkNameAvailability")
  @post
  CheckNameAvailability is Azure.Core.Foundations.Operation<
    {
      @doc("""
A client-generated GUID value that identifies this request. If specified, this
will be included in response information as a way to track the request.
""")
      @header
      `x-ms-client-request-id`: string;

      @doc("""
The unique identifier for a Microsoft Azure subscription. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      subscriptionId: string;

      @doc("The resource name and type to check.")
      @body
      checkNameAvailabilityInput: CheckNameAvailabilityInput;
    },
    CheckNameAvailabilityOutput
  >;
}

interface PrivateLinkResourcesOperations {
  @doc("Gets a list of all supported private link resource types for the given service.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Search/searchServices/{searchServiceName}/privateLinkResources")
  @get
  ListSupported is Azure.Core.Foundations.Operation<
    {
      @doc("""
A client-generated GUID value that identifies this request. If specified, this
will be included in response information as a way to track the request.
""")
      @header
      `x-ms-client-request-id`: string;

      @doc("""
The unique identifier for a Microsoft Azure subscription. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      subscriptionId: string;

      @doc("""
The name of the resource group within the current subscription. You can obtain
this value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("""
The name of the Azure Cognitive Search service associated with the specified
resource group.
""")
      @path
      searchServiceName: string;
    },
    PrivateLinkResourcesResult
  >;
}

interface PrivateEndpointConnectionsOperations {
  @doc("""
Updates a Private Endpoint connection to the search service in the given
resource group.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Search/searchServices/{searchServiceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @put
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("""
The name of the resource group within the current subscription. You can obtain
this value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("""
The name of the Azure Cognitive Search service associated with the specified
resource group.
""")
      @path
      searchServiceName: string;

      @doc("""
The name of the private endpoint connection to the Azure Cognitive Search
service with the specified resource group.
""")
      @path
      privateEndpointConnectionName: string;

      @doc("""
A client-generated GUID value that identifies this request. If specified, this
will be included in response information as a way to track the request.
""")
      @header
      `x-ms-client-request-id`: string;

      @doc("""
The unique identifier for a Microsoft Azure subscription. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      subscriptionId: string;

      @doc("The definition of the private endpoint connection to update.")
      @body
      privateEndpointConnection: PrivateEndpointConnection;
    },
    PrivateEndpointConnection
  >;

  @doc("""
Gets the details of the private endpoint connection to the search service in
the given resource group.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Search/searchServices/{searchServiceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("""
The name of the resource group within the current subscription. You can obtain
this value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("""
The name of the Azure Cognitive Search service associated with the specified
resource group.
""")
      @path
      searchServiceName: string;

      @doc("""
The name of the private endpoint connection to the Azure Cognitive Search
service with the specified resource group.
""")
      @path
      privateEndpointConnectionName: string;

      @doc("""
A client-generated GUID value that identifies this request. If specified, this
will be included in response information as a way to track the request.
""")
      @header
      `x-ms-client-request-id`: string;

      @doc("""
The unique identifier for a Microsoft Azure subscription. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      subscriptionId: string;
    },
    PrivateEndpointConnection
  >;

  @doc("""
Disconnects the private endpoint connection and deletes it from the search
service.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Search/searchServices/{searchServiceName}/privateEndpointConnections/{privateEndpointConnectionName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("""
The name of the resource group within the current subscription. You can obtain
this value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("""
The name of the Azure Cognitive Search service associated with the specified
resource group.
""")
      @path
      searchServiceName: string;

      @doc("""
The name of the private endpoint connection to the Azure Cognitive Search
service with the specified resource group.
""")
      @path
      privateEndpointConnectionName: string;

      @doc("""
A client-generated GUID value that identifies this request. If specified, this
will be included in response information as a way to track the request.
""")
      @header
      `x-ms-client-request-id`: string;

      @doc("""
The unique identifier for a Microsoft Azure subscription. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      subscriptionId: string;
    },
    PrivateEndpointConnection | void
  >;

  @doc("Gets a list of all private endpoint connections in the given service.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Search/searchServices/{searchServiceName}/privateEndpointConnections")
  @get
  ListByService is Azure.Core.Foundations.Operation<
    {
      @doc("""
A client-generated GUID value that identifies this request. If specified, this
will be included in response information as a way to track the request.
""")
      @header
      `x-ms-client-request-id`: string;

      @doc("""
The unique identifier for a Microsoft Azure subscription. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      subscriptionId: string;

      @doc("""
The name of the resource group within the current subscription. You can obtain
this value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("""
The name of the Azure Cognitive Search service associated with the specified
resource group.
""")
      @path
      searchServiceName: string;
    },
    PrivateEndpointConnectionListResult
  >;
}

interface SharedPrivateLinkResourcesOperations {
  @doc("""
Initiates the creation or update of a shared private link resource managed by
the search service in the given resource group.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Search/searchServices/{searchServiceName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("""
The name of the resource group within the current subscription. You can obtain
this value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("""
The name of the Azure Cognitive Search service associated with the specified
resource group.
""")
      @path
      searchServiceName: string;

      @doc("""
The name of the shared private link resource managed by the Azure Cognitive
Search service within the specified resource group.
""")
      @path
      sharedPrivateLinkResourceName: string;

      @doc("""
A client-generated GUID value that identifies this request. If specified, this
will be included in response information as a way to track the request.
""")
      @header
      `x-ms-client-request-id`: string;

      @doc("""
The unique identifier for a Microsoft Azure subscription. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      subscriptionId: string;

      @doc("The definition of the shared private link resource to create or update.")
      @body
      sharedPrivateLinkResource: SharedPrivateLinkResource;
    },
    SharedPrivateLinkResource | void
  >;

  @doc("""
Gets the details of the shared private link resource managed by the search
service in the given resource group.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Search/searchServices/{searchServiceName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("""
The name of the resource group within the current subscription. You can obtain
this value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("""
The name of the Azure Cognitive Search service associated with the specified
resource group.
""")
      @path
      searchServiceName: string;

      @doc("""
The name of the shared private link resource managed by the Azure Cognitive
Search service within the specified resource group.
""")
      @path
      sharedPrivateLinkResourceName: string;

      @doc("""
A client-generated GUID value that identifies this request. If specified, this
will be included in response information as a way to track the request.
""")
      @header
      `x-ms-client-request-id`: string;

      @doc("""
The unique identifier for a Microsoft Azure subscription. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      subscriptionId: string;
    },
    SharedPrivateLinkResource
  >;

  @doc("""
Initiates the deletion of the shared private link resource from the search
service.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Search/searchServices/{searchServiceName}/sharedPrivateLinkResources/{sharedPrivateLinkResourceName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("""
The name of the resource group within the current subscription. You can obtain
this value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("""
The name of the Azure Cognitive Search service associated with the specified
resource group.
""")
      @path
      searchServiceName: string;

      @doc("""
The name of the shared private link resource managed by the Azure Cognitive
Search service within the specified resource group.
""")
      @path
      sharedPrivateLinkResourceName: string;

      @doc("""
A client-generated GUID value that identifies this request. If specified, this
will be included in response information as a way to track the request.
""")
      @header
      `x-ms-client-request-id`: string;

      @doc("""
The unique identifier for a Microsoft Azure subscription. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      subscriptionId: string;
    },
    void
  >;

  @doc("Gets a list of all shared private link resources managed by the given service.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.Search/searchServices/{searchServiceName}/sharedPrivateLinkResources")
  @get
  ListByService is Azure.Core.Foundations.Operation<
    {
      @doc("""
A client-generated GUID value that identifies this request. If specified, this
will be included in response information as a way to track the request.
""")
      @header
      `x-ms-client-request-id`: string;

      @doc("""
The unique identifier for a Microsoft Azure subscription. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      subscriptionId: string;

      @doc("""
The name of the resource group within the current subscription. You can obtain
this value from the Azure Resource Manager API or the portal.
""")
      @path
      resourceGroupName: string;

      @doc("""
The name of the Azure Cognitive Search service associated with the specified
resource group.
""")
      @path
      searchServiceName: string;
    },
    SharedPrivateLinkResourceListResult
  >;
}

interface UsagesOperations {
  @doc("Gets a list of all Search quota usages in the given subscription.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Search/locations/{location}/usages")
  @get
  ListBySubscription is Azure.Core.Foundations.Operation<
    {
      @doc("""
A client-generated GUID value that identifies this request. If specified, this
will be included in response information as a way to track the request.
""")
      @header
      `x-ms-client-request-id`: string;

      @doc("The unique location name for a Microsoft Azure geographic region.")
      @path
      location: string;

      @doc("""
The unique identifier for a Microsoft Azure subscription. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
      @path
      subscriptionId: string;
    },
    QuotaUsagesListResult
  >;
}

@doc("Gets the quota usage for a search sku in the given subscription.")
@route("/subscriptions/{subscriptionId}/providers/Microsoft.Search/locations/{location}/usages/{skuName}")
@get
op UsageBySubscriptionSku is Azure.Core.Foundations.Operation<
  {
    @doc("""
A client-generated GUID value that identifies this request. If specified, this
will be included in response information as a way to track the request.
""")
    @header
    `x-ms-client-request-id`: string;

    @doc("The unique location name for a Microsoft Azure geographic region.")
    @path
    location: string;

    @doc("""
The unique identifier for a Microsoft Azure subscription. You can obtain this
value from the Azure Resource Manager API or the portal.
""")
    @path
    subscriptionId: string;

    @doc("The unique search service sku name supported by Azure Cognitive Search.")
    @path
    skuName: string;
  },
  QuotaUsageResult
>;
