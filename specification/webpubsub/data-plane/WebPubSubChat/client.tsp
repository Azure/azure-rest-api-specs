import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";
import "./python-customizations.mjs";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;

@TypeSpec.Versioning.versioned(WebPubSubChat.Versions)
namespace WebPubSubChat.PythonCustomizations {
  /** Substitute the resource request model for Python without changing the REST operation. */
  extern dec pythonRequestModel(
    target: TypeSpec.Reflection.Operation,
    input: TypeSpec.Reflection.Model
  );

  /** Properties supplied when creating a role. */
  model ChatRoleCreate {
    ...Create<{
      ...WebPubSubChat.ChatRole;
    }>;
  }

  /** Properties supplied when creating a room. */
  model ChatRoomCreate {
    ...Create<{
      ...WebPubSubChat.ChatRoom;
    }>;
  }

  /** Properties supplied when creating a room member. */
  model ChatRoomMemberCreate {
    ...Create<{
      ...WebPubSubChat.ChatRoomMember;
    }>;
  }

  /** Properties supplied when creating a user. */
  @discriminator("kind")
  model ChatUserCreate {
    ...Create<{
      ...WebPubSubChat.ChatUser;
    }>;
  }

  /** Properties supplied when creating a human user. */
  model HumanChatUserCreate extends ChatUserCreate {
    ...Create<{
      ...WebPubSubChat.HumanChatUser;
    }>;
  }

  /** Properties supplied when partially updating a message. */
  model ChatMessageUpdate {
    ...OptionalProperties<Update<{
      ...WebPubSubChat.ChatMessage;
    }>>;
  }

  @@alternateType(
    ChatMessageUpdate.content,
    WebPubSubChat.MessageContent,
    "python"
  );

  /** Properties supplied when creating a topic. */
  @TypeSpec.Versioning.added(WebPubSubChat.Versions.v2026_08_01_preview)
  model ChatTopicCreate {
    ...Create<{
      ...WebPubSubChat.ChatTopic;
    }>;
  }

  /** Properties supplied when partially updating a topic. */
  @TypeSpec.Versioning.added(WebPubSubChat.Versions.v2026_08_01_preview)
  model ChatTopicUpdate {
    ...OptionalProperties<Update<{
      ...WebPubSubChat.ChatTopic;
    }>>;
  }
}

namespace Customizations {
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
  @@clientName(
    WebPubSubChat.ChatRoomMember,
    "WebPubSubChatRoomMember",
    "csharp"
  );
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

  @@WebPubSubChat.PythonCustomizations.pythonRequestModel(
    WebPubSubChatServiceClient.createOrReplaceTopic,
    WebPubSubChat.PythonCustomizations.ChatTopicCreate
  );
  @@WebPubSubChat.PythonCustomizations.pythonRequestModel(
    WebPubSubChatServiceClient.updateTopic,
    WebPubSubChat.PythonCustomizations.ChatTopicUpdate
  );

  @@WebPubSubChat.PythonCustomizations.pythonRequestModel(
    WebPubSubChatServiceClient.updateMessage,
    WebPubSubChat.PythonCustomizations.ChatMessageUpdate
  );
  @@WebPubSubChat.PythonCustomizations.pythonRequestModel(
    WebPubSubChatServiceClient.createOrReplaceRole,
    WebPubSubChat.PythonCustomizations.ChatRoleCreate
  );
  @@WebPubSubChat.PythonCustomizations.pythonRequestModel(
    WebPubSubChatServiceClient.createOrReplaceRoom,
    WebPubSubChat.PythonCustomizations.ChatRoomCreate
  );
  @@WebPubSubChat.PythonCustomizations.pythonRequestModel(
    WebPubSubChatServiceClient.createOrReplaceRoomMember,
    WebPubSubChat.PythonCustomizations.ChatRoomMemberCreate
  );
  @@WebPubSubChat.PythonCustomizations.pythonRequestModel(
    WebPubSubChatServiceClient.createOrReplaceUser,
    WebPubSubChat.PythonCustomizations.ChatUserCreate
  );
}
