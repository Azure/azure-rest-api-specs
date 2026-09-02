import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.Marketplace;

// ===== Client name =====
@@clientName(Microsoft.Marketplace, "MarketplaceMgmtClient", "python");

// csharp configartion
@@clientName(
  AdminRequestApprovalsResource,
  "MarketplaceAdminApprovalRequest",
  "csharp"
);
@@clientName(
  AdminRequestApprovalsList,
  "MarketplaceAdminApprovalRequestList",
  "csharp"
);
@@clientName(Collection, "PrivateStoreCollectionInfo", "csharp");
@@clientName(Offer, "PrivateStoreOffer", "csharp");
@@clientName(RequestApprovalResource, "MarketplaceApprovalRequest", "csharp");
@@clientName(SubscriptionsResponse, "SubscriptionsResult", "csharp");
@@clientName(
  AcknowledgeOfferNotificationDetails.acknowledge,
  "IsAcknowledgeActionFlagEnabled",
  "csharp"
);
@@clientName(
  AcknowledgeOfferNotificationDetails.dismiss,
  "IsDismissActionFlagEnabled",
  "csharp"
);
@@clientName(
  AcknowledgeOfferNotificationDetails.removeOffer,
  "IsRemoveOfferActionFlagEnabled",
  "csharp"
);
@@clientName(
  CollectionProperties.allSubscriptions,
  "AreAllSubscriptionsSelected",
  "csharp"
);
@@clientName(CollectionProperties.enabled, "IsEnabled", "csharp");
@@clientName(
  CollectionProperties.approveAllItems,
  "AreAllItemsApproved",
  "csharp"
);
@@clientName(
  StopSellOffersPlansNotificationsListProperties.publicContext,
  "HasPublicContext",
  "csharp"
);
@@clientName(
  StopSellOffersPlansNotificationsListProperties.isEntire,
  "IsEntireInStopSell",
  "csharp"
);
@@clientName(OfferProperties.createdAt, "CreatedOn", "csharp");
@@clientName(OfferProperties.modifiedAt, "ModifiedOn", "csharp");
@@clientName(
  OfferProperties.updateSuppressedDueIdempotence,
  "IsUpdateSuppressedDueToIdempotence",
  "csharp"
);
@@clientName(AdminRequestApprovalProperties.icon, "IconUri", "csharp");
@@clientName(NewNotifications.icon, "IconUri", "csharp");
@@clientName(StopSellNotifications.icon, "IconUri", "csharp");
@@clientName(RequestApprovalsDetails.icon, "IconUri", "csharp");
@@clientName(
  StopSellOffersPlansNotificationsListProperties.icon,
  "IconUri",
  "csharp"
);
@@clientName(Rule.type, "RuleType", "csharp");
// The two POSTs in routes.tsp share their URL with the resource DELETE verbs. They are a
// non-standard server-side workaround surfaced publicly on main as a second Delete overload
// taking PrivateStoreOperation?. We rename the generated method to "Delete" and merge it
// into the CRUD client so the resource exposes both Delete(WaitUntil) (from the real DELETE
// verb) and Delete(PrivateStoreOperation?) (from this POST workaround), matching main.
// The @Azure.ResourceManager.Private.legacyResourceOperation decorators in routes.tsp pin
// each POST to its owning resource (Collection / Offer).
// The MPG generator has a codegen gap for extensible-enum bodies: it emits
// `PrivateStoreOperation.ToRequestContent(payload)` but never emits that helper on the
// extensible-enum struct. A SDK-side partial at src/Customize/Models/PrivateStoreOperation.cs
// supplies the missing method so the generated Delete(PrivateStoreOperation?) still compiles.
@@clientName(PrivateStoreCollectionOperationGroup.post, "Delete", "csharp");
@@clientName(
  PrivateStoreCollectionOfferOperationGroup.post,
  "Delete",
  "csharp"
);
// Merge the POSTs into the existing CRUD client groups, avoiding an orphan
// "PrivateStoreCollection" client (which would also collide with the ArmCollection class
// for PrivateStoreResource) and a redundant sibling client for offer.
@@clientLocation(
  PrivateStoreCollectionOperationGroup.post,
  "PrivateStoreCollectionInfo",
  "csharp"
);
@@clientLocation(
  PrivateStoreCollectionOfferOperationGroup.post,
  "PrivateStoreCollectionOffer",
  "csharp"
);
@@clientName(
  PrivateStores.fetchAllSubscriptionsInTenant,
  "FetchAllMarketplaceSubscriptions",
  "csharp"
);
@@clientName(
  RequestApprovalResources.queryRequestApproval,
  "QueryApprovalRequest",
  "csharp"
);
@@clientName(PrivateStores.billingAccounts, "FetchBillingAccounts", "csharp");
@@clientName(
  PrivateStores.bulkCollectionsAction,
  "PerformActionOnBulkCollections",
  "csharp"
);
@@clientName(
  PrivateStores.collectionsToSubscriptionsMapping,
  "FetchCollectionsToSubscriptionsMapping",
  "csharp"
);
@@clientName(
  Collections.listByContexts,
  "GetPrivateStoreCollectionOffersByContexts",
  "csharp"
);
@@clientName(Offers.contextsView, "GetByContexts", "csharp");
@@clientName(
  AcknowledgeOfferNotificationProperties,
  "AcknowledgeOfferNotificationContent",
  "csharp"
);
@@clientName(
  AnyExistingOffersInTheCollectionsResponse,
  "AnyExistingOffersInTheCollectionsResult",
  "csharp"
);
@@clientName(BulkCollectionsPayload, "BulkCollectionsActionContent", "csharp");
@@clientName(BulkCollectionsResponse, "BulkCollectionsActionResult", "csharp");
@@clientName(CollectionsDetails, "PrivateStoreCollectionDetails", "csharp");
@@clientName(
  CollectionsToSubscriptionsMappingPayload,
  "CollectionsToSubscriptionsMappingContent",
  "csharp"
);
@@clientName(
  CollectionsToSubscriptionsMappingResponse,
  "CollectionsToSubscriptionsMappingResult",
  "csharp"
);
@@clientName(
  MultiContextAndPlansPayload,
  "MultiContextAndPlansContent",
  "csharp"
);
@@clientName(NewNotifications, "NewPlanNotification", "csharp");
@@clientName(
  NewPlansNotificationsList,
  "NewPlanNotificationListResult",
  "csharp"
);
@@clientName(OfferProperties, "PrivateStoreOfferResult", "csharp");
@@clientName(QueryApprovedPlansPayload, "QueryApprovedPlansContent", "csharp");
@@clientName(QueryApprovedPlansResponse, "QueryApprovedPlansResult", "csharp");
@@clientName(QueryRequestApproval, "QueryApprovalRequestResult", "csharp");
@@clientName(
  QueryRequestApprovalProperties,
  "QueryApprovalRequestContent",
  "csharp"
);
@@clientName(QueryUserOffersProperties, "QueryUserOffersContent", "csharp");
@@clientName(QueryUserRulesProperties, "QueryUserRulesContent", "csharp");
@@clientName(Recipient, "NotificationRecipient", "csharp");
@@clientName(
  BillingAccountsResponse,
  "PrivateStoreBillingAccountsResult",
  "csharp"
);
@@clientName(SetRulesRequest, "SetRulesContent", "csharp");
@@clientName(TransferOffersProperties, "TransferOffersContent", "csharp");
@@clientName(TransferOffersResponse, "TransferOffersResult", "csharp");
@@clientName(UserRequestDetails, "PlanRequesterInfo", "csharp");
@@clientName(WithdrawProperties, "WithdrawPlanContent", "csharp");
@@clientName(
  StopSellOffersPlansNotificationsListProperties,
  "StopSellOffersPlansNotificationsResult",
  "csharp"
);
@@clientName(Accessibility, "PrivateStorePlanAccessibility", "csharp");
@@clientName(AdminAction, "MarketplaceAdminAction", "csharp");
@@clientName(Availability, "PrivateStoreAvailability", "csharp");
@@clientName(Operation, "PrivateStoreOperation", "csharp");
@@clientName(Rule, "MarketplaceRule", "csharp");
@@clientName(RuleListResponse, "MarketplaceRuleListResult", "csharp");
@@clientName(RuleType, "MarketplaceRuleType", "csharp");
@@clientName(Status, "PrivateStorePlanStatus", "csharp");
@@clientName(Subscription, "MarketplaceSubscription", "csharp");
@@clientName(SubscriptionState, "MarketplaceSubscriptionState", "csharp");
@@clientName(PlanDetails, "PrivateStorePlanDetails", "csharp");
@@clientName(Plan, "PrivateStorePlan", "csharp");
// NOTE: @@clientName on Collections.createOrUpdate::parameters.resource has no effect
// for the C# MPG generator. BodyParameterNameNormalizer forcibly renames body parameters
// based on the body type suffix (e.g., a type ending in "Data" becomes "data"), overriding
// any client-name customization. Kept as a comment for historical context.

// ===== @@alternateType: Type changes (C#) =====
@@alternateType(
  PrivateStoreProperties.privateStoreId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(PrivateStoreProperties.tenantId, Azure.Core.uuid, "csharp");
@@alternateType(CollectionProperties.collectionId, Azure.Core.uuid, "csharp");
@@alternateType(CollectionsDetails.collectionId, Azure.Core.uuid, "csharp");
@@alternateType(Recipient.principalId, Azure.Core.uuid, "csharp");
@@alternateType(OfferProperties.privateStoreId, Azure.Core.uuid, "csharp");
@@alternateType(AdminRequestApprovalProperties.icon, url, "csharp");
@@alternateType(NewNotifications.icon, url, "csharp");
@@alternateType(StopSellNotifications.icon, url, "csharp");
@@alternateType(RequestApprovalsDetails.icon, url, "csharp");
@@alternateType(
  StopSellOffersPlansNotificationsListProperties.icon,
  url,
  "csharp"
);
@@alternateType(OfferProperties.createdAt, utcDateTime, "csharp");
@@alternateType(OfferProperties.modifiedAt, utcDateTime, "csharp");
@@alternateType(PrivateStoreProperties.eTag, Azure.Core.eTag, "csharp");
@@alternateType(OfferProperties.eTag, Azure.Core.eTag, "csharp");
@@alternateType(MultiContextAndPlansProperties.eTag, Azure.Core.eTag, "csharp");
@@alternateType(QueryRequestApproval.etag, Azure.Core.eTag, "csharp");
@@alternateType(
  PrivateStoreProperties.collectionIds,
  Azure.Core.uuid[],
  "csharp"
);
@@alternateType(
  BulkCollectionsDetails.collectionIds,
  Azure.Core.uuid[],
  "csharp"
);
@@alternateType(
  AdminRequestApprovalProperties.collectionIds,
  Azure.Core.uuid[],
  "csharp"
);
@@alternateType(
  Azure.ResourceManager.CommonTypes.Resource.id,
  Azure.Core.armResourceIdentifier,
  "csharp"
);
@@alternateType(PrivateStore.name, Azure.Core.uuid, "csharp");
@@alternateType(Collection.name, Azure.Core.uuid, "csharp");
@@alternateType(
  PrivateStoreCollectionOperationGroup.post::parameters.privateStoreId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  PrivateStoreCollectionOperationGroup.post::parameters.collectionId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  PrivateStoreCollectionOfferOperationGroup.post::parameters.privateStoreId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(
  PrivateStoreCollectionOfferOperationGroup.post::parameters.collectionId,
  Azure.Core.uuid,
  "csharp"
);

// ===== @@clientLocation: Operation grouping (C#) =====
// back-compatible.tsp targets "PrivateStoreCollection" for Collection REST ops,
// which collides with the auto-generated ArmCollection class for PrivateStoreResource
// (also named PrivateStoreCollection). Override to "PrivateStoreCollectionInfo" to
// match the renamed Collection model and avoid the name collision.
// The workaround POST clientLocations are kept for consistency with the renamed groupings.
@@clientLocation(Collections.get, "PrivateStoreCollectionInfo", "csharp");
@@clientLocation(
  Collections.createOrUpdate,
  "PrivateStoreCollectionInfo",
  "csharp"
);
@@clientLocation(Collections.delete, "PrivateStoreCollectionInfo", "csharp");
@@clientLocation(Collections.list, "PrivateStoreCollectionInfo", "csharp");
@@clientLocation(
  Collections.transferOffers,
  "PrivateStoreCollectionInfo",
  "csharp"
);
@@clientLocation(
  Collections.approveAllItems,
  "PrivateStoreCollectionInfo",
  "csharp"
);
@@clientLocation(
  Collections.disableApproveAllItems,
  "PrivateStoreCollectionInfo",
  "csharp"
);

// ===== @@usage: Model usage overrides (C#) =====
// Make OfferProperties (C# name: PrivateStoreOfferResult) input+output so collections are writable.
@@usage(OfferProperties, Usage.input | Usage.output, "csharp");

// ===== Legacy.markAsPageable: Pageable fixes (C#) =====
// These list operations use ArmListSinglePageByParent which returns Response<ListModel>
// instead of Pageable<Resource>. Mark them as pageable to generate correct Pageable<T> return types.
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  AdminRequestApprovalsResources.adminRequestApprovalsList,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  RequestApprovalResources.getApprovalRequestsList,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(Collections.list, "csharp");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  PrivateStores.queryOffers,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  PrivateStores.queryUserOffers,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  PrivateStores.queryUserRules,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  PrivateStores.fetchAllSubscriptionsInTenant,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-client-generator-core/mark-as-pageable-ineffective" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  Collections.listByContexts,
  "csharp"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.markAsPageable(
  Collections.queryRules,
  "csharp"
);

// ===== Legacy.flattenProperty: Property flattening (C#) =====
// QueryRequestApprovalProperties needs flattening so PlanIds/PublisherId/SubscriptionId appear directly.
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Azure.ClientGenerator.Core.Legacy.flattenProperty(
  QueryRequestApprovalProperties.properties,
  "csharp"
);
