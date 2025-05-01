import "@typespec/versioning";
using TypeSpec.Versioning;
/** Describes the schema of the Azure Communication Services events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent. */
namespace Microsoft.EventGrid.SystemEvents;

//  const MicrosoftCommunicationIncomingCallExample: AcsIncomingCallEventData = #{to: #{kind: "communicationUser", rawId: "{recipient-id}", communicationUser: #{id: "{recipient-id}"}}, from: #{kind: "communicationUser", rawId: "{caller-id}", communicationUser: #{id: "{caller-id}"}}, serverCallId: "{server-call-id}", callerDisplayName: "VOIP Caller", customContext: #{sipHeaders: #{userToUser: "616d617a6f6e5f6368696;encoding=hex", "X-MS-Custom-myheader1": "35567842", "X-MS-Custom-myheader2": "customsipheadervalue"}, voipHeaders: #{customHeader: "customValue"}, onBehalfOfCallee: #{kind: "communicationUser", rawId: "{caller-id}", communicationUser: #{id: "{caller-id}"}}}, incomingCallContext: "{incoming-call-contextValue}", correlationId: "correlationId"};
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

//  const MicrosoftCommunicationUserDisconnectedExample: AcsUserDisconnectedEventData = #{userCommunicationIdentifier: #{rawId: "8:acs:5354158b-17b7-489c-9380-95d8821ff76b_0000000c-6c47-7dfd-6d70-224822000cfb", communicationUser: #{id: "8:acs:5354158b-17b7-489c-9380-95d8821ff76b_0000000c-6c47-7dfd-6d70-224822000cfb"}}};
// @example(MicrosoftCommunicationUserDisconnectedExample)
/** Schema of the Data property of an EventGridEvent for an Microsoft.Communication.UserDisconnected event. */
model AcsUserDisconnectedEventData {
  /** The communication identifier of the user who was disconnected */
  userCommunicationIdentifier: CommunicationIdentifierModel;
}

//  const MicrosoftCommunicationChatMessageReceivedExample: AcsChatMessageReceivedEventData = #{messageBody: "Welcome to Azure Communication Services", messageId: "1613694358927", metadata: #{key: "value", description: "A map of data associated with the message"}, senderId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7caf-07fd-084822001724", senderCommunicationIdentifier: #{rawId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7caf-07fd-084822001724", communicationUser: #{id: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7caf-07fd-084822001724"}}, senderDisplayName: "Jhon", composeTime: "2021-02-19T00:25:58.927Z", type: "Text", version: 1613694358927, recipientId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7d05-83fe-084822000f6d", recipientCommunicationIdentifier: #{rawId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7d05-83fe-084822000f6d", communicationUser: #{id: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7d05-83fe-084822000f6d"}}, transactionId: "oh+LGB2dUUadMcTAdRWQxQ.1.1.1.1.1827536918.1.7", threadId: "19:6e5d6ca1d75044a49a36a7965ec4a906@thread.v2"};
// @example(MicrosoftCommunicationChatMessageReceivedExample)
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatMessageReceived event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatMessageReceivedEventData
  extends AcsChatMessageEventBaseProperties {
  ...AcsChatMessageBaseEventData;
}

//  const MicrosoftCommunicationChatMessageReceivedInThreadExample: AcsChatMessageReceivedInThreadEventData = #{messageBody: "Talk about new Thread Events in communication services", messageId: "1613783230064", metadata: #{key: "value", description: "A map of data associated with the message"}, type: "Text", version: "1613783230064", senderDisplayName: "Bob", senderCommunicationIdentifier: #{rawId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5cdb-4916-07fd-084822002624", communicationUser: #{id: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5cdb-4916-07fd-084822002624"}}, composeTime: "2021-02-19T17:07:10.064-08:00", threadId: "19:5b3809e80e4a439d92c3316e273f4a2b@thread.v2", transactionId: "foMkntkKS0O/MhMlIE5Aag.1.1.1.1.1004077250.1"};
// @example(MicrosoftCommunicationChatMessageReceivedInThreadExample)
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatMessageReceivedInThread event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatMessageReceivedInThreadEventData
  extends AcsChatMessageEventInThreadBaseProperties {
  ...AcsChatMessageBaseEventData;
}

//  const MicrosoftCommunicationChatMessageEditedExample: AcsChatMessageEditedEventData = #{editTime: utcDateTime.fromISO("2021-02-19T00:28:20.784Z"), messageBody: "Let's Chat about new communication services.", messageId: "1613694357917", metadata: #{key: "value", description: "A map of data associated with the message"}, senderId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7caf-07fd-084822001724", senderCommunicationIdentifier: #{rawId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7caf-07fd-084822001724", communicationUser: #{id: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7caf-07fd-084822001724"}}, senderDisplayName: "Bob(Admin)", composeTime: "2021-02-19T00:25:57.917Z", type: "Text", version: 1613694500784, recipientId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7d60-83fe-084822000f6f", recipientCommunicationIdentifier: #{rawId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7d60-83fe-084822000f6f", communicationUser: #{id: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7d60-83fe-084822000f6f"}}, transactionId: "1mL4XZH2gEecu/alk9tOtw.2.1.2.1.1833042153.1.7", threadId: "19:6e5d6ca1d75044a49a36a7965ec4a906@thread.v2"};
// @example(MicrosoftCommunicationChatMessageEditedExample)
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatMessageEdited event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatMessageEditedEventData extends AcsChatMessageEventBaseProperties {
  ...AcsChatMessageBaseEventData;

  /** The time at which the message was edited */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  editTime: utcDateTime;
}

//  const MicrosoftCommunicationChatMessageEditedInThreadExample: AcsChatMessageEditedInThreadEventData = #{editTime: utcDateTime.fromISO("2021-02-19T16:59:10.464-08:00"), messageBody: "8effb181-1eb2-4a58-9d03-ed48a461b19b", messageId: "1613782685964", metadata: #{key: "value", description: "A map of data associated with the message"}, type: "Text", version: "1613782750464", senderDisplayName: "Scott", senderCommunicationIdentifier: #{rawId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5cbb-38a0-88f7-084822002453", communicationUser: #{id: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5cbb-38a0-88f7-084822002453"}}, composeTime: "2021-02-19T16:58:05.964-08:00", threadId: "19:e07c8ddc5bab4c059ea9f11d29b544b6@thread.v2", transactionId: "H8Gpj3NkIU6bXlWw8WPvhQ.2.1.2.1.985333801.1"};
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

//  const MicrosoftCommunicationChatMessageDeletedExample: AcsChatMessageDeletedEventData = #{deleteTime: "2021-02-19T00:43:10.14Z", messageId: "1613695388152", senderId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7d07-83fe-084822000f6e", senderCommunicationIdentifier: #{rawId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7d07-83fe-084822000f6e", communicationUser: #{id: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7d07-83fe-084822000f6e"}}, senderDisplayName: "Bob(Admin)", composeTime: "2021-02-19T00:43:08.152Z", type: "Text", version: 1613695390361, recipientId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7d60-83fe-084822000f6f", recipientCommunicationIdentifier: #{rawId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7d60-83fe-084822000f6f", communicationUser: #{id: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7d60-83fe-084822000f6f"}}, transactionId: "fFs4InlBn0O/0WyhfQZVSQ.1.1.2.1.1867776045.1.4", threadId: "19:48899258eec941e7a281e03edc8f4964@thread.v2"};
// @example(MicrosoftCommunicationChatMessageDeletedExample)
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatMessageDeleted event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatMessageDeletedEventData extends AcsChatMessageEventBaseProperties {
  /** The time at which the message was deleted */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  deleteTime: utcDateTime;
}

//  const MicrosoftCommunicationChatMessageDeletedInThreadExample: AcsChatMessageDeletedInThreadEventData = #{deleteTime: utcDateTime.fromISO("2021-02-19T16:59:10.464-08:00"), messageId: "1613782685440", type: "Text", version: "1613782814333", senderDisplayName: "Scott", senderCommunicationIdentifier: #{rawId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5cbb-38a0-88f7-084822002453", communicationUser: #{id: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5cbb-38a0-88f7-084822002453"}}, composeTime: "2021-02-19T16:58:05.44-08:00", threadId: "19:e07c8ddc5bab4c059ea9f11d29b544b6@thread.v2", transactionId: "HqU6PeK5AkCRSpW8eAbL0A.1.1.2.1.987824181.1"};
// @example(MicrosoftCommunicationChatMessageDeletedInThreadExample)
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatMessageDeletedInThread event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatMessageDeletedInThreadEventData
  extends AcsChatMessageEventInThreadBaseProperties {
  /** The time at which the message was deleted */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  deleteTime: utcDateTime;
}

//  const MicrosoftCommunicationChatThreadCreatedWithUserExample: AcsChatThreadCreatedWithUserEventData = #{createdBy: "8:acs:3d703c91-9657-4b3f-b19c-ef9d53f99710_00000008-576c-286d-e1fe-0848220013b9", createdByCommunicationIdentifier: #{rawId: "8:acs:3d703c91-9657-4b3f-b19c-ef9d53f99710_00000008-576c-286d-e1fe-0848220013b9", communicationUser: #{id: "8:acs:3d703c91-9657-4b3f-b19c-ef9d53f99710_00000008-576c-286d-e1fe-0848220013b9"}}, properties: #{topic: "Chat about new commuication services"}, members: #[#{displayName: "Bob", memberId: "8:acs:3d703c91-9657-4b3f-b19c-ef9d53f99710_00000008-576c-286d-e1fe-0848220013b9"}, #{displayName: "John", memberId: "8:acs:3d703c91-9657-4b3f-b19c-ef9d53f99710_00000008-576c-289b-07fd-0848220015ea"}], participants: #[#{displayName: "Bob", participantCommunicationIdentifier: #{rawId: "8:acs:3d703c91-9657-4b3f-b19c-ef9d53f99710_00000008-576c-286d-e1fe-0848220013b9", communicationUser: #{id: "8:acs:3d703c91-9657-4b3f-b19c-ef9d53f99710_00000008-576c-286d-e1fe-0848220013b9"}}, metadata: #{key: "value"}}, #{displayName: "John", participantCommunicationIdentifier: #{rawId: "8:acs:3d703c91-9657-4b3f-b19c-ef9d53f99710_00000008-576c-289b-07fd-0848220015ea", communicationUser: #{id: "8:acs:3d703c91-9657-4b3f-b19c-ef9d53f99710_00000008-576c-289b-07fd-0848220015ea"}}, metadata: #{key: "value"}}], metadata: #{key: "value"}, createTime: "2021-02-18T23:47:26.91Z", version: 1613692046910, recipientId: "8:acs:3d703c91-9657-4b3f-b19c-ef9d53f99710_00000008-576c-286e-84f5-08482200181c", recipientCommunicationIdentifier: #{rawId: "8:acs:3d703c91-9657-4b3f-b19c-ef9d53f99710_00000008-576c-286e-84f5-08482200181c", communicationUser: #{id: "8:acs:3d703c91-9657-4b3f-b19c-ef9d53f99710_00000008-576c-286e-84f5-08482200181c"}}, transactionId: "zbZt+9h/N0em+XCW2QvyIA.1.1.1.1.1737228330.0.1737490483.1.6", threadId: "19:1d594fb1eeb14566903cbc5decb5bf5b@thread.v2"};
// @example(MicrosoftCommunicationChatThreadCreatedWithUserExample)
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatThreadCreatedWithUser event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatThreadCreatedWithUserEventData
  extends AcsChatThreadEventBaseProperties {
  ...AcsChatThreadBaseEventData;
}

// const MicrosoftCommunicationChatThreadCreatedExample: AcsChatThreadCreatedEventData =
// #{
//   createdByCommunicationIdentifier: #{
//     rawId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5cbb-38a0-88f7-084822002453",
//     communicationUser: #{
//       id: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5cbb-38a0-88f7-084822002453"
//     }
//   },
//   properties: #{
//     topic: "Talk about new Thread Events in commuication services"
//   },
//   participants: #[
//     #{
//       displayName: "Bob",
//       participantCommunicationIdentifier: #{
//         rawId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5cbb-38a0-88f7-084822002453",
//         communicationUser: #{
//           id: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5cbb-38a0-88f7-084822002453"
//         }
//       },
//       metadata: #{
//         key: "value"
//       }
//     },
//     #{
//       displayName: "Scott",
//       participantCommunicationIdentifier: #{
//         rawId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5cbb-38e6-07fd-084822002467",
//         communicationUser: #{
//           id: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5cbb-38e6-07fd-084822002467"
//         }
//       },
//       metadata: #{
//         key: "value",
//         description: "A map of data associated with the participant"
//       }
//     },
//     #{
//       displayName: "Shawn",
//       participantCommunicationIdentifier: #{
//         rawId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5cbb-38f6-83fe-084822002337",
//         communicationUser: #{
//           id: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5cbb-38f6-83fe-084822002337"
//         }
//       },
//       metadata: #{
//         key: "value"
//       }
//     },
//     #{
//       displayName: "Anthony",
//       participantCommunicationIdentifier: #{
//         rawId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5cbb-38e3-e1fe-084822002c35",
//         communicationUser: #{
//           id: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5cbb-38e3-e1fe-084822002c35"
//         }
//       },
//       metadata: #{
//         key: "value"
//       }
//     }
//   ],
//   metadata: #{
//     key: "value"
//   },
//   createTime: "2021-02-19T16:31:54.365-08:00",
//   version: 1613781114365,
//   threadId: "19:e07c8ddc5bab4c059ea9f11d29b544b6@thread.v2",
//   transactionId: "gK6+kgANy0O1wchlVKVTJg.1.1.1.1.921436178.1"
// };
// @example(MicrosoftCommunicationChatThreadCreatedExample)
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatThreadCreated event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatThreadCreatedEventData
  extends AcsChatThreadEventInThreadBaseProperties {
  ...AcsChatThreadBaseEventData;
}

//  const MicrosoftCommunicationChatThreadWithUserDeletedExample: AcsChatThreadWithUserDeletedEventData = #{deletedBy: "8:acs:3d703c91-9657-4b3f-b19c-ef9d53f99710_00000008-5772-6473-83fe-084822000e21", deletedByCommunicationIdentifier: #{rawId: "8:acs:3d703c91-9657-4b3f-b19c-ef9d53f99710_00000008-5772-6473-83fe-084822000e21", communicationUser: #{id: "8:acs:3d703c91-9657-4b3f-b19c-ef9d53f99710_00000008-5772-6473-83fe-084822000e21"}}, deleteTime: "2021-02-18T23:57:51.5987591Z", createTime: "2021-02-18T23:54:15.683Z", version: 1613692578672, recipientId: "8:acs:3d703c91-9657-4b3f-b19c-ef9d53f99710_00000008-5772-647b-e1fe-084822001416", recipientCommunicationIdentifier: #{rawId: "8:acs:3d703c91-9657-4b3f-b19c-ef9d53f99710_00000008-5772-647b-e1fe-084822001416", communicationUser: #{id: "8:acs:3d703c91-9657-4b3f-b19c-ef9d53f99710_00000008-5772-647b-e1fe-084822001416"}}, transactionId: "mrliWVUndEmLwkZbeS5KoA.1.1.2.1.1761607918.1.6", threadId: "19:5870b8f021d74fd786bf5aeb095da291@thread.v2"};
// @example(MicrosoftCommunicationChatThreadWithUserDeletedExample)
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatThreadWithUserDeleted event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatThreadWithUserDeletedEventData
  extends AcsChatThreadEventBaseProperties {
  ...AcsChatThreadDeletedBaseEventData;
}

//  const MicrosoftCommunicationChatThreadDeletedExample: AcsChatThreadDeletedEventData = #{deletedByCommunicationIdentifier: #{rawId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5c9e-a300-07fd-084822002266", communicationUser: #{id: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5c9e-a300-07fd-084822002266"}}, deleteTime: "2021-02-19T16:00:42.109802-08:00", createTime: "2021-02-19T16:00:39.947-08:00", version: 1613779241389, threadId: "19:c9e9f3060b884e448671391882066ac3@thread.v2", transactionId: "KibptDpcLEeEFnlR7cI3QA.1.1.2.1.848298005.1"};
// @example(MicrosoftCommunicationChatThreadDeletedExample)
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatThreadDeleted event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatThreadDeletedEventData
  extends AcsChatThreadEventInThreadBaseProperties {
  ...AcsChatThreadDeletedBaseEventData;
}

// const MicrosoftCommunicationChatThreadPropertiesUpdatedPerUserExample: AcsChatThreadPropertiesUpdatedPerUserEventData = #{editedBy: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7d07-83fe-084822000f6e", editedByCommunicationIdentifier: #{rawId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7d07-83fe-084822000f6e", communicationUser: #{id: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7d07-83fe-084822000f6e"}}, editTime: "2021-02-19T00:28:28.7390282Z", properties: #{topic: "Communication in Azure"}, metadata: #{key: "value"}, createTime: "2021-02-19T00:28:25.864Z", version: 1613694508719, recipientId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7caf-07fd-084822001724", recipientCommunicationIdentifier: #{rawId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7caf-07fd-084822001724", communicationUser: #{id: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7caf-07fd-084822001724"}}, transactionId: "WLXPrnJ/I0+LTj2cwMrNMQ.1.1.1.1.1833369763.1.4", threadId: "19:2cc3504c41244d7483208a4f58a1f188@thread.v2"};
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
  metadata: Record<string>;

  /** The updated thread properties */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "The type of properties is object with additionalProperties: object"
  properties: Record<unknown>;
}

// const AcsChatThreadPropertiesUpdatedExample: AcsChatThreadPropertiesUpdatedEventData =
// #{
//   editedByCommunicationIdentifier: #{
//     rawId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5c9e-9e35-07fd-084822002264",
//     communicationUser: #{
//       id: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5c9e-9e35-07fd-084822002264"
//     }
//   },
//   editTime: utcDateTime.fromISO("2021-02-19T16:04:07.7152073-08:00"),
//   properties: #{
//     topic: "Talk about new Thread Events in commuication services"
//   },
//   metadata: #{
//     key: "value"
//   },
//   createTime: utcDateTime.fromISO("2021-02-19T16:00:40.126-08:00"),
//   version: 1613779447695,
//   threadId: "19:9e8eefe67b3c470a8187b4c2b00240bc@thread.v2",
//   transactionId: "GBE9MB2a40KEWzexIg0D3A.1.1.1.1.856359041.1"
// };
// @example(AcsChatThreadPropertiesUpdatedExample)
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatThreadPropertiesUpdated event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatThreadPropertiesUpdatedEventData
  extends AcsChatThreadEventInThreadBaseProperties {
  ...AcsChatThreadPropertiesBaseEventData;
}

//  const MicrosoftCommunicationChatParticipantAddedToThreadWithUserExample: AcsChatParticipantAddedToThreadWithUserEventData = #{time: utcDateTime.fromISO("2021-02-25T06:37:29.9232485Z"), addedByCommunicationIdentifier: #{rawId: "8:acs:0a420b29-555c-4f6b-841e-de8059893bb9_00000008-77c9-8767-1655-373a0d00885d", communicationUser: #{id: "8:acs:0a420b29-555c-4f6b-841e-de8059893bb9_00000008-77c9-8767-1655-373a0d00885d"}}, participantAdded: #{displayName: "John Smith", participantCommunicationIdentifier: #{rawId: "8:acs:0a420b29-555c-4f6b-841e-de8059893bb9_00000008-77c9-8785-1655-373a0d00885f", communicationUser: #{id: "8:acs:0a420b29-555c-4f6b-841e-de8059893bb9_00000008-77c9-8785-1655-373a0d00885f"}}, metadata: #{key: "value"}}, recipientCommunicationIdentifier: #{rawId: "8:acs:0a420b29-555c-4f6b-841e-de8059893bb9_00000008-77c9-8781-1655-373a0d00885e", communicationUser: #{id: "8:acs:0a420b29-555c-4f6b-841e-de8059893bb9_00000008-77c9-8781-1655-373a0d00885e"}}, createTime: "2021-02-25T06:37:17.371Z", version: 1614235049907, transactionId: "q7rr9by6m0CiGiQxKdSO1w.1.1.1.1.1473446055.1.6", threadId: "19:f1400e1c542f4086a606b52ad20cd0bd@thread.v2"};
// @example(MicrosoftCommunicationChatParticipantAddedToThreadWithUserExample)
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatParticipantAddedToThreadWithUser event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatParticipantAddedToThreadWithUserEventData
  extends AcsChatThreadEventBaseProperties {
  ...AcsChatParticipantBaseEventData;
}

//  const MicrosoftCommunicationChatParticipantRemovedFromThreadWithUserExample: AcsChatParticipantRemovedFromThreadWithUserEventData = #{time: "2021-02-25T06:40:20.3564556Z", removedByCommunicationIdentifier: #{rawId: "8:acs:0a420b29-555c-4f6b-841e-de8059893bb9_00000008-77c9-8767-1655-373a0d00885d", communicationUser: #{id: "8:acs:0a420b29-555c-4f6b-841e-de8059893bb9_00000008-77c9-8767-1655-373a0d00885d"}}, participantRemoved: #{displayName: "Bob", participantCommunicationIdentifier: #{rawId: "8:acs:0a420b29-555c-4f6b-841e-de8059893bb9_00000008-77c9-8785-1655-373a0d00885f", communicationUser: #{id: "8:acs:0a420b29-555c-4f6b-841e-de8059893bb9_00000008-77c9-8785-1655-373a0d00885f"}}, metadata: #{key: "value"}}, recipientCommunicationIdentifier: #{rawId: "8:acs:0a420b29-555c-4f6b-841e-de8059893bb9_00000008-77c9-8781-1655-373a0d00885e", communicationUser: #{id: "8:acs:0a420b29-555c-4f6b-841e-de8059893bb9_00000008-77c9-8781-1655-373a0d00885e"}}, createTime: "2021-02-25T06:37:17.371Z", version: 1614235220325, transactionId: "usv74GQ5zU+JmWv/bQ+qfg.1.1.1.1.1480065078.1.5", threadId: "19:f1400e1c542f4086a606b52ad20cd0bd@thread.v2"};
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

//  const MicrosoftCommunicationChatThreadParticipantAddedExample: AcsChatParticipantAddedToThreadEventData = #{time: utcDateTime.fromISO("2021-02-19T16:54:42.8622646-08:00"), addedByCommunicationIdentifier: #{rawId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5cbb-38a0-88f7-084822002453", communicationUser: #{id: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5cbb-38a0-88f7-084822002453"}}, participantAdded: #{displayName: "Bob", participantCommunicationIdentifier: #{rawId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5cbb-38f3-88f7-084822002454", communicationUser: #{id: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5cbb-38f3-88f7-084822002454"}}, metadata: #{key: "value"}}, createTime: "2021-02-19T16:31:54.365-08:00", version: 1613782482822, threadId: "19:e07c8ddc5bab4c059ea9f11d29b544b6@thread.v2", transactionId: "9q6cO7i4FkaZ+5RRVzshVw.1.1.1.1.974913783.1"};
// @example(MicrosoftCommunicationChatThreadParticipantAddedExample)
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.ChatThreadParticipantAdded event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsChatParticipantAddedToThreadEventData
  extends AcsChatEventInThreadBaseProperties {
  ...AcsChatParticipantBaseEventData;

  /** The version of the thread */
  version?: int64;
}

//  const MicrosoftCommunicationChatThreadParticipantRemovedExample: AcsChatParticipantRemovedFromThreadEventData = #{time: utcDateTime.fromISO("2021-02-19T16:56:18.1118825-08:00"), removedByCommunicationIdentifier: #{rawId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5cbb-38a0-88f7-084822002453", communicationUser: #{id: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5cbb-38a0-88f7-084822002453"}}, participantRemoved: #{displayName: "Shawn", participantCommunicationIdentifier: #{rawId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5cbb-38e6-07fd-084822002467", communicationUser: #{id: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5cbb-38e6-07fd-084822002467"}}, metadata: #{key: "value"}}, createTime: "2021-02-19T16:31:54.365-08:00", version: 1613782578096, threadId: "19:e07c8ddc5bab4c059ea9f11d29b544b6@thread.v2", transactionId: "zGCq8IGRr0aEF6COuy7wSA.1.1.1.1.978649284.1"};
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

const MicrosoftCommunicationSMSDeliveryReportReceivedExample: AcsSmsDeliveryReportReceivedEventData = #{
  messageId: "Outgoing_202009180022138813a09b-0cbf-4304-9b03-1546683bb910",
  from: "15555555555",
  to: "+15555555555",
  deliveryStatus: "Delivered",
  deliveryStatusDetails: "No error.",
  receivedTimestamp: utcDateTime.fromISO("2020-09-18T00:22:20.2855749Z"),
  deliveryAttempts: #[
    #{
      timestamp: utcDateTime.fromISO("2020-09-18T00:22:14.9315918Z"),
      segmentsSucceeded: 1,
      segmentsFailed: 0,
    }
  ],
};
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.SMSDeliveryReportReceived event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@example(MicrosoftCommunicationSMSDeliveryReportReceivedExample)
model AcsSmsDeliveryReportReceivedEventData extends AcsSmsEventBaseProperties {
  /** Status of Delivery */
  deliveryStatus?: string;

  /** Details about Delivery Status */
  deliveryStatusDetails?: string;

  /** List of details of delivery attempts made */
  @visibility(Lifecycle.Read)
  deliveryAttempts: AcsSmsDeliveryAttemptProperties[];

  /** The time at which the SMS delivery report was received */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  receivedTimestamp: utcDateTime;

  /** Customer Content */
  tag?: string;
}

const MicrosoftCommunicationSMSReceivedExample: AcsSmsReceivedEventData = #{
  messageId: "Incoming_20200918002745d29ebbea-3341-4466-9690-0a03af35228e",
  from: "15555555555",
  to: "15555555555",
  message: "Great to connect with ACS events",
  receivedTimestamp: utcDateTime.fromISO("2020-09-18T00:27:45.32Z"),
  segmentCount: 1,
};
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.SMSReceived event. */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@example(MicrosoftCommunicationSMSReceivedExample)
model AcsSmsReceivedEventData extends AcsSmsEventBaseProperties {
  /** The SMS content */
  message?: string;

  /** The time at which the SMS was received */
  @madeRequired(ServiceApiVersions.v2024_01_01)
  receivedTimestamp: utcDateTime;

  /** Number of segments in the message */
  segmentCount: int32;
}

//TODO: This might need some fixing

const MicrosoftCommunicationRecordingFileStatusUpdatedExample: AcsRecordingFileStatusUpdatedEventData = #{
  recordingStorageInfo: #{
    recordingChunks: #[
      #{
        documentId: "0-eus-d12-801b3f3fc462fe8a01e6810cbff729b8",
        index: 0,
        endReason: "SessionEnded",
        contentLocation: "https://storage.asm.skype.com/v1/objects/0-eus-d12-801b3f3fc462fe8a01e6810cbff729b8/content/video",
        metadataLocation: "https://storage.asm.skype.com/v1/objects/0-eus-d12-801b3f3fc462fe8a01e6810cbff729b8/content/acsmetadata",
        deleteLocation: "https://storage.asm.skype.com/v1/objects/0-eus-d12-801b3f3fc462fe8a01e6810cbff729b8/content/deletedata",
      }
    ],
  },
  recordingStartTime: utcDateTime.fromISO("2021-07-27T15:20:23.6089755Z"),
  recordingDurationMs: 6620,
  sessionEndReason: "CallEnded",
  recordingContentType: "Audio",
  recordingChannelType: "Mixed",
  recordingFormatType: "Mp3",
};
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

//  const MicrosoftCommunicationEmailDeliveryReportReceivedExample: AcsEmailDeliveryReportReceivedEventData = #{sender: "test2@contoso.org", recipient: "test1@contoso.com", messageId: "950850f5-bcdf-4315-b77a-6447cf56fac9", status: "delivered", deliveryAttemptTimestamp: "2023-02-09T19:46:12.2480265+00:00"};
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

const MicrosoftCommunicationEmailEngagementTrackingReportReceivedExample: AcsEmailEngagementTrackingReportReceivedEventData = #{
  sender: "test2@contoso.org",
  messageId: "fe26a737-6941-410c-b126-7eacbe4035d1",
  userActionTimestamp: utcDateTime.fromISO("2023-02-09T20:07:22.745555+00:00"),
  engagementContext: "www.example.com",
  userAgent: "Desktop",
  engagementType: "click",
};
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

const MicrosoftCommunicationRouterJobCancelledExample: AcsRouterJobCancelledEventData = #{
  note: "Cancelled due to <reason>",
  dispositionCode: "100",
  jobId: "7f1df17b-570b-4ae5-9cf5-fe6ff64cc712",
  channelReference: "test-abc",
  channelId: "FooVoiceChannelId",
  labels: #{ locale: "en-us", segment: "Enterprise", token: "FooToken" },
  tags: #{ locale: "en-us", segment: "Enterprise", token: "FooToken" },
  queueId: "",
};
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterJobCancelled event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@example(MicrosoftCommunicationRouterJobCancelledExample)
model AcsRouterJobCancelledEventData extends AcsRouterJobEventData {
  /** Router Job Note */
  note?: string;

  /** Router Job Disposition Code */
  dispositionCode?: string;
}

//  const MicrosoftCommunicationRouterJobClassificationFailedExample: AcsRouterJobClassificationFailedEventData = #{errors: #[#{code: null, message: "Classification failed due to <reason>", target: null, innererror: null, details: null}], jobId: "7f1df17b-570b-4ae5-9cf5-fe6ff64cc712", channelReference: "test-abc", channelId: "FooVoiceChannelId", classificationPolicyId: "test-policy", labels: #{locale: "en-us", segment: "Enterprise", token: "FooToken"}, tags: #{locale: "en-us", segment: "Enterprise", token: "FooToken"}};
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

//  const MicrosoftCommunicationRouterJobClassifiedExample: AcsRouterJobClassifiedEventData = #{queueDetails: #{id: "625fec06-ab81-4e60-b780-f364ed96ade1", name: "Queue 1", labels: #{language: "en", product: "Office", geo: "NA"}}, jobId: "7f1df17b-570b-4ae5-9cf5-fe6ff64cc712", channelReference: "test-abc", channelId: "FooVoiceChannelId", classificationPolicyId: "test-policy", queueId: "625fec06-ab81-4e60-b780-f364ed96ade1", priority: 5, labels: #{locale: "en-us", segment: "Enterprise", token: "FooToken"}, tags: #{locale: "en-us", segment: "Enterprise", token: "FooToken"}, attachedWorkerSelectors: #[#{key: "string", labelOperator: "equal", value: 5, ttlSeconds: "36"}]};
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

const MicrosoftCommunicationRouterJobClosedExample: AcsRouterJobClosedEventData = #{
  jobId: "7f1df17b-570b-4ae5-9cf5-fe6ff64cc712",
  channelReference: "test-abc",
  channelId: "FooVoiceChannelId",
  queueId: "",
  dispositionCode: "",
  workerId: "",
  assignmentId: "",
  labels: #{ locale: "en-us", segment: "Enterprise", token: "FooToken" },
  tags: #{ locale: "en-us", segment: "Enterprise", token: "FooToken" },
};
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

const MicrosoftCommunicationRouterJobCompletedExample: AcsRouterJobCompletedEventData = #{
  jobId: "7f1df17b-570b-4ae5-9cf5-fe6ff64cc712",
  channelReference: "test-abc",
  channelId: "FooVoiceChannelId",
  queueId: "queue-id",
  assignmentId: "6f1df17b-570b-4ae5-9cf5-fe6ff64cc712",
  labels: #{ locale: "en-us", segment: "Enterprise", token: "FooToken" },
  tags: #{ locale: "en-us", segment: "Enterprise", token: "FooToken" },
  workerId: "",
};
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterJobCompleted event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@example(MicrosoftCommunicationRouterJobCompletedExample)
model AcsRouterJobCompletedEventData extends AcsRouterJobEventData {
  /** Router Job Completed Assignment Id */
  assignmentId?: string;

  /** Router Job Completed Worker Id */
  workerId?: string;
}

const MicrosoftCommunicationRouterJobDeletedExample: AcsRouterJobDeletedEventData = #{
  jobId: "7f1df17b-570b-4ae5-9cf5-fe6ff64cc712",
  channelReference: "test-abc",
  channelId: "FooVoiceChannelId",
  labels: #{ locale: "en-us", segment: "Enterprise", token: "FooToken" },
  tags: #{ locale: "en-us", segment: "Enterprise", token: "FooToken" },
  queueId: "",
};
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterJobDeleted event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@example(MicrosoftCommunicationRouterJobDeletedExample)
model AcsRouterJobDeletedEventData extends AcsRouterJobEventData {}

const MicrosoftCommunicationRouterJobExceptionTriggeredExample: AcsRouterJobExceptionTriggeredEventData = #{
  ruleKey: "r100",
  exceptionRuleId: "7f1df17b-570b-4ae5-9cf5-fe6ff64cc712",
  jobId: "7f1df17b-570b-4ae5-9cf5-fe6ff64cc712",
  channelReference: "test-abc",
  channelId: "FooVoiceChannelId",
  labels: #{ locale: "en-us", segment: "Enterprise", token: "FooToken" },
  tags: #{ locale: "en-us", segment: "Enterprise", token: "FooToken" },
};
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterJobExceptionTriggered event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@example(MicrosoftCommunicationRouterJobExceptionTriggeredExample)
model AcsRouterJobExceptionTriggeredEventData extends AcsRouterJobEventData {
  /** Router Job Exception Triggered Rule Key */
  ruleKey?: string;

  /** Router Job Exception Triggered Rule Id */
  exceptionRuleId?: string;
}

//  const MicrosoftCommunicationRouterJobQueuedExample: AcsRouterJobQueuedEventData = #{jobId: "7f1df17b-570b-4ae5-9cf5-fe6ff64cc712", channelReference: "test-abc", channelId: "FooVoiceChannelId", queueId: "625fec06-ab81-4e60-b780-f364ed96ade1", priority: 1, labels: #{locale: "en-us", segment: "Enterprise", token: "FooToken"}, tags: #{locale: "en-us", segment: "Enterprise", token: "FooToken"}, requestedWorkerSelectors: #[#{key: "string", labelOperator: "equal", value: 5, ttl: "40"}], attachedWorkerSelectors: #[#{key: "string", labelOperator: "equal", value: 5, ttlSeconds: "39"}]};
// @example(MicrosoftCommunicationRouterJobQueuedExample)
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterJobQueued event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsRouterJobQueuedEventData extends AcsRouterJobEventData {
  /** Router Job Priority */
  priority?: int32;

  /** Router Job Queued Attached Worker Selector */
  @visibility(Lifecycle.Read)
  attachedWorkerSelectors: AcsRouterWorkerSelector[];

  /** Router Job Queued Requested Worker Selector */
  @visibility(Lifecycle.Read)
  requestedWorkerSelectors: AcsRouterWorkerSelector[];
}

//  const MicrosoftCommunicationRouterJobReceivedExample: AcsRouterJobReceivedEventData = #{jobId: "7f1df17b-570b-4ae5-9cf5-fe6ff64cc712", channelReference: "test-abc", jobStatus: "PendingClassification", channelId: "FooVoiceChannelId", classificationPolicyId: "test-policy", queueId: "queue-id", priority: 0, labels: #{locale: "en-us", segment: "Enterprise", token: "FooToken"}, tags: #{locale: "en-us", segment: "Enterprise", token: "FooToken"}, requestedWorkerSelectors: #[#{key: "string", labelOperator: "equal", value: 5, ttlSeconds: "36"}], scheduledOn: utcDateTime.fromISO("2022-02-17T00:55:25.1736293Z"), unavailableForMatching: false};
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

//  const MicrosoftCommunicationRouterJobSchedulingFailedExample: AcsRouterJobSchedulingFailedEventData = #{jobId: "7f1df17b-570b-4ae5-9cf5-fe6ff64cc712", channelId: "FooVoiceChannelId", channelReference: "test-abc", queueId: "queue-id", priority: 1, labels: #{locale: "en-us", segment: "Enterprise", token: "FooToken"}, tags: #{locale: "en-us", segment: "Enterprise", token: "FooToken"}, requestedWorkerSelectors: #[#{key: "string", labelOperator: "equal", value: 5, ttlSeconds: "36"}], attachedWorkerSelectors: #[#{key: "string", labelOperator: "equal", value: 5, ttlSeconds: "30"}], scheduledOn: "2022-02-17T00:55:25.1736293Z", failureReason: "Expired Job"};
// @example(MicrosoftCommunicationRouterJobSchedulingFailedExample)
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterJobSchedulingFailed event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsRouterJobSchedulingFailedEventData extends AcsRouterJobEventData {
  /** Router Job Priority */
  priority?: int32;

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

const MicrosoftCommunicationRouterJobUnassignedExample: AcsRouterJobUnassignedEventData = #{
  jobId: "7f1df17b-570b-4ae5-9cf5-fe6ff64cc712",
  assignmentId: "",
  workerId: "",
  channelId: "FooVoiceChannelId",
  channelReference: "test-abc",
  queueId: "queue-id",
  labels: #{ locale: "en-us", segment: "Enterprise", token: "FooToken" },
  tags: #{ locale: "en-us", segment: "Enterprise", token: "FooToken" },
};
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterJobUnassigned event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@example(MicrosoftCommunicationRouterJobUnassignedExample)
model AcsRouterJobUnassignedEventData extends AcsRouterJobEventData {
  /** Router Job Unassigned Assignment Id */
  assignmentId?: string;

  /** Router Job Unassigned Worker Id */
  workerId?: string;
}

//  const MicrosoftCommunicationRouterJobWaitingForActivationExample: AcsRouterJobWaitingForActivationEventData = #{jobId: "7f1df17b-570b-4ae5-9cf5-fe6ff64cc712", channelId: "FooVoiceChannelId", channelReference: "test-abc", queueId: "queue-id", priority: 1, labels: #{locale: "en-us", segment: "Enterprise", token: "FooToken"}, tags: #{locale: "en-us", segment: "Enterprise", token: "FooToken"}, requestedWorkerSelectors: #[#{key: "string", labelOperator: "equal", value: 5, ttlSeconds: "45"}], attachedWorkerSelectors: #[#{key: "string", labelOperator: "equal", value: 5, ttlSeconds: "32"}], scheduledOn: "2022-02-17T00:55:25.1736293Z", unavailableForMatching: false};
// @example(MicrosoftCommunicationRouterJobWaitingForActivationExample)
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterJobWaitingForActivation event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
model AcsRouterJobWaitingForActivationEventData extends AcsRouterJobEventData {
  /** Router Job Waiting For Activation Priority */
  priority?: int32;

  /** Router Job Waiting For Activation Worker Selector Expired */
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

//  const MicrosoftCommunicationRouterJobWorkerSelectorsExpiredExample: AcsRouterJobWorkerSelectorsExpiredEventData = #{jobId: "7f1df17b-570b-4ae5-9cf5-fe6ff64cc712", channelReference: "test-abc", channelId: "FooVoiceChannelId", queueId: "625fec06-ab81-4e60-b780-f364ed96ade1", labels: #{locale: "en-us", segment: "Enterprise", token: "FooToken"}, tags: #{locale: "en-us", segment: "Enterprise", token: "FooToken"}, expiredRequestedWorkerSelectors: #[#{key: "string", labelOperator: "equal", value: 5, ttlSeconds: "30"}], attachedWorkerSelectorsExpired: #[#{key: "string", labelOperator: "equal", value: 5, ttlSeconds: "35"}]};
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

const MicrosoftCommunicationRouterWorkerDeletedExample: AcsRouterWorkerDeletedEventData = #{
  workerId: "worker3",
};
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterWorkerDeleted event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@example(MicrosoftCommunicationRouterWorkerDeletedExample)
model AcsRouterWorkerDeletedEventData extends AcsRouterWorkerEventData {}

const MicrosoftCommunicationRouterWorkerDeregisteredExample: AcsRouterWorkerDeregisteredEventData = #{
  workerId: "worker3",
};
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterWorkerDeregistered event */
@example(MicrosoftCommunicationRouterWorkerDeregisteredExample)
model AcsRouterWorkerDeregisteredEventData {
  /** Router Worker Deregistered Worker Id */
  workerId?: string;
}

//  const MicrosoftCommunicationRouterWorkerOfferAcceptedExample: AcsRouterWorkerOfferAcceptedEventData = #{workerId: "w100", jobId: "7f1df17b-570b-4ae5-9cf5-fe6ff64cc712", jobPriority: 5, jobLabels: #{locale: "en-us", segment: "Enterprise", token: "FooToken"}, jobTags: #{locale: "en-us", segment: "Enterprise", token: "FooToken"}, channelReference: "test-abc", channelId: "FooVoiceChannelId", queueId: "625fec06-ab81-4e60-b780-f364ed96ade1", offerId: "565fec06-ab81-4e60-b780-f364ed96ade1", assignmentId: "765fec06-ab81-4e60-b780-f364ed96ade1"};
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

const MicrosoftCommunicationRouterWorkerOfferDeclinedExample: AcsRouterWorkerOfferDeclinedEventData = #{
  workerId: "w100",
  jobId: "7f1df17b-570b-4ae5-9cf5-fe6ff64cc712",
  channelReference: "test-abc",
  channelId: "FooVoiceChannelId",
  queueId: "625fec06-ab81-4e60-b780-f364ed96ade1",
  offerId: "565fec06-ab81-4e60-b780-f364ed96ade1",
};
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterWorkerOfferDeclined event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@example(MicrosoftCommunicationRouterWorkerOfferDeclinedExample)
model AcsRouterWorkerOfferDeclinedEventData extends AcsRouterWorkerEventData {
  /** Router Worker Offer Declined Queue Id */
  queueId?: string;

  /** Router Worker Offer Declined Offer Id */
  offerId?: string;
}

const MicrosoftCommunicationRouterWorkerOfferExpiredExample: AcsRouterWorkerOfferExpiredEventData = #{
  offerId: "565fec06-ab81-4e60-b780-f364ed96ade1",
  workerId: "w100",
  jobId: "7f1df17b-570b-4ae5-9cf5-fe6ff64cc712",
  channelReference: "test-abc",
  channelId: "FooVoiceChannelId",
  queueId: "625fec06-ab81-4e60-b780-f364ed96ade1",
};
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterWorkerOfferExpired event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@example(MicrosoftCommunicationRouterWorkerOfferExpiredExample)
model AcsRouterWorkerOfferExpiredEventData extends AcsRouterWorkerEventData {
  /** Router Worker Offer Expired Queue Id */
  queueId?: string;

  /** Router Worker Offer Expired Offer Id */
  offerId?: string;
}

//  const MicrosoftCommunicationRouterWorkerOfferIssuedExample: AcsRouterWorkerOfferIssuedEventData = #{workerId: "w100", jobId: "7f1df17b-570b-4ae5-9cf5-fe6ff64cc712", channelReference: "test-abc", channelId: "FooVoiceChannelId", queueId: "625fec06-ab81-4e60-b780-f364ed96ade1", offerId: "525fec06-ab81-4e60-b780-f364ed96ade1", offeredOn: "2021-06-23T02:43:30.3847144Z", expiresOn: "2021-06-23T02:44:30.3847674Z", jobPriority: 5, jobLabels: #{locale: "en-us", segment: "Enterprise", token: "FooToken"}, jobTags: #{locale: "en-us", segment: "Enterprise", token: "FooToken"}};
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

const MicrosoftCommunicationRouterWorkerOfferRevokedExample: AcsRouterWorkerOfferRevokedEventData = #{
  offerId: "565fec06-ab81-4e60-b780-f364ed96ade1",
  workerId: "w100",
  jobId: "7f1df17b-570b-4ae5-9cf5-fe6ff64cc712",
  channelReference: "test-abc",
  channelId: "FooVoiceChannelId",
  queueId: "625fec06-ab81-4e60-b780-f364ed96ade1",
};
/** Schema of the Data property of an EventGridEvent for a Microsoft.Communication.RouterWorkerOfferRevoked event */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "Maintain compatibility with existing models."
@example(MicrosoftCommunicationRouterWorkerOfferRevokedExample)
model AcsRouterWorkerOfferRevokedEventData extends AcsRouterWorkerEventData {
  /** Router Worker Offer Revoked Queue Id */
  queueId?: string;

  /** Router Worker Offer Revoked Offer Id */
  offerId?: string;
}

const MicrosoftCommunicationRouterWorkerRegisteredExample: AcsRouterWorkerRegisteredEventData = #{
  workerId: "worker3",
  totalCapacity: 100,
  queueAssignments: #[
    #{
      id: "MyQueueId2",
      name: "Queue 3",
      labels: #{ language: "en", product: "Office", geo: "NA" },
    }
  ],
  labels: #{ x: "111", y: "111" },
  channelConfigurations: #[
    #{
      channelId: "FooVoiceChannelId",
      capacityCostPerJob: 10,
      maxNumberOfJobs: 5,
    }
  ],
  tags: #{ locale: "en-us", segment: "Enterprise", token: "FooToken" },
};
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
  @visibility(Lifecycle.Read)
  errors: AcsRouterCommunicationError[];
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
  messageId?: string;

  /** The communication identifier of the sender */
  senderCommunicationIdentifier: CommunicationIdentifierModel;

  /** The display name of the sender */
  senderDisplayName?: string;

  /** The original compose time of the message */
  @madeRequired(ServiceApiVersions.v2024_01_01)
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
  @madeRequired(ServiceApiVersions.v2024_01_01)
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
  @madeRequired(ServiceApiVersions.v2024_01_01)
  timestamp: utcDateTime;

  /** Number of segments that were successfully delivered */
  segmentsSucceeded?: int32;

  /** Number of segments whose delivery failed */
  segmentsFailed?: int32;
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
  @madeRequired(ServiceApiVersions.v2024_01_01)
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

const MicrosoftCommunicationRouterWorkerUpdatedExample: AcsRouterWorkerUpdatedEventData = #{
  workerId: "worker3",
  totalCapacity: 100,
  queueAssignments: #[
    #{
      id: "MyQueueId2",
      name: "Queue 3",
      labels: #{ language: "en", product: "Office", geo: "NA" },
    }
  ],
  labels: #{ x: "111", y: "111" },
  channelConfigurations: #[
    #{
      channelId: "FooVoiceChannelId",
      capacityCostPerJob: 10,
      maxNumberOfJobs: 5,
    }
  ],
  tags: #{ locale: "en-us", segment: "Enterprise", token: "FooToken" },
  updatedWorkerProperties: #["TotalCapacity", "Labels", "Tags"],
};
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

const MicrosoftCommunicationAdvancedMessageDeliveryStatusUpdatedExample: AcsMessageDeliveryStatusUpdatedEventData = #{
  messageId: "d59f9468-0a5c-4022-8200-d7bf6fb78bc5",
  status: "delivered",
  channelType: "whatsapp",
  from: "12375679879",
  to: "1345679879",
  receivedTimeStamp: utcDateTime.fromISO("2024-03-22T17:06:11.1980225+00:00"),
  error: #{ channelCode: "channelCode", channelMessage: "channelMessage" },
};
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

const MicrosoftCommunicationAdvancedMessageReceivedExample: AcsMessageReceivedEventData = #{
  content: "Come on guys, lets go for lunch together.",
  messageId: "messageId",
  channelType: "whatsapp",
  messageType: "messageType",
  media: #{
    mimeType: "mimeType",
    id: "mediaId",
    fileName: "fileName",
    caption: "caption",
    animated: true,
  },
  reaction: #{ messageId: "messageId", emoji: "emoji" },
  context: #{ from: "1234578988", id: "messageId" },
  button: #{ text: "button text", payload: "payload" },
  interactive: #{
    type: "buttonReply",
    buttonReply: #{ id: "buttonId", title: "button reply" },
  },
  from: "12375679879",
  to: "1345679879",
  receivedTimeStamp: utcDateTime.fromISO("2024-03-22T17:06:11.2610383+00:00"),
  error: #{ channelCode: "channelCode", channelMessage: "channelMessage" },
};
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
