import "./AzureCommunicationServicesCore.tsp";

@doc("Describes the schema of the Azure Communication Services events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent.")
namespace EventGrid;

@doc("Schema of the Data property of an EventGridEvent for an Microsoft.Communication.IncomingCall event")
model AcsIncomingCallEventData {
  @doc("The communication identifier of the target user.")
  to?: CommunicationIdentifierModel;

  @doc("The communication identifier of the user who initiated the call.")
  from?: CommunicationIdentifierModel;

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

@doc("Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatMessageReceived event.")
model AcsChatMessageReceivedEventData
  extends AcsChatMessageEventBaseProperties {
  ...AcsChatMessageBaseEventData;
}

@doc("Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatMessageReceivedInThread event.")
model AcsChatMessageReceivedInThreadEventData
  extends AcsChatMessageEventInThreadBaseProperties {
  ...AcsChatMessageBaseEventData;
}

@doc("Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatMessageEdited event.")
model AcsChatMessageEditedEventData extends AcsChatMessageEventBaseProperties {
  ...AcsChatMessageBaseEventData;

  @doc("The time at which the message was edited")
  editTime?: utcDateTime;
}

@doc("Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatMessageEditedInThread event.")
model AcsChatMessageEditedInThreadEventData
  extends AcsChatMessageEventInThreadBaseProperties {
  ...AcsChatMessageBaseEventData;

  @doc("The time at which the message was edited")
  editTime?: utcDateTime;
}

@doc("Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatMessageDeleted event.")
model AcsChatMessageDeletedEventData extends AcsChatMessageEventBaseProperties {
  @doc("The time at which the message was deleted")
  deleteTime?: utcDateTime;
}

@doc("Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatMessageDeletedInThread event.")
model AcsChatMessageDeletedInThreadEventData
  extends AcsChatMessageEventInThreadBaseProperties {
  @doc("The time at which the message was deleted")
  deleteTime?: utcDateTime;
}

@doc("Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatThreadCreatedWithUser event.")
model AcsChatThreadCreatedWithUserEventData
  extends AcsChatThreadEventBaseProperties {
  ...AcsChatThreadBaseEventData;
}

@doc("Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatThreadCreated event.")
model AcsChatThreadCreatedEventData
  extends AcsChatThreadEventInThreadBaseProperties {
  ...AcsChatThreadBaseEventData;
}

@doc("Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatThreadWithUserDeleted event.")
model AcsChatThreadWithUserDeletedEventData
  extends AcsChatThreadEventBaseProperties {
  ...AcsChatThreadDeletedBaseEventData;
}

@doc("Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatThreadDeleted event.")
model AcsChatThreadDeletedEventData
  extends AcsChatThreadEventInThreadBaseProperties {
  ...AcsChatThreadDeletedBaseEventData;
}

@doc("Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatThreadPropertiesUpdatedPerUser event.")
model AcsChatThreadPropertiesUpdatedPerUserEventData
  extends AcsChatThreadEventBaseProperties {
  ...AcsChatThredPropertiesBaseEventData;
}

@doc("Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatThreadPropertiesUpdated event.")
model AcsChatThreadPropertiesUpdatedEventData
  extends AcsChatThreadEventInThreadBaseProperties {
  ...AcsChatThredPropertiesBaseEventData;
}

@doc("Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatParticipantAddedToThreadWithUser event.")
model AcsChatParticipantAddedToThreadWithUserEventData
  extends AcsChatThreadEventBaseProperties {
  ...AcsChatParticipantBaseEventData;
}

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

@doc("Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatThreadParticipantAdded event.")
model AcsChatParticipantAddedToThreadEventData
  extends AcsChatEventInThreadBaseProperties {
  ...AcsChatParticipantBaseEventData;

  @doc("The version of the thread")
  version?: int64;
}

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

@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.Communication.RouterJobCancelled event
""")
model AcsRouterJobCancelledEventData {
  ...AcsRouterJobEventData;

  @doc("Router Job Note")
  note?: string;

  @doc("Router Job Disposition Code")
  dispositionCode?: string;
}

@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.Communication.RouterJobClassificationFailed event
""")
model AcsRouterJobClassificationFailedEventData {
  ...AcsRouterJobEventData;

  @doc("Router Job Classification Policy Id")
  classificationPolicyId?: string;

  @doc("Router Job Classification Failed Errors")
  errors?: AcsRouterCommunicationError[];
}

@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.Communication.RouterJobClassified event
""")
model AcsRouterJobClassifiedEventData {
  ...AcsRouterJobEventData;

  @doc("Router Job Queue Info")
  queueDetails?: AcsRouterQueueDetails;

  @doc("Router Job Classification Policy Id")
  classificationPolicyId?: string;

  @doc("Router Job Priority")
  priority?: int32;

  @doc("Router Job Attached Worker Selector")
  attachedWorkerSelectors?: AcsRouterWorkerSelector[];
}

@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.Communication.RouterJobClosed event
""")
model AcsRouterJobClosedEventData {
  ...AcsRouterJobEventData;

  @doc("Router Job Closed Assignment Id")
  assignmentId?: string;

  @doc("Router Job Closed Worker Id")
  workerId?: string;

  @doc("Router Job Closed Disposition Code")
  dispositionCode?: string;
}

@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.Communication.RouterJobCompleted event
""")
model AcsRouterJobCompletedEventData {
  ...AcsRouterJobEventData;

  @doc("Router Job Completed Assignment Id")
  assignmentId?: string;

  @doc("Router Job Completed Worker Id")
  workerId?: string;
}

@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.Communication.RouterJobDeleted event
""")
model AcsRouterJobDeletedEventData {
  ...AcsRouterJobEventData;
}

@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.Communication.RouterJobExceptionTriggered event
""")
model AcsRouterJobExceptionTriggeredEventData {
  ...AcsRouterJobEventData;

  @doc("Router Job Exception Triggered Rule Key")
  ruleKey?: string;

  @doc("Router Job Exception Triggered Rule Id")
  exceptionRuleId?: string;
}

@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.Communication.RouterJobQueued event
""")
model AcsRouterJobQueuedEventData {
  ...AcsRouterJobEventData;

  @doc("Router Job Priority")
  priority?: int32;

  @doc("Router Job Queued Attached Worker Selector")
  attachedWorkerSelectors?: AcsRouterWorkerSelector[];

  @doc("Router Job Queued Requested Worker Selector")
  requestedWorkerSelectors?: AcsRouterWorkerSelector[];
}

@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.Communication.RouterJobReceived event
""")
model AcsRouterJobReceivedEventData {
  ...AcsRouterJobEventData;

  @doc("Router Job Received Job Status")
  jobStatus?: AcsRouterJobStatus;

  @doc("Router Job Classification Policy Id")
  classificationPolicyId?: string;

  @doc("Router Job Priority")
  priority?: int32;

  @doc("Router Job Received Requested Worker Selectors")
  requestedWorkerSelectors?: AcsRouterWorkerSelector[];

  @doc("Router Job Received Scheduled Time in UTC")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  scheduledOn?: utcDateTime;

  @doc("Unavailable For Matching for Router Job Received")
  unavailableForMatching: boolean;
}

@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.Communication.RouterJobSchedulingFailed event
""")
model AcsRouterJobSchedulingFailedEventData {
  ...AcsRouterJobEventData;

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

@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.Communication.RouterJobUnassigned event
""")
model AcsRouterJobUnassignedEventData {
  ...AcsRouterJobEventData;

  @doc("Router Job Unassigned Assignment Id")
  assignmentId?: string;

  @doc("Router Job Unassigned Worker Id")
  workerId?: string;
}

@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.Communication.RouterJobWaitingForActivation event
""")
model AcsRouterJobWaitingForActivationEventData {
  ...AcsRouterJobEventData;

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

@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.Communication.RouterJobWorkerSelectorsExpired event
""")
model AcsRouterJobWorkerSelectorsExpiredEventData {
  ...AcsRouterJobEventData;

  @doc("Router Job Worker Selectors Expired Requested Worker Selectors")
  expiredRequestedWorkerSelectors?: AcsRouterWorkerSelector[];

  @doc("Router Job Worker Selectors Expired Attached Worker Selectors")
  expiredAttachedWorkerSelectors?: AcsRouterWorkerSelector[];
}

@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.Communication.RouterWorkerDeleted event
""")
model AcsRouterWorkerDeletedEventData {
  ...AcsRouterWorkerEventData;
}

@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.Communication.RouterWorkerDeregistered event
""")
model AcsRouterWorkerDeregisteredEventData {
  @doc("Router Worker Deregistered Worker Id")
  workerId?: string;
}

@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.Communication.RouterWorkerOfferAccepted event
""")
model AcsRouterWorkerOfferAcceptedEventData {
  ...AcsRouterWorkerEventData;

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

@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.Communication.RouterWorkerOfferDeclined event
""")
model AcsRouterWorkerOfferDeclinedEventData {
  ...AcsRouterWorkerEventData;

  @doc("Router Worker Offer Declined Queue Id")
  queueId?: string;

  @doc("Router Worker Offer Declined Offer Id")
  offerId?: string;
}

@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.Communication.RouterWorkerOfferExpired event
""")
model AcsRouterWorkerOfferExpiredEventData {
  ...AcsRouterWorkerEventData;

  @doc("Router Worker Offer Expired Queue Id")
  queueId?: string;

  @doc("Router Worker Offer Expired Offer Id")
  offerId?: string;
}

@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.Communication.RouterWorkerOfferIssued event
""")
model AcsRouterWorkerOfferIssuedEventData {
  ...AcsRouterWorkerEventData;

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

@doc("""
Schema of the Data property of an EventGridEvent for a
Microsoft.Communication.RouterWorkerOfferRevoked event
""")
model AcsRouterWorkerOfferRevokedEventData {
  ...AcsRouterWorkerEventData;

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

@doc("Schema of common properties of all Router Job events")
model AcsRouterJobEventData {
  ...AcsRouterEventData;

  @doc("Router Job events Queue Id")
  queueId?: string;

  @doc("Router Job events Labels")
  labels?: Record<string>;

  @doc("Router Jobs events Tags")
  tags?: Record<string>;
}

@doc("Schema of common properties of all Router Worker events")
model AcsRouterWorkerEventData {
  ...AcsRouterEventData;

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
  @doc("Router Communication Error Code")
  code?: string;

  @doc("Router Communication Error Message")
  message?: string;

  @doc("Router Communication Error Target")
  target?: string;

  @doc("Router Communication Inner Error")
  innererror?: AcsRouterCommunicationError;

  @doc("List of Router Communication Errors")
  details?: AcsRouterCommunicationError[];
}

@doc("Router Job Worker Selector")
model AcsRouterWorkerSelector {
  @doc("Router Job Worker Selector Key")
  key?: string;

  @doc("Router Job Worker Selector Label Operator")
  labelOperator?: AcsRouterLabelOperator;

  @doc("Router Job Worker Selector Value")
  labelValue?: unknown;

  @doc("Router Job Worker Selector Time to Live in Seconds")
  ttlSeconds?: float32;

  @doc("Router Job Worker Selector State")
  state?: AcsRouterWorkerSelectorState;

  @doc("Router Job Worker Selector Expiration Time")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
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
  properties?: Record<unknown>;

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

@doc("Schema of common properties of all chat thread events")
model AcsChatThreadEventBaseProperties extends AcsChatEventBaseProperties {
  @doc("The original creation time of the thread")
  createTime?: utcDateTime;

  @doc("The version of the thread")
  version?: int64;
}

@doc("Schema of common properties of all chat thread events")
model AcsChatThreadEventInThreadBaseProperties
  extends AcsChatEventInThreadBaseProperties {
  @doc("The original creation time of the thread")
  createTime?: utcDateTime;

  @doc("The version of the thread")
  version?: int64;
}

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
