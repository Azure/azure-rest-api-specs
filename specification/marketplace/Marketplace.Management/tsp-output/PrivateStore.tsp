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

namespace Microsoft.Marketplace;
/**
 * The PrivateStore data structure.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@tenantResource
@Azure.ResourceManager.Private.armResourceInternal(PrivateStoreProperties)
@includeInapplicableMetadataInPayload(false)
model PrivateStore extends Resource {
  /**
   * The store ID - must use the tenant ID
   */
  @path
  @key("privateStoreId")
  @segment("privateStores")
  name: string;

  /**
   * The PrivateStore data structure.
   */
  @extension("x-ms-client-flatten", true)
  properties?: PrivateStoreProperties;
}

@armResourceOperations
interface PrivateStores {
  /**
   * Get information about the private store
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateStore_Get")
  get is ArmResourceRead<PrivateStore>;

  /**
   * Changes private store properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateStore_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<PrivateStore>;

  /**
   * Deletes the private store. All that is not saved will be lost.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateStore_Delete")
  delete is ArmResourceDeleteSync<PrivateStore>;

  /**
   * Gets the list of available private stores.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateStore_List")
  list is ArmResourceListByParent<
    PrivateStore,
    {
      ...BaseParameters<PrivateStore>;

      /**
       * Determines if to use cache or DB for serving this request
       */
      @query("use-cache")
      `use-cache`?: string;
    }
  >;

  /**
   * Query whether exists any offer in the collections.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateStore_AnyExistingOffersInTheCollections")
  anyExistingOffersInTheCollections is ArmResourceActionSync<
    PrivateStore,
    void,
    AnyExistingOffersInTheCollectionsResponse
  >;

  /**
   * List of offers, regardless the collections
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateStore_QueryOffers")
  queryOffers is ArmResourceActionSync<PrivateStore, void, QueryOffers>;

  /**
   * List of user's approved offers for the provided offers and subscriptions
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateStore_QueryUserOffers")
  queryUserOffers is ArmResourceActionSync<
    PrivateStore,
    QueryUserOffersProperties,
    QueryOffers
  >;

  /**
   * Tenant billing accounts names
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateStore_BillingAccounts")
  billingAccounts is ArmResourceActionSync<
    PrivateStore,
    void,
    BillingAccountsResponse
  >;

  /**
   * For a given subscriptions list, the API will return a map of collections and the related subscriptions from the supplied list.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateStore_CollectionsToSubscriptionsMapping")
  collectionsToSubscriptionsMapping is ArmResourceActionSync<
    PrivateStore,
    CollectionsToSubscriptionsMappingPayload,
    CollectionsToSubscriptionsMappingResponse
  >;

  /**
   * Get map of plans and related approved subscriptions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateStore_QueryApprovedPlans")
  queryApprovedPlans is ArmResourceActionSync<
    PrivateStore,
    QueryApprovedPlansPayload,
    QueryApprovedPlansResponse
  >;

  /**
   * Perform an action on bulk collections
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateStore_BulkCollectionsAction")
  bulkCollectionsAction is ArmResourceActionSync<
    PrivateStore,
    BulkCollectionsPayload,
    BulkCollectionsResponse
  >;

  /**
   * Get private store notifications state
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateStore_QueryNotificationsState")
  queryNotificationsState is ArmResourceActionSync<
    PrivateStore,
    void,
    PrivateStoreNotificationsState
  >;

  /**
   * Acknowledge notification for offer
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateStore_AcknowledgeOfferNotification")
  acknowledgeOfferNotification is ArmResourceActionSync<
    PrivateStore,
    AcknowledgeOfferNotificationProperties,
    void,
    {
      ...BaseParameters<PrivateStore>;

      /**
       * The offer ID to update or delete
       */
      @path
      offerId: string;
    }
  >;

  /**
   * Fetch all subscriptions in tenant, only for marketplace admin
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateStore_FetchAllSubscriptionsInTenant")
  fetchAllSubscriptionsInTenant is ArmResourceActionSync<
    PrivateStore,
    void,
    SubscriptionsResponse,
    {
      ...BaseParameters<PrivateStore>;

      /**
       * The skip token to get the next page.
       */
      @header
      `next-page-token`?: string;
    }
  >;

  /**
   * List new plans notifications
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateStore_ListNewPlansNotifications")
  listNewPlansNotifications is ArmResourceActionSync<
    PrivateStore,
    void,
    NewPlansNotificationsList
  >;

  /**
   * List stop sell notifications for both stop sell offers and stop sell plans
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateStore_ListStopSellOffersPlansNotifications")
  listStopSellOffersPlansNotifications is ArmResourceActionSync<
    PrivateStore,
    StopSellSubscriptions,
    StopSellOffersPlansNotificationsList
  >;

  /**
   * List all the subscriptions in the private store context
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateStore_ListSubscriptionsContext")
  listSubscriptionsContext is ArmResourceActionSync<
    PrivateStore,
    void,
    SubscriptionsContextList
  >;

  /**
   * All rules approved in the private store that are relevant for user subscriptions
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("QueryUserRules")
  queryUserRules is ArmResourceActionSync<
    PrivateStore,
    QueryUserRulesProperties,
    RuleListResponse
  >;
}

@@projectedName(PrivateStores.createOrUpdate::parameters.resource,
  "json",
  "payload"
);
@@extension(PrivateStores.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "payload"
);
@@doc(PrivateStores.createOrUpdate::parameters.resource, "");
@@projectedName(PrivateStores.queryUserOffers::parameters.body,
  "json",
  "payload"
);
@@extension(PrivateStores.queryUserOffers::parameters.body,
  "x-ms-client-name",
  "payload"
);
@@doc(PrivateStores.queryUserOffers::parameters.body, "");
@@projectedName(PrivateStores.collectionsToSubscriptionsMapping::parameters.body,
  "json",
  "payload"
);
@@extension(PrivateStores.collectionsToSubscriptionsMapping::parameters.body,
  "x-ms-client-name",
  "payload"
);
@@doc(PrivateStores.collectionsToSubscriptionsMapping::parameters.body, "");
@@projectedName(PrivateStores.queryApprovedPlans::parameters.body,
  "json",
  "payload"
);
@@extension(PrivateStores.queryApprovedPlans::parameters.body,
  "x-ms-client-name",
  "payload"
);
@@doc(PrivateStores.queryApprovedPlans::parameters.body, "");
@@projectedName(PrivateStores.bulkCollectionsAction::parameters.body,
  "json",
  "payload"
);
@@extension(PrivateStores.bulkCollectionsAction::parameters.body,
  "x-ms-client-name",
  "payload"
);
@@doc(PrivateStores.bulkCollectionsAction::parameters.body, "");
@@projectedName(PrivateStores.acknowledgeOfferNotification::parameters.body,
  "json",
  "payload"
);
@@extension(PrivateStores.acknowledgeOfferNotification::parameters.body,
  "x-ms-client-name",
  "payload"
);
@@doc(PrivateStores.acknowledgeOfferNotification::parameters.body, "");
@@projectedName(PrivateStores.listStopSellOffersPlansNotifications::parameters.body,
  "json",
  "stopSellSubscriptions"
);
@@extension(PrivateStores.listStopSellOffersPlansNotifications::parameters.body,
  "x-ms-client-name",
  "stopSellSubscriptions"
);
@@doc(PrivateStores.listStopSellOffersPlansNotifications::parameters.body, "");
@@projectedName(PrivateStores.queryUserRules::parameters.body,
  "json",
  "payload"
);
@@extension(PrivateStores.queryUserRules::parameters.body,
  "x-ms-client-name",
  "payload"
);
@@doc(PrivateStores.queryUserRules::parameters.body, "");
