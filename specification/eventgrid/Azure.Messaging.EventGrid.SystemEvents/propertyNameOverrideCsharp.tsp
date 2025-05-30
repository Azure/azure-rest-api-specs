import "./Microsoft.Communication/AzureCommunicationServices.tsp";
import "./Microsoft.EventHub/EventHub.tsp";
import "./Microsoft.HealthcareApis/HealthcareApis.tsp";
import "./Microsoft.Devices/IotHub.tsp";
import "./Microsoft.ResourceNotifications/HealthResources.tsp";
import "./Microsoft.ResourceNotifications/Resources.tsp";
import "./Microsoft.Storage/Storage.tsp";
import "./Microsoft.DataBox/DataBox.tsp";
import "./Microsoft.EventGrid/EventGrid.tsp";
import "./Microsoft.AVS/AVS.tsp";

import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.EventGrid.SystemEvents;

@@clientName(AcsIncomingCallEventData.to,
  "toCommunicationIdentifier",
  "csharp"
);
@@clientName(AcsIncomingCallEventData.from,
  "fromCommunicationIdentifier",
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
  "channelType",
  "csharp"
);

@@clientName(AcsRecordingFileStatusUpdatedEventData.recordingContentType,
  "contentType",
  "csharp"
);

@@clientName(AcsRecordingFileStatusUpdatedEventData.recordingFormatType,
  "formatType",
  "csharp"
);

@@clientName(EventGridMQTTClientCreatedOrUpdatedEventData,
  "EventGridMqttClientCreatedOrUpdatedEventData",
  "csharp"
);

@@clientName(EventGridMQTTClientDeletedEventData,
  "EventGridMqttClientDeletedEventData",
  "csharp"
);

@@clientName(EventGridMQTTClientSessionConnectedEventData,
  "EventGridMqttClientSessionConnectedEventData",
  "csharp"
);

@@clientName(EventGridMQTTClientSessionDisconnectedEventData,
  "EventGridMqttClientSessionDisconnectedEventData",
  "csharp"
);

@@clientName(EventGridMQTTClientEventData,
  "EventGridMqttClientEventData",
  "csharp"
);

@@clientName(EventGridMQTTClientState, "EventGridMqttClientState", "csharp");

@@clientName(EventGridMQTTClientDisconnectionReason,
  "EventGridMqttClientDisconnectionReason",
  "csharp"
);

@@clientName(RedisImportRDBCompletedEventData,
  "RedisImportRdbCompletedEventData",
  "csharp"
);

@@clientName(RedisExportRDBCompletedEventData,
  "RedisExportRdbCompletedEventData",
  "csharp"
);

@@clientName(AcsRouterWorkerSelector.state, "SelectorState", "csharp");
@@clientName(AcsRouterWorkerSelector.ttlSeconds, "TimeToLive", "csharp");
@@clientName(AcsRouterWorkerSelector.value, "labelValue", "csharp");
