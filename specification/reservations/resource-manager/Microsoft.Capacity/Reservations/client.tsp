import "./Quota/main.tsp";
import "./Reservations/main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Reservations;

@client({
  name: "ReservationsClient",
  service: [Quota, Reservations],
  autoMergeService: true,
})
namespace ReservationsClient;

@@clientName(ReservationsClient, "ReservationsMgmtClient", "python");
@@clientName(BillingPlan.P1M, "P1_M", "python");
@@clientName(ReservationTerm.P1Y, "P1_Y", "python");
@@clientName(ReservationTerm.P3Y, "P3_Y", "python");
@@clientName(ReservationTerm.P5Y, "P5_Y", "python");
@@clientName(SavingsPlanTerm.P1Y, "P1_Y", "python");
@@clientName(SavingsPlanTerm.P3Y, "P3_Y", "python");

@@clientLocation(getAppliedReservationList, "AzureReservationAPIClient", "go");
@@clientLocation(getCatalog, "AzureReservationAPIClient", "go");

@@clientLocation(Reservations.getAppliedReservationList::parameters.subscriptionId,
  Reservations.getAppliedReservationList
);
@@clientLocation(Reservations.getCatalog::parameters.subscriptionId,
  Reservations.getCatalog
);

@@clientLocation(Quota.QuotaPutBaseParam.subscriptionId,
  Quota.CurrentQuotaLimitBases.createOrUpdate
);
@@clientLocation(Quota.QuotaPatchBaseParam.subscriptionId,
  Quota.CurrentQuotaLimitBases.update
);
@@clientLocation(Quota.QuotaGetBaseParam.subscriptionId,
  Quota.CurrentQuotaLimitBases.get
);
@@clientLocation(Quota.QuotaListBaseParam.subscriptionId,
  Quota.CurrentQuotaLimitBases.list
);
@@clientLocation(Quota.QuotaRequestGetBaseParam.subscriptionId,
  Quota.QuotaRequestStatus.get
);
@@clientLocation(Quota.QuotaRequestListBaseParam.subscriptionId,
  Quota.QuotaRequestStatus.list
);
