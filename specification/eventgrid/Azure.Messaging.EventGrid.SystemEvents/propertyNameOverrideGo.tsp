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

// [BEGIN] misc renames

@@clientName(AcsRecordingFileStatusUpdatedEventData.recordingDurationMs,
  "RecordingDurationMS",
  "go"
);

@@clientName(EventHubCaptureFileCreatedEventData.fileUrl, "FileURL", "go");

@@clientName(StorageTaskAssignmentCompletedEventData.completedDateTime,
  "CompletedOn",
  "go"
);
@@clientName(StorageTaskAssignmentCompletedEventData.summaryReportBlobUrl,
  "SummaryReportBlobURI",
  "go"
);

@@clientName(StorageTaskAssignmentQueuedEventData.queuedDateTime,
  "QueuedOn",
  "go"
);

// [END] misc renames

// [BEGIN] ResourceNotifications Info -> Details renames

@@clientName(ResourceNotificationsHealthResourcesAnnotatedEventData.resourceInfo,
  "ResourceDetails",
  "go"
);
@@clientName(ResourceNotificationsHealthResourcesAnnotatedEventData.operationalInfo,
  "OperationalDetails",
  "go"
);

@@clientName(ResourceNotificationsHealthResourcesAvailabilityStatusChangedEventData.resourceInfo,
  "ResourceDetails",
  "go"
);
@@clientName(ResourceNotificationsHealthResourcesAvailabilityStatusChangedEventData.operationalInfo,
  "OperationalDetails",
  "go"
);

@@clientName(ResourceNotificationsResourceDeletedEventData.resourceInfo,
  "ResourceDetails",
  "go"
);
@@clientName(ResourceNotificationsResourceDeletedEventData.operationalInfo,
  "OperationalDetails",
  "go"
);

@@clientName(ResourceNotificationsResourceManagementCreatedOrUpdatedEventData.resourceInfo,
  "ResourceDetails",
  "go"
);
@@clientName(ResourceNotificationsResourceManagementCreatedOrUpdatedEventData.operationalInfo,
  "OperationalDetails",
  "go"
);
@@clientName(ResourceNotificationsResourceManagementDeletedEventData.resourceInfo,
  "ResourceDetails",
  "go"
);

@@clientName(ResourceNotificationsResourceManagementDeletedEventData.operationalInfo,
  "OperationalDetails",
  "go"
);

@@clientName(ResourceNotificationsResourceUpdatedEventData.resourceInfo,
  "ResourceDetails",
  "go"
);
@@clientName(ResourceNotificationsResourceUpdatedEventData.operationalInfo,
  "OperationalDetails",
  "go"
);

// [END] ResourceNotifications Info -> Details renames

// [BEGIN] AVS fixes.

@@clientName(AvsClusterCreatedEventData, "AVSClusterCreatedEventData", "go");
@@clientName(AvsClusterDeletedEventData, "AVSClusterDeletedEventData", "go");
@@clientName(AvsClusterEventData, "AVSClusterEventData", "go");
@@clientName(AvsClusterFailedEventData, "AVSClusterFailedEventData", "go");
@@clientName(AvsClusterUpdatedEventData, "AVSClusterUpdatedEventData", "go");
@@clientName(AvsClusterUpdatingEventData, "AVSClusterUpdatingEventData", "go");
@@clientName(AvsPrivateCloudEventData, "AVSPrivateCloudEventData", "go");
@@clientName(AvsPrivateCloudFailedEventData,
  "AVSPrivateCloudFailedEventData",
  "go"
);
@@clientName(AvsPrivateCloudUpdatedEventData,
  "AVSPrivateCloudUpdatedEventData",
  "go"
);
@@clientName(AvsPrivateCloudUpdatingEventData,
  "AVSPrivateCloudUpdatingEventData",
  "go"
);
@@clientName(AvsScriptExecutionCancelledEventData,
  "AVSScriptExecutionCancelledEventData",
  "go"
);
@@clientName(AvsScriptExecutionEventData, "AVSScriptExecutionEventData", "go");
@@clientName(AvsScriptExecutionFailedEventData,
  "AVSScriptExecutionFailedEventData",
  "go"
);
@@clientName(AvsScriptExecutionFinishedEventData,
  "AVSScriptExecutionFinishedEventData",
  "go"
);
@@clientName(AvsScriptExecutionStartedEventData,
  "AVSScriptExecutionStartedEventData",
  "go"
);

// [END] AVS fixes.

// [BEGIN] IOT renames

@@clientName(IotHubDeviceConnectedEventData,
  "IOTHubDeviceConnectedEventData",
  "go"
);
@@clientName(IotHubDeviceCreatedEventData,
  "IOTHubDeviceCreatedEventData",
  "go"
);
@@clientName(IotHubDeviceDeletedEventData,
  "IOTHubDeviceDeletedEventData",
  "go"
);
@@clientName(IotHubDeviceDisconnectedEventData,
  "IOTHubDeviceDisconnectedEventData",
  "go"
);
@@clientName(IotHubDeviceTelemetryEventData,
  "IOTHubDeviceTelemetryEventData",
  "go"
);

// [END] IOT renames

// [BEGIN] Healthcare renames

@@clientName(HealthcareFhirResourceCreatedEventData,
  "HealthcareFHIRResourceCreatedEventData",
  "go"
);
@@clientName(HealthcareFhirResourceDeletedEventData,
  "HealthcareFHIRResourceDeletedEventData",
  "go"
);
@@clientName(HealthcareFhirResourceUpdatedEventData,
  "HealthcareFHIRResourceUpdatedEventData",
  "go"
);

@@clientName(HealthcareFhirResourceCreatedEventData.resourceFhirAccount,
  "FHIRServiceHostName",
  "go"
);
@@clientName(HealthcareFhirResourceCreatedEventData.resourceFhirId,
  "FHIRResourceID",
  "go"
);
@@clientName(HealthcareFhirResourceCreatedEventData.resourceVersionId,
  "FHIRResourceVersionID",
  "go"
);
@@clientName(HealthcareFhirResourceCreatedEventData.resourceType,
  "FHIRResourceType",
  "go"
);
@@clientName(HealthcareFhirResourceUpdatedEventData.resourceFhirAccount,
  "FHIRServiceHostName",
  "go"
);
@@clientName(HealthcareFhirResourceUpdatedEventData.resourceFhirId,
  "FHIRResourceId",
  "go"
);
@@clientName(HealthcareFhirResourceUpdatedEventData.resourceVersionId,
  "FHIRResourceVersionID",
  "go"
);
@@clientName(HealthcareFhirResourceUpdatedEventData.resourceType,
  "FHIRResourceType",
  "go"
);
@@clientName(HealthcareFhirResourceDeletedEventData.resourceFhirAccount,
  "FHIRServiceHostName",
  "go"
);
@@clientName(HealthcareFhirResourceDeletedEventData.resourceFhirId,
  "FHIRResourceID",
  "go"
);
@@clientName(HealthcareFhirResourceDeletedEventData.resourceVersionId,
  "FHIRResourceVersionID",
  "go"
);
@@clientName(HealthcareFhirResourceDeletedEventData.resourceType,
  "FHIRResourceType",
  "go"
);

// [END] Healthcare renames

// [BEGIN] ACS renames (and acronym casing)

@@clientName(AcsChatEventBaseProperties, "ACSChatEventBaseProperties", "go");
@@clientName(AcsChatEventInThreadBaseProperties,
  "ACSChatEventInThreadBaseProperties",
  "go"
);
@@clientName(AcsChatMessageDeletedEventData,
  "ACSChatMessageDeletedEventData",
  "go"
);
@@clientName(AcsChatMessageDeletedInThreadEventData,
  "ACSChatMessageDeletedInThreadEventData",
  "go"
);
@@clientName(AcsChatMessageEditedEventData,
  "ACSChatMessageEditedEventData",
  "go"
);
@@clientName(AcsChatMessageEditedInThreadEventData,
  "ACSChatMessageEditedInThreadEventData",
  "go"
);
@@clientName(AcsChatMessageEventBaseProperties,
  "ACSChatMessageEventBaseProperties",
  "go"
);
@@clientName(AcsChatMessageEventInThreadBaseProperties,
  "ACSChatMessageEventInThreadBaseProperties",
  "go"
);
@@clientName(AcsChatMessageReceivedEventData,
  "ACSChatMessageReceivedEventData",
  "go"
);
@@clientName(AcsChatMessageReceivedEventData,
  "ACSChatMessageReceivedEventData",
  "go"
);
@@clientName(AcsChatMessageReceivedInThreadEventData,
  "ACSChatMessageReceivedInThreadEventData",
  "go"
);
@@clientName(AcsChatParticipantAddedToThreadEventData,
  "ACSChatParticipantAddedToThreadEventData",
  "go"
);
@@clientName(AcsChatParticipantAddedToThreadWithUserEventData,
  "ACSChatParticipantAddedToThreadWithUserEventData",
  "go"
);
@@clientName(AcsChatParticipantRemovedFromThreadEventData,
  "ACSChatParticipantRemovedFromThreadEventData",
  "go"
);
@@clientName(AcsChatParticipantRemovedFromThreadWithUserEventData,
  "ACSChatParticipantRemovedFromThreadWithUserEventData",
  "go"
);
@@clientName(AcsChatThreadCreatedEventData,
  "ACSChatThreadCreatedEventData",
  "go"
);
@@clientName(AcsChatThreadCreatedWithUserEventData,
  "ACSChatThreadCreatedWithUserEventData",
  "go"
);
@@clientName(AcsChatThreadDeletedEventData,
  "ACSChatThreadDeletedEventData",
  "go"
);
@@clientName(AcsChatThreadEventBaseProperties,
  "ACSChatThreadEventBaseProperties",
  "go"
);
@@clientName(AcsChatThreadEventInThreadBaseProperties,
  "ACSChatThreadEventInThreadBaseProperties",
  "go"
);
@@clientName(AcsChatThreadParticipantProperties,
  "ACSChatThreadParticipantProperties",
  "go"
);
@@clientName(AcsChatThreadPropertiesUpdatedEventData,
  "ACSChatThreadPropertiesUpdatedEventData",
  "go"
);
@@clientName(AcsChatThreadPropertiesUpdatedPerUserEventData,
  "ACSChatThreadPropertiesUpdatedPerUserEventData",
  "go"
);
@@clientName(AcsChatThreadWithUserDeletedEventData,
  "ACSChatThreadWithUserDeletedEventData",
  "go"
);
@@clientName(AcsEmailDeliveryReportReceivedEventData,
  "ACSEmailDeliveryReportReceivedEventData",
  "go"
);

@@clientName(AcsEmailDeliveryReportStatus,
  "ACSEmailDeliveryReportStatus",
  "go"
);
@@clientName(AcsEmailDeliveryReportStatusDetails,
  "ACSEmailDeliveryReportStatusDetails",
  "go"
);

@@clientName(AcsEmailEngagementTrackingReportReceivedEventData,
  "ACSEmailEngagementTrackingReportReceivedEventData",
  "go"
);
@@clientName(AcsEmailEngagementTrackingReportReceivedEventData.engagementType,
  "Engagement",
  "go"
);

@@clientName(AcsIncomingCallCustomContext,
  "ACSIncomingCallCustomContext",
  "go"
);

@@clientName(AcsIncomingCallEventData, "ACSIncomingCallEventData", "go");
@@clientName(AcsIncomingCallEventData.from,
  "FromCommunicationIdentifier",
  "go"
);
@@clientName(AcsIncomingCallEventData.to, "ToCommunicationIdentifier", "go");

@@clientName(AcsInteractiveReplyKind, "ACSInteractiveReplyKind", "go");
@@clientName(AcsMessageButtonContent, "ACSMessageButtonContent", "go");

// we expose a custom error type and use this internally.
@@clientName(AcsMessageChannelEventError,
  "internalACSMessageChannelEventError",
  "go"
);
@@access(AcsMessageChannelEventError, Access.internal, "go");

@@clientName(AcsMessageChannelKind, "ACSMessageChannelKind", "go");

@@clientName(AcsMessageContext, "ACSMessageContext", "go");
@@clientName(AcsMessageContext.id, "MessageID", "go");

@@clientName(AcsMessageDeliveryStatus, "ACSMessageDeliveryStatus", "go");

@@clientName(AcsMessageDeliveryStatusUpdatedEventData,
  "ACSMessageDeliveryStatusUpdatedEventData",
  "go"
);
@@clientName(AcsMessageDeliveryStatusUpdatedEventData.receivedTimeStamp,
  "ReceivedTimestamp",
  "go"
);

@@clientName(AcsMessageEventData, "ACSMessageEventData", "go");
@@clientName(AcsMessageEventData.receivedTimeStamp, "ReceivedTimestamp", "go");

@@clientName(AcsMessageInteractiveButtonReplyContent,
  "ACSMessageInteractiveButtonReplyContent",
  "go"
);
@@clientName(AcsMessageInteractiveButtonReplyContent.id, "ButtonID", "go");

@@clientName(AcsMessageInteractiveContent,
  "ACSMessageInteractiveContent",
  "go"
);
@@clientName(AcsMessageInteractiveContent.type, "ReplyKind", "go");

@@clientName(AcsMessageInteractiveListReplyContent.id, "ListItemID", "go");
@@clientName(AcsMessageInteractiveListReplyContent,
  "ACSMessageInteractiveListReplyContent",
  "go"
);

@@clientName(AcsMessageMediaContent, "ACSMessageMediaContent", "go");
@@clientName(AcsMessageMediaContent.id, "MediaID", "go");

@@clientName(AcsMessageReceivedEventData, "ACSMessageReceivedEventData", "go");
@@clientName(AcsMessageReceivedEventData.interactive,
  "InteractiveContent",
  "go"
);
@@clientName(AcsMessageReceivedEventData.media, "MediaContent", "go");
@@clientName(AcsMessageReceivedEventData.receivedTimeStamp,
  "ReceivedTimestamp",
  "go"
);

@@clientName(AcsRecordingChunkInfoProperties,
  "ACSRecordingChunkInfoProperties",
  "go"
);

@@clientName(AcsRecordingFileStatusUpdatedEventData,
  "ACSRecordingFileStatusUpdatedEventData",
  "go"
);

@@clientName(recordingChannelType, "ACSRecordingChannelType", "go");
@@clientName(recordingContentType, "ACSRecordingContentType", "go");
@@clientName(recordingFormatType, "ACSRecordingFormatType", "go");
@@clientName(KeyVaultAccessPolicyChangedEventData.NBF, "NBF", "go");
@@clientName(KeyVaultAccessPolicyChangedEventData.EXP, "EXP", "go");
@@clientName(KeyVaultCertificateNearExpiryEventData.NBF, "NBF", "go");
@@clientName(KeyVaultCertificateNearExpiryEventData.EXP, "EXP", "go");
@@clientName(KeyVaultCertificateNewVersionCreatedEventData.NBF, "NBF", "go");
@@clientName(KeyVaultCertificateNewVersionCreatedEventData.EXP, "EXP", "go");
@@clientName(KeyVaultCertificateExpiredEventData.NBF, "NBF", "go");
@@clientName(KeyVaultCertificateExpiredEventData.EXP, "EXP", "go");
@@clientName(KeyVaultKeyExpiredEventData.NBF, "NBF", "go");
@@clientName(KeyVaultKeyExpiredEventData.EXP, "EXP", "go");
@@clientName(KeyVaultKeyNearExpiryEventData.NBF, "NBF", "go");
@@clientName(KeyVaultKeyNearExpiryEventData.EXP, "EXP", "go");
@@clientName(KeyVaultKeyNewVersionCreatedEventData.NBF, "NBF", "go");
@@clientName(KeyVaultKeyNewVersionCreatedEventData.EXP, "EXP", "go");
@@clientName(KeyVaultSecretExpiredEventData.NBF, "NBF", "go");
@@clientName(KeyVaultSecretExpiredEventData.EXP, "EXP", "go");
@@clientName(KeyVaultSecretNearExpiryEventData.NBF, "NBF", "go");
@@clientName(KeyVaultSecretNearExpiryEventData.EXP, "EXP", "go");
@@clientName(KeyVaultSecretNewVersionCreatedEventData.NBF, "NBF", "go");
@@clientName(KeyVaultSecretNewVersionCreatedEventData.EXP, "EXP", "go");

@@clientName(AcsRecordingStorageInfoProperties,
  "ACSRecordingStorageInfoProperties",
  "go"
);
@@clientName(AcsRouterChannelConfiguration,
  "ACSRouterChannelConfiguration",
  "go"
);

// we expose a custom error type and use this internally.
@@clientName(AcsRouterCommunicationError,
  "internalACSRouterCommunicationError",
  "go"
);
@@access(AcsRouterCommunicationError, Access.internal, "go");

@@clientName(AcsRouterEventData, "ACSRouterEventData", "go");
@@clientName(AcsRouterJobCancelledEventData,
  "ACSRouterJobCancelledEventData",
  "go"
);
@@clientName(AcsRouterJobClassificationFailedEventData,
  "ACSRouterJobClassificationFailedEventData",
  "go"
);
@@clientName(AcsRouterJobClassifiedEventData,
  "ACSRouterJobClassifiedEventData",
  "go"
);
@@clientName(AcsRouterJobClosedEventData, "ACSRouterJobClosedEventData", "go");
@@clientName(AcsRouterJobCompletedEventData,
  "ACSRouterJobCompletedEventData",
  "go"
);
@@clientName(AcsRouterJobDeletedEventData,
  "ACSRouterJobDeletedEventData",
  "go"
);
@@clientName(AcsRouterJobEventData, "ACSRouterJobEventData", "go");
@@clientName(AcsRouterJobExceptionTriggeredEventData,
  "ACSRouterJobExceptionTriggeredEventData",
  "go"
);
@@clientName(AcsRouterJobQueuedEventData, "ACSRouterJobQueuedEventData", "go");
@@clientName(AcsRouterJobReceivedEventData,
  "ACSRouterJobReceivedEventData",
  "go"
);
@@clientName(AcsRouterJobSchedulingFailedEventData,
  "ACSRouterJobSchedulingFailedEventData",
  "go"
);
@@clientName(AcsRouterJobStatus, "ACSRouterJobStatus", "go");
@@clientName(AcsRouterJobUnassignedEventData,
  "ACSRouterJobUnassignedEventData",
  "go"
);
@@clientName(AcsRouterJobWaitingForActivationEventData,
  "ACSRouterJobWaitingForActivationEventData",
  "go"
);
@@clientName(AcsRouterJobWorkerSelectorsExpiredEventData,
  "ACSRouterJobWorkerSelectorsExpiredEventData",
  "go"
);
@@clientName(AcsRouterLabelOperator, "ACSRouterLabelOperator", "go");
@@clientName(AcsRouterQueueDetails, "ACSRouterQueueDetails", "go");
@@clientName(AcsRouterUpdatedWorkerProperty,
  "ACSRouterUpdatedWorkerProperty",
  "go"
);
@@clientName(AcsRouterWorkerDeletedEventData,
  "ACSRouterWorkerDeletedEventData",
  "go"
);
@@clientName(AcsRouterWorkerDeregisteredEventData,
  "ACSRouterWorkerDeregisteredEventData",
  "go"
);
@@clientName(AcsRouterWorkerEventData, "ACSRouterWorkerEventData", "go");
@@clientName(AcsRouterWorkerOfferAcceptedEventData,
  "ACSRouterWorkerOfferAcceptedEventData",
  "go"
);
@@clientName(AcsRouterWorkerOfferDeclinedEventData,
  "ACSRouterWorkerOfferDeclinedEventData",
  "go"
);
@@clientName(AcsRouterWorkerOfferExpiredEventData,
  "ACSRouterWorkerOfferExpiredEventData",
  "go"
);
@@clientName(AcsRouterWorkerOfferIssuedEventData,
  "ACSRouterWorkerOfferIssuedEventData",
  "go"
);
@@clientName(AcsRouterWorkerOfferRevokedEventData,
  "ACSRouterWorkerOfferRevokedEventData",
  "go"
);
@@clientName(AcsRouterWorkerRegisteredEventData,
  "ACSRouterWorkerRegisteredEventData",
  "go"
);
@@clientName(AcsRouterWorkerSelector, "ACSRouterWorkerSelector", "go");
@@clientName(AcsRouterWorkerSelector.labelOperator, "Operator", "go");
@@clientName(AcsRouterWorkerSelector.state, "SelectorState", "go");
@@clientName(AcsRouterWorkerSelector.ttlSeconds, "TimeToLive", "go");
@@clientName(AcsRouterWorkerSelector.value, "labelValue", "go");

@@clientName(AcsRouterWorkerSelectorState,
  "ACSRouterWorkerSelectorState",
  "go"
);
@@clientName(AcsRouterWorkerUpdatedEventData,
  "ACSRouterWorkerUpdatedEventData",
  "go"
);
@@clientName(AcsSmsDeliveryAttemptProperties,
  "ACSSMSDeliveryAttemptProperties",
  "go"
);
@@clientName(AcsSmsDeliveryReportReceivedEventData,
  "ACSSMSDeliveryReportReceivedEventData",
  "go"
);
@@clientName(AcsSmsEventBaseProperties, "ACSSMSEventBaseProperties", "go");
@@clientName(AcsSmsReceivedEventData, "ACSSMSReceivedEventData", "go");
@@clientName(AcsUserDisconnectedEventData,
  "ACSUserDisconnectedEventData",
  "go"
);

@@clientName(AcsUserEngagement, "ACSUserEngagement", "go");
@@clientName(AcsMessageReactionContent, "ACSMessageReactionContent", "go");

@@clientName(AcsCallEndReasonProperties, "ACSCallEndReasonProperties", "go");
@@clientName(AcsCallEndedByProperties, "ACSCallEndedByProperties", "go");
@@clientName(AcsCallEndedByKind, "ACSCallEndedByKind", "go");
@@clientName(AcsCallEndedEventData, "ACSCallEndedEventData", "go");
@@clientName(AcsCallGroupProperties, "ACSCallGroupProperties", "go");
@@clientName(AcsCallParticipantAddedEventData,
  "ACSCallParticipantAddedEventData",
  "go"
);
@@clientName(AcsCallParticipantEventData, "ACSCallParticipantEventData", "go");
@@clientName(AcsCallParticipantProperties,
  "ACSCallParticipantProperties",
  "go"
);
@@clientName(AcsCallParticipantRemovedEventData,
  "ACSCallParticipantRemovedEventData",
  "go"
);
@@clientName(AcsCallRoomProperties, "ACSCallRoomProperties", "go");
@@clientName(AcsCallStartedEventData, "ACSCallStartedEventData", "go");
@@clientName(AcsCallingEventProperties, "ACSCallingEventProperties", "go");
@@clientName(AcsChatAzureBotCommandReceivedInThreadEventData,
  "ACSChatAzureBotCommandReceivedInThreadEventData",
  "go"
);
@@clientName(AcsChatTypingIndicatorReceivedInThreadEventData,
  "ACSChatTypingIndicatorReceivedInThreadEventData",
  "go"
);
@@clientName(AcsCallParticipantKind, "ACSCallParticipantRoleKind", "go");

// [END] ACS renames (and acronym casing)
