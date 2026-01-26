import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Marketplace;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PrivateStoreProperties.notificationsSettings);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(QueryUserOffersProperties.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(QueryUserRulesProperties.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(TransferOffersProperties.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(QueryApprovedPlansPayload.properties);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(BulkCollectionsPayload.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CollectionOffersByAllContextsPayload.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(CollectionOffersByContext.offers);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(MultiContextAndPlansPayload.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AcknowledgeOfferNotificationProperties.properties);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(WithdrawProperties.properties);

@@clientLocation(PrivateStores.get, "PrivateStore");
@@clientLocation(PrivateStores.createOrUpdate, "PrivateStore");
@@clientName(PrivateStores.createOrUpdate::parameters.resource, "payload");
@@clientLocation(PrivateStores.delete, "PrivateStore");
@@clientLocation(PrivateStores.list, "PrivateStore");
@@clientLocation(PrivateStores.anyExistingOffersInTheCollections,
  "PrivateStore"
);
@@clientLocation(PrivateStores.queryOffers, "PrivateStore");
@@clientLocation(PrivateStores.queryUserOffers, "PrivateStore");
@@clientName(PrivateStores.queryUserOffers::parameters.body, "payload");
@@clientLocation(PrivateStores.billingAccounts, "PrivateStore");
@@clientLocation(PrivateStores.collectionsToSubscriptionsMapping,
  "PrivateStore"
);
@@clientName(PrivateStores.collectionsToSubscriptionsMapping::parameters.body,
  "payload"
);
@@clientLocation(PrivateStores.queryApprovedPlans, "PrivateStore");
@@clientName(PrivateStores.queryApprovedPlans::parameters.body, "payload");
@@clientLocation(PrivateStores.bulkCollectionsAction, "PrivateStore");
@@clientName(PrivateStores.bulkCollectionsAction::parameters.body, "payload");
@@clientLocation(PrivateStores.queryNotificationsState, "PrivateStore");
@@clientLocation(PrivateStores.acknowledgeOfferNotification, "PrivateStore");
@@clientName(PrivateStores.acknowledgeOfferNotification::parameters.body,
  "payload"
);
@@clientLocation(PrivateStores.fetchAllSubscriptionsInTenant, "PrivateStore");
@@clientLocation(PrivateStores.listNewPlansNotifications, "PrivateStore");
@@clientLocation(PrivateStores.listStopSellOffersPlansNotifications,
  "PrivateStore"
);
@@clientName(PrivateStores.listStopSellOffersPlansNotifications::parameters.body,
  "stopSellSubscriptions"
);
@@clientLocation(PrivateStores.listSubscriptionsContext, "PrivateStore");
@@clientLocation(PrivateStores.queryUserRules, Microsoft.Marketplace);
@@clientLocation(PrivateStores.queryUserRules, "MarketplaceRPService", "go");
@@clientName(PrivateStores.queryUserRules::parameters.body, "payload");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(PrivateStore.properties);

@@clientLocation(Collections.get, "PrivateStoreCollection");
@@clientLocation(Collections.createOrUpdate, "PrivateStoreCollection");
@@clientName(Collections.createOrUpdate::parameters.resource, "payload");
@@clientLocation(Collections.delete, "PrivateStoreCollection");
@@clientLocation(Collections.list, "PrivateStoreCollection");
@@clientLocation(Collections.setCollectionRules, Microsoft.Marketplace);
@@clientLocation(Collections.setCollectionRules, "MarketplaceRPService", "go");
@@clientName(Collections.setCollectionRules::parameters.body, "payload");
@@clientLocation(Collections.queryRules, Microsoft.Marketplace);
@@clientLocation(Collections.queryRules, "MarketplaceRPService", "go");
@@clientLocation(Collections.transferOffers, "PrivateStoreCollection");
@@clientName(Collections.transferOffers::parameters.body, "payload");
@@clientLocation(Collections.approveAllItems, "PrivateStoreCollection");
@@clientLocation(Collections.disableApproveAllItems, "PrivateStoreCollection");
@@clientLocation(Collections.listByContexts, "PrivateStoreCollectionOffer");
@@clientName(Collections.listByContexts::parameters.body, "payload");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Collection.properties);

@@clientLocation(Offers.get, "PrivateStoreCollectionOffer");
@@clientLocation(Offers.createOrUpdate, "PrivateStoreCollectionOffer");
@@clientName(Offers.createOrUpdate::parameters.resource, "payload");
@@clientLocation(Offers.delete, "PrivateStoreCollectionOffer");
@@clientLocation(Offers.list, "PrivateStoreCollectionOffer");
@@clientLocation(Offers.contextsView, "PrivateStoreCollectionOffer");
@@clientName(Offers.contextsView::parameters.body, "payload");
@@clientLocation(Offers.upsertOfferWithMultiContext,
  "PrivateStoreCollectionOffer"
);
@@clientName(Offers.upsertOfferWithMultiContext::parameters.body, "payload");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Offer.properties);

@@clientLocation(RequestApprovalResources.getRequestApproval, "PrivateStore");
@@clientLocation(RequestApprovalResources.createApprovalRequest,
  "PrivateStore"
);
@@clientName(RequestApprovalResources.createApprovalRequest::parameters.resource,
  "payload"
);
@@clientLocation(RequestApprovalResources.getApprovalRequestsList,
  "PrivateStore"
);
@@clientLocation(RequestApprovalResources.queryRequestApproval, "PrivateStore");
@@clientName(RequestApprovalResources.queryRequestApproval::parameters.body,
  "payload"
);
@@clientLocation(RequestApprovalResources.withdrawPlan, "PrivateStore");
@@clientName(RequestApprovalResources.withdrawPlan::parameters.body, "payload");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(RequestApprovalResource.properties);

@@clientLocation(AdminRequestApprovalsResources.getAdminRequestApproval,
  "PrivateStore"
);
@@clientLocation(AdminRequestApprovalsResources.updateAdminRequestApproval,
  "PrivateStore"
);
@@clientName(AdminRequestApprovalsResources.updateAdminRequestApproval::parameters.resource,
  "payload"
);
@@clientLocation(AdminRequestApprovalsResources.adminRequestApprovalsList,
  "PrivateStore"
);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(AdminRequestApprovalsResource.properties);

@@clientLocation(PrivateStoreCollectionOperationGroup.post,
  "PrivateStoreCollection"
);

@@clientLocation(PrivateStoreCollectionOfferOperationGroup.post,
  "PrivateStoreCollectionOffer"
);
@@clientName(CollectionsSubscriptionsMappingDetails,
  "collectionsSubscriptionsMappingDetails"
);
@@clientName(PlanDetails, "planDetails");
