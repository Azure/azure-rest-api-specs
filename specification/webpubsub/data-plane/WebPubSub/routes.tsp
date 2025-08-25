import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Http;

namespace WebPubSub {
  /**
   * Get service health status.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  @summary("Get service health status.")
  @route("/api/health")
  @head
  op getServiceStatus is Azure.Core.Foundations.Operation<{}, void>;

  /**
   * Add filtered connections to multiple groups.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  @summary("Add filtered connections to multiple groups.")
  @route("/api/hubs/{hub}/:addToGroups")
  @post
  op addConnectionsToGroups is Azure.Core.Foundations.Operation<
    {
      /**
       * Target hub name, which should start with alphabetic characters and only contain
       * alpha-numeric characters or underscore.
       */
      @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
      @path
      hub: string;

      /**
       * Target groups and connection filter.
       */
      @bodyRoot
      groupsToAdd: AddToGroupsRequest;
    },
    void
  >;

  /**
   * Close the connections in the hub.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  @summary("Close the connections in the hub.")
  @route("/api/hubs/{hub}/:closeConnections")
  @post
  op closeAllConnections is Azure.Core.Foundations.Operation<
    {
      /**
       * Target hub name, which should start with alphabetic characters and only contain
       * alpha-numeric characters or underscore.
       */
      @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
      @path
      hub: string;

      /**
       * Exclude these connectionIds when closing the connections in the hub.
       */
      @query
      excluded?: string[];

      /**
       * The reason closing the client connection.
       */
      @query
      reason?: string;
    },
    void
  >;

  /**
   * Generate token for the client to connect Azure Web PubSub service.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  @summary("Generate token for the client to connect Azure Web PubSub service.")
  @route("/api/hubs/{hub}/:generateToken")
  @post
  op generateClientToken is Azure.Core.Foundations.Operation<
    {
      /**
       * Target hub name, which should start with alphabetic characters and only contain
       * alpha-numeric characters or underscore.
       */
      @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
      @path
      hub: string;

      /**
       * User Id.
       */
      @query
      userId?: string;

      /**
       * Roles that the connection with the generated token will have.
       */
      @query
      roles?: string[];

      /**
       * The expire time of the generated token.
       */
      @minValue(1)
      @query
      minutesToExpire?: int32 = 60;

      /**
       * Groups that the connection will join when it connects.
       */
      @query
      groups?: string[];

      /**
       * The type of client. Case-insensitive. If not set, it's "Default". For Web
       * PubSub for Socket.IO, only the default value is supported. For Web PubSub, the
       * valid values are 'Default' and 'MQTT'.
       */
      @query
      clientProtocol?: WebPubSubClientType = WebPubSubClientType.Default;
    },
    ClientTokenResponse & {
      @header("content-type")
      contentType: ResponseContentType;
    }
  >;

  /**
   * Remove filtered connections from multiple groups.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  @summary("Remove filtered connections from multiple groups.")
  @route("/api/hubs/{hub}/:removeFromGroups")
  @post
  op removeConnectionsFromGroups is Azure.Core.Foundations.Operation<
    {
      /**
       * Target hub name, which should start with alphabetic characters and only contain
       * alpha-numeric characters or underscore.
       */
      @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
      @path
      hub: string;

      /**
       * Target groups and connection filter.
       */
      @bodyRoot
      groupsToRemove: RemoveFromGroupsRequest;
    },
    void
  >;

  /**
   * Broadcast content inside request body to all the connected client connections.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/byos" "Web PubSub is a real-time messaging service that handles binary data directly, BYOS pattern not applicable"
  @summary("Broadcast content inside request body to all the connected client connections.")
  @route("/api/hubs/{hub}/:send")
  @post
  op sendToAll is Azure.Core.Foundations.Operation<
    {
      /**
       * Target hub name, which should start with alphabetic characters and only contain
       * alpha-numeric characters or underscore.
       */
      @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
      @path
      hub: string;

      /**
       * Excluded connection Ids.
       */
      @query
      excluded?: string[];

      /**
       * Following OData filter syntax to filter out the subscribers receiving the
       * messages.
       */
      @query
      filter?: string;

      /**
       * The time-to-live (TTL) value in seconds for messages sent to the service. 0 is
       * the default value, which means the message never expires. 300 is the maximum
       * value. If this parameter is non-zero, messages that are not consumed by the
       * client within the specified TTL will be dropped by the service. This parameter
       * can help when the client's bandwidth is limited.
       */
      @maxValue(300)
      @query
      messageTtlSeconds?: int32;

      /**
       * Upload file type
       */
      @header("content-type")
      contentType: MessageContentType;

      /**
       * The payload body.
       */
      @bodyRoot
      message: bytes;
    },
    void
  >;

  /**
   * Close the client connection.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Preserving existing API operation name for backward compatibility"
  @summary("Close the client connection.")
  @route("/api/hubs/{hub}/connections/{connectionId}")
  @delete
  op closeConnection is Azure.Core.Foundations.Operation<
    {
      /**
       * Target hub name, which should start with alphabetic characters and only contain
       * alpha-numeric characters or underscore.
       */
      @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
      @path
      hub: string;

      /**
       * Target connection Id.
       */
      @minLength(1)
      @path
      connectionId: string;

      /**
       * The reason closing the client connection.
       */
      @query
      reason?: string;
    },
    void
  >;

  /**
   * Check if the connection with the given connectionId exists.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  @summary("Check if the connection with the given connectionId exists.")
  @route("/api/hubs/{hub}/connections/{connectionId}")
  @head
  op connectionExists is Azure.Core.Foundations.Operation<
    {
      /**
       * Target hub name, which should start with alphabetic characters and only contain
       * alpha-numeric characters or underscore.
       */
      @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
      @path
      hub: string;

      /**
       * The connection Id.
       */
      @minLength(1)
      @path
      connectionId: string;
    },
    OkResponse | NotFoundResponse
  >;

  /**
   * Send content inside request body to the specific connection.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/byos" "Web PubSub is a real-time messaging service that handles binary data directly, BYOS pattern not applicable"
  @summary("Send content inside request body to the specific connection.")
  @route("/api/hubs/{hub}/connections/{connectionId}/:send")
  @post
  op sendToConnection is Azure.Core.Foundations.Operation<
    {
      /**
       * Target hub name, which should start with alphabetic characters and only contain
       * alpha-numeric characters or underscore.
       */
      @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
      @path
      hub: string;

      /**
       * The connection Id.
       */
      @minLength(1)
      @path
      connectionId: string;

      /**
       * The time-to-live (TTL) value in seconds for messages sent to the service. 0 is
       * the default value, which means the message never expires. 300 is the maximum
       * value. If this parameter is non-zero, messages that are not consumed by the
       * client within the specified TTL will be dropped by the service. This parameter
       * can help when the client's bandwidth is limited.
       */
      @maxValue(300)
      @query
      messageTtlSeconds?: int32;

      /**
       * Upload file type
       */
      @header("content-type")
      contentType: MessageContentType;

      /**
       * The payload body.
       */
      @bodyRoot
      message: bytes;
    },
    void
  >;

  /**
   * Remove a connection from all groups.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Preserving existing API operation name for backward compatibility"
  @summary("Remove a connection from all groups.")
  @route("/api/hubs/{hub}/connections/{connectionId}/groups")
  @delete
  op removeConnectionFromAllGroups is Azure.Core.Foundations.Operation<
    {
      /**
       * Target hub name, which should start with alphabetic characters and only contain
       * alpha-numeric characters or underscore.
       */
      @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
      @path
      hub: string;

      /**
       * Target connection Id.
       */
      @minLength(1)
      @path
      connectionId: string;
    },
    void
  >;

  /**
   * Check if there are any client connections inside the given group
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  @summary("Check if there are any client connections inside the given group")
  @route("/api/hubs/{hub}/groups/{group}")
  @head
  op groupExists is Azure.Core.Foundations.Operation<
    {
      /**
       * Target hub name, which should start with alphabetic characters and only contain
       * alpha-numeric characters or underscore.
       */
      @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
      @path
      hub: string;

      /**
       * Target group name, which length should be greater than 0 and less than 1025.
       */
      @maxLength(1024)
      @minLength(1)
      @pattern("^(?!\\s+$).+$")
      @path
      group: string;
    },
    OkResponse | NotFoundResponse
  >;

  /**
   * Close connections in the specific group.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  @summary("Close connections in the specific group.")
  @route("/api/hubs/{hub}/groups/{group}/:closeConnections")
  @post
  op closeGroupConnections is Azure.Core.Foundations.Operation<
    {
      /**
       * Target hub name, which should start with alphabetic characters and only contain
       * alpha-numeric characters or underscore.
       */
      @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
      @path
      hub: string;

      /**
       * Target group name, which length should be greater than 0 and less than 1025.
       */
      @maxLength(1024)
      @minLength(1)
      @pattern("^(?!\\s+$).+$")
      @path
      group: string;

      /**
       * Exclude these connectionIds when closing the connections in the group.
       */
      @query
      excluded?: string[];

      /**
       * The reason closing the client connection.
       */
      @query
      reason?: string;
    },
    void
  >;

  /**
   * Send content inside request body to a group of connections.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/byos" "Web PubSub is a real-time messaging service that handles binary data directly, BYOS pattern not applicable"
  @summary("Send content inside request body to a group of connections.")
  @route("/api/hubs/{hub}/groups/{group}/:send")
  @post
  op sendToGroup is Azure.Core.Foundations.Operation<
    {
      /**
       * Target hub name, which should start with alphabetic characters and only contain
       * alpha-numeric characters or underscore.
       */
      @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
      @path
      hub: string;

      /**
       * Target group name, which length should be greater than 0 and less than 1025.
       */
      @maxLength(1024)
      @minLength(1)
      @pattern("^(?!\\s+$).+$")
      @path
      group: string;

      /**
       * Excluded connection Ids
       */
      @query
      excluded?: string[];

      /**
       * Following OData filter syntax to filter out the subscribers receiving the
       * messages.
       */
      @query
      filter?: string;

      /**
       * The time-to-live (TTL) value in seconds for messages sent to the service. 0 is
       * the default value, which means the message never expires. 300 is the maximum
       * value. If this parameter is non-zero, messages that are not consumed by the
       * client within the specified TTL will be dropped by the service. This parameter
       * can help when the client's bandwidth is limited.
       */
      @maxValue(300)
      @query
      messageTtlSeconds?: int32;

      /**
       * Upload file type
       */
      @header("content-type")
      contentType: MessageContentType;

      /**
       * The payload body.
       */
      @bodyRoot
      message: bytes;
    },
    void
  >;

  /**
   * List connections in a group.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Preserving existing API operation name for backward compatibility"
  @summary("List connections in a group.")
  @route("/api/hubs/{hub}/groups/{group}/connections")
  @get
  @list
  op listConnectionsInGroup is Azure.Core.Foundations.Operation<
    {
      /**
       * Target hub name, which should start with alphabetic characters and only contain
       * alpha-numeric characters or underscore.
       */
      @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
      @path
      hub: string;

      /**
       * Target group name, whose length should be greater than 0 and less than 1025.
       */
      @maxLength(1024)
      @minLength(1)
      @pattern("^(?!\\s+$).+$")
      @path
      group: string;

      /**
       * The maximum number of connections to include in a single response. It should be
       * between 1 and 200.
       */
      @maxValue(200)
      @minValue(1)
      @query
      maxpagesize?: int32;

      /**
       * The maximum number of connections to return. If the value is not set, then all
       * the connections in a group are returned.
       */
      @maxValue(2147483647)
      @minValue(1)
      @query
      top?: int32;

      /**
       * A token that allows the client to retrieve the next page of results. This
       * parameter is provided by the service in the response of a previous request when
       * there are additional results to be fetched. Clients should include the
       * continuationToken in the next request to receive the subsequent page of data.
       * If this parameter is omitted, the server will return the first page of results.
       */
      @query
      @continuationToken
      continuationToken?: string;
    },
    GroupMemberPagedValues
  >;

  /**
   * Remove a connection from the target group.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Preserving existing API operation name for backward compatibility"
  @summary("Remove a connection from the target group.")
  @route("/api/hubs/{hub}/groups/{group}/connections/{connectionId}")
  @delete
  op removeConnectionFromGroup is Azure.Core.Foundations.Operation<
    {
      /**
       * Target hub name, which should start with alphabetic characters and only contain
       * alpha-numeric characters or underscore.
       */
      @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
      @path
      hub: string;

      /**
       * Target group name, which length should be greater than 0 and less than 1025.
       */
      @maxLength(1024)
      @minLength(1)
      @pattern("^(?!\\s+$).+$")
      @path
      group: string;

      /**
       * Target connection Id.
       */
      @minLength(1)
      @path
      connectionId: string;
    },
    void
  >;

  /**
   * Add a connection to the target group.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Preserving existing API operation name for backward compatibility"
  @summary("Add a connection to the target group.")
  @route("/api/hubs/{hub}/groups/{group}/connections/{connectionId}")
  @put
  op addConnectionToGroup is Azure.Core.Foundations.Operation<
    {
      /**
       * Target hub name, which should start with alphabetic characters and only contain
       * alpha-numeric characters or underscore.
       */
      @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
      @path
      hub: string;

      /**
       * Target group name, which length should be greater than 0 and less than 1025.
       */
      @maxLength(1024)
      @minLength(1)
      @pattern("^(?!\\s+$).+$")
      @path
      group: string;

      /**
       * Target connection Id
       */
      @minLength(1)
      @path
      connectionId: string;
    },
    {}
  >;

  /**
   * Revoke permission for the connection.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Preserving existing API operation name for backward compatibility"
  @summary("Revoke permission for the connection.")
  @route("/api/hubs/{hub}/permissions/{permission}/connections/{connectionId}")
  @delete
  op revokePermission is Azure.Core.Foundations.Operation<
    {
      /**
       * Target hub name, which should start with alphabetic characters and only contain
       * alpha-numeric characters or underscore.
       */
      @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
      @path
      hub: string;

      /**
       * The permission: current supported actions are joinLeaveGroup and sendToGroup.
       */
      @path
      permission: WebPubSubPermission;

      /**
       * Target connection Id.
       */
      @minLength(1)
      @path
      connectionId: string;

      /**
       * The meaning of the target depends on the specific permission. For
       * joinLeaveGroup and sendToGroup, targetName is a required parameter standing for
       * the group name.
       */
      @query
      targetName?: string;
    },
    void
  >;

  /**
   * Check if a connection has permission to the specified action.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Preserving existing API operation name for backward compatibility"
  @summary("Check if a connection has permission to the specified action.")
  @route("/api/hubs/{hub}/permissions/{permission}/connections/{connectionId}")
  @head
  op checkPermission is Azure.Core.Foundations.Operation<
    {
      /**
       * Target hub name, which should start with alphabetic characters and only contain
       * alpha-numeric characters or underscore.
       */
      @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
      @path
      hub: string;

      /**
       * The permission: current supported actions are joinLeaveGroup and sendToGroup.
       */
      @path
      permission: WebPubSubPermission;

      /**
       * Target connection Id.
       */
      @minLength(1)
      @path
      connectionId: string;

      /**
       * The meaning of the target depends on the specific permission. For
       * joinLeaveGroup and sendToGroup, targetName is a required parameter standing for
       * the group name.
       */
      @query
      targetName?: string;
    },
    OkResponse | NotFoundResponse
  >;

  /**
   * Grant permission to the connection.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Preserving existing API operation name for backward compatibility"
  @summary("Grant permission to the connection.")
  @route("/api/hubs/{hub}/permissions/{permission}/connections/{connectionId}")
  @put
  op grantPermission is Azure.Core.Foundations.Operation<
    {
      /**
       * Target hub name, which should start with alphabetic characters and only contain
       * alpha-numeric characters or underscore.
       */
      @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
      @path
      hub: string;

      /**
       * The permission: current supported actions are joinLeaveGroup and sendToGroup.
       */
      @path
      permission: WebPubSubPermission;

      /**
       * Target connection Id.
       */
      @minLength(1)
      @path
      connectionId: string;

      /**
       * The meaning of the target depends on the specific permission. For
       * joinLeaveGroup and sendToGroup, targetName is a required parameter standing for
       * the group name.
       */
      @query
      targetName?: string;
    },
    {}
  >;

  /**
   * Check if there are any client connections connected for the given user.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  @summary("Check if there are any client connections connected for the given user.")
  @route("/api/hubs/{hub}/users/{userId}")
  @head
  op userExists is Azure.Core.Foundations.Operation<
    {
      /**
       * Target hub name, which should start with alphabetic characters and only contain
       * alpha-numeric characters or underscore.
       */
      @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
      @path
      hub: string;

      /**
       * Target user Id.
       */
      @minLength(1)
      @path
      userId: string;
    },
    OkResponse | NotFoundResponse
  >;

  /**
   * Close connections for the specific user.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Preserving existing API operation name for backward compatibility"
  @summary("Close connections for the specific user.")
  @route("/api/hubs/{hub}/users/{userId}/:closeConnections")
  @post
  op closeUserConnections is Azure.Core.Foundations.Operation<
    {
      /**
       * Target hub name, which should start with alphabetic characters and only contain
       * alpha-numeric characters or underscore.
       */
      @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
      @path
      hub: string;

      /**
       * The user Id.
       */
      @minLength(1)
      @path
      userId: string;

      /**
       * Exclude these connectionIds when closing the connections for the user.
       */
      @query
      excluded?: string[];

      /**
       * The reason closing the client connection.
       */
      @query
      reason?: string;
    },
    void
  >;

  /**
   * Send content inside request body to the specific user.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/byos" "Web PubSub is a real-time messaging service that handles binary data directly, BYOS pattern not applicable"
  @summary("Send content inside request body to the specific user.")
  @route("/api/hubs/{hub}/users/{userId}/:send")
  @post
  op sendToUser is Azure.Core.Foundations.Operation<
    {
      /**
       * Target hub name, which should start with alphabetic characters and only contain
       * alpha-numeric characters or underscore.
       */
      @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
      @path
      hub: string;

      /**
       * The user Id.
       */
      @minLength(1)
      @path
      userId: string;

      /**
       * Following OData filter syntax to filter out the subscribers receiving the
       * messages.
       */
      @query
      filter?: string;

      /**
       * The time-to-live (TTL) value in seconds for messages sent to the service. 0 is
       * the default value, which means the message never expires. 300 is the maximum
       * value. If this parameter is non-zero, messages that are not consumed by the
       * client within the specified TTL will be dropped by the service. This parameter
       * can help when the client's bandwidth is limited.
       */
      @maxValue(300)
      @query
      messageTtlSeconds?: int32;

      /**
       * Upload file type
       */
      @header("content-type")
      contentType: MessageContentType;

      /**
       * The payload body.
       */
      @bodyRoot
      message: bytes;
    },
    void
  >;

  /**
   * Remove a user from all groups.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Preserving existing API operation name for backward compatibility"
  @summary("Remove a user from all groups.")
  @route("/api/hubs/{hub}/users/{userId}/groups")
  @delete
  op removeUserFromAllGroups is Azure.Core.Foundations.Operation<
    {
      /**
       * Target hub name, which should start with alphabetic characters and only contain
       * alpha-numeric characters or underscore.
       */
      @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
      @path
      hub: string;

      /**
       * Target user Id.
       */
      @minLength(1)
      @path
      userId: string;
    },
    void
  >;

  /**
   * Remove a user from the target group.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Preserving existing API operation name for backward compatibility"
  @summary("Remove a user from the target group.")
  @route("/api/hubs/{hub}/users/{userId}/groups/{group}")
  @delete
  op removeUserFromGroup is Azure.Core.Foundations.Operation<
    {
      /**
       * Target hub name, which should start with alphabetic characters and only contain
       * alpha-numeric characters or underscore.
       */
      @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
      @path
      hub: string;

      /**
       * Target group name, which length should be greater than 0 and less than 1025.
       */
      @maxLength(1024)
      @minLength(1)
      @pattern("^(?!\\s+$).+$")
      @path
      group: string;

      /**
       * Target user Id.
       */
      @minLength(1)
      @path
      userId: string;
    },
    void
  >;

  /**
   * Add a user to the target group.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API - must use current operation signature for backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Preserving existing API operation name for backward compatibility"
  @summary("Add a user to the target group.")
  @route("/api/hubs/{hub}/users/{userId}/groups/{group}")
  @put
  op addUserToGroup is Azure.Core.Foundations.Operation<
    {
      /**
       * Target hub name, which should start with alphabetic characters and only contain
       * alpha-numeric characters or underscore.
       */
      @pattern("^[A-Za-z][A-Za-z0-9_`,.[\\]]{0,127}$")
      @path
      hub: string;

      /**
       * Target group name, which length should be greater than 0 and less than 1025.
       */
      @maxLength(1024)
      @minLength(1)
      @pattern("^(?!\\s+$).+$")
      @path
      group: string;

      /**
       * Target user Id.
       */
      @minLength(1)
      @path
      userId: string;
    },
    {}
  >;
}
