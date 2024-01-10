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
interface NotificationMessagesClient extends AzureCommunicationMessagesService.NotificationMessagesOperations
{
  @access(Access.internal)
  getMedia is AzureCommunicationMessagesService.StreamOperations.getStream;
}

@client({
  name: "MessageTemplateClient",
  service: AzureCommunicationMessagesService,
})
interface MessageTemplateClient extends AzureCommunicationMessagesService.TemplateOperations
{}