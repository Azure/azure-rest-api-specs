import "@typespec/rest";
import "@typespec/http";
import "@typespec/xml";
import "@azure-tools/typespec-azure-core";

using Azure.Core;

namespace AzureQueueStorage;

/**
 * The status of the secondary location
 */
union GeoReplicationStatusType {
  string,
  live: "live",
  bootstrap: "bootstrap",
  unavailable: "unavailable",
}

/**
 * Error codes returned by the service
 */
union StorageErrorCode {
  string,
  AccountAlreadyExists: "AccountAlreadyExists",
  AccountBeingCreated: "AccountBeingCreated",
  AccountIsDisabled: "AccountIsDisabled",
  AuthenticationFailed: "AuthenticationFailed",
  AuthorizationFailure: "AuthorizationFailure",
  ConditionHeadersNotSupported: "ConditionHeadersNotSupported",
  ConditionNotMet: "ConditionNotMet",
  EmptyMetadataKey: "EmptyMetadataKey",
  InsufficientAccountPermissions: "InsufficientAccountPermissions",
  InternalError: "InternalError",
  InvalidAuthenticationInfo: "InvalidAuthenticationInfo",
  InvalidHeaderValue: "InvalidHeaderValue",
  InvalidHttpVerb: "InvalidHttpVerb",
  InvalidInput: "InvalidInput",
  InvalidMd5: "InvalidMd5",
  InvalidMetadata: "InvalidMetadata",
  InvalidQueryParameterValue: "InvalidQueryParameterValue",
  InvalidRange: "InvalidRange",
  InvalidResourceName: "InvalidResourceName",
  InvalidUri: "InvalidUri",
  InvalidXmlDocument: "InvalidXmlDocument",
  InvalidXmlNodeValue: "InvalidXmlNodeValue",
  Md5Mismatch: "Md5Mismatch",
  MetadataTooLarge: "MetadataTooLarge",
  MissingContentLengthHeader: "MissingContentLengthHeader",
  MissingRequiredQueryParameter: "MissingRequiredQueryParameter",
  MissingRequiredHeader: "MissingRequiredHeader",
  MissingRequiredXmlNode: "MissingRequiredXmlNode",
  MultipleConditionHeadersNotSupported: "MultipleConditionHeadersNotSupported",
  OperationTimedOut: "OperationTimedOut",
  OutOfRangeInput: "OutOfRangeInput",
  OutOfRangeQueryParameterValue: "OutOfRangeQueryParameterValue",
  RequestBodyTooLarge: "RequestBodyTooLarge",
  ResourceTypeMismatch: "ResourceTypeMismatch",
  RequestUrlFailedToParse: "RequestUrlFailedToParse",
  ResourceAlreadyExists: "ResourceAlreadyExists",
  ResourceNotFound: "ResourceNotFound",
  ServerBusy: "ServerBusy",
  UnsupportedHeader: "UnsupportedHeader",
  UnsupportedXmlNode: "UnsupportedXmlNode",
  UnsupportedQueryParameter: "UnsupportedQueryParameter",
  UnsupportedHttpVerb: "UnsupportedHttpVerb",
  InvalidMarker: "InvalidMarker",
  MessageNotFound: "MessageNotFound",
  MessageTooLarge: "MessageTooLarge",
  PopReceiptMismatch: "PopReceiptMismatch",
  QueueAlreadyExists: "QueueAlreadyExists",
  QueueBeingDeleted: "QueueBeingDeleted",
  QueueDisabled: "QueueDisabled",
  QueueNotEmpty: "QueueNotEmpty",
  QueueNotFound: "QueueNotFound",
  AuthorizationSourceIPMismatch: "AuthorizationSourceIPMismatch",
  AuthorizationProtocolMismatch: "AuthorizationProtocolMismatch",
  AuthorizationPermissionMismatch: "AuthorizationPermissionMismatch",
  AuthorizationServiceMismatch: "AuthorizationServiceMismatch",
  AuthorizationResourceTypeMismatch: "AuthorizationResourceTypeMismatch",
  FeatureVersionMismatch: "FeatureVersionMismatch",
}

/**
 * Storage Service Properties.
 */
@mediaTypeHint("application/xml")
model StorageServiceProperties {
  /**
   * Azure Analytics Logging settings
   */
  Logging?: Logging;

  /**
   * A summary of request statistics grouped by API in hourly aggregates for queues
   */
  HourMetrics?: Metrics;

  /**
   * a summary of request statistics grouped by API in minute aggregates for queues
   */
  MinuteMetrics?: Metrics;

  /**
   * The set of CORS rules.
   */
  Cors?: CorsRule[];
}

/**
 * Azure Analytics Logging settings.
 */
model Logging {
  /**
   * The version of Storage Analytics to configure.
   */
  Version: string;

  /**
   * Indicates whether all delete requests should be logged.
   */
  Delete: boolean;

  /**
   * Indicates whether all read requests should be logged.
   */
  Read: boolean;

  /**
   * Indicates whether all write requests should be logged.
   */
  Write: boolean;

  /**
   * the retention policy
   */
  RetentionPolicy: RetentionPolicy;
}

/**
 * the retention policy
 */
model RetentionPolicy {
  /**
   * Indicates whether a retention policy is enabled for the storage service
   */
  Enabled: boolean;

  /**
   * Indicates the number of days that metrics or logging or soft-deleted data
   * should be retained. All data older than this value will be deleted
   */
  @minValue(1)
  Days?: int32;
}

/**
 * the retention policy for response
 */
model RetentionPolicyResponse {
  /**
   * Indicates whether a retention policy is enabled for the storage service
   */
  Enabled: boolean;

  /**
   * Indicates the number of days that metrics or logging or soft-deleted data
   * should be retained. All data older than this value will be deleted
   */
  @minValue(1)
  Days?: int32;
}

/**
 * a summary of request statistics grouped by API in hour or minute aggregates for
 * queues
 */
model Metrics {
  /**
   * The version of Storage Analytics to configure.
   */
  Version?: string;

  /**
   * Indicates whether metrics are enabled for the Queue service.
   */
  Enabled: boolean;

  /**
   * Indicates whether metrics should generate summary statistics for called API
   * operations.
   */
  IncludeAPIs?: boolean;

  /**
   * the retention policy
   */
  RetentionPolicy?: RetentionPolicy;
}

/**
 * CORS is an HTTP feature that enables a web application running under one domain
 * to access resources in another domain. Web browsers implement a security
 * restriction known as same-origin policy that prevents a web page from calling
 * APIs in a different domain; CORS provides a secure way to allow one domain (the
 * origin domain) to call APIs in another domain
 */
model CorsRule {
  /**
   * The origin domains that are permitted to make a request against the storage
   * service via CORS. The origin domain is the domain from which the request
   * originates. Note that the origin must be an exact case-sensitive match with the
   * origin that the user age sends to the service. You can also use the wildcard
   * character '*' to allow all origin domains to make requests via CORS.
   */
  AllowedOrigins: string;

  /**
   * The methods (HTTP request verbs) that the origin domain may use for a CORS
   * request. (comma separated)
   */
  AllowedMethods: string;

  /**
   * the request headers that the origin domain may specify on the CORS request.
   */
  AllowedHeaders: string;

  /**
   * The response headers that may be sent in the response to the CORS request and
   * exposed by the browser to the request issuer
   */
  ExposedHeaders: string;

  /**
   * The maximum amount time that a browser should cache the preflight OPTIONS
   * request.
   */
  MaxAgeInSeconds: int32;
}

@error
model StorageError {
  Message?: string;
}

/**
 * Stats for the storage service.
 */
@mediaTypeHint("application/xml")
model StorageServiceStats {
  /**
   * Geo-Replication information for the Secondary Storage Service
   */
  GeoReplication?: GeoReplication;
}

model GeoReplication {
  /**
   * The status of the secondary location
   */
  Status: GeoReplicationStatusType;

  /**
   * A GMT date/time value, to the second. All primary writes preceding this value
   * are guaranteed to be available for read operations at the secondary. Primary
   * writes after this point in time may or may not be available for reads.
   */
  @encode(DateTimeKnownEncoding.rfc7231)
  LastSyncTime: utcDateTime;
}

/**
 * The object returned when calling List Queues on a Queue Service.
 */
@pagedResult
@Xml.name("EnumerationResults")
@mediaTypeHint("application/xml")
model ListQueuesSegmentResponse {
  ServiceEndpoint: string;
  Prefix: string;
  Marker?: string;
  MaxResults: int32;

  @items
  QueueItems?: QueueItem[];

  @nextLink
  NextMarker: string;
}

/**
 * An Azure Storage Queue.
 */
@Xml.name("Queue")
@mediaTypeHint("application/xml")
model QueueItem {
  /**
   * The name of the Queue.
   */
  Name: string;

  /**
   * Dictionary of <string>
   */
  Metadata?: Record<string>;
}

/**
 * signed identifier
 */
model SignedIdentifier {
  /**
   * a unique id
   */
  Id: string;

  /**
   * The access policy
   */
  AccessPolicy: AccessPolicy;
}

/**
 * An Access policy
 */
model AccessPolicy {
  /**
   * the date-time the policy is active
   */
  @encode(DateTimeKnownEncoding.rfc7231)
  Start?: utcDateTime;

  /**
   * the date-time the policy expires
   */
  @encode(DateTimeKnownEncoding.rfc7231)
  Expiry?: utcDateTime;

  /**
   * the permissions for the acl policy
   */
  Permission?: string;
}

/**
 * The object returned in the QueueMessageList array when calling Get Messages on
 * a Queue.
 */
model DequeuedMessageItem {
  /**
   * The Id of the Message.
   */
  MessageId: string;

  /**
   * The time the Message was inserted into the Queue.
   */
  @encode(DateTimeKnownEncoding.rfc7231)
  InsertionTime: utcDateTime;

  /**
   * The time that the Message will expire and be automatically deleted.
   */
  @encode(DateTimeKnownEncoding.rfc7231)
  ExpirationTime: utcDateTime;

  /**
   * This value is required to delete the Message. If deletion fails using this
   * PopReceipt then the message has been dequeued by another client.
   */
  PopReceipt: string;

  /**
   * The time that the message will again become visible in the Queue.
   */
  @encode(DateTimeKnownEncoding.rfc7231)
  TimeNextVisible: utcDateTime;

  /**
   * The number of times the message has been dequeued.
   */
  DequeueCount: int64;

  /**
   * The content of the message
   */
  MessageText: string;
}

/**
 * List wrapper for SignedIdentifier array
 */
@Xml.name("SignedIdentifiers")
@mediaTypeHint("application/xml")
model ListOfSignedIdentifier {
  @Xml.name("SignedIdentifier")
  value: SignedIdentifier[];
}
/**
 * List wrapper for DequeuedMessageItem array
 */
@Xml.name("QueueMessagesList")
@mediaTypeHint("application/xml")
model ListOfDequeuedMessageItem {
  @Xml.name("QueueMessage")
  value: DequeuedMessageItem[];
}

/**
 * List wrapper for EnqueuedMessage array
 */
@Xml.name("QueueMessagesList")
@mediaTypeHint("application/xml")
model ListOfEnqueuedMessage {
  @Xml.name("QueueMessage")
  value: EnqueuedMessage[];
}

/**
 * List wrapper for PeekedMessageItem array
 */
@Xml.name("QueueMessagesList")
@mediaTypeHint("application/xml")
model ListOfPeekedMessageItem {
  @Xml.name("QueueMessage")
  value: PeekedMessageItem[];
}

/**
 * A Message object which can be stored in a Queue
 */
model QueueMessage {
  /**
   * The content of the message
   */
  MessageText: string;
}

/**
 * The object returned in the QueueMessageList array when calling Put Message on a
 * Queue
 */
model EnqueuedMessage {
  /**
   * The Id of the Message.
   */
  MessageId: string;

  /**
   * The time the Message was inserted into the Queue.
   */
  @encode(DateTimeKnownEncoding.rfc7231)
  InsertionTime: utcDateTime;

  /**
   * The time that the Message will expire and be automatically deleted.
   */
  @encode(DateTimeKnownEncoding.rfc7231)
  ExpirationTime: utcDateTime;

  /**
   * This value is required to delete the Message. If deletion fails using this
   * PopReceipt then the message has been dequeued by another client.
   */
  PopReceipt: string;

  /**
   * The time that the message will again become visible in the Queue.
   */
  @encode(DateTimeKnownEncoding.rfc7231)
  TimeNextVisible: utcDateTime;
}

/**
 * The object returned in the QueueMessageList array when calling Peek Messages on
 * a Queue
 */
model PeekedMessageItem {
  /**
   * The Id of the Message.
   */
  MessageId: string;

  /**
   * The time the Message was inserted into the Queue.
   */
  @encode(DateTimeKnownEncoding.rfc7231)
  InsertionTime: utcDateTime;

  /**
   * The time that the Message will expire and be automatically deleted.
   */
  @encode(DateTimeKnownEncoding.rfc7231)
  ExpirationTime: utcDateTime;

  /**
   * The number of times the message has been dequeued.
   */
  DequeueCount: int64;

  /**
   * The content of the Message.
   */
  MessageText: string;
}
