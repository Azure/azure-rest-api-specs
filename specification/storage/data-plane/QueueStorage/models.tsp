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

/** Specify to include additional, optional information. */
#suppress "@azure-tools/typespec-azure-core/no-enum" "Existing API"
enum ListQueuesIncludeType {
  /** Include queue metadata. */
  metadata: "metadata",
}

/** Storage Service Properties. */
@Xml.name("StorageServiceProperties")
model QueueServiceProperties {
  /** Azure Analytics Logging settings. */
  @Xml.name("Logging") logging?: Logging;

  /** A summary of request statistics grouped by API in hourly aggregates for queues. */
  @Xml.name("HourMetrics") hourMetrics?: Metrics;

  /** a summary of request statistics grouped by API in minute aggregates for queues. */
  @Xml.name("MinuteMetrics") minuteMetrics?: Metrics;

  /** The set of CORS rules. */
  @Xml.name("Cors") cors?: CorsRule[];
}

/** Azure Analytics Logging settings. */
model Logging {
  /** The version of Storage Analytics to configure. */
  @Xml.name("Version") version: string;

  /** Indicates whether all delete requests should be logged. */
  @Xml.name("Delete") delete: boolean;

  /** Indicates whether all read requests should be logged. */
  @Xml.name("Read") read: boolean;

  /** Indicates whether all write requests should be logged. */
  @Xml.name("Write") write: boolean;

  /** the retention policy. */
  @Xml.name("RetentionPolicy") retentionPolicy: RetentionPolicy;
}

/** the retention policy. */
model RetentionPolicy {
  /** Indicates whether a retention policy is enabled for the storage service. */
  @Xml.name("Enabled") enabled: boolean;

  /** Indicates the number of days that metrics or logging or soft-deleted data should be retained. All data older than this value will be deleted. */
  @Xml.name("Days")
  @minValue(1)
  days?: int32;
}

/** a summary of request statistics grouped by API in hour or minute aggregates for queues. */
model Metrics {
  /** The version of Storage Analytics to configure. */
  @Xml.name("Version") version?: string;

  /** Indicates whether metrics are enabled for the Queue service. */
  @Xml.name("Enabled") enabled: boolean;

  /** Indicates whether metrics should generate summary statistics for called API operations. */
  @Xml.name("IncludeAPIs") includeApis?: boolean;

  /** the retention policy. */
  @Xml.name("RetentionPolicy") retentionPolicy?: RetentionPolicy;
}

/** CORS is an HTTP feature that enables a web application running under one domain to access resources in another domain. Web browsers implement a security restriction known as same-origin policy that prevents a web page from calling APIs in a different domain; CORS provides a secure way to allow one domain (the origin domain) to call APIs in another domain. */
@Xml.name("CorsRule")
model CorsRule {
  /** The origin domains that are permitted to make a request against the storage service via CORS. The origin domain is the domain from which the request originates. Note that the origin must be an exact case-sensitive match with the origin that the user age sends to the service. You can also use the wildcard character '*' to allow all origin domains to make requests via CORS. */
  @Xml.name("AllowedOrigins") allowedOrigins: string;

  /** The methods (HTTP request verbs) that the origin domain may use for a CORS request. (comma separated). */
  @Xml.name("AllowedMethods") allowedMethods: string;

  /** the request headers that the origin domain may specify on the CORS request. */
  @Xml.name("AllowedHeaders") allowedHeaders: string;

  /** The response headers that may be sent in the response to the CORS request and exposed by the browser to the request issuer. */
  @Xml.name("ExposedHeaders") exposedHeaders: string;

  /** The maximum amount time that a browser should cache the preflight OPTIONS request. */
  @Xml.name("MaxAgeInSeconds")
  @minValue(0)
  maxAgeInSeconds: int32;
}

/** The error response. */
@error
@mediaTypeHint("application/xml")
model Error {
  /** The error code. */
  @header("x-ms-error-code")
  errorCode?: string;

  /** The error code. */
  @Xml.name("Code") code?: StorageErrorCode;

  /** The error message. */
  @Xml.name("Message") message?: string;
}

/** Stats for the storage service. */
@Xml.name("StorageServiceStats")
model QueueServiceStats {
  /** Geo-Replication information for the Secondary Storage Service. */
  @Xml.name("GeoReplication") geoReplication?: GeoReplication;
}

/** The GeoReplication model. */
model GeoReplication {
  /** The status of the secondary location. */
  @Xml.name("Status") status: GeoReplicationStatus;

  /**
   * A GMT date/time value, to the second. All primary writes preceding this value are guaranteed to be available
   * for read operations at the secondary. Primary writes after this point in time may or may not be available
   * for reads.
   */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @encode("rfc7231")
  @Xml.name("LastSyncTime")
  lastSyncTime: utcDateTime;
}

/** The geo replication status. */
union GeoReplicationStatus {
  /** The geo replication is live. */
  Live: "live",

  /** The geo replication is bootstrap. */
  Bootstrap: "bootstrap",

  /** The geo replication is unavailable. */
  Unavailable: "unavailable",

  /** Extensible */
  string,
}

/** The list queues response. */
@Xml.name("EnumerationResults")
model ListQueuesResponse {
  /** The service endpoint. */
  @Xml.attribute
  @Xml.name("ServiceEndpoint")
  serviceEndpoint: string;

  /** The prefix of the queues. */
  @Xml.name("Prefix") prefix: string;

  /** Identifies the current position in the list queues operation. */
  @Xml.name("Marker") marker?: string;

  /** The max results. */
  @Xml.name("MaxResults") maxResults: int32;

  /** The list of queues. */
  @pageItems
  @Xml.name("Queues")
  queueItems?: QueueItem[];

  /** Identifies the portion of the list of queues to be returned with the next listing operation. */
  @continuationToken
  @Xml.name("NextMarker")
  nextMarker: string;
}

/** An Azure Storage Queue. */
@Xml.name("Queue")
model QueueItem {
  /** The name of the Queue. */
  @Xml.name("Name") name: string;

  /** Dictionary of <string>. */
  @Xml.name("Metadata") metadata?: Record<string>;
}

/** signed identifier. */
model SignedIdentifier {
  /** a unique id. */
  @Xml.name("Id") id: string;

  /** The access policy. */
  @Xml.name("AccessPolicy") accessPolicy: AccessPolicy;
}

/** An Access policy. */
model AccessPolicy {
  /** the date-time the policy is active. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "rfc3339-fixed-width is required because the Queue service rejects timestamps that do not have exactly 7 fractional-second digits. Without this encoding the Rust time crate drops trailing zeros, producing variable precision (e.g. 6 digits instead of 7) which causes the service to return InvalidXmlDocument (HTTP 400)."
  #suppress "@azure-tools/typespec-autorest/unknown-format" "rfc3339-fixed-width is required because the Queue service rejects timestamps that do not have exactly 7 fractional-second digits. Without this encoding the Rust time crate drops trailing zeros, producing variable precision (e.g. 6 digits instead of 7) which causes the service to return InvalidXmlDocument (HTTP 400)."
  @Xml.name("Start")
  @encode("rfc3339-fixed-width")
  start?: utcDateTime;

  /** the date-time the policy expires. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "rfc3339-fixed-width is required because the Queue service rejects timestamps that do not have exactly 7 fractional-second digits. Without this encoding the Rust time crate drops trailing zeros, producing variable precision (e.g. 6 digits instead of 7) which causes the service to return InvalidXmlDocument (HTTP 400)."
  #suppress "@azure-tools/typespec-autorest/unknown-format" "rfc3339-fixed-width is required because the Queue service rejects timestamps that do not have exactly 7 fractional-second digits. Without this encoding the Rust time crate drops trailing zeros, producing variable precision (e.g. 6 digits instead of 7) which causes the service to return InvalidXmlDocument (HTTP 400)."
  @Xml.name("Expiry")
  @encode("rfc3339-fixed-width")
  expiry?: utcDateTime;

  /** the permissions for the acl policy. */
  @Xml.name("Permission") permission?: string;
}

/** The received queue message. */
@Xml.name("QueueMessage")
model ReceivedMessage {
  /** The ID of the message. */
  @Xml.name("MessageId") messageId: string;

  /** The time the message was inserted into the queue. */
  @Xml.name("InsertionTime")
  @encode("rfc7231")
  insertionTime: utcDateTime;

  /** The time that the message will expire and be automatically deleted. */
  @Xml.name("ExpirationTime")
  @encode("rfc7231")
  expirationTime: utcDateTime;

  /**
   * An opaque value required to delete the message. If deletion fails using this
   * PopReceipt then the message has been dequeued by another client.
   */
  @Xml.name("PopReceipt") popReceipt: string;

  /** The time that the message will again become visible in the queue. */
  @Xml.name("TimeNextVisible")
  @encode("rfc7231")
  timeNextVisible: utcDateTime;

  /** The number of times the message has been dequeued. */
  @Xml.name("DequeueCount") dequeueCount: int64;

  /** The content of the message. */
  @Xml.name("MessageText") messageText: string;
}

/** An array of signed identifiers. */
@Xml.name("SignedIdentifiers")
model SignedIdentifiers {
  /** The list of signed identifiers. */
  @Xml.unwrapped
  @Xml.name("SignedIdentifier")
  items: Array<SignedIdentifier>;
}

/** The response of receive messages. */
@Xml.name("QueueMessagesList")
model ReceivedMessages {
  /** The list of received messages. */
  @Xml.unwrapped
  @Xml.name("QueueMessage")
  items: Array<ReceivedMessage>;
}

/** The response of send message. */
@Xml.name("QueueMessagesList")
model ListOfSentMessage {
  /** The list of sent messages. */
  @Xml.unwrapped
  @Xml.name("QueueMessage")
  items: Array<SentMessage>;
}

/** The response of peek messages. */
@Xml.name("QueueMessagesList")
model PeekedMessages {
  /** The list of peeked messages. */
  @Xml.unwrapped
  @Xml.name("QueueMessage")
  items: Array<PeekedMessage>;
}

/** The queue message. */
model QueueMessage {
  /** The content of the message. */
  @Xml.name("MessageText") messageText: string;
}

/** The object returned in the QueueMessageList array when calling Put Message on a Queue. */
@Xml.name("QueueMessage")
model SentMessage {
  /** The Id of the Message. */
  @Xml.name("MessageId") messageId: string;

  /** The time the Message was inserted into the Queue. */
  @Xml.name("InsertionTime")
  @encode("rfc7231")
  insertionTime: utcDateTime;

  /** The time that the Message will expire and be automatically deleted. */
  @Xml.name("ExpirationTime")
  @encode("rfc7231")
  expirationTime: utcDateTime;

  /** This value is required to delete the Message. If deletion fails using this popreceipt then the message has been dequeued by another client. */
  @Xml.name("PopReceipt") popReceipt: string;

  /** The time that the message will again become visible in the Queue. */
  @Xml.name("TimeNextVisible")
  @encode("rfc7231")
  timeNextVisible: utcDateTime;
}

/** The peeked queue message. */
@Xml.name("QueueMessage")
model PeekedMessage {
  /** The ID of the message. */
  @Xml.name("MessageId") messageId: string;

  /** The time the message was inserted into the queue. */
  @Xml.name("InsertionTime")
  @encode("rfc7231")
  insertionTime: utcDateTime;

  /** The time that the message will expire and be automatically deleted. */
  @Xml.name("ExpirationTime")
  @encode("rfc7231")
  expirationTime: utcDateTime;

  /** The number of times the message has been dequeued. */
  @Xml.name("DequeueCount") dequeueCount: int64;

  /** The content of the message. */
  @Xml.name("MessageText") messageText: string;
}

alias MessageIdPathParameter = {
  /** The ID of the queue message. */
  @path
  messageId: string;
};

alias PopReceiptQueryParameter = {
  /**
   * An opaque value required to delete the message. If deletion fails using this
   * PopReceipt then the message has been dequeued by another client.
   */
  @query("popreceipt")
  popReceipt: string;
};

/** The request ID response header. */
alias RequestIdResponseHeader = {
  /** An opaque, globally-unique, server-generated string identifier for the request. */
  @access(Access.internal)
  @visibility(Lifecycle.Read)
  @header("x-ms-request-id")
  requestId?: uuid;
};

/** The timeout parameter. */
alias TimeoutParameter = {
  /**
   * The timeout parameter is expressed in seconds. For more information, see
   * <a href="https://learn.microsoft.com/en-us/rest/api/storageservices/setting-timeouts-for-queue-service-operations">Setting Timeouts for Queue Service Operations.</a>
   */
  @query
  @minValue(0)
  timeout?: int32;
};

/** The visibility timeout parameter. */
alias VisibilityTimeoutParameter = {
  /**
   * Specifies the new visibility timeout value, in seconds, relative to server time. A specified value must be
   * larger than or equal to 1 second, and cannot be larger than 7 days. The visibility timeout of a message
   * can be set to a value later than the expiry time.
   */
  @maxValue(604800)
  @query("visibilitytimeout")
  visibilityTimeout?: int32;
};

/** The Date response header. */
alias DateResponseHeader = {
  /** UTC date/time value generated by the service that indicates the time at which the response was initiated. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @encode("rfc7231")
  @access(Access.internal)
  @header("Date")
  date: utcDateTime;
};

/** The approximate messages count header. */
alias ApproximateMessagesCountHeader = {
  /**
   * The approximate number of messages in the queue. This number is not lower than the actual number of
   * messages in the queue, but could be higher.
   */
  @header("x-ms-approximate-messages-count")
  approximateMessagesCount?: int64;
};

/** The pop receipt response header. */
alias PopReceiptResponseHeader = {
  /** The pop receipt of the queue message. */
  @header("x-ms-popreceipt")
  popReceipt: string;
};

/** The time next visible response header. */
alias TimeNextVisibleResponseHeader = {
  /** A UTC date/time value that represents when the message will be visible on the queue. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @encode("rfc7231")
  @header("x-ms-time-next-visible")
  timeNextVisible: utcDateTime;
};

/** The private pop receipt response header. */
alias PopReceiptResponseHeaderPrivate = {
  /** The pop receipt of the queue message. */
  @access(Access.internal)
  @header("x-ms-popreceipt")
  popReceipt: string;
};

/** The private time next visible response header. */
alias TimeNextVisibleResponseHeaderPrivate = {
  /** A UTC date/time value that represents when the message will be visible on the queue. */
  #suppress "@azure-tools/typespec-azure-core/known-encoding" "Existing API"
  @access(Access.internal)
  @encode("rfc7231")
  @header("x-ms-time-next-visible")
  timeNextVisible: utcDateTime;
};

/** The metadata headers. */
alias MetadataHeaders = {
  /** The metadata headers. */
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

alias ClientRequestIdParameter = {
  /** An opaque, globally-unique, client-generated string identifier for the request. */
  @access(Access.internal)
  @header("x-ms-client-request-id")
  clientRequestId?: uuid;
};

alias ClientRequestIdResponseHeader = {
  /** An opaque, globally-unique, client-generated string identifier for the request. */
  @access(Access.internal)
  @header("x-ms-client-request-id")
  clientRequestId?: uuid;
};

alias QueueMessageBodyParameter = {
  /**
   * The queue message. The message must be in a format that can be included in
   * an XML request with UTF-8 encoding. The encoded message can be up to 64 KB in size.
   */
  @bodyRoot
  queueMessage?: QueueMessage;
};

/** Key information for user delegation key. */
model KeyInfo {
  /** The date-time the key is active in ISO 8601 UTC time. */
  @Xml.name("Start")
  start?: utcDateTime;

  /** The date-time the key expires in ISO 8601 UTC time. */
  @Xml.name("Expiry")
  expiry: utcDateTime;

  /** The delegated user tenant ID in Entra ID. */
  @Xml.name("DelegatedUserTid")
  delegatedUserTid?: string;
}

/** A user delegation key. */
model UserDelegationKey {
  /** The Azure Active Directory object ID in GUID format. */
  @Xml.name("SignedOid")
  signedOid: string;

  /** The Azure Active Directory tenant ID in GUID format. */
  @Xml.name("SignedTid")
  signedTid: string;

  /** The date-time the key is active. */
  @Xml.name("SignedStart")
  signedStart: utcDateTime;

  /** The date-time the key expires. */
  @Xml.name("SignedExpiry")
  signedExpiry: utcDateTime;

  /** Abbreviation of the Azure Storage service that accepts the key. */
  @Xml.name("SignedService")
  signedService: string;

  /** The service version that created the key. */
  @Xml.name("SignedVersion")
  signedVersion: string;

  /** The delegated user tenant id in Azure AD. Return if DelegatedUserTid is specified. */
  @Xml.name("SignedDelegatedUserTid")
  signedDelegatedUserTid?: string;

  /** The key as a base64 string. */
  @Xml.name("Value")
  value: string;
}
