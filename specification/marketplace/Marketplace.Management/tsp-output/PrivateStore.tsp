import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;

namespace Azure.ResourceManager.Marketplace;
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
interface PrivateStore {
  @doc("Get information about the private store")
  get is ArmResourceRead<PrivateStore>;
  @doc("Changes private store properties")
  createOrUpdate is ArmResourceCreateOrReplaceSync<PrivateStore>;
  @doc("Deletes the private store. All that is not saved will be lost.")
  delete is ArmResourceDeleteSync<PrivateStore>;
  @doc("Gets the list of available private stores.")
  list is ArmResourceListByParent<
    PrivateStore,
    {
      ...BaseParameters<PrivateStore>;

      @doc("Determines if to use cache or DB for serving this request")
      @query("use-cache")
      `use-cache`?: string;
    }
  >;
  @doc("Query whether exists any offer in the collections.")
  anyExistingOffersInTheCollections is ArmResourceActionSync<
    PrivateStore,
    void,
    AnyExistingOffersInTheCollectionsResponse
  >;
  @doc("List of offers, regardless the collections")
  queryOffers is ArmResourceActionSync<PrivateStore, void, QueryOffers>;
  @doc("List of user's approved offers for the provided offers and subscriptions")
  queryUserOffers is ArmResourceActionSync<
    PrivateStore,
    QueryUserOffersProperties,
    QueryOffers
  >;
  @doc("Tenant billing accounts names")
  billingAccounts is ArmResourceActionSync<
    PrivateStore,
    void,
    BillingAccountsResponse
  >;
  @doc("For a given subscriptions list, the API will return a map of collections and the related subscriptions from the supplied list.")
  collectionsToSubscriptionsMapping is ArmResourceActionSync<
    PrivateStore,
    CollectionsToSubscriptionsMappingPayload,
    CollectionsToSubscriptionsMappingResponse
  >;
  @doc("Get map of plans and related approved subscriptions.")
  queryApprovedPlans is ArmResourceActionSync<
    PrivateStore,
    QueryApprovedPlansPayload,
    QueryApprovedPlansResponse
  >;
  @doc("Perform an action on bulk collections")
  bulkCollectionsAction is ArmResourceActionSync<
    PrivateStore,
    BulkCollectionsPayload,
    BulkCollectionsResponse
  >;
  @doc("Get private store notifications state")
  queryNotificationsState is ArmResourceActionSync<
    PrivateStore,
    void,
    PrivateStoreNotificationsState
  >;
  @doc("Acknowledge notification for offer")
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
  @doc("Fetch all subscriptions in tenant, only for marketplace admin")
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
  @doc("List new plans notifications")
  listNewPlansNotifications is ArmResourceActionSync<
    PrivateStore,
    void,
    NewPlansNotificationsList
  >;
  @doc("List stop sell notifications for both stop sell offers and stop sell plans")
  listStopSellOffersPlansNotifications is ArmResourceActionSync<
    PrivateStore,
    StopSellSubscriptions,
    StopSellOffersPlansNotificationsList
  >;
  @doc("List all the subscriptions in the private store context")
  listSubscriptionsContext is ArmResourceActionSync<
    PrivateStore,
    void,
    SubscriptionsContextList
  >;
}

@armResourceOperations
interface PrivateStores {
  @doc("All rules approved in the private store that are relevant for user subscriptions")
  queryUserRules is ArmResourceActionSync<
    PrivateStore,
    QueryUserRulesProperties,
    RuleListResponse
  >;
}
