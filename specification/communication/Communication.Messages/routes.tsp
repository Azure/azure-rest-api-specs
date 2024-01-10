import "@typespec/rest";
import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace AzureCommunicationMessagesService;

alias ServiceTraits = SupportsRepeatableRequests &
  NoConditionalRequests &
  SupportsClientRequestId;

alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

interface TemplateOperations {
  @tag("Template")
  @doc("List all templates for given ACS channel")
  getTemplates is Operations.ResourceList<MessageTemplateItem>;
}

interface NotificationMessagesOperations {
  @tag("Notifications")
  @doc("Sends a notification message from Business to User.")
  sendMessage is Operations.ResourceCollectionAction<Notifications, NotificationContent, AcceptedResponse & SendMessageResult>
}

interface StreamOperations {
  @tag("Stream")
  @doc("Download the Media payload from a User to Business message.")
  getStream is Operations.ResourceRead<MessageDataStream>;
}