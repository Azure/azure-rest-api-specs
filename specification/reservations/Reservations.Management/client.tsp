import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.Capacity;

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(AppliedReservations.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(PurchaseRequest.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SplitRequest.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(MergeRequest.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(Patch.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(SavingsPlanPurchaseRequest.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(QuotaRequestSubmitResponse201.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CurrentQuotaLimit.quotaInformation);
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(CurrentQuotaLimit.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(QuotaRequestOneResourceSubmitResponse.properties);

#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(QuotaRequestOneResourceProperties.properties);

@@clientName(ReservationOrderResponses.purchase::parameters.resource, "body");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(ReservationOrderResponse.properties);

@@clientName(ReservationResponses.update::parameters.properties, "parameters");

@@clientName(CurrentQuotaLimitBases.createOrUpdate::parameters.resource,
  "createQuotaRequest"
);
@@clientName(CurrentQuotaLimitBases.update::parameters.properties,
  "createQuotaRequest"
);

@@clientName(QuotaRequestDetailsOperationGroup, "QuotaRequestDetails");
#suppress "deprecated" "@flattenProperty decorator is not recommended to use."
@@flattenProperty(QuotaRequestDetails.properties);
