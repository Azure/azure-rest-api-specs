import "./main.tsp";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Http;
using Azure.ClientGenerator.Core;
using Storage.Queues;

namespace Customizations;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@client(
  {
    service: Storage.Queues,
  },
  "rust,go"
)
interface QueueServiceClient extends Storage.Queues.Service {}

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
@client(
  {
    service: Storage.Queues,
  },
  "rust,go"
)
interface QueueClient extends Storage.Queues.Queue {}

@@clientInitialization(QueueServiceClient,
  {
    initializedBy: InitializedBy.customizeCode,
  },
  "rust"
);

@@clientInitialization(QueueClient,
  {
    initializedBy: InitializedBy.customizeCode,
  },
  "rust"
);

@@clientNamespace(Storage.Queues, "Azure.Storage.Queues", "!python, !csharp");
@@clientNamespace(Storage.Queues.Service, "Azure.Storage.Queues", "!python, !csharp");
@@clientNamespace(Storage.Queues.Queue, "Azure.Storage.Queues", "!python, !csharp");

@@clientName(Storage.Queues.MetadataHeaders.metadata, "metadata", "rust");
@@clientName(Storage.Queues.SentMessage, "SentMessageInternal", "rust");

@@alternateType(Storage.Queues.ListOfSentMessage,
  {
    identity: "crate::models::SentMessage",
  },
  "rust"
);

@@scope(Storage.Queues.Service.getUserDelegationKey, "!rust");

// Go customizations
/**
 * List wrapper for EnqueuedMessage array
 */
model ListOfSentMessageGo is Array<SentMessage>;
/**
 * List wrapper for PeekedMessageItem array
 */
model PeekedMessagesGo is Array<PeekedMessage>;
/**
 * List wrapper for DequeuedMessageItem array
*/
model ReceivedMessagesGo is Array<ReceivedMessage>;
/** Represents an array of signed identifiers */
@clientName("SignedIdentifiers", "go")
model SignedIdentifiersGo is Array<SignedIdentifier>;
@@alternateType(AccessPolicy.start, utcDateTime, "go");
@@alternateType(AccessPolicy.expiry, utcDateTime, "go");
@@alternateType(ListOfSentMessage, ListOfSentMessageGo, "go");
@@alternateType(PeekedMessages, PeekedMessagesGo, "go");
@@alternateType(ReceivedMessages, ReceivedMessagesGo, "go");
@@alternateType(SignedIdentifiers, SignedIdentifiersGo, "go");
@@clientName(Metrics.includeApis, "includeAPIs", "go");
@@clientName(CorsRule, "CORSRule", "go");
@@clientName(ListQueuesResponse, "ListQueuesSegmentResponse", "go");
@@clientName(ListQueuesResponse.queueItems, "Queues", "go");
@@clientName(QueueItem, "Queue", "go");
@@clientName(QueueServiceClient, "ServiceClient", "go");
@@clientName(QueueServiceProperties, "StorageServiceProperties", "go");
@@clientName(QueueServiceProperties.cors, "CORS", "go");
@@clientName(QueueServiceStats, "StorageServiceStats", "go");
@@clientName(ReceivedMessage, "DequeuedMessage", "go");
@@clientName(SentMessage, "EnqueuedMessage", "go");
@@clientName(Service.getQueues, "ListQueuesSegment", "go");
@@clientName(UserDelegationKey.signedOid, "SignedOID", "go");
@@clientName(UserDelegationKey.signedTid, "SignedTID", "go");
@@clientName(UserDelegationKey.signedDelegatedUserTid,
  "SignedDelegatedUserTID",
  "go"
);
@@clientOption(Queue.peekMessages, "monomorphicResponseFieldName", "Messages", "go");
@@clientOption(Queue.receiveMessages, "monomorphicResponseFieldName", "Messages", "go");
@@clientOption(Queue.sendMessage, "monomorphicResponseFieldName", "Messages", "go");
@@clientOption(Queue.sendMessage, "responseEnvelopeName", "MessagesClientEnqueueResponse", "go");
@@clientOption(Queue.receiveMessages, "responseEnvelopeName", "MessagesClientDequeueResponse", "go");
@@clientOption(Queue.updateMessage, "responseEnvelopeName", "MessageIDClientUpdateResponse", "go");
@@clientOption(Queue.deleteMessage, "responseEnvelopeName", "MessageIDClientDeleteResponse", "go");
@@clientOption(Queue.peekMessages, "responseEnvelopeName", "MessagesClientPeekResponse", "go");
@@clientOption(Queue.clear, "responseEnvelopeName", "MessagesClientClearResponse", "go");


// JavaScript SDK renames - based on azure-sdk-for-js storage-queue swagger README

@@clientName(Storage.Queues.ReceivedMessage.insertionTime,
  "insertedOn",
  "javascript"
);
@@clientName(Storage.Queues.SentMessage.insertionTime,
  "insertedOn",
  "javascript"
);
@@clientName(Storage.Queues.PeekedMessage.insertionTime,
  "insertedOn",
  "javascript"
);
@@clientName(Storage.Queues.ReceivedMessage.expirationTime,
  "expiresOn",
  "javascript"
);
@@clientName(Storage.Queues.SentMessage.expirationTime,
  "expiresOn",
  "javascript"
);
@@clientName(Storage.Queues.PeekedMessage.expirationTime,
  "expiresOn",
  "javascript"
);
@@clientName(Storage.Queues.ReceivedMessage.timeNextVisible,
  "nextVisibleOn",
  "javascript"
);
@@clientName(Storage.Queues.SentMessage.timeNextVisible,
  "nextVisibleOn",
  "javascript"
);
@@clientName(Storage.Queues.TimeNextVisibleResponseHeader.timeNextVisible,
  "nextVisibleOn",
  "javascript"
);
@@clientName(Storage.Queues.TimeNextVisibleResponseHeaderPrivate.timeNextVisible,
  "nextVisibleOn",
  "javascript"
);
@@alternateType(Storage.Queues.AccessPolicy.start, string, "javascript");
@@alternateType(Storage.Queues.AccessPolicy.expiry, string, "javascript");
@@clientName(Storage.Queues.AccessPolicy.start, "startsOn", "javascript");
@@clientName(Storage.Queues.AccessPolicy.expiry, "expiresOn", "javascript");
@@clientName(Storage.Queues.AccessPolicy.permission,
  "permissions",
  "javascript"
);
@@clientName(Storage.Queues.UserDelegationKey.signedOid,
  "signedObjectId",
  "javascript"
);
@@clientName(Storage.Queues.UserDelegationKey.signedTid,
  "signedTenantId",
  "javascript"
);
@@alternateType(Storage.Queues.UserDelegationKey.signedStart,
  string,
  "javascript"
);
@@alternateType(Storage.Queues.UserDelegationKey.signedExpiry,
  string,
  "javascript"
);
@@clientName(Storage.Queues.UserDelegationKey.signedStart,
  "signedStartsOn",
  "javascript"
);
@@clientName(Storage.Queues.UserDelegationKey.signedExpiry,
  "signedExpiresOn",
  "javascript"
);
@@clientName(Storage.Queues.QueueServiceProperties.logging,
  "queueAnalyticsLogging",
  "javascript"
);
@@clientName(Storage.Queues.Logging.delete, "deleteProperty", "javascript");
@@clientName(Storage.Queues.GeoReplication.lastSyncTime,
  "lastSyncOn",
  "javascript"
);
@@clientName(Storage.Queues.ListQueuesResponse.maxResults,
  "maxPageSize",
  "javascript"
);
@@clientName(Storage.Queues.ListQueuesResponse.nextMarker,
  "continuationToken",
  "javascript"
);
@@clientName(Storage.Queues.TimeoutParameter.timeout,
  "timeoutInSeconds",
  "javascript"
);
@@clientName(Storage.Queues.Metrics.includeApis, "includeAPIs", "javascript");
@@alternateType(Storage.Queues.KeyInfo.start, string, "javascript, python");
@@alternateType(Storage.Queues.KeyInfo.expiry, string, "javascript, python");
@@clientName(Storage.Queues.KeyInfo.start, "startsOn", "javascript");
@@clientName(Storage.Queues.KeyInfo.expiry, "expiresOn", "javascript");
@@clientOption(Storage.Queues.Error,
  "header",
  "x-ms-error-code:errorCode",
  "javascript"
);
@@clientOption(Storage.Queues.Error,
  "restErrorCodeHeader",
  "x-ms-error-code",
  "javascript"
);
@@clientOption(Storage.Queues.MetadataHeaders.metadata,
  "headerCollectionPrefix",
  "x-ms-meta",
  "javascript"
);

@@clientOption(Storage.Queues, "includeRootSlash", false, "python,javascript");

@@Legacy.disablePageable(Storage.Queues.Service.getQueues, "python,javascript,csharp");

@@alternateType(Storage.Queues.UserDelegationKey.signedExpiry,
  string,
  "python"
);
@@alternateType(Storage.Queues.UserDelegationKey.signedStart, string, "python");

@@clientOption(Storage.Queues, "omitSlashFromEmptyRoute", true, "python");

/** ----- This section overrides the setAccessPolicy operation for Rust to require the queueAcl body ----- */
/** sets the permissions for the specified queue. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
@put
@route("?comp=acl")
op setAccessPolicyRequiredQueueAcl is StorageOperationNoBody<
  {
    /** The media type of the requestbody */
    @header("Content-Type")
    contentType?: "application/xml";

    ...TimeoutParameter;

    /** The access control list for the queue. */
    #suppress "@azure-tools/typespec-azure-core/request-body-problem" "Existing API"
    @bodyRoot
    queueAcl: SignedIdentifiers;
  },
  {
    @statusCode statusCode: 204;
  }
>;

@@override(Queue.setAccessPolicy, setAccessPolicyRequiredQueueAcl, "rust");

/** ----- This section overrides the setMetadata operations for Rust to require the metadata headers ----- */
alias MetadataHeadersRequired = {
  /** The metadata headers. */
  @alternateType(Record<string>, "rust")
  @header("x-ms-meta")
  metadata: string;
};

/** Operation sets one or more user-defined name-value pairs for the specified queue. */
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
@put
@route("?comp=metadata")
op setMetadataRequiredMetadataQueue is StorageOperationNoBody<
  {
    ...TimeoutParameter;
    ...MetadataHeadersRequired;
  },
  {
    @statusCode statusCode: 204;
  }
>;

@@override(Queue.setMetadata, setMetadataRequiredMetadataQueue, "rust");

// csharp customizations
@@alternateType(AccessPolicy.start, utcDateTime, "csharp");
@@alternateType(AccessPolicy.expiry, utcDateTime, "csharp");
@@alternateType(MetadataHeaders.metadata, Record<string>, "csharp");
@@alternateType(ListQueuesIncludeType, string, "csharp");
@@alternateType(KeyInfo.start, string, "csharp");
@@alternateType(KeyInfo.expiry, string, "csharp");

@@clientName(Storage.Queues, "QueueClient", "csharp");
@@clientName(AccessPolicy, "QueueAccessPolicy", "csharp");
@@clientName(AccessPolicy.start, "StartsOn", "csharp");
@@clientName(AccessPolicy.expiry, "ExpiresOn", "csharp");
@@clientName(AccessPolicy.permission, "Permissions", "csharp");
@@clientName(Service, "ServiceRestClient", "csharp");
@@clientName(Queue, "QueueRestClient", "csharp");
@@clientName(GeoReplication, "QueueGeoReplication", "csharp");
@@clientName(GeoReplicationStatus, "QueueGeoReplicationStatus", "csharp");
@@clientName(QueueServiceStats, "QueueServiceStatistics", "csharp");
@@clientName(SentMessage, "SendReceipt", "csharp");
@@clientName(StorageErrorCode, "QueueErrorCode", "csharp");
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" ""
@@clientName(Queue.receiveMessages, "Dequeue", "csharp");
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" ""
@@clientName(Queue.sendMessage, "Enqueue", "csharp");
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" ""
@@clientName(Queue.peekMessages, "Peek", "csharp");
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" ""
@@clientName(Queue.updateMessage, "Update", "csharp");
#suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" ""
@@clientName(Queue.deleteMessage, "Delete", "csharp");
@@clientName(Service.getQueues, "GetQueuesSegment", "csharp");
@@clientName(CorsRule, "QueueCorsRule", "csharp");
@@clientName(Metrics, "QueueMetrics", "csharp");
@@clientName(RetentionPolicy, "QueueRetentionPolicy", "csharp");
@@clientName(Logging, "QueueAnalyticsLogging", "csharp");
@@clientName(SignedIdentifier, "QueueSignedIdentifier", "csharp");
@@clientName(SignedIdentifiers, "QueueSignedIdentifiers", "csharp");


@@clientLocation(Queue.receiveMessages, "MessagesRestClient", "csharp");
@@clientLocation(Queue.sendMessage, "MessagesRestClient", "csharp");
@@clientLocation(Queue.peekMessages, "MessagesRestClient", "csharp");
@@clientLocation(Queue.clear, "MessagesRestClient", "csharp");
@@clientLocation(Queue.updateMessage, "MessageIdRestClient", "csharp");
@@clientLocation(Queue.deleteMessage, "MessageIdRestClient", "csharp");

@@clientOption(MetadataHeaders.metadata, "collectionHeaderPrefix", "x-ms-meta-", "csharp");
@@clientOption(Storage.Queues, "omitSlashFromEmptyRoute", true, "csharp");
