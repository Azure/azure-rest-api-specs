import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace MarketplaceRPService;

interface PrivateStoreOperations {
  @doc("Gets the list of available private stores.")
  @route("/providers/Microsoft.Marketplace/privateStores")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("Determines if to use cache or DB for serving this request")
      @query
      `use-cache`: string;
    },
    PrivateStoreList
  >;

  @doc("Get information about the private store")
  @route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The store ID - must use the tenant ID")
      @path
      privateStoreId: string;
    },
    PrivateStore
  >;

  @doc("Changes private store properties")
  @route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The store ID - must use the tenant ID")
      @path
      privateStoreId: string;

      @body payload: PrivateStore;
    },
    void
  >;

  @doc("Deletes the private store. All that is not saved will be lost.")
  @route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The store ID - must use the tenant ID")
      @path
      privateStoreId: string;
    },
    void
  >;

  @doc("Query whether exists any offer in the collections.")
  @route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}/anyExistingOffersInTheCollections")
  @post
  AnyExistingOffersInTheCollections is Azure.Core.Foundations.Operation<
    {
      @doc("The store ID - must use the tenant ID")
      @path
      privateStoreId: string;
    },
    AnyExistingOffersInTheCollectionsResponse
  >;

  @doc("List of offers, regardless the collections")
  // FIXME: (name-collision-error) There is a potential collision with Operation, Parameter and Response names.
  // Problematic names: [QueryOffers]
  @route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}/queryOffers")
  @post
  QueryOffers is Azure.Core.Foundations.Operation<
    {
      @doc("The store ID - must use the tenant ID")
      @path
      privateStoreId: string;
    },
    QueryOffers
  >;

  @doc("List of user's approved offers for the provided offers and subscriptions")
  @route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}/queryUserOffers")
  @post
  QueryUserOffers is Azure.Core.Foundations.Operation<
    {
      @doc("The store ID - must use the tenant ID")
      @path
      privateStoreId: string;

      @body payload: QueryUserOffersProperties;
    },
    QueryOffers
  >;

  @doc("Tenant billing accounts names")
  @route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}/billingAccounts")
  @post
  BillingAccounts is Azure.Core.Foundations.Operation<
    {
      @doc("The store ID - must use the tenant ID")
      @path
      privateStoreId: string;
    },
    BillingAccountsResponse
  >;

  @doc("""
For a given subscriptions list, the API will return a map of collections and
the related subscriptions from the supplied list.
""")
  @route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}/collectionsToSubscriptionsMapping")
  @post
  CollectionsToSubscriptionsMapping is Azure.Core.Foundations.Operation<
    {
      @doc("The store ID - must use the tenant ID")
      @path
      privateStoreId: string;

      @body payload: CollectionsToSubscriptionsMappingPayload;
    },
    CollectionsToSubscriptionsMappingResponse
  >;

  @doc("Get map of plans and related approved subscriptions.")
  @route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}/queryApprovedPlans")
  @post
  QueryApprovedPlans is Azure.Core.Foundations.Operation<
    {
      @doc("The store ID - must use the tenant ID")
      @path
      privateStoreId: string;

      @body payload: QueryApprovedPlansPayload;
    },
    QueryApprovedPlansResponse
  >;

  @doc("Perform an action on bulk collections")
  @route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}/bulkCollectionsAction")
  @post
  BulkCollectionsAction is Azure.Core.Foundations.Operation<
    {
      @doc("The store ID - must use the tenant ID")
      @path
      privateStoreId: string;

      @body payload: BulkCollectionsPayload;
    },
    BulkCollectionsResponse
  >;

  @doc("Get all open approval requests of current user")
  @route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}/requestApprovals")
  @get
  GetApprovalRequestsList is Azure.Core.Foundations.Operation<
    {
      @doc("The store ID - must use the tenant ID")
      @path
      privateStoreId: string;
    },
    RequestApprovalsList
  >;

  @doc("Get open request approval details")
  @route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}/requestApprovals/{requestApprovalId}")
  @get
  GetRequestApproval is Azure.Core.Foundations.Operation<
    {
      @doc("The store ID - must use the tenant ID")
      @path
      privateStoreId: string;

      @doc("The request approval ID to get create or update")
      @path
      requestApprovalId: string;
    },
    RequestApprovalResource
  >;

  @doc("Create approval request")
  @route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}/requestApprovals/{requestApprovalId}")
  @put
  CreateApprovalRequest is Azure.Core.Foundations.Operation<
    {
      @doc("The store ID - must use the tenant ID")
      @path
      privateStoreId: string;

      @doc("The request approval ID to get create or update")
      @path
      requestApprovalId: string;

      @body payload: RequestApprovalResource;
    },
    RequestApprovalResource
  >;

  @doc("Get request statuses foreach plan, this api is used as a complex GET action.")
  // FIXME: (name-collision-error) There is a potential collision with Operation, Parameter and Response names.
  // Problematic names: [QueryRequestApproval]
  @route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}/requestApprovals/{requestApprovalId}/query")
  @post
  QueryRequestApproval is Azure.Core.Foundations.Operation<
    {
      @doc("The store ID - must use the tenant ID")
      @path
      privateStoreId: string;

      @doc("The request approval ID to get create or update")
      @path
      requestApprovalId: string;

      @body payload: QueryRequestApprovalProperties;
    },
    QueryRequestApproval
  >;

  @doc("Get list of admin request approvals")
  // FIXME: (name-collision-error) There is a potential collision with Operation, Parameter and Response names.
  // Problematic names: [AdminRequestApprovalsList]
  @route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}/adminRequestApprovals")
  @get
  AdminRequestApprovalsList is Azure.Core.Foundations.Operation<
    {
      @doc("The store ID - must use the tenant ID")
      @path
      privateStoreId: string;
    },
    AdminRequestApprovalsList
  >;

  @doc("Get open approval requests")
  @route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}/adminRequestApprovals/{adminRequestApprovalId}")
  @get
  GetAdminRequestApproval is Azure.Core.Foundations.Operation<
    {
      @doc("The store ID - must use the tenant ID")
      @path
      privateStoreId: string;

      @doc("The admin request approval ID to get create or update")
      @path
      adminRequestApprovalId: string;

      @doc("The publisher id of this offer.")
      @query
      publisherId: string;
    },
    AdminRequestApprovalsResource
  >;

  @doc("""
Update the admin action, weather the request is approved or rejected and the
approved plans
""")
  @route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}/adminRequestApprovals/{adminRequestApprovalId}")
  @put
  UpdateAdminRequestApproval is Azure.Core.Foundations.Operation<
    {
      @doc("The store ID - must use the tenant ID")
      @path
      privateStoreId: string;

      @doc("The admin request approval ID to get create or update")
      @path
      adminRequestApprovalId: string;

      @body payload: AdminRequestApprovalsResource;
    },
    AdminRequestApprovalsResource
  >;

  @doc("Get private store notifications state")
  @route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}/queryNotificationsState")
  @post
  QueryNotificationsState is Azure.Core.Foundations.Operation<
    {
      @doc("The store ID - must use the tenant ID")
      @path
      privateStoreId: string;
    },
    PrivateStoreNotificationsState
  >;

  @doc("Acknowledge notification for offer")
  @route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}/offers/{offerId}/acknowledgeNotification")
  @post
  AcknowledgeOfferNotification is Azure.Core.Foundations.Operation<
    {
      @doc("The store ID - must use the tenant ID")
      @path
      privateStoreId: string;

      @doc("The offer ID to update or delete")
      @path
      offerId: string;

      @body payload: AcknowledgeOfferNotificationProperties;
    },
    void
  >;

  @doc("Withdraw a user request approval on specific plan")
  @route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}/requestApprovals/{requestApprovalId}/withdrawPlan")
  @post
  WithdrawPlan is Azure.Core.Foundations.Operation<
    {
      @doc("The store ID - must use the tenant ID")
      @path
      privateStoreId: string;

      @doc("The request approval ID to get create or update")
      @path
      requestApprovalId: string;

      @body payload: WithdrawProperties;
    },
    void
  >;

  @doc("Fetch all subscriptions in tenant, only for marketplace admin")
  @route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}/fetchAllSubscriptionsInTenant")
  @post
  FetchAllSubscriptionsInTenant is Azure.Core.Foundations.Operation<
    {
      @doc("The store ID - must use the tenant ID")
      @path
      privateStoreId: string;

      @doc("The skip token to get the next page.")
      @header
      `next-page-token`: string;
    },
    SubscriptionsResponse
  >;

  @doc("List new plans notifications")
  @route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}/listNewPlansNotifications")
  @post
  ListNewPlansNotifications is Azure.Core.Foundations.Operation<
    {
      @doc("The store ID - must use the tenant ID")
      @path
      privateStoreId: string;
    },
    NewPlansNotificationsList
  >;

  @doc("List stop sell notifications for both stop sell offers and stop sell plans")
  @route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}/listStopSellOffersPlansNotifications")
  @post
  ListStopSellOffersPlansNotifications is Azure.Core.Foundations.Operation<
    {
      @doc("The store ID - must use the tenant ID")
      @path
      privateStoreId: string;

      @body stopSellSubscriptions: StopSellSubscriptions;
    },
    StopSellOffersPlansNotificationsList
  >;

  @doc("List all the subscriptions in the private store context")
  @route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}/listSubscriptionsContext")
  @post
  ListSubscriptionsContext is Azure.Core.Foundations.Operation<
    {
      @doc("The store ID - must use the tenant ID")
      @path
      privateStoreId: string;
    },
    SubscriptionsContextList
  >;
}

@doc("All rules approved in the private store that are relevant for user subscriptions")
@route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}/queryUserRules")
@post
op QueryUserRules is Azure.Core.Foundations.Operation<
  {
    @doc("The store ID - must use the tenant ID")
    @path
    privateStoreId: string;

    @body payload: QueryUserRulesProperties;
  },
  RuleListResponse
>;

@doc("Set rule for specific private store and collection")
@route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}/collections/{collectionId}/setRules")
@post
op SetCollectionRules is Azure.Core.Foundations.Operation<
  {
    @doc("The store ID - must use the tenant ID")
    @path
    privateStoreId: string;

    @doc("The collection ID")
    @path
    collectionId: string;

    @body payload: SetRulesRequest;
  },
  void
>;

@doc("Get a list of all private store rules in the given private store and collection")
@route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}/collections/{collectionId}/queryRules")
@post
op QueryRules is Azure.Core.Foundations.Operation<
  {
    @doc("The store ID - must use the tenant ID")
    @path
    privateStoreId: string;

    @doc("The collection ID")
    @path
    collectionId: string;
  },
  RuleListResponse
>;

interface PrivateStoreCollectionOperations {
  @doc("Gets private store collections list")
  @route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}/collections")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The store ID - must use the tenant ID")
      @path
      privateStoreId: string;
    },
    CollectionsList
  >;

  @doc("Gets private store collection")
  @route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}/collections/{collectionId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The store ID - must use the tenant ID")
      @path
      privateStoreId: string;

      @doc("The collection ID")
      @path
      collectionId: string;
    },
    Collection
  >;

  @doc("Create or update private store collection")
  @route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}/collections/{collectionId}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The store ID - must use the tenant ID")
      @path
      privateStoreId: string;

      @doc("The collection ID")
      @path
      collectionId: string;

      @body payload: Collection;
    },
    Collection
  >;

  @doc("Delete a collection from the given private store.")
  @route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}/collections/{collectionId}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The store ID - must use the tenant ID")
      @path
      privateStoreId: string;

      @doc("The collection ID")
      @path
      collectionId: string;
    },
    void
  >;

  @doc("Delete Private store collection. This is a workaround.")
  @route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}/collections/{collectionId}")
  @post
  Post is Azure.Core.Foundations.Operation<
    {
      @doc("The store ID - must use the tenant ID")
      @path
      privateStoreId: string;

      @doc("The collection ID")
      @path
      collectionId: string;

      @body payload: Operation;
    },
    void
  >;

  @doc("""
transferring offers (copy or move) from source collection to target
collection(s)
""")
  @route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}/collections/{collectionId}/transferOffers")
  @post
  TransferOffers is Azure.Core.Foundations.Operation<
    {
      @doc("The store ID - must use the tenant ID")
      @path
      privateStoreId: string;

      @doc("The collection ID")
      @path
      collectionId: string;

      @body payload: TransferOffersProperties;
    },
    TransferOffersResponse
  >;

  @doc("Delete all existing offers from the collection and enable approve all items.")
  @route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}/collections/{collectionId}/approveAllItems")
  @post
  ApproveAllItems is Azure.Core.Foundations.Operation<
    {
      @doc("The store ID - must use the tenant ID")
      @path
      privateStoreId: string;

      @doc("The collection ID")
      @path
      collectionId: string;
    },
    Collection
  >;

  @doc("Disable approve all items for the collection.")
  @route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}/collections/{collectionId}/disableApproveAllItems")
  @post
  DisableApproveAllItems is Azure.Core.Foundations.Operation<
    {
      @doc("The store ID - must use the tenant ID")
      @path
      privateStoreId: string;

      @doc("The collection ID")
      @path
      collectionId: string;
    },
    Collection
  >;
}

interface PrivateStoreCollectionOfferOperations {
  @doc("Get a list of all private offers in the given private store and collection")
  @route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}/collections/{collectionId}/offers")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The store ID - must use the tenant ID")
      @path
      privateStoreId: string;

      @doc("The collection ID")
      @path
      collectionId: string;
    },
    OfferListResponse
  >;

  @doc("""
Get a list of all offers in the given collection according to the required
contexts.
""")
  @route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}/collections/{collectionId}/mapOffersToContexts")
  @post
  ListByContexts is Azure.Core.Foundations.Operation<
    {
      @doc("The store ID - must use the tenant ID")
      @path
      privateStoreId: string;

      @doc("The collection ID")
      @path
      collectionId: string;

      @body payload: CollectionOffersByAllContextsPayload;
    },
    CollectionOffersByContextList
  >;

  @doc("Gets information about a specific offer.")
  @route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}/collections/{collectionId}/offers/{offerId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The store ID - must use the tenant ID")
      @path
      privateStoreId: string;

      @doc("The collection ID")
      @path
      collectionId: string;

      @doc("The offer ID to update or delete")
      @path
      offerId: string;
    },
    Offer
  >;

  @doc("Update or add an offer to a specific collection of the private store.")
  @route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}/collections/{collectionId}/offers/{offerId}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The store ID - must use the tenant ID")
      @path
      privateStoreId: string;

      @doc("The collection ID")
      @path
      collectionId: string;

      @doc("The offer ID to update or delete")
      @path
      offerId: string;

      @body payload: Offer;
    },
    Offer
  >;

  @doc("Deletes an offer from the given collection of private store.")
  @route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}/collections/{collectionId}/offers/{offerId}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The store ID - must use the tenant ID")
      @path
      privateStoreId: string;

      @doc("The collection ID")
      @path
      collectionId: string;

      @doc("The offer ID to update or delete")
      @path
      offerId: string;
    },
    void
  >;

  @doc("Delete Private store offer. This is a workaround.")
  @route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}/collections/{collectionId}/offers/{offerId}")
  @post
  Post is Azure.Core.Foundations.Operation<
    {
      @doc("The store ID - must use the tenant ID")
      @path
      privateStoreId: string;

      @doc("The collection ID")
      @path
      collectionId: string;

      @doc("The offer ID to update or delete")
      @path
      offerId: string;

      @body payload: Operation;
    },
    void
  >;

  @doc("Upsert an offer with multiple context details.")
  @route("/providers/Microsoft.Marketplace/privateStores/{privateStoreId}/collections/{collectionId}/offers/{offerId}/upsertOfferWithMultiContext")
  @post
  UpsertOfferWithMultiContext is Azure.Core.Foundations.Operation<
    {
      @doc("The store ID - must use the tenant ID")
      @path
      privateStoreId: string;

      @doc("The collection ID")
      @path
      collectionId: string;

      @doc("The offer ID to update or delete")
      @path
      offerId: string;

      @body payload: MultiContextAndPlansPayload;
    },
    Offer
  >;
}

interface OperationsOperations {
  @doc("Lists all of the available Microsoft.Marketplace REST API operations.")
  @route("/providers/Microsoft.Marketplace/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationListResult>;
}
