import "./AzureCommunicationServices.tsp";
namespace Microsoft.EventGrid.SystemEvents;

// const MicrosoftCommunicationIncomingCallExample: AcsIncomingCallEventData = #{to: #{kind: "communicationUser", rawId: "{recipient-id}", communicationUser: #{id: "{recipient-id}"}}, from: #{kind: "communicationUser", rawId: "{caller-id}", communicationUser: #{id: "{caller-id}"}}, serverCallId: "{server-call-id}", callerDisplayName: "VOIP Caller", customContext: #{sipHeaders: #{userToUser: "616d617a6f6e5f6368696;encoding=hex", "X-MS-Custom-my-header1": "35567842", "X-MS-Custom-my-header2": "customsipheadervalue"}, voipHeaders: #{customHeader: "customValue"}, onBehalfOfCallee: #{kind: "communicationUser", rawId: "{caller-id}", communicationUser: #{id: "{caller-id}"}}}, incomingCallContext: "{incoming-call-contextValue}", correlationId: "correlationId"};

// const MicrosoftCommunicationUserDisconnectedExample: AcsUserDisconnectedEventData = #{userCommunicationIdentifier: #{rawId: "8:acs:5354158b-17b7-489c-9380-95d8821ff76b_0000000c-6c47-7dfd-6d70-224822000cfb", communicationUser: #{id: "8:acs:5354158b-17b7-489c-9380-95d8821ff76b_0000000c-6c47-7dfd-6d70-224822000cfb"}}};

// const MicrosoftCommunicationChatMessageReceivedExample: AcsChatMessageReceivedEventData = #{
//   messageBody: "Welcome to Azure Communication Services",
//   messageId: "1613694358927",
//   metadata: #{
//     key: "value",
//     description: "A map of data associated with the message",
//   },
//   senderId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7caf-07fd-084822001724",
//   senderCommunicationIdentifier: #{
//     rawId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7caf-07fd-084822001724",
//     communicationUser: #{
//       id: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7caf-07fd-084822001724",
//     },
//   },
//   senderDisplayName: "Jhon",
//   composeTime: "2021-02-19T00:25:58.927Z",
//   type: "Text",
//   version: 1613694358927,
//   recipientId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7d05-83fe-084822000f6d",
//   recipientCommunicationIdentifier: #{
//     rawId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7d05-83fe-084822000f6d",
//     communicationUser: #{
//       id: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7d05-83fe-084822000f6d",
//     },
//   },
//   transactionId: "oh+LGB2dUUadMcTAdRWQxQ.1.1.1.1.1827536918.1.7",
//   threadId: "19:6e5d6ca1d75044a49a36a7965ec4a906@thread.v2",
// };

// const MicrosoftCommunicationChatMessageReceivedInThreadExample: AcsChatMessageReceivedInThreadEventData = #{
//   messageBody: "Talk about new Thread Events in communication services",
//   messageId: "1613783230064",
//   metadata: #{
//     key: "value",
//     description: "A map of data associated with the message",
//   },
//   type: "Text",
//   version: "1613783230064",
//   senderDisplayName: "Bob",
//   senderCommunicationIdentifier: #{
//     rawId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5cdb-4916-07fd-084822002624",
//     communicationUser: #{
//       id: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5cdb-4916-07fd-084822002624",
//     },
//   },
//   composeTime: "2021-02-19T17:07:10.064-08:00",
//   threadId: "19:5b3809e80e4a439d92c3316e273f4a2b@thread.v2",
//   transactionId: "foMkntkKS0O/MhMlIE5Aag.1.1.1.1.1004077250.1",
// };

// const MicrosoftCommunicationChatMessageEditedExample: AcsChatMessageEditedEventData = #{
//   editTime: utcDateTime.fromISO("2021-02-19T00:28:20.784Z"),
//   messageBody: "Let's Chat about new communication services.",
//   messageId: "1613694357917",
//   metadata: #{
//     key: "value",
//     description: "A map of data associated with the message",
//   },
//   senderId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7caf-07fd-084822001724",
//   senderCommunicationIdentifier: #{
//     rawId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7caf-07fd-084822001724",
//     communicationUser: #{
//       id: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7caf-07fd-084822001724",
//     },
//   },
//   senderDisplayName: "Bob(Admin)",
//   composeTime: "2021-02-19T00:25:57.917Z",
//   type: "Text",
//   version: 1613694500784,
//   recipientId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7d60-83fe-084822000f6f",
//   recipientCommunicationIdentifier: #{
//     rawId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7d60-83fe-084822000f6f",
//     communicationUser: #{
//       id: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7d60-83fe-084822000f6f",
//     },
//   },
//   transactionId: "1mL4XZH2gEecu/alk9tOtw.2.1.2.1.1833042153.1.7",
//   threadId: "19:6e5d6ca1d75044a49a36a7965ec4a906@thread.v2",
// };

// const MicrosoftCommunicationChatMessageEditedInThreadExample: AcsChatMessageEditedInThreadEventData = #{
//   editTime: utcDateTime.fromISO("2021-02-19T16:59:10.464-08:00"),
//   messageBody: "8effb181-1eb2-4a58-9d03-ed48a461b19b",
//   messageId: "1613782685964",
//   metadata: #{
//     key: "value",
//     description: "A map of data associated with the message",
//   },
//   type: "Text",
//   version: "1613782750464",
//   senderDisplayName: "Scott",
//   senderCommunicationIdentifier: #{
//     rawId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5cbb-38a0-88f7-084822002453",
//     communicationUser: #{
//       id: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5cbb-38a0-88f7-084822002453",
//     },
//   },
//   composeTime: "2021-02-19T16:58:05.964-08:00",
//   threadId: "19:e07c8ddc5bab4c059ea9f11d29b544b6@thread.v2",
//   transactionId: "H8Gpj3NkIU6bXlWw8WPvhQ.2.1.2.1.985333801.1",
// };

// const MicrosoftCommunicationChatMessageDeletedExample: AcsChatMessageDeletedEventData = #{deleteTime: "2021-02-19T00:43:10.14Z", messageId: "1613695388152", senderId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7d07-83fe-084822000f6e", senderCommunicationIdentifier: #{rawId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7d07-83fe-084822000f6e", communicationUser: #{id: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7d07-83fe-084822000f6e"}}, senderDisplayName: "Bob(Admin)", composeTime: "2021-02-19T00:43:08.152Z", type: "Text", version: 1613695390361, recipientId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7d60-83fe-084822000f6f", recipientCommunicationIdentifier: #{rawId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7d60-83fe-084822000f6f", communicationUser: #{id: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7d60-83fe-084822000f6f"}}, transactionId: "fFs4InlBn0O/0WyhfQZVSQ.1.1.2.1.1867776045.1.4", threadId: "19:48899258eec941e7a281e03edc8f4964@thread.v2"};

// const MicrosoftCommunicationChatMessageDeletedInThreadExample: AcsChatMessageDeletedInThreadEventData = #{
//   deleteTime: utcDateTime.fromISO("2021-02-19T16:59:10.464-08:00"),
//   messageId: "1613782685440",
//   type: "Text",
//   version: "1613782814333",
//   senderDisplayName: "Scott",
//   senderCommunicationIdentifier: #{
//     rawId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5cbb-38a0-88f7-084822002453",
//     communicationUser: #{
//       id: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5cbb-38a0-88f7-084822002453",
//     },
//   },
//   composeTime: "2021-02-19T16:58:05.44-08:00",
//   threadId: "19:e07c8ddc5bab4c059ea9f11d29b544b6@thread.v2",
//   transactionId: "HqU6PeK5AkCRSpW8eAbL0A.1.1.2.1.987824181.1",
// };

// const MicrosoftCommunicationChatThreadCreatedWithUserExample: AcsChatThreadCreatedWithUserEventData = #{createdBy: "8:acs:3d703c91-9657-4b3f-b19c-ef9d53f99710_00000008-576c-286d-e1fe-0848220013b9", createdByCommunicationIdentifier: #{rawId: "8:acs:3d703c91-9657-4b3f-b19c-ef9d53f99710_00000008-576c-286d-e1fe-0848220013b9", communicationUser: #{id: "8:acs:3d703c91-9657-4b3f-b19c-ef9d53f99710_00000008-576c-286d-e1fe-0848220013b9"}}, properties: #{topic: "Chat about new communication services"}, members: #[#{displayName: "Bob", memberId: "8:acs:3d703c91-9657-4b3f-b19c-ef9d53f99710_00000008-576c-286d-e1fe-0848220013b9"}, #{displayName: "John", memberId: "8:acs:3d703c91-9657-4b3f-b19c-ef9d53f99710_00000008-576c-289b-07fd-0848220015ea"}], participants: #[#{displayName: "Bob", participantCommunicationIdentifier: #{rawId: "8:acs:3d703c91-9657-4b3f-b19c-ef9d53f99710_00000008-576c-286d-e1fe-0848220013b9", communicationUser: #{id: "8:acs:3d703c91-9657-4b3f-b19c-ef9d53f99710_00000008-576c-286d-e1fe-0848220013b9"}}, metadata: #{key: "value"}}, #{displayName: "John", participantCommunicationIdentifier: #{rawId: "8:acs:3d703c91-9657-4b3f-b19c-ef9d53f99710_00000008-576c-289b-07fd-0848220015ea", communicationUser: #{id: "8:acs:3d703c91-9657-4b3f-b19c-ef9d53f99710_00000008-576c-289b-07fd-0848220015ea"}}, metadata: #{key: "value"}}], metadata: #{key: "value"}, createTime: "2021-02-18T23:47:26.91Z", version: 1613692046910, recipientId: "8:acs:3d703c91-9657-4b3f-b19c-ef9d53f99710_00000008-576c-286e-84f5-08482200181c", recipientCommunicationIdentifier: #{rawId: "8:acs:3d703c91-9657-4b3f-b19c-ef9d53f99710_00000008-576c-286e-84f5-08482200181c", communicationUser: #{id: "8:acs:3d703c91-9657-4b3f-b19c-ef9d53f99710_00000008-576c-286e-84f5-08482200181c"}}, transactionId: "zbZt+9h/N0em+XCW2QvyIA.1.1.1.1.1737228330.0.1737490483.1.6", threadId: "19:1d594fb1eeb14566903cbc5decb5bf5b@thread.v2"};

// const MicrosoftCommunicationChatThreadWithUserDeletedExample: AcsChatThreadWithUserDeletedEventData = #{deletedBy: "8:acs:3d703c91-9657-4b3f-b19c-ef9d53f99710_00000008-5772-6473-83fe-084822000e21", deletedByCommunicationIdentifier: #{rawId: "8:acs:3d703c91-9657-4b3f-b19c-ef9d53f99710_00000008-5772-6473-83fe-084822000e21", communicationUser: #{id: "8:acs:3d703c91-9657-4b3f-b19c-ef9d53f99710_00000008-5772-6473-83fe-084822000e21"}}, deleteTime: "2021-02-18T23:57:51.5987591Z", createTime: "2021-02-18T23:54:15.683Z", version: 1613692578672, recipientId: "8:acs:3d703c91-9657-4b3f-b19c-ef9d53f99710_00000008-5772-647b-e1fe-084822001416", recipientCommunicationIdentifier: #{rawId: "8:acs:3d703c91-9657-4b3f-b19c-ef9d53f99710_00000008-5772-647b-e1fe-084822001416", communicationUser: #{id: "8:acs:3d703c91-9657-4b3f-b19c-ef9d53f99710_00000008-5772-647b-e1fe-084822001416"}}, transactionId: "mrliWVUndEmLwkZbeS5KoA.1.1.2.1.1761607918.1.6", threadId: "19:5870b8f021d74fd786bf5aeb095da291@thread.v2"};

// const MicrosoftCommunicationChatThreadDeletedExample: AcsChatThreadDeletedEventData = #{deletedByCommunicationIdentifier: #{rawId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5c9e-a300-07fd-084822002266", communicationUser: #{id: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5c9e-a300-07fd-084822002266"}}, deleteTime: "2021-02-19T16:00:42.109802-08:00", createTime: "2021-02-19T16:00:39.947-08:00", version: 1613779241389, threadId: "19:c9e9f3060b884e448671391882066ac3@thread.v2", transactionId: "KibptDpcLEeEFnlR7cI3QA.1.1.2.1.848298005.1"};

// const MicrosoftCommunicationChatThreadPropertiesUpdatedPerUserExample: AcsChatThreadPropertiesUpdatedPerUserEventData = #{editedBy: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7d07-83fe-084822000f6e", editedByCommunicationIdentifier: #{rawId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7d07-83fe-084822000f6e", communicationUser: #{id: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7d07-83fe-084822000f6e"}}, editTime: "2021-02-19T00:28:28.7390282Z", properties: #{topic: "Communication in Azure"}, metadata: #{key: "value"}, createTime: "2021-02-19T00:28:25.864Z", version: 1613694508719, recipientId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7caf-07fd-084822001724", recipientCommunicationIdentifier: #{rawId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7caf-07fd-084822001724", communicationUser: #{id: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7caf-07fd-084822001724"}}, transactionId: "WLXPrnJ/I0+LTj2cwMrNMQ.1.1.1.1.1833369763.1.4", threadId: "19:2cc3504c41244d7483208a4f58a1f188@thread.v2"};

// const MicrosoftCommunicationChatParticipantAddedToThreadWithUserExample: AcsChatParticipantAddedToThreadWithUserEventData = #{
//   time: utcDateTime.fromISO("2021-02-25T06:37:29.9232485Z"),
//   addedByCommunicationIdentifier: #{
//     rawId: "8:acs:0a420b29-555c-4f6b-841e-de8059893bb9_00000008-77c9-8767-1655-373a0d00885d",
//     communicationUser: #{
//       id: "8:acs:0a420b29-555c-4f6b-841e-de8059893bb9_00000008-77c9-8767-1655-373a0d00885d",
//     },
//   },
//   participantAdded: #{
//     displayName: "John Smith",
//     participantCommunicationIdentifier: #{
//       rawId: "8:acs:0a420b29-555c-4f6b-841e-de8059893bb9_00000008-77c9-8785-1655-373a0d00885f",
//       communicationUser: #{
//         id: "8:acs:0a420b29-555c-4f6b-841e-de8059893bb9_00000008-77c9-8785-1655-373a0d00885f",
//       },
//     },
//     metadata: #{ key: "value" },
//   },
//   recipientCommunicationIdentifier: #{
//     rawId: "8:acs:0a420b29-555c-4f6b-841e-de8059893bb9_00000008-77c9-8781-1655-373a0d00885e",
//     communicationUser: #{
//       id: "8:acs:0a420b29-555c-4f6b-841e-de8059893bb9_00000008-77c9-8781-1655-373a0d00885e",
//     },
//   },
//   createTime: "2021-02-25T06:37:17.371Z",
//   version: 1614235049907,
//   transactionId: "q7rr9by6m0CiGiQxKdSO1w.1.1.1.1.1473446055.1.6",
//   threadId: "19:f1400e1c542f4086a606b52ad20cd0bd@thread.v2",
// };

// const MicrosoftCommunicationChatParticipantRemovedFromThreadWithUserExample: AcsChatParticipantRemovedFromThreadWithUserEventData = #{time: "2021-02-25T06:40:20.3564556Z", removedByCommunicationIdentifier: #{rawId: "8:acs:0a420b29-555c-4f6b-841e-de8059893bb9_00000008-77c9-8767-1655-373a0d00885d", communicationUser: #{id: "8:acs:0a420b29-555c-4f6b-841e-de8059893bb9_00000008-77c9-8767-1655-373a0d00885d"}}, participantRemoved: #{displayName: "Bob", participantCommunicationIdentifier: #{rawId: "8:acs:0a420b29-555c-4f6b-841e-de8059893bb9_00000008-77c9-8785-1655-373a0d00885f", communicationUser: #{id: "8:acs:0a420b29-555c-4f6b-841e-de8059893bb9_00000008-77c9-8785-1655-373a0d00885f"}}, metadata: #{key: "value"}}, recipientCommunicationIdentifier: #{rawId: "8:acs:0a420b29-555c-4f6b-841e-de8059893bb9_00000008-77c9-8781-1655-373a0d00885e", communicationUser: #{id: "8:acs:0a420b29-555c-4f6b-841e-de8059893bb9_00000008-77c9-8781-1655-373a0d00885e"}}, createTime: "2021-02-25T06:37:17.371Z", version: 1614235220325, transactionId: "usv74GQ5zU+JmWv/bQ+qfg.1.1.1.1.1480065078.1.5", threadId: "19:f1400e1c542f4086a606b52ad20cd0bd@thread.v2"};

// const MicrosoftCommunicationChatThreadParticipantAddedExample: AcsChatParticipantAddedToThreadEventData = #{
//   time: utcDateTime.fromISO("2021-02-19T16:54:42.8622646-08:00"),
//   addedByCommunicationIdentifier: #{
//     rawId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5cbb-38a0-88f7-084822002453",
//     communicationUser: #{
//       id: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5cbb-38a0-88f7-084822002453",
//     },
//   },
//   participantAdded: #{
//     displayName: "Bob",
//     participantCommunicationIdentifier: #{
//       rawId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5cbb-38f3-88f7-084822002454",
//       communicationUser: #{
//         id: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5cbb-38f3-88f7-084822002454",
//       },
//     },
//     metadata: #{ key: "value" },
//   },
//   createTime: "2021-02-19T16:31:54.365-08:00",
//   version: 1613782482822,
//   threadId: "19:e07c8ddc5bab4c059ea9f11d29b544b6@thread.v2",
//   transactionId: "9q6cO7i4FkaZ+5RRVzshVw.1.1.1.1.974913783.1",
// };

// const MicrosoftCommunicationChatThreadParticipantRemovedExample: AcsChatParticipantRemovedFromThreadEventData = #{
//   time: utcDateTime.fromISO("2021-02-19T16:56:18.1118825-08:00"),
//   removedByCommunicationIdentifier: #{
//     rawId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5cbb-38a0-88f7-084822002453",
//     communicationUser: #{
//       id: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5cbb-38a0-88f7-084822002453",
//     },
//   },
//   participantRemoved: #{
//     displayName: "Shawn",
//     participantCommunicationIdentifier: #{
//       rawId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5cbb-38e6-07fd-084822002467",
//       communicationUser: #{
//         id: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5cbb-38e6-07fd-084822002467",
//       },
//     },
//     metadata: #{ key: "value" },
//   },
//   createTime: "2021-02-19T16:31:54.365-08:00",
//   version: 1613782578096,
//   threadId: "19:e07c8ddc5bab4c059ea9f11d29b544b6@thread.v2",
//   transactionId: "zGCq8IGRr0aEF6COuy7wSA.1.1.1.1.978649284.1",
// };

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

const MicrosoftCommunicationSMSReceivedExample: AcsSmsReceivedEventData = #{
  messageId: "Incoming_20200918002745d29ebbea-3341-4466-9690-0a03af35228e",
  from: "15555555555",
  to: "15555555555",
  message: "Great to connect with ACS events",
  receivedTimestamp: utcDateTime.fromISO("2020-09-18T00:27:45.32Z"),
  segmentCount: 1,
};

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

// const MicrosoftCommunicationEmailDeliveryReportReceivedExample: AcsEmailDeliveryReportReceivedEventData = #{sender: "test2@contoso.org", recipient: "test1@contoso.com", messageId: "950850f5-bcdf-4315-b77a-6447cf56fac9", status: "delivered", deliveryAttemptTimestamp: "2023-02-09T19:46:12.2480265+00:00"};

const MicrosoftCommunicationEmailEngagementTrackingReportReceivedExample: AcsEmailEngagementTrackingReportReceivedEventData = #{
  sender: "test2@contoso.org",
  messageId: "fe26a737-6941-410c-b126-7eacbe4035d1",
  userActionTimestamp: utcDateTime.fromISO("2023-02-09T20:07:22.745555+00:00"),
  engagementContext: "www.example.com",
  userAgent: "Desktop",
  engagementType: "click",
};

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

// const MicrosoftCommunicationRouterJobClassificationFailedExample: AcsRouterJobClassificationFailedEventData = #{errors: #[#{code: null, message: "Classification failed due to <reason>", target: null, innererror: null, details: null}], jobId: "7f1df17b-570b-4ae5-9cf5-fe6ff64cc712", channelReference: "test-abc", channelId: "FooVoiceChannelId", classificationPolicyId: "test-policy", labels: #{locale: "en-us", segment: "Enterprise", token: "FooToken"}, tags: #{locale: "en-us", segment: "Enterprise", token: "FooToken"}};

// const MicrosoftCommunicationRouterJobClassifiedExample: AcsRouterJobClassifiedEventData = #{
//   queueDetails: #{
//     id: "625fec06-ab81-4e60-b780-f364ed96ade1",
//     name: "Queue 1",
//     labels: #{ language: "en", product: "Office", geo: "NA" },
//   },
//   jobId: "7f1df17b-570b-4ae5-9cf5-fe6ff64cc712",
//   channelReference: "test-abc",
//   channelId: "FooVoiceChannelId",
//   classificationPolicyId: "test-policy",
//   queueId: "625fec06-ab81-4e60-b780-f364ed96ade1",
//   priority: 5,
//   labels: #{ locale: "en-us", segment: "Enterprise", token: "FooToken" },
//   tags: #{ locale: "en-us", segment: "Enterprise", token: "FooToken" },
//   attachedWorkerSelectors: #[
//     #{ key: "string", labelOperator: "equal", value: 5, ttlSeconds: "36" }
//   ],
// };

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

const MicrosoftCommunicationRouterJobDeletedExample: AcsRouterJobDeletedEventData = #{
  jobId: "7f1df17b-570b-4ae5-9cf5-fe6ff64cc712",
  channelReference: "test-abc",
  channelId: "FooVoiceChannelId",
  labels: #{ locale: "en-us", segment: "Enterprise", token: "FooToken" },
  tags: #{ locale: "en-us", segment: "Enterprise", token: "FooToken" },
  queueId: "",
};

const MicrosoftCommunicationRouterJobExceptionTriggeredExample: AcsRouterJobExceptionTriggeredEventData = #{
  ruleKey: "r100",
  exceptionRuleId: "7f1df17b-570b-4ae5-9cf5-fe6ff64cc712",
  jobId: "7f1df17b-570b-4ae5-9cf5-fe6ff64cc712",
  channelReference: "test-abc",
  channelId: "FooVoiceChannelId",
  labels: #{ locale: "en-us", segment: "Enterprise", token: "FooToken" },
  tags: #{ locale: "en-us", segment: "Enterprise", token: "FooToken" },
};

// const MicrosoftCommunicationRouterJobQueuedExample: AcsRouterJobQueuedEventData = #{
//   jobId: "7f1df17b-570b-4ae5-9cf5-fe6ff64cc712",
//   channelReference: "test-abc",
//   channelId: "FooVoiceChannelId",
//   queueId: "625fec06-ab81-4e60-b780-f364ed96ade1",
//   priority: 1,
//   labels: #{ locale: "en-us", segment: "Enterprise", token: "FooToken" },
//   tags: #{ locale: "en-us", segment: "Enterprise", token: "FooToken" },
//   requestedWorkerSelectors: #[
//     #{ key: "string", labelOperator: "equal", value: 5, ttl: "40" }
//   ],
//   attachedWorkerSelectors: #[
//     #{ key: "string", labelOperator: "equal", value: 5, ttlSeconds: "39" }
//   ],
// };

// const MicrosoftCommunicationRouterJobReceivedExample: AcsRouterJobReceivedEventData = #{
//   jobId: "7f1df17b-570b-4ae5-9cf5-fe6ff64cc712",
//   channelReference: "test-abc",
//   jobStatus: "PendingClassification",
//   channelId: "FooVoiceChannelId",
//   classificationPolicyId: "test-policy",
//   queueId: "queue-id",
//   priority: 0,
//   labels: #{ locale: "en-us", segment: "Enterprise", token: "FooToken" },
//   tags: #{ locale: "en-us", segment: "Enterprise", token: "FooToken" },
//   requestedWorkerSelectors: #[
//     #{ key: "string", labelOperator: "equal", value: 5, ttlSeconds: "36" }
//   ],
//   scheduledOn: utcDateTime.fromISO("2022-02-17T00:55:25.1736293Z"),
//   unavailableForMatching: false,
// };

// const MicrosoftCommunicationRouterJobSchedulingFailedExample: AcsRouterJobSchedulingFailedEventData = #{jobId: "7f1df17b-570b-4ae5-9cf5-fe6ff64cc712", channelId: "FooVoiceChannelId", channelReference: "test-abc", queueId: "queue-id", priority: 1, labels: #{locale: "en-us", segment: "Enterprise", token: "FooToken"}, tags: #{locale: "en-us", segment: "Enterprise", token: "FooToken"}, requestedWorkerSelectors: #[#{key: "string", labelOperator: "equal", value: 5, ttlSeconds: "36"}], attachedWorkerSelectors: #[#{key: "string", labelOperator: "equal", value: 5, ttlSeconds: "30"}], scheduledOn: "2022-02-17T00:55:25.1736293Z", failureReason: "Expired Job"};

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

// const MicrosoftCommunicationRouterJobWaitingForActivationExample: AcsRouterJobWaitingForActivationEventData = #{jobId: "7f1df17b-570b-4ae5-9cf5-fe6ff64cc712", channelId: "FooVoiceChannelId", channelReference: "test-abc", queueId: "queue-id", priority: 1, labels: #{locale: "en-us", segment: "Enterprise", token: "FooToken"}, tags: #{locale: "en-us", segment: "Enterprise", token: "FooToken"}, requestedWorkerSelectors: #[#{key: "string", labelOperator: "equal", value: 5, ttlSeconds: "45"}], attachedWorkerSelectors: #[#{key: "string", labelOperator: "equal", value: 5, ttlSeconds: "32"}], scheduledOn: "2022-02-17T00:55:25.1736293Z", unavailableForMatching: false};

// const MicrosoftCommunicationRouterJobWorkerSelectorsExpiredExample: AcsRouterJobWorkerSelectorsExpiredEventData = #{jobId: "7f1df17b-570b-4ae5-9cf5-fe6ff64cc712", channelReference: "test-abc", channelId: "FooVoiceChannelId", queueId: "625fec06-ab81-4e60-b780-f364ed96ade1", labels: #{locale: "en-us", segment: "Enterprise", token: "FooToken"}, tags: #{locale: "en-us", segment: "Enterprise", token: "FooToken"}, expiredRequestedWorkerSelectors: #[#{key: "string", labelOperator: "equal", value: 5, ttlSeconds: "30"}], attachedWorkerSelectorsExpired: #[#{key: "string", labelOperator: "equal", value: 5, ttlSeconds: "35"}]};

// const MicrosoftCommunicationRouterWorkerDeletedExample: AcsRouterWorkerDeletedEventData = #{
//   workerId: "worker3",
// };

const MicrosoftCommunicationRouterWorkerDeregisteredExample: AcsRouterWorkerDeregisteredEventData = #{
  workerId: "worker3",
};

// const MicrosoftCommunicationRouterWorkerOfferAcceptedExample: AcsRouterWorkerOfferAcceptedEventData = #{workerId: "w100", jobId: "7f1df17b-570b-4ae5-9cf5-fe6ff64cc712", jobPriority: 5, jobLabels: #{locale: "en-us", segment: "Enterprise", token: "FooToken"}, jobTags: #{locale: "en-us", segment: "Enterprise", token: "FooToken"}, channelReference: "test-abc", channelId: "FooVoiceChannelId", queueId: "625fec06-ab81-4e60-b780-f364ed96ade1", offerId: "565fec06-ab81-4e60-b780-f364ed96ade1", assignmentId: "765fec06-ab81-4e60-b780-f364ed96ade1"};

const MicrosoftCommunicationRouterWorkerOfferDeclinedExample: AcsRouterWorkerOfferDeclinedEventData = #{
  workerId: "w100",
  jobId: "7f1df17b-570b-4ae5-9cf5-fe6ff64cc712",
  channelReference: "test-abc",
  channelId: "FooVoiceChannelId",
  queueId: "625fec06-ab81-4e60-b780-f364ed96ade1",
  offerId: "565fec06-ab81-4e60-b780-f364ed96ade1",
};

const MicrosoftCommunicationRouterWorkerOfferExpiredExample: AcsRouterWorkerOfferExpiredEventData = #{
  offerId: "565fec06-ab81-4e60-b780-f364ed96ade1",
  workerId: "w100",
  jobId: "7f1df17b-570b-4ae5-9cf5-fe6ff64cc712",
  channelReference: "test-abc",
  channelId: "FooVoiceChannelId",
  queueId: "625fec06-ab81-4e60-b780-f364ed96ade1",
};

// const MicrosoftCommunicationRouterWorkerOfferIssuedExample: AcsRouterWorkerOfferIssuedEventData = #{workerId: "w100", jobId: "7f1df17b-570b-4ae5-9cf5-fe6ff64cc712", channelReference: "test-abc", channelId: "FooVoiceChannelId", queueId: "625fec06-ab81-4e60-b780-f364ed96ade1", offerId: "525fec06-ab81-4e60-b780-f364ed96ade1", offeredOn: "2021-06-23T02:43:30.3847144Z", expiresOn: "2021-06-23T02:44:30.3847674Z", jobPriority: 5, jobLabels: #{locale: "en-us", segment: "Enterprise", token: "FooToken"}, jobTags: #{locale: "en-us", segment: "Enterprise", token: "FooToken"}};

const MicrosoftCommunicationRouterWorkerOfferRevokedExample: AcsRouterWorkerOfferRevokedEventData = #{
  offerId: "565fec06-ab81-4e60-b780-f364ed96ade1",
  workerId: "w100",
  jobId: "7f1df17b-570b-4ae5-9cf5-fe6ff64cc712",
  channelReference: "test-abc",
  channelId: "FooVoiceChannelId",
  queueId: "625fec06-ab81-4e60-b780-f364ed96ade1",
};

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

const MicrosoftCommunicationAdvancedMessageDeliveryStatusUpdatedExample: AcsMessageDeliveryStatusUpdatedEventData = #{
  messageId: "d59f9468-0a5c-4022-8200-d7bf6fb78bc5",
  status: "delivered",
  channelType: "whatsapp",
  from: "12375679879",
  to: "1345679879",
  receivedTimeStamp: utcDateTime.fromISO("2024-03-22T17:06:11.1980225+00:00"),
  error: #{ channelCode: "channelCode", channelMessage: "channelMessage" },
};

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

// const MicrosoftCommunicationChatThreadCreatedExample: AcsChatThreadCreatedEventData =
// #{
//   createdByCommunicationIdentifier: #{
//     rawId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5cbb-38a0-88f7-084822002453",
//     communicationUser: #{
//       id: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-5cbb-38a0-88f7-084822002453"
//     }
//   },
//   properties: #{
//     topic: "Talk about new Thread Events in communication services"
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
//     topic: "Talk about new Thread Events in communication services"
//   },
//   metadata: #{
//     key: "value"
//   },
//   createTime: utcDateTime.fromISO("2021-02-19T16:00:40.126-08:00"),
//   version: 1613779447695,
//   threadId: "19:9e8eefe67b3c470a8187b4c2b00240bc@thread.v2",
//   transactionId: "GBE9MB2a40KEWzexIg0D3A.1.1.1.1.856359041.1"
// };

const AcsCallEndedExample: AcsCallEndedEventData = #{
  reason: #{ code: 1, subCode: 1, phrase: "ReasonCode" },

  // callDurationInSeconds: 10,
  endedBy: #{
    communicationIdentifier: #{
      kind: "communicationUser",
      rawId: "8:acs:d9ff4983-39e7-4420-8d54-f6354ed06ccd_7a668e62-08f4-4ac1-b29e-f01010f57475",
      communicationUser: #{
        id: "8:acs:d9ff4983-39e7-4420-8d54-f6354ed06ccd_7a668e62-08f4-4ac1-b29e-f01010f57475",
      },
    },
    type: "TestCallEndedBy",
    name: "TestCallEndedBy",
  },

  startedBy: #{
    communicationIdentifier: #{
      kind: "communicationUser",
      rawId: "8:acs:d9ff4983-39e7-4420-8d54-f6354ed06ccd_7a668e62-08f4-4ac1-b29e-f01010f57475",
      communicationUser: #{
        id: "8:acs:d9ff4983-39e7-4420-8d54-f6354ed06ccd_7a668e62-08f4-4ac1-b29e-f01010f57475",
      },
    },
    role: "UserRole",
  },
  serverCallId: "Y3NVcmw",
  group: #{ id: "055d13d6-8161-43c8-af88-2110373e1e4a" },
  room: #{ id: "055d13d6-8161-43c8-af88-2110373e1e4a" },
  isTwoParty: false,
  correlationId: "CallIdGuid",
  isRoomsCall: false,
};

const AcsCallParticipantAddedExample: AcsCallParticipantAddedEventData = #{
  user: #{
    communicationIdentifier: #{
      kind: "communicationUser",
      rawId: "8:acs:d9ff4983-39e7-4420-8d54-f6354ed06ccd_7a668e62-08f4-4ac1-b29e-f01010f57475",
      communicationUser: #{
        id: "8:acs:d9ff4983-39e7-4420-8d54-f6354ed06ccd_7a668e62-08f4-4ac1-b29e-f01010f57475",
      },
    },
    role: "UserRole",
  },
  displayName: "displayName1",
  participantId: "participant1",
  userAgent: "endpointType",
  startedBy: #{
    communicationIdentifier: #{
      kind: "communicationUser",
      rawId: "8:acs:d9ff4983-39e7-4420-8d54-f6354ed06ccd_7a668e62-08f4-4ac1-b29e-f01010f57475",
      communicationUser: #{
        id: "8:acs:d9ff4983-39e7-4420-8d54-f6354ed06ccd_7a668e62-08f4-4ac1-b29e-f01010f57475",
      },
    },
    role: "UserRole",
  },
  serverCallId: "Y3NVcmw",
  group: #{ id: "6d16b954-0531-4262-9cdd-c4b85da5c5d8" },
  room: #{ id: "055d13d6-8161-43c8-af88-2110373e1e4a" },
  isTwoParty: false,
  correlationId: "CallIdGuid",
  isRoomsCall: false,
};

const AcsCallParticipantRemovedExample: AcsCallParticipantRemovedEventData = #{
  user: #{
    communicationIdentifier: #{
      kind: "communicationUser",
      rawId: "8:acs:d9ff4983-39e7-4420-8d54-f6354ed06ccd_7a668e62-08f4-4ac1-b29e-f01010f57475",
      communicationUser: #{
        id: "8:acs:d9ff4983-39e7-4420-8d54-f6354ed06ccd_7a668e62-08f4-4ac1-b29e-f01010f57475",
      },
    },
    role: "UserRole",
  },
  displayName: "displayName1",
  participantId: "participant1",
  userAgent: "endpointType",
  startedBy: #{
    communicationIdentifier: #{
      kind: "communicationUser",
      rawId: "8:acs:d9ff4983-39e7-4420-8d54-f6354ed06ccd_7a668e62-08f4-4ac1-b29e-f01010f57475",
      communicationUser: #{
        id: "8:acs:d9ff4983-39e7-4420-8d54-f6354ed06ccd_7a668e62-08f4-4ac1-b29e-f01010f57475",
      },
    },
    role: "UserRole",
  },
  serverCallId: "Y3NVcmw",
  group: #{ id: "51422183-029d-4750-9db5-c8e5a578f469" },
  room: #{ id: "055d13d6-8161-43c8-af88-2110373e1e4a" },
  isTwoParty: false,
  correlationId: "CallIdGuid",
  isRoomsCall: false,
};

const AcsCallStartedExample: AcsCallStartedEventData = #{
  startedBy: #{
    communicationIdentifier: #{
      kind: "communicationUser",
      rawId: "8:acs:d9ff4983-39e7-4420-8d54-f6354ed06ccd_7a668e62-08f4-4ac1-b29e-f01010f57475",
      communicationUser: #{
        id: "8:acs:d9ff4983-39e7-4420-8d54-f6354ed06ccd_7a668e62-08f4-4ac1-b29e-f01010f57475",
      },
    },
    role: "UserRole",
  },
  serverCallId: "Y3NVcmw",
  group: #{ id: "aca7bf5b-ff44-4f47-8385-cfd4e0232a6e" },
  room: #{ id: "055d13d6-8161-43c8-af88-2110373e1e4a" },
  isTwoParty: false,
  correlationId: "CallIdGuid",
  isRoomsCall: false,
};

const AcsChatAzureBotCommandReceivedInThreadExample: AcsChatAzureBotCommandReceivedInThreadEventData = #{
  messageBody: "Welcome to Azure Communication Services",
  messageId: "1613694358927",
  senderCommunicationIdentifier: #{
    rawId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7caf-07fd-084822001724",
    communicationUser: #{
      id: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7caf-07fd-084822001724",
    },
  },
  senderDisplayName: "John",
  composeTime: utcDateTime.fromISO("2021-02-19T00:25:58.927Z"),
  type: "Text",
  version: 1613694358927,
  transactionId: "oh+LGB2dUUadMcTAdRWQxQ.1.1.1.1.1827536918.1.7",
  threadId: "19:6e5d6ca1d75044a49a36a7965ec4a906@thread.v2",
};

const AcsChatTypingIndicatorReceivedInThreadExample: AcsChatTypingIndicatorReceivedInThreadEventData = #{
  messageBody: "Welcome to Azure Communication Services",
  messageId: "1613694358927",
  senderCommunicationIdentifier: #{
    rawId: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7caf-07fd-084822001724",
    communicationUser: #{
      id: "8:acs:109f0644-b956-4cd9-87b1-71024f6e2f44_00000008-578d-7caf-07fd-084822001724",
    },
  },
  composeTime: utcDateTime.fromISO("2021-02-19T00:25:58.927Z"),
  senderDisplayName: "John",
  transactionId: "oh+LGB2dUUadMcTAdRWQxQ.1.1.1.1.1827536918.1.7",
  threadId: "19:6e5d6ca1d75044a49a36a7965ec4a906@thread.v2",
  type: "Text",
  version: 1613694358927,
};
