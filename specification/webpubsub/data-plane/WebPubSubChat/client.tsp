import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;

namespace Customizations;

/** Response containing a Web PubSub client access token. */
model GenerateClientTokenResponse {
  /** Access token used to connect to Azure Web PubSub. */
  token: string;

  /** Response content type. */
  @header("content-type")
  contentType: "application/json";
}

/** Generate a token for connecting a client to Azure Web PubSub. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "The existing Web PubSub token operation has a non-standard wire contract."
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "The token endpoint pins the Web PubSub service API version 2024-12-01 instead of using the Chat service version."
@summary("Generate a token for connecting a client to Azure Web PubSub.")
@route("/api/hubs/{hub}/:generateToken")
@post
@scope("csharp")
@access(Access.internal, "csharp")
op generateClientToken(
  /** Target hub name. */
  @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
  @path
  hub: string,

  /** User identifier for the client connection. */
  @query
  userId?: string,

  /** Roles granted to the client connection. */
  #suppress "@azure-tools/typespec-azure-core/no-query-explode" "The existing Web PubSub token endpoint represents roles as repeated role query parameters."
  @query(#{ explode: true })
  role?: string[],

  /** Lifetime of the generated token, in minutes. */
  @minValue(1)
  @query
  minutesToExpire?: int32 = 60,

  /** API version of the Web PubSub token service operation. */
  @apiVersion(false, "csharp")
  @query("api-version")
  apiVersion: "2024-12-01",

  /** Web PubSub client protocol used by the Chat client. */
  @query
  clientType: "default",
): GenerateClientTokenResponse | Azure.Core.Foundations.ErrorResponse;

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
  extends WebPubSubChat.WebPubSubChatServiceClient {
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "The existing Web PubSub token operation has a non-standard wire contract."
  generateClientToken is Customizations.generateClientToken;
}

@@access(GenerateClientTokenResponse, Access.internal, "csharp");

@@clientName(
  WebPubSubChat.ChatConversation,
  "WebPubSubChatConversation",
  "csharp"
);
@@clientName(WebPubSubChat.ChatMessage, "WebPubSubChatMessage", "csharp");
@@clientName(WebPubSubChat.ChatRole, "WebPubSubChatRole", "csharp");
@@clientName(WebPubSubChat.ChatRoom, "WebPubSubChatRoom", "csharp");
@@clientName(WebPubSubChat.ChatRoomMember, "WebPubSubChatRoomMember", "csharp");
@@clientName(WebPubSubChat.ChatUser, "WebPubSubChatUser", "csharp");
@@clientName(WebPubSubChat.HumanChatUser, "WebPubSubHumanChatUser", "csharp");
@@clientName(WebPubSubChat.ChatUserKind, "WebPubSubChatUserKind", "csharp");
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
