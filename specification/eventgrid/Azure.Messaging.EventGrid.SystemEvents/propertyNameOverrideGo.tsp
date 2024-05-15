import "./Microsoft.Communication/AzureCommunicationServices.tsp";
import "./Microsoft.EventHub/EventHub.tsp";
import "./Microsoft.HealthcareApis/HealthcareApis.tsp";
import "./Microsoft.Devices/IotHub.tsp";
import "./Microsoft.ResourceNotifications/ResourceNotifications.tsp";
import "./Microsoft.Storage/Storage.tsp";
import "./Microsoft.DataBox/DataBox.tsp";
import "./Microsoft.EventGrid/EventGrid.tsp";

import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Reflection;

using Azure.ClientGenerator.Core;
using Microsoft.EventGrid.SystemEvents;

// [BEGIN] misc renames

@@clientName(MediaLiveEventChannelArchiveHeartbeatEventData.channelLatencyMs,
    "ChannelLatencyMS",
    "go"
);

@@clientName(AcsRecordingFileStatusUpdatedEventData.recordingDurationMs,
    "RecordingDurationMS",
    "go"
);

// [END] misc renames

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
@@clientName(AcsIncomingCallCustomContext,
    "ACSIncomingCallCustomContext",
    "go"
);
@@clientName(AcsIncomingCallEventData, "ACSIncomingCallEventData", "go");
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
@@clientName(AcsMessageDeliveryStatus, "ACSMessageDeliveryStatus", "go");
@@clientName(AcsMessageDeliveryStatusUpdatedEventData,
    "ACSMessageDeliveryStatusUpdatedEventData",
    "go"
);
@@clientName(AcsMessageEventData, "ACSMessageEventData", "go");
@@clientName(AcsMessageInteractiveButtonReplyContent,
    "ACSMessageInteractiveButtonReplyContent",
    "go"
);
@@clientName(AcsMessageInteractiveContent,
    "ACSMessageInteractiveContent",
    "go"
);
@@clientName(AcsMessageInteractiveListReplyContent,
    "ACSMessageInteractiveListReplyContent",
    "go"
);
@@clientName(AcsMessageMediaContent, "ACSMessageMediaContent", "go");
@@clientName(AcsMessageReceivedEventData, "ACSMessageReceivedEventData", "go");
@@clientName(AcsRecordingChunkInfoProperties,
    "ACSRecordingChunkInfoProperties",
    "go"
);

@@clientName(AcsRecordingFileStatusUpdatedEventData,
    "ACSRecordingFileStatusUpdatedEventData",
    "go"
);

@@clientName(recordingChannelType, "recordingChannelKind", "go");

@@clientName(AcsRecordingFileStatusUpdatedEventData.recordingChannelType,
    "recordingChannelKind",
    "go"
);

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
@@clientName(AcsRouterWorkerSelectorState,
    "ACSRouterWorkerSelectorState",
    "go"
);
@@clientName(AcsRouterWorkerUpdatedEventData,
    "ACSRouterWorkerUpdatedEventData",
    "go"
);
@@clientName(AcsSmsDeliveryAttemptProperties,
    "ACSSmsDeliveryAttemptProperties",
    "go"
);
@@clientName(AcsSmsDeliveryReportReceivedEventData,
    "ACSSmsDeliveryReportReceivedEventData",
    "go"
);
@@clientName(AcsSmsEventBaseProperties, "ACSSmsEventBaseProperties", "go");
@@clientName(AcsSmsReceivedEventData, "ACSSmsReceivedEventData", "go");
@@clientName(AcsUserDisconnectedEventData,
    "ACSUserDisconnectedEventData",
    "go"
);
@@clientName(AcsUserEngagement, "ACSUserEngagement", "go");

// [END] ACS renames (and acronym casing)
