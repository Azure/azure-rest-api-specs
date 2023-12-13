// client.tsp
import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";

import "./main.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

@useDependency(AzureCommunicationMessagesService.Versions.c2024_02_01)
namespace ClientForAcsMessages;

@client({
  name: "NotificationMessagesClient",
  service: AzureCommunicationMessagesService,
})
interface NotificationMessagesRestClient {
  @access(Access.internal, "csharp")
  postMessage is AzureCommunicationMessagesService.NotificationMessagesOperations.sendMessage;

  @access(Access.internal, "csharp")
  getMedia is AzureCommunicationMessagesService.StreamOperations.downloadMedia;
}

@client({
  name: "MessageTemplateClient",
  service: AzureCommunicationMessagesService,
})
interface MessageTemplateRestClient {
  @access(Access.internal, "csharp")
  getTemplates is AzureCommunicationMessagesService.TemplateOperations.list;
}