import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@typespec/openapi";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;

namespace Storage.Queues {
  /** Azure Storage Queue basic operation template */
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
  op StorageOperation<
    TParams extends TypeSpec.Reflection.Model | void,
    TResponse extends TypeSpec.Reflection.Model | void,
    RequestMediaType extends string = "application/xml",
    ResponseMediaType extends string = "application/xml",
    TError = StorageError
  >(
    /** Content-Type header */
    #suppress "@typespec/http/content-type-ignored" "Template for existing API"
    @header("Content-Type")
    contentType: RequestMediaType,

    ...ApiVersionHeader,
    ...ClientRequestIdHeader,
    ...TParams,
  ): (TResponse & {
    /** Content-Type header */
    #suppress "@typespec/http/content-type-ignored" "Template for existing API"
    @header("Content-Type")
    contentType: ResponseMediaType;

    ...ApiVersionHeader;
    ...RequestIdResponseHeader;
    ...ClientRequestIdHeader;
  }) | TError;

  /** Azure Storage Queue basic operation template */
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
  op StorageOperationNoBody<
    TParams extends TypeSpec.Reflection.Model | void,
    TResponse extends TypeSpec.Reflection.Model | void,
    TError = StorageError
  >(...ApiVersionHeader, ...ClientRequestIdHeader, ...TParams): (TResponse & {
    ...ApiVersionHeader;
    ...RequestIdResponseHeader;
    ...ClientRequestIdHeader;
  }) | TError;

  /** Sets properties for a storage account's Queue service endpoint, including properties for Storage Analytics and CORS (Cross-Origin Resource Sharing) rules */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
  @put
  @route("?restype=service&comp=properties")
  op setProperties is StorageOperation<
    {
      ...TimeoutParameter;

      /** The storage service properties to set. */
      @body
      queueServiceProperties: QueueServiceProperties;
    },
    AcceptedResponse
  >;

  /** Retrieves properties of a storage account's Queue service, including properties for Storage Analytics and CORS (Cross-Origin Resource Sharing) rules. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
  @get
  @route("?restype=service&comp=properties")
  op getProperties is StorageOperation<
    TimeoutParameter,
    QueueServiceProperties
  >;

  /** Retrieves statistics related to replication for the Queue service. It is only available on the secondary location endpoint when read-access geo-redundant replication is enabled for the storage account. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
  @get
  @route("?restype=service&comp=stats")
  op getStatistics is StorageOperation<
    TimeoutParameter,
    {
      ...DateResponseHeader;

      /** Storage service statistics */
      @body
      queueServiceStats: QueueServiceStats;
    }
  >;

  /** returns a list of the queues under the specified account */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @get
  @list
  @route("?comp=list")
  op getQueues is StorageOperation<
    {
      /** Filters the results to return only queues whose name begins with the specified prefix. */
      @query prefix?: string;

      /** A string value that identifies the portion of the list of queues to be returned with the next listing operation. The operation returns the NextMarker value within the response body if the listing operation did not return all queues remaining to be listed with the current page. The NextMarker value can be used as the value for the marker parameter in a subsequent call to request the next page of list items. The marker value is opaque to the client. */
      @continuationToken
      @query
      marker?: string;

      /** Specifies the maximum number of queues to return. If the request does not specify maxresults, or specifies a value greater than 5000, the server will return up to 5000 items. */
      @query
      @minValue(1)
      maxresults?: int32;

      ...TimeoutParameter;

      /** Include this parameter to specify that the queue's metadata be returned as part of the response body. */
      @query include?: Array<ListQueuesIncludeType>;
    },
    ListQueuesResponse
  >;

  @route("/{queueName}")
  namespace Queue {
    /** Creates a new queue under the specified account. If the queue with the same name already exists, the operation fails. */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
    @put
    op create is StorageOperationNoBody<
      {
        ...QueueNamePathParameter;
        ...TimeoutParameter;
        ...MetadataHeaders;
      },
      CreatedResponse
    >;

    /** returns all user-defined metadata and system properties for the specified queue. */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
    @get
    @route("?comp=metadata")
    op getMetadata is StorageOperationNoBody<
      {
        ...QueueNamePathParameter;
        ...TimeoutParameter;
      },
      {
        ...MetadataHeaders;
      }
    >;

    /** operation permanently deletes the specified queue */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
    @delete
    op delete is StorageOperationNoBody<
      {
        ...QueueNamePathParameter;
        ...TimeoutParameter;
        ...MetadataHeaders;
      },
      NoContentResponse
    >;

    /** operation sets one or more user-defined name-value pairs for the specified queue. */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
    @put
    @route("?comp=metadata")
    op setMetadata is StorageOperationNoBody<
      {
        ...QueueNamePathParameter;
        ...TimeoutParameter;

        /** The metadata headers. */
        @alternateType(Record<string>, "rust")
        @header("x-ms-meta")
        metadata: string;
      },
      NoContentResponse
    >;

    /** gets the permissions for the specified queue. The permissions indicate whether queue data may be accessed publicly. */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
    @get
    @route("?comp=acl")
    op getAccessPolicy is StorageOperation<
      {
        ...QueueNamePathParameter;
        ...TimeoutParameter;
      },
      {
        @body body: ListOfSignedIdentifier;
        ...DateResponseHeader;
      }
    >;

    /** sets the permissions for the specified queue. */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
    @put
    @route("?comp=acl")
    op setAccessPolicy is StorageOperation<
      {
        ...QueueNamePathParameter;
        ...TimeoutParameter;

        /** The access control list for the queue. */
        #suppress "@azure-tools/typespec-azure-core/request-body-problem" "Existing API"
        @body
        queueAcl: ListOfSignedIdentifier;
      },
      {
        ...DateResponseHeader;
      }
    >;

    /**
     * The Dequeue operation retrieves one or more messages from the front of the
     * queue.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
    @get
    @route("/messages")
    op receiveMessages is StorageOperation<
      {
        ...QueueNamePathParameter;

        /**
         * Optional. A nonzero integer value that specifies the number of messages to
         * retrieve from the queue, up to a maximum of 32. If fewer are visible, the
         * visible messages are returned. By default, a single message is retrieved from
         * the queue with this operation.
         */
        @minValue(1)
        @query("numofmessages")
        numberOfMessages?: int32;

        ...VisibilityTimeoutParameter;
        ...TimeoutParameter;
      },
      ListOfReceivedMessage
    >;

    /**
     * The Clear operation deletes all messages from the specified queue.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
    @delete
    @route("/messages")
    op clear is StorageOperationNoBody<
      {
        ...QueueNamePathParameter;
      },
      NoContentResponse
    >;

    /**
     * The Enqueue operation adds a new message to the back of the message queue. A
     * visibility timeout can also be specified to make the message invisible until
     * the visibility timeout expires. A message must be in a format that can be
     * included in an XML request with UTF-8 encoding. The encoded message can be up
     * to 64 KB in size for versions 2011-08-18 and newer, or 8 KB in size for
     * previous versions.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
    @post
    @route("/messages")
    op sendMessage is StorageOperation<
      {
        ...QueueNamePathParameter;
        ...VisibilityTimeoutParameter;

        /**
         * Optional. Specifies the time-to-live interval for the message, in seconds.
         * Prior to version 2017-07-29, the maximum time-to-live allowed is 7 days. For
         * version 2017-07-29 or later, the maximum time-to-live can be any positive
         * number, as well as -1 indicating that the message does not expire. If this
         * parameter is omitted, the default time-to-live is 7 days.
         */
        @minValue(-1)
        @query("messageTtl")
        messageTimeToLive?: int32;

        ...QueueMessageBodyParameter;
      },
      {
        @statusCode statusCode: 201;
        ...ListOfSentMessage;
      }
    >;

    /**
     * The Peek operation retrieves one or more messages from the front of the queue,
     * but does not alter the visibility of the message.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
    @get
    @route("/messages?peekonly=true")
    op peekMessages is StorageOperation<
      {
        ...QueueNamePathParameter;

        /**
         * Optional. A nonzero integer value that specifies the number of messages to
         * retrieve from the queue, up to a maximum of 32. If fewer are visible, the
         * visible messages are returned. By default, a single message is retrieved from
         * the queue with this operation.
         */
        @minValue(1)
        @query("numofmessages")
        numberOfMessages?: int32;
      },
      ListOfPeekedMessage
    >;

    /**
     * The Update operation was introduced with version 2011-08-18 of the Queue
     * service API. The Update Message operation updates the visibility timeout of a
     * message. You can also use this operation to update the contents of a message. A
     * message must be in a format that can be included in an XML request with UTF-8
     * encoding, and the encoded message can be up to 64KB in size.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
    #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
    @put
    @route("/messages/{messageId}")
    op update is StorageOperation<
      {
        ...QueueNamePathParameter;
        ...MessageIdPathParameter;
        ...PopReceiptQueryParameter;

        @doc("Specifies the new visibility timeout value, in seconds, relative to server time. The default value is 30 seconds. A specified value must be larger than or equal to 1 second, and cannot be larger than 7 days, or larger than 2 hours on REST protocol versions prior to version 2011-08-18. The visibility timeout of a message can be set to a value later than the expiry time.")
        @maxValue(604800)
        @query("visibilityTimeout")
        visibilityTimeout: int32;

        ...QueueMessageBodyParameter;
      },
      NoContentResponse
    >;

    /**
     * The Delete operation deletes the specified message.
     */
    #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
    #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
    @delete
    @route("/messages/{messageId}")
    op deleteMessage is StorageOperationNoBody<
      {
        ...QueueNamePathParameter;
        ...MessageIdPathParameter;
        ...PopReceiptQueryParameter;
      },
      NoContentResponse
    >;
  }
}
