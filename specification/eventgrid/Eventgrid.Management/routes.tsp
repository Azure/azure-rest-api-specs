// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.EventGrid;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface EventSubscriptionsOperationGroup {
  /**
   * List all global event subscriptions under an Azure subscription for a topic type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("List all global event subscriptions for a topic type.")
  @operationId("EventSubscriptions_ListGlobalBySubscriptionForTopicType")
  @autoRoute
  @get
  @action("eventSubscriptions")
  listGlobalBySubscriptionForTopicType is ArmProviderActionSync<
    Response = ResourceListResult<EventSubscription>,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * Name of the topic type.
       */
      @path
      @segment("topicTypes")
      topicTypeName: string;

      /**
       * The query used to filter the search results using OData syntax. Filtering is permitted on the 'name' property only and with limited number of OData operations. These operations are: the 'contains' function as well as the following logical operations: not, and, or, eq (for equal), and ne (for not equal). No arithmetic operations are supported. The following is a valid filter example: $filter=contains(namE, 'PATTERN') and name ne 'PATTERN-1'. The following is not a valid filter example: $filter=location eq 'westus'.
       */
      @query("$filter")
      $filter?: string;

      /**
       * The number of results to return per page for the list operation. Valid range for top parameter is 1 to 100. If not specified, the default number of results to be returned is 20 items per page.
       */
      @query("$top")
      $top?: int32;
    }
  >;
  /**
   * List all global event subscriptions under a resource group for a specific topic type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("List all global event subscriptions under a resource group for a topic type.")
  @operationId("EventSubscriptions_ListGlobalByResourceGroupForTopicType")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventGrid/topicTypes/{topicTypeName}/eventSubscriptions")
  @get
  listGlobalByResourceGroupForTopicType(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Name of the topic type.
     */
    @path
    topicTypeName: string,

    /**
     * The query used to filter the search results using OData syntax. Filtering is permitted on the 'name' property only and with limited number of OData operations. These operations are: the 'contains' function as well as the following logical operations: not, and, or, eq (for equal), and ne (for not equal). No arithmetic operations are supported. The following is a valid filter example: $filter=contains(namE, 'PATTERN') and name ne 'PATTERN-1'. The following is not a valid filter example: $filter=location eq 'westus'.
     */
    @query("$filter")
    $filter?: string,

    /**
     * The number of results to return per page for the list operation. Valid range for top parameter is 1 to 100. If not specified, the default number of results to be returned is 20 items per page.
     */
    @query("$top")
    $top?: int32,
  ): ArmResponse<ResourceListResult<EventSubscription>> | ErrorResponse;

  /**
   * List all event subscriptions from the given location under a specific Azure subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("List all regional event subscriptions under an Azure subscription.")
  @operationId("EventSubscriptions_ListRegionalBySubscription")
  @autoRoute
  @get
  @action("eventSubscriptions")
  listRegionalBySubscription is ArmProviderActionSync<
    Response = ResourceListResult<EventSubscription>,
    Scope = SubscriptionActionScope,
    Parameters = {
      ...LocationParameter;

      /**
       * The query used to filter the search results using OData syntax. Filtering is permitted on the 'name' property only and with limited number of OData operations. These operations are: the 'contains' function as well as the following logical operations: not, and, or, eq (for equal), and ne (for not equal). No arithmetic operations are supported. The following is a valid filter example: $filter=contains(namE, 'PATTERN') and name ne 'PATTERN-1'. The following is not a valid filter example: $filter=location eq 'westus'.
       */
      @query("$filter")
      $filter?: string;

      /**
       * The number of results to return per page for the list operation. Valid range for top parameter is 1 to 100. If not specified, the default number of results to be returned is 20 items per page.
       */
      @query("$top")
      $top?: int32;
    }
  >;
  /**
   * List all event subscriptions from the given location under a specific Azure subscription and resource group.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("List all regional event subscriptions under an Azure subscription and resource group.")
  @operationId("EventSubscriptions_ListRegionalByResourceGroup")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventGrid/locations/{location}/eventSubscriptions")
  @get
  listRegionalByResourceGroup(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,
    ...LocationResourceParameter,

    /**
     * The query used to filter the search results using OData syntax. Filtering is permitted on the 'name' property only and with limited number of OData operations. These operations are: the 'contains' function as well as the following logical operations: not, and, or, eq (for equal), and ne (for not equal). No arithmetic operations are supported. The following is a valid filter example: $filter=contains(namE, 'PATTERN') and name ne 'PATTERN-1'. The following is not a valid filter example: $filter=location eq 'westus'.
     */
    @query("$filter")
    $filter?: string,

    /**
     * The number of results to return per page for the list operation. Valid range for top parameter is 1 to 100. If not specified, the default number of results to be returned is 20 items per page.
     */
    @query("$top")
    $top?: int32,
  ): ArmResponse<ResourceListResult<EventSubscription>> | ErrorResponse;

  /**
   * List all event subscriptions from the given location under a specific Azure subscription and topic type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("List all regional event subscriptions under an Azure subscription for a topic type.")
  @operationId("EventSubscriptions_ListRegionalBySubscriptionForTopicType")
  @autoRoute
  @get
  @action("eventSubscriptions")
  listRegionalBySubscriptionForTopicType is ArmProviderActionSync<
    Response = ResourceListResult<EventSubscription>,
    Scope = SubscriptionActionScope,
    Parameters = {
      ...LocationParameter;

      /**
       * Name of the topic type.
       */
      @path
      @segment("topicTypes")
      topicTypeName: string;

      /**
       * The query used to filter the search results using OData syntax. Filtering is permitted on the 'name' property only and with limited number of OData operations. These operations are: the 'contains' function as well as the following logical operations: not, and, or, eq (for equal), and ne (for not equal). No arithmetic operations are supported. The following is a valid filter example: $filter=contains(namE, 'PATTERN') and name ne 'PATTERN-1'. The following is not a valid filter example: $filter=location eq 'westus'.
       */
      @query("$filter")
      $filter?: string;

      /**
       * The number of results to return per page for the list operation. Valid range for top parameter is 1 to 100. If not specified, the default number of results to be returned is 20 items per page.
       */
      @query("$top")
      $top?: int32;
    }
  >;
  /**
   * List all event subscriptions from the given location under a specific Azure subscription and resource group and topic type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("List all regional event subscriptions under an Azure subscription and resource group for a topic type.")
  @operationId("EventSubscriptions_ListRegionalByResourceGroupForTopicType")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventGrid/locations/{location}/topicTypes/{topicTypeName}/eventSubscriptions")
  @get
  listRegionalByResourceGroupForTopicType(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,
    ...LocationResourceParameter,

    /**
     * Name of the topic type.
     */
    @path
    topicTypeName: string,

    /**
     * The query used to filter the search results using OData syntax. Filtering is permitted on the 'name' property only and with limited number of OData operations. These operations are: the 'contains' function as well as the following logical operations: not, and, or, eq (for equal), and ne (for not equal). No arithmetic operations are supported. The following is a valid filter example: $filter=contains(namE, 'PATTERN') and name ne 'PATTERN-1'. The following is not a valid filter example: $filter=location eq 'westus'.
     */
    @query("$filter")
    $filter?: string,

    /**
     * The number of results to return per page for the list operation. Valid range for top parameter is 1 to 100. If not specified, the default number of results to be returned is 20 items per page.
     */
    @query("$top")
    $top?: int32,
  ): ArmResponse<ResourceListResult<EventSubscription>> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface TopicsOperationGroup {
  /**
   * List event types for a topic.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @summary("List topic event types.")
  @operationId("Topics_ListEventTypes")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{providerNamespace}/{resourceTypeName}/{resourceName}/providers/Microsoft.EventGrid/eventTypes")
  @get
  listEventTypes(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * Namespace of the provider of the topic.
     */
    @path
    providerNamespace: string,

    /**
     * Name of the topic type.
     */
    @path
    resourceTypeName: string,

    /**
     * Name of the topic.
     */
    @path
    resourceName: string,
  ): ArmResponse<EventTypesListResult> | ErrorResponse;
}
