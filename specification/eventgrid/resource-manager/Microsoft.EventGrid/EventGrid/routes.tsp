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

alias ExtensionOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: string;
  },
  {},
  {
    /** Name of the event type to be found. */
    @path
    @segment("eventTypes")
    @key
    eventTypeName: string;
  }
>;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface EventSubscriptionsOperationGroup {
  /**
   * List all global event subscriptions under an Azure subscription for a topic type.
   */
  @summary("List all global event subscriptions for a topic type.")
  @autoRoute
  @get
  @list
  @action("eventSubscriptions")
  listGlobalBySubscriptionForTopicType is ArmProviderActionSync<
    Response = ArmResponse<EventSubscriptionsListResult>,
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
  @summary("List all global event subscriptions under a resource group for a topic type.")
  @autoRoute
  @get
  @list
  @action("eventSubscriptions")
  listGlobalByResourceGroupForTopicType is ArmProviderActionSync<
    Response = ArmResponse<EventSubscriptionsListResult>,
    Scope = Extension.ResourceGroup,
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
   * List all event subscriptions from the given location under a specific Azure subscription.
   */
  @summary("List all regional event subscriptions under an Azure subscription.")
  @autoRoute
  @get
  @list
  @action("eventSubscriptions")
  listRegionalBySubscription is ArmProviderActionSync<
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
    },
    Response = ArmResponse<EventSubscriptionsListResult>
  >;
  /**
   * List all event subscriptions from the given location under a specific Azure subscription and resource group.
   */
  @summary("List all regional event subscriptions under an Azure subscription and resource group.")
  @autoRoute
  @get
  @list
  @action("eventSubscriptions")
  listRegionalByResourceGroup is ArmProviderActionSync<
    Scope = Extension.ResourceGroup,
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
    },
    Response = ArmResponse<EventSubscriptionsListResult>
  >;
  /**
   * List all event subscriptions from the given location under a specific Azure subscription and topic type.
   */
  @summary("List all regional event subscriptions under an Azure subscription for a topic type.")
  @autoRoute
  @get
  @list
  @action("eventSubscriptions")
  listRegionalBySubscriptionForTopicType is ArmProviderActionSync<
    Response = ArmResponse<EventSubscriptionsListResult>,
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
  @summary("List all regional event subscriptions under an Azure subscription and resource group for a topic type.")
  @autoRoute
  @get
  @list
  @action("eventSubscriptions")
  listRegionalByResourceGroupForTopicType is ArmProviderActionSync<
    Response = ArmResponse<EventSubscriptionsListResult>,
    Scope = Extension.ResourceGroup,
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
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface TopicsOperationGroup {
  /**
   * List event types for a topic.
   */
  @summary("List topic event types.")
  @action("eventTypes")
  @get
  listEventTypes is ExtensionOps.List<
    Azure.ResourceManager.Foundations.SimpleResource,
    Parameters = {
      /**
       * Name of the topic type.
       */
      @path
      resourceTypeName: string;

      /**
       * Name of the topic.
       */
      @path
      resourceName: string;

      /**
       * Namespace of the provider of the topic.
       */
      @path
      @segment("providers")
      extensionProviderNamespace: "microsoft.EventGrid";
    },
    Response = EventTypesListResult
  >;
}
