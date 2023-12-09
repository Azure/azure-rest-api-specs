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
  @access(Access.internal)
  sendMessage is AzureCommunicationMessagesService.NotificationMessagesOperations.sendMessage;

  @access(Access.internal)
  downloadMedia is AzureCommunicationMessagesService.StreamOperations.downloadMedia;
}

@client({
  name: "MessageTemplateClient",
  service: AzureCommunicationMessagesService,
})
interface MessageTemplateRestClient {
  @access(Access.internal)
  getTemplates is AzureCommunicationMessagesService.TemplateOperations.list;
}