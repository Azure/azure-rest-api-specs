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

@doc("Calling permissions")
model CallingPermissions {
  @doc("Add participants")
  addParticipants: boolean;

  @doc("Add pstn participants")
  addPstnParticipants: boolean;

  @doc("Leave a call")
  removeSelf: boolean;

  @doc("Leave a call")
  leaveCall: boolean;

  @doc("Remove any participant")
  removeParticipants: boolean;

  @doc("Remove any pstn participant")
  removePstnParticipant: boolean;

  @doc("List participants")
  listParticipants: boolean;

  @doc("Get own data")
  getOwnData: boolean;

  @doc("Get others data")
  getOthersData: boolean;

  @doc("Update own data")
  updateOwnData: boolean;

  @doc("Update others data")
  updateOthersData: boolean;

  @doc("Get call poperties")
  getCallProperties: boolean;

  @doc("Update call poperties")
  updateCallProperties: boolean;

  @doc("Admit participants from the lobby")
  admitLobbyParticipants: boolean;

  @doc("Deny participants from the lobby")
  denyLobbyParticipants: boolean;

  @doc("Get the call directly without waiting in the lobby")
  bypassLobby: boolean;

  @doc("Delete a scheduled call")
  deleteCall: boolean;

  @doc("Join a meeting")
  joinMeeting: boolean;

  @doc("Turn on own video")
  turnOnVideo: boolean;

  @doc("Turn on own video")
  shareVideo: boolean;

  @doc("Turn on own video")
  sendVideo: boolean;

  @doc("Disable video sharing functionality for other participants")
  restrictOthersVideo: boolean;

  @doc("Enable video sharing functionality for other participants")
  unrestrictOthersVideo: boolean;

  @doc("Turn on own audio in a call")
  turnOnAudio: boolean;

  @doc("Turn on own audio in a call")
  shareAudio: boolean;

  @doc("Turn on own audio in a call")
  sendAudio: boolean;

  @doc("Disable audio sharing functionality for others")
  restrictOthersAudio: boolean;

  @doc("Enable audio sharing functionality for others")
  unrestrictOthersAudio: boolean;

  @doc("Share own screen")
  shareScreen: boolean;

  @doc("Share own screen")
  shareContent: boolean;

  @doc("Mute self in a call")
  muteSelf: boolean;

  @doc("Unmute self in a call")
  unmuteSelf: boolean;

  @doc("Mute others in a call")
  muteOthers: boolean;

  @doc("Highlight video feeds for everyone in the call")
  spotlightParticipants: boolean;

  @doc("Remove highlighted video feeds for everyone in the call")
  removeSpotlights: boolean;

  @doc("Remove highlighted video feeds for everyone in the call")
  removeParticipantsSpotlight: boolean;

  @doc("Start recording in the call")
  startRecording: boolean;

  @doc("Stop recording in the call")
  stopRecording: boolean;

  @doc("Start live captions")
  startLiveCaptions: boolean;

  @doc("Stop live captions")
  stopLiveCaptions: boolean;

  @doc("Raise a hand during the call")
  raiseHand: boolean;

  @doc("Send reactions during the call")
  sendReaction: boolean;

  @doc("End the call for everyone")
  hangUpForEveryOne: boolean;

  @doc("End the call for everyone")
  endCallForAll: boolean;
}
