import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Reservations;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(AppliedReservations.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(PurchaseRequest.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SplitRequest.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MergeRequest.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Patch.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(SavingsPlanPurchaseRequest.properties);

@@clientLocation(ReservationOrderResponses.get, "ReservationOrder");
@@clientLocation(ReservationOrderResponses.purchase, "ReservationOrder");
@@clientName(ReservationOrderResponses.purchase::parameters.resource, "body");
@@clientLocation(ReservationOrderResponses.list, "ReservationOrder");
@@clientLocation(ReservationOrderResponses.split, "Reservation");
@@clientLocation(ReservationOrderResponses.merge, "Reservation");
@@clientLocation(ReservationOrderResponses.changeDirectory, "ReservationOrder");
@@clientLocation(ReservationOrderResponses.post, "CalculateRefund");
@@clientLocation(ReservationOrderResponses.returnPost, "Return");
@@clientName(ReservationOrderResponses.returnPost, "Post");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ReservationOrderResponse.properties);

@@clientLocation(ReservationResponses.get, "Reservation");
@@clientLocation(ReservationResponses.update, "Reservation");
@@clientName(ReservationResponses.update::parameters.properties, "parameters");
@@clientLocation(ReservationResponses.list, "Reservation");
@@clientLocation(ReservationResponses.availableScopes, "Reservation");
@@clientLocation(ReservationResponses.archive, "Reservation");
@@clientLocation(ReservationResponses.unarchive, "Reservation");
@@clientLocation(ReservationResponses.listRevisions, "Reservation");

@@clientLocation(ReservationOperationGroup.listAll, "Reservation");

@@clientLocation(ReservationOrderOperationGroup.calculate, "ReservationOrder");

@@clientLocation(CalculateExchangeOperationGroup.post, "CalculateExchange");

@@clientLocation(ExchangeOperationGroup.post, "Exchange");
