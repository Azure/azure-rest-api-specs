import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Microsoft.Marketplace;

/**
 * Indicates private store availability
 */
union Availability {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  enabled: "enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  disabled: "disabled",
}

/**
 * The type of identity that creates/modifies resources
 */
union IdentityType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  User: "User",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Application: "Application",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  ManagedIdentity: "ManagedIdentity",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Key: "Key",
}

/**
 * Plan accessibility
 */
union Accessibility {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Unknown: "Unknown",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Public: "Public",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PrivateTenantOnLevel: "PrivateTenantOnLevel",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PrivateSubscriptionOnLevel: "PrivateSubscriptionOnLevel",
}

/**
 * Rule type
 */
union RuleType {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PrivateProducts: "PrivateProducts",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  TermsAndCondition: "TermsAndCondition",
}

/**
 * Set the Operation for the POST method. Ping or Delete
 */
union Operation {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DeletePrivateStoreOffer: "DeletePrivateStoreOffer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DeletePrivateStoreCollection: "DeletePrivateStoreCollection",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  DeletePrivateStoreCollectionOffer: "DeletePrivateStoreCollectionOffer",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Ping: "Ping",
}

/**
 * Gets the plan status
 */
union Status {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Pending: "Pending",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Rejected: "Rejected",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Approved: "Approved",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  None: "None",
}

/**
 * Gets or sets admin action
 */
union AdminAction {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Approved: "Approved",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Rejected: "Rejected",
}

/**
 * The subscription state. Possible values are Enabled, Warned, PastDue, Disabled, and Deleted.
 */
union SubscriptionState {
  string,
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Enabled: "Enabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Warned: "Warned",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  PastDue: "PastDue",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Disabled: "Disabled",
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  Deleted: "Deleted",
}

/**
 * Describes the json payload for the list of available private stores (between zero and one, inclusive)
 */
model PrivateStoreList is Azure.Core.Page<PrivateStore>;

/**
 * Describes the json payload on whether or not the private store is enabled for a given tenant
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model PrivateStoreProperties {
  /**
   * Indicates private store availability
   */
  availability?: Availability;

  /**
   * Private Store id
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  collectionIds?: string[];

  /**
   * Gets or sets list of branding characteristics
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  branding?: Record<string>;

  /**
   * Gets or sets notifications settings
   */
  notificationsSettings?: NotificationsSettingsProperties;
}

/**
 * Describes the json payload for notifications settings
 */
model NotificationsSettingsProperties {
  /**
   * Gets or sets list of notified recipients for new requests
   */
  @identifiers(#["principalId"])
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
  @visibility(Lifecycle.Read)
  emailAddress?: string;

  /**
   * Display Name
   */
  @visibility(Lifecycle.Read)
  displayName?: string;
}

/**
 * An Azure resource.
 */
model Resource {
  /**
   * The resource ID.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The name of the resource.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The type of the resource.
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * Metadata pertaining to creation and last modification of the resource
   */
  @visibility(Lifecycle.Read)
  systemData?: SystemData;
}

/**
 * Read only system data
 */
model SystemData {
  /**
   * The identity that created the resource.
   */
  createdBy?: string;

  /**
   * The type of identity that created the resource
   */
  createdByType?: IdentityType;

  /**
   * The timestamp of resource creation (UTC)
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  createdAt?: utcDateTime;

  /**
   * The identity that last modified the resource.
   */
  lastModifiedBy?: string;

  /**
   * The type of identity that last modified the resource
   */
  lastModifiedByType?: IdentityType;

  /**
   * The timestamp of resource last modification (UTC)
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  lastModifiedAt?: utcDateTime;
}

/**
 * Error response indicates Microsoft.Marketplace service is not able to process the incoming request. The reason is provided in the error message.
 */
@error
model ErrorResponse {
  /**
   * The details of the error.
   */
  error?: ErrorResponseError;
}

/**
 * The details of the error.
 */
model ErrorResponseError {
  /**
   * Error code.
   */
  @visibility(Lifecycle.Read)
  code?: string;

  /**
   * Error message indicating why the operation failed.
   */
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#["uniqueOfferId"])
  value?: OfferProperties[];

  /**
   * URL to get the next set of PrivateStore list results if there are any.
   */
  nextLink?: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model OfferProperties {
  /**
   * Offers unique id
   */
  @visibility(Lifecycle.Read)
  uniqueOfferId?: string;

  /**
   * It will be displayed prominently in the marketplace
   */
  @visibility(Lifecycle.Read)
  offerDisplayName?: string;

  /**
   * Publisher name that will be displayed prominently in the marketplace
   */
  @visibility(Lifecycle.Read)
  publisherDisplayName?: string;

  /**
   * Identifier for purposes of race condition
   */
  eTag?: string;

  /**
   * Private store unique id
   */
  @visibility(Lifecycle.Read)
  privateStoreId?: string;

  /**
   * Private store offer creation date
   */
  @visibility(Lifecycle.Read)
  createdAt?: string;

  /**
   * Private store offer modification date
   */
  @visibility(Lifecycle.Read)
  modifiedAt?: string;

  /**
   * Plan ids limitation for this offer
   */
  specificPlanIdsLimitation?: string[];

  /**
   * Indicating whether the offer was not updated to db (true = not updated). If the allow list is identical to the existed one in db, the offer would not be updated.
   */
  updateSuppressedDueIdempotence?: boolean;

  /**
   * Icon File Uris
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  iconFileUris?: Record<string>;

  /**
   * Indicating whether the offer is stop sell or not.
   */
  @visibility(Lifecycle.Read)
  isStopSell?: boolean;

  /**
   * Offer plans
   */
  @identifiers(#["planId"])
  plans?: Plan[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model Plan {
  /**
   * Identifier for this plan
   */
  @visibility(Lifecycle.Read)
  skuId?: string;

  /**
   * Text identifier for this plan
   */
  @visibility(Lifecycle.Read)
  planId?: string;

  /**
   * Friendly name for the plan for display in the marketplace
   */
  @visibility(Lifecycle.Read)
  planDisplayName?: string;

  /**
   * Plan accessibility
   */
  accessibility?: Accessibility;

  /**
   * Alternative stack type
   */
  @visibility(Lifecycle.Read)
  altStackReference?: string;

  /**
   * Stack type (classic or arm)
   */
  @visibility(Lifecycle.Read)
  stackType?: string;

  /**
   * Indicating whether the plan is stop sell or not.
   */
  @visibility(Lifecycle.Read)
  isStopSell?: boolean;
}

/**
 * Query user's offers properties
 */
model QueryUserOffersProperties {
  /**
   * Query user's offers details
   */
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RuleListResponse {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  @identifiers(#["type"])
  value?: Rule[];

  /**
   * URL to get the next set of rules list results if there are any.
   */
  nextLink?: string;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model Rule {
  /**
   * Rule type
   */
  type?: RuleType;

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CollectionsList {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @pageItems
  value?: Collection[];

  /**
   * URL to get the next set of offer list results if there are any.
   */
  @nextLink
  nextLink?: string;
}

/**
 * The collection details
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model CollectionProperties {
  /**
   * Gets collection Id.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  approveAllItems?: boolean;

  /**
   * Gets the modified date of all items approved.
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  numberOfOffers?: int64;

  /**
   * Gets list of collection rules
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["type"])
  appliedRules?: Rule[];
}

/**
 * Transfer offers properties
 */
model TransferOffersProperties {
  /**
   * transfer offers properties details
   */
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
  @identifiers(#["collectionId"])
  succeeded?: CollectionsDetails[];

  /**
   * Failed collections
   */
  @identifiers(#["collectionId"])
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
  @identifiers(#["planId"])
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
  @identifiers(#["collectionId"])
  succeeded?: CollectionsDetails[];

  /**
   * Failed collections
   */
  @identifiers(#["collectionId"])
  failed?: CollectionsDetails[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model OfferListResponse is Azure.Core.Page<Offer>;

/**
 * Suggested subscription list
 */
model CollectionOffersByAllContextsPayload {
  /**
   * Subscriptions ids list
   */
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
model CollectionOffersByContextList {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#["context"])
  @visibility(Lifecycle.Read)
  @pageItems
  value?: CollectionOffersByContext[];

  /**
   * URL to get the next set of offer list per context results if there are any.
   */
  @nextLink
  nextLink?: string;
}

/**
 * List of offers and plans that restricted to the context
 */
model CollectionOffersByContext {
  /**
   * Offer's context, e.g. subscription ID, tenant ID.
   */
  @visibility(Lifecycle.Read)
  context?: string;

  /**
   * List of offers
   */
  offers?: CollectionOffersByContextOffers;
}

/**
 * List of offers
 */
model CollectionOffersByContextOffers {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#["uniqueOfferId"])
  value?: OfferProperties[];
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model SetRulesRequest {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#["type"])
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

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#["context"])
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
 * List of admin request approval resources
 */
model RequestApprovalsList {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @pageItems
  value?: RequestApprovalResource[];

  /**
   * URL to get the next set of notifications list results if there are any.
   */
  @visibility(Lifecycle.Read)
  @nextLink
  nextLink?: string;
}

/**
 * Approval request resource properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model RequestApprovalProperties {
  /**
   * Gets or sets unique offer id.
   */
  offerId?: string;

  /**
   * Gets offer display name
   */
  @visibility(Lifecycle.Read)
  offerDisplayName?: string;

  /**
   * The offer's publisher id
   */
  publisherId?: string;

  /**
   * Gets or sets the plans details
   */
  @identifiers(#["planId"])
  plansDetails?: PlanDetails[];

  /**
   * Gets a value indicating whether the request is closed
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  status?: Status;

  /**
   * Gets request date
   */
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
 * List of admin request approval resources
 */
model AdminRequestApprovalsList {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @pageItems
  value?: AdminRequestApprovalsResource[];

  /**
   * URL to get the next set of notifications list results if there are any.
   */
  @visibility(Lifecycle.Read)
  @nextLink
  nextLink?: string;
}

/**
 * Admin approval request resource properties
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model AdminRequestApprovalProperties {
  /**
   * Gets or sets offer Id
   */
  offerId?: string;

  /**
   * Gets display name
   */
  @visibility(Lifecycle.Read)
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
  @visibility(Lifecycle.Read)
  @identifiers(#["planId"])
  plans?: PlanRequesterDetails[];

  /**
   * Gets or sets list of associated collection ids
   */
  collectionIds?: string[];

  /**
   * The offer icon url.
   */
  @visibility(Lifecycle.Read)
  icon?: string;
}

/**
 * Plan with requesters details
 */
model PlanRequesterDetails {
  /**
   * Gets the plan id
   */
  @visibility(Lifecycle.Read)
  planId?: string;

  /**
   * Gets the plan display name
   */
  @visibility(Lifecycle.Read)
  planDisplayName?: string;

  /**
   * Gets requesters details list
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["user"])
  requesters?: UserRequestDetails[];
}

/**
 * user request details
 */
model UserRequestDetails {
  /**
   * Gets user id
   */
  @visibility(Lifecycle.Read)
  user?: string;

  /**
   * Gets request date
   */
  @visibility(Lifecycle.Read)
  date?: string;

  /**
   * Gets justification
   */
  @visibility(Lifecycle.Read)
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
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  stopSellNotifications?: StopSellNotifications[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  newNotifications?: NewNotifications[];

  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
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
  @identifiers(#["planId"])
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
  @identifiers(#["planId"])
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
  @identifiers(#["planId"])
  plans?: PlanNotificationDetails[];
}

/**
 * Notification update request payload
 */
model AcknowledgeOfferNotificationProperties {
  /**
   * Notification update request payload details
   */
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
  @visibility(Lifecycle.Read)
  value?: Subscription[];

  /**
   * The skip token to retrieve the next page.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  skipToken?: string;

  /**
   * Number of subscriptions on the page
   */
  @visibility(Lifecycle.Read)
  count?: int64;
}

/**
 * Subscription information.
 */
model Subscription {
  /**
   * The fully qualified ID for the subscription. For example, /subscriptions/00000000-0000-0000-0000-000000000000.
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * The subscription ID.
   */
  @visibility(Lifecycle.Read)
  subscriptionId?: string;

  /**
   * The subscription display name.
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * The subscription state. Possible values are Enabled, Warned, PastDue, Disabled, and Deleted.
   */
  @visibility(Lifecycle.Read)
  state?: SubscriptionState;
}

/**
 * List of all new plans notifications for public offers
 */
model NewPlansNotificationsList {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#[])
  newPlansNotifications?: NewNotifications[];
}

/**
 * Private plans subscriptions
 */
model StopSellSubscriptions {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  subscriptions?: string[];
}

/**
 * List of stop sell offers and plans notifications.
 */
model StopSellOffersPlansNotificationsList {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @identifiers(#["offerId"])
  stopSellNotifications?: StopSellOffersPlansNotificationsListProperties[];
}

/**
 * List of stop sell offers and plans notifications.
 */
model StopSellOffersPlansNotificationsListProperties {
  /**
   * The offer id
   */
  @visibility(Lifecycle.Read)
  offerId?: string;

  /**
   * The offer display name
   */
  @visibility(Lifecycle.Read)
  displayName?: string;

  /**
   * A value indicating whether entire offer is in stop sell or only few of its plans
   */
  @visibility(Lifecycle.Read)
  isEntire?: boolean;

  /**
   * The notification message code
   */
  @visibility(Lifecycle.Read)
  messageCode?: int64;

  /**
   * The icon url
   */
  @visibility(Lifecycle.Read)
  icon?: string;

  /**
   * The list of removed plans notifications
   */
  @visibility(Lifecycle.Read)
  @identifiers(#["planId"])
  plans?: PlanNotificationDetails[];

  /**
   * True if the offer has public plans
   */
  @visibility(Lifecycle.Read)
  publicContext?: boolean;

  /**
   * The subscriptions related to private plans
   */
  @visibility(Lifecycle.Read)
  subscriptionsIds?: string[];
}

/**
 * List of subscription Ids in the private store
 */
model SubscriptionsContextList {
  #suppress "@azure-tools/typespec-azure-core/documentation-required" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  properties?: unknown;
}

/**
 * The object that represents the operation.
 */
model SingleOperationDisplay {
  /**
   * Service provider: Microsoft.Marketplace
   */
  @visibility(Lifecycle.Read)
  provider?: string;

  /**
   * Resource on which the operation is performed
   */
  @visibility(Lifecycle.Read)
  resource?: string;

  /**
   * Operation type
   */
  @visibility(Lifecycle.Read)
  operation?: string;

  /**
   * Friendly description for the operation,
   */
  @visibility(Lifecycle.Read)
  description?: string;
}

/**
 * Result of the request to list Marketplace operations. It contains a list of operations and a URL link to get the next set of results.
 */
model OperationListResult {
  /**
   * List of Microsoft.Marketplace operations supported by the Microsoft.Marketplace resource provider.
   */
  @pageItems
  @identifiers(#["name"])
  value?: SingleOperation[];

  /**
   * URL to get the next set of operation list results if there are any.
   */
  @visibility(Lifecycle.Read)
  @nextLink
  nextLink?: string;
}
