import "./Microsoft.Communication/AzureCommunicationServices.tsp";
import "./Microsoft.EventHub/EventHub.tsp";
import "./Microsoft.HealthcareApis/HealthcareApis.tsp";
import "./Microsoft.Devices/IotHub.tsp";
import "./Microsoft.ResourceNotifications/ResourceNotifications.tsp";
import "./Microsoft.Storage/Storage.tsp";
import "./Microsoft.DataBox/DataBox.tsp";
import "./Microsoft.EventGrid/EventGrid.tsp";
import "./Microsoft.Media/MediaServices.tsp";
import "./Microsoft.AVS/AVS.tsp";

import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.EventGrid.SystemEvents;
using Microsoft.EventGrid.SystemEvents.AzureCommunicationServices;
using Microsoft.EventGrid.SystemEvents.EventHub;
using Microsoft.EventGrid.SystemEvents.HealthcareApis;
using Microsoft.EventGrid.SystemEvents.IotHub;
using Microsoft.EventGrid.SystemEvents.ResourceNotifications;
using Microsoft.EventGrid.SystemEvents.Storage;
using Microsoft.EventGrid.SystemEvents.DataBox;
using Microsoft.EventGrid.SystemEvents.EventGrid;
using Microsoft.EventGrid.SystemEvents.MediaServices;
using Microsoft.EventGrid.SystemEvents.AVS;

@@clientName(AcsIncomingCallEventData.to,
  "toCommunicationIdentifier",
  "csharp"
);
@@clientName(AcsIncomingCallEventData.from,
  "fromCommunicationIdentifier",
  "csharp"
);

@@clientName(AcsEmailDeliveryReportReceivedEventData.deliveryAttemptTimeStamp,
  "deliveryAttemptTimestamp",
  "csharp"
);
@@clientName(AcsEmailEngagementTrackingReportReceivedEventData.userActionTimeStamp,
  "userActionTimestamp",
  "csharp"
);
@@clientName(AcsEmailEngagementTrackingReportReceivedEventData.engagementType,
  "engagement",
  "csharp"
);

@@clientName(EventHubCaptureFileCreatedEventData.fileUrl, "fileurl", "csharp");

@@clientName(HealthcareFhirResourceCreatedEventData.resourceFhirAccount,
  "FhirServiceHostName",
  "csharp"
);
@@clientName(HealthcareFhirResourceCreatedEventData.resourceFhirId,
  "FhirResourceId",
  "csharp"
);
@@clientName(HealthcareFhirResourceCreatedEventData.resourceVersionId,
  "FhirResourceVersionId",
  "csharp"
);
@@clientName(HealthcareFhirResourceCreatedEventData.resourceType,
  "FhirResourceType",
  "csharp"
);
@@clientName(HealthcareFhirResourceUpdatedEventData.resourceFhirAccount,
  "FhirServiceHostName",
  "csharp"
);
@@clientName(HealthcareFhirResourceUpdatedEventData.resourceFhirId,
  "FhirResourceId",
  "csharp"
);
@@clientName(HealthcareFhirResourceUpdatedEventData.resourceVersionId,
  "FhirResourceVersionId",
  "csharp"
);
@@clientName(HealthcareFhirResourceUpdatedEventData.resourceType,
  "FhirResourceType",
  "csharp"
);
@@clientName(HealthcareFhirResourceDeletedEventData.resourceFhirAccount,
  "FhirServiceHostName",
  "csharp"
);
@@clientName(HealthcareFhirResourceDeletedEventData.resourceFhirId,
  "FhirResourceId",
  "csharp"
);
@@clientName(HealthcareFhirResourceDeletedEventData.resourceVersionId,
  "FhirResourceVersionId",
  "csharp"
);
@@clientName(HealthcareFhirResourceDeletedEventData.resourceType,
  "FhirResourceType",
  "csharp"
);

@@clientName(DeviceTwinMetadata.lastUpdated, "$lastUpdated", "csharp");
@@clientName(DeviceTwinProperties.metadata, "$metadata", "csharp");
@@clientName(DeviceTwinProperties.version, "$version", "csharp");

@@clientName(ResourceNotificationsResourceUpdatedEventData.resourceInfo,
  "resourceDetails",
  "csharp"
);
@@clientName(ResourceNotificationsResourceUpdatedEventData.operationalInfo,
  "operationalDetails",
  "csharp"
);
@@clientName(ResourceNotificationsResourceDeletedEventData.resourceInfo,
  "resourceDetails",
  "csharp"
);
@@clientName(ResourceNotificationsResourceDeletedEventData.operationalInfo,
  "operationalDetails",
  "csharp"
);

@@clientName(StorageTaskAssignmentQueuedEventData.queuedDateTime,
  "queuedOn",
  "csharp"
);
@@clientName(StorageTaskAssignmentCompletedEventData.completedDateTime,
  "completedOn",
  "csharp"
);
@@clientName(StorageTaskAssignmentCompletedEventData.summaryReportBlobUrl,
  "summaryReportBlobUri",
  "csharp"
);

@@clientName(AcsMessageDeliveryStatusUpdatedEventData.channelType,
  "channelKind",
  "csharp"
);

@@clientName(AcsMessageReceivedEventData.channelType, "channelKind", "csharp");

@@clientName(AcsMessageReceivedEventData.media, "mediaContent", "csharp");

@@clientName(AcsMessageReceivedEventData.interactive,
  "interactiveContent",
  "csharp"
);

@@clientName(AcsMessageMediaContent.id, "mediaId", "csharp");

@@clientName(AcsMessageContext.id, "messageId", "csharp");

@@clientName(AcsMessageInteractiveContent.type, "replyKind", "csharp");

@@clientName(AcsMessageInteractiveButtonReplyContent.id, "buttonId", "csharp");

@@clientName(AcsMessageInteractiveListReplyContent.id, "listItemId", "csharp");

@@clientName(ResourceNotificationsHealthResourcesAnnotatedEventData.resourceInfo,
  "ResourceDetails",
  "csharp"
);
@@clientName(ResourceNotificationsHealthResourcesAnnotatedEventData.operationalInfo,
  "OperationalDetails",
  "csharp"
);

@@clientName(ResourceNotificationsHealthResourcesAvailabilityStatusChangedEventData.resourceInfo,
  "ResourceDetails",
  "csharp"
);
@@clientName(ResourceNotificationsHealthResourcesAvailabilityStatusChangedEventData.operationalInfo,
  "OperationalDetails",
  "csharp"
);

@@clientName(ResourceNotificationsResourceManagementCreatedOrUpdatedEventData.resourceInfo,
  "ResourceDetails",
  "csharp"
);
@@clientName(ResourceNotificationsResourceManagementCreatedOrUpdatedEventData.operationalInfo,
  "OperationalDetails",
  "csharp"
);
@@clientName(ResourceNotificationsResourceManagementDeletedEventData.resourceInfo,
  "ResourceDetails",
  "csharp"
);

@@clientName(ResourceNotificationsResourceManagementDeletedEventData.operationalInfo,
  "OperationalDetails",
  "csharp"
);

@@clientName(AcsMessageDeliveryStatusUpdatedEventData.receivedTimeStamp,
  "receivedTimestamp",
  "csharp"
);

@@clientName(AcsMessageEventData.receivedTimeStamp,
  "receivedTimestamp",
  "csharp"
);

@@clientName(AcsMessageReceivedEventData.receivedTimeStamp,
  "receivedTimestamp",
  "csharp"
);

@@clientName(AcsRecordingFileStatusUpdatedEventData.recordingChannelType,
  "recordingChannelKind",
  "csharp"
);

@@clientName(AcsRouterWorkerSelector.state, "SelectorState", "csharp");
@@clientName(AcsRouterWorkerSelector.ttlSeconds, "TimeToLive", "csharp");
@@clientName(AcsRouterWorkerSelector.value, "labelValue", "csharp");
