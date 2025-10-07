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

interface ReadReceiptsOperations {
  #suppress "@azure-tools/typespec-azure-core/no-response-body" ""
  @tag("ReadReceipts")
  @added(Versions.c2025_09_01_Preview)
  @action("send")
  @doc("Sends a read receipt update from Business to User.")
  send is Operations.ResourceCollectionAction<
    ReadReceipts,
    ReadReceiptSendRequestBody,
    AcceptedResponse
  >;
}

interface StreamOperations {
  @tag("Stream")
  @doc("Download the Media payload from a User to Business message.")
  getMedia is Operations.ResourceRead<MessageDataStream>;
}

@added(Versions.c2025_04_01_Preview)
interface ConversationAdministrationOperations {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
  @tag("ConversationAdministration")
  @doc("Creates a new conversation. This is only for create operation.")
  @createsResource(Conversation)
  @added(Versions.c2025_04_01_Preview)
  createConversation is Foundations.ResourceCollectionOperation<
    Conversation,
    CreateConversationRequest,
    CreatedResponse & Conversation
  >;

  @tag("ConversationAdministration")
  @doc("Gets the details of a specific conversation.")
  @added(Versions.c2025_04_01_Preview)
  getConversation is Operations.ResourceRead<Conversation>;

  @tag("ConversationAdministration")
  @doc("Deletes a specific conversation.")
  @added(Versions.c2025_04_01_Preview)
  deleteConversation is Operations.ResourceDelete<Conversation>;

  #suppress "@azure-tools/typespec-azure-core/no-response-body" ""
  @tag("ConversationAdministration")
  @doc("Terminates a specific conversation.")
  @added(Versions.c2025_04_01_Preview)
  @action("terminate")
  terminateConversation is Operations.ResourceAction<
    Conversation,
    {},
    OkResponse
  >;
}

@added(Versions.c2025_04_01_Preview)
interface ConversationThreadOperations {
  @tag("ConversationThread")
  @doc("Adds participants to a specific conversation.")
  @added(Versions.c2025_04_01_Preview)
  @action("add")
  addParticipants is Operations.ResourceCollectionAction<
    ConversationParticipant,
    AddParticipantsRequestBody,
    Response<207> & AddParticipantsResult
  >;

  @tag("ConversationThread")
  @doc("remove a participant from a conversation")
  @added(Versions.c2025_04_01_Preview)
  @action("remove")
  removeParticipants is Operations.ResourceCollectionAction<
    ConversationParticipant,
    RemoveParticipantsRequestBody,
    Response<207> & RemoveParticipantsResult
  >;

  @tag("ConversationThread")
  @doc("Retrieves list of conversations.")
  @added(Versions.c2025_04_01_Preview)
  listConversations is Operations.ResourceList<
    Conversation,
    ListConversationsQueryParams
  >;

  @tag("ConversationThread")
  @doc("Retrieves list of conversation messages.")
  @added(Versions.c2025_04_01_Preview)
  listMessages is Operations.ResourceList<
    ConversationMessageItem,
    ListConversationThreadQueryParams
  >;

  @tag("ConversationThread")
  @doc("Sends a conversation message from Business to User.")
  @added(Versions.c2025_04_01_Preview)
  @action("send")
  sendMessage is Operations.ResourceCollectionAction<
    ConversationMessageItem,
    ConversationThreadSendRequestBody,
    OkResponse & SendConversationMessageResult
  >;

  @tag("ConversationThread")
  @doc("Get AI Analysis of a conversation.")
  @added(Versions.c2025_04_01_Preview)
  @action("analyze")
  analyzeConversation is Operations.ResourceAction<
    Conversation,
    {},
    OkResponse & GetConversationThreadAnalysisResult
  >;
}
