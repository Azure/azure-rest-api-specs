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
  @access(Access.internal, "csharp")
  @projectedName("csharp", "downloadMediaInternal")
  downloadMedia is AzureCommunicationMessagesService.StreamOperations.downloadMedia;
}

@client({
  name: "MessageTemplateClient",
  service: AzureCommunicationMessagesService,
})
interface MessageTemplateClient extends AzureCommunicationMessagesService.TemplateOperations
{}