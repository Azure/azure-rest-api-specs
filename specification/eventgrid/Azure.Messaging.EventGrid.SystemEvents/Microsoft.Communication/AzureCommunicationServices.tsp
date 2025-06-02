import "@typespec/versioning";
import "./AzureCommunicationServicesExample.tsp";
using TypeSpec.Versioning;

/** Describes the schema of the Azure Communication Services events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent. */
namespace Microsoft.EventGrid.SystemEvents;

// @example(MicrosoftCommunicationIncomingCallExample)
/** Schema of the Data property of an EventGridEvent for an Microsoft.Communication.IncomingCall event */
model AcsIncomingCallEventData {
  /** The communication identifier of the target user. */
  to: CommunicationIdentifierModel;

  /** The communication identifier of the user who initiated the call. */
  from: CommunicationIdentifierModel;

  /** The Id of the server call */
  serverCallId?: string;

  /** Display name of caller. */
  callerDisplayName?: string;

  /** Custom Context of Incoming Call */
  customContext: AcsIncomingCallCustomContext;

  /** Signed incoming call context. */
  incomingCallContext?: string;

  /** The communication identifier of the user on behalf of whom the call is made. */
  onBehalfOfCallee?: CommunicationIdentifierModel;

  /** CorrelationId (CallId). */
  correlationId?: string;
}

// @example(MicrosoftCommunicationUserDisconnectedExample)
/** Schema of the Data property of an EventGridEvent for an Microsoft.Communication.UserDisconnected event. */
model AcsUserDisconnectedEventData {
  /** The communication identifier of the user who was disconnected */
  userCommunicationIdentifier: CommunicationIdentifierModel;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.CallStarted event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsCallStartedEventData extends AcsCallingEventProperties {}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.CallEnded event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsCallEndedEventData extends AcsCallingEventProperties {
  /** The communication identifier of the user who was disconnected */
  endedBy?: AcsCallEndedByProperties;

  /** The reason for ending the call. */
  reason?: AcsCallEndReasonProperties;

  /** Duration of the call in seconds. */
  @encode(DurationKnownEncoding.seconds, float64)
  callDurationInSeconds?: duration;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.CallParticipantAdded event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsCallParticipantAddedEventData extends AcsCallParticipantEventData {}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.CallParticipantRemoved event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsCallParticipantRemovedEventData extends AcsCallParticipantEventData {}

// @example(MicrosoftCommunicationChatMessageReceivedExample)
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatMessageReceived event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatMessageReceivedEventData
  extends AcsChatMessageEventBaseProperties {
  ...AcsChatMessageBaseEventData;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatAzureBotCommandReceivedInThread event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatAzureBotCommandReceivedInThreadEventData
  extends AcsChatMessageEventInThreadBaseProperties {
  ...AcsChatMessageBaseEventData;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatTypingIndicatorReceivedInThread event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatTypingIndicatorReceivedInThreadEventData
  extends AcsChatMessageEventInThreadBaseProperties {
  ...AcsChatMessageBaseEventData;
}

// @example(MicrosoftCommunicationChatMessageReceivedInThreadExample)
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatMessageReceivedInThread event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatMessageReceivedInThreadEventData
  extends AcsChatMessageEventInThreadBaseProperties {
  ...AcsChatMessageBaseEventData;
}

// @example(MicrosoftCommunicationChatMessageEditedExample)
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatMessageEdited event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatMessageEditedEventData extends AcsChatMessageEventBaseProperties {
  ...AcsChatMessageBaseEventData;

  /** The time at which the message was edited */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  editTime: utcDateTime;
}

// @example(MicrosoftCommunicationChatMessageEditedInThreadExample)
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatMessageEditedInThread event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatMessageEditedInThreadEventData
  extends AcsChatMessageEventInThreadBaseProperties {
  ...AcsChatMessageBaseEventData;

  /** The time at which the message was edited */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  editTime: utcDateTime;
}

// @example(MicrosoftCommunicationChatMessageDeletedExample)
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatMessageDeleted event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatMessageDeletedEventData extends AcsChatMessageEventBaseProperties {
  /** The time at which the message was deleted */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  deleteTime: utcDateTime;
}

// @example(MicrosoftCommunicationChatMessageDeletedInThreadExample)
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatMessageDeletedInThread event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatMessageDeletedInThreadEventData
  extends AcsChatMessageEventInThreadBaseProperties {
  /** The time at which the message was deleted */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  deleteTime: utcDateTime;
}

// @example(MicrosoftCommunicationChatThreadCreatedWithUserExample)
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatThreadCreatedWithUser event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatThreadCreatedWithUserEventData
  extends AcsChatThreadEventBaseProperties {
  ...AcsChatThreadBaseEventData;
}

// @example(MicrosoftCommunicationChatThreadCreatedExample)
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatThreadCreated event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatThreadCreatedEventData
  extends AcsChatThreadEventInThreadBaseProperties {
  ...AcsChatThreadBaseEventData;
}

// @example(MicrosoftCommunicationChatThreadWithUserDeletedExample)
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatThreadWithUserDeleted event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatThreadWithUserDeletedEventData
  extends AcsChatThreadEventBaseProperties {
  ...AcsChatThreadDeletedBaseEventData;
}

// @example(MicrosoftCommunicationChatThreadDeletedExample)
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatThreadDeleted event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatThreadDeletedEventData
  extends AcsChatThreadEventInThreadBaseProperties {
  ...AcsChatThreadDeletedBaseEventData;
}

// @example(MicrosoftCommunicationChatThreadPropertiesUpdatedPerUserExample)
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatThreadPropertiesUpdatedPerUser event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatThreadPropertiesUpdatedPerUserEventData
  extends AcsChatThreadEventBaseProperties {
  /** The communication identifier of the user who updated the thread properties */
  editedByCommunicationIdentifier: CommunicationIdentifierModel;

  /** The time at which the properties of the thread were updated */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  editTime: utcDateTime;

  /** The thread metadata */
  metadata?: Record<string>;

  /** The updated thread properties */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "The type of properties is object with additionalProperties: object"
  properties: Record<unknown>;
}

// @example(AcsChatThreadPropertiesUpdatedExample)
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatThreadPropertiesUpdated event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatThreadPropertiesUpdatedEventData
  extends AcsChatThreadEventInThreadBaseProperties {
  ...AcsChatThreadPropertiesBaseEventData;
}

// @example(MicrosoftCommunicationChatParticipantAddedToThreadWithUserExample)
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatParticipantAddedToThreadWithUser event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatParticipantAddedToThreadWithUserEventData
  extends AcsChatThreadEventBaseProperties {
  ...AcsChatParticipantBaseEventData;
}

// @example(MicrosoftCommunicationChatParticipantRemovedFromThreadWithUserExample)
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatParticipantRemovedFromThreadWithUser event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatParticipantRemovedFromThreadWithUserEventData
  extends AcsChatThreadEventBaseProperties {
  /** The time at which the user was removed to the thread */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  time: utcDateTime;

  /** The communication identifier of the user who removed the user */
  removedByCommunicationIdentifier: CommunicationIdentifierModel;

  /** The details of the user who was removed */
  participantRemoved: AcsChatThreadParticipantProperties;
}

// @example(MicrosoftCommunicationChatThreadParticipantAddedExample)
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatThreadParticipantAdded event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatParticipantAddedToThreadEventData
  extends AcsChatEventInThreadBaseProperties {
  ...AcsChatParticipantBaseEventData;

  /** The version of the thread */
  version?: int64;
}

// @example(MicrosoftCommunicationChatThreadParticipantRemovedExample)
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatThreadParticipantRemoved event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatParticipantRemovedFromThreadEventData
  extends AcsChatEventInThreadBaseProperties {
  /** The time at which the user was removed to the thread */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  time: utcDateTime;

  /** The communication identifier of the user who removed the user */
  removedByCommunicationIdentifier: CommunicationIdentifierModel;

  /** The details of the user who was removed */
  participantRemoved: AcsChatThreadParticipantProperties;

  /** The version of the thread */
  version?: int64;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.SMSDeliveryReportReceived event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@example(MicrosoftCommunicationSMSDeliveryReportReceivedExample)
model AcsSmsDeliveryReportReceivedEventData extends AcsSmsEventBaseProperties {
  /** Status of Delivery */
  deliveryStatus: string;

  /** Details about Delivery Status */
  deliveryStatusDetails: string;

  /** List of details of delivery attempts made */
  @visibility(Lifecycle.Read)
  deliveryAttempts: AcsSmsDeliveryAttemptProperties[];

  /** The time at which the SMS delivery report was received */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  receivedTimestamp: utcDateTime;

  /** Customer Content */
  tag?: string;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.SMSReceived event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@example(MicrosoftCommunicationSMSReceivedExample)
model AcsSmsReceivedEventData extends AcsSmsEventBaseProperties {
  /** The SMS content */
  message: string;

  /** The time at which the SMS was received */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  receivedTimestamp: utcDateTime;

  /** Number of segments in the message */
  segmentCount: int32;
}

//TODO: This might need some fixing

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RecordingFileStatusUpdated event. */
@example(MicrosoftCommunicationRecordingFileStatusUpdatedExample)
model AcsRecordingFileStatusUpdatedEventData {
  /** The details of recording storage information */
  recordingStorageInfo: AcsRecordingStorageInfoProperties;

  /** The time at which the recording started */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  recordingStartTime: utcDateTime;

  /** The recording duration in milliseconds */
  recordingDurationMs?: int64;

  /** The recording content type- AudioVideo, or Audio */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  recordingContentType: recordingContentType;

  /** The recording  channel type - Mixed, Unmixed */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  recordingChannelType: recordingChannelType;

  /** The recording format type - Mp4, Mp3, Wav */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  recordingFormatType: recordingFormatType;

  /** The reason for ending recording session */
  sessionEndReason?: string;
}

// @example(MicrosoftCommunicationEmailDeliveryReportReceivedExample)
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.EmailDeliveryReportReceived event. */
model AcsEmailDeliveryReportReceivedEventData {
  /** The Sender Email Address */
  sender: string;

  /** The recipient Email Address */
  recipient: string;

  /** The Internet Message Id of the email that has been sent */
  internetMessageId: string;

  /** The Id of the email that has been sent */
  messageId?: string;

  /** The status of the email. Any value other than Delivered is considered failed. */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  status: AcsEmailDeliveryReportStatus;

  /** Detailed information about the status if any */
  deliveryStatusDetails: AcsEmailDeliveryReportStatusDetails;

  /** The time at which the email delivery report received timestamp */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  deliveryAttemptTimestamp: utcDateTime;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.EmailEngagementTrackingReportReceived event. */
@example(MicrosoftCommunicationEmailEngagementTrackingReportReceivedExample)
model AcsEmailEngagementTrackingReportReceivedEventData {
  /** The Sender Email Address */
  sender?: string;

  /** The Recipient Email Address */
  recipient?: string;

  /** The Id of the email that has been sent */
  messageId?: string;

  /** The time at which the user interacted with the email */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  userActionTimestamp: utcDateTime;

  /** The context of the type of engagement user had with email */
  engagementContext?: string;

  /** The user agent interacting with the email */
  userAgent?: string;

  /** The type of engagement user have with email */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  engagementType: AcsUserEngagement;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterJobCancelled event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@example(MicrosoftCommunicationRouterJobCancelledExample)
model AcsRouterJobCancelledEventData extends AcsRouterJobEventData {
  /** Router Job Note */
  note?: string;

  /** Router Job Disposition Code */
  dispositionCode?: string;
}

// @example(MicrosoftCommunicationRouterJobClassificationFailedExample)
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterJobClassificationFailed event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsRouterJobClassificationFailedEventData extends AcsRouterJobEventData {
  /** Router Job Classification Policy Id */
  classificationPolicyId?: string;

  /** Router Job Classification Failed Errors */
  @visibility(Lifecycle.Read)
  errors: AcsRouterCommunicationError[];
}

// @example(MicrosoftCommunicationRouterJobClassifiedExample)
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterJobClassified event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsRouterJobClassifiedEventData extends AcsRouterJobEventData {
  /** Router Job Queue Info */
  queueDetails: AcsRouterQueueDetails;

  /** Router Job Classification Policy Id */
  classificationPolicyId?: string;

  /** Router Job Priority */
  priority?: int32;

  /** Router Job Attached Worker Selector */
  @visibility(Lifecycle.Read)
  attachedWorkerSelectors: AcsRouterWorkerSelector[];
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterJobClosed event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@example(MicrosoftCommunicationRouterJobClosedExample)
model AcsRouterJobClosedEventData extends AcsRouterJobEventData {
  /** Router Job Closed Assignment Id */
  assignmentId?: string;

  /** Router Job Closed Worker Id */
  workerId?: string;

  /** Router Job Closed Disposition Code */
  dispositionCode?: string;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterJobCompleted event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@example(MicrosoftCommunicationRouterJobCompletedExample)
model AcsRouterJobCompletedEventData extends AcsRouterJobEventData {
  /** Router Job Completed Assignment Id */
  assignmentId?: string;

  /** Router Job Completed Worker Id */
  workerId?: string;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterJobDeleted event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@example(MicrosoftCommunicationRouterJobDeletedExample)
model AcsRouterJobDeletedEventData extends AcsRouterJobEventData {}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterJobExceptionTriggered event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@example(MicrosoftCommunicationRouterJobExceptionTriggeredExample)
model AcsRouterJobExceptionTriggeredEventData extends AcsRouterJobEventData {
  /** Router Job Exception Triggered Rule Key */
  ruleKey?: string;

  /** Router Job Exception Triggered Rule Id */
  exceptionRuleId?: string;
}

// @example(MicrosoftCommunicationRouterJobQueuedExample)
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterJobQueued event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsRouterJobQueuedEventData extends AcsRouterJobEventData {
  /** Router Job Priority */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  priority: int32;

  /** Router Job Queued Attached Worker Selector */
  @visibility(Lifecycle.Read)
  attachedWorkerSelectors: AcsRouterWorkerSelector[];

  /** Router Job Queued Requested Worker Selector */
  @visibility(Lifecycle.Read)
  requestedWorkerSelectors: AcsRouterWorkerSelector[];
}

// @example(MicrosoftCommunicationRouterJobReceivedExample)
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterJobReceived event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsRouterJobReceivedEventData extends AcsRouterJobEventData {
  /** Router Job Received Job Status */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  jobStatus: AcsRouterJobStatus;

  /** Router Job Classification Policy Id */
  classificationPolicyId?: string;

  /** Router Job Priority */
  priority?: int32;

  /** Router Job Received Requested Worker Selectors */
  @visibility(Lifecycle.Read)
  requestedWorkerSelectors: AcsRouterWorkerSelector[];

  /** Router Job Received Scheduled Time in UTC */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  scheduledOn: utcDateTime;

  /** Unavailable For Matching for Router Job Received */
  unavailableForMatching: boolean;
}

/** Acs Router Job Status */
union AcsRouterJobStatus {
  /** Router Job Status Pending Classification */
  "PendingClassification",

  /** Router Job Status Queued */
  "Queued",

  /** Router Job Status Assigned */
  "Assigned",

  /** Router Job Status Completed */
  "Completed",

  /** Router Job Status Closed */
  "Closed",

  /** Router Job Status Cancelled */
  "Cancelled",

  /** Router Job Status Classification Failed */
  "ClassificationFailed",

  /** Router Job Status Created */
  "Created",

  /** Router Job Status Pending Schedule */
  "PendingSchedule",

  /** Router Job Status Scheduled */
  "Scheduled",

  /** Router Job Status Schedule Failed */
  "ScheduleFailed",

  /** Router Job Status Waiting For Activation */
  "WaitingForActivation",

  string,
}

// @example(MicrosoftCommunicationRouterJobSchedulingFailedExample)
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterJobSchedulingFailed event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsRouterJobSchedulingFailedEventData extends AcsRouterJobEventData {
  /** Router Job Priority */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  priority: int32;

  /** Router Job Scheduling Failed Attached Worker Selector Expired */
  @visibility(Lifecycle.Read)
  expiredAttachedWorkerSelectors: AcsRouterWorkerSelector[];

  /** Router Job Scheduling Failed Requested Worker Selector Expired */
  @visibility(Lifecycle.Read)
  expiredRequestedWorkerSelectors: AcsRouterWorkerSelector[];

  /** Router Job Scheduling Failed Scheduled Time in UTC */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  @madeRequired(ServiceApiVersions.v2024_01_01)
  scheduledOn: utcDateTime;

  /** Router Job Scheduling Failed Reason */
  failureReason?: string;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterJobUnassigned event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@example(MicrosoftCommunicationRouterJobUnassignedExample)
model AcsRouterJobUnassignedEventData extends AcsRouterJobEventData {
  /** Router Job Unassigned Assignment Id */
  assignmentId?: string;

  /** Router Job Unassigned Worker Id */
  workerId?: string;
}

// @example(MicrosoftCommunicationRouterJobWaitingForActivationExample)
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterJobWaitingForActivation event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsRouterJobWaitingForActivationEventData extends AcsRouterJobEventData {
  /** Router Job Waiting For Activation Priority */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  priority: int32;

  /** Router Job Waiting For Activation Worker Selector Expired */
  @visibility(Lifecycle.Read)
  expiredAttachedWorkerSelectors: AcsRouterWorkerSelector[];

  /** Router Job Waiting For Activation Requested Worker Selector Expired */
  @visibility(Lifecycle.Read)
  expiredRequestedWorkerSelectors: AcsRouterWorkerSelector[];

  /** Router Job Waiting For Activation Scheduled Time in UTC */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  @madeRequired(ServiceApiVersions.v2024_01_01)
  scheduledOn: utcDateTime;

  /** Router Job Waiting For Activation Unavailable For Matching */
  unavailableForMatching: boolean;
}

// @example(MicrosoftCommunicationRouterJobWorkerSelectorsExpiredExample)
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterJobWorkerSelectorsExpired event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsRouterJobWorkerSelectorsExpiredEventData
  extends AcsRouterJobEventData {
  /** Router Job Worker Selectors Expired Requested Worker Selectors */
  @visibility(Lifecycle.Read)
  expiredRequestedWorkerSelectors: AcsRouterWorkerSelector[];

  /** Router Job Worker Selectors Expired Attached Worker Selectors */
  @visibility(Lifecycle.Read)
  expiredAttachedWorkerSelectors: AcsRouterWorkerSelector[];
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterWorkerDeleted event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
// @example(MicrosoftCommunicationRouterWorkerDeletedExample)
model AcsRouterWorkerDeletedEventData extends AcsRouterWorkerEventData {}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterWorkerDeregistered event */
@example(MicrosoftCommunicationRouterWorkerDeregisteredExample)
model AcsRouterWorkerDeregisteredEventData {
  /** Router Worker Deregistered Worker Id */
  workerId?: string;
}

// @example(MicrosoftCommunicationRouterWorkerOfferAcceptedExample)
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterWorkerOfferAccepted event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsRouterWorkerOfferAcceptedEventData extends AcsRouterWorkerEventData {
  /** Router Worker Offer Accepted Queue Id */
  queueId?: string;

  /** Router Worker Offer Accepted Offer Id */
  offerId?: string;

  /** Router Worker Offer Accepted Assignment Id */
  assignmentId?: string;

  /** Router Worker Offer Accepted Job Priority */
  jobPriority?: int32;

  /** Router Worker Offer Accepted Worker Labels */
  workerLabels: Record<string>;

  /** Router Worker Offer Accepted Worker Tags */
  workerTags: Record<string>;

  /** Router Worker Offer Accepted Job Labels */
  jobLabels: Record<string>;

  /** Router Worker Offer Accepted Job Tags */
  jobTags: Record<string>;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterWorkerOfferDeclined event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@example(MicrosoftCommunicationRouterWorkerOfferDeclinedExample)
model AcsRouterWorkerOfferDeclinedEventData extends AcsRouterWorkerEventData {
  /** Router Worker Offer Declined Queue Id */
  queueId?: string;

  /** Router Worker Offer Declined Offer Id */
  offerId?: string;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterWorkerOfferExpired event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@example(MicrosoftCommunicationRouterWorkerOfferExpiredExample)
model AcsRouterWorkerOfferExpiredEventData extends AcsRouterWorkerEventData {
  /** Router Worker Offer Expired Queue Id */
  queueId?: string;

  /** Router Worker Offer Expired Offer Id */
  offerId?: string;
}

// @example(MicrosoftCommunicationRouterWorkerOfferIssuedExample)
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterWorkerOfferIssued event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsRouterWorkerOfferIssuedEventData extends AcsRouterWorkerEventData {
  /** Router Worker Offer Issued Queue Id */
  queueId?: string;

  /** Router Worker Offer Issued Offer Id */
  offerId?: string;

  /** Router Worker Offer Issued Job Priority */
  jobPriority?: int32;

  /** Router Worker Offer Issued Worker Labels */
  workerLabels: Record<string>;

  /** Router Worker Offer Issued Time in UTC */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  @madeRequired(ServiceApiVersions.v2024_01_01)
  offeredOn: utcDateTime;

  /** Router Worker Offer Issued Expiration Time in UTC */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  @madeRequired(ServiceApiVersions.v2024_01_01)
  expiresOn: utcDateTime;

  /** Router Worker Offer Issued Worker Tags */
  workerTags: Record<string>;

  /** Router Worker Offer Issued Job Labels */
  jobLabels: Record<string>;

  /** Router Worker Offer Issued Job Tags */
  jobTags: Record<string>;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterWorkerOfferRevoked event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@example(MicrosoftCommunicationRouterWorkerOfferRevokedExample)
model AcsRouterWorkerOfferRevokedEventData extends AcsRouterWorkerEventData {
  /** Router Worker Offer Revoked Queue Id */
  queueId?: string;

  /** Router Worker Offer Revoked Offer Id */
  offerId?: string;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterWorkerRegistered event */
@example(MicrosoftCommunicationRouterWorkerRegisteredExample)
model AcsRouterWorkerRegisteredEventData {
  /** Router Worker Registered Worker Id */
  workerId?: string;

  /** Router Worker Registered Queue Info */
  @visibility(Lifecycle.Read)
  queueAssignments: AcsRouterQueueDetails[];

  /** Router Worker Registered Channel Configuration */
  @visibility(Lifecycle.Read)
  channelConfigurations: AcsRouterChannelConfiguration[];

  /** Router Worker Register Total Capacity */
  totalCapacity?: int32;

  /** Router Worker Registered Labels */
  labels: Record<string>;

  /** Router Worker Registered Tags */
  tags: Record<string>;
}

// Base Properties
/** Schema of common properties of all Router Job events */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsRouterJobEventData extends AcsRouterEventData {
  /** Router Job events Queue Id */
  queueId?: string;

  /** Router Job events Labels */
  labels: Record<string>;

  /** Router Jobs events Tags */
  tags: Record<string>;
}

/** Schema of common properties of all Router Worker events */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsRouterWorkerEventData extends AcsRouterEventData {
  /** Router Worker events Worker Id */
  workerId?: string;
}

/** Schema of common properties of all Router events */
model AcsRouterEventData {
  /** Router Event Job ID */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  jobId: string;

  /** Router Event Channel Reference */
  channelReference?: string;

  /** Router Event Channel ID */
  channelId?: string;
}

/** Router Channel Configuration */
model AcsRouterChannelConfiguration {
  /** Channel ID for Router Job */
  channelId?: string;

  /** Capacity Cost Per Job for Router Job */
  capacityCostPerJob?: int32;

  /** Max Number of Jobs for Router Job */
  maxNumberOfJobs?: int32;
}

/** Router Queue Details */
model AcsRouterQueueDetails {
  /** Router Queue Id */
  id?: string;

  /** Router Queue Name */
  name?: string;

  /** Router Queue Labels */
  labels: Record<string>;
}

/** Router Communication Error */
model AcsRouterCommunicationError {
  /** Router Communication Error Code */
  code?: string;

  /** Router Communication Error Message */
  message?: string;

  /** Router Communication Error Target */
  target?: string;

  /** Router Communication Inner Error */
  innererror: AcsRouterCommunicationError;

  /** List of Router Communication Errors */
  @visibility(Lifecycle.Read)
  details: AcsRouterCommunicationError[];
}

/** Router Job Worker Selector */
model AcsRouterWorkerSelector {
  /** Router Job Worker Selector Key */
  key?: string;

  /** Router Job Worker Selector Label Operator */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  labelOperator: AcsRouterLabelOperator;

  /** Router Job Worker Selector Value */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "The type of labelValue is object"
  value: unknown;

  /** Router Job Worker Selector Time to Live in Seconds */
  ttlSeconds: float64;

  /** Router Job Worker Selector State */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  state: AcsRouterWorkerSelectorState;

  /** Router Job Worker Selector Expiration Time */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  expirationTime: utcDateTime;
}

alias AcsChatMessageBaseEventData = {
  /** The body of the chat message */
  messageBody: string;

  /** The chat message metadata */
  metadata?: Record<string>;
};

alias AcsChatThreadBaseEventData = {
  /** The communication identifier of the user who created the thread */
  createdByCommunicationIdentifier: CommunicationIdentifierModel;

  /** The thread properties */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "The type of properties is object with additionalProperties: object"
  properties: Record<unknown>;

  /** The thread metadata */
  metadata?: Record<string>;

  /** The list of properties of participants who are part of the thread */
  @visibility(Lifecycle.Read)
  participants: AcsChatThreadParticipantProperties[];
};

alias AcsChatThreadDeletedBaseEventData = {
  /** The communication identifier of the user who deleted the thread */
  deletedByCommunicationIdentifier: CommunicationIdentifierModel;

  /** The deletion time of the thread */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  deleteTime: utcDateTime;
};

alias AcsChatThreadPropertiesBaseEventData = {
  /** The communication identifier of the user who updated the thread properties */
  editedByCommunicationIdentifier: CommunicationIdentifierModel;

  /** The time at which the properties of the thread were updated */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  editTime: utcDateTime;

  /** The updated thread properties */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "The type of properties is object with additionalProperties: object"
  properties: Record<unknown>;

  /** The thread metadata */
  metadata: Record<string>;
};

alias AcsChatParticipantBaseEventData = {
  /** The time at which the user was added to the thread */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  time: utcDateTime;

  /** The communication identifier of the user who added the user */
  addedByCommunicationIdentifier: CommunicationIdentifierModel;

  /** The details of the user who was added */
  participantAdded: AcsChatThreadParticipantProperties;
};

/** Recording content type */
union recordingContentType {
  /** AudioVideo content type */
  "AudioVideo",

  /** Audio content type */
  "Audio",

  string,
}

/** Recording channel type */
union recordingChannelType {
  /** Mixed channel type */
  "Mixed",

  /** Unmixed channel type */
  "Unmixed",

  string,
}

/** Recording format type */
union recordingFormatType {
  /** WAV format */
  "Wav",

  /** MP3 format */
  "Mp3",

  /** MP4 format */
  "Mp4",

  string,
}

/** Router Job Worker Selector Label Operator */
union AcsRouterLabelOperator {
  /** Router Label Operator Equal */
  "Equal",

  /** Router Label Operator Not Equal */
  "NotEqual",

  /** Router Label Operator Greater */
  "Greater",

  /** Router Label Operator Less */
  "Less",

  /** Router Label Operator Greater than or equal */
  "GreaterThanOrEqual",

  /** Router Label Operator Less than or equal */
  "LessThanOrEqual",

  string,
}

/** Router Worker Selector State */
union AcsRouterWorkerSelectorState {
  /** Router Worker Selector State Active */
  Active: "active",

  /** Router Worker Selector State Expired */
  Expired: "expired",

  string,
}

/** The status of the email. Any value other than Delivered is considered failed. */
union AcsEmailDeliveryReportStatus {
  /** Hard bounce detected while sending the email */
  "Bounced",

  /** The email was delivered */
  "Delivered",

  /** The email failed to be delivered */
  "Failed",

  /** The message was identified as spam and was rejected or blocked (not quarantined). */
  "FilteredSpam",

  /** The message was quarantined (as spam, bulk mail, or phishing). For more information, see Quarantined email messages in EOP (EXCHANGE ONLINE PROTECTION). */
  "Quarantined",

  /** The email was suppressed */
  "Suppressed",

  string,
}

/** Detailed information about the status if any */
model AcsEmailDeliveryReportStatusDetails {
  /** Detailed status message */
  statusMessage?: string;

  /** Recipient mail server host name */
  recipientMailServerHostName?: string;
}

/** Schema of common properties of all chat thread events */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatThreadEventBaseProperties extends AcsChatEventBaseProperties {
  /** The original creation time of the thread */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  createTime: utcDateTime;

  /** The version of the thread */
  version?: int64;
}

/** Schema of common properties of all chat thread events */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatThreadEventInThreadBaseProperties
  extends AcsChatEventInThreadBaseProperties {
  /** The original creation time of the thread */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  createTime: utcDateTime;

  /** The version of the thread */
  version?: int64;
}

/** Schema of common properties of all chat message events */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatMessageEventBaseProperties extends AcsChatEventBaseProperties {
  /** The chat message id */
  messageId: string;

  /** The communication identifier of the sender */
  senderCommunicationIdentifier: CommunicationIdentifierModel;

  /** The display name of the sender */
  senderDisplayName?: string;

  /** The original compose time of the message */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  composeTime: utcDateTime;

  /** The type of the message */
  type: string;

  /** The version of the message */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  version: int64;
}

/** Schema of common properties of all participant events */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsCallParticipantEventData extends AcsCallingEventProperties {
  /** The user of the call participant */
  user?: AcsCallParticipantProperties;

  /** The display name of the participant. */
  displayName?: string;

  /** The id of the participant. */
  participantId?: string;

  /** The user agent of the participant. */
  userAgent?: string;
}

/** Schema of common properties of all participant event user */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsCallParticipantProperties {
  /** The communication identifier of the participant user */
  communicationIdentifier?: CommunicationIdentifierModel;

  /** The role of the participant */
  role?: AcsCallParticipantKind;
}

/** Schema of common properties of all calling events */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsCallingEventProperties {
  /** The call participant who initiated the call. */
  startedBy: AcsCallParticipantProperties;

  /** The call id of the server */
  serverCallId: string;

  /** The group metadata */
  group?: AcsCallGroupProperties;

  /** The room metadata */
  room?: AcsCallRoomProperties;

  /** Is two-party in calling event. */
  isTwoParty?: boolean;

  /** The correlationId of calling event */
  correlationId: string;

  /** Is the calling event a room call. */
  isRoomsCall?: boolean;
}

/** Schema of calling event group properties */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsCallGroupProperties {
  /** Group Id. */
  id?: string;
}

/** Schema of calling event room properties */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsCallRoomProperties {
  /** Room Id. */
  id?: string;
}

/** Schema of calling event ended by properties */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsCallEndedByProperties {
  /** The communication identifier of the call ended by */
  communicationIdentifier: CommunicationIdentifierModel;

  /** The type of call ended by. */
  type: AcsCallEndedByKind;

  /** The name of the call ended by. */
  name: string;
}

/** Schema of calling event reason properties */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsCallEndReasonProperties {
  /** Reason code for ending the call. */
  code?: int32;

  /** Reason subcode for ending the call. */
  subCode?: int32;

  /** Reason for the ending the call. */
  phrase?: string;
}

/** Schema of common properties of all thread-level chat message events */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatMessageEventInThreadBaseProperties
  extends AcsChatEventInThreadBaseProperties {
  /** The chat message id */
  messageId: string;

  /** The communication identifier of the sender */
  senderCommunicationIdentifier: CommunicationIdentifierModel;

  /** The display name of the sender */
  senderDisplayName?: string;

  /** The original compose time of the message */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  composeTime: utcDateTime;

  /** The type of the message */
  type: string;

  /** The version of the message */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  version: int64;
}

/** Schema of common properties of all thread-level chat events */
model AcsChatEventInThreadBaseProperties {
  /** The transaction id will be used as co-relation vector */
  transactionId?: string;

  /** The chat thread id */
  threadId: string;
}

/** Schema of common properties of all chat events */
model AcsChatEventBaseProperties {
  /** The communication identifier of the target user */
  recipientCommunicationIdentifier: CommunicationIdentifierModel;

  ...AcsChatEventInThreadBaseProperties;
}

/** Schema of the chat thread participant */
model AcsChatThreadParticipantProperties {
  /** The name of the user */
  displayName?: string;

  /** The communication identifier of the user */
  participantCommunicationIdentifier: CommunicationIdentifierModel;

  /** The metadata of the user */
  metadata?: Record<string>;
}

/** Schema of common properties of all SMS events */
model AcsSmsEventBaseProperties {
  /** The identity of the SMS message */
  messageId: string;

  /** The identity of SMS message sender */
  from: string;

  /** The identity of SMS message receiver */
  to: string;
}

/** Schema for details of a delivery attempt */
model AcsSmsDeliveryAttemptProperties {
  /** TimeStamp when delivery was attempted */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  timestamp: utcDateTime;

  /** Number of segments that were successfully delivered */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  segmentsSucceeded: int32;

  /** Number of segments whose delivery failed */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  segmentsFailed: int32;
}

/** Schema for all properties of Recording Storage Information. */
model AcsRecordingStorageInfoProperties {
  /** List of details of recording chunks information */
  @visibility(Lifecycle.Read)
  recordingChunks: AcsRecordingChunkInfoProperties[];
}

/** Schema for all properties of  Recording Chunk Information. */
model AcsRecordingChunkInfoProperties {
  /** The documentId of the recording chunk */
  documentId?: string;

  /** The index of the recording chunk */
  index?: int64;

  /** The reason for ending the recording chunk */
  endReason?: string;

  /** The location of the metadata for this chunk */
  metadataLocation?: string;

  /** The location of the content for this chunk */
  contentLocation?: string;

  /** The location to delete all chunk storage */
  deleteLocation?: string;
}

/** Custom Context of Incoming Call */
model AcsIncomingCallCustomContext {
  /** Sip Headers for incoming call */
  sipHeaders: Record<string>;

  /** Voip Headers for incoming call */
  voipHeaders: Record<string>;
}

/** The type of engagement user have with email. */
union AcsUserEngagement {
  /** View */
  "view",

  /** Click */
  "click",

  string,
}

/** Identifies a participant in Azure Communication services. A participant is, for example, a phone number or an Azure communication user. This model must be interpreted as a union: Apart from rawId, at most one further property may be set. */
model CommunicationIdentifierModel {
  /** The identifier kind. Only required in responses. */
  kind?: CommunicationIdentifierModelKind;

  /** Raw Id of the identifier. Optional in requests, required in responses. */
  rawId: string;

  /** The communication user. */
  communicationUser: CommunicationUserIdentifierModel;

  /** The phone number. */
  phoneNumber?: PhoneNumberIdentifierModel;

  /** The Microsoft Teams user. */
  microsoftTeamsUser?: MicrosoftTeamsUserIdentifierModel;

  /** The Microsoft Teams application. */
  microsoftTeamsApp?: MicrosoftTeamsAppIdentifierModel;
}

/** Communication model identifier kind */
union CommunicationIdentifierModelKind {
  /** Unknown */
  "unknown",

  /** Communication User */
  "communicationUser",

  /** Phone Number */
  "phoneNumber",

  /** Microsoft Teams User */
  "microsoftTeamsUser",

  string,
}

/** A Microsoft Teams application. */
model MicrosoftTeamsAppIdentifierModel {
  /** The Id of the Microsoft Teams application */
  appId: string;

  /** The cloud that the Microsoft Teams application belongs to. By default 'public' if missing. */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  cloud: CommunicationCloudEnvironmentModel;
}

/** A Microsoft Teams user. */
model MicrosoftTeamsUserIdentifierModel {
  /** The Id of the Microsoft Teams user. If not anonymous, this is the AAD object Id of the user. */
  userId: string;

  /** True if the Microsoft Teams user is anonymous. By default false if missing. */
  isAnonymous?: boolean;

  /** The cloud that the Microsoft Teams user belongs to. By default 'public' if missing. */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  cloud: CommunicationCloudEnvironmentModel;
}

/** A phone number. */
model PhoneNumberIdentifierModel {
  /** The phone number in E.164 format. */
  value: string;
}

/** A user that got created with an Azure Communication Services resource. */
model CommunicationUserIdentifierModel {
  /** The Id of the communication user. */
  id: string;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterWorkerUpdated event. */
@example(MicrosoftCommunicationRouterWorkerUpdatedExample)
model AcsRouterWorkerUpdatedEventData {
  /** Router Worker Updated Worker Id */
  workerId?: string;

  /** Router Worker Updated Queue Info */
  @visibility(Lifecycle.Read)
  queueAssignments: AcsRouterQueueDetails[];

  /** Router Worker Updated Channel Configuration */
  @visibility(Lifecycle.Read)
  channelConfigurations: AcsRouterChannelConfiguration[];

  /** Router Worker Updated Total Capacity */
  totalCapacity?: int32;

  /** Router Worker Updated Labels */
  labels: Record<string>;

  /** Router Worker Updated Tags */
  tags: Record<string>;

  /** Router Worker Properties Updated */
  @visibility(Lifecycle.Read)
  updatedWorkerProperties: AcsRouterUpdatedWorkerProperty[];
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.AdvancedMessageDeliveryStatusUpdated event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@example(MicrosoftCommunicationAdvancedMessageDeliveryStatusUpdatedExample)
model AcsMessageDeliveryStatusUpdatedEventData extends AcsMessageEventData {
  /** The message id */
  messageId?: string;

  /** The updated message status */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  status: AcsMessageDeliveryStatus;

  /** The updated message channel type */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  channelType: AcsMessageChannelKind;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.AdvancedMessageReceived event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@example(MicrosoftCommunicationAdvancedMessageReceivedExample)
model AcsMessageReceivedEventData extends AcsMessageEventData {
  /** Optional. The message content */
  content?: string;

  /** Optional. Message ID. Format is Guid as string. */
  messageId?: string;

  /** Required. The message channel type */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  channelType: AcsMessageChannelKind;

  /** Required. Whatsapp message type */
  messageType: string;

  /** Optional. The received message media content */
  media?: AcsMessageMediaContent;

  /** Optional. The received message reaction content */
  reaction?: AcsMessageReactionContent;

  /** Optional. The received message context */
  context?: AcsMessageContext;

  /** Optional. The received message button content */
  button?: AcsMessageButtonContent;

  /** Optional. The received message interactive content */
  interactive?: AcsMessageInteractiveContent;
}

/** Message Media Content */
model AcsMessageMediaContent {
  /** Required. The MIME type of the file this media represents */
  mimeType: string;

  /** Required. The media identifier */
  id: string;

  /** Optional. The filename of the underlying media file as specified when uploaded */
  fileName?: string;

  /** Optional. The caption for the media object, if supported and provided */
  caption?: string;

  /** Optional. Set to true if the sticker is animated; false otherwise. */
  animated?: boolean;
}

/** Message Reaction Content */
model AcsMessageReactionContent {
  /** Required. WhatsApp message ID of the message that the emoji is applied to */
  messageId: string;

  /** Optional. Unicode escape sequence of the emoji. */
  emoji?: string;
}

/** Message Context */
model AcsMessageContext {
  /** The WhatsApp ID for the customer who replied to an inbound message. */
  from?: string;

  /** The message ID for the sent message for an inbound reply */
  id?: string;
}

/** Message Button Content */
model AcsMessageButtonContent {
  /** The Text of the button */
  text?: string;

  /** The Payload of the button which was clicked by the user, setup by the business */
  payload?: string;
}

/** Message Interactive Content */
model AcsMessageInteractiveContent {
  /** The Message interactive reply type */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  type: AcsInteractiveReplyKind;

  /** The Message Sent when a customer clicks a button */
  buttonReply?: AcsMessageInteractiveButtonReplyContent;

  /** The Message Sent when a customer selects an item from a list */
  listReply?: AcsMessageInteractiveListReplyContent;
}

/** Message Interactive button reply content for a user to business message */
model AcsMessageInteractiveButtonReplyContent {
  /** The ID of the button */
  id?: string;

  /** The title of the button */
  title?: string;
}

/** Message Interactive list reply content for a user to business message */
model AcsMessageInteractiveListReplyContent {
  /** The ID of the selected list item */
  id?: string;

  /** The title of the selected list item */
  title?: string;

  /** The description of the selected row */
  description?: string;
}

/** Schema of common properties of all chat thread events */
model AcsMessageEventData {
  /** The message sender */
  from: string;

  /** The message recipient */
  to: string;

  /** The time message was received */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  receivedTimeStamp: utcDateTime;

  /** The channel event error */
  error?: AcsMessageChannelEventError;
}

/** Message Channel Event Error */
model AcsMessageChannelEventError {
  /** The channel error code */
  channelCode?: string;

  /** The channel error message */
  channelMessage?: string;
}

/** Interactive reply kind */
union AcsInteractiveReplyKind {
  /** Messaged interactive reply type is ButtonReply */
  "buttonReply",

  /** Messaged interactive reply type is ListReply */
  "listReply",

  /** Messaged interactive reply type is Unknown */
  "unknown",

  string,
}

/** Message channel kind */
union AcsMessageChannelKind {
  /** Updated message channel type is WhatsApp */
  "whatsapp",

  string,
}

/** Message delivery status */
union AcsMessageDeliveryStatus {
  /** Read */
  "read",

  /** Delivered */
  "delivered",

  /** Failed */
  "failed",

  /** Sent */
  "sent",

  /** Warning */
  "warning",

  /** Unknown */
  "unknown",

  string,
}

/** Worker properties that can be updated */
union AcsRouterUpdatedWorkerProperty {
  /** AvailableForOffers */
  "AvailableForOffers",

  /** TotalCapacity */
  "TotalCapacity",

  /** QueueAssignments */
  "QueueAssignments",

  /** Labels */
  "Labels",

  /** Tags */
  "Tags",

  /** ChannelConfigurations */
  "ChannelConfigurations",

  string,
}

/** Call ended participant kind. */
union AcsCallEndedByKind {
  /** Participant */
  "Participant",

  /** MicrosoftInternal */
  "MicrosoftInternal",

  string,
}

/** Call participant kind. */
union AcsCallParticipantKind {
  /** Attendee */
  "Attendee",

  /** Presenter */
  "Presenter",

  /** Organizer */
  "Organizer",

  /** Consumer */
  "Consumer",

  /** Collaborator */
  "Collaborator",

  string,
}

/** Communication cloud environment model. */
union CommunicationCloudEnvironmentModel {
  /** Public */
  "public",

  /** Dod */
  "dod",

  /** Gcch */
  "gcch",

  string,
}
