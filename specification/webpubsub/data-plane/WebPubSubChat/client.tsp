import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;

namespace Customizations;

/** Client options for Azure Web PubSub Chat. */
model WebPubSubChatServiceClientOptions {
  /** Target hub name, which should start with alphabetic characters and only contain
     alpha-numeric characters or underscore. */
  hub: string;
}

@client({
  name: "WebPubSubChatServiceClient",
  service: WebPubSubChat,
})
interface WebPubSubChatServiceClient
  extends WebPubSubChat.WebPubSubChatServiceClient {}

@@clientName(
  WebPubSubChat.ChatConversation,
  "WebPubSubChatConversation",
  "csharp"
);
@@clientName(WebPubSubChat.ChatMessage, "WebPubSubChatMessage", "csharp");
@@clientName(WebPubSubChat.ChatRole, "WebPubSubChatRole", "csharp");
@@clientName(WebPubSubChat.ChatRoom, "WebPubSubChatRoom", "csharp");
@@clientName(
  WebPubSubChat.ChatRoomMember,
  "WebPubSubChatRoomMember",
  "csharp"
);
@@clientName(WebPubSubChat.ChatUser, "WebPubSubChatUser", "csharp");
@@clientName(
  WebPubSubChat.HumanChatUser,
  "WebPubSubHumanChatUser",
  "csharp"
);
@@clientName(
  WebPubSubChat.ChatUserKind,
  "WebPubSubChatUserKind",
  "csharp"
);
@@clientName(
  WebPubSubChat.MessageContent,
  "WebPubSubChatMessageContent",
  "csharp"
);
@@clientName(
  Azure.Core.MaxPageSizeQueryParameter.maxpagesize,
  "maxPageSize",
  "javascript"
);

@@clientInitialization(
  WebPubSubChatServiceClient,
  {
    parameters: WebPubSubChatServiceClientOptions,
  }
);
