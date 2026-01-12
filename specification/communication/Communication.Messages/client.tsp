// client.tsp
import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";

import "./main.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

@useDependency(Azure.Communication.MessagesService.Versions.c2025_09_01_Preview)
namespace ClientForAcsMessages;

@client({
  name: "NotificationMessagesClient",
  service: Azure.Communication.MessagesService,
})
interface NotificationMessagesClient
  extends Azure.Communication.MessagesService.NotificationMessagesOperations {
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" ""
  @access(Access.internal, "csharp")
  @clientName("downloadMediaInternal", "csharp")
  downloadMedia is Azure.Communication.MessagesService.StreamOperations.getMedia;
  sendReadReceipt is Azure.Communication.MessagesService.ReadReceiptsOperations.send;
}

@client({
  name: "MessageTemplateClient",
  service: Azure.Communication.MessagesService,
})
interface MessageTemplateClient
  extends Azure.Communication.MessagesService.TemplateOperations {}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""
@added(Azure.Communication.MessagesService.Versions.c2025_04_01_Preview)
@client({
  name: "ConversationAdministrationClient",
  service: Azure.Communication.MessagesService,
})
interface ConversationAdministrationClient
  extends Azure.Communication.MessagesService.ConversationAdministrationOperations {
  listConversations is Azure.Communication.MessagesService.ConversationThreadOperations.listConversations;
  listMessages is Azure.Communication.MessagesService.ConversationThreadOperations.listMessages;
  addParticipants is Azure.Communication.MessagesService.ConversationThreadOperations.addParticipants;
  removeParticipants is Azure.Communication.MessagesService.ConversationThreadOperations.removeParticipants;
  analyzeConversation is Azure.Communication.MessagesService.ConversationThreadOperations.analyzeConversation;
}

@added(Azure.Communication.MessagesService.Versions.c2025_04_01_Preview)
@client({
  name: "ConversationThreadClient",
  service: Azure.Communication.MessagesService,
})
interface ConversationThreadClient
  extends Azure.Communication.MessagesService.ConversationThreadOperations {}

@@access(Azure.Communication.MessagesService.MessageDataStream,
  Access.internal
);

@@clientName(Azure.Communication.MessagesService.MessageTemplate.values,
  "templateValues",
  "python"
);

@@clientName(Azure.Communication.MessagesService.NotificationMessagesSendRequestBody.body,
  "notificationContent",
  "csharp,java"
);

@@clientName(Azure.Communication.MessagesService.LinkContent.url,
  "uri",
  "csharp"
);

@@clientName(Azure.Communication.MessagesService.MediaMessageContent.mediaUri,
  "mediaUrl",
  "java"
);
