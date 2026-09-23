import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ResourceHealth;

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(ImpactedResourceStatus.properties);

@@clientLocation(MetadataEntities.getEntity, MetadataClientGroup);
@@clientLocation(MetadataEntities.list, MetadataClientGroup);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(MetadataEntity.properties);

@@clientLocation(EventImpactedResources.get, ImpactedResources);
@@clientLocation(
  EventImpactedResources.listBySubscriptionIdAndEventId,
  ImpactedResources
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(EventImpactedResource.properties);

@@clientLocation(
  EventOperationGroup.getBySubscriptionIdAndTrackingId,
  EventClientGroup
);
@@clientLocation(EventOperationGroup.listBySubscriptionId, EventsClientGroup);
@@clientLocation(
  EventOperationGroup.listBySubscriptionIdAndEventId,
  SecurityAdvisoryImpactedResourcesClientGroup
);
@@clientLocation(
  EventOperationGroup.fetchDetailsBySubscriptionIdAndTrackingId,
  EventClientGroup
);
@@clientName(
  EventOperationGroup.fetchDetailsBySubscriptionIdAndTrackingId,
  "fetchDetailsBySubscriptionIdAndTrackingId"
);
@@clientLocation(
  EventOperationGroup.fetchBilllingCommunicationDetailsBySubscriptionIdAndTrackingId,
  EventClientGroup
);
@@clientName(
  EventOperationGroup.fetchBilllingCommunicationDetailsBySubscriptionIdAndTrackingId,
  "fetchBilllingCommunicationDetailsBySubscriptionIdAndTrackingId"
);
@@clientLocation(
  TenantEventOperationGroup.getByTenantIdAndTrackingId,
  EventClientGroup
);
@@clientLocation(TenantEventOperationGroup.listByTenantId, EventsClientGroup);
@@clientLocation(
  TenantEventOperationGroup.listByTenantIdAndEventId,
  SecurityAdvisoryImpactedResourcesClientGroup
);
@@clientLocation(
  TenantEventOperationGroup.fetchDetailsByTenantIdAndTrackingId,
  EventClientGroup
);
@@clientName(
  TenantEventOperationGroup.fetchDetailsByTenantIdAndTrackingId,
  "fetchDetailsByTenantIdAndTrackingId"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(Event.properties);

@@clientLocation(EmergingIssuesGetResults.get, EmergingIssuesClientGroup);
@@clientLocation(EmergingIssuesGetResults.list, EmergingIssuesClientGroup);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@@Legacy.flattenProperty(EmergingIssuesGetResult.properties);

@@clientLocation(EventsOperationGroup.listBySingleResource, EventsClientGroup);

@@clientLocation(ChildResourcesOperationGroup.list, ChildResourcesClientGroup);
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
