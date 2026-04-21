import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-core";

using TypeSpec.Http;

namespace WebPubSubService;

/**
 * Inner error detail.
 */
model ErrorInner {
  /** One of a server-defined set of error codes. */
  code?: string;

  /** Inner error. */
  inner?: ErrorInner;
}

/**
 * The error detail object.
 */
model ErrorDetail {
  /** One of a server-defined set of error codes. */
  code?: string;

  /** A human-readable representation of the error. */
  message?: string;

  /** The target of the error. */
  target?: string;

  /** An array of details about specific errors that led to this reported error. */
  details?: ErrorDetail[];

  /** An object containing more specific information about the error. */
  inner?: ErrorInner;
}

/**
 * The error response.
 */
@error
model ErrorResponse {
  /** The error detail body. */
  @body
  body: ErrorDetail;

  /** The error code. */
  @header("x-ms-error-code")
  errorCode?: string;
}

/**
 * Details about the client.
 */
model ClientDetail {
  /** User Id */
  userId?: string;

  /** Roles that the connection with the user id has */
  roles?: string[];
}

/**
 * The response object containing the client access token
 */
model ClientTokenResponse {
  /** Access token for the client to connect Azure Web PubSub service */
  token: string;
}

/**
 * Request object to add connections to groups
 */
model AddToGroupsRequest {
  /** Target groups */
  groups: string[];

  /** Following OData filter syntax to filter out the subscribers receiving the messages */
  filter?: string;
}

/**
 * Request object to remove connections from groups
 */
model RemoveFromGroupsRequest {
  /** Target groups */
  groups: string[];

  /** Following OData filter syntax to filter out the subscribers receiving the messages */
  filter?: string;
}

/**
 * Content type for upload
 */
union ContentType {
  string,

  /**
   * Content Type 'application/json'
   */
  "application/json",

  /**
   * Content Type 'application/octet-stream'
   */
  "application/octet-stream",

  /**
   * Content Type 'text/plain'
   */
  "text/plain",
}

/**
 * Content type for HTTP headers in message operations (closed union for HTTP compliance)
 */
#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Intentionally closed for HTTP Content-Type header compliance"
union MessageContentType {
  /**
   * Content Type 'application/json'
   */
  "application/json",

  /**
   * Content Type 'application/octet-stream'
   */
  "application/octet-stream",

  /**
   * Content Type 'text/plain'
   */
  "text/plain",
}

/**
 * Content type for response headers (closed union for HTTP compliance)
 */
#suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Intentionally closed for HTTP Content-Type header compliance"
union ResponseContentType {
  /**
   * Content Type 'text/plain'
   */
  "text/plain",

  /**
   * Content Type 'application/json'
   */
  "application/json",

  /**
   * Content Type 'text/json'
   */
  "text/json",
}

/**
 * Group member
 */
model GroupMember {
  /** Connection Id */
  connectionId: string;

  /** User Id */
  userId?: string;
}

/**
 * Paged response for group members
 */
model GroupMemberPagedValues {
  /** The group members */
  @pageItems
  value: GroupMember[];

  /** The link to the next page of results */
  @nextLink
  nextLink?: string;
}

/**
 * Web PubSub permission
 */
union WebPubSubPermission {
  string,

  /** The permission to send messages to groups. */
  SendToGroup: "sendToGroup",

  /** The permission to join/leave groups. */
  JoinLeaveGroup: "joinLeaveGroup",
}

/**
 * Web PubSub client type
 */
union WebPubSubClientType {
  string,

  /** Default value. */
  Default: "Default",

  /** MQTT client. */
  MQTT: "MQTT",
}
