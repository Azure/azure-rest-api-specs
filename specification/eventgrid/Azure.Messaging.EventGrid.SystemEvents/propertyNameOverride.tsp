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

@@clientName(Microsoft.EventGrid.SystemEvents.AcsMessageDeliveryStatusUpdatedEventData.channelType,
  "channelKind",
  "autorest"
);

@@clientName(Microsoft.EventGrid.SystemEvents.AcsMessageReceivedEventData.channelType,
  "channelKind",
  "autorest"
);

@@clientName(Microsoft.EventGrid.SystemEvents.AcsMessageReceivedEventData.media,
  "mediaContent",
  "autorest"
);

@@clientName(Microsoft.EventGrid.SystemEvents.AcsMessageReceivedEventData.interactive,
  "interactiveContent",
  "autorest"
);

@@clientName(Microsoft.EventGrid.SystemEvents.AcsMessageMediaContent.id,
  "mediaId",
  "autorest"
);

@@clientName(Microsoft.EventGrid.SystemEvents.AcsMessageContext.id,
  "messageId",
  "autorest"
);

@@clientName(Microsoft.EventGrid.SystemEvents.AcsMessageInteractiveContent.type,
  "replyKind",
  "autorest"
);

@@clientName(Microsoft.EventGrid.SystemEvents.AcsMessageInteractiveButtonReplyContent.id,
  "buttonId",
  "autorest"
);

@@clientName(Microsoft.EventGrid.SystemEvents.AcsMessageInteractiveListReplyContent.id,
  "listItemId",
  "autorest"
);



@@clientName(Microsoft.EventGrid.SystemEvents.AcsIncomingCallEventData.to,
  "toCommunicationIdentifier",
  "csharp"
);
@@clientName(Microsoft.EventGrid.SystemEvents.AcsIncomingCallEventData.from,
  "fromCommunicationIdentifier",
  "csharp"
);

@@clientName(Microsoft.EventGrid.SystemEvents.AcsEmailDeliveryReportReceivedEventData.deliveryAttemptTimeStamp,
  "deliveryAttemptTimestamp",
  "csharp"
);
@@clientName(Microsoft.EventGrid.SystemEvents.AcsEmailEngagementTrackingReportReceivedEventData.userActionTimeStamp,
  "userActionTimestamp",
  "csharp"
);
@@clientName(Microsoft.EventGrid.SystemEvents.AcsEmailEngagementTrackingReportReceivedEventData.engagementType,
  "engagement",
  "csharp"
);

@@clientName(Microsoft.EventGrid.SystemEvents.EventHubCaptureFileCreatedEventData.fileUrl,
  "fileurl",
  "csharp"
);

@@clientName(Microsoft.EventGrid.SystemEvents.HealthcareFhirResourceCreatedEventData.resourceFhirAccount,
  "FhirServiceHostName",
  "csharp"
);
@@clientName(Microsoft.EventGrid.SystemEvents.HealthcareFhirResourceCreatedEventData.resourceFhirId,
  "FhirResourceId",
  "csharp"
);
@@clientName(Microsoft.EventGrid.SystemEvents.HealthcareFhirResourceCreatedEventData.resourceVersionId,
  "FhirResourceVersionId",
  "csharp"
);
@@clientName(Microsoft.EventGrid.SystemEvents.HealthcareFhirResourceCreatedEventData.resourceType,
  "FhirResourceType",
  "csharp"
);
@@clientName(Microsoft.EventGrid.SystemEvents.HealthcareFhirResourceUpdatedEventData.resourceFhirAccount,
  "FhirServiceHostName",
  "csharp"
);
@@clientName(Microsoft.EventGrid.SystemEvents.HealthcareFhirResourceUpdatedEventData.resourceFhirId,
  "FhirResourceId",
  "csharp"
);
@@clientName(Microsoft.EventGrid.SystemEvents.HealthcareFhirResourceUpdatedEventData.resourceVersionId,
  "FhirResourceVersionId",
  "csharp"
);
@@clientName(Microsoft.EventGrid.SystemEvents.HealthcareFhirResourceUpdatedEventData.resourceType,
  "FhirResourceType",
  "csharp"
);
@@clientName(Microsoft.EventGrid.SystemEvents.HealthcareFhirResourceDeletedEventData.resourceFhirAccount,
  "FhirServiceHostName",
  "csharp"
);
@@clientName(Microsoft.EventGrid.SystemEvents.HealthcareFhirResourceDeletedEventData.resourceFhirId,
  "FhirResourceId",
  "csharp"
);
@@clientName(Microsoft.EventGrid.SystemEvents.HealthcareFhirResourceDeletedEventData.resourceVersionId,
  "FhirResourceVersionId",
  "csharp"
);
@@clientName(Microsoft.EventGrid.SystemEvents.HealthcareFhirResourceDeletedEventData.resourceType,
  "FhirResourceType",
  "csharp"
);

@@clientName(Microsoft.EventGrid.SystemEvents.DeviceTwinMetadata.lastUpdated,
  "$lastUpdated",
  "csharp"
);
@@clientName(Microsoft.EventGrid.SystemEvents.DeviceTwinProperties.metadata,
  "$metadata",
  "csharp"
);
@@clientName(Microsoft.EventGrid.SystemEvents.DeviceTwinProperties.version,
  "$version",
  "csharp"
);

@@clientName(Microsoft.EventGrid.SystemEvents.ResourceNotificationsResourceUpdatedEventData.resourceInfo,
  "resourceDetails",
  "csharp"
);
@@clientName(Microsoft.EventGrid.SystemEvents.ResourceNotificationsResourceUpdatedEventData.operationalInfo,
  "operationalDetails",
  "csharp"
);
@@clientName(Microsoft.EventGrid.SystemEvents.ResourceNotificationsResourceDeletedEventData.resourceInfo,
  "resourceDetails",
  "csharp"
);
@@clientName(Microsoft.EventGrid.SystemEvents.ResourceNotificationsResourceDeletedEventData.operationalInfo,
  "operationalDetails",
  "csharp"
);

@@clientName(Microsoft.EventGrid.SystemEvents.StorageTaskAssignmentQueuedEventData.queuedDateTime,
  "queuedOn",
  "csharp"
);
@@clientName(Microsoft.EventGrid.SystemEvents.StorageTaskAssignmentCompletedEventData.completedDateTime,
  "completedOn",
  "csharp"
);
@@clientName(Microsoft.EventGrid.SystemEvents.StorageTaskAssignmentCompletedEventData.summaryReportBlobUrl,
  "summaryReportBlobUri",
  "csharp"
);

@@clientName(Microsoft.EventGrid.SystemEvents.AcsMessageDeliveryStatusUpdatedEventData.channelType,
  "channelKind",
  "csharp"
);

@@clientName(Microsoft.EventGrid.SystemEvents.AcsMessageReceivedEventData.channelType,
  "channelKind",
  "csharp"
);

@@clientName(Microsoft.EventGrid.SystemEvents.AcsMessageReceivedEventData.media,
  "mediaContent",
  "csharp"
);

@@clientName(Microsoft.EventGrid.SystemEvents.AcsMessageReceivedEventData.interactive,
  "interactiveContent",
  "csharp"
);

@@clientName(Microsoft.EventGrid.SystemEvents.AcsMessageMediaContent.id,
  "mediaId",
  "csharp"
);

@@clientName(Microsoft.EventGrid.SystemEvents.AcsMessageContext.id,
  "messageId",
  "csharp"
);

@@clientName(Microsoft.EventGrid.SystemEvents.AcsMessageInteractiveContent.type,
  "replyKind",
  "csharp"
);

@@clientName(Microsoft.EventGrid.SystemEvents.AcsMessageInteractiveButtonReplyContent.id,
  "buttonId",
  "csharp"
);

@@clientName(Microsoft.EventGrid.SystemEvents.AcsMessageInteractiveListReplyContent.id,
  "listItemId",
  "csharp"
);
