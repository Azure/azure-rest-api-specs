// client.tsp
import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";

import "./main.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

@useDependency(Azure.Communication.MessagesService.Versions.c2024_02_01)
namespace ClientForAcsMessages;

@client({
  name: "NotificationMessagesClient",
  service: Azure.Communication.MessagesService,
})
interface NotificationMessagesClient
  extends Azure.Communication.MessagesService.NotificationMessagesOperations {
  @access(Access.internal, "csharp")
  @clientName("downloadMediaInternal", "csharp")
  downloadMedia is Azure.Communication.MessagesService.StreamOperations.getMedia;
}

@client({
  name: "MessageTemplateClient",
  service: Azure.Communication.MessagesService,
})
interface MessageTemplateClient
  extends Azure.Communication.MessagesService.TemplateOperations {}

@@access(Azure.Communication.MessagesService.MessageDataStream,
  Access.internal
);

@@clientName(Azure.Communication.MessagesService.MessageTemplate.values,
  "templateValues",
  "python"
);
