import "@typespec/rest";
import "@typespec/http";
import "@typespec/openapi";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Marketplace;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Indicates private store availability
 */
enum Availability {
  enabled,
  disabled,
}

/**
 * The type of identity that creates/modifies resources
 */
enum IdentityType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

/**
 * Plan accessibility
 */
enum Accessibility {
  Unknown,
  Public,
  PrivateTenantOnLevel,
  PrivateSubscriptionOnLevel,
}

/**
 * Rule type
 */
enum RuleType {
  PrivateProducts,
  TermsAndCondition,
}

/**
 * Set the Operation for the POST method. Ping or Delete
 */
enum Operation {
  DeletePrivateStoreOffer,
  DeletePrivateStoreCollection,
  DeletePrivateStoreCollectionOffer,
  Ping,
}

/**
 * Gets the plan status
 */
enum Status {
  Pending,
  Rejected,
  Approved,
  None,
}

/**
 * Gets or sets admin action
 */
enum AdminAction {
  Approved,
  Rejected,
}

/**
 * The subscription state. Possible values are Enabled, Warned, PastDue, Disabled, and Deleted.
 */
enum SubscriptionState {
  Enabled,
  Warned,
  PastDue,
  Disabled,
  Deleted,
}

/**
 * Describes the json payload on whether or not the private store is enabled for a given tenant
 */
model PrivateStoreProperties {
  /**
   * Indicates private store availability
   */
  availability?: Availability;

  /**
   * Private Store id
   */
  @visibility("read")
  privateStoreId?: string;

  /**
   * Identifier for purposes of race condition
   */
  eTag?: string;

  /**
   * Private Store Name
   */
  privateStoreName?: string;

  /**
   * Tenant id
   */
  tenantId?: string;

  /**
   * Is government
   */
  isGov?: boolean;

  /**
   * Gets list of associated collection ids
   */
  @visibility("read")
  collectionIds?: string[];

  /**
   * Gets or sets list of branding characteristics
   */
  branding?: Record<string>;

  /**
   * Gets or sets notifications settings
   */
  @extension("x-ms-client-flatten", true)
  notificationsSettings?: NotificationsSettingsProperties;
}

/**
 * Describes the json payload for notifications settings
 */
model NotificationsSettingsProperties {
  /**
   * Gets or sets list of notified recipients for new requests
   */
  recipients?: Recipient[];

  /**
   * Gets or sets whether to send email to all marketplace admins for new requests
   */
  sendToAllMarketplaceAdmins?: boolean;
}

/**
 * Describes the json payload for a notified recipient for new requests
 */
model Recipient {
  /**
   * Principal ID
   */
  principalId?: string;

  /**
   * Email Address
   */
  @visibility("read")
  emailAddress?: string;

  /**
   * Display Name
   */
  @visibility("read")
  displayName?: string;
}

/**
 * An Azure resource.
 */
model Resource {
  /**
   * The resource ID.
   */
  @visibility("read")
  id?: string;

  /**
   * The name of the resource.
   */
  @visibility("read")
  name?: string;

  /**
   * The type of the resource.
   */
  @visibility("read")
  type?: string;

  /**
   * Metadata pertaining to creation and last modification of the resource
   */
  @visibility("read")
  systemData?: SystemData;
}

/**
 * The details of the error.
 */
model ErrorResponseError {
  /**
   * Error code.
   */
  @visibility("read")
  code?: string;

  /**
   * Error message indicating why the operation failed.
   */
  @visibility("read")
  message?: string;
}

/**
 * Response object of query if are there existing offers in the collections.
 */
model AnyExistingOffersInTheCollectionsResponse {
  /**
   * Boolean answer, true if exists at least a single offer in an enabled collection, otherwise, false.
   */
  value?: boolean;
}

/**
 * List of offers
 */
model QueryOffers {
  value?: OfferProperties[];

  /**
   * URL to get the next set of PrivateStore list results if there are any.
   */
  nextLink?: string;
}

model OfferProperties {
  /**
   * Offers unique id
   */
  @visibility("read")
  uniqueOfferId?: string;

  /**
   * It will be displayed prominently in the marketplace
   */
  @visibility("read")
  offerDisplayName?: string;

  /**
   * Publisher name that will be displayed prominently in the marketplace
   */
  @visibility("read")
  publisherDisplayName?: string;

  /**
   * Identifier for purposes of race condition
   */
  eTag?: string;

  /**
   * Private store unique id
   */
  @visibility("read")
  privateStoreId?: string;

  /**
   * Private store offer creation date
   */
  @visibility("read")
  @projectedName("json", "createdAt")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;

  /**
   * Private store offer modification date
   */
  @visibility("read")
  @projectedName("json", "modifiedAt")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  modifiedOn?: utcDateTime;

  /**
   * Plan ids limitation for this offer
   */
  specificPlanIdsLimitation?: string[];

  /**
   * Indicating whether the offer was not updated to db (true = not updated). If the allow list is identical to the existed one in db, the offer would not be updated.
   */
  @projectedName("json", "updateSuppressedDueIdempotence")
  IsUpdateSuppressedDueToIdempotence?: boolean;

  /**
   * Icon File Uris
   */
  iconFileUris?: Record<url>;

  /**
   * Offer plans
   */
  plans?: Plan[];
}

model Plan {
  /**
   * Identifier for this plan
   */
  @visibility("read")
  skuId?: string;

  /**
   * Text identifier for this plan
   */
  @visibility("read")
  planId?: string;

  /**
   * Friendly name for the plan for display in the marketplace
   */
  @visibility("read")
  planDisplayName?: string;

  /**
   * Plan accessibility
   */
  accessibility?: Accessibility;

  /**
   * Alternative stack type
   */
  @visibility("read")
  altStackReference?: string;

  /**
   * Stack type (classic or arm)
   */
  @visibility("read")
  stackType?: string;
}

/**
 * Query user's offers properties
 */
model QueryUserOffersProperties {
  /**
   * Query user's offers details
   */
  @extension("x-ms-client-flatten", true)
  properties?: QueryUserOffersDetails;
}

/**
 * List of offers IDs and list of user's subscriptions IDs to query the user's approved offers
 */
model QueryUserOffersDetails {
  /**
   * List of offer IDs
   */
  offerIds?: string[];

  /**
   * List of subscription IDs
   */
  subscriptionIds?: string[];
}

/**
 * Query user's rules properties
 */
model QueryUserRulesProperties {
  /**
   * Query user's rules details
   */
  @extension("x-ms-client-flatten", true)
  properties?: QueryUserRulesDetails;
}

/**
 * List of subscriptions IDs to query the user's rules
 */
model QueryUserRulesDetails {
  /**
   * List of subscription IDs
   */
  subscriptionIds?: string[];
}

model RuleListResponse {
  @visibility("read")
  value?: Rule[];

  /**
   * URL to get the next set of rules list results if there are any.
   */
  nextLink?: string;
}

model Rule {
  /**
   * Rule type
   */
  type?: RuleType;

  value?: string[];
}

/**
 * Billing accounts response object
 */
model BillingAccountsResponse {
  /**
   * Billing accounts list
   */
  billingAccounts?: string[];
}

/**
 * The subscriptions list to get the related collections
 */
model CollectionsToSubscriptionsMappingPayload {
  /**
   * Subscriptions ids list
   */
  properties?: CollectionsToSubscriptionsMappingProperties;
}

/**
 * The subscriptions list to get the related collections
 */
model CollectionsToSubscriptionsMappingProperties {
  /**
   * Subscriptions ids list
   */
  subscriptionIds?: string[];
}

/**
 * A map of collections subscriptions details
 */
model CollectionsToSubscriptionsMappingResponse {
  /**
   * The map of collections subscriptions
   */
  details?: Record<CollectionsSubscriptionsMappingDetails>;
}

/**
 * Collection name and related subscriptions list
 */
model CollectionsSubscriptionsMappingDetails {
  /**
   * Collection name
   */
  collectionName?: string;

  /**
   * Subscriptions ids list
   */
  subscriptions?: string[];
}

/**
 * The collection details
 */
model CollectionProperties {
  /**
   * Gets collection Id.
   */
  @visibility("read")
  collectionId?: string;

  /**
   * Gets or sets collection name.
   */
  collectionName?: string;

  /**
   * Gets or sets the association with Commercial's Billing Account.
   */
  claim?: string;

  /**
   * Indicating whether all subscriptions are selected (=true) or not (=false).
   */
  allSubscriptions?: boolean;

  /**
   * Indicating whether all items are approved for this collection (=true) or not (=false).
   */
  @visibility("read")
  approveAllItems?: boolean;

  /**
   * Gets the modified date of all items approved.
   */
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  approveAllItemsModifiedAt?: utcDateTime;

  /**
   * Gets or sets subscription ids list. Empty list indicates all subscriptions are selected, null indicates no update is done, explicit list indicates the explicit selected subscriptions. On insert, null is considered as bad request
   */
  subscriptionsList?: string[];

  /**
   * Indicating whether the collection is enabled or disabled.
   */
  enabled?: boolean;

  /**
   * Gets the number of offers associated with the collection.
   */
  @visibility("read")
  numberOfOffers?: int64;

  /**
   * Gets list of collection rules
   */
  @visibility("read")
  appliedRules?: Rule[];
}

/**
 * Transfer offers properties
 */
model TransferOffersProperties {
  /**
   * transfer offers properties details
   */
  @extension("x-ms-client-flatten", true)
  properties?: TransferOffersDetails;
}

/**
 * Transfer offers response details
 */
model TransferOffersDetails {
  /**
   * Target collections ids
   */
  targetCollections?: string[];

  /**
   * Operation to perform (For example: Copy or Move)
   */
  operation?: string;

  /**
   * Offers ids list to transfer from source collection to target collection(s)
   */
  offerIdsList?: string[];
}

/**
 * The transfer items response. The response contains two lists that indicate for each collection whether the operation succeeded or failed
 */
model TransferOffersResponse {
  /**
   * Succeeded collections
   */
  succeeded?: CollectionsDetails[];

  /**
   * Failed collections
   */
  failed?: CollectionsDetails[];
}

/**
 * Collection name and id.
 */
model CollectionsDetails {
  /**
   * Collection name.
   */
  collectionName?: string;

  /**
   * Collection id.
   */
  collectionId?: string;
}

/**
 * Query approved plans payload
 */
model QueryApprovedPlansPayload {
  /**
   * Query approved plans details
   */
  @extension("x-ms-client-flatten", true)
  properties?: QueryApprovedPlans;
}

/**
 * Query approved plans details
 */
model QueryApprovedPlans {
  /**
   * Offer id
   */
  offerId?: string;

  /**
   * Offer plan ids
   */
  planIds?: string[];

  /**
   * List of subscription IDs
   */
  subscriptionIds?: string[];
}

/**
 * Query approved plans response
 */
model QueryApprovedPlansResponse {
  /**
   * A list indicating for each plan which subscriptions are approved. Plan Id is unique
   */
  details?: QueryApprovedPlansDetails[];
}

/**
 * Query approved plans response
 */
model QueryApprovedPlansDetails {
  /**
   * Plan id
   */
  planId?: string;

  /**
   * Approved subscription ids list. In case all subscriptions are approved for a plan, allSubscriptions flag is true and list is empty ( else flag is set to false). In case both subscriptions list is empty and allSubscriptions flag is false, the plan is not approved for any subscription.
   */
  subscriptionIds?: string[];

  /**
   * Indicates whether all subscriptions are approved for this plan
   */
  allSubscriptions?: boolean;
}

/**
 * Bulk collections action properties
 */
model BulkCollectionsPayload {
  /**
   * bulk collections properties details
   */
  @extension("x-ms-client-flatten", true)
  properties?: BulkCollectionsDetails;
}

/**
 * Bulk collection details
 */
model BulkCollectionsDetails {
  /**
   * collection ids list that the action is performed on
   */
  collectionIds?: string[];

  /**
   * Action to perform (For example: EnableCollections, DisableCollections)
   */
  action?: string;
}

/**
 * The bulk collections response. The response contains two lists that indicate for each collection whether the operation succeeded or failed
 */
model BulkCollectionsResponse {
  /**
   * Succeeded collections
   */
  succeeded?: CollectionsDetails[];

  /**
   * Failed collections
   */
  failed?: CollectionsDetails[];
}

/**
 * Suggested subscription list
 */
model CollectionOffersByAllContextsPayload {
  /**
   * Subscriptions ids list
   */
  @extension("x-ms-client-flatten", true)
  properties?: CollectionOffersByAllContextsProperties;
}

/**
 * Suggested subscription list
 */
model CollectionOffersByAllContextsProperties {
  /**
   * Subscription ids list
   */
  subscriptionIds?: string[];
}

/**
 * List of objects which describes offers per context. An empty GUID is a public context.
 */
model CollectionOffersByContextList
  is Azure.Core.Page<CollectionOffersByContext>;

/**
 * List of offers and plans that restricted to the context
 */
model CollectionOffersByContext {
  /**
   * Offer's context, e.g. subscription ID, tenant ID.
   */
  @visibility("read")
  context?: string;

  /**
   * List of offers
   */
  @extension("x-ms-client-flatten", true)
  offers?: CollectionOffersByContextOffers;
}

/**
 * List of offers
 */
model CollectionOffersByContextOffers {
  value?: OfferProperties[];
}

model SetRulesRequest {
  value?: Rule[];

  /**
   * URL to get the next set of rules list results if there are any.
   */
  nextLink?: string;
}

/**
 * Payload object for upsert offer with multiple context and plans.
 */
model MultiContextAndPlansPayload {
  /**
   * Object describes multiple context and plans.
   */
  @extension("x-ms-client-flatten", true)
  properties?: MultiContextAndPlansProperties;
}

/**
 * Object describes multiple context and plans.
 */
model MultiContextAndPlansProperties {
  /**
   * The offer ID which contains the plans.
   */
  offerId?: string;

  /**
   * The offer's eTag.
   */
  eTag?: string;

  plansContext?: ContextAndPlansDetails[];
}

/**
 * Object of plans per context.
 */
model ContextAndPlansDetails {
  /**
   * Plan's context, e.g. subscription ID, tenant ID.
   */
  context?: string;

  /**
   * List of plan IDs.
   */
  planIds?: string[];
}

/**
 * Approval request resource properties
 */
model RequestApprovalProperties {
  /**
   * Gets or sets unique offer id.
   */
  offerId?: string;

  /**
   * Gets offer display name
   */
  @visibility("read")
  offerDisplayName?: string;

  /**
   * The offer's publisher id
   */
  publisherId?: string;

  /**
   * Gets or sets the plans details
   */
  plansDetails?: PlanDetails[];

  /**
   * Gets a value indicating whether the request is closed
   */
  @visibility("read")
  isClosed?: boolean;

  /**
   * Gets or sets the request approval message code
   */
  messageCode?: int64;
}

/**
 * Return plan with request details
 */
model PlanDetails {
  /**
   * Gets or sets Plan Id
   */
  planId?: string;

  /**
   * Gets the plan status
   */
  @visibility("read")
  status?: Status;

  /**
   * Gets request date
   */
  @visibility("read")
  requestDate?: unknown;

  /**
   * Gets or sets user's justification for the plan's request
   */
  justification?: string;

  /**
   * Gets or sets the subscription id that the user is requesting to add the plan to
   */
  subscriptionId?: string;

  /**
   * Gets or sets the subscription name that the user is requesting to add the plan to
   */
  subscriptionName?: string;
}

/**
 * The details to get the request plans statuses
 */
model QueryRequestApprovalProperties {
  /**
   * The details to get the request plans statuses
   */
  @extension("x-ms-client-flatten", true)
  properties?: RequestDetails;
}

/**
 * Request details needed to get the plans statuses
 */
model RequestDetails {
  /**
   * The offer's publisher id
   */
  publisherId?: string;

  /**
   * Current plans list
   */
  planIds?: string[];

  /**
   * Gets or sets the subscription id
   */
  subscriptionId?: string;
}

/**
 * Gets the request plans with indication on each plan whether is approved by the admin, has pending request or not requested yet
 */
model QueryRequestApproval {
  /**
   * Gets or sets unique offer id.
   */
  uniqueOfferId?: string;

  /**
   * Gets or sets the plans details
   */
  plansDetails?: Record<PlanDetails>;

  /**
   * Gets or sets e-tag field
   */
  etag?: string;

  /**
   * Gets or sets the notification message id
   */
  messageCode?: int64;
}

/**
 * Admin approval request resource properties
 */
model AdminRequestApprovalProperties {
  /**
   * Gets or sets offer Id
   */
  offerId?: string;

  /**
   * Gets display name
   */
  @visibility("read")
  displayName?: string;

  /**
   * Gets or sets publisher Id
   */
  publisherId?: string;

  /**
   * Gets or sets admin action
   */
  adminAction?: AdminAction;

  /**
   * Gets or sets Approved plans ids, empty in case of rejected
   */
  approvedPlans?: string[];

  /**
   * Gets or sets admin comment
   */
  comment?: string;

  /**
   * Gets or sets admin details
   */
  administrator?: string;

  /**
   * Gets list of plans with requesters details
   */
  @visibility("read")
  plans?: PlanRequesterDetails[];

  /**
   * Gets or sets list of associated collection ids
   */
  collectionIds?: string[];

  /**
   * The offer icon url.
   */
  @visibility("read")
  icon?: string;
}

/**
 * Plan with requesters details
 */
model PlanRequesterDetails {
  /**
   * Gets the plan id
   */
  @visibility("read")
  planId?: string;

  /**
   * Gets the plan display name
   */
  @visibility("read")
  planDisplayName?: string;

  /**
   * Gets requesters details list
   */
  @visibility("read")
  requesters?: UserRequestDetails[];
}

/**
 * user request details
 */
model UserRequestDetails {
  /**
   * Gets user id
   */
  @visibility("read")
  user?: string;

  /**
   * Gets request date
   */
  @visibility("read")
  date?: string;

  /**
   * Gets justification
   */
  @visibility("read")
  justification?: string;

  /**
   * Gets the subscription id that the user is requesting to add the plan to
   */
  subscriptionId?: string;

  /**
   * Gets the subscription name that the user is requesting to add the plan to
   */
  subscriptionName?: string;
}

/**
 * Get private store notifications state
 */
model PrivateStoreNotificationsState {
  stopSellNotifications?: StopSellNotifications[];
  newNotifications?: NewNotifications[];
  approvalRequests?: RequestApprovalsDetails[];
}

/**
 * Stop sell notification details
 */
model StopSellNotifications {
  /**
   * Gets offer id
   */
  offerId?: string;

  /**
   * Gets offer display name
   */
  displayName?: string;

  /**
   * Gets a value indicating whether entire offer is in stop sell or only few of its plans
   */
  isEntire?: boolean;

  /**
   * Gets or sets the notification message id
   */
  messageCode?: int64;

  /**
   * Gets or sets the icon url
   */
  icon?: string;

  /**
   * Gets or sets removed plans notifications
   */
  plans?: PlanNotificationDetails[];
}

/**
 * Plan notification details
 */
model PlanNotificationDetails {
  /**
   * Gets or sets the plan id
   */
  planId?: string;

  /**
   * Gets or sets the plan display name
   */
  planDisplayName?: string;
}

/**
 * New plans notification details
 */
model NewNotifications {
  /**
   * Gets offer id
   */
  offerId?: string;

  /**
   * Gets offer display name
   */
  displayName?: string;

  /**
   * Gets a value indicating whether future plans is enabled.
   */
  isFuturePlansEnabled?: boolean;

  /**
   * Gets or sets the notification message id
   */
  messageCode?: int64;

  /**
   * Gets or sets the icon url
   */
  icon?: string;

  /**
   * Gets or sets removed plans notifications
   */
  plans?: PlanNotificationDetails[];
}

/**
 * Request approvals details
 */
model RequestApprovalsDetails {
  /**
   * Gets offer id
   */
  offerId?: string;

  /**
   * Gets offer display name
   */
  displayName?: string;

  /**
   * Gets or sets publisher id
   */
  publisherId?: string;

  /**
   * Gets or sets the notification message id
   */
  messageCode?: int64;

  /**
   * Gets or sets the icon url
   */
  icon?: string;

  /**
   * Gets or sets removed plans notifications
   */
  plans?: PlanNotificationDetails[];
}

/**
 * Notification update request payload
 */
model AcknowledgeOfferNotificationProperties {
  /**
   * Notification update request payload details
   */
  @extension("x-ms-client-flatten", true)
  properties?: AcknowledgeOfferNotificationDetails;
}

/**
 * Notification update request payload details
 */
model AcknowledgeOfferNotificationDetails {
  /**
   * Gets or sets a value indicating whether acknowledge action flag is enabled
   */
  acknowledge?: boolean;

  /**
   * Gets or sets a value indicating whether dismiss action flag is enabled
   */
  dismiss?: boolean;

  /**
   * Gets or sets a value indicating whether remove offer action flag is enabled
   */
  removeOffer?: boolean;

  /**
   * Gets or sets added plans
   */
  addPlans?: string[];

  /**
   * Gets or sets remove plans
   */
  removePlans?: string[];
}

/**
 * Withdraw properties
 */
model WithdrawProperties {
  /**
   * Withdraw properties details
   */
  @extension("x-ms-client-flatten", true)
  properties?: WithdrawDetails;
}

/**
 * Withdraw properties details
 */
model WithdrawDetails {
  /**
   * Gets or sets Plan Id
   */
  planId?: string;

  /**
   * The offer's publisher id
   */
  publisherId?: string;
}

/**
 * Subscription list operation response.
 */
model SubscriptionsResponse {
  /**
   * An array of subscriptions.
   */
  @visibility("read")
  value?: Subscription[];

  /**
   * The skip token to retrieve the next page.
   */
  @visibility("read")
  skipToken?: string;

  /**
   * Number of subscriptions on the page
   */
  @visibility("read")
  count?: int64;
}

/**
 * Subscription information.
 */
model Subscription {
  /**
   * The fully qualified ID for the subscription. For example, /subscriptions/00000000-0000-0000-0000-000000000000.
   */
  @visibility("read")
  id?: string;

  /**
   * The subscription ID.
   */
  @visibility("read")
  subscriptionId?: string;

  /**
   * The subscription display name.
   */
  @visibility("read")
  displayName?: string;

  /**
   * The subscription state. Possible values are Enabled, Warned, PastDue, Disabled, and Deleted.
   */
  @visibility("read")
  state?: SubscriptionState;
}

/**
 * List of all new plans notifications for public offers
 */
model NewPlansNotificationsList {
  newPlansNotifications?: NewNotifications[];
}

/**
 * Private plans subscriptions
 */
model StopSellSubscriptions {
  subscriptions?: string[];
}

/**
 * List of stop sell offers and plans notifications.
 */
model StopSellOffersPlansNotificationsList {
  stopSellNotifications?: StopSellOffersPlansNotificationsListProperties[];
}

/**
 * List of stop sell offers and plans notifications.
 */
model StopSellOffersPlansNotificationsListProperties {
  /**
   * The offer id
   */
  @visibility("read")
  offerId?: string;

  /**
   * The offer display name
   */
  @visibility("read")
  displayName?: string;

  /**
   * A value indicating whether entire offer is in stop sell or only few of its plans
   */
  @visibility("read")
  isEntire?: boolean;

  /**
   * The notification message code
   */
  @visibility("read")
  messageCode?: int64;

  /**
   * The icon url
   */
  @visibility("read")
  icon?: string;

  /**
   * The list of removed plans notifications
   */
  @visibility("read")
  plans?: PlanNotificationDetails[];

  /**
   * True if the offer has public plans
   */
  @visibility("read")
  publicContext?: boolean;

  /**
   * The subscriptions related to private plans
   */
  @visibility("read")
  subscriptionsIds?: string[];
}

/**
 * List of subscription Ids in the private store
 */
model SubscriptionsContextList {
  subscriptionsIds?: string[];
}

/**
 * Microsoft.Marketplace REST API operation
 */
model SingleOperation {
  /**
   * Operation ID
   */
  id?: string;

  /**
   * Operation name: {provider}/{resource}/{operation}
   */
  name?: string;

  /**
   * Indicates whether the operation is a data action
   */
  isDataAction?: boolean;

  /**
   * The object that represents the operation.
   */
  display?: SingleOperationDisplay;

  /**
   * Origin of the operation
   */
  origin?: string;

  /**
   * Properties of the operation
   */
  properties?: Record<unknown>;
}

/**
 * The object that represents the operation.
 */
model SingleOperationDisplay {
  /**
   * Service provider: Microsoft.Marketplace
   */
  @visibility("read")
  provider?: string;

  /**
   * Resource on which the operation is performed
   */
  @visibility("read")
  resource?: string;

  /**
   * Operation type
   */
  @visibility("read")
  operation?: string;

  /**
   * Friendly description for the operation,
   */
  @visibility("read")
  description?: string;
}
