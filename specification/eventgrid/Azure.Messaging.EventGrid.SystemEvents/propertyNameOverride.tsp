import "./AzureCommunicationServices.tsp";
import "./EventHub.tsp";
import "./HealthcareApis.tsp";
import "./IotHub.tsp";
import "./ResourceNotifications.tsp";
import "./Storage.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.EventGrid.SystemEvents.AcsIncomingCallEventData.to,
  "toCommunicationIdentifier",
  "autorest"
);
@@clientName(Microsoft.EventGrid.SystemEvents.AcsIncomingCallEventData.from,
  "fromCommunicationIdentifier",
  "autorest"
);

@@clientName(Microsoft.EventGrid.SystemEvents.AcsEmailDeliveryReportReceivedEventData.deliveryAttemptTimeStamp,
  "deliveryAttemptTimestamp",
  "autorest"
);
@@clientName(Microsoft.EventGrid.SystemEvents.AcsEmailEngagementTrackingReportReceivedEventData.userActionTimeStamp,
  "userActionTimestamp",
  "autorest"
);
@@clientName(Microsoft.EventGrid.SystemEvents.AcsEmailEngagementTrackingReportReceivedEventData.engagementType,
  "engagement",
  "autorest"
);

@@clientName(Microsoft.EventGrid.SystemEvents.EventHubCaptureFileCreatedEventData.fileUrl,
  "fileurl",
  "autorest"
);

@@clientName(Microsoft.EventGrid.SystemEvents.HealthcareFhirResourceBaseEventData.resourceFhirAccount,
  "FhirServiceHostName",
  "autorest"
);
@@clientName(Microsoft.EventGrid.SystemEvents.HealthcareFhirResourceBaseEventData.resourceFhirId,
  "FhirResourceId",
  "autorest"
);
@@clientName(Microsoft.EventGrid.SystemEvents.HealthcareFhirResourceBaseEventData.resourceVersionId,
  "FhirResourceVersionId",
  "autorest"
);
@@clientName(Microsoft.EventGrid.SystemEvents.HealthcareFhirResourceBaseEventData.resourceType,
  "FhirResourceType",
  "autorest"
);

@@clientName(Microsoft.EventGrid.SystemEvents.DeviceTwinMetadata.lastUpdated,
  "$lastUpdated",
  "autorest"
);
@@clientName(Microsoft.EventGrid.SystemEvents.DeviceTwinProperties.metadata,
  "$metadata",
  "autorest"
);
@@clientName(Microsoft.EventGrid.SystemEvents.DeviceTwinProperties.version,
  "$version",
  "autorest"
);

@@clientName(Microsoft.EventGrid.SystemEvents.ResourceNotificationsResourceUpdatedEventData.resourceInfo,
  "resourceDetails",
  "autorest"
);
@@clientName(Microsoft.EventGrid.SystemEvents.ResourceNotificationsResourceUpdatedEventData.operationalInfo,
  "operationalDetails",
  "autorest"
);
@@clientName(Microsoft.EventGrid.SystemEvents.ResourceNotificationsResourceDeletedEventData.resourceInfo,
  "resourceDetails",
  "autorest"
);
@@clientName(Microsoft.EventGrid.SystemEvents.ResourceNotificationsResourceDeletedEventData.operationalInfo,
  "operationalDetails",
  "autorest"
);

@@clientName(Microsoft.EventGrid.SystemEvents.StorageTaskAssignmentQueuedEventData.queuedDateTime,
  "queuedOn",
  "autorest"
);
@@clientName(Microsoft.EventGrid.SystemEvents.StorageTaskAssignmentCompletedEventData.completedDateTime,
  "completedOn",
  "autorest"
);
@@clientName(Microsoft.EventGrid.SystemEvents.StorageTaskAssignmentCompletedEventData.summaryReportBlobUrl,
  "summaryReportBlobUri",
  "autorest"
);
