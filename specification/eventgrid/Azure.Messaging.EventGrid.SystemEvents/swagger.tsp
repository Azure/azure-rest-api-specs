import "./AzureCommunicationServices.tsp";
import "./EventHub.tsp";
import "./HealthcareApis.tsp";
import "./IotHub.tsp";
import "./ResourceNotifications.tsp";
import "./Storage.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

@@clientName(Microsoft.EventGrid.SystemEvents.AcsIncomingCallEventData.to, "toCommunicationIdentifier");
@@clientName(Microsoft.EventGrid.SystemEvents.AcsIncomingCallEventData.from, "fromCommunicationIdentifier");

@@clientName(Microsoft.EventGrid.SystemEvents.AcsEmailDeliveryReportReceivedEventData.deliveryAttemptTimeStamp, "deliveryAttemptTimestamp");
@@clientName(Microsoft.EventGrid.SystemEvents.AcsEmailEngagementTrackingReportReceivedEventData.userActionTimeStamp, "userActionTimestamp");
@@clientName(Microsoft.EventGrid.SystemEvents.AcsEmailEngagementTrackingReportReceivedEventData.engagementType, "engagement");


@@clientName(Microsoft.EventGrid.SystemEvents.EventHubCaptureFileCreatedEventData.fileUrl, "fileurl");


@@clientName(Microsoft.EventGrid.SystemEvents.HealthcareFhirResourceBaseEventData.resourceFhirAccount, "FhirServiceHostName");
@@clientName(Microsoft.EventGrid.SystemEvents.HealthcareFhirResourceBaseEventData.resourceFhirId, "FhirResourceId");
@@clientName(Microsoft.EventGrid.SystemEvents.HealthcareFhirResourceBaseEventData.resourceVersionId, "FhirResourceVersionId");
@@clientName(Microsoft.EventGrid.SystemEvents.HealthcareFhirResourceBaseEventData.resourceType, "FhirResourceType");


@@clientName(Microsoft.EventGrid.SystemEvents.DeviceTwinMetadata.lastUpdated, "$lastUpdated");
@@clientName(Microsoft.EventGrid.SystemEvents.DeviceTwinProperties.metadata, "$metadata");
@@clientName(Microsoft.EventGrid.SystemEvents.DeviceTwinProperties.version, "$version");


@@clientName(Microsoft.EventGrid.SystemEvents.ResourceNotificationsResourceUpdatedEventData.resourceInfo, "resourceDetails");
@@clientName(Microsoft.EventGrid.SystemEvents.ResourceNotificationsResourceUpdatedEventData.operationalInfo, "operationalDetails");
@@clientName(Microsoft.EventGrid.SystemEvents.ResourceNotificationsResourceDeletedEventData.resourceInfo, "resourceDetails");
@@clientName(Microsoft.EventGrid.SystemEvents.ResourceNotificationsResourceDeletedEventData.operationalInfo, "operationalDetails");


@@clientName(Microsoft.EventGrid.SystemEvents.StorageTaskAssignmentQueuedEventData.queuedDateTime, "queuedOn");
@@clientName(Microsoft.EventGrid.SystemEvents.StorageTaskAssignmentCompletedEventData.completedDateTime, "completedOn");
@@clientName(Microsoft.EventGrid.SystemEvents.StorageTaskAssignmentCompletedEventData.summaryReportBlobUrl, "summaryReportBlobUri");
