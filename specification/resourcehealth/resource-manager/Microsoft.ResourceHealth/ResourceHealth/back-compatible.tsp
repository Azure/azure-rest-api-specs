import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ResourceHealth;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ImpactedResourceStatus.properties);

@@clientLocation(MetadataEntities.getEntity, "Metadata");
@@clientLocation(MetadataEntities.list, "Metadata");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(MetadataEntity.properties);

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(EventImpactedResource.properties);

@@clientName(
  EventOperationGroup.fetchDetailsBySubscriptionIdAndTrackingId,
  "fetchDetailsBySubscriptionIdAndTrackingId"
);
@@clientName(
  EventOperationGroup.fetchBilllingCommunicationDetailsBySubscriptionIdAndTrackingId,
  "fetchBilllingCommunicationDetailsBySubscriptionIdAndTrackingId"
);
@@clientName(
  TenantEventOperationGroup.fetchDetailsByTenantIdAndTrackingId,
  "fetchDetailsByTenantIdAndTrackingId"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Event.properties);

@@clientLocation(EmergingIssuesGetResults.get, "EmergingIssues");
@@clientLocation(EmergingIssuesGetResults.list, "EmergingIssues");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(EmergingIssuesGetResult.properties);

@@clientLocation(EventsOperationGroup.listBySingleResource, "Events");

@@clientLocation(ChildResourcesOperationGroup.list, "ChildResources");
@@clientName(AvailabilityStatus, "availabilityStatus");
@@clientName(Events, "events");
@@clientName(EmergingIssuesGetResult, "emergingIssuesGetResult");
@@clientName(Event, "event");
@@clientName(EventImpactedResource, "eventImpactedResource");
@@clientName(AvailabilityStatus, "availabilityStatus");
@@clientName(StatusBanner, "statusBanner");
@@clientName(Microsoft.ResourceHealth.Update, "update");
@@clientName(StatusActiveEvent, "statusActiveEvent");
@@clientName(ServiceImpactingEvent, "serviceImpactingEvent");
@@clientName(RecommendedAction, "recommendedAction");
@@clientName(Operation, "operation");
@@clientName(EmergingIssue, "emergingIssue");
@@clientName(Faq, "faq");
@@clientName(Impact, "impact");
@@clientName(ImpactedRegion, "impactedRegion");
@@clientName(ImpactedServiceRegion, "impactedServiceRegion");
@@clientName(KeyValueItem, "keyValueItem");
@@clientName(Link, "link");
@@clientName(EmergingIssueImpact, "emergingIssueImpact");

// Keep pre-migration Go names for typo'd wire names introduced by conversion.
@@clientName(AvailabilityStatusProperties.occuredTime, "OccurredTime", "go");
@@clientName(
  AvailabilityStatusPropertiesRecentlyResolved.unavailableOccuredTime,
  "UnavailableOccurredTime",
  "go"
);
@@clientName(
  AvailabilityStatusPropertiesRecentlyResolved.unavailableSummary,
  "UnavailabilitySummary",
  "go"
);
@@clientName(
  EventPropertiesRecommendedActionsActionsItem,
  "EventPropertiesRecommendedActionsItem",
  "go,javascript,python"
);
