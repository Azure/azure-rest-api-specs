import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Azure.Communication.MessagesService;

alias ServiceTraits = SupportsRepeatableRequests &
  NoConditionalRequests &
  SupportsClientRequestId;

alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

interface TemplateOperations {
  @tag("Template")
  @doc("List all templates for given Azure Communication Services channel")
  @clientName("getTemplates", "csharp")
  listTemplates is Operations.ResourceList<
    MessageTemplateItem,
    ListTemplatesQueryParams
  >;
}

interface NotificationMessagesOperations {
  @tag("Notifications")
  @doc("Sends a notification message from Business to User.")
  send is Operations.ResourceCollectionAction<
    Notifications,
    NotificationMessagesSendRequestBody,
    AcceptedResponse & SendMessageResult
  >;
}

interface StreamOperations {
  @tag("Stream")
  @doc("Download the Media payload from a User to Business message.")
  getMedia is Operations.ResourceRead<MessageDataStream>;
}

@added(Versions.c2025_03_01_Preview)
interface ConversationManagementOperations {
  @tag("ConversationManagement")
  @doc("Creates a new conversation.")
  @added(Versions.c2025_03_01_Preview)
  create is Operations.ResourceCollectionAction<
    Conversation,
    CreateConversationRequestBody,
    CreatedResponse & CreateConversationResponseBody
  >;

  @tag("ConversationManagement")
  @doc("Gets the details of a specific conversation.")
  @added(Versions.c2025_03_01_Preview)
  getConversation is Operations.ResourceRead<Conversation>;

  @tag("ConversationManagement")
  @doc("Terminates a specific conversation.")
  @added(Versions.c2025_03_01_Preview)
  deleteConversation is Operations.ResourceDelete<Conversation>;

  @tag("ConversationManagement")
  @doc("Adds participants to a specific conversation.")
  @added(Versions.c2025_03_01_Preview)
  addParticipants is Operations.ResourceCollectionAction<
    Participant,
    AddParticipantsRequestBody,
    NoContentResponse
  >;

  @tag("ConversationManagement")
  @doc("remove a participant from a conversation")
  @added(Versions.c2025_03_01_Preview)
  removeParticipants is Operations.ResourceCollectionAction<
    Participant,
    RemoveParticipantsRequestBody,
    NoContentResponse
  >;

  @tag("ConversationManagement")
  @doc("Retrieves list of conversation for a participant.")
  @added(Versions.c2025_03_01_Preview)
  @route("/messages/conversations:manage")
  @get
  getConversations is Azure.Core.Foundations.Operation<
    {
      @header
      @doc("The Initiator user ID")
      initiator: string;
    },
    ListConversationResponse
  >;

  @tag("ConversationManagement")
  @doc("Retrieves list of conversations for a channel.")
  @added(Versions.c2025_03_01_Preview)
  @route("/messages/conversations/channels/{channelId}:manage")
  getChannelConversations is Azure.Core.Foundations.Operation<
  {
    @doc("The ID of the channel.")
    @path
    channelId: string;
  },
  ListConversationResponse
>;

  @tag("ConversationManagement")
  @doc("Retrieves list of conversation messages.")
  @added(Versions.c2025_03_01_Preview)
  @route("/messages/conversations/{conversationId}/messages:manage")
  @get
  getMessages is Azure.Core.Foundations.Operation<
    {
      @header
      @doc("The Initiator user ID")
      initiator: string;

      @doc("The ID of the conversation.")
      @path
      conversationId: string;

      @doc("The max page size.")
      @query
      maxPageSize?: int32;
    },
    ListConversationMessageResponse
  >;

  @tag("ConversationManagement")
  @doc("Get AI Analysis of a conversation.")
  @added(Versions.c2025_03_01_Preview)
  summarizeConversation is Operations.ResourceCollectionAction<
    ConversationMessageItem,
    RemoveParticipantsRequestBody,
    OkResponse & GetConversationMessagesAnalysisResult
  >;
}

@useAuth(BearerAuth)
@added(Versions.c2025_03_01_Preview)
interface ConversationMessagesOperations {
  @tag("ConversationMessages")
  @doc("Retrieves list of conversations.")
  @added(Versions.c2025_03_01_Preview)
  listConversations is Operations.ResourceList<
    Conversation,
    ListConversationsQueryParams
  >;

  @tag("ConversationMessages")
  @doc("Retrieves list of conversation messages.")
  @added(Versions.c2025_03_01_Preview)
  listMessages is Operations.ResourceList<
    ConversationMessageItem,
    ListConversationMessagesQueryParams
  >;

  @tag("ConversationMessages")
  @doc("Sends a conversation message from Business to User.")
  @added(Versions.c2025_03_01_Preview)
  sendMessage is Operations.ResourceCollectionAction<
    ConversationMessageItem,
    ConversationMessagesSendRequestBody,
    OkResponse & SendConversationMessageResult
  >;

  @tag("ConversationMessages")
  @doc("Get AI Analysis of a conversation.")
  @added(Versions.c2025_03_01_Preview)
  summarize is Operations.ResourceCollectionAction<
    ConversationMessageItem,
    RemoveParticipantsRequestBody,
    OkResponse & GetConversationMessagesAnalysisResult
  >;
}
