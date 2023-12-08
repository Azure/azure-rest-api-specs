// client.tsp
import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";

import "./main.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

@useDependency(AzureCommunicationMessagesService.Versions.c2024_02_01)
namespace ClientForAcsMessages;

// Your customizations here

@client({
  name: "NotificationMessagesClient",
  service: AzureCommunicationMessagesService,
})
interface NotificationMessagesClient {
  sendMessage is AzureCommunicationMessagesService.NotificationMessagesOperations.sendMessage;
  downloadMedia is AzureCommunicationMessagesService.StreamOperations.downloadMedia;
}

@client({
  name: "MessageTemplateClient",
  service: AzureCommunicationMessagesService,
})
interface MessageTemplateClient {
  getTemplates is AzureCommunicationMessagesService.TemplateOperations.list;
}

@client({
  name: "StreamRestClient",
  service: AzureCommunicationMessagesService,
})
interface StreamRestClient {
  downloadMedia is AzureCommunicationMessagesService.StreamOperations.downloadMedia;
}