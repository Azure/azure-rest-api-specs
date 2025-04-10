import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Topic.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.EventGrid;
/**
 * Event Subscription.
 */
@parentResource(Topic)
model EventSubscription
  is Azure.ResourceManager.ProxyResource<EventSubscriptionProperties> {
  ...ResourceNameParameter<
    Resource = EventSubscription,
    KeyName = "eventSubscriptionName",
    SegmentName = "eventSubscriptions",
    NamePattern = ""
  >;
}

@armResourceOperations
interface EventSubscriptionOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = NamespaceTopic,
          KeyName = "topicName",
          SegmentName = "topics",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = EventSubscription,
        KeyName = "eventSubscriptionName",
        SegmentName = "eventSubscriptions",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface EventSubscriptions {
  /**
   * Get properties of an event subscription of a topic.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("TopicEventSubscriptions_Get")
  get is EventSubscriptionOps.Read<EventSubscription>;

  /**
   * Asynchronously creates a new event subscription or updates an existing event subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("TopicEventSubscriptions_CreateOrUpdate")
  createOrUpdate is EventSubscriptionOps.CreateOrUpdateAsync<
    EventSubscription,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update an existing event subscription for a topic.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("TopicEventSubscriptions_Update")
  update is EventSubscriptionOps.CustomPatchAsync<
    EventSubscription,
    PatchModel = EventSubscriptionUpdateParameters,
    Response = ArmResourceCreatedResponse<EventSubscription>
  >;

  /**
   * Delete an existing event subscription for a topic.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("TopicEventSubscriptions_Delete")
  delete is EventSubscriptionOps.DeleteWithoutOkAsync<
    EventSubscription,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all event subscriptions that have been created for a specific topic.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("TopicEventSubscriptions_List")
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
   * Get all delivery attributes for an event subscription for topic.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("TopicEventSubscriptions_GetDeliveryAttributes")
  getDeliveryAttributes is EventSubscriptionOps.ActionSync<
    EventSubscription,
    void,
    ArmResponse<DeliveryAttributeListResult>
  >;

  /**
   * Get the full endpoint URL for an event subscription for topic.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("TopicEventSubscriptions_GetFullUrl")
  getFullUrl is EventSubscriptionOps.ActionSync<
    EventSubscription,
    void,
    ArmResponse<EventSubscriptionFullUrl>
  >;
}
@armResourceOperations
interface DomainEventSubscriptionOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = Domain,
          KeyName = "domainName",
          SegmentName = "domains",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = EventSubscription,
        KeyName = "eventSubscriptionName",
        SegmentName = "eventSubscriptions",
        NamePattern = ""
      >>
    > {}

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
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
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
@armResourceOperations
interface EventSubscriptionOperationGroupOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,

        /** {scope} */
        @path @segment("{scope}") providers: string,
      },
      KeysOf<ResourceNameParameter<
        Resource = EventSubscription,
        KeyName = "eventSubscriptions",
        SegmentName = "Microsoft.EventGrid",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface EventSubscriptionOperationGroup {
  /**
   * Get properties of an event subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("EventSubscriptions_Get")
  get is EventSubscriptionOperationGroupOps.Read<
    EventSubscription,
    Parameters = {
      /**
       * The scope of the event subscription. The scope can be a subscription, or a resource group, or a top level resource belonging to a resource provider namespace, or an EventGrid topic. For example, use '/subscriptions/{subscriptionId}/' for a subscription, '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}' for a resource group, and '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}' for a resource, and '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventGrid/topics/{topicName}' for an EventGrid topic.
       */
      @path
      scope: string;

      /**
       * Name of the event subscription to be found.
       */
      @path
      eventSubscriptionName: string;
    }
  >;

  /**
   * Asynchronously creates a new event subscription or updates an existing event subscription based on the specified scope.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("EventSubscriptions_CreateOrUpdate")
  createOrUpdate is EventSubscriptionOperationGroupOps.CreateOrUpdateAsync<
    EventSubscription,
    Parameters = {
      /**
       * The identifier of the resource to which the event subscription needs to be created or updated. The scope can be a subscription, or a resource group, or a top level resource belonging to a resource provider namespace, or an EventGrid topic. For example, use '/subscriptions/{subscriptionId}/' for a subscription, '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}' for a resource group, and '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}' for a resource, and '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventGrid/topics/{topicName}' for an EventGrid topic.
       */
      @path
      scope: string;

      /**
       * Name of the event subscription to be created. Event subscription names must be between 3 and 64 characters in length and should use alphanumeric letters only.
       */
      @path
      eventSubscriptionName: string;
    },
    Response = ArmResourceCreatedResponse<
      EventSubscription,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * Asynchronously updates an existing event subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @patch(#{ implicitOptionality: false })
  @operationId("EventSubscriptions_Update")
  update is EventSubscriptionOperationGroupOps.CustomPatchAsync<
    EventSubscription,
    PatchModel = EventSubscriptionUpdateParameters,
    Parameters = {
      /**
       * The scope of existing event subscription. The scope can be a subscription, or a resource group, or a top level resource belonging to a resource provider namespace, or an EventGrid topic. For example, use '/subscriptions/{subscriptionId}/' for a subscription, '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}' for a resource group, and '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}' for a resource, and '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventGrid/topics/{topicName}' for an EventGrid topic.
       */
      @path
      scope: string;

      /**
       * Name of the event subscription to be updated.
       */
      @path
      eventSubscriptionName: string;
    },
    Response = ArmResourceCreatedResponse<EventSubscription>
  >;

  /**
   * Delete an existing event subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("EventSubscriptions_Delete")
  delete is EventSubscriptionOperationGroupOps.DeleteWithoutOkAsync<
    EventSubscription,
    Parameters = {
      /**
       * The scope of the event subscription. The scope can be a subscription, or a resource group, or a top level resource belonging to a resource provider namespace, or an EventGrid topic. For example, use '/subscriptions/{subscriptionId}/' for a subscription, '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}' for a resource group, and '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}' for a resource, and '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventGrid/topics/{topicName}' for an EventGrid topic.
       */
      @path
      scope: string;

      /**
       * Name of the event subscription to be deleted.
       */
      @path
      eventSubscriptionName: string;
    },
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all aggregated global event subscriptions under a specific Azure subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("EventSubscriptions_ListGlobalBySubscription")
  listGlobalBySubscription is EventSubscriptionOperationGroupOps.List<
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
   * Get the full endpoint URL for an event subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("EventSubscriptions_GetFullUrl")
  getFullUrl is EventSubscriptionOperationGroupOps.ActionSync<
    EventSubscription,
    void,
    ArmResponse<EventSubscriptionFullUrl>,
    Parameters = {
      /**
       * The scope of the event subscription. The scope can be a subscription, or a resource group, or a top level resource belonging to a resource provider namespace, or an EventGrid topic. For example, use '/subscriptions/{subscriptionId}/' for a subscription, '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}' for a resource group, and '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}' for a resource, and '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventGrid/topics/{topicName}' for an EventGrid topic.
       */
      @path
      scope: string;

      /**
       * Name of the event subscription.
       */
      @path
      eventSubscriptionName: string;
    }
  >;

  /**
   * Get all delivery attributes for an event subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("EventSubscriptions_GetDeliveryAttributes")
  getDeliveryAttributes is EventSubscriptionOperationGroupOps.ActionSync<
    EventSubscription,
    void,
    ArmResponse<DeliveryAttributeListResult>,
    Parameters = {
      /**
       * The scope of the event subscription. The scope can be a subscription, or a resource group, or a top level resource belonging to a resource provider namespace, or an EventGrid topic. For example, use '/subscriptions/{subscriptionId}/' for a subscription, '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}' for a resource group, and '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}' for a resource, and '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.EventGrid/topics/{topicName}' for an EventGrid topic.
       */
      @path
      scope: string;

      /**
       * Name of the event subscription.
       */
      @path
      eventSubscriptionName: string;
    }
  >;
}
@armResourceOperations
interface DomainTopicEventSubscriptionOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = Domain,
          KeyName = "domainName",
          SegmentName = "domains",
          NamePattern = ""
        >>,
        ...KeysOf<ResourceNameParameter<
          Resource = NamespaceTopic,
          KeyName = "topicName",
          SegmentName = "topics",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = EventSubscription,
        KeyName = "eventSubscriptionName",
        SegmentName = "eventSubscriptions",
        NamePattern = ""
      >>
    > {}

@armResourceOperations
interface DomainTopicEventSubscriptions {
  /**
   * Get properties of a nested event subscription for a domain topic.
   */
  get is DomainTopicEventSubscriptionOps.Read<EventSubscription>;

  /**
   * Asynchronously creates a new event subscription or updates an existing event subscription.
   */
  createOrUpdate is DomainTopicEventSubscriptionOps.CreateOrUpdateAsync<
    EventSubscription,
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Update an existing event subscription for a domain topic.
   */
  @patch(#{ implicitOptionality: false })
  update is DomainTopicEventSubscriptionOps.CustomPatchAsync<
    EventSubscription,
    PatchModel = EventSubscriptionUpdateParameters,
    Response = ArmResourceCreatedResponse<EventSubscription>
  >;

  /**
   * Delete a nested existing event subscription for a domain topic.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  delete is DomainTopicEventSubscriptionOps.DeleteWithoutOkAsync<
    EventSubscription,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all event subscriptions that have been created for a specific domain topic.
   */
  list is DomainTopicEventSubscriptionOps.List<
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
   * Get the full endpoint URL for a nested event subscription for domain topic.
   */
  getFullUrl is DomainTopicEventSubscriptionOps.ActionSync<
    EventSubscription,
    void,
    ArmResponse<EventSubscriptionFullUrl>
  >;

  /**
   * Get all delivery attributes for an event subscription for domain topic.
   */
  getDeliveryAttributes is DomainTopicEventSubscriptionOps.ActionSync<
    EventSubscription,
    void,
    ArmResponse<DeliveryAttributeListResult>
  >;
}
@armResourceOperations
interface SystemTopicEventSubscriptionOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = SystemTopic,
          KeyName = "systemTopicName",
          SegmentName = "systemTopics",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = EventSubscription,
        KeyName = "eventSubscriptionName",
        SegmentName = "eventSubscriptions",
        NamePattern = ""
      >>
    > {}

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
   * Get the full endpoint URL for an event subscription of a system topic.
   */
  getFullUrl is SystemTopicEventSubscriptionOps.ActionSync<
    EventSubscription,
    void,
    ArmResponse<EventSubscriptionFullUrl>
  >;

  /**
   * Get all delivery attributes for an event subscription.
   */
  getDeliveryAttributes is SystemTopicEventSubscriptionOps.ActionSync<
    EventSubscription,
    void,
    ArmResponse<DeliveryAttributeListResult>
  >;
}
@armResourceOperations
interface PartnerTopicEventSubscriptionOps
  extends Azure.ResourceManager.Legacy.LegacyOperations<
      {
        ...ApiVersionParameter,
        ...SubscriptionIdParameter,
        ...ResourceGroupParameter,
        ...Azure.ResourceManager.Legacy.Provider,
        ...KeysOf<ResourceNameParameter<
          Resource = PartnerTopic,
          KeyName = "partnerTopicName",
          SegmentName = "partnerTopics",
          NamePattern = ""
        >>,
      },
      KeysOf<ResourceNameParameter<
        Resource = EventSubscription,
        KeyName = "eventSubscriptionName",
        SegmentName = "eventSubscriptions",
        NamePattern = ""
      >>
    > {}

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
    LroHeaders = ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
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
@@doc(DomainTopicEventSubscriptions.createOrUpdate::parameters.resource,
  "Event subscription properties containing the destination and filter information."
);
@@doc(DomainTopicEventSubscriptions.update::parameters.properties,
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
