import "@azure-tools/typespec-client-generator-core";
import "./main.tsp";

using Azure.ClientGenerator.Core;
using Microsoft.Marketplace;

@@clientName(Microsoft.Marketplace, "MarketplaceMgmtClient", "python");

// ===== Resource/Model Renames =====
@@clientName(AdminRequestApprovalsResource,
  "MarketplaceAdminApprovalRequest",
  "csharp"
);
@@clientName(AdminRequestApprovalsList,
  "MarketplaceAdminApprovalRequestList",
  "csharp"
);
@@clientName(Collection, "PrivateStoreCollectionInfo", "csharp");
@@clientName(Offer, "PrivateStoreOffer", "csharp");
@@clientName(RequestApprovalResource, "MarketplaceApprovalRequest", "csharp");

// ===== Property Renames =====

// AcknowledgeOfferNotificationDetails property renames
@@clientName(AcknowledgeOfferNotificationDetails.acknowledge,
  "IsAcknowledgeActionFlagEnabled",
  "csharp"
);
@@clientName(AcknowledgeOfferNotificationDetails.dismiss,
  "IsDismissActionFlagEnabled",
  "csharp"
);
@@clientName(AcknowledgeOfferNotificationDetails.removeOffer,
  "IsRemoveOfferActionFlagEnabled",
  "csharp"
);

// Collection property renames
@@clientName(CollectionProperties.allSubscriptions,
  "AreAllSubscriptionsSelected",
  "csharp"
);
@@clientName(CollectionProperties.enabled, "IsEnabled", "csharp");
@@clientName(CollectionProperties.approveAllItems,
  "AreAllItemsApproved",
  "csharp"
);

// StopSellOffersPlansNotificationsListProperties property renames
@@clientName(StopSellOffersPlansNotificationsListProperties.publicContext,
  "HasPublicContext",
  "csharp"
);
@@clientName(StopSellOffersPlansNotificationsListProperties.isEntire,
  "IsEntireInStopSell",
  "csharp"
);

// OfferProperties property renames
@@clientName(OfferProperties.createdAt, "CreatedOn", "csharp");
@@clientName(OfferProperties.modifiedAt, "ModifiedOn", "csharp");
@@clientName(OfferProperties.updateSuppressedDueIdempotence,
  "IsUpdateSuppressedDueToIdempotence",
  "csharp"
);

// Icon → IconUri renames
@@clientName(AdminRequestApprovalProperties.icon, "IconUri", "csharp");
@@clientName(NewNotifications.icon, "IconUri", "csharp");
@@clientName(StopSellNotifications.icon, "IconUri", "csharp");
@@clientName(RequestApprovalsDetails.icon, "IconUri", "csharp");
@@clientName(StopSellOffersPlansNotificationsListProperties.icon,
  "IconUri",
  "csharp"
);

// ===== Type Changes (alternateType) =====

// UUID types
@@alternateType(PrivateStoreProperties.privateStoreId,
  Azure.Core.uuid,
  "csharp"
);
@@alternateType(PrivateStoreProperties.tenantId, Azure.Core.uuid, "csharp");
@@alternateType(CollectionProperties.collectionId, Azure.Core.uuid, "csharp");
@@alternateType(CollectionsDetails.collectionId, Azure.Core.uuid, "csharp");
@@alternateType(Recipient.principalId, Azure.Core.uuid, "csharp");
@@alternateType(OfferProperties.privateStoreId, Azure.Core.uuid, "csharp");

// URI types for icon properties
@@alternateType(AdminRequestApprovalProperties.icon, url, "csharp");
@@alternateType(NewNotifications.icon, url, "csharp");
@@alternateType(StopSellNotifications.icon, url, "csharp");
@@alternateType(RequestApprovalsDetails.icon, url, "csharp");
@@alternateType(StopSellOffersPlansNotificationsListProperties.icon,
  url,
  "csharp"
);

// DateTime types for OfferProperties
@@alternateType(OfferProperties.createdAt, utcDateTime, "csharp");
@@alternateType(OfferProperties.modifiedAt, utcDateTime, "csharp");

// ETag types (string → Azure.ETag in C#)
@@alternateType(PrivateStoreProperties.eTag, Azure.Core.eTag, "csharp");
@@alternateType(OfferProperties.eTag, Azure.Core.eTag, "csharp");
@@alternateType(MultiContextAndPlansProperties.eTag, Azure.Core.eTag, "csharp");
@@alternateType(QueryRequestApproval.etag, Azure.Core.eTag, "csharp");

// CollectionIds types (string[] → Guid[] in C#)
@@alternateType(PrivateStoreProperties.collectionIds, Azure.Core.uuid[], "csharp");
@@alternateType(BulkCollectionsDetails.collectionIds, Azure.Core.uuid[], "csharp");
@@alternateType(AdminRequestApprovalProperties.collectionIds, Azure.Core.uuid[], "csharp");

// ===== Model Renames (naming convention compliance) =====
@@clientName(SubscriptionsResponse, "SubscriptionsResult", "csharp");

// ===== ClientLocation overrides =====
// back-compatible.tsp targets "PrivateStoreCollection" for Collection REST ops,
// which collides with the ARM collection class for PrivateStore resources.
// Override to "PrivateStoreCollectionInfo" to match the renamed Collection model.
@@clientLocation(Collections.get, "PrivateStoreCollectionInfo", "csharp");
@@clientLocation(Collections.createOrUpdate, "PrivateStoreCollectionInfo", "csharp");
@@clientLocation(Collections.delete, "PrivateStoreCollectionInfo", "csharp");
@@clientLocation(Collections.list, "PrivateStoreCollectionInfo", "csharp");
@@clientLocation(Collections.transferOffers, "PrivateStoreCollectionInfo", "csharp");
@@clientLocation(Collections.approveAllItems, "PrivateStoreCollectionInfo", "csharp");
@@clientLocation(Collections.disableApproveAllItems, "PrivateStoreCollectionInfo", "csharp");
@@clientLocation(PrivateStoreCollectionOperationGroup.post, "PrivateStoreCollectionInfo", "csharp");

// ===== Operation Renames =====
@@clientName(PrivateStoreCollectionOperationGroup.post, "Delete", "csharp");
@@clientName(PrivateStoreCollectionOfferOperationGroup.post,
  "Delete",
  "csharp"
);
@@clientName(PrivateStores.fetchAllSubscriptionsInTenant,
  "FetchAllMarketplaceSubscriptions",
  "csharp"
);
@@clientName(RequestApprovalResources.queryRequestApproval,
  "QueryApprovalRequest",
  "csharp"
);
@@clientName(PrivateStores.billingAccounts, "FetchBillingAccounts", "csharp");
@@clientName(PrivateStores.bulkCollectionsAction,
  "PerformActionOnBulkCollections",
  "csharp"
);
@@clientName(PrivateStores.collectionsToSubscriptionsMapping,
  "FetchCollectionsToSubscriptionsMapping",
  "csharp"
);
