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

// [BEGIN] misc renames

@@clientName(MediaLiveEventChannelArchiveHeartbeatEventData.channelLatencyMs,
  "ChannelLatencyMS",
  "csharp"
);

@@clientName(AcsRecordingFileStatusUpdatedEventData.recordingDurationMs,
  "RecordingDurationMS",
  "csharp"
);

@@clientName(EventHubCaptureFileCreatedEventData.fileUrl, "FileURL", "csharp");

@@clientName(StorageTaskAssignmentCompletedEventData.completedDateTime,
  "CompletedOn",
  "csharp"
);
@@clientName(StorageTaskAssignmentCompletedEventData.summaryReportBlobUrl,
  "SummaryReportBlobURI",
  "csharp"
);

@@clientName(StorageTaskAssignmentQueuedEventData.queuedDateTime,
  "QueuedOn",
  "csharp"
);

// [END] misc renames

// [BEGIN] ResourceNotifications Info -> Details renames

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

@@clientName(ResourceNotificationsResourceDeletedEventData.resourceInfo,
  "ResourceDetails",
  "csharp"
);
@@clientName(ResourceNotificationsResourceDeletedEventData.operationalInfo,
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

@@clientName(ResourceNotificationsResourceUpdatedEventData.resourceInfo,
  "ResourceDetails",
  "csharp"
);
@@clientName(ResourceNotificationsResourceUpdatedEventData.operationalInfo,
  "OperationalDetails",
  "csharp"
);

// [END] ResourceNotifications Info -> Details renames

// [BEGIN] AVS fixes.

@@clientName(AvsClusterCreatedEventData,
  "AVSClusterCreatedEventData",
  "csharp"
);
@@clientName(AvsClusterDeletedEventData,
  "AVSClusterDeletedEventData",
  "csharp"
);
@@clientName(AvsClusterEventData, "AVSClusterEventData", "csharp");
@@clientName(AvsClusterFailedEventData, "AVSClusterFailedEventData", "csharp");
@@clientName(AvsClusterUpdatedEventData,
  "AVSClusterUpdatedEventData",
  "csharp"
);
@@clientName(AvsClusterUpdatingEventData,
  "AVSClusterUpdatingEventData",
  "csharp"
);
@@clientName(AvsPrivateCloudEventData, "AVSPrivateCloudEventData", "csharp");
@@clientName(AvsPrivateCloudFailedEventData,
  "AVSPrivateCloudFailedEventData",
  "csharp"
);
@@clientName(AvsPrivateCloudUpdatedEventData,
  "AVSPrivateCloudUpdatedEventData",
  "csharp"
);
@@clientName(AvsPrivateCloudUpdatingEventData,
  "AVSPrivateCloudUpdatingEventData",
  "csharp"
);
@@clientName(AvsScriptExecutionCancelledEventData,
  "AVSScriptExecutionCancelledEventData",
  "csharp"
);
@@clientName(AvsScriptExecutionEventData,
  "AVSScriptExecutionEventData",
  "csharp"
);
@@clientName(AvsScriptExecutionFailedEventData,
  "AVSScriptExecutionFailedEventData",
  "csharp"
);
@@clientName(AvsScriptExecutionFinishedEventData,
  "AVSScriptExecutionFinishedEventData",
  "csharp"
);
@@clientName(AvsScriptExecutionStartedEventData,
  "AVSScriptExecutionStartedEventData",
  "csharp"
);

// [END] AVS fixes.

// [BEGIN] IOT renames

@@clientName(IotHubDeviceConnectedEventData,
  "IOTHubDeviceConnectedEventData",
  "csharp"
);
@@clientName(IotHubDeviceCreatedEventData,
  "IOTHubDeviceCreatedEventData",
  "csharp"
);
@@clientName(IotHubDeviceDeletedEventData,
  "IOTHubDeviceDeletedEventData",
  "csharp"
);
@@clientName(IotHubDeviceDisconnectedEventData,
  "IOTHubDeviceDisconnectedEventData",
  "csharp"
);
@@clientName(IotHubDeviceTelemetryEventData,
  "IOTHubDeviceTelemetryEventData",
  "csharp"
);

// [END] IOT renames

// [BEGIN] Healthcare renames

@@clientName(HealthcareFhirResourceCreatedEventData,
  "HealthcareFHIRResourceCreatedEventData",
  "csharp"
);
@@clientName(HealthcareFhirResourceDeletedEventData,
  "HealthcareFHIRResourceDeletedEventData",
  "csharp"
);
@@clientName(HealthcareFhirResourceUpdatedEventData,
  "HealthcareFHIRResourceUpdatedEventData",
  "csharp"
);

@@clientName(HealthcareFhirResourceCreatedEventData.resourceFhirAccount,
  "FHIRServiceHostName",
  "csharp"
);
@@clientName(HealthcareFhirResourceCreatedEventData.resourceFhirId,
  "FHIRResourceID",
  "csharp"
);
@@clientName(HealthcareFhirResourceCreatedEventData.resourceVersionId,
  "FHIRResourceVersionID",
  "csharp"
);
@@clientName(HealthcareFhirResourceCreatedEventData.resourceType,
  "FHIRResourceType",
  "csharp"
);
@@clientName(HealthcareFhirResourceUpdatedEventData.resourceFhirAccount,
  "FHIRServiceHostName",
  "csharp"
);
@@clientName(HealthcareFhirResourceUpdatedEventData.resourceFhirId,
  "FHIRResourceId",
  "csharp"
);
@@clientName(HealthcareFhirResourceUpdatedEventData.resourceVersionId,
  "FHIRResourceVersionID",
  "csharp"
);
@@clientName(HealthcareFhirResourceUpdatedEventData.resourceType,
  "FHIRResourceType",
  "csharp"
);
@@clientName(HealthcareFhirResourceDeletedEventData.resourceFhirAccount,
  "FHIRServiceHostName",
  "csharp"
);
@@clientName(HealthcareFhirResourceDeletedEventData.resourceFhirId,
  "FHIRResourceID",
  "csharp"
);
@@clientName(HealthcareFhirResourceDeletedEventData.resourceVersionId,
  "FHIRResourceVersionID",
  "csharp"
);
@@clientName(HealthcareFhirResourceDeletedEventData.resourceType,
  "FHIRResourceType",
  "csharp"
);

// [END] Healthcare renames

// [BEGIN] ACS renames (and acronym casing)

@@clientName(AcsChatEventBaseProperties,
  "ACSChatEventBaseProperties",
  "csharp"
);
@@clientName(AcsChatEventInThreadBaseProperties,
  "ACSChatEventInThreadBaseProperties",
  "csharp"
);
@@clientName(AcsChatMessageDeletedEventData,
  "ACSChatMessageDeletedEventData",
  "csharp"
);
@@clientName(AcsChatMessageDeletedInThreadEventData,
  "ACSChatMessageDeletedInThreadEventData",
  "csharp"
);
@@clientName(AcsChatMessageEditedEventData,
  "ACSChatMessageEditedEventData",
  "csharp"
);
@@clientName(AcsChatMessageEditedInThreadEventData,
  "ACSChatMessageEditedInThreadEventData",
  "csharp"
);
@@clientName(AcsChatMessageEventBaseProperties,
  "ACSChatMessageEventBaseProperties",
  "csharp"
);
@@clientName(AcsChatMessageEventInThreadBaseProperties,
  "ACSChatMessageEventInThreadBaseProperties",
  "csharp"
);
@@clientName(AcsChatMessageReceivedEventData,
  "ACSChatMessageReceivedEventData",
  "csharp"
);
@@clientName(AcsChatMessageReceivedEventData,
  "ACSChatMessageReceivedEventData",
  "csharp"
);
@@clientName(AcsChatMessageReceivedInThreadEventData,
  "ACSChatMessageReceivedInThreadEventData",
  "csharp"
);
@@clientName(AcsChatParticipantAddedToThreadEventData,
  "ACSChatParticipantAddedToThreadEventData",
  "csharp"
);
@@clientName(AcsChatParticipantAddedToThreadWithUserEventData,
  "ACSChatParticipantAddedToThreadWithUserEventData",
  "csharp"
);
@@clientName(AcsChatParticipantRemovedFromThreadEventData,
  "ACSChatParticipantRemovedFromThreadEventData",
  "csharp"
);
@@clientName(AcsChatParticipantRemovedFromThreadWithUserEventData,
  "ACSChatParticipantRemovedFromThreadWithUserEventData",
  "csharp"
);
@@clientName(AcsChatThreadCreatedEventData,
  "ACSChatThreadCreatedEventData",
  "csharp"
);
@@clientName(AcsChatThreadCreatedWithUserEventData,
  "ACSChatThreadCreatedWithUserEventData",
  "csharp"
);
@@clientName(AcsChatThreadDeletedEventData,
  "ACSChatThreadDeletedEventData",
  "csharp"
);
@@clientName(AcsChatThreadEventBaseProperties,
  "ACSChatThreadEventBaseProperties",
  "csharp"
);
@@clientName(AcsChatThreadEventInThreadBaseProperties,
  "ACSChatThreadEventInThreadBaseProperties",
  "csharp"
);
@@clientName(AcsChatThreadParticipantProperties,
  "ACSChatThreadParticipantProperties",
  "csharp"
);
@@clientName(AcsChatThreadPropertiesUpdatedEventData,
  "ACSChatThreadPropertiesUpdatedEventData",
  "csharp"
);
@@clientName(AcsChatThreadPropertiesUpdatedPerUserEventData,
  "ACSChatThreadPropertiesUpdatedPerUserEventData",
  "csharp"
);
@@clientName(AcsChatThreadWithUserDeletedEventData,
  "ACSChatThreadWithUserDeletedEventData",
  "csharp"
);
@@clientName(AcsEmailDeliveryReportReceivedEventData,
  "ACSEmailDeliveryReportReceivedEventData",
  "csharp"
);
@@clientName(AcsEmailDeliveryReportReceivedEventData.deliveryAttemptTimeStamp,
  "DeliveryAttemptTimestamp",
  "csharp"
);

@@clientName(AcsEmailDeliveryReportStatus,
  "ACSEmailDeliveryReportStatus",
  "csharp"
);
@@clientName(AcsEmailDeliveryReportStatusDetails,
  "ACSEmailDeliveryReportStatusDetails",
  "csharp"
);

@@clientName(AcsEmailEngagementTrackingReportReceivedEventData,
  "ACSEmailEngagementTrackingReportReceivedEventData",
  "csharp"
);
@@clientName(AcsEmailEngagementTrackingReportReceivedEventData.engagementType,
  "Engagement",
  "csharp"
);
@@clientName(AcsEmailEngagementTrackingReportReceivedEventData.userActionTimeStamp,
  "UserActionTimestamp",
  "csharp"
);

@@clientName(AcsIncomingCallCustomContext,
  "ACSIncomingCallCustomContext",
  "csharp"
);

@@clientName(AcsIncomingCallEventData, "ACSIncomingCallEventData", "csharp");
@@clientName(AcsIncomingCallEventData.from,
  "FromCommunicationIdentifier",
  "csharp"
);
@@clientName(AcsIncomingCallEventData.to,
  "ToCommunicationIdentifier",
  "csharp"
);

@@clientName(AcsInteractiveReplyKind, "ACSInteractiveReplyKind", "csharp");
@@clientName(AcsMessageButtonContent, "ACSMessageButtonContent", "csharp");

// we expose a custom error type and use this internally.
@@clientName(AcsMessageChannelEventError,
  "internalACSMessageChannelEventError",
  "csharp"
);
@@access(AcsMessageChannelEventError, Access.internal, "csharp");

@@clientName(AcsMessageChannelKind, "ACSMessageChannelKind", "csharp");

@@clientName(AcsMessageContext, "ACSMessageContext", "csharp");
@@clientName(AcsMessageContext.id, "MessageID", "csharp");

@@clientName(AcsMessageDeliveryStatus, "ACSMessageDeliveryStatus", "csharp");

@@clientName(AcsMessageDeliveryStatusUpdatedEventData,
  "ACSMessageDeliveryStatusUpdatedEventData",
  "csharp"
);
@@clientName(AcsMessageDeliveryStatusUpdatedEventData.channelType,
  "ChannelKind",
  "csharp"
);
@@clientName(AcsMessageDeliveryStatusUpdatedEventData.receivedTimeStamp,
  "ReceivedTimestamp",
  "csharp"
);

@@clientName(AcsMessageEventData, "ACSMessageEventData", "csharp");
@@clientName(AcsMessageEventData.receivedTimeStamp,
  "ReceivedTimestamp",
  "csharp"
);

@@clientName(AcsMessageInteractiveButtonReplyContent,
  "ACSMessageInteractiveButtonReplyContent",
  "csharp"
);
@@clientName(AcsMessageInteractiveButtonReplyContent.id, "ButtonID", "csharp");

@@clientName(AcsMessageInteractiveContent,
  "ACSMessageInteractiveContent",
  "csharp"
);
@@clientName(AcsMessageInteractiveContent.type, "ReplyKind", "csharp");

@@clientName(AcsMessageInteractiveListReplyContent.id, "ListItemID", "csharp");
@@clientName(AcsMessageInteractiveListReplyContent,
  "ACSMessageInteractiveListReplyContent",
  "csharp"
);

@@clientName(AcsMessageMediaContent, "ACSMessageMediaContent", "csharp");
@@clientName(AcsMessageMediaContent.id, "MediaID", "csharp");

@@clientName(AcsMessageReceivedEventData,
  "ACSMessageReceivedEventData",
  "csharp"
);
@@clientName(AcsMessageReceivedEventData.channelType, "ChannelKind", "csharp");
@@clientName(AcsMessageReceivedEventData.interactive,
  "InteractiveContent",
  "csharp"
);
@@clientName(AcsMessageReceivedEventData.media, "MediaContent", "csharp");
@@clientName(AcsMessageReceivedEventData.receivedTimeStamp,
  "ReceivedTimestamp",
  "csharp"
);

@@clientName(AcsRecordingChunkInfoProperties,
  "ACSRecordingChunkInfoProperties",
  "csharp"
);

@@clientName(AcsRecordingFileStatusUpdatedEventData,
  "ACSRecordingFileStatusUpdatedEventData",
  "csharp"
);

@@clientName(recordingChannelType, "recordingChannelKind", "csharp");

@@clientName(AcsRecordingFileStatusUpdatedEventData.recordingChannelType,
  "recordingChannelKind",
  "csharp"
);

@@clientName(AcsRecordingStorageInfoProperties,
  "ACSRecordingStorageInfoProperties",
  "csharp"
);
@@clientName(AcsRouterChannelConfiguration,
  "ACSRouterChannelConfiguration",
  "csharp"
);

// we expose a custom error type and use this internally.
@@clientName(AcsRouterCommunicationError,
  "internalACSRouterCommunicationError",
  "csharp"
);
@@access(AcsRouterCommunicationError, Access.internal, "csharp");

@@clientName(AcsRouterEventData, "ACSRouterEventData", "csharp");
@@clientName(AcsRouterJobCancelledEventData,
  "ACSRouterJobCancelledEventData",
  "csharp"
);
@@clientName(AcsRouterJobClassificationFailedEventData,
  "ACSRouterJobClassificationFailedEventData",
  "csharp"
);
@@clientName(AcsRouterJobClassifiedEventData,
  "ACSRouterJobClassifiedEventData",
  "csharp"
);
@@clientName(AcsRouterJobClosedEventData,
  "ACSRouterJobClosedEventData",
  "csharp"
);
@@clientName(AcsRouterJobCompletedEventData,
  "ACSRouterJobCompletedEventData",
  "csharp"
);
@@clientName(AcsRouterJobDeletedEventData,
  "ACSRouterJobDeletedEventData",
  "csharp"
);
@@clientName(AcsRouterJobEventData, "ACSRouterJobEventData", "csharp");
@@clientName(AcsRouterJobExceptionTriggeredEventData,
  "ACSRouterJobExceptionTriggeredEventData",
  "csharp"
);
@@clientName(AcsRouterJobQueuedEventData,
  "ACSRouterJobQueuedEventData",
  "csharp"
);
@@clientName(AcsRouterJobReceivedEventData,
  "ACSRouterJobReceivedEventData",
  "csharp"
);
@@clientName(AcsRouterJobSchedulingFailedEventData,
  "ACSRouterJobSchedulingFailedEventData",
  "csharp"
);
@@clientName(AcsRouterJobStatus, "ACSRouterJobStatus", "csharp");
@@clientName(AcsRouterJobUnassignedEventData,
  "ACSRouterJobUnassignedEventData",
  "csharp"
);
@@clientName(AcsRouterJobWaitingForActivationEventData,
  "ACSRouterJobWaitingForActivationEventData",
  "csharp"
);
@@clientName(AcsRouterJobWorkerSelectorsExpiredEventData,
  "ACSRouterJobWorkerSelectorsExpiredEventData",
  "csharp"
);
@@clientName(AcsRouterLabelOperator, "ACSRouterLabelOperator", "csharp");
@@clientName(AcsRouterQueueDetails, "ACSRouterQueueDetails", "csharp");
@@clientName(AcsRouterUpdatedWorkerProperty,
  "ACSRouterUpdatedWorkerProperty",
  "csharp"
);
@@clientName(AcsRouterWorkerDeletedEventData,
  "ACSRouterWorkerDeletedEventData",
  "csharp"
);
@@clientName(AcsRouterWorkerDeregisteredEventData,
  "ACSRouterWorkerDeregisteredEventData",
  "csharp"
);
@@clientName(AcsRouterWorkerEventData, "ACSRouterWorkerEventData", "csharp");
@@clientName(AcsRouterWorkerOfferAcceptedEventData,
  "ACSRouterWorkerOfferAcceptedEventData",
  "csharp"
);
@@clientName(AcsRouterWorkerOfferDeclinedEventData,
  "ACSRouterWorkerOfferDeclinedEventData",
  "csharp"
);
@@clientName(AcsRouterWorkerOfferExpiredEventData,
  "ACSRouterWorkerOfferExpiredEventData",
  "csharp"
);
@@clientName(AcsRouterWorkerOfferIssuedEventData,
  "ACSRouterWorkerOfferIssuedEventData",
  "csharp"
);
@@clientName(AcsRouterWorkerOfferRevokedEventData,
  "ACSRouterWorkerOfferRevokedEventData",
  "csharp"
);
@@clientName(AcsRouterWorkerRegisteredEventData,
  "ACSRouterWorkerRegisteredEventData",
  "csharp"
);
@@clientName(AcsRouterWorkerSelector, "ACSRouterWorkerSelector", "csharp");
@@clientName(AcsRouterWorkerSelector.labelOperator, "Operator", "csharp");
@@clientName(AcsRouterWorkerSelector.state, "SelectorState", "csharp");
@@clientName(AcsRouterWorkerSelector.ttlSeconds, "TimeToLive", "csharp");

@@clientName(AcsRouterWorkerSelectorState,
  "ACSRouterWorkerSelectorState",
  "csharp"
);
@@clientName(AcsRouterWorkerUpdatedEventData,
  "ACSRouterWorkerUpdatedEventData",
  "csharp"
);
@@clientName(AcsSmsDeliveryAttemptProperties,
  "ACSSmsDeliveryAttemptProperties",
  "csharp"
);
@@clientName(AcsSmsDeliveryReportReceivedEventData,
  "ACSSmsDeliveryReportReceivedEventData",
  "csharp"
);
@@clientName(AcsSmsEventBaseProperties, "ACSSmsEventBaseProperties", "csharp");
@@clientName(AcsSmsReceivedEventData, "ACSSmsReceivedEventData", "csharp");
@@clientName(AcsUserDisconnectedEventData,
  "ACSUserDisconnectedEventData",
  "csharp"
);
@@clientName(AcsUserEngagement, "ACSUserEngagement", "csharp");

// [END] ACS renames (and acronym casing)
