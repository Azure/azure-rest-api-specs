import "./Microsoft.Communication/AzureCommunicationServices.tsp";
import "./Microsoft.EventHub/EventHub.tsp";
import "./Microsoft.HealthcareApis/HealthcareApis.tsp";
import "./Microsoft.Devices/IotHub.tsp";
import "./Microsoft.ResourceNotifications/Resources.tsp";
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
  "timeToLive",
  "java"
);

@@clientName(MediaLiveEventChannelArchiveHeartbeatEventData.channelLatencyMs,
  "channelLatency",
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

@@clientName(KeyVaultAccessPolicyChangedEventData.NBF,
  "Nbf",
  "java"
);

@@clientName(KeyVaultAccessPolicyChangedEventData.EXP,
  "Exp",
  "java"
);

@@clientName(KeyVaultCertificateNewVersionCreatedEventData.NBF,
  "Nbf",
  "java"
);

@@clientName(KeyVaultCertificateNewVersionCreatedEventData.EXP,
  "Exp",
  "java"
);

@@clientName(KeyVaultCertificateExpiredEventData.NBF,
  "Nbf",
  "java"
);

@@clientName(KeyVaultCertificateExpiredEventData.EXP,
  "Exp",
  "java"
);

@@clientName(KeyVaultKeyNewVersionCreatedEventData.NBF,
  "Nbf",
  "java"
);


@@clientName(KeyVaultKeyNewVersionCreatedEventData.EXP,
  "Exp",
  "java"
);

@@clientName(KeyVaultKeyNearExpiryEventData.NBF,
  "Nbf",
  "java"
);

@@clientName(KeyVaultKeyNearExpiryEventData.EXP,
  "Exp",
  "java"
);

@@clientName(KeyVaultKeyExpiredEventData.NBF,
  "Nbf",
  "java"
);

@@clientName(KeyVaultKeyExpiredEventData.EXP,
  "Exp",
  "java"
);

@@clientName(KeyVaultSecretNewVersionCreatedEventData.NBF,
  "Nbf",
  "java"
);

@@clientName(KeyVaultSecretNewVersionCreatedEventData.EXP,
  "Exp",
  "java"
);

@@clientName(KeyVaultSecretNearExpiryEventData.NBF,
  "Nbf",
  "java"
);

@@clientName(KeyVaultSecretNearExpiryEventData.EXP,
  "Exp",
  "java"
);

@@clientName(KeyVaultSecretExpiredEventData.NBF,
  "Nbf",
  "java"
);

@@clientName(KeyVaultSecretExpiredEventData.EXP,
  "Exp",
  "java"
);

@@clientName(KeyVaultCertificateNearExpiryEventData.NBF,
  "Nbf",
  "java"
);

@@clientName(KeyVaultCertificateNearExpiryEventData.EXP,
  "Exp",
  "java"
);

@@clientName(AcsMessageDeliveryStatusUpdatedEventData.channelType,
  "channelKind",
  "java"
);

@@clientName(AcsMessageReceivedEventData.channelType,
  "channelKind",
  "java"
);

@@clientName(AcsMessageReceivedEventData.media,
  "mediaContent",
  "java"
);

@@clientName(AcsMessageReceivedEventData.interactive,
  "interactiveContent",
  "java"
);

@@clientName(ResourceNotificationsResourceDeletedEventData.operationalInfo,
  "operationalDetails",
  "java"
);

@@clientName(ResourceNotificationsResourceDeletedEventData.resourceInfo,
  "resourceDetails",
  "java"
);

@@clientName(ResourceNotificationsResourceUpdatedEventData.operationalInfo,
  "operationalDetails",
  "java"
);

@@clientName(ResourceNotificationsResourceUpdatedEventData.resourceInfo,
  "resourceDetails",
  "java"
);




/*

Remaining diffs explained:

Resource(Action|Delete|Write)(Cancel|Failure|Success)EventData:
These had a bunch of customization in v1 due to changing return types from Strings to actual types.
In those cases new methods were added that included "Resource", like getHttpRequest->getResourceHttpRequest..
In v2, I think we can just leave the methods as they are and not include "Resource".

Setters are removed as now these are properly immutable.

Overridden getters from base methods for optional fields are showing up. This is a bug, probably.

Several instances of Map<String, Object> moving to Map<String, BinaryData> based on recent codegen changes.
determination:
I think this is a good change we should keep.

DeviceTwinInfo:
float getVersion->Double getVersion, same for getCloudTodeviceMessageCount
these were defined as number in swagger, float32 in TSP
determination:
Given that Double is what we use for a float32, let's just keep this.


Handful of things went from `object` to `Map<String,Object>` due to moving from being a `object` in Swagger to `Record<unknown>` in TSP
 - need to check these manually to see what the ux is.
 - DeviceTelemtryEventProperties.getBody
 - MachineLearningServicesModelDeployedEventData.getServiceProperties, getServiceTags
 - MachineLearningServicesModelRegisteredEventData.getModelProperties, getModelTags
 - MachineLearningServicesRunCompletedEventData.getRunProperties, getRunTags
 - MachineLearningServicesRunStatusChangedEventData.getRunProperites, getRunTags
 - StorageAsyncOperationInitiatedEventData.getStorageDiagnostics
 - StorageBlobCreatedEventData.getStorageDiagnostics
 - StorageBlobDeletedEventData.getStorageDiagnostics
 - StorageBlobRenamedEventData.getStorageDiagnostics
 - StorageBlobTierChangedEventData.getStorageDiagnostics
 - StorageDirectoryCreatedEventData.getStorageDiagnostics
 - StorageDirectoryDeletedEventData.getStorageDiagnostics
 - StorageDirectoryRenamedEventData.getStorageDiagnostics

 Determination:
 These all wind up correct. In all cases the payload example has a key/value of some sort.
 Users will have to modify existing code to handle this by either knowing what key they want
 or by iterating them. We could go back to bundle everything into a top level object representing 
 the whole json, but I think that is overkill.


AcsCommunicationIdentifierKind - now is CommunicationIdentifierModelKind
AcsMicrosoftTeamsAppIdentifier - now is MicrosoftTeamsAppIdentifierModel

Determination: I think these are fine but I am willing to change them.


Healthcare FHIR events:
Lots of method name changes due to moving where "Fhir" is in the name or simply omitting it.

Determination: Keeping these. It's harmless and they aren't really any better or worse.
.NET did keep this customization, but that is due largely I think to their desire to 
use type forwarders.


*/

