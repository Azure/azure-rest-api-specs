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
@doc("The PrivateStore data structure.")
@tenantResource
model PrivateStore is ProxyResource<PrivateStoreProperties> {
  @doc("The store ID - must use the tenant ID")
  @path
  @key("privateStoreId")
  @segment("privateStores")
  name: string;
}

@armResourceOperations
interface PrivateStores {
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get information about the private store")
  @operationId("PrivateStore_Get")
  get is ArmResourceRead<PrivateStore>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Changes private store properties")
  @operationId("PrivateStore_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<PrivateStore>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Deletes the private store. All that is not saved will be lost.")
  @operationId("PrivateStore_Delete")
  delete is ArmResourceDeleteSync<PrivateStore>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Gets the list of available private stores.")
  @operationId("PrivateStore_List")
  list is ArmResourceListByParent<
    PrivateStore,
    {
      ...BaseParameters<PrivateStore>;

      @doc("Determines if to use cache or DB for serving this request")
      @query("use-cache")
      `use-cache`?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Query whether exists any offer in the collections.")
  @operationId("PrivateStore_AnyExistingOffersInTheCollections")
  anyExistingOffersInTheCollections is ArmResourceActionSync<
    PrivateStore,
    void,
    AnyExistingOffersInTheCollectionsResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List of offers, regardless the collections")
  @operationId("PrivateStore_QueryOffers")
  queryOffers is ArmResourceActionSync<PrivateStore, void, QueryOffers>;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List of user's approved offers for the provided offers and subscriptions")
  @operationId("PrivateStore_QueryUserOffers")
  queryUserOffers is ArmResourceActionSync<
    PrivateStore,
    QueryUserOffersProperties,
    QueryOffers
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Tenant billing accounts names")
  @operationId("PrivateStore_BillingAccounts")
  billingAccounts is ArmResourceActionSync<
    PrivateStore,
    void,
    BillingAccountsResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("For a given subscriptions list, the API will return a map of collections and the related subscriptions from the supplied list.")
  @operationId("PrivateStore_CollectionsToSubscriptionsMapping")
  collectionsToSubscriptionsMapping is ArmResourceActionSync<
    PrivateStore,
    CollectionsToSubscriptionsMappingPayload,
    CollectionsToSubscriptionsMappingResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get map of plans and related approved subscriptions.")
  @operationId("PrivateStore_QueryApprovedPlans")
  queryApprovedPlans is ArmResourceActionSync<
    PrivateStore,
    QueryApprovedPlansPayload,
    QueryApprovedPlansResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Perform an action on bulk collections")
  @operationId("PrivateStore_BulkCollectionsAction")
  bulkCollectionsAction is ArmResourceActionSync<
    PrivateStore,
    BulkCollectionsPayload,
    BulkCollectionsResponse
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Get private store notifications state")
  @operationId("PrivateStore_QueryNotificationsState")
  queryNotificationsState is ArmResourceActionSync<
    PrivateStore,
    void,
    PrivateStoreNotificationsState
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Acknowledge notification for offer")
  @operationId("PrivateStore_AcknowledgeOfferNotification")
  acknowledgeOfferNotification is ArmResourceActionSync<
    PrivateStore,
    AcknowledgeOfferNotificationProperties,
    void,
    {
      ...BaseParameters<PrivateStore>;

      @doc("The offer ID to update or delete")
      @path
      offerId: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("Fetch all subscriptions in tenant, only for marketplace admin")
  @operationId("PrivateStore_FetchAllSubscriptionsInTenant")
  fetchAllSubscriptionsInTenant is ArmResourceActionSync<
    PrivateStore,
    void,
    SubscriptionsResponse,
    {
      ...BaseParameters<PrivateStore>;

      @doc("The skip token to get the next page.")
      @header
      `next-page-token`?: string;
    }
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List new plans notifications")
  @operationId("PrivateStore_ListNewPlansNotifications")
  listNewPlansNotifications is ArmResourceActionSync<
    PrivateStore,
    void,
    NewPlansNotificationsList
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List stop sell notifications for both stop sell offers and stop sell plans")
  @operationId("PrivateStore_ListStopSellOffersPlansNotifications")
  listStopSellOffersPlansNotifications is ArmResourceActionSync<
    PrivateStore,
    StopSellSubscriptions,
    StopSellOffersPlansNotificationsList
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("List all the subscriptions in the private store context")
  @operationId("PrivateStore_ListSubscriptionsContext")
  listSubscriptionsContext is ArmResourceActionSync<
    PrivateStore,
    void,
    SubscriptionsContextList
  >;

  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @doc("All rules approved in the private store that are relevant for user subscriptions")
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
