import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Domain.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.EventGrid;
/**
 * Event Subscription.
 */
model EventSubscription
  is Azure.ResourceManager.ProxyResource<EventSubscriptionProperties> {
  ...ResourceNameParameter<
    Resource = EventSubscription,
    KeyName = "eventSubscriptionName",
    SegmentName = "eventSubscriptions",
    NamePattern = ""
  >;
}

alias EventSubscriptionOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of the top level domain. */
    @path
    @segment("domains")
    @key
    domainName: string;

    /** Name of the domain topic. */
    @path
    @segment("topics")
    @key
    topicName: string;
  },
  {
    /** Name of the event subscription to be found. */
    @path
    @segment("eventSubscriptions")
    @key
    eventSubscriptionName: string;
  }
>;

alias EventSubScriptionExtensionOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;

    /** Namespace of the provider of the topic. */
    @path
    @segment("providers")
    @key
    providerNamespace: string;

    /**
     * Name of the resource type.
     */
    @path
    resourceTypeName: string;

    /**
     * Name of the resource.
     */
    @path
    resourceName: string;
  },
  {
    ...Extension.ExtensionProviderNamespace<EventSubscription>;
  },
  {}
>;

alias EventSubScriptionListyByDomainExtensionOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of the top level domain. */
    @path
    @segment("domains")
    @key
    domainName: string;

    /**
     * Name of the domain topic.
     */
    @path
    @segment("topics")
    @key
    topicName: string;
  },
  {
    ...Extension.ExtensionProviderNamespace<EventSubscription>;
  },
  {}
>;

@armResourceOperations
interface EventSubscriptions {
  /**
   * Get properties of a nested event subscription for a domain topic.
   */
  @summary("Get a nested event subscription for domain topic.")
  get is EventSubscriptionOps.Read<EventSubscription>;

  /**
   * Asynchronously creates a new event subscription or updates an existing event subscription.
   */
  @summary("Create or update a nested event subscription to a domain topic.")
  createOrUpdate is EventSubscriptionOps.CreateOrUpdateAsync<
    EventSubscription,
    LroHeaders = ArmLroLocationHeader<FinalResult = EventSubscription> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update an existing event subscription for a domain topic.
   */
  @summary("Update a nested event subscription for a domain topic.")
  @patch(#{ implicitOptionality: false })
  update is EventSubscriptionOps.CustomPatchAsync<
    EventSubscription,
    PatchModel = EventSubscriptionUpdateParameters,
    Response = ArmResourceCreatedResponse<
      EventSubscription,
      LroHeaders = ArmLroLocationHeader
    >
  >;

  /**
   * Delete a nested existing event subscription for a domain topic.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete a nested event subscription for a domain topic.")
  delete is EventSubscriptionOps.DeleteWithoutOkAsync<
    EventSubscription,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all event subscriptions that have been created for a specific domain topic.
   */
  @summary("List all nested event subscriptions for a specific domain topic.")
  list is EventSubscriptionOps.List<
    EventSubscription,
    Parameters = {
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
   * Get all delivery attributes for an event subscription for domain topic.
   */
  @summary("Get delivery attributes for an event subscription for domain topic.")
  @list
  getDeliveryAttributes is EventSubscriptionOps.ActionSync<
    EventSubscription,
    void,
    ArmResponse<DeliveryAttributeListResult>
  >;

  /**
   * Get the full endpoint URL for a nested event subscription for domain topic.
   */
  @summary("Get full URL of a nested event subscription for domain topic.")
  getFullUrl is EventSubscriptionOps.ActionSync<
    EventSubscription,
    void,
    ArmResponse<EventSubscriptionFullUrl>
  >;

  /**
   *List all global event subscriptions under a specific Azure subscription and resource group.
   */
  @summary("List all global event subscriptions under an Azure subscription and resource group.")
  listGlobalByResourceGroup is Extension.ListByTarget<
    Extension.ResourceGroup,
    EventSubscription,
    Parameters = {
      /**
       * The query used to filter the search results using OData syntax. Filtering is permitted on the 'name' property only and with limited number of OData operations. These operations are: the 'contains' function as well as the following logical operations: not, and, or, eq (for equal), and ne (for not equal). No arithmetic operations are supported. The following is a valid filter example: $filter=contains(namE, 'PATTERN') and name ne 'PATTERN-1'. The following is not a valid filter example: $filter=location eq 'westus'.
       */
      @query
      $filter?: string;

      /**
       * The number of results to return per page for the list operation. Valid range for top parameter is 1 to 100. If not specified, the default number of results to be returned is 20 items per page.
       */
      @query
      $top?: int32;
    },
    Response = ArmResponse<EventSubscriptionsListResult>
  >;

  /**
   * List all event subscriptions that have been created for a specific domain topic.
   */
  @summary("List all event subscriptions for a specific domain topic.")
  listByDomainTopic is EventSubScriptionListyByDomainExtensionOps.List<
    EventSubscription,
    Parameters = {
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
}
alias TopicEventSubscriptionOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of the topic. */
    @path
    @segment("topics")
    @key
    topicName: string;
  },
  {
    /** Name of the event subscription to be found. */
    @path
    @segment("eventSubscriptions")
    @key
    eventSubscriptionName: string;
  }
>;

@armResourceOperations
interface TopicEventSubscriptions {
  /**
   * Get properties of an event subscription of a topic.
   */
  @summary("Get an event subscription of a topic.")
  get is TopicEventSubscriptionOps.Read<EventSubscription>;

  /**
   * Asynchronously creates a new event subscription or updates an existing event subscription.
   */
  @summary("Create or update an event subscription to a topic.")
  createOrUpdate is TopicEventSubscriptionOps.CreateOrUpdateAsync<
    EventSubscription,
    LroHeaders = ArmLroLocationHeader<FinalResult = EventSubscription> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update an existing event subscription for a topic.
   */
  @summary("Update an event subscription for a topic.")
  @patch(#{ implicitOptionality: false })
  update is TopicEventSubscriptionOps.CustomPatchAsync<
    EventSubscription,
    PatchModel = EventSubscriptionUpdateParameters,
    Response = ArmResourceCreatedResponse<
      EventSubscription,
      LroHeaders = ArmLroLocationHeader
    >
  >;

  /**
   * Delete an existing event subscription for a topic.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete an event subscription for a topic.")
  delete is TopicEventSubscriptionOps.DeleteWithoutOkAsync<
    EventSubscription,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all event subscriptions that have been created for a specific topic.
   */
  @summary("List all event subscriptions for a specific topic.")
  list is TopicEventSubscriptionOps.List<
    EventSubscription,
    Parameters = {
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
   * Get all delivery attributes for an event subscription for topic.
   */
  @summary("Get delivery attributes for an event subscription for topic.")
  @list
  getDeliveryAttributes is TopicEventSubscriptionOps.ActionSync<
    EventSubscription,
    void,
    ArmResponse<DeliveryAttributeListResult>
  >;

  /**
   * Get the full endpoint URL for an event subscription for topic.
   */
  @summary("Get full URL of an event subscription for topic.")
  getFullUrl is TopicEventSubscriptionOps.ActionSync<
    EventSubscription,
    void,
    ArmResponse<EventSubscriptionFullUrl>
  >;
}
alias DomainEventSubscriptionOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of the domain. */
    @path
    @segment("domains")
    @key
    domainName: string;
  },
  {
    /** Name of the event subscription to be found. */
    @path
    @segment("eventSubscriptions")
    @key
    eventSubscriptionName: string;
  }
>;

@armResourceOperations
interface DomainEventSubscriptions {
  /**
   * Get properties of an event subscription of a domain.
   */
  @summary("Get an event subscription of a domain.")
  get is DomainEventSubscriptionOps.Read<EventSubscription>;

  /**
   * Asynchronously creates a new event subscription or updates an existing event subscription.
   */
  @summary("Create or update an event subscription to a domain.")
  createOrUpdate is DomainEventSubscriptionOps.CreateOrUpdateAsync<
    EventSubscription,
    LroHeaders = ArmLroLocationHeader<FinalResult = EventSubscription> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update an existing event subscription for a topic.
   */
  @summary("Update an event subscription for a domain.")
  @patch(#{ implicitOptionality: false })
  update is DomainEventSubscriptionOps.CustomPatchAsync<
    EventSubscription,
    PatchModel = EventSubscriptionUpdateParameters,
    Response = ArmResourceCreatedResponse<
      EventSubscription,
      LroHeaders = ArmLroLocationHeader
    >
  >;

  /**
   * Delete an existing event subscription for a domain.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete an event subscription for a domain.")
  delete is DomainEventSubscriptionOps.DeleteWithoutOkAsync<
    EventSubscription,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all event subscriptions that have been created for a specific topic.
   */
  @summary("List all event subscriptions for a specific domain.")
  list is DomainEventSubscriptionOps.List<
    EventSubscription,
    Parameters = {
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
   * Get all delivery attributes for an event subscription for domain.
   */
  @summary("Get delivery attributes for an event subscription for domain.")
  @list
  getDeliveryAttributes is DomainEventSubscriptionOps.ActionSync<
    EventSubscription,
    void,
    ArmResponse<DeliveryAttributeListResult>
  >;

  /**
   * Get the full endpoint URL for an event subscription for domain.
   */
  @summary("Get full URL of an event subscription for domain.")
  getFullUrl is DomainEventSubscriptionOps.ActionSync<
    EventSubscription,
    void,
    ArmResponse<EventSubscriptionFullUrl>
  >;
}
alias EventSubscriptionOperationGroupOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** undefined */
    @path
    @segment("")
    @key
    scope: string;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.EventGrid";
  },
  {},
  {
    /** Name of the event subscription to be found. */
    @path
    @segment("eventSubscriptions")
    @key
    eventSubscriptionName: string;
  }
>;

@armResourceOperations
interface EventSubscriptionOperationGroup {
  /**
   * Get properties of an event subscription.
   */
  @summary("Get an event subscription.")
  get is EventSubscriptionOperationGroupOps.Read<EventSubscription>;

  /**
   * Asynchronously creates a new event subscription or updates an existing event subscription based on the specified scope.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Create or update an event subscription.")
  createOrUpdate is EventSubscriptionOperationGroupOps.CreateOrUpdateAsync<
    EventSubscription,
    Response = ArmResourceCreatedResponse<
      EventSubscription,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * Asynchronously updates an existing event subscription.
   */
  @summary("Update an event subscription.")
  @patch(#{ implicitOptionality: false })
  update is EventSubscriptionOperationGroupOps.CustomPatchAsync<
    EventSubscription,
    PatchModel = EventSubscriptionUpdateParameters,
    Response = ArmResourceCreatedResponse<
      EventSubscription,
      LroHeaders = ArmLroLocationHeader<FinalResult = EventSubscription>
    >
  >;

  /**
   * Delete an existing event subscription.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete an event subscription.")
  delete is EventSubscriptionOperationGroupOps.DeleteWithoutOkAsync<
    EventSubscription,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all aggregated global event subscriptions under a specific Azure subscription.
   */
  @summary("Get an aggregated list of all global event subscriptions under an Azure subscription.")
  listGlobalBySubscription is Extension.ListByTarget<
    Extension.Subscription,
    EventSubscription,
    Parameters = {
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
   * List all event subscriptions that have been created for a specific resource.
   */
  @summary("List all event subscriptions.")
  listByResource is EventSubScriptionExtensionOps.List<
    EventSubscription,
    Parameters = {
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
   * Get all delivery attributes for an event subscription.
   */
  @summary("Get delivery attributes for an event subscription.")
  @list
  getDeliveryAttributes is EventSubscriptionOperationGroupOps.ActionSync<
    Extension.ScopeParameter,
    void,
    ArmResponse<DeliveryAttributeListResult>
  >;

  /**
   * Get the full endpoint URL for an event subscription.
   */
  @summary("Get full URL of an event subscription.")
  getFullUrl is EventSubscriptionOperationGroupOps.ActionSync<
    Extension.ScopeParameter,
    void,
    ArmResponse<EventSubscriptionFullUrl>
  >;
}
alias SystemTopicEventSubscriptionOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of the system topic. */
    @path
    @segment("systemTopics")
    @key
    systemTopicName: string;
  },
  {
    /** Name of the event subscription to be found. */
    @path
    @segment("eventSubscriptions")
    @key
    eventSubscriptionName: string;
  }
>;

@armResourceOperations
interface SystemTopicEventSubscriptions {
  /**
   * Get an event subscription.
   */
  @summary("Get an event subscription of a system topic.")
  get is SystemTopicEventSubscriptionOps.Read<EventSubscription>;

  /**
   * Asynchronously creates or updates an event subscription with the specified parameters. Existing event subscriptions will be updated with this API.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Create or update an event subscription for a system topic.")
  createOrUpdate is SystemTopicEventSubscriptionOps.CreateOrUpdateAsync<
    EventSubscription,
    Response = ArmResourceCreatedResponse<
      EventSubscription,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * Update an existing event subscription of a system topic.
   */
  @summary("Update event subscription of a system topic.")
  @patch(#{ implicitOptionality: false })
  update is SystemTopicEventSubscriptionOps.CustomPatchAsync<
    EventSubscription,
    PatchModel = EventSubscriptionUpdateParameters,
    Response = ArmResourceCreatedResponse<
      EventSubscription,
      LroHeaders = ArmLroLocationHeader
    >
  >;

  /**
   * Delete an existing event subscription of a system topic.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete an event subscription of a system topic.")
  delete is SystemTopicEventSubscriptionOps.DeleteWithoutOkAsync<
    EventSubscription,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List event subscriptions that belong to a specific system topic.
   */
  @summary("List event subscriptions of a system topic.")
  listBySystemTopic is SystemTopicEventSubscriptionOps.List<
    EventSubscription,
    Parameters = {
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
   * Get all delivery attributes for an event subscription.
   */
  @summary("Get delivery attributes for an event subscription.")
  @list
  getDeliveryAttributes is SystemTopicEventSubscriptionOps.ActionSync<
    EventSubscription,
    void,
    ArmResponse<DeliveryAttributeListResult>
  >;

  /**
   * Get the full endpoint URL for an event subscription of a system topic.
   */
  @summary("Get full URL of an event subscription of a system topic.")
  getFullUrl is SystemTopicEventSubscriptionOps.ActionSync<
    EventSubscription,
    void,
    ArmResponse<EventSubscriptionFullUrl>
  >;
}
alias PartnerTopicEventSubscriptionOps = Azure.ResourceManager.Legacy.LegacyOperations<
  {
    ...ApiVersionParameter;
    ...SubscriptionIdParameter;
    ...ResourceGroupParameter;
    ...Azure.ResourceManager.Legacy.Provider;

    /** Name of the partner topic. */
    @path
    @segment("partnerTopics")
    @key
    partnerTopicName: string;
  },
  {
    /** Name of the event subscription to be found. */
    @path
    @segment("eventSubscriptions")
    @key
    eventSubscriptionName: string;
  }
>;

@armResourceOperations
interface PartnerTopicEventSubscriptions {
  /**
   * Get properties of an event subscription of a partner topic.
   */
  @summary("Get an event subscription of a partner topic.")
  get is PartnerTopicEventSubscriptionOps.Read<EventSubscription>;

  /**
   * Asynchronously creates or updates an event subscription of a partner topic with the specified parameters. Existing event subscriptions will be updated with this API.
   */
  @summary("Create or update an event subscription of a partner topic.")
  createOrUpdate is PartnerTopicEventSubscriptionOps.CreateOrUpdateAsync<
    EventSubscription,
    LroHeaders = ArmLroLocationHeader<FinalResult = EventSubscription> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update an existing event subscription of a partner topic.
   */
  @summary("Update event subscription of a partner topic.")
  @patch(#{ implicitOptionality: false })
  update is PartnerTopicEventSubscriptionOps.CustomPatchAsync<
    EventSubscription,
    PatchModel = EventSubscriptionUpdateParameters,
    Response = ArmResourceCreatedResponse<
      EventSubscription,
      LroHeaders = ArmLroLocationHeader
    >
  >;

  /**
   * Delete an existing event subscription of a partner topic.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete an event subscription of a partner topic.")
  delete is PartnerTopicEventSubscriptionOps.DeleteWithoutOkAsync<
    EventSubscription,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List event subscriptions that belong to a specific partner topic.
   */
  @summary("List event subscriptions of a partner topic.")
  listByPartnerTopic is PartnerTopicEventSubscriptionOps.List<
    EventSubscription,
    Parameters = {
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
   * Get the full endpoint URL for an event subscription of a partner topic.
   */
  @summary("Get full URL of an event subscription of a partner topic.")
  getFullUrl is PartnerTopicEventSubscriptionOps.ActionSync<
    EventSubscription,
    void,
    ArmResponse<EventSubscriptionFullUrl>
  >;

  /**
   * Get all delivery attributes for an event subscription of a partner topic.
   */
  @summary("Get delivery attributes for an event subscription of a partner topic.")
  @list
  getDeliveryAttributes is PartnerTopicEventSubscriptionOps.ActionSync<
    EventSubscription,
    void,
    ArmResponse<DeliveryAttributeListResult>
  >;
}

@@doc(EventSubscription.name, "Name of the event subscription to be found.");
@@doc(EventSubscription.properties, "Properties of the event subscription.");
@@doc(EventSubscriptions.createOrUpdate::parameters.resource,
  "Event subscription properties containing the destination and filter information."
);
@@doc(EventSubscriptions.update::parameters.properties,
  "Updated event subscription information."
);
@@doc(TopicEventSubscriptions.createOrUpdate::parameters.resource,
  "Event subscription properties containing the destination and filter information."
);
@@doc(TopicEventSubscriptions.update::parameters.properties,
  "Updated event subscription information."
);
@@doc(DomainEventSubscriptions.createOrUpdate::parameters.resource,
  "Event subscription properties containing the destination and filter information."
);
@@doc(DomainEventSubscriptions.update::parameters.properties,
  "Updated event subscription information."
);
@@doc(EventSubscriptionOperationGroup.createOrUpdate::parameters.resource,
  "Event subscription properties containing the destination and filter information."
);
@@doc(EventSubscriptionOperationGroup.update::parameters.properties,
  "Updated event subscription information."
);
@@doc(SystemTopicEventSubscriptions.createOrUpdate::parameters.resource,
  "Event subscription properties containing the destination and filter information."
);
@@doc(SystemTopicEventSubscriptions.update::parameters.properties,
  "Updated event subscription information."
);
@@doc(PartnerTopicEventSubscriptions.createOrUpdate::parameters.resource,
  "Event subscription properties containing the destination and filter information."
);
@@doc(PartnerTopicEventSubscriptions.update::parameters.properties,
  "Updated event subscription information."
);
