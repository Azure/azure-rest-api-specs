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

@@clientName(AcsEmailEngagementTrackingReportReceivedEventData.engagementType,
  "Engagement",
  "csharp"
);
@@clientName(AcsEmailEngagementTrackingReportReceivedEventData.userActionTimeStamp,
  "UserActionTimestamp",
  "csharp"
);

@@clientName(AcsIncomingCallEventData.from,
  "FromCommunicationIdentifier",
  "csharp"
);
@@clientName(AcsIncomingCallEventData.to,
  "ToCommunicationIdentifier",
  "csharp"
);

// we expose a custom error type and use this internally.
@@clientName(AcsMessageChannelEventError,
  "internalACSMessageChannelEventError",
  "csharp"
);
@@access(AcsMessageChannelEventError, Access.internal, "csharp");

@@clientName(AcsMessageContext.id, "MessageId", "csharp");

@@clientName(AcsMessageDeliveryStatusUpdatedEventData.channelType,
  "ChannelKind",
  "csharp"
);
@@clientName(AcsMessageDeliveryStatusUpdatedEventData.receivedTimeStamp,
  "ReceivedTimestamp",
  "csharp"
);

@@clientName(AcsMessageEventData.error, "InternalError", "csharp");
@@clientName(AcsMessageEventData.receivedTimeStamp,
  "ReceivedTimestamp",
  "csharp"
);

@@clientName(AcsMessageInteractiveButtonReplyContent.id, "ButtonId", "csharp");

@@clientName(AcsMessageInteractiveContent.type, "ReplyKind", "csharp");

@@clientName(AcsMessageInteractiveListReplyContent.id, "ListItemId", "csharp");

@@clientName(AcsMessageMediaContent.id, "MediaId", "csharp");

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

@@clientName(recordingChannelType, "recordingChannelKind", "csharp");

@@clientName(AcsRecordingFileStatusUpdatedEventData.recordingChannelType,
  "recordingChannelKind",
  "csharp"
);

// we expose a custom error type and use this internally.
@@clientName(AcsRouterCommunicationError,
  "internalAcsRouterCommunicationError",
  "csharp"
);
@@access(AcsRouterCommunicationError, Access.internal, "csharp");

@@clientName(AcsRouterJobClassificationFailedEventData.errors,
  "errorsInternal",
  "csharp"
);

@@clientName(AcsRouterWorkerSelector.state, "SelectorState", "csharp");
@@clientName(AcsRouterWorkerSelector.ttlSeconds, "TimeToLive", "csharp");
@@clientName(AcsRouterWorkerSelector.value, "labelValue", "csharp");

// [END] ACS renames (and acronym casing)
