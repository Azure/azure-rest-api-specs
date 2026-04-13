import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.ResourceHealth;

@@clientName(RecommendedAction.`_ActionUrl.Comment`, "ActionUrlComment");

#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(ImpactedResourceStatus.properties);

@@clientLocation(MetadataEntities.getEntity, "Metadata");
@@clientLocation(MetadataEntities.list, "Metadata");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(MetadataEntity.properties);

@@clientLocation(EventImpactedResources.get, ImpactedResources);
@@clientLocation(EventImpactedResources.listBySubscriptionIdAndEventId,
  ImpactedResources
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(EventImpactedResource.properties);

@@clientLocation(EventOperationGroup.getBySubscriptionIdAndTrackingId, "Event");
@@clientLocation(EventOperationGroup.listBySubscriptionId, "Events");
@@clientLocation(EventOperationGroup.listBySubscriptionIdAndEventId,
  "SecurityAdvisoryImpactedResources"
);
@@clientLocation(EventOperationGroup.fetchDetailsBySubscriptionIdAndTrackingId,
  "Event"
);
@@clientName(EventOperationGroup.fetchDetailsBySubscriptionIdAndTrackingId,
  "fetchDetailsBySubscriptionIdAndTrackingId"
);
@@clientLocation(EventOperationGroup.fetchBilllingCommunicationDetailsBySubscriptionIdAndTrackingId,
  "Event"
);
@@clientName(EventOperationGroup.fetchBilllingCommunicationDetailsBySubscriptionIdAndTrackingId,
  "fetchBilllingCommunicationDetailsBySubscriptionIdAndTrackingId"
);
@@clientLocation(EventOperationGroup.getByTenantIdAndTrackingId, "Event");
@@clientLocation(EventOperationGroup.listByTenantId, "Events");
@@clientLocation(EventOperationGroup.listByTenantIdAndEventId,
  "SecurityAdvisoryImpactedResources"
);
@@clientLocation(EventOperationGroup.fetchDetailsByTenantIdAndTrackingId,
  "Event"
);
@@clientName(EventOperationGroup.fetchDetailsByTenantIdAndTrackingId,
  "fetchDetailsByTenantIdAndTrackingId"
);
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(Event.properties);

@@clientLocation(EmergingIssuesGetResults.get, "EmergingIssues");
@@clientLocation(EmergingIssuesGetResults.list, "EmergingIssues");
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "Property flatten for SDK backward compatibility."
@@Legacy.flattenProperty(EmergingIssuesGetResult.properties);

@@clientLocation(EventsOperationGroup.listBySingleResource, "Events");

@@clientLocation(ChildResourcesOperationGroup.list, "ChildResources");
