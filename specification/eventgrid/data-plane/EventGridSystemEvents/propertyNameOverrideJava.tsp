import "./Microsoft.Communication/AzureCommunicationServices.tsp";
import "./Microsoft.EventHub/EventHub.tsp";
import "./Microsoft.HealthcareApis/HealthcareApis.tsp";
import "./Microsoft.Devices/IotHub.tsp";
import "./Microsoft.ResourceNotifications/Resources.tsp";
import "./Microsoft.Storage/Storage.tsp";
import "./Microsoft.DataBox/DataBox.tsp";
import "./Microsoft.EventGrid/EventGrid.tsp";
import "./Microsoft.AVS/AVS.tsp";
import "./Microsoft.KeyVault/KeyVault.tsp";

import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using Microsoft.EventGrid.SystemEvents;

@@clientName(AcsIncomingCallEventData.to, "toCommunicationIdentifier", "java");
@@clientName(AcsIncomingCallEventData.from,
  "fromCommunicationIdentifier",
  "java"
);

@@clientName(AcsIncomingCallEventData.onBehalfOfCallee,
  "onBehalfOfCommunicationIdentifier",
  "java"
);

@@clientName(AcsMessageMediaContent.id, "mediaId", "java");

@@clientName(AcsMessageContext.id, "messageId", "java");

@@clientName(AcsRouterWorkerSelector.ttlSeconds, "timeToLive", "java");

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

@@clientName(AcsRouterWorkerSelector.value, "labelValue", "java");

@@clientName(AcsRecordingFileStatusUpdatedEventData.recordingDurationMs,
  "recordingDuration",
  "java"
);

@@clientName(StorageTaskAssignmentQueuedEventData.queuedDateTime,
  "queuedOn",
  "java"
);

@@clientName(KeyVaultAccessPolicyChangedEventData.NBF, "Nbf", "java");

@@clientName(KeyVaultAccessPolicyChangedEventData.EXP, "Exp", "java");

@@clientName(KeyVaultCertificateNewVersionCreatedEventData.NBF, "Nbf", "java");

@@clientName(KeyVaultCertificateNewVersionCreatedEventData.EXP, "Exp", "java");

@@clientName(KeyVaultCertificateExpiredEventData.NBF, "Nbf", "java");

@@clientName(KeyVaultCertificateExpiredEventData.EXP, "Exp", "java");

@@clientName(KeyVaultKeyNewVersionCreatedEventData.NBF, "Nbf", "java");

@@clientName(KeyVaultKeyNewVersionCreatedEventData.EXP, "Exp", "java");

@@clientName(KeyVaultKeyNearExpiryEventData.NBF, "Nbf", "java");

@@clientName(KeyVaultKeyNearExpiryEventData.EXP, "Exp", "java");

@@clientName(KeyVaultKeyExpiredEventData.NBF, "Nbf", "java");

@@clientName(KeyVaultKeyExpiredEventData.EXP, "Exp", "java");

@@clientName(KeyVaultSecretNewVersionCreatedEventData.NBF, "Nbf", "java");

@@clientName(KeyVaultSecretNewVersionCreatedEventData.EXP, "Exp", "java");

@@clientName(KeyVaultSecretNearExpiryEventData.NBF, "Nbf", "java");

@@clientName(KeyVaultSecretNearExpiryEventData.EXP, "Exp", "java");

@@clientName(KeyVaultSecretExpiredEventData.NBF, "Nbf", "java");

@@clientName(KeyVaultSecretExpiredEventData.EXP, "Exp", "java");

@@clientName(KeyVaultCertificateNearExpiryEventData.NBF, "Nbf", "java");

@@clientName(KeyVaultCertificateNearExpiryEventData.EXP, "Exp", "java");

@@clientName(AcsMessageDeliveryStatusUpdatedEventData.channelType,
  "channelKind",
  "java"
);

@@clientName(AcsMessageReceivedEventData.channelType, "channelKind", "java");

@@clientName(AcsMessageReceivedEventData.media, "mediaContent", "java");

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

@@clientName(CommunicationIdentifierModelKind,
  "CommunicationIdentifierKind",
  "java"
);

@@clientName(MicrosoftTeamsAppIdentifierModel,
  "MicrosoftTeamsAppIdentifier",
  "java"
);

@@clientName(AcsMessageEventData.receivedTimeStamp,
  "receivedTimestamp",
  "java"
);

@@clientName(AcsCallEndedEventData.callDurationInSeconds,
  "callDuration",
  "java"
);
