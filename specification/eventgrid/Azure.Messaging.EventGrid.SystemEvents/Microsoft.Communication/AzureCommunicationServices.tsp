/** Describes the schema of the Azure Communication Services events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent. */
namespace Microsoft.EventGrid.SystemEvents;

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

  /** CorrelationId (CallId). */
  correlationId?: string;
}

/** Schema of the Data property of an EventGridEvent for an Microsoft.Communication.UserDisconnected event. */
model AcsUserDisconnectedEventData {
  /** The communication identifier of the user who was disconnected */
  userCommunicationIdentifier: CommunicationIdentifierModel;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatMessageReceived event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatMessageReceivedEventData
  extends AcsChatMessageEventBaseProperties {
  ...AcsChatMessageBaseEventData;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatMessageReceivedInThread event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatMessageReceivedInThreadEventData
  extends AcsChatMessageEventInThreadBaseProperties {
  ...AcsChatMessageBaseEventData;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatMessageEdited event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatMessageEditedEventData extends AcsChatMessageEventBaseProperties {
  ...AcsChatMessageBaseEventData;

  /** The time at which the message was edited */
  editTime: utcDateTime;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatMessageEditedInThread event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatMessageEditedInThreadEventData
  extends AcsChatMessageEventInThreadBaseProperties {
  ...AcsChatMessageBaseEventData;

  /** The time at which the message was edited */
  editTime: utcDateTime;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatMessageDeleted event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatMessageDeletedEventData extends AcsChatMessageEventBaseProperties {
  /** The time at which the message was deleted */
  deleteTime: utcDateTime;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatMessageDeletedInThread event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatMessageDeletedInThreadEventData
  extends AcsChatMessageEventInThreadBaseProperties {
  /** The time at which the message was deleted */
  deleteTime: utcDateTime;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatThreadCreatedWithUser event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatThreadCreatedWithUserEventData
  extends AcsChatThreadEventBaseProperties {
  ...AcsChatThreadBaseEventData;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatThreadCreated event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatThreadCreatedEventData
  extends AcsChatThreadEventInThreadBaseProperties {
  ...AcsChatThreadBaseEventData;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatThreadWithUserDeleted event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatThreadWithUserDeletedEventData
  extends AcsChatThreadEventBaseProperties {
  ...AcsChatThreadDeletedBaseEventData;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatThreadDeleted event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatThreadDeletedEventData
  extends AcsChatThreadEventInThreadBaseProperties {
  ...AcsChatThreadDeletedBaseEventData;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatThreadPropertiesUpdatedPerUser event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatThreadPropertiesUpdatedPerUserEventData
  extends AcsChatThreadEventBaseProperties {
  /** The communication identifier of the user who updated the thread properties */
  editedByCommunicationIdentifier: CommunicationIdentifierModel;

  /** The time at which the properties of the thread were updated */
  editTime: utcDateTime;

  /** The thread metadata */
  metadata: Record<string>;

  /** The updated thread properties */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "The type of properties is object with additionalProperties: object"
  properties: Record<unknown>;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatThreadPropertiesUpdated event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatThreadPropertiesUpdatedEventData
  extends AcsChatThreadEventInThreadBaseProperties {
  ...AcsChatThreadPropertiesBaseEventData;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatParticipantAddedToThreadWithUser event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatParticipantAddedToThreadWithUserEventData
  extends AcsChatThreadEventBaseProperties {
  ...AcsChatParticipantBaseEventData;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatParticipantRemovedFromThreadWithUser event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatParticipantRemovedFromThreadWithUserEventData
  extends AcsChatThreadEventBaseProperties {
  /** The time at which the user was removed to the thread */
  time: utcDateTime;

  /** The communication identifier of the user who removed the user */
  removedByCommunicationIdentifier: CommunicationIdentifierModel;

  /** The details of the user who was removed */
  participantRemoved: AcsChatThreadParticipantProperties;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatThreadParticipantAdded event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatParticipantAddedToThreadEventData
  extends AcsChatEventInThreadBaseProperties {
  ...AcsChatParticipantBaseEventData;

  /** The version of the thread */
  version?: int64;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatThreadParticipantRemoved event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatParticipantRemovedFromThreadEventData
  extends AcsChatEventInThreadBaseProperties {
  /** The time at which the user was removed to the thread */
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
model AcsSmsDeliveryReportReceivedEventData extends AcsSmsEventBaseProperties {
  /** Status of Delivery */
  deliveryStatus?: string;

  /** Details about Delivery Status */
  deliveryStatusDetails?: string;

  /** List of details of delivery attempts made */
  deliveryAttempts: AcsSmsDeliveryAttemptProperties[];

  /** The time at which the SMS delivery report was received */
  receivedTimestamp: utcDateTime;

  /** Customer Content */
  tag?: string;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.SMSReceived event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsSmsReceivedEventData extends AcsSmsEventBaseProperties {
  /** The SMS content */
  message?: string;

  /** The time at which the SMS was received */
  receivedTimestamp: utcDateTime;
}

//TODO: This might need some fixing
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RecordingFileStatusUpdated event. */
model AcsRecordingFileStatusUpdatedEventData {
  /** The details of recording storage information */
  recordingStorageInfo: AcsRecordingStorageInfoProperties;

  /** The time at which the recording started */
  recordingStartTime: utcDateTime;

  /** The recording duration in milliseconds */
  recordingDurationMs?: int64;

  /** The recording content type- AudioVideo, or Audio */
  recordingContentType: recordingContentType;

  /** The recording  channel type - Mixed, Unmixed */
  recordingChannelType: recordingChannelType;

  /** The recording format type - Mp4, Mp3, Wav */
  recordingFormatType: recordingFormatType;

  /** The reason for ending recording session */
  sessionEndReason?: string;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.EmailDeliveryReportReceived event. */
model AcsEmailDeliveryReportReceivedEventData {
  /** The Sender Email Address */
  sender?: string;

  /** The recipient Email Address */
  recipient?: string;

  /** The Id of the email been sent */
  messageId?: string;

  /** The status of the email. Any value other than Delivered is considered failed. */
  status: AcsEmailDeliveryReportStatus;

  /** Detailed information about the status if any */
  deliveryStatusDetails: AcsEmailDeliveryReportStatusDetails;

  /** The time at which the email delivery report received timestamp */
  deliveryAttemptTimeStamp: utcDateTime;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.EmailEngagementTrackingReportReceived event. */
model AcsEmailEngagementTrackingReportReceivedEventData {
  /** The Sender Email Address */
  sender?: string;

  /** The Recipient Email Address */
  recipient?: string;

  /** The Id of the email that has been sent */
  messageId?: string;

  /** The time at which the user interacted with the email */
  userActionTimeStamp: utcDateTime;

  /** The context of the type of engagement user had with email */
  engagementContext?: string;

  /** The user agent interacting with the email */
  userAgent?: string;

  /** The type of engagement user have with email */
  engagementType: AcsUserEngagement;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterJobCancelled event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsRouterJobCancelledEventData extends AcsRouterJobEventData {
  /** Router Job Note */
  note?: string;

  /** Router Job Disposition Code */
  dispositionCode?: string;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterJobClassificationFailed event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsRouterJobClassificationFailedEventData extends AcsRouterJobEventData {
  /** Router Job Classification Policy Id */
  classificationPolicyId?: string;

  /** Router Job Classification Failed Errors */
  errors: AcsRouterCommunicationError[];
}

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
  attachedWorkerSelectors: AcsRouterWorkerSelector[];
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterJobClosed event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
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
model AcsRouterJobCompletedEventData extends AcsRouterJobEventData {
  /** Router Job Completed Assignment Id */
  assignmentId?: string;

  /** Router Job Completed Worker Id */
  workerId?: string;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterJobDeleted event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsRouterJobDeletedEventData extends AcsRouterJobEventData {}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterJobExceptionTriggered event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsRouterJobExceptionTriggeredEventData extends AcsRouterJobEventData {
  /** Router Job Exception Triggered Rule Key */
  ruleKey?: string;

  /** Router Job Exception Triggered Rule Id */
  exceptionRuleId?: string;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterJobQueued event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsRouterJobQueuedEventData extends AcsRouterJobEventData {
  /** Router Job Priority */
  priority?: int32;

  /** Router Job Queued Attached Worker Selector */
  attachedWorkerSelectors: AcsRouterWorkerSelector[];

  /** Router Job Queued Requested Worker Selector */
  requestedWorkerSelectors: AcsRouterWorkerSelector[];
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterJobReceived event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsRouterJobReceivedEventData extends AcsRouterJobEventData {
  /** Router Job Received Job Status */
  jobStatus: AcsRouterJobStatus;

  /** Router Job Classification Policy Id */
  classificationPolicyId?: string;

  /** Router Job Priority */
  priority?: int32;

  /** Router Job Received Requested Worker Selectors */
  requestedWorkerSelectors: AcsRouterWorkerSelector[];

  /** Router Job Received Scheduled Time in UTC */
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

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterJobSchedulingFailed event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsRouterJobSchedulingFailedEventData extends AcsRouterJobEventData {
  /** Router Job Priority */
  priority?: int32;

  /** Router Job Scheduling Failed Attached Worker Selector Expired */
  expiredAttachedWorkerSelectors: AcsRouterWorkerSelector[];

  /** Router Job Scheduling Failed Requested Worker Selector Expired */
  expiredRequestedWorkerSelectors: AcsRouterWorkerSelector[];

  /** Router Job Scheduling Failed Scheduled Time in UTC */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  scheduledOn: utcDateTime;

  /** Router Job Scheduling Failed Reason */
  failureReason?: string;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterJobUnassigned event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsRouterJobUnassignedEventData extends AcsRouterJobEventData {
  /** Router Job Unassigned Assignment Id */
  assignmentId?: string;

  /** Router Job Unassigned Worker Id */
  workerId?: string;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterJobWaitingForActivation event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsRouterJobWaitingForActivationEventData extends AcsRouterJobEventData {
  /** Router Job Waiting For Activation Priority */
  priority?: int32;

  /** Router Job Waiting For Activation Worker Selector Expired */
  expiredAttachedWorkerSelectors: AcsRouterWorkerSelector[];

  /** Router Job Waiting For Activation Requested Worker Selector Expired */
  expiredRequestedWorkerSelectors: AcsRouterWorkerSelector[];

  /** Router Job Waiting For Activation Scheduled Time in UTC */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  scheduledOn: utcDateTime;

  /** Router Job Waiting For Activation Unavailable For Matching */
  unavailableForMatching: boolean;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterJobWorkerSelectorsExpired event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsRouterJobWorkerSelectorsExpiredEventData
  extends AcsRouterJobEventData {
  /** Router Job Worker Selectors Expired Requested Worker Selectors */
  expiredRequestedWorkerSelectors: AcsRouterWorkerSelector[];

  /** Router Job Worker Selectors Expired Attached Worker Selectors */
  expiredAttachedWorkerSelectors: AcsRouterWorkerSelector[];
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterWorkerDeleted event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsRouterWorkerDeletedEventData extends AcsRouterWorkerEventData {}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterWorkerDeregistered event */
model AcsRouterWorkerDeregisteredEventData {
  /** Router Worker Deregistered Worker Id */
  workerId?: string;
}

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
model AcsRouterWorkerOfferDeclinedEventData extends AcsRouterWorkerEventData {
  /** Router Worker Offer Declined Queue Id */
  queueId?: string;

  /** Router Worker Offer Declined Offer Id */
  offerId?: string;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterWorkerOfferExpired event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsRouterWorkerOfferExpiredEventData extends AcsRouterWorkerEventData {
  /** Router Worker Offer Expired Queue Id */
  queueId?: string;

  /** Router Worker Offer Expired Offer Id */
  offerId?: string;
}

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
  offeredOn: utcDateTime;

  /** Router Worker Offer Issued Expiration Time in UTC */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
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
model AcsRouterWorkerOfferRevokedEventData extends AcsRouterWorkerEventData {
  /** Router Worker Offer Revoked Queue Id */
  queueId?: string;

  /** Router Worker Offer Revoked Offer Id */
  offerId?: string;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterWorkerRegistered event */
model AcsRouterWorkerRegisteredEventData {
  /** Router Worker Registered Worker Id */
  workerId?: string;

  /** Router Worker Registered Queue Info */
  queueAssignments: AcsRouterQueueDetails[];

  /** Router Worker Registered Channel Configuration */
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
  jobId?: string;

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
  details: AcsRouterCommunicationError[];
}

/** Router Job Worker Selector */
model AcsRouterWorkerSelector {
  /** Router Job Worker Selector Key */
  key?: string;

  /** Router Job Worker Selector Label Operator */
  operator: AcsRouterLabelOperator;

  /** Router Job Worker Selector Value */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "The type of labelValue is object"
  labelValue: unknown;

  /** Router Job Worker Selector Time to Live in Seconds */
  @encode("ISO8601") // TODO verify this is timespan in C#
  ttlSeconds: duration;

  /** Router Job Worker Selector State */
  selectorState: AcsRouterWorkerSelectorState;

  /** Router Job Worker Selector Expiration Time */
  expirationTime: utcDateTime;
}

alias AcsChatMessageBaseEventData = {
  /** The body of the chat message */
  messageBody?: string;

  /** The chat message metadata */
  metadata: Record<string>;
};

alias AcsChatThreadBaseEventData = {
  /** The communication identifier of the user who created the thread */
  createdByCommunicationIdentifier: CommunicationIdentifierModel;

  /** The thread properties */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "The type of properties is object with additionalProperties: object"
  properties: Record<unknown>;

  /** The thread metadata */
  metadata: Record<string>;

  /** The list of properties of participants who are part of the thread */
  participants: AcsChatThreadParticipantProperties[];
};

alias AcsChatThreadDeletedBaseEventData = {
  /** The communication identifier of the user who deleted the thread */
  deletedByCommunicationIdentifier: CommunicationIdentifierModel;

  /** The deletion time of the thread */
  deleteTime: utcDateTime;
};

alias AcsChatThreadPropertiesBaseEventData = {
  /** The communication identifier of the user who updated the thread properties */
  editedByCommunicationIdentifier: CommunicationIdentifierModel;

  /** The time at which the properties of the thread were updated */
  editTime: utcDateTime;

  /** The updated thread properties */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "The type of properties is object with additionalProperties: object"
  properties: Record<unknown>;

  /** The thread metadata */
  metadata: Record<string>;
};

alias AcsChatParticipantBaseEventData = {
  /** The time at which the user was added to the thread */
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
}

/** Schema of common properties of all chat thread events */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatThreadEventBaseProperties extends AcsChatEventBaseProperties {
  /** The original creation time of the thread */
  createTime: utcDateTime;

  /** The version of the thread */
  version?: int64;
}

/** Schema of common properties of all chat thread events */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatThreadEventInThreadBaseProperties
  extends AcsChatEventInThreadBaseProperties {
  /** The original creation time of the thread */
  createTime: utcDateTime;

  /** The version of the thread */
  version?: int64;
}

/** Schema of common properties of all chat message events */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatMessageEventBaseProperties extends AcsChatEventBaseProperties {
  /** The chat message id */
  messageId?: string;

  /** The communication identifier of the sender */
  senderCommunicationIdentifier: CommunicationIdentifierModel;

  /** The display name of the sender */
  senderDisplayName?: string;

  /** The original compose time of the message */
  composeTime: utcDateTime;

  /** The type of the message */
  type?: string;

  /** The version of the message */
  version?: int64;
}

/** Schema of common properties of all thread-level chat message events */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatMessageEventInThreadBaseProperties
  extends AcsChatEventInThreadBaseProperties {
  /** The chat message id */
  messageId?: string;

  /** The communication identifier of the sender */
  senderCommunicationIdentifier: CommunicationIdentifierModel;

  /** The display name of the sender */
  senderDisplayName?: string;

  /** The original compose time of the message */
  composeTime: utcDateTime;

  /** The type of the message */
  type?: string;

  /** The version of the message */
  version?: int64;
}

/** Schema of common properties of all thread-level chat events */
model AcsChatEventInThreadBaseProperties {
  /** The transaction id will be used as co-relation vector */
  transactionId?: string;

  /** The chat thread id */
  threadId?: string;
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
  metadata: Record<string>;
}

/** Schema of common properties of all SMS events */
model AcsSmsEventBaseProperties {
  /** The identity of the SMS message */
  messageId?: string;

  /** The identity of SMS message sender */
  from?: string;

  /** The identity of SMS message receiver */
  to?: string;
}

/** Schema for details of a delivery attempt */
model AcsSmsDeliveryAttemptProperties {
  /** TimeStamp when delivery was attempted */
  timestamp: utcDateTime;

  /** Number of segments that were successfully delivered */
  segmentsSucceeded?: int32;

  /** Number of segments whose delivery failed */
  segmentsFailed?: int32;
}

/** Schema for all properties of Recording Storage Information. */
model AcsRecordingStorageInfoProperties {
  /** List of details of recording chunks information */
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
  kind: CommunicationIdentifierModelKind;

  /** Raw Id of the identifier. Optional in requests, required in responses. */
  rawId?: string;

  /** The communication user. */
  communicationUser: CommunicationUserIdentifierModel;

  /** The phone number. */
  phoneNumber: PhoneNumberIdentifierModel;

  /** The Microsoft Teams user. */
  microsoftTeamsUser: MicrosoftTeamsUserIdentifierModel;

  /** The Microsoft Teams application. */
  microsoftTeamsApp: MicrosoftTeamsAppIdentifierModel;
}

union CommunicationIdentifierModelKind {
  "unknown",
  "communicationUser",
  "phoneNumber",
  "microsoftTeamsUser",
  string,
}

/** A Microsoft Teams application. */
model MicrosoftTeamsAppIdentifierModel {
  /** The Id of the Microsoft Teams application */
  appId: string;

  /** The cloud that the Microsoft Teams application belongs to. By default 'public' if missing. */
  cloud: CommunicationCloudEnvironmentModel;
}

/** A Microsoft Teams user. */
model MicrosoftTeamsUserIdentifierModel {
  /** The Id of the Microsoft Teams user. If not anonymous, this is the AAD object Id of the user. */
  userId: string;

  /** True if the Microsoft Teams user is anonymous. By default false if missing. */
  isAnonymous?: boolean;

  /** The cloud that the Microsoft Teams user belongs to. By default 'public' if missing. */
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
model AcsRouterWorkerUpdatedEventData {
  /** Router Worker Updated Worker Id */
  workerId?: string;

  /** Router Worker Updated Queue Info */
  queueAssignments: AcsRouterQueueDetails[];

  /** Router Worker Updated Channel Configuration */
  channelConfigurations: AcsRouterChannelConfiguration[];

  /** Router Worker Updated Total Capacity */
  totalCapacity?: int32;

  /** Router Worker Updated Labels */
  labels: Record<string>;

  /** Router Worker Updated Tags */
  tags: Record<string>;

  /** Router Worker Properties Updated */
  updatedWorkerProperties: AcsRouterUpdatedWorkerProperty[];
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.AdvancedMessageDeliveryStatusUpdated event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsMessageDeliveryStatusUpdatedEventData extends AcsMessageEventData {
  /** The message id */
  messageId?: string;

  /** The updated message status */
  status: AcsMessageDeliveryStatus;

  /** The updated message channel type */
  channelType: AcsMessageChannelKind;
}

/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.AdvancedMessageReceived event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsMessageReceivedEventData extends AcsMessageEventData {
  /** The message content */
  content?: string;

  /** The message channel type */
  channelType: AcsMessageChannelKind;

  /** The received message media content */
  media: AcsMessageMediaContent;

  /** The received message context */
  context: AcsMessageContext;

  /** The received message button content */
  button: AcsMessageButtonContent;

  /** The received message interactive content */
  interactive: AcsMessageInteractiveContent;
}

/** Message Media Content */
model AcsMessageMediaContent {
  /** The MIME type of the file this media represents */
  mimeType?: string;

  /** The media identifier */
  id?: string;

  /** The filename of the underlying media file as specified when uploaded */
  filename?: string;

  /** The caption for the media object, if supported and provided */
  caption?: string;
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
  type: AcsInteractiveReplyKind;

  /** The Message Sent when a customer clicks a button */
  buttonReply: AcsMessageInteractiveButtonReplyContent;

  /** The Message Sent when a customer selects an item from a list */
  listReply: AcsMessageInteractiveListReplyContent;
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

  /** The sescription of the selected row */
  description?: string;
}

/** Schema of common properties of all chat thread events */
model AcsMessageEventData {
  /** The message sender */
  from?: string;

  /** The message recipient */
  to?: string;

  /** The time message was received */
  receivedTimeStamp: utcDateTime;

  /** The channel event error */
  error: AcsMessageChannelEventError;
}

/** Message Channel Event Error */
model AcsMessageChannelEventError {
  /** The channel error code */
  channelCode?: string;

  /** The channel error message */
  channelMessage?: string;
}

union AcsInteractiveReplyKind {
  /** Messaged interactive reply type is ButtonReply */
  "buttonReply",

  /** Messaged interactive reply type is ListReply */
  "listReply",

  /** Messaged interactive reply type is Unknown */
  "unknown",

  string,
}

union AcsMessageChannelKind {
  /** Updated message channel type is Whatsapp */
  "whatsapp",

  string,
}

union AcsMessageDeliveryStatus {
  "Read",
  "Delivered",
  "Failed",
  "Sent",
  "Warning",
  "Unknown",
  string,
}

union AcsRouterUpdatedWorkerProperty {
  "AvailableForOffers",
  "TotalCapacity",
  "QueueAssignments",
  "Labels",
  "Tags",
  "ChannelConfigurations",
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
