import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./NamespaceTopic.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.EventGrid;
/**
 * Event Subscription.
 */
@parentResource(NamespaceTopic)
model Subscription
  is Azure.ResourceManager.ProxyResource<SubscriptionProperties> {
  ...ResourceNameParameter<
    Resource = Subscription,
    KeyName = "eventSubscriptionName",
    SegmentName = "eventSubscriptions",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

@armResourceOperations
interface Subscriptions {
  /**
   * Get properties of an event subscription of a namespace topic.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NamespaceTopicEventSubscriptions_Get")
  get is ArmResourceRead<Subscription>;

  /**
   * Asynchronously creates or updates an event subscription of a namespace topic with the specified parameters. Existing event subscriptions will be updated with this API.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NamespaceTopicEventSubscriptions_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Subscription>;

  /**
   * Update an existing event subscription of a namespace topic.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "For backward compatibility"
  @operationId("NamespaceTopicEventSubscriptions_Update")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    Subscription,
    PatchModel = SubscriptionUpdateParameters,
    Response = ArmResponse<Subscription> | (ArmAcceptedLroResponse<ArmAsyncOperationHeader<FinalResult = Subscription> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: Subscription;
    })
  >;

  /**
   * Delete an existing event subscription of a namespace topic.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "For backward compatibility"
  @operationId("NamespaceTopicEventSubscriptions_Delete")
  delete is ArmResourceDeleteWithoutOkAsync<
    Subscription,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List event subscriptions that belong to a specific namespace topic.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NamespaceTopicEventSubscriptions_ListByNamespaceTopic")
  listByNamespaceTopic is ArmResourceListByParent<
    Subscription,
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
   * Get all delivery attributes for an event subscription of a namespace topic.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NamespaceTopicEventSubscriptions_GetDeliveryAttributes")
  @list
  getDeliveryAttributes is ArmResourceActionSync<
    Subscription,
    void,
    ArmResponse<DeliveryAttributeListResult>
  >;

  /**
   * Get the full endpoint URL for an event subscription of a namespace topic.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("NamespaceTopicEventSubscriptions_GetFullUrl")
  getFullUrl is ArmResourceActionSync<
    Subscription,
    void,
    ArmResponse<SubscriptionFullUrl>
  >;
}

@@maxLength(Subscription.name, 50);
@@minLength(Subscription.name, 3);
@@doc(Subscription.name, "Name of the event subscription to be found.");
@@doc(Subscription.properties, "Properties of the event subscription.");
@@doc(Subscriptions.createOrUpdate::parameters.resource,
  "Event subscription properties containing the delivery mode, filter information, and others."
);
@@doc(Subscriptions.update::parameters.properties,
  "Updated event subscription information."
);
