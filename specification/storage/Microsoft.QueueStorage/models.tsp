import "@typespec/rest";
import "@typespec/http";
import "@typespec/xml";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Http;
using Azure.Core;
using Azure.ClientGenerator.Core;

namespace Storage.Queues;

/** Error codes returned by the service */
union StorageErrorCode {
  /** AccountAlreadyExists */
  AccountAlreadyExists: "AccountAlreadyExists",

  /** AccountBeingCreated */
  AccountBeingCreated: "AccountBeingCreated",

  /** AccountIsDisabled */
  AccountIsDisabled: "AccountIsDisabled",

  /** AuthenticationFailed */
  AuthenticationFailed: "AuthenticationFailed",

  /** AuthorizationFailure */
  AuthorizationFailure: "AuthorizationFailure",

  /** ConditionHeadersNotSupported */
  ConditionHeadersNotSupported: "ConditionHeadersNotSupported",

  /** ConditionNotMet */
  ConditionNotMet: "ConditionNotMet",

  /** EmptyMetadataKey */
  EmptyMetadataKey: "EmptyMetadataKey",

  /** InsufficientAccountPermissions */
  InsufficientAccountPermissions: "InsufficientAccountPermissions",

  /** InternalError */
  InternalError: "InternalError",

  /** InvalidAuthenticationInfo */
  InvalidAuthenticationInfo: "InvalidAuthenticationInfo",

  /** InvalidHeaderValue */
  InvalidHeaderValue: "InvalidHeaderValue",

  /** InvalidHttpVerb */
  InvalidHttpVerb: "InvalidHttpVerb",

  /** InvalidInput */
  InvalidInput: "InvalidInput",

  /** InvalidMd5 */
  InvalidMd5: "InvalidMd5",

  /** InvalidMetadata */
  InvalidMetadata: "InvalidMetadata",

  /** InvalidQueryParameterValue */
  InvalidQueryParameterValue: "InvalidQueryParameterValue",

  /** InvalidRange */
  InvalidRange: "InvalidRange",

  /** InvalidResourceName */
  InvalidResourceName: "InvalidResourceName",

  /** InvalidUri */
  InvalidUri: "InvalidUri",

  /** InvalidXmlDocument */
  InvalidXmlDocument: "InvalidXmlDocument",

  /** InvalidXmlNodeValue */
  InvalidXmlNodeValue: "InvalidXmlNodeValue",

  /** Md5Mismatch */
  Md5Mismatch: "Md5Mismatch",

  /** MetadataTooLarge */
  MetadataTooLarge: "MetadataTooLarge",

  /** MissingContentLengthHeader */
  MissingContentLengthHeader: "MissingContentLengthHeader",

  /** MissingRequiredQueryParameter */
  MissingRequiredQueryParameter: "MissingRequiredQueryParameter",

  /** MissingRequiredHeader */
  MissingRequiredHeader: "MissingRequiredHeader",

  /** MissingRequiredXmlNode */
  MissingRequiredXmlNode: "MissingRequiredXmlNode",

  /** MultipleConditionHeadersNotSupported */
  MultipleConditionHeadersNotSupported: "MultipleConditionHeadersNotSupported",

  /** OperationTimedOut */
  OperationTimedOut: "OperationTimedOut",

  /** OutOfRangeInput */
  OutOfRangeInput: "OutOfRangeInput",

  /** OutOfRangeQueryParameterValue */
  OutOfRangeQueryParameterValue: "OutOfRangeQueryParameterValue",

  /** RequestBodyTooLarge */
  RequestBodyTooLarge: "RequestBodyTooLarge",

  /** ResourceTypeMismatch */
  ResourceTypeMismatch: "ResourceTypeMismatch",

  /** RequestUrlFailedToParse */
  RequestUrlFailedToParse: "RequestUrlFailedToParse",

  /** ResourceAlreadyExists */
  ResourceAlreadyExists: "ResourceAlreadyExists",

  /** ResourceNotFound */
  ResourceNotFound: "ResourceNotFound",

  /** ServerBusy */
  ServerBusy: "ServerBusy",

  /** UnsupportedHeader */
  UnsupportedHeader: "UnsupportedHeader",

  /** UnsupportedXmlNode */
  UnsupportedXmlNode: "UnsupportedXmlNode",

  /** UnsupportedQueryParameter */
  UnsupportedQueryParameter: "UnsupportedQueryParameter",

  /** UnsupportedHttpVerb */
  UnsupportedHttpVerb: "UnsupportedHttpVerb",

  /** InvalidMarker */
  InvalidMarker: "InvalidMarker",

  /** MessageNotFound */
  MessageNotFound: "MessageNotFound",

  /** MessageTooLarge */
  MessageTooLarge: "MessageTooLarge",

  /** PopReceiptMismatch */
  PopReceiptMismatch: "PopReceiptMismatch",

  /** QueueAlreadyExists */
  QueueAlreadyExists: "QueueAlreadyExists",

  /** QueueBeingDeleted */
  QueueBeingDeleted: "QueueBeingDeleted",

  /** QueueDisabled */
  QueueDisabled: "QueueDisabled",

  /** QueueNotEmpty */
  QueueNotEmpty: "QueueNotEmpty",

  /** QueueNotFound */
  QueueNotFound: "QueueNotFound",

  /** AuthorizationSourceIPMismatch */
  AuthorizationSourceIPMismatch: "AuthorizationSourceIPMismatch",

  /** AuthorizationProtocolMismatch */
  AuthorizationProtocolMismatch: "AuthorizationProtocolMismatch",

  /** AuthorizationPermissionMismatch */
  AuthorizationPermissionMismatch: "AuthorizationPermissionMismatch",

  /** AuthorizationServiceMismatch */
  AuthorizationServiceMismatch: "AuthorizationServiceMismatch",

  /** AuthorizationResourceTypeMismatch */
  AuthorizationResourceTypeMismatch: "AuthorizationResourceTypeMismatch",

  /** FeatureVersionMismatch */
  FeatureVersionMismatch: "FeatureVersionMismatch",

  string,
}

/** Include this parameter to specify that the queue's metadata be returned as part of the response body. */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Existing API"
enum ListQueuesIncludeType {
  /** Include metadata */
  metadata: "metadata",
}

/** The service properties. */
@Xml.name("StorageServiceProperties")
model QueueServiceProperties {
  /** The logging properties. */
  @Xml.name("Logging") logging?: Logging;

  /** The hour metrics properties. */
  @Xml.name("HourMetrics") hourMetrics?: Metrics;

  /** The minute metrics properties. */
  @Xml.name("MinuteMetrics") minuteMetrics?: Metrics;

  /** The CORS properties. */
  @Xml.name("Cors") cors?: CorsRule[];
}

/** Azure Analytics Logging settings. */
model Logging {
  /** The version of the logging properties. */
  @Xml.name("Version") version: string;

  /** Whether delete operation is logged. */
  @Xml.name("Delete") delete: boolean;

  /** Whether read operation is logged. */
  @Xml.name("Read") read: boolean;

  /** Whether write operation is logged. */
  @Xml.name("Write") write: boolean;

  /** The retention policy of the logs. */
  @Xml.name("RetentionPolicy") retentionPolicy: RetentionPolicy;
}

/** The retention policy. */
model RetentionPolicy {
  /** Whether to enable the retention policy. */
  @Xml.name("Enabled") enabled: boolean;

  /** The number of days to retain the logs. */
  @Xml.name("Days")
  @minValue(1)
  days?: int32;
}

/** The metrics properties. */
model Metrics {
  /** The version of the metrics properties. */
  @Xml.name("Version") version?: string;

  /** Whether it is enabled. */
  @Xml.name("Enabled") enabled: boolean;

  /** Whether to include API in the metrics. */
  @Xml.name("IncludeAPIs") includeApis?: boolean;

  /** The retention policy of the metrics. */
  @Xml.name("RetentionPolicy") retentionPolicy?: RetentionPolicy;
}

/** CORS is an HTTP feature that enables a web application running under one domain to access resources in another domain. Web browsers implement a security restriction known as same-origin policy that prevents a web page from calling APIs in a different domain; CORS provides a secure way to allow one domain (the origin domain) to call APIs in another domain */
model CorsRule {
  /** The allowed origins. */
  @Xml.name("AllowedOrigins") allowedOrigins: string;

  /** The allowed methods. */
  @Xml.name("AllowedMethods") allowedMethods: string;

  /** The allowed headers. */
  @Xml.name("AllowedHeaders") allowedHeaders: string;

  /** The exposed headers. */
  @Xml.name("ExposedHeaders") exposedHeaders: string;

  /** The maximum age in seconds. */
  @Xml.name("MaxAgeInSeconds")
  @minValue(0)
  maxAgeInSeconds: int32;
}

/** The error response. */
@error
@mediaTypeHint("application/xml")
model StorageError {
  /** The error code. */
  @header("x-ms-error-code")
  errorCode?: string;

  /** The error code for the copy source. */
  @header("x-ms-copy-source-error-code")
  xMsCopySourceErrorCode?: string;

  /** The status code for the copy source. */
  @header("x-ms-copy-source-status-code")
  xMsCopySourceStatusCode?: int32;

  /** The error code. */
  @Xml.name("Code") code?: string;

  /** The error message. */
  @Xml.name("Message") message?: string;

  /** Copy source status code */
  @Xml.name("CopySourceStatusCode") copySourceStatusCode?: int32;

  /** Copy source error code */
  @Xml.name("CopySourceErrorCode") copySourceErrorCode?: string;

  /** Copy source error message */
  @Xml.name("CopySourceErrorMessage") copySourceErrorMessage?: string;
}

/** Stats for the storage service. */
model QueueServiceStats {
  /** The geo replication stats. */
  @Xml.name("GeoReplication") geoReplication?: GeoReplication;
}

/** Geo-Replication information for the Secondary Storage Service */
model GeoReplication {
  /** The status of the secondary location */
  @Xml.name("Status") status: GeoReplicationStatusType;

  /** A GMT date/time value, to the second. All primary writes preceding this value are guaranteed to be available for read operations at the secondary. Primary writes after this point in time may or may not be available for reads. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @encode("rfc7231")
  @Xml.name("LastSyncTime")
  lastSyncTime: utcDateTime;
}

/** The geo replication status. */
union GeoReplicationStatusType {
  /** The geo replication is live. */
  Live: "live",

  /** The geo replication is bootstrap. */
  Bootstrap: "bootstrap",

  /** The geo replication is unavailable. */
  Unavailable: "unavailable",

  /** Extensible */
  string,
}

/** The list queue segment response */
@Xml.name("EnumerationResults")
model ListQueuesResponse {
  /** The service endpoint. */
  @Xml.attribute
  @Xml.name("ServiceEndpoint")
  serviceEndpoint: string;

  /** The prefix of the queues. */
  @Xml.name("Prefix") prefix?: string;

  /** The marker of the queues. */
  @Xml.name("Marker") marker?: string;

  /** The max results of the queues. */
  @Xml.name("MaxResults") maxResults?: int32;

  /** The queue segment. */
  @pageItems
  @Xml.name("Queues")
  queueItems: QueueItem[];

  /** The next marker of the queues. */
  @continuationToken
  @Xml.name("NextMarker")
  nextMarker?: string;
}

/**
 * An Azure Storage Queue.
 */
@Xml.name("Queue")
model QueueItem {
  /** The name of the queue. */
  @Xml.name("Name") name: string;

  /** The metadata of the container. */
  @Xml.name("Metadata") metadata?: Record<string>;
}

/** The signed identifier. */
model SignedIdentifier {
  /** The unique ID for the signed identifier. */
  @Xml.name("Id") id: string;

  /** The access policy for the signed identifier. */
  @Xml.name("AccessPolicy") accessPolicy: AccessPolicy;
}

/** Represents an access policy. */
model AccessPolicy {
  /** The date-time the policy is active. */
  @Xml.name("Start")
  @encode("rfc3339")
  start: utcDateTime;

  /** The date-time the policy expires. */
  @Xml.name("Expiry")
  @encode("rfc3339")
  expiry: utcDateTime;

  /** The permissions for acl the policy. */
  @Xml.name("Permission") permission: string;
}

/**
 * The object returned in the QueueMessageList array when calling Get Messages on
 * a Queue.
 */
model ReceivedMessage {
  /**
   * The Id of the Message.
   */
  @Xml.name("MessageId") messageId: string;

  /**
   * The time the Message was inserted into the Queue.
   */
  @Xml.name("InsertionTime")
  @encode("rfc7231")
  insertionTime: utcDateTime;

  /**
   * The time that the Message will expire and be automatically deleted.
   */
  @Xml.name("ExpirationTime")
  @encode("rfc7231")
  expirationTime: utcDateTime;

  /**
   * This value is required to delete the Message. If deletion fails using this
   * PopReceipt then the message has been dequeued by another client.
   */
  @Xml.name("PopReceipt") popReceipt: string;

  /**
   * The time that the message will again become visible in the Queue.
   */
  @Xml.name("TimeNextVisible")
  @encode("rfc7231")
  timeNextVisible: utcDateTime;

  /**
   * The number of times the message has been dequeued.
   */
  @Xml.name("DequeueCount") dequeueCount: int64;

  /**
   * The content of the message
   */
  @Xml.name("MessageText") messageText: string;
}

/** Represents an array of signed identifiers */
@Xml.name("SignedIdentifiers")
model ListOfSignedIdentifier {
  /**
   * The list of signed identifiers.
   *
   */
  @Xml.unwrapped
  @Xml.name("SignedIdentifier")
  items: Array<SignedIdentifier>;
}

/**
 * List wrapper for DequeuedMessageItem array
 */
@Xml.name("QueueMessagesList")
model ListOfReceivedMessage {
  /**
   * The list of dequeued messages.
   */
  @Xml.unwrapped
  @Xml.name("QueueMessage")
  items: Array<ReceivedMessage>;
}

/**
 * List wrapper for EnqueuedMessage array
 */
@Xml.name("QueueMessagesList")
model ListOfSentMessage {
  /**
   * The list of enqueued messages.
   */
  @Xml.unwrapped
  @Xml.name("QueueMessage")
  items: Array<SentMessage>;
}

/**
 * List wrapper for PeekedMessageItem array
 */
@Xml.name("QueueMessagesList")
model ListOfPeekedMessage {
  /**
   * The list of peeked messages.
   */
  @Xml.unwrapped
  @Xml.name("QueueMessage")
  items: Array<PeekedMessage>;
}

/**
 * A Message object which can be stored in a Queue
 */
model QueueMessage {
  /**
   * The content of the message
   */
  @Xml.name("MessageText") messageText: string;
}

/**
 * The object returned in the QueueMessageList array when calling Put Message on a
 * Queue
 */
model SentMessage {
  /**
   * The Id of the Message.
   */
  @Xml.name("MessageId") messageId: string;

  /**
   * The time the Message was inserted into the Queue.
   */
  @Xml.name("InsertionTime")
  @encode("rfc7231")
  insertionTime: utcDateTime;

  /**
   * The time that the Message will expire and be automatically deleted.
   */
  @Xml.name("ExpirationTime")
  @encode("rfc7231")
  expirationTime: utcDateTime;

  /**
   * This value is required to delete the Message. If deletion fails using this
   * PopReceipt then the message has been dequeued by another client.
   */
  @Xml.name("PopReceipt") popReceipt: string;

  /**
   * The time that the message will again become visible in the Queue.
   */
  @Xml.name("TimeNextVisible")
  @encode("rfc7231")
  timeNextVisible: utcDateTime;
}

/**
 * The object returned in the QueueMessageList array when calling Peek Messages on
 * a Queue
 */
model PeekedMessage {
  /**
   * The Id of the Message.
   */
  @Xml.name("MessageId") messageId: string;

  /**
   * The time the Message was inserted into the Queue.
   */
  @Xml.name("InsertionTime")
  @encode("rfc7231")
  insertionTime: utcDateTime;

  /**
   * The time that the Message will expire and be automatically deleted.
   */
  @Xml.name("ExpirationTime")
  @encode("rfc7231")
  expirationTime: utcDateTime;

  /**
   * The number of times the message has been dequeued.
   */
  @Xml.name("DequeueCount") dequeueCount: int64;

  /**
   * The content of the Message.
   */
  @Xml.name("MessageText") messageText: string;
}

alias MessageIdPathParameter = {
  /**
   * The id of the queue message.
   */
  @path
  messageId: string;
};

alias PopReceiptQueryParameter = {
  /**
   * Required. Specifies the valid pop receipt value returned from an earlier call to the Get Messages or Update Message operation.
   */
  @query("popReceipt")
  popReceipt: string;
};

alias RequestIdResponseHeader = {
  @access(Access.internal)
  @visibility(Lifecycle.Read)
  @header("x-ms-request-id")
  @doc("An opaque, globally-unique, server-generated string identifier for the request.")
  requestId?: uuid;
};

/** The timeout parameter. */
alias TimeoutParameter = {
  @doc("The timeout parameter is expressed in seconds. For more information, see <a href=\"https://learn.microsoft.com/en-us/rest/api/storageservices/setting-timeouts-for-queue-service-operations\">Setting Timeouts for Queue Service Operations.</a>")
  @query
  @minValue(0)
  timeout?: int32;
};

alias VisibilityTimeoutParameter = {
  @doc("Specifies the new visibility timeout value, in seconds, relative to server time. The default value is 30 seconds. A specified value must be larger than or equal to 1 second, and cannot be larger than 7 days, or larger than 2 hours on REST protocol versions prior to version 2011-08-18. The visibility timeout of a message can be set to a value later than the expiry time.")
  @maxValue(604800)
  @query("visibilityTimeout")
  visibilityTimeout?: int32;
};

/** The Date response header */
alias DateResponseHeader = {
  /** UTC date/time value generated by the service that indicates the time at which the response was initiated */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @encode("rfc7231")
  @header("Date")
  date: utcDateTime;
};

/** The approximate messages count header */
alias ApproximateMessagesCountHeader = {
  /** The approximate number of messages in the queue. This number is not lower than the actual number of messages in the queue, but could be higher. */
  @header("x-ms-approximate-messages-count")
  approximateMessagesCount?: int64;
};

/** The pop receipt response header */
alias PopReceiptResponseHeader = {
  /** The pop receipt of the queue message. */
  @header("x-ms-popreceipt")
  popReceipt: string;
};

/** The time next visible response header */
alias TimeNextVisibleResponseHeader = {
  /** A UTC date/time value that represents when the message will be visible on the queue. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @encode("rfc7231")
  @header("x-ms-time-next-visible")
  timeNextVisible: utcDateTime;
};

/** The queue name path parameter */
alias QueueNamePathParameter = {
  /** The name of the queue. */
  @path
  queueName: string;
};

/** The metadata headers. */
alias MetadataHeaders = {
  /** The metadata headers. */
  @alternateType(Record<string>, "rust")
  @header("x-ms-meta")
  metadata?: string;
};

alias ApiVersionHeader = {
  /** Specifies the version of the operation to use for this request. */
  @apiVersion
  @access(Access.internal)
  @header("x-ms-version")
  version: string;
};

alias ClientRequestIdHeader = {
  @access(Access.internal)
  @header("x-ms-client-request-id")
  @doc("An opaque, globally-unique, client-generated string identifier for the request.")
  clientRequestId?: uuid;
};

alias QueueMessageBodyParameter = {
  /**
   * A Message object which can be stored in a Queue
   */
  @bodyRoot
  queueMessage?: QueueMessage;
};

/** Key information for user delegation key */
model KeyInfo {
  /** The date-time the key is active in ISO 8601 UTC time */
  @Xml.name("Start")
  @encode("rfc3339")
  start?: utcDateTime;

  /** The date-time the key expires in ISO 8601 UTC time */
  @Xml.name("Expiry")
  @encode("rfc3339")
  expiry: utcDateTime;

  /** The delegated user tenant id in Azure AD */
  @Xml.name("DelegatedUserTid")
  delegatedUserTid?: string;
}

/** A user delegation key */
model UserDelegationKey {
  /** The Azure Active Directory object ID in GUID format. */
  @Xml.name("SignedOid")
  signedOid: string;

  /** The Azure Active Directory tenant ID in GUID format */
  @Xml.name("SignedTid")
  signedTid: string;

  /** The date-time the key is active */
  @Xml.name("SignedStart")
  @encode("rfc7231")
  signedStart: utcDateTime;

  /** The date-time the key expires */
  @Xml.name("SignedExpiry")
  @encode("rfc7231")
  signedExpiry: utcDateTime;

  /** The service that created the key */
  @Xml.name("SignedService")
  signedService: string;

  /** The version of the service that created the key */
  @Xml.name("SignedVersion")
  signedVersion: string;

  /** The delegated user tenant id in Azure AD. Return if DelegatedUserTid is specified. */
  @Xml.name("SignedDelegatedUserTid")
  signedDelegatedUserTid?: string;

  /** The key as a base64 string */
  @Xml.name("Value")
  value: string;
}
