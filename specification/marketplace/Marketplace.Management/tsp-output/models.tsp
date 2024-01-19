import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Marketplace;

interface Operations extends Azure.ResourceManager.Operations {}

@doc("Indicates private store availability")
enum Availability {
  enabled,
  disabled,
}

@doc("The type of identity that creates/modifies resources")
enum IdentityType {
  User,
  Application,
  ManagedIdentity,
  Key,
}

@doc("Plan accessibility")
enum Accessibility {
  Unknown,
  Public,
  PrivateTenantOnLevel,
  PrivateSubscriptionOnLevel,
}

@doc("Rule type")
enum RuleType {
  PrivateProducts,
  TermsAndCondition,
}

@doc("Set the Operation for the POST method. Ping or Delete")
enum Operation {
  DeletePrivateStoreOffer,
  DeletePrivateStoreCollection,
  DeletePrivateStoreCollectionOffer,
  Ping,
}

@doc("Gets the plan status")
enum Status {
  Pending,
  Rejected,
  Approved,
  None,
}

@doc("Gets or sets admin action")
enum AdminAction {
  Approved,
  Rejected,
}

@doc("The subscription state. Possible values are Enabled, Warned, PastDue, Disabled, and Deleted.")
enum SubscriptionState {
  Enabled,
  Warned,
  PastDue,
  Disabled,
  Deleted,
}

@doc("Describes the json payload on whether or not the private store is enabled for a given tenant")
model PrivateStoreProperties {
  @doc("Indicates private store availability")
  availability?: Availability;

  @doc("Private Store id")
  @visibility("read")
  privateStoreId?: string;

  @doc("Identifier for purposes of race condition")
  eTag?: string;

  @doc("Private Store Name")
  privateStoreName?: string;

  @doc("Tenant id")
  tenantId?: string;

  @doc("Is government")
  isGov?: boolean;

  @doc("Gets list of associated collection ids")
  @visibility("read")
  collectionIds?: string[];

  @doc("Gets or sets list of branding characteristics")
  branding?: Record<string>;

  @doc("Gets or sets notifications settings")
  notificationsSettings?: NotificationsSettingsProperties;
}

@doc("Describes the json payload for notifications settings")
model NotificationsSettingsProperties {
  @doc("Gets or sets list of notified recipients for new requests")
  recipients?: Recipient[];

  @doc("Gets or sets whether to send email to all marketplace admins for new requests")
  sendToAllMarketplaceAdmins?: boolean;
}

@doc("Describes the json payload for a notified recipient for new requests")
model Recipient {
  @doc("Principal ID")
  principalId?: string;

  @doc("Email Address")
  @visibility("read")
  emailAddress?: string;

  @doc("Display Name")
  @visibility("read")
  displayName?: string;
}

@doc("An Azure resource.")
model Resource {
  @doc("The resource ID.")
  @visibility("read")
  id?: string;

  @doc("The name of the resource.")
  @visibility("read")
  name?: string;

  @doc("The type of the resource.")
  @visibility("read")
  type?: string;

  @doc("Metadata pertaining to creation and last modification of the resource")
  @visibility("read")
  systemData?: SystemData;
}

@doc("The details of the error.")
model ErrorResponseError {
  @doc("Error code.")
  @visibility("read")
  code?: string;

  @doc("Error message indicating why the operation failed.")
  @visibility("read")
  message?: string;
}

@doc("Response object of query if are there existing offers in the collections.")
model AnyExistingOffersInTheCollectionsResponse {
  @doc("Boolean answer, true if exists at least a single offer in an enabled collection, otherwise, false.")
  value?: boolean;
}

@doc("List of offers")
model QueryOffers {
  value?: OfferProperties[];

  @doc("URL to get the next set of PrivateStore list results if there are any.")
  nextLink?: string;
}

model OfferProperties {
  @doc("Offers unique id")
  @visibility("read")
  uniqueOfferId?: string;

  @doc("It will be displayed prominently in the marketplace")
  @visibility("read")
  offerDisplayName?: string;

  @doc("Publisher name that will be displayed prominently in the marketplace")
  @visibility("read")
  publisherDisplayName?: string;

  @doc("Identifier for purposes of race condition")
  eTag?: string;

  @doc("Private store unique id")
  @visibility("read")
  privateStoreId?: string;

  @doc("Private store offer creation date")
  @visibility("read")
  @projectedName("json", "createdAt")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdOn?: utcDateTime;

  @doc("Private store offer modification date")
  @visibility("read")
  @projectedName("json", "modifiedAt")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  modifiedOn?: utcDateTime;

  @doc("Plan ids limitation for this offer")
  specificPlanIdsLimitation?: string[];

  @doc("Indicating whether the offer was not updated to db (true = not updated). If the allow list is identical to the existed one in db, the offer would not be updated.")
  @projectedName("json", "updateSuppressedDueIdempotence")
  IsUpdateSuppressedDueToIdempotence?: boolean;

  @doc("Icon File Uris")
  iconFileUris?: Record<string>;

  @doc("Offer plans")
  plans?: Plan[];
}

model Plan {
  @doc("Identifier for this plan")
  @visibility("read")
  skuId?: string;

  @doc("Text identifier for this plan")
  @visibility("read")
  planId?: string;

  @doc("Friendly name for the plan for display in the marketplace")
  @visibility("read")
  planDisplayName?: string;

  @doc("Plan accessibility")
  accessibility?: Accessibility;

  @doc("Alternative stack type")
  @visibility("read")
  altStackReference?: string;

  @doc("Stack type (classic or arm)")
  @visibility("read")
  stackType?: string;
}

@doc("Query user's offers properties")
model QueryUserOffersProperties {
  @doc("Query user's offers details")
  properties?: QueryUserOffersDetails;
}

@doc("List of offers IDs and list of user's subscriptions IDs to query the user's approved offers")
model QueryUserOffersDetails {
  @doc("List of offer IDs")
  offerIds?: string[];

  @doc("List of subscription IDs")
  subscriptionIds?: string[];
}

@doc("Query user's rules properties")
model QueryUserRulesProperties {
  @doc("Query user's rules details")
  properties?: QueryUserRulesDetails;
}

@doc("List of subscriptions IDs to query the user's rules")
model QueryUserRulesDetails {
  @doc("List of subscription IDs")
  subscriptionIds?: string[];
}

model RuleListResponse {
  @visibility("read")
  value?: Rule[];

  @doc("URL to get the next set of rules list results if there are any.")
  nextLink?: string;
}

model Rule {
  @doc("Rule type")
  type?: RuleType;

  value?: string[];
}

@doc("Billing accounts response object")
model BillingAccountsResponse {
  @doc("Billing accounts list")
  billingAccounts?: string[];
}

@doc("The subscriptions list to get the related collections")
model CollectionsToSubscriptionsMappingPayload {
  @doc("Subscriptions ids list")
  properties?: CollectionsToSubscriptionsMappingProperties;
}

@doc("The subscriptions list to get the related collections")
model CollectionsToSubscriptionsMappingProperties {
  @doc("Subscriptions ids list")
  subscriptionIds?: string[];
}

@doc("A map of collections subscriptions details")
model CollectionsToSubscriptionsMappingResponse {
  @doc("The map of collections subscriptions")
  details?: Record<CollectionsSubscriptionsMappingDetails>;
}

@doc("Collection name and related subscriptions list")
model CollectionsSubscriptionsMappingDetails {
  @doc("Collection name")
  collectionName?: string;

  @doc("Subscriptions ids list")
  subscriptions?: string[];
}

@doc("The collection details")
model CollectionProperties {
  @doc("Gets collection Id.")
  @visibility("read")
  collectionId?: string;

  @doc("Gets or sets collection name.")
  collectionName?: string;

  @doc("Gets or sets the association with Commercial's Billing Account.")
  claim?: string;

  @doc("Indicating whether all subscriptions are selected (=true) or not (=false).")
  allSubscriptions?: boolean;

  @doc("Indicating whether all items are approved for this collection (=true) or not (=false).")
  @visibility("read")
  approveAllItems?: boolean;

  @doc("Gets the modified date of all items approved.")
  @visibility("read")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  approveAllItemsModifiedAt?: utcDateTime;

  @doc("Gets or sets subscription ids list. Empty list indicates all subscriptions are selected, null indicates no update is done, explicit list indicates the explicit selected subscriptions. On insert, null is considered as bad request")
  subscriptionsList?: string[];

  @doc("Indicating whether the collection is enabled or disabled.")
  enabled?: boolean;

  @doc("Gets the number of offers associated with the collection.")
  @visibility("read")
  numberOfOffers?: int32;

  @doc("Gets list of collection rules")
  @visibility("read")
  appliedRules?: Rule[];
}

@doc("Transfer offers properties")
model TransferOffersProperties {
  @doc("transfer offers properties details")
  properties?: TransferOffersDetails;
}

@doc("Transfer offers response details")
model TransferOffersDetails {
  @doc("Target collections ids")
  targetCollections?: string[];

  @doc("Operation to perform (For example: Copy or Move)")
  operation?: string;

  @doc("Offers ids list to transfer from source collection to target collection(s)")
  offerIdsList?: string[];
}

@doc("The transfer items response. The response contains two lists that indicate for each collection whether the operation succeeded or failed")
model TransferOffersResponse {
  @doc("Succeeded collections")
  succeeded?: CollectionsDetails[];

  @doc("Failed collections")
  failed?: CollectionsDetails[];
}

@doc("Collection name and id.")
model CollectionsDetails {
  @doc("Collection name.")
  collectionName?: string;

  @doc("Collection id.")
  collectionId?: string;
}

@doc("Query approved plans payload")
model QueryApprovedPlansPayload {
  @doc("Query approved plans details")
  properties?: QueryApprovedPlans;
}

@doc("Query approved plans details")
model QueryApprovedPlans {
  @doc("Offer id")
  offerId?: string;

  @doc("Offer plan ids")
  planIds?: string[];

  @doc("List of subscription IDs")
  subscriptionIds?: string[];
}

@doc("Query approved plans response")
model QueryApprovedPlansResponse {
  @doc("A list indicating for each plan which subscriptions are approved. Plan Id is unique")
  details?: QueryApprovedPlansDetails[];
}

@doc("Query approved plans response")
model QueryApprovedPlansDetails {
  @doc("Plan id")
  planId?: string;

  @doc("Approved subscription ids list. In case all subscriptions are approved for a plan, allSubscriptions flag is true and list is empty ( else flag is set to false). In case both subscriptions list is empty and allSubscriptions flag is false, the plan is not approved for any subscription.")
  subscriptionIds?: string[];

  @doc("Indicates whether all subscriptions are approved for this plan")
  allSubscriptions?: boolean;
}

@doc("Bulk collections action properties")
model BulkCollectionsPayload {
  @doc("bulk collections properties details")
  properties?: BulkCollectionsDetails;
}

@doc("Bulk collection details")
model BulkCollectionsDetails {
  @doc("collection ids list that the action is performed on")
  collectionIds?: string[];

  @doc("Action to perform (For example: EnableCollections, DisableCollections)")
  action?: string;
}

@doc("The bulk collections response. The response contains two lists that indicate for each collection whether the operation succeeded or failed")
model BulkCollectionsResponse {
  @doc("Succeeded collections")
  succeeded?: CollectionsDetails[];

  @doc("Failed collections")
  failed?: CollectionsDetails[];
}

@doc("Suggested subscription list")
model CollectionOffersByAllContextsPayload {
  @doc("Subscriptions ids list")
  properties?: CollectionOffersByAllContextsProperties;
}

@doc("Suggested subscription list")
model CollectionOffersByAllContextsProperties {
  @doc("Subscription ids list")
  subscriptionIds?: string[];
}

@doc("List of objects which describes offers per context. An empty GUID is a public context.")
model CollectionOffersByContextList
  is Azure.Core.Page<CollectionOffersByContext>;

@doc("List of offers and plans that restricted to the context")
model CollectionOffersByContext {
  @doc("Offer's context, e.g. subscription ID, tenant ID.")
  @visibility("read")
  context?: string;

  @doc("List of offers")
  offers?: CollectionOffersByContextOffers;
}

@doc("List of offers")
model CollectionOffersByContextOffers {
  value?: OfferProperties[];
}

model SetRulesRequest {
  value?: Rule[];

  @doc("URL to get the next set of rules list results if there are any.")
  nextLink?: string;
}

@doc("Payload object for upsert offer with multiple context and plans.")
model MultiContextAndPlansPayload {
  @doc("Object describes multiple context and plans.")
  properties?: MultiContextAndPlansProperties;
}

@doc("Object describes multiple context and plans.")
model MultiContextAndPlansProperties {
  @doc("The offer ID which contains the plans.")
  offerId?: string;

  @doc("The offer's eTag.")
  eTag?: string;

  plansContext?: ContextAndPlansDetails[];
}

@doc("Object of plans per context.")
model ContextAndPlansDetails {
  @doc("Plan's context, e.g. subscription ID, tenant ID.")
  context?: string;

  @doc("List of plan IDs.")
  planIds?: string[];
}

@doc("Approval request resource properties")
model RequestApprovalProperties {
  @doc("Gets or sets unique offer id.")
  offerId?: string;

  @doc("Gets offer display name")
  @visibility("read")
  offerDisplayName?: string;

  @doc("The offer's publisher id")
  publisherId?: string;

  @doc("Gets or sets the plans details")
  plansDetails?: PlanDetails[];

  @doc("Gets a value indicating whether the request is closed")
  @visibility("read")
  isClosed?: boolean;

  @doc("Gets or sets the request approval message code")
  messageCode?: int32;
}

@doc("Return plan with request details")
model PlanDetails {
  @doc("Gets or sets Plan Id ")
  planId?: string;

  @doc("Gets the plan status")
  @visibility("read")
  status?: Status;

  @doc("Gets request date")
  @visibility("read")
  requestDate?: unknown;

  @doc("Gets or sets user's justification for the plan's request")
  justification?: string;

  @doc("Gets or sets the subscription id that the user is requesting to add the plan to")
  subscriptionId?: string;

  @doc("Gets or sets the subscription name that the user is requesting to add the plan to")
  subscriptionName?: string;
}

@doc("The details to get the request plans statuses")
model QueryRequestApprovalProperties {
  @doc("The details to get the request plans statuses")
  properties?: RequestDetails;
}

@doc("Request details needed to get the plans statuses")
model RequestDetails {
  @doc("The offer's publisher id")
  publisherId?: string;

  @doc("Current plans list")
  planIds?: string[];

  @doc("Gets or sets the subscription id")
  subscriptionId?: string;
}

@doc("Gets the request plans with indication on each plan whether is approved by the admin, has pending request or not requested yet")
model QueryRequestApproval {
  @doc("Gets or sets unique offer id.")
  uniqueOfferId?: string;

  @doc("Gets or sets the plans details")
  plansDetails?: Record<PlanDetails>;

  @doc("Gets or sets e-tag field ")
  etag?: string;

  @doc("Gets or sets the notification message id")
  messageCode?: int32;
}

@doc("Admin approval request resource properties")
model AdminRequestApprovalProperties {
  @doc("Gets or sets offer Id")
  offerId?: string;

  @doc("Gets display name")
  @visibility("read")
  displayName?: string;

  @doc("Gets or sets publisher Id")
  publisherId?: string;

  @doc("Gets or sets admin action")
  adminAction?: AdminAction;

  @doc("Gets or sets Approved plans ids, empty in case of rejected")
  approvedPlans?: string[];

  @doc("Gets or sets admin comment")
  comment?: string;

  @doc("Gets or sets admin details")
  administrator?: string;

  @doc("Gets list of plans with requesters details")
  @visibility("read")
  plans?: PlanRequesterDetails[];

  @doc("Gets or sets list of associated collection ids")
  collectionIds?: string[];

  @doc("The offer icon url.")
  @visibility("read")
  icon?: string;
}

@doc("Plan with requesters details")
model PlanRequesterDetails {
  @doc("Gets the plan id")
  @visibility("read")
  planId?: string;

  @doc("Gets the plan display name")
  @visibility("read")
  planDisplayName?: string;

  @doc("Gets requesters details list")
  @visibility("read")
  requesters?: UserRequestDetails[];
}

@doc("user request details")
model UserRequestDetails {
  @doc("Gets user id")
  @visibility("read")
  user?: string;

  @doc("Gets request date")
  @visibility("read")
  date?: string;

  @doc("Gets justification")
  @visibility("read")
  justification?: string;

  @doc("Gets the subscription id that the user is requesting to add the plan to")
  subscriptionId?: string;

  @doc("Gets the subscription name that the user is requesting to add the plan to")
  subscriptionName?: string;
}

@doc("Get private store notifications state")
model PrivateStoreNotificationsState {
  stopSellNotifications?: StopSellNotifications[];
  newNotifications?: NewNotifications[];
  approvalRequests?: RequestApprovalsDetails[];
}

@doc("Stop sell notification details")
model StopSellNotifications {
  @doc("Gets offer id")
  offerId?: string;

  @doc("Gets offer display name")
  displayName?: string;

  @doc("Gets a value indicating whether entire offer is in stop sell or only few of its plans")
  isEntire?: boolean;

  @doc("Gets or sets the notification message id")
  messageCode?: int32;

  @doc("Gets or sets the icon url")
  icon?: string;

  @doc("Gets or sets removed plans notifications")
  plans?: PlanNotificationDetails[];
}

@doc("Plan notification details")
model PlanNotificationDetails {
  @doc("Gets or sets the plan id")
  planId?: string;

  @doc("Gets or sets the plan display name")
  planDisplayName?: string;
}

@doc("New plans notification details")
model NewNotifications {
  @doc("Gets offer id")
  offerId?: string;

  @doc("Gets offer display name")
  displayName?: string;

  @doc("Gets a value indicating whether future plans is enabled.")
  isFuturePlansEnabled?: boolean;

  @doc("Gets or sets the notification message id")
  messageCode?: int32;

  @doc("Gets or sets the icon url")
  icon?: string;

  @doc("Gets or sets removed plans notifications")
  plans?: PlanNotificationDetails[];
}

@doc("Request approvals details")
model RequestApprovalsDetails {
  @doc("Gets offer id")
  offerId?: string;

  @doc("Gets offer display name")
  displayName?: string;

  @doc("Gets or sets publisher id")
  publisherId?: string;

  @doc("Gets or sets the notification message id")
  messageCode?: int32;

  @doc("Gets or sets the icon url")
  icon?: string;

  @doc("Gets or sets removed plans notifications")
  plans?: PlanNotificationDetails[];
}

@doc("Notification update request payload")
model AcknowledgeOfferNotificationProperties {
  @doc("Notification update request payload details")
  properties?: AcknowledgeOfferNotificationDetails;
}

@doc("Notification update request payload details")
model AcknowledgeOfferNotificationDetails {
  @doc("Gets or sets a value indicating whether acknowledge action flag is enabled")
  acknowledge?: boolean;

  @doc("Gets or sets a value indicating whether dismiss action flag is enabled")
  dismiss?: boolean;

  @doc("Gets or sets a value indicating whether remove offer action flag is enabled")
  removeOffer?: boolean;

  @doc("Gets or sets added plans")
  addPlans?: string[];

  @doc("Gets or sets remove plans")
  removePlans?: string[];
}

@doc("Withdraw properties")
model WithdrawProperties {
  @doc("Withdraw properties details")
  properties?: WithdrawDetails;
}

@doc("Withdraw properties details")
model WithdrawDetails {
  @doc("Gets or sets Plan Id ")
  planId?: string;

  @doc("The offer's publisher id")
  publisherId?: string;
}

@doc("Subscription list operation response.")
model SubscriptionsResponse {
  @doc("An array of subscriptions.")
  @visibility("read")
  value?: Subscription[];

  @doc("The skip token to retrieve the next page.")
  @visibility("read")
  skipToken?: string;

  @doc("Number of subscriptions on the page")
  @visibility("read")
  count?: int32;
}

@doc("Subscription information.")
model Subscription {
  @doc("The fully qualified ID for the subscription. For example, /subscriptions/00000000-0000-0000-0000-000000000000.")
  @visibility("read")
  id?: string;

  @doc("The subscription ID.")
  @visibility("read")
  subscriptionId?: string;

  @doc("The subscription display name.")
  @visibility("read")
  displayName?: string;

  @doc("The subscription state. Possible values are Enabled, Warned, PastDue, Disabled, and Deleted.")
  @visibility("read")
  state?: SubscriptionState;
}

@doc("List of all new plans notifications for public offers")
model NewPlansNotificationsList {
  newPlansNotifications?: NewNotifications[];
}

@doc("Private plans subscriptions")
model StopSellSubscriptions {
  subscriptions?: string[];
}

@doc("List of stop sell offers and plans notifications.")
model StopSellOffersPlansNotificationsList {
  stopSellNotifications?: StopSellOffersPlansNotificationsListProperties[];
}

@doc("List of stop sell offers and plans notifications.")
model StopSellOffersPlansNotificationsListProperties {
  @doc("The offer id")
  @visibility("read")
  offerId?: string;

  @doc("The offer display name")
  @visibility("read")
  displayName?: string;

  @doc("A value indicating whether entire offer is in stop sell or only few of its plans")
  @visibility("read")
  isEntire?: boolean;

  @doc("The notification message code")
  @visibility("read")
  messageCode?: int32;

  @doc("The icon url")
  @visibility("read")
  icon?: string;

  @doc("The list of removed plans notifications")
  @visibility("read")
  plans?: PlanNotificationDetails[];

  @doc("True if the offer has public plans")
  @visibility("read")
  publicContext?: boolean;

  @doc("The subscriptions related to private plans")
  @visibility("read")
  subscriptionsIds?: string[];
}

@doc("List of subscription Ids in the private store")
model SubscriptionsContextList {
  subscriptionsIds?: string[];
}

@doc("Microsoft.Marketplace REST API operation")
model SingleOperation {
  @doc("Operation ID")
  id?: string;

  @doc("Operation name: {provider}/{resource}/{operation}")
  name?: string;

  @doc("Indicates whether the operation is a data action")
  isDataAction?: boolean;

  @doc("The object that represents the operation.")
  display?: SingleOperationDisplay;

  @doc("Origin of the operation")
  origin?: string;

  @doc("Properties of the operation")
  properties?: Record<unknown>;
}

@doc("The object that represents the operation.")
model SingleOperationDisplay {
  @doc("Service provider: Microsoft.Marketplace")
  @visibility("read")
  provider?: string;

  @doc("Resource on which the operation is performed")
  @visibility("read")
  resource?: string;

  @doc("Operation type")
  @visibility("read")
  operation?: string;

  @doc("Friendly description for the operation,")
  @visibility("read")
  description?: string;
}
