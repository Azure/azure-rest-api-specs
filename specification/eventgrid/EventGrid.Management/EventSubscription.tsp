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
@parentResource(Domain)
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

@armResourceOperations
interface EventSubscriptions {
  /**
   * Get properties of a nested event subscription for a domain topic.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DomainTopicEventSubscriptions_Get")
  get is EventSubscriptionOps.Read<EventSubscription>;

  /**
   * Asynchronously creates a new event subscription or updates an existing event subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DomainTopicEventSubscriptions_CreateOrUpdate")
  createOrUpdate is EventSubscriptionOps.CreateOrUpdateAsync<
    EventSubscription,
    LroHeaders = ArmLroLocationHeader<FinalResult = EventSubscription> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update an existing event subscription for a domain topic.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DomainTopicEventSubscriptions_Update")
  @patch(#{ implicitOptionality: false })
  update is EventSubscriptionOps.CustomPatchAsync<
    EventSubscription,
    PatchModel = EventSubscriptionUpdateParameters,
    Response = ArmResourceCreatedResponse<EventSubscription>
  >;

  /**
   * Delete a nested existing event subscription for a domain topic.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("DomainTopicEventSubscriptions_Delete")
  delete is EventSubscriptionOps.DeleteWithoutOkAsync<
    EventSubscription,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all event subscriptions that have been created for a specific domain topic.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DomainTopicEventSubscriptions_List")
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
    }
  >;

  /**
   * Get all delivery attributes for an event subscription for domain topic.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DomainTopicEventSubscriptions_GetDeliveryAttributes")
  @list
  getDeliveryAttributes is EventSubscriptionOps.ActionSync<
    EventSubscription,
    void,
    ArmResponse<DeliveryAttributeListResult>
  >;

  /**
   * Get the full endpoint URL for a nested event subscription for domain topic.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DomainTopicEventSubscriptions_GetFullUrl")
  getFullUrl is EventSubscriptionOps.ActionSync<
    EventSubscription,
    void,
    ArmResponse<EventSubscriptionFullUrl>
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
  get is TopicEventSubscriptionOps.Read<EventSubscription>;

  /**
   * Asynchronously creates a new event subscription or updates an existing event subscription.
   */
  createOrUpdate is TopicEventSubscriptionOps.CreateOrUpdateAsync<
    EventSubscription,
    LroHeaders = ArmLroLocationHeader<FinalResult = EventSubscription> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update an existing event subscription for a topic.
   */
  @patch(#{ implicitOptionality: false })
  update is TopicEventSubscriptionOps.CustomPatchAsync<
    EventSubscription,
    PatchModel = EventSubscriptionUpdateParameters,
    Response = ArmResourceCreatedResponse<EventSubscription>
  >;

  /**
   * Delete an existing event subscription for a topic.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is TopicEventSubscriptionOps.DeleteWithoutOkAsync<
    EventSubscription,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all event subscriptions that have been created for a specific topic.
   */
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
    }
  >;

  /**
   * Get all delivery attributes for an event subscription for topic.
   */
  @list
  getDeliveryAttributes is TopicEventSubscriptionOps.ActionSync<
    EventSubscription,
    void,
    ArmResponse<DeliveryAttributeListResult>
  >;

  /**
   * Get the full endpoint URL for an event subscription for topic.
   */
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
  get is DomainEventSubscriptionOps.Read<EventSubscription>;

  /**
   * Asynchronously creates a new event subscription or updates an existing event subscription.
   */
  createOrUpdate is DomainEventSubscriptionOps.CreateOrUpdateAsync<
    EventSubscription,
    LroHeaders = ArmLroLocationHeader<FinalResult = EventSubscription> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update an existing event subscription for a topic.
   */
  @patch(#{ implicitOptionality: false })
  update is DomainEventSubscriptionOps.CustomPatchAsync<
    EventSubscription,
    PatchModel = EventSubscriptionUpdateParameters,
    Response = ArmResourceCreatedResponse<EventSubscription>
  >;

  /**
   * Delete an existing event subscription for a domain.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is DomainEventSubscriptionOps.DeleteWithoutOkAsync<
    EventSubscription,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all event subscriptions that have been created for a specific topic.
   */
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
    }
  >;

  /**
   * Get all delivery attributes for an event subscription for domain.
   */
  @list
  getDeliveryAttributes is DomainEventSubscriptionOps.ActionSync<
    EventSubscription,
    void,
    ArmResponse<DeliveryAttributeListResult>
  >;

  /**
   * Get the full endpoint URL for an event subscription for domain.
   */
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("EventSubscriptions_Get")
  get is EventSubscriptionOperationGroupOps.Read<
    Extension.ScopeParameter,
    EventSubscription
  >;

  /**
   * Asynchronously creates a new event subscription or updates an existing event subscription based on the specified scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("EventSubscriptions_CreateOrUpdate")
  createOrUpdate is EventSubscriptionOperationGroupOps.CreateOrUpdateAsync<
    Extension.ScopeParameter,
    EventSubscription,
    Response = ArmResourceCreatedResponse<
      EventSubscription,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * Asynchronously updates an existing event subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("EventSubscriptions_Update")
  @patch(#{ implicitOptionality: false })
  update is EventSubscriptionOperationGroupOps.CustomPatchAsync<
    Extension.ScopeParameter,
    EventSubscription,
    PatchModel = EventSubscriptionUpdateParameters,
    Response = ArmResourceCreatedResponse<EventSubscription>
  >;

  /**
   * Delete an existing event subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("EventSubscriptions_Delete")
  delete is EventSubscriptionOperationGroupOps.DeleteWithoutOkAsync<
    Extension.ScopeParameter,
    EventSubscription,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all aggregated global event subscriptions under a specific Azure subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("EventSubscriptions_ListGlobalBySubscription")
  listGlobalBySubscription is EventSubscriptionOperationGroupOps.List<
    Extension.ScopeParameter,
    EventSubscription,
    Parameters = {
      ...SubscriptionIdParameter;

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
   * Get all delivery attributes for an event subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("EventSubscriptions_GetDeliveryAttributes")
  @list
  getDeliveryAttributes is EventSubscriptionOperationGroupOps.ActionSync<
    Extension.ScopeParameter,
    EventSubscription,
    void,
    ArmResponse<DeliveryAttributeListResult>
  >;

  /**
   * Get the full endpoint URL for an event subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("EventSubscriptions_GetFullUrl")
  getFullUrl is EventSubscriptionOperationGroupOps.ActionSync<
    Extension.ScopeParameter,
    EventSubscription,
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
  get is SystemTopicEventSubscriptionOps.Read<EventSubscription>;

  /**
   * Asynchronously creates or updates an event subscription with the specified parameters. Existing event subscriptions will be updated with this API.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
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
  @patch(#{ implicitOptionality: false })
  update is SystemTopicEventSubscriptionOps.CustomPatchAsync<
    EventSubscription,
    PatchModel = EventSubscriptionUpdateParameters,
    Response = ArmResourceCreatedResponse<EventSubscription>
  >;

  /**
   * Delete an existing event subscription of a system topic.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is SystemTopicEventSubscriptionOps.DeleteWithoutOkAsync<
    EventSubscription,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List event subscriptions that belong to a specific system topic.
   */
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
    }
  >;

  /**
   * Get all delivery attributes for an event subscription.
   */
  @list
  getDeliveryAttributes is SystemTopicEventSubscriptionOps.ActionSync<
    EventSubscription,
    void,
    ArmResponse<DeliveryAttributeListResult>
  >;

  /**
   * Get the full endpoint URL for an event subscription of a system topic.
   */
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
  get is PartnerTopicEventSubscriptionOps.Read<EventSubscription>;

  /**
   * Asynchronously creates or updates an event subscription of a partner topic with the specified parameters. Existing event subscriptions will be updated with this API.
   */
  createOrUpdate is PartnerTopicEventSubscriptionOps.CreateOrUpdateAsync<
    EventSubscription,
    LroHeaders = ArmLroLocationHeader<FinalResult = EventSubscription> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update an existing event subscription of a partner topic.
   */
  @patch(#{ implicitOptionality: false })
  update is PartnerTopicEventSubscriptionOps.CustomPatchAsync<
    EventSubscription,
    PatchModel = EventSubscriptionUpdateParameters,
    Response = ArmResourceCreatedResponse<EventSubscription>
  >;

  /**
   * Delete an existing event subscription of a partner topic.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is PartnerTopicEventSubscriptionOps.DeleteWithoutOkAsync<
    EventSubscription,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List event subscriptions that belong to a specific partner topic.
   */
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
    }
  >;

  /**
   * Get the full endpoint URL for an event subscription of a partner topic.
   */
  getFullUrl is PartnerTopicEventSubscriptionOps.ActionSync<
    EventSubscription,
    void,
    ArmResponse<EventSubscriptionFullUrl>
  >;

  /**
   * Get all delivery attributes for an event subscription of a partner topic.
   */
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
