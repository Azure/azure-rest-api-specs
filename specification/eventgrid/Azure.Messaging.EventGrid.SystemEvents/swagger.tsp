import "./AzureCommunicationServices.tsp";
import "./EventHub.tsp";
import "./HealthcareApis.tsp";
import "./IotHub.tsp";
import "./ResourceNotifications.tsp";
import "./Storage.tsp";
import "@azure-tools/typespec-client-generator-core";

@@projectedName(Microsoft.EventGrid.SystemEvents.AcsIncomingCallEventData.to, "client", "toCommunicationIdentifier");
@@projectedName(Microsoft.EventGrid.SystemEvents.AcsIncomingCallEventData.from, "client", "fromCommunicationIdentifier");

@@projectedName(Microsoft.EventGrid.SystemEvents.AcsEmailDeliveryReportReceivedEventData.deliveryAttemptTimeStamp, "client", "deliveryAttemptTimestamp");
@@projectedName(Microsoft.EventGrid.SystemEvents.AcsEmailEngagementTrackingReportReceivedEventData.userActionTimeStamp, "client", "userActionTimestamp");
@@projectedName(Microsoft.EventGrid.SystemEvents.AcsEmailEngagementTrackingReportReceivedEventData.engagementType, "client", "engagement");


@@projectedName(Microsoft.EventGrid.SystemEvents.EventHubCaptureFileCreatedEventData.fileUrl, "client", "fileurl");


@@projectedName(Microsoft.EventGrid.SystemEvents.HealthcareFhirResourceBaseEventData.resourceFhirAccount, "client", "FhirServiceHostName");
@@projectedName(Microsoft.EventGrid.SystemEvents.HealthcareFhirResourceBaseEventData.resourceFhirId, "client", "FhirResourceId");
@@projectedName(Microsoft.EventGrid.SystemEvents.HealthcareFhirResourceBaseEventData.resourceVersionId, "client", "FhirResourceVersionId");
@@projectedName(Microsoft.EventGrid.SystemEvents.HealthcareFhirResourceBaseEventData.resourceType, "client", "FhirResourceType");


@@projectedName(Microsoft.EventGrid.SystemEvents.DeviceTwinMetadata.lastUpdated, "client", "$lastUpdated");
@@projectedName(Microsoft.EventGrid.SystemEvents.DeviceTwinProperties.metadata, "client", "$metadata");
@@projectedName(Microsoft.EventGrid.SystemEvents.DeviceTwinProperties.version, "client", "$version");


@@projectedName(Microsoft.EventGrid.SystemEvents.ResourceNotificationsResourceUpdatedEventData.resourceInfo, "client", "resourceDetails");
@@projectedName(Microsoft.EventGrid.SystemEvents.ResourceNotificationsResourceUpdatedEventData.operationalInfo, "client", "operationalDetails");
@@projectedName(Microsoft.EventGrid.SystemEvents.ResourceNotificationsResourceDeletedEventData.resourceInfo, "client", "resourceDetails");
@@projectedName(Microsoft.EventGrid.SystemEvents.ResourceNotificationsResourceDeletedEventData.operationalInfo, "client", "operationalDetails");


@@projectedName(Microsoft.EventGrid.SystemEvents.StorageTaskAssignmentQueuedEventData.queuedDateTime, "client", "queuedOn");
@@projectedName(Microsoft.EventGrid.SystemEvents.StorageTaskAssignmentCompletedEventData.completedDateTime, "client", "completedOn");
@@projectedName(Microsoft.EventGrid.SystemEvents.StorageTaskAssignmentCompletedEventData.summaryReportBlobUrl, "client", "summaryReportBlobUri");
