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
  send is AzureCommunicationMessagesService.NotificationMessagesOperations.send;

  @access(Access.internal, "csharp")
  getMedia is AzureCommunicationMessagesService.StreamOperations.getStream;
}

@client({
  name: "MessageTemplateClient",
  service: AzureCommunicationMessagesService,
})
interface MessageTemplateRestClient {
  @access(Access.internal, "csharp")
  getTemplates is AzureCommunicationMessagesService.TemplateOperations.list;
}