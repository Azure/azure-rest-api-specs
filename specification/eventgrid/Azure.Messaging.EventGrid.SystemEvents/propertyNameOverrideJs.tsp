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
using Microsoft.EventGrid.SystemEvents.Maps;

@@clientName(AcsRouterWorkerSelector.value, "labelValue", "javascript");
@@clientName(AcsMessageMediaContent.id, "mediaId", "javascript");
@@clientName(AcsMessageContext.id, "messageId", "javascript");
@@clientName(AcsMessageInteractiveContent.type, "replyKind", "javascript");
@@clientName(AcsMessageInteractiveButtonReplyContent.id,
  "buttonId",
  "javascript"
);
@@clientName(AcsMessageInteractiveListReplyContent.id,
  "listItemId",
  "javascript"
);
@@clientName(AcsMessageDeliveryStatusUpdatedEventData.channelType,
  "channelKind",
  "javascript"
);
@@clientName(AcsMessageReceivedEventData.channelType,
  "channelKind",
  "javascript"
);
@@clientName(AcsMessageReceivedEventData.media, "mediaContent", "javascript");
@@clientName(AcsMessageReceivedEventData.interactive,
  "interactiveContent",
  "javascript"
);
@@clientName(AcsIncomingCallEventData.from,
  "fromCommunicationIdentifier",
  "javascript"
);
@@clientName(AcsIncomingCallEventData.to,
  "toCommunicationIdentifier",
  "javascript"
);
@@clientName(AcsEmailEngagementTrackingReportReceivedEventData.userActionTimeStamp,
  "userActionTimestamp",
  "javascript"
);
@@clientName(AcsEmailEngagementTrackingReportReceivedEventData.engagementType,
  "engagement",
  "javascript"
);
@@clientName(StorageTaskAssignmentQueuedEventData.queuedDateTime,
  "queuedOn",
  "javascript"
);
@@clientName(StorageTaskAssignmentCompletedEventData.completedDateTime,
  "completedOn",
  "javascript"
);
@@clientName(StorageTaskAssignmentCompletedEventData.summaryReportBlobUrl,
  "summaryReportBlobUri",
  "javascript"
);
@@clientName(AcsEmailDeliveryReportReceivedEventData.deliveryAttemptTimeStamp,
  "deliveryAttemptTimestamp",
  "javascript"
);
@@clientName(ResourceNotificationsResourceUpdatedEventData.resourceInfo,
  "resourceDetails",
  "javascript"
);
@@clientName(ResourceNotificationsResourceUpdatedEventData.operationalInfo,
  "operationalDetails",
  "javascript"
);
@@clientName(ResourceNotificationsResourceDeletedEventData.resourceInfo,
  "resourceDetails",
  "javascript"
);
@@clientName(ResourceNotificationsResourceDeletedEventData.operationalInfo,
  "operationalDetails",
  "javascript"
);
@@clientName(AcsChatEventBaseProperties, "AcsChatEventBase", "javascript");
@@clientName(AcsChatMessageEventBaseProperties,
  "AcsChatMessageEventBase",
  "javascript"
);
@@clientName(AcsChatThreadEventBaseProperties,
  "AcsChatThreadEventBase",
  "javascript"
);
@@clientName(AcsChatEventInThreadBaseProperties,
  "AcsChatEventInThreadBase",
  "javascript"
);
@@clientName(AcsRecordingStorageInfoProperties,
  "AcsRecordingStorageInfo",
  "javascript"
);
@@clientName(AcsRecordingChunkInfoProperties,
  "AcsRecordingChunkInfo",
  "javascript"
);
@@clientName(AcsChatThreadParticipantProperties,
  "AcsChatThreadParticipant",
  "javascript"
);
@@clientName(AcsSmsDeliveryAttemptProperties,
  "AcsSmsDeliveryAttempt",
  "javascript"
);
@@clientName(AcsSmsEventBaseProperties, "AcsSmsEventBase", "javascript");
@@clientName(MapsGeofenceEventProperties, "MapsGeofenceEvent", "javascript");
@@clientName(DeviceConnectionStateEventProperties,
  "DeviceConnectionStateEvent",
  "javascript"
);
@@clientName(DeviceLifeCycleEventProperties,
  "DeviceLifeCycleEvent",
  "javascript"
);
@@clientName(DeviceTelemetryEventProperties,
  "DeviceTelemetryEvent",
  "javascript"
);
@@clientName(DeviceTwinProperties, "DeviceTwin", "javascript");
@@clientName(AcsChatThreadEventInThreadBaseProperties,
  "AcsChatThreadEventInThreadBase",
  "javascript"
);
@@clientName(AcsChatMessageEventInThreadBaseProperties,
  "AcsChatMessageEventInThreadBase",
  "javascript"
);
@@clientName(EventGridMQTTClientCreatedOrUpdatedEventData,
  "EventGridMqttClientCreatedOrUpdatedEventData",
  "javascript"
);
@@clientName(EventGridMQTTClientDeletedEventData,
  "EventGridMqttClientDeletedEventData",
  "javascript"
);
@@clientName(EventGridMQTTClientSessionConnectedEventData,
  "EventGridMqttClientSessionConnectedEventData",
  "javascript"
);
@@clientName(EventGridMQTTClientSessionDisconnectedEventData,
  "EventGridMqttClientSessionDisconnectedEventData",
  "javascript"
);
@@clientName(EventGridMQTTClientEventData,
  "EventGridMqttClientEventData",
  "javascript"
);
@@clientName(EventGridMQTTClientState,
  "EventGridMqttClientState",
  "javascript"
);
@@clientName(EventGridMQTTClientDisconnectionReason,
  "EventGridMqttClientDisconnectionReason",
  "javascript"
);
