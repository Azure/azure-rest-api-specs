import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";
import "./client-customizations.mjs";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;

@TypeSpec.Versioning.versioned(WebPubSubChat.Versions)
namespace ClientCustomizations {
  /** Give a template-expanded request body a resource-specific SDK parameter name. */
  extern dec requestParameterName(
    target: TypeSpec.Reflection.Operation,
    name: valueof string,
    scope: valueof string
  );

  /** Substitute the resource request model for selected SDKs without changing the REST operation. */
  extern dec requestModel(
    target: TypeSpec.Reflection.Operation,
    input: TypeSpec.Reflection.Model,
    scope: valueof string
  );

  /** Omit the initial continuation token from Python paging method parameters. */
  extern dec omitContinuationToken(
    target: TypeSpec.Reflection.Operation,
    scope: valueof string
  );

  /** Properties supplied when creating or replacing a role. */
  model ChatRoleCreateOrReplace {
    ...CreateOrUpdate<{
      ...WebPubSubChat.ChatRole;
    }>;
  }

  /** Properties supplied when creating or replacing a room. */
  model ChatRoomCreateOrReplace {
    ...CreateOrUpdate<{
      ...WebPubSubChat.ChatRoom;
    }>;
  }

  /** Properties supplied when creating or replacing a room member. */
  model ChatRoomMemberCreateOrReplace {
    ...CreateOrUpdate<{
      ...WebPubSubChat.ChatRoomMember;
    }>;
  }

  /** Properties supplied when creating or replacing a user. */
  @discriminator("kind")
  model ChatUserCreateOrReplace {
    ...CreateOrUpdate<{
      ...WebPubSubChat.ChatUser;
    }>;
  }

  /** Properties supplied when creating or replacing a human user. */
  model HumanChatUserCreateOrReplace extends ChatUserCreateOrReplace {
    ...CreateOrUpdate<{
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
    "python,javascript"
  );

  /** Properties supplied when creating or replacing a topic. */
  @TypeSpec.Versioning.added(WebPubSubChat.Versions.v2026_08_01_preview)
  model ChatTopicCreateOrReplace {
    ...CreateOrUpdate<{
      ...OmitProperties<WebPubSubChat.ChatTopic, "state">;

      // State is writable on replacement, but must not be required for creation.
      ...OptionalProperties<PickProperties<WebPubSubChat.ChatTopic, "state">>;
    }>;
  }

  /** Properties supplied when partially updating a topic. */
  @TypeSpec.Versioning.added(WebPubSubChat.Versions.v2026_08_01_preview)
  model ChatTopicUpdate {
    ...OptionalProperties<Update<{
      ...WebPubSubChat.ChatTopic;
    }>>;
  }

  @@clientNamespace(ClientCustomizations, "WebPubSubChat", "javascript");
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

  @@clientName(
    WebPubSubChat.ChatConversation.parentRoom,
    "roomId",
    "csharp,java,python,javascript,go,rust"
  );

  @@ClientCustomizations.requestParameterName(
    WebPubSubChatServiceClient.createOrReplaceRole,
    "role",
    "csharp,java,python,javascript,go,rust"
  );
  @@ClientCustomizations.requestParameterName(
    WebPubSubChatServiceClient.createOrReplaceRoom,
    "room",
    "csharp,java,python,javascript,go,rust"
  );
  @@ClientCustomizations.requestParameterName(
    WebPubSubChatServiceClient.createOrReplaceRoomMember,
    "member",
    "csharp,java,python,javascript,go,rust"
  );
  @@ClientCustomizations.requestParameterName(
    WebPubSubChatServiceClient.createOrReplaceUser,
    "user",
    "csharp,java,python,javascript,go,rust"
  );
  @@ClientCustomizations.requestParameterName(
    WebPubSubChatServiceClient.createOrReplaceTopic,
    "topic",
    "csharp,java,python,javascript,go,rust"
  );
  @@ClientCustomizations.requestParameterName(
    WebPubSubChatServiceClient.updateTopic,
    "topic",
    "csharp,java,python,javascript,go,rust"
  );
  @@ClientCustomizations.requestParameterName(
    WebPubSubChatServiceClient.updateMessage,
    "message",
    "csharp,java,python,javascript,go,rust"
  );

  @@clientInitialization(
    WebPubSubChatServiceClient,
    {
      parameters: WebPubSubChatServiceClientOptions,
    }
  );

  // Python callers resume pagination through ItemPaged.by_page(continuation_token=...).
  @@ClientCustomizations.omitContinuationToken(
    WebPubSubChatServiceClient.listRoles,
    "!python"
  );
  @@ClientCustomizations.omitContinuationToken(
    WebPubSubChatServiceClient.listRooms,
    "!python"
  );
  @@ClientCustomizations.omitContinuationToken(
    WebPubSubChatServiceClient.listTopics,
    "!python"
  );
  @@ClientCustomizations.omitContinuationToken(
    WebPubSubChatServiceClient.listRoomMembers,
    "!python"
  );
  @@ClientCustomizations.omitContinuationToken(
    WebPubSubChatServiceClient.listUsers,
    "!python"
  );
  @@ClientCustomizations.omitContinuationToken(
    WebPubSubChatServiceClient.listRoomsForUser,
    "!python"
  );

  @@ClientCustomizations.requestModel(
    WebPubSubChatServiceClient.createOrReplaceTopic,
    ClientCustomizations.ChatTopicCreateOrReplace,
    "python,javascript"
  );
  @@ClientCustomizations.requestModel(
    WebPubSubChatServiceClient.updateTopic,
    ClientCustomizations.ChatTopicUpdate,
    "python,javascript"
  );

  @@ClientCustomizations.requestModel(
    WebPubSubChatServiceClient.updateMessage,
    ClientCustomizations.ChatMessageUpdate,
    "python,javascript"
  );
  @@ClientCustomizations.requestModel(
    WebPubSubChatServiceClient.createOrReplaceRole,
    ClientCustomizations.ChatRoleCreateOrReplace,
    "python,javascript"
  );
  @@ClientCustomizations.requestModel(
    WebPubSubChatServiceClient.createOrReplaceRoom,
    ClientCustomizations.ChatRoomCreateOrReplace,
    "python,javascript"
  );
  @@ClientCustomizations.requestModel(
    WebPubSubChatServiceClient.createOrReplaceRoomMember,
    ClientCustomizations.ChatRoomMemberCreateOrReplace,
    "python,javascript"
  );
  @@ClientCustomizations.requestModel(
    WebPubSubChatServiceClient.createOrReplaceUser,
    ClientCustomizations.ChatUserCreateOrReplace,
    "python"
  );
  @@ClientCustomizations.requestModel(
    WebPubSubChatServiceClient.createOrReplaceUser,
    ClientCustomizations.HumanChatUserCreateOrReplace,
    "javascript"
  );
}
