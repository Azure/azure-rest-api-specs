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

@doc("Custom Context of Incoming Call")
model AcsIncomingCallCustomContext {
  @doc("Sip Headers for incoming call")
  sipHeaders?: Record<string>;

  @doc("Voip Headers for incoming call")
  voipHeaders?: Record<string>;
}

@doc("Schema of the Data property of an EventGridEvent for an Microsoft.Communication.UserDisconnected event.")
model AcsUserDisconnectedEventData {
  @doc("The communication identifier of the user who was disconnected")
  userCommunicationIdentifier?: CommunicationIdentifierModel;
}

alias AcsChatMessageBaseEventData = {
  @doc("The body of the chat message")
  messageBody?: string;

  @doc("The chat message metadata")
  metadata?: Record<string>;
};

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

alias AcsChatThreadBaseEventData = {
  @doc("The communication identifier of the user who created the thread")
  createdByCommunicationIdentifier?: CommunicationIdentifierModel;

  @doc("The thread properties")
  properties?: Record<string>;

  @doc("The list of properties of participants who are part of the thread")
  participants?: AcsChatThreadParticipantProperties[];
};

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

alias AcsChatThreadDeletedBaseEventData = {
  @doc("The communication identifier of the user who deleted the thread")
  deletedByCommunicationIdentifier?: CommunicationIdentifierModel;

  @doc("The deletion time of the thread")
  deleteTime?: utcDateTime;
};

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

alias AcsChatThredPropertiesBaseEventData = {
  @doc("The communication identifier of the user who updated the thread properties")
  editedByCommunicationIdentifier?: CommunicationIdentifierModel;

  @doc("The time at which the properties of the thread were updated")
  editTime?: utcDateTime;

  @doc("The updated thread properties")
  properties?: Record<string>;
};

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

alias AcsChatParticipantBaseEventData = {
  @doc("The time at which the user was added to the thread")
  time?: utcDateTime;

  @doc("The communication identifier of the user who added the user")
  addedByCommunicationIdentifier?: CommunicationIdentifierModel;

  @doc("The details of the user who was added")
  participantAdded?: AcsChatThreadParticipantProperties;
};

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

@doc("Schema of the Data property of an EventGridEvent for a Microsoft.Communication.EmailEngagementTrackingReportReceived event.")
model AcsEmailEngagementTrackingReportReceivedEventData {
  @doc("The Sender Email Address")
  sender?: string;

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

@doc("The type of engagement user have with email.")
enum AcsUserEngagement {
  @doc("View")
  view,

  @doc("Click")
  click,
}

// Base Properties

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
  segmentsSucceeded?: int64;

  @doc("Number of segments whose delivery failed")
  segmentsFailed?: int64;
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
