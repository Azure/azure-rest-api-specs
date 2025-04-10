import "./main.tsp";
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

@@clientName(PrivateStores.createOrUpdate::parameters.resource, "payload");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PrivateStore.properties);

@@clientName(Collections.createOrUpdate::parameters.resource, "payload");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Collection.properties);

@@clientName(Offers.createOrUpdate::parameters.resource, "payload");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Offer.properties);

@@clientName(RequestApprovalResources.createApprovalRequest::parameters.resource,
  "payload"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(RequestApprovalResource.properties);

@@clientName(AdminRequestApprovalsResources.updateAdminRequestApproval::parameters.resource,
  "payload"
);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AdminRequestApprovalsResource.properties);
