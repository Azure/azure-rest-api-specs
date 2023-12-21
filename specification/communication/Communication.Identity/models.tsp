import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;
using TypeSpec.Rest;

@doc("A role.")
@resource("roles")
model Role {
  @key
  @doc("The Role id.")
  @visibility("read")
  id: string;

  @doc("The role name.")
  name: string;

  @doc("Set to false to prevent new assignments but keep existing assignments intact.")
  isEnabled: boolean;

  @doc("The date and time when the request was created.")
  @visibility("read")
  createdAt: utcDateTime;

  @doc("The date and time when the request was updated.")
  @visibility("read")
  updatedAt: utcDateTime;

  @doc("Permissions")
  permissions: Permissions;
}

@doc("Permissions")
model Permissions {

  @doc("Chat permissions")
  chat: ChatPermissions;

  @doc("Calling permissions")
  calling: CallingPermissions;
}

// https://skype.visualstudio.com/SCC/_git/async_messaging_chatentityservice?path=/Dev/ThreadService.Scenarios/Templates/ChatThreadTemplate.cs&_a=contents&version=GBmaster
@doc("Chat permissions")
model ChatPermissions {
  @doc("Add participants")
  addParticipants: boolean;

  @doc("Remove self")
  removeSelf: boolean;

  @doc("Leave chat thread")
  leaveChatThread: boolean;

  @doc("Remove participants")
  removeParticipants: boolean;

  @doc("Get list of participants")
  listParticipants: boolean;

  @doc("Get own data")
  getOwnData: boolean;

  @doc("Get others data")
  getOthersData: boolean;

  @doc("Update own data")
  updateOwnData: boolean;

  @doc("Update others data")
  updateOthersData: boolean;

  @doc("Share history of chat thread with others participants")
  shareHistory: boolean;

  @doc("Get properties of chat thread")
  getChatThreadProperties: boolean;

  @doc("Update chat thread properties")
  updateChatThreadProperties: boolean;

  @doc("Delete chat thread")
  deleteChatThread: boolean;

  @doc("Send message")
  sendMessage: boolean;

  @doc("Get messages")
  getMessages: boolean;
  
  @doc("Get messages")
  readMessages: boolean;

  @doc("Edit own message")
  editOwnMessage: boolean;

  @doc("Edit any message")
  editOthersMessage: boolean;

  @doc("Edit any message")
  editAnyMessage: boolean;

  @doc("Reply to own message")
  annotateOwnMessage: boolean;

  @doc("Reply to own message")
  replyOwnMessage: boolean;

  @doc("Reply to others message")
  annotateOthersMessage: boolean;

  @doc("Reply to others message")
  replyOthersMessage: boolean;

  @doc("Delete own message")
  deleteOwnMessage: boolean;

  @doc("Delete others message")
  deleteOthersMessage: boolean;

  @doc("Delete others message")
  deleteAnyMessage: boolean;

  @doc("Recover own message")
  recoverOwnMessage: boolean;

  @doc("Recover others message")
  recoverOthersMessage: boolean;

  @doc("Recover others message")
  recoverAnyMessage: boolean;

  @doc("Get read recepits")
  getReadReceipts: boolean;

  @doc("Send read recepits")
  sendReadReceipt: boolean;

  @doc("Send typing notification")
  sendTypingNotification: boolean;
}


// https://skype.visualstudio.com/SCC/_git/sync_calling_concore-conversation?path=/ConversationService/ConversationLogic/MeetingAuthorizer/MeetingAuthorizer.cs
@doc("Calling permissions")
model CallingPermissions {

  @doc("CanPublishAttendeeModalitiesUnrestricted")
  canPublishAttendeeModalitiesUnrestricted: boolean;

  @doc("CanPublishSharingLayoutType")
  canPublishSharingLayoutType: boolean;

  @doc("canPublishOrRemoveStateForOthers")
  canPublishOrRemoveStateForOthers: boolean;

  @doc("CanBeAVRestricted")
  canBeAVRestricted: boolean;

  @doc("CanMeetingRoleBeUpdated")
  canMeetingRoleBeUpdated: boolean;

  @doc("ShouldRemoveContentSharingAndMediaStreamsWhenStagingRoom")
  shouldRemoveContentSharingAndMediaStreamsWhenStagingRoom: boolean;

  @doc("CanJoinGreenGroupByDefault")
  canJoinGreenGroupByDefault: boolean;

  @doc("CanUpdateMeetingGroup")
  canUpdateMeetingGroup: boolean;

  @doc("CanRemoveOtherParticipantEndpoint")
  canRemoveOtherParticipantEndpoint: boolean;

  @doc("CanAddRecordingBot")
  canAddRecordingBot: boolean;

  @doc("CanUpdateMeetingLiveState")
  canUpdateMeetingLiveState: boolean;

  @doc("CanUpdateParticipantInterpretationState")
  canUpdateParticipantInterpretationState: boolean;

  @doc("CanMuteSelfOrOthers")
  canMuteSelfOrOthers: boolean;

  @doc("CanMuteAll")
  canMuteAll: boolean;

  @doc("CanUnmute")
  canUnmute: boolean;

  @doc("CanAddParticipant")
  canAddParticipant: boolean;

  @doc("AuthorizeMeetingJoin")
  authorizeMeetingJoin: boolean;

  @doc("AuthorizeMeetingJoinForBroadcastMeetings")
  authorizeMeetingJoinForBroadcastMeetings: boolean;

  @doc("CanJoinAsAnonymousParticipant")
  canJoinAsAnonymousParticipant: boolean;
}
