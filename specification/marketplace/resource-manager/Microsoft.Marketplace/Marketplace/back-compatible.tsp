import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Marketplace;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateStoreProperties.notificationsSettings);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(QueryUserOffersProperties.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(QueryUserRulesProperties.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(TransferOffersProperties.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(QueryApprovedPlansPayload.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(BulkCollectionsPayload.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CollectionOffersByAllContextsPayload.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CollectionOffersByContext.offers);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MultiContextAndPlansPayload.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AcknowledgeOfferNotificationProperties.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(WithdrawProperties.properties);

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
@@clientLocation(PrivateStores.queryUserRules, "");
@@clientName(PrivateStores.queryUserRules::parameters.body, "payload");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateStore.properties);

@@clientLocation(Collections.get, "PrivateStoreCollection");
@@clientLocation(Collections.createOrUpdate, "PrivateStoreCollection");
@@clientName(Collections.createOrUpdate::parameters.resource, "payload");
@@clientLocation(Collections.delete, "PrivateStoreCollection");
@@clientLocation(Collections.list, "PrivateStoreCollection");
@@clientLocation(Collections.setCollectionRules, "");
@@clientName(Collections.setCollectionRules::parameters.body, "payload");
@@clientLocation(Collections.queryRules, "");
@@clientLocation(Collections.transferOffers, "PrivateStoreCollection");
@@clientName(Collections.transferOffers::parameters.body, "payload");
@@clientLocation(Collections.approveAllItems, "PrivateStoreCollection");
@@clientLocation(Collections.disableApproveAllItems, "PrivateStoreCollection");
@@clientLocation(Collections.listByContexts, "PrivateStoreCollectionOffer");
@@clientName(Collections.listByContexts::parameters.body, "payload");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Collection.properties);

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
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Offer.properties);

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
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RequestApprovalResource.properties);

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
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AdminRequestApprovalsResource.properties);

@@clientLocation(PrivateStoreCollectionOperationGroup.post,
  "PrivateStoreCollection"
);

@@clientLocation(PrivateStoreCollectionOfferOperationGroup.post,
  "PrivateStoreCollectionOffer"
);
