import "./Microsoft.Communication/AzureCommunicationServices.tsp";
import "./Microsoft.EventHub/EventHub.tsp";
import "./Microsoft.HealthcareApis/HealthcareApis.tsp";
import "./Microsoft.Devices/IotHub.tsp";
import "./Microsoft.ResourceNotifications/ResourceNotifications.tsp";
import "./Microsoft.Storage/Storage.tsp";
import "./Microsoft.DataBox/DataBox.tsp";
import "./Microsoft.EventGrid/EventGrid.tsp";

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

@@clientName(Microsoft.EventGrid.SystemEvents.HealthcareFhirResourceCreatedEventData.resourceFhirAccount,
  "FhirServiceHostName",
  "autorest"
);
@@clientName(Microsoft.EventGrid.SystemEvents.HealthcareFhirResourceCreatedEventData.resourceFhirId,
  "FhirResourceId",
  "autorest"
);
@@clientName(Microsoft.EventGrid.SystemEvents.HealthcareFhirResourceCreatedEventData.resourceVersionId,
  "FhirResourceVersionId",
  "autorest"
);
@@clientName(Microsoft.EventGrid.SystemEvents.HealthcareFhirResourceCreatedEventData.resourceType,
  "FhirResourceType",
  "autorest"
);
@@clientName(Microsoft.EventGrid.SystemEvents.HealthcareFhirResourceUpdatedEventData.resourceFhirAccount,
  "FhirServiceHostName",
  "autorest"
);
@@clientName(Microsoft.EventGrid.SystemEvents.HealthcareFhirResourceUpdatedEventData.resourceFhirId,
  "FhirResourceId",
  "autorest"
);
@@clientName(Microsoft.EventGrid.SystemEvents.HealthcareFhirResourceUpdatedEventData.resourceVersionId,
  "FhirResourceVersionId",
  "autorest"
);
@@clientName(Microsoft.EventGrid.SystemEvents.HealthcareFhirResourceUpdatedEventData.resourceType,
  "FhirResourceType",
  "autorest"
);
@@clientName(Microsoft.EventGrid.SystemEvents.HealthcareFhirResourceDeletedEventData.resourceFhirAccount,
  "FhirServiceHostName",
  "autorest"
);
@@clientName(Microsoft.EventGrid.SystemEvents.HealthcareFhirResourceDeletedEventData.resourceFhirId,
  "FhirResourceId",
  "autorest"
);
@@clientName(Microsoft.EventGrid.SystemEvents.HealthcareFhirResourceDeletedEventData.resourceVersionId,
  "FhirResourceVersionId",
  "autorest"
);
@@clientName(Microsoft.EventGrid.SystemEvents.HealthcareFhirResourceDeletedEventData.resourceType,
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
