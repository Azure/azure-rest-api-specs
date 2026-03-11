// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./routes.tsp";
import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ClientGenerator.Core;
using TypeSpec.OpenAPI;

namespace Microsoft.Search;

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model `search-management-request-options` {
  /**
   * A client-generated GUID value that identifies this request. If specified, this will be included in response information as a way to track the request.
   */
  @header("x-ms-client-request-id")
  clientRequestId?: string;
}

/**
 * Checks whether or not the given search service name is available for use. Search service names must be globally unique since they are part of the service URI (https://<name>.search.windows.net).
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-action-verb" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@autoRoute
@action("servicesCheckNameAvailability")
op servicesCheckNameAvailabilityCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  /**
   * The resource name and type to check.
   */
  body: CheckNameAvailabilityInput,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  params: `search-management-request-options`,
): ArmResponse<CheckNameAvailabilityOutput> | CloudError;

/**
 * Get a list of all Azure AI Search quota usages across the subscription.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-action-verb" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@autoRoute
@action("usagesListBySubscription")
op usagesListBySubscriptionCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...SubscriptionActionScope,
  ...Azure.ResourceManager.Legacy.Provider,
  ...LocationParameter,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  body: void,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  params: `search-management-request-options`,
): ArmResponse<QuotaUsagesListResult> | CloudError;

/**
 * Gets the quota usage for a search SKU in the given subscription.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@autoRoute
op usageBySubscriptionSkuCustomization(
  ...ApiVersionParameter,
  ...LocationResourceParameter,
  ...SubscriptionIdParameter,

  /**
   * The unique SKU name that identifies a billable tier.
   */
  @path
  skuName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  params: `search-management-request-options`,
): ArmResponse<QuotaUsageResult> | CloudError;

/**
 * Gets a list of all Search services in the given subscription.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-action-verb" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@autoRoute
@action("searchServicesListBySubscription")
op searchServicesListBySubscriptionCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  params: `search-management-request-options`,
): ArmResponse<SearchServiceListResult> | CloudError;

/**
 * Gets a list of all Search services in the given resource group.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@autoRoute
op searchServicesListByResourceGroupCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...CommonTypes.ResourceGroupNameParameter,
  ...Azure.ResourceManager.Legacy.Provider,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  params: `search-management-request-options`,
): ArmResponse<SearchServiceListResult> | CloudError;

/**
 * Gets the search service with the given name in the given resource group.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@autoRoute
@get
@action("searchGetCustomization")
op searchGetCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...CommonTypes.ResourceGroupNameParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  /** The name of the Azure AI Search service associated with the specified resource group. */
  @path
  @segment("searchServices")
  @key
  @pattern("^(?=.{2,60}$)[a-z0-9][a-z0-9]+(-[a-z0-9]+)*$")
  searchServiceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  params: `search-management-request-options`,
): ArmResponse<SearchService> | CloudError;

/**
 * Creates or updates a search service in the given resource group. If the search service already exists, all properties will be updated with the given values.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-action-verb" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@autoRoute
@put
@action("searchCreateOrUpdateCustomization")
op searchCreateOrUpdateCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...CommonTypes.ResourceGroupNameParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  /** The name of the Azure AI Search service associated with the specified resource group. */
  @path
  @segment("searchServices")
  @key
  @pattern("^(?=.{2,60}$)[a-z0-9][a-z0-9]+(-[a-z0-9]+)*$")
  searchServiceName: string,

  /**
   * The definition of the search service to create or update.
   */
  resource: SearchService,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  params: `search-management-request-options`,
): ArmResponse<SearchService> | CloudError;

/**
 * Updates an existing search service in the given resource group.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-action-verb" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-patch" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@autoRoute
@patch(#{ implicitOptionality: true })
@action("searchUpdateCustomization")
op searchUpdateCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...CommonTypes.ResourceGroupNameParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  /** The name of the Azure AI Search service associated with the specified resource group. */
  @path
  @segment("searchServices")
  @key
  @pattern("^(?=.{2,60}$)[a-z0-9][a-z0-9]+(-[a-z0-9]+)*$")
  searchServiceName: string,

  /**
   * The definition of the search service to update.
   */
  properties: SearchServiceUpdate,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  params: `search-management-request-options`,
): ArmResponse<SearchService> | CloudError;

/**
 * Deletes a search service in the given resource group, along with its associated resources.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-action-verb" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@autoRoute
@delete
@action("searchDeleteCustomization")
op searchDeleteCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...CommonTypes.ResourceGroupNameParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  /** The name of the Azure AI Search service associated with the specified resource group. */
  @path
  @segment("searchServices")
  @key
  @pattern("^(?=.{2,60}$)[a-z0-9][a-z0-9]+(-[a-z0-9]+)*$")
  searchServiceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  params: `search-management-request-options`,
): OkResponse | NoContentResponse | NotFoundResponse | CloudError;

/**
 * Generates a new query key for the specified search service. You can create up to 50 query keys per service.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@autoRoute
@post
op queryKeysCreateCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...CommonTypes.ResourceGroupNameParameter,

  /** The name of the Azure AI Search service associated with the specified resource group. */
  @path
  @segment("searchServices")
  @key
  @pattern("^(?=.{2,60}$)[a-z0-9][a-z0-9]+(-[a-z0-9]+)*$")
  searchServiceName: string,

  /**
   * The name of the new query API key.
   */
  @path
  name: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resource: void,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  params: `search-management-request-options`,
): ArmResponse<QueryKey> | CloudError;

/**
 * Deletes the specified query key. Unlike admin keys, query keys are not regenerated. The process for regenerating a query key is to delete and then recreate it.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@autoRoute
@delete
op queryKeysDeleteCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...CommonTypes.ResourceGroupNameParameter,

  /** The name of the Azure AI Search service associated with the specified resource group. */
  @path
  @segment("searchServices")
  @key
  @pattern("^(?=.{2,60}$)[a-z0-9][a-z0-9]+(-[a-z0-9]+)*$")
  searchServiceName: string,

  /**
   * The query key to be deleted. Query keys are identified by value, not by name.
   */
  @path
  key: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  body: void,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  params: `search-management-request-options`,
): OkResponse | NoContentResponse | NotFoundResponse | CloudError;

/**
 * Gets the primary and secondary admin API keys for the specified Azure AI Search service.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@autoRoute
@post
op adminKeysGetCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...CommonTypes.ResourceGroupNameParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  /** The name of the Azure AI Search service associated with the specified resource group. */
  @path
  @segment("searchServices")
  @key
  @pattern("^(?=.{2,60}$)[a-z0-9][a-z0-9]+(-[a-z0-9]+)*$")
  searchServiceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  body: void,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  params: `search-management-request-options`,
): ArmResponse<AdminKeyResult> | CloudError;

/**
 * Returns the list of query API keys for the given Azure AI Search service.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@autoRoute
@post
@action("queryKeysListBySearchService")
op queryKeysListBySearchServiceCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...CommonTypes.ResourceGroupNameParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  /** The name of the Azure AI Search service associated with the specified resource group. */
  @path
  @segment("searchServices")
  @key
  @pattern("^(?=.{2,60}$)[a-z0-9][a-z0-9]+(-[a-z0-9]+)*$")
  searchServiceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  body: void,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  params: `search-management-request-options`,
): ArmResponse<ListQueryKeysResult> | CloudError;

/**
 * Gets a list of all private endpoint connections in the given service.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@autoRoute
@get
@action("privateEndpointConnectionsListByService")
op privateEndpointConnectionsListByServiceCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...CommonTypes.ResourceGroupNameParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  /** The name of the Azure AI Search service associated with the specified resource group. */
  @path
  @segment("searchServices")
  @key
  @pattern("^(?=.{2,60}$)[a-z0-9][a-z0-9]+(-[a-z0-9]+)*$")
  searchServiceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  params: `search-management-request-options`,
): PrivateEndpointConnectionListResult | CloudError;

/**
 * Gets the details of the private endpoint connection to the search service in the given resource group.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@autoRoute
@get
op privateEndpointConnectionsGetCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...CommonTypes.ResourceGroupNameParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  /** The name of the Azure AI Search service associated with the specified resource group. */
  @path
  @segment("searchServices")
  @key
  @pattern("^(?=.{2,60}$)[a-z0-9][a-z0-9]+(-[a-z0-9]+)*$")
  searchServiceName: string,

  /**
   * The name of the private endpoint connection to the Azure AI Search service with the specified resource group.
   */
  @path
  privateEndpointConnectionName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  params: `search-management-request-options`,
): ArmResponse<PrivateEndpointConnection> | CloudError;

/**
 * Updates a private endpoint connection to the search service in the given resource group.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@autoRoute
@put
op privateEndpointConnectionsUpdateCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...CommonTypes.ResourceGroupNameParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  /** The name of the Azure AI Search service associated with the specified resource group. */
  @path
  @segment("searchServices")
  @key
  @pattern("^(?=.{2,60}$)[a-z0-9][a-z0-9]+(-[a-z0-9]+)*$")
  searchServiceName: string,

  /**
   * The name of the private endpoint connection to the Azure AI Search service with the specified resource group.
   */
  @path
  privateEndpointConnectionName: string,

  /**
   * The definition of the private endpoint connection to update.
   */
  resource: Microsoft.Search.PrivateEndpointConnection,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  params: `search-management-request-options`,
): ArmResourceUpdatedResponse<PrivateEndpointConnection> | CloudError;

/**
 * Disconnects the private endpoint connection and deletes it from the search service.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@autoRoute
@delete
op privateEndpointConnectionsDeleteCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...CommonTypes.ResourceGroupNameParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  /** The name of the Azure AI Search service associated with the specified resource group. */
  @path
  @segment("searchServices")
  @key
  @pattern("^(?=.{2,60}$)[a-z0-9][a-z0-9]+(-[a-z0-9]+)*$")
  searchServiceName: string,

  /**
   * The name of the private endpoint connection to the Azure AI Search service with the specified resource group.
   */
  @path
  privateEndpointConnectionName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  params: `search-management-request-options`,
): ArmResponse<PrivateEndpointConnection> | NotFoundResponse | CloudError;

/**
 * Gets a list of all supported private link resource types for the given service.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@autoRoute
@get
@action("privateLinkResourcesCustomization")
op privateLinkResourcesListSupportedCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...CommonTypes.ResourceGroupNameParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  /** The name of the Azure AI Search service associated with the specified resource group. */
  @path
  @segment("searchServices")
  @key
  @pattern("^(?=.{2,60}$)[a-z0-9][a-z0-9]+(-[a-z0-9]+)*$")
  searchServiceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  body: void,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  params: `search-management-request-options`,
): ArmResponse<PrivateLinkResourcesResult> | CloudError;

/**
 * Regenerates either the primary or secondary admin API key. You can only regenerate one key at a time.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@autoRoute
@post
op privateLinkResourcesRegenerateCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...CommonTypes.ResourceGroupNameParameter,

  /** The name of the Azure AI Search service associated with the specified resource group. */
  @path
  @segment("searchServices")
  @key
  @pattern("^(?=.{2,60}$)[a-z0-9][a-z0-9]+(-[a-z0-9]+)*$")
  searchServiceName: string,

  /**
   * Specifies which key to regenerate. Valid values include 'primary' and 'secondary'.
   */
  @path
  keyKind: AdminKeyKind,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  body: void,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  params: `search-management-request-options`,
): ArmResponse<AdminKeyResult> | CloudError;

/**
 * Gets a list of all shared private link resources managed by the given service.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@autoRoute
@get
@action("sharedPrivateLinkResourcesCustomization")
op SharedPrivateLinkResourcesListByServiceCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...CommonTypes.ResourceGroupNameParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  /** The name of the Azure AI Search service associated with the specified resource group. */
  @path
  @segment("searchServices")
  @key
  @pattern("^(?=.{2,60}$)[a-z0-9][a-z0-9]+(-[a-z0-9]+)*$")
  searchServiceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  params: `search-management-request-options`,
): SharedPrivateLinkResourceListResult | CloudError;

/**
 * Gets the details of the shared private link resource managed by the search service in the given resource group.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@autoRoute
@get
op SharedPrivateLinkResourcesGetCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...CommonTypes.ResourceGroupNameParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  /** The name of the Azure AI Search service associated with the specified resource group. */
  @path
  @segment("searchServices")
  @key
  @pattern("^(?=.{2,60}$)[a-z0-9][a-z0-9]+(-[a-z0-9]+)*$")
  searchServiceName: string,

  /**
   * The name of the shared private link resource managed by the Azure AI Search service within the specified resource group.
   */
  @path
  sharedPrivateLinkResourceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  params: `search-management-request-options`,
): ArmResponse<SharedPrivateLinkResource> | CloudError;

/**
 * Initiates the creation or update of a shared private link resource managed by the search service in the given resource group.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@autoRoute
@put
op SharedPrivateLinkResourcesCreateOrUpdateCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...CommonTypes.ResourceGroupNameParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  /** The name of the Azure AI Search service associated with the specified resource group. */
  @path
  @segment("searchServices")
  @key
  @pattern("^(?=.{2,60}$)[a-z0-9][a-z0-9]+(-[a-z0-9]+)*$")
  searchServiceName: string,

  /**
   * The name of the shared private link resource managed by the Azure AI Search service within the specified resource group.
   */
  @path
  sharedPrivateLinkResourceName: string,

  /**
   * The definition of the shared private link resource to create or update.
   */
  resource: SharedPrivateLinkResource,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  params: `search-management-request-options`,
): ArmResourceUpdatedResponse<SharedPrivateLinkResource> | ArmAcceptedLroResponse<
  "Resource operation accepted.",
  ArmAsyncOperationHeader<
    ArmOperationStatus<never, ResourceProvisioningState>,
    string,
    SharedPrivateLinkResource
  >
> | CloudError;

/**
 * Initiates the deletion of the shared private link resource from the search service.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@autoRoute
@delete
op SharedPrivateLinkResourcesDeleteCustomization(
  ...ApiVersionParameter,
  ...SubscriptionIdParameter,
  ...CommonTypes.ResourceGroupNameParameter,
  ...Azure.ResourceManager.Legacy.Provider,

  /** The name of the Azure AI Search service associated with the specified resource group. */
  @path
  @segment("searchServices")
  @key
  @pattern("^(?=.{2,60}$)[a-z0-9][a-z0-9]+(-[a-z0-9]+)*$")
  searchServiceName: string,

  /**
   * The name of the shared private link resource managed by the Azure AI Search service within the specified resource group.
   */
  @path
  sharedPrivateLinkResourceName: string,

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  params: `search-management-request-options`,
):
  | ArmAcceptedLroResponse<
      "Resource operation accepted.",
      {
        azureAsyncOperation: string;
        retryAfter: int32;
      }
    >
  | NoContentResponse
  | NotFoundResponse
  | CloudError;

@@clientName(privateEndpointConnectionsUpdateCustomization::parameters.resource,
  "privateEndpointConnection",
  "go"
);
@@clientName(SharedPrivateLinkResourcesCreateOrUpdateCustomization::parameters.resource,
  "sharedPrivateLinkResource",
  "go"
);
@@clientName(servicesCheckNameAvailabilityCustomization::parameters.body,
  "checkNameAvailabilityInput",
  "go"
);

@@Azure.ClientGenerator.Core.override(ServicesOperationGroup.checkNameAvailability,
  servicesCheckNameAvailabilityCustomization,
  "!java,!python,!javascript"
);
@@Azure.ClientGenerator.Core.override(UsagesOperationGroup.listBySubscription,
  usagesListBySubscriptionCustomization,
  "!java,!python,!javascript"
);
@@Azure.ClientGenerator.Core.override(usageBySubscriptionSku,
  usageBySubscriptionSkuCustomization,
  "!java,!python,!javascript"
);
@@Azure.ClientGenerator.Core.override(SearchServices.listBySubscription,
  searchServicesListBySubscriptionCustomization,
  "!java,!python,!javascript"
);
@@Azure.ClientGenerator.Core.override(SearchServices.listByResourceGroup,
  searchServicesListByResourceGroupCustomization,
  "!java,!python,!javascript"
);
@@Azure.ClientGenerator.Core.override(SearchServices.get,
  searchGetCustomization,
  "!java,!python,!javascript"
);
@@Azure.ClientGenerator.Core.override(SearchServices.createOrUpdate,
  searchCreateOrUpdateCustomization,
  "!java,!python,!javascript"
);
@@Azure.ClientGenerator.Core.override(SearchServices.update,
  searchUpdateCustomization,
  "!java,!python,!javascript"
);
@@Azure.ClientGenerator.Core.override(SearchServices.delete,
  searchDeleteCustomization,
  "!java,!python,!javascript"
);
@@Azure.ClientGenerator.Core.override(SearchServices.create,
  queryKeysCreateCustomization,
  "!java,!python,!javascript"
);
@@Azure.ClientGenerator.Core.override(SearchServices.queryKeysDelete,
  queryKeysDeleteCustomization,
  "!java,!python,!javascript"
);
@@Azure.ClientGenerator.Core.override(SearchServices.adminKeysGet,
  adminKeysGetCustomization,
  "!java,!python,!javascript"
);
@@Azure.ClientGenerator.Core.override(SearchServices.listBySearchService,
  queryKeysListBySearchServiceCustomization,
  "!java,!python,!javascript"
);
@@Azure.ClientGenerator.Core.override(PrivateEndpointConnections.listByService,
  privateEndpointConnectionsListByServiceCustomization,
  "!java,!python,!javascript"
);
@@Azure.ClientGenerator.Core.override(PrivateEndpointConnections.get,
  privateEndpointConnectionsGetCustomization,
  "!java,!python,!javascript"
);
@@Azure.ClientGenerator.Core.override(PrivateEndpointConnections.update,
  privateEndpointConnectionsUpdateCustomization,
  "!java,!python,!javascript"
);
@@Azure.ClientGenerator.Core.override(PrivateEndpointConnections.delete,
  privateEndpointConnectionsDeleteCustomization,
  "!java,!python,!javascript"
);
@@Azure.ClientGenerator.Core.override(SearchServices.listSupported,
  privateLinkResourcesListSupportedCustomization,
  "!java,!python,!javascript"
);
@@Azure.ClientGenerator.Core.override(SearchServices.regenerate,
  privateLinkResourcesRegenerateCustomization,
  "!java,!python,!javascript"
);
@@Azure.ClientGenerator.Core.override(SharedPrivateLinkResources.listByService,
  SharedPrivateLinkResourcesListByServiceCustomization,
  "!java,!python,!javascript"
);
@@Azure.ClientGenerator.Core.override(SharedPrivateLinkResources.get,
  SharedPrivateLinkResourcesGetCustomization,
  "!java,!python,!javascript"
);
@@Azure.ClientGenerator.Core.override(SharedPrivateLinkResources.createOrUpdate,
  SharedPrivateLinkResourcesCreateOrUpdateCustomization,
  "!java,!python,!javascript"
);
@@Azure.ClientGenerator.Core.override(SharedPrivateLinkResources.delete,
  SharedPrivateLinkResourcesDeleteCustomization,
  "!java,!python,!javascript"
);

@@clientName(Microsoft.Search, "SearchManagementClient", "python, javascript");

@@clientName(servicesCheckNameAvailabilityCustomization::parameters.params,
  "searchManagementRequestOptions",
  "go"
);
@@clientName(usagesListBySubscriptionCustomization::parameters.params,
  "searchManagementRequestOptions",
  "go"
);
@@clientName(usageBySubscriptionSkuCustomization::parameters.params,
  "searchManagementRequestOptions",
  "go"
);
@@clientName(searchServicesListBySubscriptionCustomization::parameters.params,
  "searchManagementRequestOptions",
  "go"
);
@@clientName(searchServicesListByResourceGroupCustomization::parameters.params,
  "searchManagementRequestOptions",
  "go"
);
@@clientName(searchGetCustomization::parameters.params,
  "searchManagementRequestOptions",
  "go"
);
@@clientName(searchCreateOrUpdateCustomization::parameters.params,
  "searchManagementRequestOptions",
  "go"
);
@@clientName(searchUpdateCustomization::parameters.params,
  "searchManagementRequestOptions",
  "go"
);
@@clientName(searchDeleteCustomization::parameters.params,
  "searchManagementRequestOptions",
  "go"
);
@@clientName(queryKeysCreateCustomization::parameters.params,
  "searchManagementRequestOptions",
  "go"
);
@@clientName(queryKeysDeleteCustomization::parameters.params,
  "searchManagementRequestOptions",
  "go"
);

@@clientName(adminKeysGetCustomization::parameters.params,
  "searchManagementRequestOptions",
  "go"
);
@@clientName(queryKeysListBySearchServiceCustomization::parameters.params,
  "searchManagementRequestOptions",
  "go"
);
@@clientName(privateEndpointConnectionsListByServiceCustomization::parameters.params,
  "searchManagementRequestOptions",
  "go"
);
@@clientName(privateEndpointConnectionsGetCustomization::parameters.params,
  "searchManagementRequestOptions",
  "go"
);
@@clientName(privateEndpointConnectionsUpdateCustomization::parameters.params,
  "searchManagementRequestOptions",
  "go"
);
@@clientName(privateEndpointConnectionsDeleteCustomization::parameters.params,
  "searchManagementRequestOptions",
  "go"
);
@@clientName(privateLinkResourcesListSupportedCustomization::parameters.params,
  "searchManagementRequestOptions",
  "go"
);
@@clientName(privateLinkResourcesRegenerateCustomization::parameters.params,
  "searchManagementRequestOptions",
  "go"
);
@@clientName(SharedPrivateLinkResourcesListByServiceCustomization::parameters.params,
  "searchManagementRequestOptions",
  "go"
);
@@clientName(SharedPrivateLinkResourcesGetCustomization::parameters.params,
  "searchManagementRequestOptions",
  "go"
);
@@clientName(SharedPrivateLinkResourcesCreateOrUpdateCustomization::parameters.params,
  "searchManagementRequestOptions",
  "go"
);
@@clientName(SharedPrivateLinkResourcesDeleteCustomization::parameters.params,
  "searchManagementRequestOptions",
  "go"
);
@@clientLocation(usageBySubscriptionSku, "ManagementClient", "go");
/** Network security perimeter configuration */
model AccessRulePropertiesSubscriptionsItem {
  /** The fully qualified Azure resource ID of the subscription e.g. ('/subscriptions/00000000-0000-0000-0000-000000000000') */
  id?: Azure.Core.armResourceIdentifier;
}
@@alternateType(Azure.ResourceManager.CommonTypes.AccessRuleProperties.subscriptions,
  AccessRulePropertiesSubscriptionsItem[],
  "go,python,javascript"
);

@@clientName(SearchServiceProperties.eTag, "etag", "java");
