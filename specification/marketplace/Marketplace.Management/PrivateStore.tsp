import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Marketplace;
/**
 * The PrivateStore data structure.
 */
@tenantResource
model PrivateStore
  is Azure.ResourceManager.ProxyResource<PrivateStoreProperties> {
  ...ResourceNameParameter<
    Resource = PrivateStore,
    KeyName = "privateStoreId",
    SegmentName = "privateStores",
    NamePattern = ""
  >;
}

@armResourceOperations
interface PrivateStores {
  /**
   * Get information about the private store
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateStore_Get")
  get is ArmResourceRead<
    PrivateStore,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Changes private store properties
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "For backward compatibility"
  @operationId("PrivateStore_CreateOrUpdate")
  createOrUpdate is ArmResourceCreateOrReplaceSync<
    PrivateStore,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Response = OkResponse
  >;

  /**
   * Deletes the private store. All that is not saved will be lost.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateStore_Delete")
  delete is ArmResourceDeleteSync<
    PrivateStore,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Gets the list of available private stores.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateStore_List")
  list is ArmResourceListByParent<
    PrivateStore,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = {
      /**
       * Determines if to use cache or DB for serving this request
       */
      @query("use-cache")
      `use-cache`?: string;
    },
    Response = ArmResponse<PrivateStoreList>
  >;

  /**
   * Query whether exists any offer in the collections.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateStore_AnyExistingOffersInTheCollections")
  anyExistingOffersInTheCollections is ArmResourceActionSync<
    PrivateStore,
    void,
    ArmResponse<AnyExistingOffersInTheCollectionsResponse>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * List of offers, regardless the collections
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateStore_QueryOffers")
  queryOffers is ArmResourceActionSync<
    PrivateStore,
    void,
    ArmResponse<QueryOffers>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * List of user's approved offers for the provided offers and subscriptions
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateStore_QueryUserOffers")
  queryUserOffers is ArmResourceActionSync<
    PrivateStore,
    {
      @bodyRoot
      payload?: QueryUserOffersProperties;
    },
    ArmResponse<QueryOffers>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Tenant billing accounts names
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateStore_BillingAccounts")
  billingAccounts is ArmResourceActionSync<
    PrivateStore,
    void,
    ArmResponse<BillingAccountsResponse>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * For a given subscriptions list, the API will return a map of collections and the related subscriptions from the supplied list.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateStore_CollectionsToSubscriptionsMapping")
  collectionsToSubscriptionsMapping is ArmResourceActionSync<
    PrivateStore,
    {
      @bodyRoot
      payload?: CollectionsToSubscriptionsMappingPayload;
    },
    ArmResponse<CollectionsToSubscriptionsMappingResponse>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Get map of plans and related approved subscriptions.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateStore_QueryApprovedPlans")
  queryApprovedPlans is ArmResourceActionSync<
    PrivateStore,
    {
      @bodyRoot
      payload?: QueryApprovedPlansPayload;
    },
    ArmResponse<QueryApprovedPlansResponse>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Perform an action on bulk collections
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateStore_BulkCollectionsAction")
  bulkCollectionsAction is ArmResourceActionSync<
    PrivateStore,
    {
      @bodyRoot
      payload?: BulkCollectionsPayload;
    },
    ArmResponse<BulkCollectionsResponse>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Get private store notifications state
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateStore_QueryNotificationsState")
  queryNotificationsState is ArmResourceActionSync<
    PrivateStore,
    void,
    ArmResponse<PrivateStoreNotificationsState>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Acknowledge notification for offer
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @action("acknowledgeNotification")
  @operationId("PrivateStore_AcknowledgeOfferNotification")
  acknowledgeOfferNotification is ArmResourceActionSync<
    PrivateStore,
    {
      @bodyRoot
      payload?: AcknowledgeOfferNotificationProperties;
    },
    OkResponse,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = {
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateStore_FetchAllSubscriptionsInTenant")
  fetchAllSubscriptionsInTenant is ArmResourceActionSync<
    PrivateStore,
    void,
    ArmResponse<SubscriptionsResponse>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = {
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateStore_ListNewPlansNotifications")
  listNewPlansNotifications is ArmResourceActionSync<
    PrivateStore,
    void,
    ArmResponse<NewPlansNotificationsList>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * List stop sell notifications for both stop sell offers and stop sell plans
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateStore_ListStopSellOffersPlansNotifications")
  listStopSellOffersPlansNotifications is ArmResourceActionSync<
    PrivateStore,
    {
      @bodyRoot
      stopSellSubscriptions?: StopSellSubscriptions;
    },
    ArmResponse<StopSellOffersPlansNotificationsList>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * List all the subscriptions in the private store context
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("PrivateStore_ListSubscriptionsContext")
  listSubscriptionsContext is ArmResourceActionSync<
    PrivateStore,
    void,
    ArmResponse<SubscriptionsContextList>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * All rules approved in the private store that are relevant for user subscriptions
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("QueryUserRules")
  queryUserRules is ArmResourceActionSync<
    PrivateStore,
    {
      @bodyRoot
      payload?: QueryUserRulesProperties;
    },
    ArmResponse<RuleListResponse>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;
}

@@doc(PrivateStore.name, "The store ID - must use the tenant ID");
@@doc(PrivateStore.properties, "The PrivateStore data structure.");
@@doc(PrivateStores.createOrUpdate::parameters.resource, "");
