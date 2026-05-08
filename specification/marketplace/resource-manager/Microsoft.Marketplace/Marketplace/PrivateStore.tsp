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
  get is ArmResourceRead<
    PrivateStore,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Error = ErrorResponse
  >;

  /**
   * Changes private store properties
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  createOrUpdate is Azure.ResourceManager.Legacy.CreateOrReplaceSync<
    PrivateStore,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Response = OkResponse,
    Error = ErrorResponse,
    OptionalRequestBody = true
  >;

  /**
   * Deletes the private store. All that is not saved will be lost.
   */
  delete is ArmResourceDeleteSync<
    PrivateStore,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Error = ErrorResponse
  >;

  /**
   * Gets the list of available private stores.
   */
  list is ArmResourceListByParent<
    PrivateStore,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = {
      /**
       * Determines if to use cache or DB for serving this request
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @query("use-cache")
      `use-cache`?: string;
    },
    Response = ArmResponse<PrivateStoreList>,
    Error = ErrorResponse
  >;

  /**
   * Query whether exists any offer in the collections.
   */
  anyExistingOffersInTheCollections is ArmResourceActionSync<
    PrivateStore,
    void,
    ArmResponse<AnyExistingOffersInTheCollectionsResponse>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Error = ErrorResponse
  >;

  /**
   * List of offers, regardless the collections
   */
  queryOffers is ArmResourceActionSync<
    PrivateStore,
    void,
    ArmResponse<QueryOffers>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Error = ErrorResponse
  >;

  /**
   * List of user's approved offers for the provided offers and subscriptions
   */
  queryUserOffers is ArmResourceActionSync<
    PrivateStore,
    QueryUserOffersProperties,
    ArmResponse<QueryOffers>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    OptionalRequestBody = true,
    Error = ErrorResponse
  >;

  /**
   * Tenant billing accounts names
   */
  billingAccounts is ArmResourceActionSync<
    PrivateStore,
    void,
    ArmResponse<BillingAccountsResponse>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Error = ErrorResponse
  >;

  /**
   * For a given subscriptions list, the API will return a map of collections and the related subscriptions from the supplied list.
   */
  collectionsToSubscriptionsMapping is ArmResourceActionSync<
    PrivateStore,
    CollectionsToSubscriptionsMappingPayload,
    ArmResponse<CollectionsToSubscriptionsMappingResponse>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    OptionalRequestBody = true,
    Error = ErrorResponse
  >;

  /**
   * Get map of plans and related approved subscriptions.
   */
  queryApprovedPlans is ArmResourceActionSync<
    PrivateStore,
    QueryApprovedPlansPayload,
    ArmResponse<QueryApprovedPlansResponse>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    OptionalRequestBody = true,
    Error = ErrorResponse
  >;

  /**
   * Perform an action on bulk collections
   */
  bulkCollectionsAction is ArmResourceActionSync<
    PrivateStore,
    BulkCollectionsPayload,
    ArmResponse<BulkCollectionsResponse>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    OptionalRequestBody = true,
    Error = ErrorResponse
  >;

  /**
   * Get private store notifications state
   */
  queryNotificationsState is ArmResourceActionSync<
    PrivateStore,
    void,
    ArmResponse<PrivateStoreNotificationsState>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Error = ErrorResponse
  >;

  /**
   * Acknowledge notification for offer
   */
  @action("acknowledgeNotification")
  acknowledgeOfferNotification is ArmResourceActionSync<
    PrivateStore,
    AcknowledgeOfferNotificationProperties,
    OkResponse,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = {
      /**
       * The offer ID to update or delete
       */
      @path
      @segment("offers")
      offerId: string;
    },
    OptionalRequestBody = true,
    Error = ErrorResponse
  >;

  /**
   * Fetch all subscriptions in tenant, only for marketplace admin
   */
  fetchAllSubscriptionsInTenant is ArmResourceActionSync<
    PrivateStore,
    void,
    ArmResponse<SubscriptionsResponse>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Parameters = {
      /**
       * The skip token to get the next page.
       */
      #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
      @header
      `next-page-token`?: string;
    },
    Error = ErrorResponse
  >;

  /**
   * List new plans notifications
   */
  listNewPlansNotifications is ArmResourceActionSync<
    PrivateStore,
    void,
    ArmResponse<NewPlansNotificationsList>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Error = ErrorResponse
  >;

  /**
   * List stop sell notifications for both stop sell offers and stop sell plans
   */
  listStopSellOffersPlansNotifications is ArmResourceActionSync<
    PrivateStore,
    StopSellSubscriptions,
    ArmResponse<StopSellOffersPlansNotificationsList>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    OptionalRequestBody = true,
    Error = ErrorResponse
  >;

  /**
   * List all the subscriptions in the private store context
   */
  listSubscriptionsContext is ArmResourceActionSync<
    PrivateStore,
    void,
    ArmResponse<SubscriptionsContextList>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    Error = ErrorResponse
  >;

  /**
   * All rules approved in the private store that are relevant for user subscriptions
   */
  queryUserRules is ArmResourceActionSync<
    PrivateStore,
    QueryUserRulesProperties,
    ArmResponse<RuleListResponse>,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
    OptionalRequestBody = true,
    Error = ErrorResponse
  >;
}

@@doc(PrivateStore.name, "The store ID - must use the tenant ID");
@@doc(PrivateStore.properties, "The PrivateStore data structure.");
@@doc(PrivateStores.createOrUpdate::parameters.resource, "");
@@doc(PrivateStores.queryUserOffers::parameters.body, "");
@@doc(PrivateStores.collectionsToSubscriptionsMapping::parameters.body, "");
@@doc(PrivateStores.queryApprovedPlans::parameters.body, "");
@@doc(PrivateStores.bulkCollectionsAction::parameters.body, "");
@@doc(PrivateStores.acknowledgeOfferNotification::parameters.body, "");
@@doc(PrivateStores.listStopSellOffersPlansNotifications::parameters.body, "");
@@doc(PrivateStores.queryUserRules::parameters.body, "");
