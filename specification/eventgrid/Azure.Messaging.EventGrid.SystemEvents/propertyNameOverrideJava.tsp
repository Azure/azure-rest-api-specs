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
import "./Microsoft.KeyVault/KeyVault.tsp";

import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.EventGrid.SystemEvents;

@@clientName(AcsIncomingCallEventData.to,
  "toCommunicationIdentifier",
  "java"
);
@@clientName(AcsIncomingCallEventData.from,
  "fromCommunicationIdentifier",
  "java"
);

@@clientName(AcsIncomingCallEventData.onBehalfOfCallee,
  "onBehalfOfCommunicationIdentifier",
  "java"
);

@@clientName(AcsMessageMediaContent.id,
  "mediaId",
  "java"
);

@@clientName(AcsMessageContext.id,
  "messageId",
  "java"
);

@@clientName(AcsRouterWorkerSelector.ttlSeconds,
  "getTimeToLive",
  "java"
);

@@clientName(MediaLiveEventChannelArchiveHeartbeatEventData.channelLatencyMs,
  "channelLatency",
  "java"
);

@@clientName(StorageDirectoryDeletedEventData.recursive,
  "isRecursive",
  "java"
);

@@clientName(Microsoft.EventGrid.SystemEvents.AcsMessageInteractiveContent.type,
  "replyKind",
  "java"
);

@@clientName(Microsoft.EventGrid.SystemEvents.AcsMessageInteractiveButtonReplyContent.id,
  "buttonId",
  "java"
);

@@clientName(Microsoft.EventGrid.SystemEvents.AcsMessageInteractiveListReplyContent.id,
  "listItemId",
  "java"
);

@@clientName(AcsRecordingFileStatusUpdatedEventData.recordingDurationMs,
  "recordingDuration",
  "java"
);

@@clientName(EventGridMQTTClientCreatedOrUpdatedEventData,
  "EventGridMqttClientCreatedOrUpdatedEventData",
  "java"
);

@@clientName(EventGridMQTTClientDeletedEventData,
  "EventGridMqttClientDeletedEventData",
  "java"
);

@@clientName(EventGridMQTTClientSessionConnectedEventData,
  "EventGridMqttClientSessionConnectedEventData",
  "java"
);

@@clientName(EventGridMQTTClientSessionDisconnectedEventData,
  "EventGridMqttClientSessionDisconnectedEventData",
  "java"
);

@@clientName(EventGridMQTTClientEventData,
  "EventGridMqttClientEventData",
  "java"
);

@@clientName(EventGridMQTTClientState, "EventGridMqttClientState", "java");

@@clientName(EventGridMQTTClientDisconnectionReason,
  "EventGridMqttClientDisconnectionReason",
  "java"
);

@@clientName(RedisImportRDBCompletedEventData,
  "RedisImportRdbCompletedEventData",
  "java"
);

@@clientName(RedisExportRDBCompletedEventData,
  "RedisExportRdbCompletedEventData",
  "java"
);

@@clientName(MediaLiveEventChannelArchiveHeartbeatEventData.channelLatencyMs,
  "channelLatency",
  "java"
);

@@clientName(AcsRouterWorkerSelector.ttlSeconds,
  "getTimeToLive",
  "java"
);

@@clientName(AcsRouterWorkerSelector.value,
  "labelValue",
  "java"
);

@@clientName(AcsRecordingFileStatusUpdatedEventData.recordingDurationMs,
  "recordingDuration",
  "java"
);

@@clientName(StorageTaskAssignmentQueuedEventData.queuedDateTime,
  "queuedOn",
  "java"
);

// @@clientName(KeyVaultCertificateExpiredEventData.NBF,
//   "foo",
//   "java"
// );




/*

todo:

fix return types:
MediaLiveEventChannelArchiveHeartbeatEventData.channelLatency
AcsRouterWorkerSelector.getTimeToLive
AcsRecordingFileStatusUpdaetdEventData.getRecordingDuration() {
StorageDirectoryDeletedEventData.getIsRecursive string->Boolean, also needs a custom rename it seems.
MediaLiveEventIngestHeartbeatEventData:
- getIngestDriftValue went from Integer to String
- getLastFragmentArrivalTime went from Datetime to String

DeviceTwinInfo:
float getVersion->Double getVersion, same for getCloudTodeviceMessageCount
these were defined as number in swagger, float32 in TSP




all the Nbf/Exp/etc stuff from previous swagger customization needs to come over
- blocked on an issue in typespec, may need to customize in the mean time.


Handful of things went from `object` to `Map<String,Object>` due to moving from being a `object` in Swagger to `Record<unknown>` in TSP
 - need to check these manually to see what the ux is.


need to validate we want:
AcsCommunicationIdentifierKind - now is CommunicationIdentifierModelKind
AcsMicrosoftTeamsAppIdentifier - now is MicrosoftTeamsAppIdentifierModel
AcsRouterCommunicationError - was previously ResponseError for these usages, should this still be? Only appears on AcsRouterJobClassificationFailedEventData.


validated correct removal:
AcsChatMemberAddedToThreadWithUserEventData  - deprecated
AcsChatMemberRemovedFromThreadWithUserEventData - deprecated
AcsChatThreadMemberProperties - only appeared in the previous two

diffs I kept:
fhir in healthcare events


*/

