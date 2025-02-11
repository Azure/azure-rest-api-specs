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
  @doc("Creates a new conversation. This is only for create operation.")
  @createsResource(Conversation)
  @added(Versions.c2025_03_01_Preview)
  createConversation is Foundations.ResourceCollectionOperation<
    Conversation,
    CreateConversationRequest,
    CreatedResponse & Conversation
  >;

  @tag("ConversationManagement")
  @doc("Gets the details of a specific conversation.")
  @added(Versions.c2025_03_01_Preview)
  getConversation is Operations.ResourceRead<Conversation>;

  @tag("ConversationManagement")
  @doc("Deletes a specific conversation.")
  @added(Versions.c2025_03_01_Preview)
  deleteConversation is Operations.ResourceDelete<Conversation>;

  @tag("ConversationManagement")
  @doc("Terminates a specific conversation.")
  @added(Versions.c2025_03_01_Preview)
  @action("terminate")
  terminateConversation is Operations.ResourceAction<
    Conversation,
    {},
    OkResponse
  >;
}

@added(Versions.c2025_03_01_Preview)
interface ConversationMessagesOperations {
  @tag("ConversationMessages")
  @doc("Adds participants to a specific conversation.")
  @added(Versions.c2025_03_01_Preview)
  @action("add")
  addParticipants is Operations.ResourceCollectionAction<
    Participant,
    AddParticipantsRequestBody,
    Response<207> & AddParticipantsResult
  >;

  @tag("ConversationMessages")
  @doc("remove a participant from a conversation")
  @added(Versions.c2025_03_01_Preview)
  @action("remove")
  removeParticipants is Operations.ResourceCollectionAction<
    Participant,
    RemoveParticipantsRequestBody,
    Response<207> & RemoveParticipantsResult
  >;

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
  @action("send")
  sendMessage is Operations.ResourceCollectionAction<
    ConversationMessageItem,
    ConversationMessagesSendRequestBody,
    OkResponse & SendConversationMessageResult
  >;

  @tag("ConversationMessages")
  @doc("Get AI Analysis of a conversation.")
  @added(Versions.c2025_03_01_Preview)
  @action("analyze")
  analyzeConversation is Operations.ResourceAction<
    Conversation,
    {},
    OkResponse & GetConversationMessagesAnalysisResult
  >;
}
