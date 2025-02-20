// client.tsp
import "@azure-tools/typespec-client-generator-core";
import "@typespec/versioning";

import "./main.tsp";

using Azure.ClientGenerator.Core;
using TypeSpec.Versioning;

@useDependency(Azure.Communication.MessagesService.Versions.c2025_03_01_Preview)
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

@added(Azure.Communication.MessagesService.Versions.c2025_03_01_Preview)
@client({
  name: "ConversationAdministrationClient",
  service: Azure.Communication.MessagesService,
})
interface ConversationAdministrationClient
  extends Azure.Communication.MessagesService.ConversationManagementOperations {
    listConversations is Azure.Communication.MessagesService.ConversationMessagesOperations.listConversations;
    listMessages is Azure.Communication.MessagesService.ConversationMessagesOperations.listMessages;
    addParticipants is Azure.Communication.MessagesService.ConversationMessagesOperations.addParticipants;
    removeParticipants is Azure.Communication.MessagesService.ConversationMessagesOperations.removeParticipants;
    analyzeConversation is Azure.Communication.MessagesService.ConversationMessagesOperations.analyzeConversation;
  }

@added(Azure.Communication.MessagesService.Versions.c2025_03_01_Preview)
@client({
  name: "ConversationThreadClient",
  service: Azure.Communication.MessagesService,
})
interface ConversationThreadClient
  extends Azure.Communication.MessagesService.ConversationMessagesOperations {}

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
