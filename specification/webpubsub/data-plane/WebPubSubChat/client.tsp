import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;

@TypeSpec.Versioning.versioned(WebPubSubChat.Versions)
namespace ClientCustomizations {
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

  alias ConditionalTraits = WebPubSubChat.SupportsEtagConditionalRequests &
    Azure.Core.Traits.NoRepeatableRequests &
    Azure.Core.Traits.NoClientRequestId;

  alias CreateOrReplaceOperation<
    Resource extends TypeSpec.Reflection.Model,
    BodyParameter extends TypeSpec.Reflection.Model
  > = Azure.Core.Foundations.ResourceOperation<
    Resource,
    BodyParameter &
      Azure.Core.Traits.Private.TraitProperties<
        ConditionalTraits,
        Azure.Core.Traits.TraitLocation.Parameters,
        | Azure.Core.Traits.TraitContext.Create
        | Azure.Core.Traits.TraitContext.Update
      >,
    Azure.Core.Foundations.ResourceCreatedOrOkResponse<Resource &
      Azure.Core.Traits.Private.TraitProperties<
        ConditionalTraits,
        Azure.Core.Traits.TraitLocation.Response,
        | Azure.Core.Traits.TraitContext.Create
        | Azure.Core.Traits.TraitContext.Update
      >>,
    ConditionalTraits
  >;

  alias UpdateOperation<
    Resource extends TypeSpec.Reflection.Model,
    BodyParameter extends TypeSpec.Reflection.Model
  > = Azure.Core.Foundations.ResourceOperation<
    Resource,
    {
      /** This request has a JSON Merge Patch body. */
      @header("Content-Type")
      contentType: "application/merge-patch+json";

      ...BodyParameter;
      ...Azure.Core.Traits.Private.TraitProperties<
        ConditionalTraits,
        Azure.Core.Traits.TraitLocation.Parameters,
        Azure.Core.Traits.TraitContext.Update
      >;
    },
    Azure.Core.Foundations.ResourceOkResponse<Resource &
      Azure.Core.Traits.Private.TraitProperties<
        ConditionalTraits,
        Azure.Core.Traits.TraitLocation.Response,
        Azure.Core.Traits.TraitContext.Update
      >>,
    ConditionalTraits
  >;

  /** Continuation token query parameter for pagination. */
  model ContinuationTokenQueryParameter {
    /** Continuation token for pagination. */
    @query
    @continuationToken
    @minLength(1)
    continuationToken?: string;
  }

  alias ListWithContinuationToken<Resource extends TypeSpec.Reflection.Model> = WebPubSubChat.Operations.ResourceList<
    Resource,
    Azure.Core.Traits.ListQueryParametersTrait<{
      ...Azure.Core.MaxPageSizeQueryParameter;
      ...ContinuationTokenQueryParameter;
    }>
  >;

  /** Request body parameter for role operations. */
  model RoleBodyParameter {
    /** The resource instance. */
    @body
    resource: WebPubSubChat.ChatRole;
  }

  /** Request body parameter for room operations. */
  model RoomBodyParameter {
    /** The resource instance. */
    @body
    resource: WebPubSubChat.ChatRoom;
  }

  /** Request body parameter for room member operations. */
  model RoomMemberBodyParameter {
    /** The resource instance. */
    @body
    resource: WebPubSubChat.ChatRoomMember;
  }

  /** Request body parameter for user operations. */
  model UserBodyParameter {
    /** The resource instance. */
    @body
    resource: WebPubSubChat.ChatUser;
  }

  /** Request body parameter for topic create or replace operations. */
  model TopicCreateOrReplaceBodyParameter {
    /** The resource instance. */
    @body
    resource: WebPubSubChat.ChatTopic;
  }

  /** Request body parameter for topic update operations. */
  model TopicUpdateBodyParameter {
    /** The resource instance. */
    @body
    resource: WebPubSubChat.ChatTopic;
  }

  /** Request body parameter for message update operations. */
  model MessageUpdateBodyParameter {
    /** The resource instance. */
    @body
    resource: WebPubSubChat.ChatMessage;
  }

  @client({
    name: "WebPubSubChatServiceClient",
    service: WebPubSubChat,
  })
  interface WebPubSubChatServiceClient
    extends WebPubSubChat.WebPubSubChatServiceClient {
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "The existing Web PubSub token operation has a non-standard wire contract."
    generateClientToken is Customizations.generateClientToken;

    /** Update a message. */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Defined with an explicit body parameter model so SDK parameter names and request models can be customized in pure TypeSpec."
    #suppress "@typespec/http/deprecated-implicit-optionality" "Legacy"
    @summary("Update a message.")
    @TypeSpec.Rest.updatesResource(WebPubSubChat.ChatMessage)
    @patch(#{ implicitOptionality: true })
    updateMessage is UpdateOperation<
      WebPubSubChat.ChatMessage,
      MessageUpdateBodyParameter
    >;

    /** Create or replace a role. */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Defined with an explicit body parameter model so SDK parameter names and request models can be customized in pure TypeSpec."
    @summary("Create or replace a role.")
    @TypeSpec.Rest.createsOrReplacesResource(WebPubSubChat.ChatRole)
    createOrReplaceRole is CreateOrReplaceOperation<
      WebPubSubChat.ChatRole,
      RoleBodyParameter
    >;

    /** Create or replace a room with a client-specified ID. */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Defined with an explicit body parameter model so SDK parameter names and request models can be customized in pure TypeSpec."
    @summary("Create or replace a room.")
    @TypeSpec.Rest.createsOrReplacesResource(WebPubSubChat.ChatRoom)
    createOrReplaceRoom is CreateOrReplaceOperation<
      WebPubSubChat.ChatRoom,
      RoomBodyParameter
    >;

    /** Create or replace a topic with a client-specified ID. */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Defined with an explicit body parameter model so SDK parameter names and request models can be customized in pure TypeSpec."
    @TypeSpec.Versioning.added(WebPubSubChat.Versions.v2026_08_01_preview)
    @summary("Create or replace a topic.")
    @TypeSpec.Rest.createsOrReplacesResource(WebPubSubChat.ChatTopic)
    createOrReplaceTopic is CreateOrReplaceOperation<
      WebPubSubChat.ChatTopic,
      TopicCreateOrReplaceBodyParameter
    >;

    /** Update a topic. */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Defined with an explicit body parameter model so SDK parameter names and request models can be customized in pure TypeSpec."
    #suppress "@typespec/http/deprecated-implicit-optionality" "Legacy"
    @TypeSpec.Versioning.added(WebPubSubChat.Versions.v2026_08_01_preview)
    @summary("Update a topic.")
    @TypeSpec.Rest.updatesResource(WebPubSubChat.ChatTopic)
    @patch(#{ implicitOptionality: true })
    updateTopic is UpdateOperation<
      WebPubSubChat.ChatTopic,
      TopicUpdateBodyParameter
    >;

    /** Create or replace a room member. */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Defined with an explicit body parameter model so SDK parameter names and request models can be customized in pure TypeSpec."
    @summary("Create or replace a room member.")
    @TypeSpec.Rest.createsOrReplacesResource(WebPubSubChat.ChatRoomMember)
    createOrReplaceRoomMember is CreateOrReplaceOperation<
      WebPubSubChat.ChatRoomMember,
      RoomMemberBodyParameter
    >;

    /** Create or replace a user. The request body is a polymorphic `ChatUser` (e.g. `HumanChatUser`) selected by the `kind` discriminator. */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Defined with an explicit body parameter model so SDK parameter names and request models can be customized in pure TypeSpec."
    @summary("Create or replace a user.")
    @TypeSpec.Rest.createsOrReplacesResource(WebPubSubChat.ChatUser)
    createOrReplaceUser is CreateOrReplaceOperation<
      WebPubSubChat.ChatUser,
      UserBodyParameter
    >;

    /** Query roles in a hub. */
    @summary("Query roles in a hub.")
    listRoles is ListWithContinuationToken<WebPubSubChat.ChatRole>;

    /** List rooms with pagination. */
    @TypeSpec.Versioning.added(WebPubSubChat.Versions.v2026_08_01_preview)
    @summary("List rooms with pagination.")
    listRooms is ListWithContinuationToken<WebPubSubChat.ChatRoom>;

    /** List topics in a room with pagination. */
    @TypeSpec.Versioning.added(WebPubSubChat.Versions.v2026_08_01_preview)
    @summary("List topics in a room with pagination.")
    listTopics is ListWithContinuationToken<WebPubSubChat.ChatTopic>;

    /** Get room members. */
    @summary("Get room members.")
    listRoomMembers is ListWithContinuationToken<WebPubSubChat.ChatRoomMember>;

    /** List all users with pagination. */
    @TypeSpec.Versioning.added(WebPubSubChat.Versions.v2026_08_01_preview)
    @summary("List all users with pagination.")
    listUsers is ListWithContinuationToken<WebPubSubChat.ChatUser>;

    /** List rooms for a user with pagination. */
    @TypeSpec.Versioning.added(WebPubSubChat.Versions.v2026_08_01_preview)
    @summary("List rooms for a user with pagination.")
    @TypeSpec.Rest.listsResource(WebPubSubChat.ChatUserRoom)
    listRoomsForUser is ListWithContinuationToken<WebPubSubChat.ChatUserRoom>;
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

  @@clientName(
    RoleBodyParameter.resource,
    "role",
    "csharp,java,python,javascript,go,rust"
  );
  @@clientName(
    RoomBodyParameter.resource,
    "room",
    "csharp,java,python,javascript,go,rust"
  );
  @@clientName(
    RoomMemberBodyParameter.resource,
    "member",
    "csharp,java,python,javascript,go,rust"
  );
  @@clientName(
    UserBodyParameter.resource,
    "user",
    "csharp,java,python,javascript,go,rust"
  );
  @@clientName(
    TopicCreateOrReplaceBodyParameter.resource,
    "topic",
    "csharp,java,python,javascript,go,rust"
  );
  @@clientName(
    TopicUpdateBodyParameter.resource,
    "topic",
    "csharp,java,python,javascript,go,rust"
  );
  @@clientName(
    MessageUpdateBodyParameter.resource,
    "message",
    "csharp,java,python,javascript,go,rust"
  );

  @@clientInitialization(
    WebPubSubChatServiceClient,
    {
      parameters: WebPubSubChatServiceClientOptions,
    }
  );

  // Python and JavaScript callers resume pagination through by_page/byPage options.
  @@scope(ContinuationTokenQueryParameter.continuationToken, "!python,!javascript");

  @@alternateType(
    TopicCreateOrReplaceBodyParameter.resource,
    ClientCustomizations.ChatTopicCreateOrReplace,
    "python,javascript"
  );
  @@alternateType(
    TopicUpdateBodyParameter.resource,
    ClientCustomizations.ChatTopicUpdate,
    "python,javascript"
  );

  @@alternateType(
    MessageUpdateBodyParameter.resource,
    ClientCustomizations.ChatMessageUpdate,
    "python,javascript"
  );
  @@alternateType(
    RoleBodyParameter.resource,
    ClientCustomizations.ChatRoleCreateOrReplace,
    "python,javascript"
  );
  @@alternateType(
    RoomBodyParameter.resource,
    ClientCustomizations.ChatRoomCreateOrReplace,
    "python,javascript"
  );
  @@alternateType(
    RoomMemberBodyParameter.resource,
    ClientCustomizations.ChatRoomMemberCreateOrReplace,
    "python,javascript"
  );
  @@alternateType(
    UserBodyParameter.resource,
    ClientCustomizations.ChatUserCreateOrReplace,
    "python"
  );
  @@alternateType(
    UserBodyParameter.resource,
    ClientCustomizations.HumanChatUserCreateOrReplace,
    "javascript"
  );
}
