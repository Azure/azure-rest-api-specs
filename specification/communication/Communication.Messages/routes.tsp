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
    NotificationContent,
    AcceptedResponse & SendMessageResult
  >;
}

interface StreamOperations {
  @tag("Stream")
  @doc("Download the Media payload from a User to Business message.")
  getMedia is Operations.ResourceRead<MessageDataStream>;
}
