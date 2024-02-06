@doc("Describes the schema of the Azure Communication Services events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent.")
namespace Microsoft.EventGrid;

@doc("Schema of the Data property of an EventGridEvent for an Microsoft.Communication.IncomingCall event")
model AcsIncomingCallEventData {
  @doc("The communication identifier of the target user.")
  toCommunicationIdentifierModel?: CommunicationIdentifierModel;

  @doc("The communication identifier of the user who initiated the call.")
  fromCommunicationIdentifierModel?: CommunicationIdentifierModel;

  @doc("The Id of the server call")
  serverCallId?: string;

  @doc("Display name of caller.")
  callerDisplayName?: string;

  @doc("Custom Context of Incoming Call")
  customContext?: AcsIncomingCallCustomContext;

  @doc("Signed incoming call context.")
  incomingCallContext?: string;

  @doc("CorrelationId (CallId).")
  correlationId?: string;
}

@doc("Schema of the Data property of an EventGridEvent for an Microsoft.Communication.UserDisconnected event.")
model AcsUserDisconnectedEventData {
  @doc("The communication identifier of the user who was disconnected")
  userCommunicationIdentifier?: CommunicationIdentifierModel;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatMessageReceived event.")
model AcsChatMessageReceivedEventData
  extends AcsChatMessageEventBaseProperties {
  ...AcsChatMessageBaseEventData;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatMessageReceivedInThread event.")
model AcsChatMessageReceivedInThreadEventData
  extends AcsChatMessageEventInThreadBaseProperties {
  ...AcsChatMessageBaseEventData;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatMessageEdited event.")
model AcsChatMessageEditedEventData extends AcsChatMessageEventBaseProperties {
  ...AcsChatMessageBaseEventData;

  @doc("The time at which the message was edited")
  editTime?: utcDateTime;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatMessageEditedInThread event.")
model AcsChatMessageEditedInThreadEventData
  extends AcsChatMessageEventInThreadBaseProperties {
  ...AcsChatMessageBaseEventData;

  @doc("The time at which the message was edited")
  editTime?: utcDateTime;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatMessageDeleted event.")
model AcsChatMessageDeletedEventData extends AcsChatMessageEventBaseProperties {
  @doc("The time at which the message was deleted")
  deleteTime?: utcDateTime;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatMessageDeletedInThread event.")
model AcsChatMessageDeletedInThreadEventData
  extends AcsChatMessageEventInThreadBaseProperties {
  @doc("The time at which the message was deleted")
  deleteTime?: utcDateTime;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatThreadCreatedWithUser event.")
model AcsChatThreadCreatedWithUserEventData
  extends AcsChatThreadEventBaseProperties {
  ...AcsChatThreadBaseEventData;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatThreadCreated event.")
model AcsChatThreadCreatedEventData
  extends AcsChatThreadEventInThreadBaseProperties {
  ...AcsChatThreadBaseEventData;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatThreadWithUserDeleted event.")
model AcsChatThreadWithUserDeletedEventData
  extends AcsChatThreadEventBaseProperties {
  ...AcsChatThreadDeletedBaseEventData;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatThreadDeleted event.")
model AcsChatThreadDeletedEventData
  extends AcsChatThreadEventInThreadBaseProperties {
  ...AcsChatThreadDeletedBaseEventData;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatThreadPropertiesUpdatedPerUser event.")
model AcsChatThreadPropertiesUpdatedPerUserEventData
  extends AcsChatThreadEventBaseProperties {
  ...AcsChatThredPropertiesBaseEventData;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatThreadPropertiesUpdated event.")
model AcsChatThreadPropertiesUpdatedEventData
  extends AcsChatThreadEventInThreadBaseProperties {
  ...AcsChatThredPropertiesBaseEventData;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatParticipantAddedToThreadWithUser event.")
model AcsChatParticipantAddedToThreadWithUserEventData
  extends AcsChatThreadEventBaseProperties {
  ...AcsChatParticipantBaseEventData;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatParticipantRemovedFromThreadWithUser event.")
model AcsChatParticipantRemovedFromThreadWithUserEventData
  extends AcsChatThreadEventBaseProperties {
  @doc("The time at which the user was removed to the thread")
  time?: utcDateTime;

  @doc("The communication identifier of the user who removed the user")
  removedByCommunicationIdentifier?: CommunicationIdentifierModel;

  @doc("The details of the user who was removed")
  participantRemoved?: AcsChatThreadParticipantProperties;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatThreadParticipantAdded event.")
model AcsChatParticipantAddedToThreadEventData
  extends AcsChatEventInThreadBaseProperties {
  ...AcsChatParticipantBaseEventData;

  @doc("The version of the thread")
  version?: int64;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatThreadParticipantRemoved event.")
model AcsChatParticipantRemovedFromThreadEventData
  extends AcsChatEventInThreadBaseProperties {
  @doc("The time at which the user was removed to the thread")
  time?: utcDateTime;

  @doc("The communication identifier of the user who removed the user")
  removedByCommunicationIdentifier?: CommunicationIdentifierModel;

  @doc("The details of the user who was removed")
  participantRemoved?: AcsChatThreadParticipantProperties;

  @doc("The version of the thread")
  version?: int64;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("Schema of the Data property of an EventGridEvent for a Microsoft.Communication.SMSDeliveryReportReceived event.")
model AcsSmsDeliveryReportReceivedEventData extends AcsSmsEventBaseProperties {
  @doc("Status of Delivery")
  deliveryStatus?: string;

  @doc("Details about Delivery Status")
  deliveryStatusDetails?: string;

  @doc("List of details of delivery attempts made")
  deliveryAttempts?: AcsSmsDeliveryAttemptProperties[];

  @doc("The time at which the SMS delivery report was received")
  receivedTimestamp?: utcDateTime;

  @doc("Customer Content")
  tag?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("Schema of the Data property of an EventGridEvent for a Microsoft.Communication.SMSReceived event.")
model AcsSmsReceivedEventData extends AcsSmsEventBaseProperties {
  @doc("The SMS content")
  message?: string;

  @doc("The time at which the SMS was received")
  receivedTimestamp?: utcDateTime;
}

//TODO: This might need some fixing
@doc("Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RecordingFileStatusUpdated event.")
model AcsRecordingFileStatusUpdatedEventData {
  @doc("The details of recording storage information")
  recordingStorageInfo?: AcsRecordingStorageInfoProperties;

  @doc("The time at which the recording started")
  recordingStartTime?: utcDateTime;

  @doc("The recording duration in milliseconds")
  recordingDurationMs?: int64;

  @doc("The recording content type- AudioVideo, or Audio")
  recordingContentType?: recordingContentType;

  @doc("The recording  channel type - Mixed, Unmixed")
  recordingChannelType?: recordingChannelType;

  @doc("The recording format type - Mp4, Mp3, Wav")
  recordingFormatType?: recordingFormatType;

  @doc("The reason for ending recording session")
  sessionEndReason?: string;
}

@doc("Schema of the Data property of an EventGridEvent for a Microsoft.Communication.EmailDeliveryReportReceived event.")
model AcsEmailDeliveryReportReceivedEventData {
  @doc("The Sender Email Address")
  sender?: string;

  @doc("The recipient Email Address")
  recipient?: string;

  @doc("The Id of the email been sent")
  messageId?: string;

  @doc("The status of the email. Any value other than Delivered is considered failed.")
  status?: AcsEmailDeliveryReportStatus;

  @doc("Detailed information about the status if any")
  deliveryStatusDetails?: AcsEmailDeliveryReportStatusDetails;

  @doc("The time at which the email delivery report received timestamp")
  @friendlyName("deliveryAttemptTimestamp")
  deliveryAttemptTimeStamp?: utcDateTime;
}

@doc("Schema of the Data property of an EventGridEvent for a Microsoft.Communication.EmailEngagementTrackingReportReceived event.")
model AcsEmailEngagementTrackingReportReceivedEventData {
  @doc("The Sender Email Address")
  sender?: string;

  @doc("The Recipient Email Address")
  recipient?: string;

  @doc("The Id of the email that has been sent")
  messageId?: string;

  @doc("The time at which the user interacted with the email")
  @friendlyName("userActionTimestamp")
  userActionTimeStamp?: utcDateTime;

  @doc("The context of the type of engagement user had with email")
  engagementContext?: string;

  @doc("The user agent interacting with the email")
  userAgent?: string;

  @doc("The type of engagement user have with email")
  engagementType?: AcsUserEngagement;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.Communication.RouterJobCancelled event
""")
model AcsRouterJobCancelledEventData extends AcsRouterJobEventData {
  @doc("Router Job Note")
  note?: string;

  @doc("Router Job Disposition Code")
  dispositionCode?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.Communication.RouterJobClassificationFailed event
""")
model AcsRouterJobClassificationFailedEventData extends AcsRouterJobEventData {
  @doc("Router Job Classification Policy Id")
  classificationPolicyId?: string;

  @doc("Router Job Classification Failed Errors")
  errors?: AcsRouterCommunicationError[];
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.Communication.RouterJobClassified event
""")
model AcsRouterJobClassifiedEventData extends AcsRouterJobEventData {
  @doc("Router Job Queue Info")
  queueDetails?: AcsRouterQueueDetails;

  @doc("Router Job Classification Policy Id")
  classificationPolicyId?: string;

  @doc("Router Job Priority")
  priority?: int32;

  @doc("Router Job Attached Worker Selector")
  attachedWorkerSelectors?: AcsRouterWorkerSelector[];
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.Communication.RouterJobClosed event
""")
model AcsRouterJobClosedEventData extends AcsRouterJobEventData {
  @doc("Router Job Closed Assignment Id")
  assignmentId?: string;

  @doc("Router Job Closed Worker Id")
  workerId?: string;

  @doc("Router Job Closed Disposition Code")
  dispositionCode?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.Communication.RouterJobCompleted event
""")
model AcsRouterJobCompletedEventData extends AcsRouterJobEventData {
  @doc("Router Job Completed Assignment Id")
  assignmentId?: string;

  @doc("Router Job Completed Worker Id")
  workerId?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.Communication.RouterJobDeleted event
""")
model AcsRouterJobDeletedEventData extends AcsRouterJobEventData {}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.Communication.RouterJobExceptionTriggered event
""")
model AcsRouterJobExceptionTriggeredEventData extends AcsRouterJobEventData {
  @doc("Router Job Exception Triggered Rule Key")
  ruleKey?: string;

  @doc("Router Job Exception Triggered Rule Id")
  exceptionRuleId?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.Communication.RouterJobQueued event
""")
model AcsRouterJobQueuedEventData extends AcsRouterJobEventData {
  @doc("Router Job Priority")
  priority?: int32;

  @doc("Router Job Queued Attached Worker Selector")
  attachedWorkerSelectors?: AcsRouterWorkerSelector[];

  @doc("Router Job Queued Requested Worker Selector")
  requestedWorkerSelectors?: AcsRouterWorkerSelector[];
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.Communication.RouterJobReceived event
""")
model AcsRouterJobReceivedEventData extends AcsRouterJobEventData {
  @doc("Router Job Received Job Status")
  jobStatus?: AcsRouterJobStatus;

  @doc("Router Job Classification Policy Id")
  classificationPolicyId?: string;

  @doc("Router Job Priority")
  priority?: int32;

  @doc("Router Job Received Requested Worker Selectors")
  requestedWorkerSelectors?: AcsRouterWorkerSelector[];

  @doc("Router Job Received Scheduled Time in UTC")
  scheduledOn?: utcDateTime;

  @doc("Unavailable For Matching for Router Job Received")
  unavailableForMatching: boolean;
}

@doc("Acs Router Job Status")
enum AcsRouterJobStatus {
  @doc("Router Job Status Pending Classification")
  PendingClassification,

  @doc("Router Job Status Queued")
  Queued,

  @doc("Router Job Status Assigned")
  Assigned,

  @doc("Router Job Status Completed")
  Completed,

  @doc("Router Job Status Closed")
  Closed,

  @doc("Router Job Status Cancelled")
  Cancelled,

  @doc("Router Job Status Classification Failed")
  ClassificationFailed,

  @doc("Router Job Status Created")
  Created,

  @doc("Router Job Status Pending Schedule")
  PendingSchedule,

  @doc("Router Job Status Scheduled")
  Scheduled,

  @doc("Router Job Status Schedule Failed")
  ScheduleFailed,

  @doc("Router Job Status Waiting For Activation")
  WaitingForActivation,
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.Communication.RouterJobSchedulingFailed event
""")
model AcsRouterJobSchedulingFailedEventData extends AcsRouterJobEventData {
  @doc("Router Job Priority")
  priority?: int32;

  @doc("Router Job Scheduling Failed Attached Worker Selector Expired")
  expiredAttachedWorkerSelectors?: AcsRouterWorkerSelector[];

  @doc("Router Job Scheduling Failed Requested Worker Selector Expired")
  expiredRequestedWorkerSelectors?: AcsRouterWorkerSelector[];

  @doc("Router Job Scheduling Failed Scheduled Time in UTC")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  scheduledOn?: utcDateTime;

  @doc("Router Job Scheduling Failed Reason")
  failureReason?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.Communication.RouterJobUnassigned event
""")
model AcsRouterJobUnassignedEventData extends AcsRouterJobEventData {
  @doc("Router Job Unassigned Assignment Id")
  assignmentId?: string;

  @doc("Router Job Unassigned Worker Id")
  workerId?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.Communication.RouterJobWaitingForActivation event
""")
model AcsRouterJobWaitingForActivationEventData extends AcsRouterJobEventData {
  @doc("Router Job Waiting For Activation Priority")
  priority?: int32;

  @doc("Router Job Waiting For Activation Worker Selector Expired")
  expiredAttachedWorkerSelectors?: AcsRouterWorkerSelector[];

  @doc("Router Job Waiting For Activation Requested Worker Selector Expired")
  expiredRequestedWorkerSelectors?: AcsRouterWorkerSelector[];

  @doc("Router Job Waiting For Activation Scheduled Time in UTC")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  scheduledOn?: utcDateTime;

  @doc("Router Job Waiting For Activation Unavailable For Matching")
  unavailableForMatching: boolean;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.Communication.RouterJobWorkerSelectorsExpired event
""")
model AcsRouterJobWorkerSelectorsExpiredEventData
  extends AcsRouterJobEventData {
  @doc("Router Job Worker Selectors Expired Requested Worker Selectors")
  expiredRequestedWorkerSelectors?: AcsRouterWorkerSelector[];

  @doc("Router Job Worker Selectors Expired Attached Worker Selectors")
  expiredAttachedWorkerSelectors?: AcsRouterWorkerSelector[];
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.Communication.RouterWorkerDeleted event
""")
model AcsRouterWorkerDeletedEventData extends AcsRouterWorkerEventData {}

@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.Communication.RouterWorkerDeregistered event
""")
model AcsRouterWorkerDeregisteredEventData {
  @doc("Router Worker Deregistered Worker Id")
  workerId?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.Communication.RouterWorkerOfferAccepted event
""")
model AcsRouterWorkerOfferAcceptedEventData extends AcsRouterWorkerEventData {
  @doc("Router Worker Offer Accepted Queue Id")
  queueId?: string;

  @doc("Router Worker Offer Accepted Offer Id")
  offerId?: string;

  @doc("Router Worker Offer Accepted Assignment Id")
  assignmentId?: string;

  @doc("Router Worker Offer Accepted Job Priority")
  jobPriority?: int32;

  @doc("Router Worker Offer Accepted Worker Labels")
  workerLabels?: Record<string>;

  @doc("Router Worker Offer Accepted Worker Tags")
  workerTags?: Record<string>;

  @doc("Router Worker Offer Accepted Job Labels")
  jobLabels?: Record<string>;

  @doc("Router Worker Offer Accepted Job Tags")
  jobTags?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.Communication.RouterWorkerOfferDeclined event
""")
model AcsRouterWorkerOfferDeclinedEventData extends AcsRouterWorkerEventData {
  @doc("Router Worker Offer Declined Queue Id")
  queueId?: string;

  @doc("Router Worker Offer Declined Offer Id")
  offerId?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.Communication.RouterWorkerOfferExpired event
""")
model AcsRouterWorkerOfferExpiredEventData extends AcsRouterWorkerEventData {
  @doc("Router Worker Offer Expired Queue Id")
  queueId?: string;

  @doc("Router Worker Offer Expired Offer Id")
  offerId?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.Communication.RouterWorkerOfferIssued event
""")
model AcsRouterWorkerOfferIssuedEventData extends AcsRouterWorkerEventData {
  @doc("Router Worker Offer Issued Queue Id")
  queueId?: string;

  @doc("Router Worker Offer Issued Offer Id")
  offerId?: string;

  @doc("Router Worker Offer Issued Job Priority")
  jobPriority?: int32;

  @doc("Router Worker Offer Issued Worker Labels")
  workerLabels?: Record<string>;

  @doc("Router Worker Offer Issued Time in UTC")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  offeredOn?: utcDateTime;

  @doc("Router Worker Offer Issued Expiration Time in UTC")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  expiresOn?: utcDateTime;

  @doc("Router Worker Offer Issued Worker Tags")
  workerTags?: Record<string>;

  @doc("Router Worker Offer Issued Job Labels")
  jobLabels?: Record<string>;

  @doc("Router Worker Offer Issued Job Tags")
  jobTags?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.Communication.RouterWorkerOfferRevoked event
""")
model AcsRouterWorkerOfferRevokedEventData extends AcsRouterWorkerEventData {
  @doc("Router Worker Offer Revoked Queue Id")
  queueId?: string;

  @doc("Router Worker Offer Revoked Offer Id")
  offerId?: string;
}

@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.Communication.RouterWorkerRegistered event
""")
model AcsRouterWorkerRegisteredEventData {
  @doc("Router Worker Registered Worker Id")
  workerId?: string;

  @doc("Router Worker Registered Queue Info")
  queueAssignments?: AcsRouterQueueDetails[];

  @doc("Router Worker Registered Channel Configuration")
  channelConfigurations?: AcsRouterChannelConfiguration[];

  @doc("Router Worker Register Total Capacity")
  totalCapacity?: int32;

  @doc("Router Worker Registered Labels")
  labels?: Record<string>;

  @doc("Router Worker Registered Tags")
  tags?: Record<string>;
}

// Base Properties
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("Schema of common properties of all Router Job events")
model AcsRouterJobEventData extends AcsRouterEventData {
  @doc("Router Job events Queue Id")
  queueId?: string;

  @doc("Router Job events Labels")
  labels?: Record<string>;

  @doc("Router Jobs events Tags")
  tags?: Record<string>;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("Schema of common properties of all Router Worker events")
model AcsRouterWorkerEventData extends AcsRouterEventData {
  @doc("Router Worker events Worker Id")
  workerId?: string;
}

@doc("Schema of common properties of all Router events")
model AcsRouterEventData {
  @doc("Router Event Job ID")
  jobId?: string;

  @doc("Router Event Channel Reference")
  channelReference?: string;

  @doc("Router Event Channel ID")
  channelId?: string;
}

@doc("Router Channel Configuration")
model AcsRouterChannelConfiguration {
  @doc("Channel ID for Router Job")
  channelId?: string;

  @doc("Capacity Cost Per Job for Router Job")
  capacityCostPerJob?: int32;

  @doc("Max Number of Jobs for Router Job")
  maxNumberOfJobs?: int32;
}

@doc("Router Queue Details")
model AcsRouterQueueDetails {
  @doc("Router Queue Id")
  id?: string;

  @doc("Router Queue Name")
  name?: string;

  @doc("Router Queue Labels")
  labels?: Record<string>;
}

@doc("Router Communication Error")
model AcsRouterCommunicationError {
  // @doc("Router Communication Error Code")
  // code?: string;

  // @doc("Router Communication Error Message")
  // message?: string;

  // @doc("Router Communication Error Target")
  // target?: string;

  // @doc("Router Communication Inner Error")
  // innererror?: AcsRouterCommunicationError;

  // @doc("List of Router Communication Errors")
  // details?: AcsRouterCommunicationError[];
}

@doc("Router Job Worker Selector")
model AcsRouterWorkerSelector {
  @doc("Router Job Worker Selector Key")
  key?: string;

  @doc("Router Job Worker Selector Label Operator")
  operator?: AcsRouterLabelOperator;

  #suppress "@azure-tools/typespec-azure-core/no-unknown" "The type of labelValue is object"
  @doc("Router Job Worker Selector Value")
  labelValue?: unknown;

  @doc("Router Job Worker Selector Time to Live in Seconds")
  @encode("ISO8601") // TODO verify this is timespan in C#
  timeToLive?: duration;

  @doc("Router Job Worker Selector State")
  selectorState?: AcsRouterWorkerSelectorState;

  @doc("Router Job Worker Selector Expiration Time")
  expirationTime?: utcDateTime;
}

alias AcsChatMessageBaseEventData = {
  @doc("The body of the chat message")
  messageBody?: string;

  @doc("The chat message metadata")
  metadata?: Record<string>;
};

alias AcsChatThreadBaseEventData = {
  @doc("The communication identifier of the user who created the thread")
  createdByCommunicationIdentifier?: CommunicationIdentifierModel;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "The type of properties is object with additionalProperties: object"
  @doc("The thread properties")
  properties?: Record<string>;

  @doc("The list of properties of participants who are part of the thread")
  participants?: AcsChatThreadParticipantProperties[];
};

alias AcsChatThreadDeletedBaseEventData = {
  @doc("The communication identifier of the user who deleted the thread")
  deletedByCommunicationIdentifier?: CommunicationIdentifierModel;

  @doc("The deletion time of the thread")
  deleteTime?: utcDateTime;
};

alias AcsChatThredPropertiesBaseEventData = {
  @doc("The communication identifier of the user who updated the thread properties")
  editedByCommunicationIdentifier?: CommunicationIdentifierModel;

  @doc("The time at which the properties of the thread were updated")
  editTime?: utcDateTime;

  @doc("The updated thread properties")
  properties?: Record<string>;
};

alias AcsChatParticipantBaseEventData = {
  @doc("The time at which the user was added to the thread")
  time?: utcDateTime;

  @doc("The communication identifier of the user who added the user")
  addedByCommunicationIdentifier?: CommunicationIdentifierModel;

  @doc("The details of the user who was added")
  participantAdded?: AcsChatThreadParticipantProperties;
};

@doc("Recording content type")
enum recordingContentType {
  @doc("AudioVideo content type")
  AudioVideo,

  @doc("Audio content type")
  Audio,
}

@doc("Recording channel type")
enum recordingChannelType {
  @doc("Mixed channel type")
  Mixed,

  @doc("Unmixed channel type")
  Unmixed,
}

@doc("Recording format type")
enum recordingFormatType {
  @doc("WAV format")
  Wav,

  @doc("MP3 format")
  Mp3,

  @doc("MP4 format")
  Mp4,
}

@doc("Router Job Worker Selector Label Operator")
enum AcsRouterLabelOperator {
  @doc("Router Label Operator Equal")
  Equal,

  @doc("Router Label Operator Not Equal")
  NotEqual,

  @doc("Router Label Operator Greater")
  Greater,

  @doc("Router Label Operator Less")
  Less,

  @doc("Router Label Operator Greater than or equal")
  GreaterThanorEqual,

  @doc("Router Label Operator Less than or equal")
  LessThanOrEqual,
}

@doc("Router Worker Selector State")
enum AcsRouterWorkerSelectorState {
  @doc("Router Worker Selector State Active")
  Active : "active";

  @doc("Router Worker Selector State Expired")
  Expired : "expired";
}

@doc("The status of the email. Any value other than Delivered is considered failed.")
enum AcsEmailDeliveryReportStatus {
  @doc("Hard bounce detected while sending the email")
  Bounced,

  @doc("The email was delivered")
  Delivered,

  @doc("The email failed to be delivered")
  Failed,

  @doc("The message was identified as spam and was rejected or blocked (not quarantined).")
  FilteredSpam,

  @doc("The message was quarantined (as spam, bulk mail, or phishing). For more information, see Quarantined email messages in EOP (EXCHANGE ONLINE PROTECTION).")
  Quarantined,

  @doc("The email was suppressed")
  Suppressed,
}

@doc("Detailed information about the status if any")
model AcsEmailDeliveryReportStatusDetails {
  @doc("Detailed status message")
  statusMessage?: string;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("Schema of common properties of all chat thread events")
model AcsChatThreadEventBaseProperties extends AcsChatEventBaseProperties {
  @doc("The original creation time of the thread")
  createTime?: utcDateTime;

  @doc("The version of the thread")
  version?: int64;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("Schema of common properties of all chat thread events")
model AcsChatThreadEventInThreadBaseProperties
  extends AcsChatEventInThreadBaseProperties {
  @doc("The original creation time of the thread")
  createTime?: utcDateTime;

  @doc("The version of the thread")
  version?: int64;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("Schema of common properties of all chat message events")
model AcsChatMessageEventBaseProperties extends AcsChatEventBaseProperties {
  @doc("The chat message id")
  messageId?: string;

  @doc("The communication identifier of the sender")
  senderCommunicationIdentifier?: CommunicationIdentifierModel;

  @doc("The display name of the sender")
  senderDisplayName?: string;

  @doc("The original compose time of the message")
  composeTime?: utcDateTime;

  @doc("The type of the message")
  type?: string;

  @doc("The version of the message")
  version?: int64;
}

#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@doc("Schema of common properties of all thread-level chat message events")
model AcsChatMessageEventInThreadBaseProperties
  extends AcsChatEventInThreadBaseProperties {
  @doc("The chat message id")
  messageId?: string;

  @doc("The communication identifier of the sender")
  senderCommunicationIdentifier?: CommunicationIdentifierModel;

  @doc("The display name of the sender")
  senderDisplayName?: string;

  @doc("The original compose time of the message")
  composeTime?: utcDateTime;

  @doc("The type of the message")
  type?: string;

  @doc("The version of the message")
  version?: int64;
}

@doc("Schema of common properties of all thread-level chat events")
model AcsChatEventInThreadBaseProperties {
  @doc("The transaction id will be used as co-relation vector")
  transactionId?: string;

  @doc("The chat thread id")
  threadId?: string;
}

@doc("Schema of common properties of all chat events")
model AcsChatEventBaseProperties {
  @doc("The communication identifier of the target user")
  recipientCommunicationIdentifier?: CommunicationIdentifierModel;

  ...AcsChatEventInThreadBaseProperties;
}

@doc("Schema of the chat thread participant")
model AcsChatThreadParticipantProperties {
  @doc("The name of the user")
  displayName?: string;

  @doc("The communication identifier of the user")
  participantCommunicationIdentifier?: CommunicationIdentifierModel;
}

@doc("Schema of common properties of all SMS events")
model AcsSmsEventBaseProperties {
  @doc("The identity of the SMS message")
  messageId?: string;

  @doc("The identity of SMS message sender")
  from?: string;

  @doc("The identity of SMS message receiver")
  to?: string;
}

@doc("Schema for details of a delivery attempt")
model AcsSmsDeliveryAttemptProperties {
  @doc("TimeStamp when delivery was attempted")
  timestamp?: utcDateTime;

  @doc("Number of segments that were successfully delivered")
  segmentsSucceeded?: int32;

  @doc("Number of segments whose delivery failed")
  segmentsFailed?: int32;
}

@doc("Schema for all properties of Recording Storage Information.")
model AcsRecordingStorageInfoProperties {
  @doc("List of details of recording chunks information")
  recordingChunks?: AcsRecordingChunkInfoProperties[];
}

@doc("Schema for all properties of  Recording Chunk Information.")
model AcsRecordingChunkInfoProperties {
  @doc("The documentId of the recording chunk")
  documentId?: string;

  @doc("The index of the recording chunk")
  index?: int64;

  @doc("The reason for ending the recording chunk")
  endReason?: string;

  @doc("The location of the metadata for this chunk")
  metadataLocation?: string;

  @doc("The location of the content for this chunk")
  contentLocation?: string;

  @doc("The location to delete all chunk storage")
  deleteLocation?: string;
}

@doc("Custom Context of Incoming Call")
model AcsIncomingCallCustomContext {
  @doc("Sip Headers for incoming call")
  sipHeaders?: Record<string>;

  @doc("Voip Headers for incoming call")
  voipHeaders?: Record<string>;
}

@doc("The type of engagement user have with email.")
enum AcsUserEngagement {
  @doc("View")
  view,

  @doc("Click")
  click,
}

@doc("Identifies a participant in Azure Communication services. A participant is, for example, a phone number or an Azure communication user. This model must be interpreted as a union: Apart from rawId, at most one further property may be set.")
model CommunicationIdentifierModel {
  @doc("Raw Id of the identifier. Optional in requests, required in responses.")
  rawId?: string;

  @doc("The communication user.")
  communicationUser?: CommunicationUserIdentifierModel;

  @doc("The phone number.")
  phoneNumber?: PhoneNumberIdentifierModel;

  @doc("The Microsoft Teams user.")
  microsoftTeamsUser?: MicrosoftTeamsUserIdentifierModel;
}

@doc("A Microsoft Teams user.")
model MicrosoftTeamsUserIdentifierModel {
  @doc("The Id of the Microsoft Teams user. If not anonymous, this is the AAD object Id of the user.")
  userId: string;

  @doc("True if the Microsoft Teams user is anonymous. By default false if missing.")
  isAnonymous?: boolean;

  @doc("The cloud that the Microsoft Teams user belongs to. By default 'public' if missing.")
  cloud?: CommunicationCloudEnvironmentModel;
}

@doc("A phone number.")
model PhoneNumberIdentifierModel {
  @doc("The phone number in E.164 format.")
  value: string;
}

@doc("A user that got created with an Azure Communication Services resource.")
model CommunicationUserIdentifierModel {
  @doc("The Id of the communication user.")
  id: string;
}

@doc("Communication cloud environment model.")
enum CommunicationCloudEnvironmentModel {
  @doc("Public")
  public,

  @doc("Dod")
  dod,

  @doc("Gcch")
  gcch,
}
