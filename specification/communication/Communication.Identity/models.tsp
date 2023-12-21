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
  @doc("Add members")
  addMembers: boolean;

  @doc("Add self")
  addSelf: boolean;

  @doc("Remove self")
  removeSelf: boolean;

  @doc("Remove member")
  removeMember: boolean;

  @doc("Get self details")
  getSelfDetails: boolean;

  @doc("Get others details")
  getOthersDetails: boolean;

  @doc("Update self details")
  updateSelfDetails: boolean;

  @doc("Get members")
  getMembers: boolean;

  @doc("Share history")
  shareHistory: boolean;

  @doc("Get thread")
  getThread: boolean;

  @doc("Delete thread")
  deleteThread: boolean;

  @doc("Update thread properties")
  updateThreadProperties: boolean;

  @doc("Send message")
  sendMessage: boolean;

  @doc("Get messages")
  getMessages: boolean;

  @doc("Edit own message")
  editOwnMessage: boolean;

  @doc("Edit shared message")
  editSharedMessage: boolean;

  @doc("Annotate own message")
  annotateOwnMessage: boolean;

  @doc("Edit shared annotation")
  editSharedAnnotation: boolean;

  @doc("Delete own message")
  deleteOwnMessage: boolean;

  @doc("Delete others message")
  deleteOthersMessage: boolean;

  @doc("Recover own message")
  recoverMessageSentBySelf: boolean;

  @doc("Recover others message")
  recoverMessageSentByOthers: boolean;

  @doc("Hard delete message initiated by ret hook")
  hardDeleteMessageInitiatedByRetHook: boolean;

  @doc("Pin message")
  pinMessage: boolean;

  @doc("New post")
  newPost: boolean;

  @doc("Reply to others' post")
  replyToPostSentByOthers: boolean;

  @doc("Reply to own post")
  replyToPostSentBySelf: boolean;

  @doc("Update template type")
  updateTemplateType: boolean;
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
