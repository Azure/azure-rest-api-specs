import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Rest;
using TypeSpec.Http;

namespace Customizations;

/** Response containing a Web PubSub client access token. */
#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
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
@scope("csharp, java, python, javascript")
@access(Access.internal, "csharp, java, python, javascript")
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
  @apiVersion(false, "csharp, java, python, javascript")
  @query("api-version")
  apiVersion: "2024-12-01",
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

@@clientLocation(
  Customizations.generateClientToken::parameters.hub,
  WebPubSubChatServiceClient.generateClientToken,
  "java"
);

@@access(
  GenerateClientTokenResponse,
  Access.internal,
  "csharp, java, python, javascript"
);

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
@@clientName(
  Azure.Core.MaxPageSizeQueryParameter.maxpagesize,
  "max_page_size",
  "python"
);

@@clientInitialization(
  WebPubSubChatServiceClient,
  {
    parameters: WebPubSubChatServiceClientOptions,
  }
);

/** Chat topic model used by the client-specific update operation. */
@resource("topics")
@parentResource(WebPubSubChat.ChatRoom)
model ChatTopicUpdateCustomized {
  /** Topic identifier unique within the room. */
  @key("topicId")
  @visibility(Lifecycle.Read)
  @pattern("^[A-Za-z0-9_-]{1,64}$")
  @minLength(1)
  @maxLength(64)
  id: string;

  /** Topic title. */
  @minLength(1)
  @maxLength(256)
  title: string;

  /** Timestamp when the topic was created. */
  @visibility(Lifecycle.Read)
  createdAt: utcDateTime;

  /** User who created the topic. */
  @visibility(Lifecycle.Read)
  @pattern("^[^\\p{Cc}\\/\\\\#\\?:;]{1,64}$")
  @minLength(1)
  @maxLength(64)
  createdBy: string;

  /** Current lifecycle state of the topic. */
  state?: WebPubSubChat.ChatTopicState;

  /** Conversation associated with this topic. */
  @visibility(Lifecycle.Read)
  @pattern("^c\\.[A-Za-z0-9_-]{1,64}\\.[A-Za-z0-9_-]{1,64}$")
  @minLength(1)
  @maxLength(131)
  conversationId: string;

  /** Entity tag for conditional requests. */
  @visibility(Lifecycle.Read)
  etag: Azure.Core.eTag;
}

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Client-only operation override."
op updateTopicCustomized is WebPubSubChat.ConditionalOperations.ResourceUpdate<ChatTopicUpdateCustomized>;

@@override(
  WebPubSubChat.WebPubSubChatServiceClient.updateTopic,
  updateTopicCustomized,
  "javascript"
);

#suppress "@azure-tools/typespec-azure-core/documentation-required" "Client-only operation override."
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Client-only override preserves the original operation's wire signature."
op updateMessageCustomized(
  @minLength(1)
  @query("api-version")
  apiVersion: string,

  /** Target hub name. */
  @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
  @minLength(1)
  @maxLength(128)
  @clientName("hubName", "csharp")
  @path
  hub: string,

  /** Conversation identifier. */
  @pattern("^c\\.[A-Za-z0-9_-]{1,64}\\.[A-Za-z0-9_-]{1,64}$")
  @minLength(1)
  @maxLength(131)
  @path
  conversationId: string,

  /** Message identifier. */
  @pattern("^\\d+$")
  @minLength(1)
  @maxLength(128)
  @path
  messageId: string,

  /** This request has a JSON Merge Patch body. */
  @header("Content-Type")
  contentType: "application/merge-patch+json",

  /** The message to update. */
  @body
  @clientName("message")
  resource: WebPubSubChat.ChatMessage,

  /** The request should only proceed if an entity matches this string. */
  @header("If-Match")
  ifMatch?: string,

  /** The request should only proceed if no entity matches this string. */
  @header("If-None-Match")
  ifNoneMatch?: string,
):
  | TypeSpec.Http.Response<200> &
      WebPubSubChat.ChatMessage &
      Azure.Core.EtagResponseEnvelope
  | Azure.Core.Foundations.ErrorResponse;

@@override(
  WebPubSubChat.WebPubSubChatServiceClient.updateMessage,
  updateMessageCustomized
);
