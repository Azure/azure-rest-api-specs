import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@typespec/openapi";
import "@azure-tools/typespec-client-generator-core";

namespace Storage.Queues;

using Azure.ClientGenerator.Core;
using TypeSpec.Http;

/** Azure Storage Queue basic operation template */
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
op StorageOperation<
  TParams extends TypeSpec.Reflection.Model | void,
  TResponse extends TypeSpec.Reflection.Model | void,
  RequestMediaType extends string = "application/xml",
  ResponseMediaType extends string = "application/xml",
  TError = Error
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
  ...DateResponseHeader;
}) | TError;

/** Azure Storage Queue basic operation template */
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
op StorageOperationNoBody<
  TParams extends TypeSpec.Reflection.Model | void,
  TResponse extends TypeSpec.Reflection.Model | void,
  TError = Error
>(...ApiVersionHeader, ...ClientRequestIdHeader, ...TParams): (TResponse & {
  ...ApiVersionHeader;
  ...RequestIdResponseHeader;
  ...ClientRequestIdHeader;
  ...DateResponseHeader;
}) | TError;

/** Azure Storage Queue basic operation template */
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
op StorageOperationResponseBody<
  TParams extends TypeSpec.Reflection.Model | void,
  TResponse extends TypeSpec.Reflection.Model | void,
  ResponseMediaType extends string = "application/xml",
  TError = Error
> is StorageOperationNoBody<
  TParams,
  {
    /** Content-Type header */
    #suppress "@typespec/http/content-type-ignored" "Template for existing API"
    @header("Content-Type")
    contentType: ResponseMediaType;
  } & TResponse,
  TError
>;

/** Azure Storage Queue basic operation template */
#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
op StorageOperationRequestBody<
  TParams extends TypeSpec.Reflection.Model | void,
  TResponse extends TypeSpec.Reflection.Model | void,
  RequestMediaType extends string = "application/xml",
  TError = Error
> is StorageOperationNoBody<
  {
    /** Content-Type header */
    #suppress "@typespec/http/content-type-ignored" "Template for existing API"
    @header("Content-Type")
    contentType: RequestMediaType;
  } & TParams,
  TResponse,
  TError
>;

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
interface Service {
  /**
   * Sets properties for a storage account's Queue service endpoint, including properties for Storage Analytics
   * and CORS (Cross-Origin Resource Sharing) rules.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
  @put
  @route("?restype=service&comp=properties")
  setProperties is StorageOperationRequestBody<
    {
      ...TimeoutParameter;

      /** The storage service properties to set. */
      @bodyRoot
      queueServiceProperties: QueueServiceProperties;
    },
    AcceptedResponse
  >;

  /**
   * Retrieves properties of a storage account's Queue service, including properties for Storage Analytics and
   * CORS (Cross-Origin Resource Sharing) rules.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
  @get
  @route("?restype=service&comp=properties")
  getProperties is StorageOperationResponseBody<
    TimeoutParameter,
    QueueServiceProperties
  >;

  /**
   * Retrieves statistics related to replication for the Queue service. It is only available on the secondary
   * location endpoint when read-access geo-redundant replication is enabled for the storage account.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
  @get
  @route("?restype=service&comp=stats")
  getStatistics is StorageOperationResponseBody<
    TimeoutParameter,
    {
      /** Storage service statistics. */
      @bodyRoot
      body: QueueServiceStats;
    }
  >;

  /**
   * Retrieves a user delegation key for the Queue service. This is only a valid operation when using bearer
   * token authentication.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
  @post
  @route("?restype=service&comp=userdelegationkey")
  getUserDelegationKey is StorageOperation<
    {
      ...TimeoutParameter;

      /** Key information. */
      @bodyRoot
      @Xml.name("KeyInfo")
      keyInfo: KeyInfo;
    },
    {
      /** A user delegation key. */
      @bodyRoot
      body: UserDelegationKey;
    }
  >;

  /** Returns a list of queues. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @get
  @list
  @route("?comp=list")
  getQueues is StorageOperationResponseBody<
    {
      /** Filters the results to return only queues whose name begins with the specified prefix. */
      @query prefix?: string;

      /**
       * Identifies the portion of the list of queues to be returned with the next listing operation. The operation
       * returns the marker value if the listing operation did not return all queues remaining. The marker value can
       * be used as the value for the marker parameter in a subsequent call to request the next page of list items.
       * The marker value is opaque to the client.
       */
      @continuationToken
      @query
      marker?: string;

      /**
       * Specifies the maximum number of queues to return. If the request does not specify maxresults, or specifies
       * a value greater than 5000, the server will return up to 5000 items.
       */
      @query
      @minValue(1)
      maxresults?: int32;

      ...TimeoutParameter;

      /** Specify to include additional, optional information. */
      @query include?: Array<ListQueuesIncludeType>;
    },
    {
      @bodyRoot body: ListQueuesResponse;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
interface Queue {
  /**
   * Creates a new queue. If a queue with the same name already exists, the operation succeeds when the metadata
   * is identical. If the metadata differs, the operation fails.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
  @put
  create is StorageOperationNoBody<
    {
      ...TimeoutParameter;
      ...MetadataHeaders;
    },
    {
      #suppress "@azure-tools/typespec-azure-core/no-closed-literal-union" "Following standard pattern"
      @statusCode statusCode: 201 | 204;
    }
  >;

  /** Returns all user-defined metadata and system properties for the specified queue. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
  @get
  @route("?comp=metadata")
  getProperties is StorageOperationNoBody<
    {
      ...TimeoutParameter;
    },
    {
      ...MetadataHeaders;
      ...ApproximateMessagesCountHeader;
    }
  >;

  /** Permanently deletes the specified queue. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
  @delete
  delete is StorageOperationNoBody<
    {
      ...TimeoutParameter;
    },
    {
      @statusCode statusCode: 204;
    }
  >;

  /** Sets user-defined metadata for the specified queue. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
  @put
  @route("?comp=metadata")
  setMetadata is StorageOperationNoBody<
    {
      ...TimeoutParameter;
      ...MetadataHeaders;
    },
    {
      @statusCode statusCode: 204;
    }
  >;

  /** Gets the access policy for the specified queue. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
  @get
  @route("?comp=acl")
  getAccessPolicy is StorageOperationResponseBody<
    {
      ...TimeoutParameter;
    },
    {
      @bodyRoot body: SignedIdentifiers;
    }
  >;

  /** Sets the permissions for the specified queue. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("?comp=acl")
  setAccessPolicy is StorageOperationNoBody<
    {
      /** The media type of the request. */
      @header("Content-Type")
      contentType?: "application/xml";

      ...TimeoutParameter;

      /** The access control list. */
      #suppress "@azure-tools/typespec-azure-core/request-body-problem" "Existing API"
      @bodyRoot
      queueAcl?: SignedIdentifiers;
    },
    {
      @statusCode statusCode: 204;
    }
  >;

  /** Retrieves one or more messages from the front of the queue. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @get
  @route("messages")
  receiveMessages is StorageOperationResponseBody<
    {
      /**
       * A nonzero integer value that specifies the number of messages to
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
    {
      @bodyRoot body: ReceivedMessages;
    }
  >;

  /** Deletes all messages from the specified queue. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @delete
  @route("messages")
  clear is StorageOperationNoBody<
    {
      ...TimeoutParameter;
    },
    {
      @statusCode statusCode: 204;
    }
  >;

  /**
   * Adds a new message to the back of the message queue. A visibility timeout
   * can also be specified to make the message invisible until the visibility timeout
   * expires.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
  @post
  @route("messages")
  sendMessage is StorageOperation<
    {
      ...VisibilityTimeoutParameter;

      /**
       * Specifies the time-to-live interval for the message, in seconds.
       * Prior to version 2017-07-29, the maximum time-to-live allowed is 7 days. For
       * version 2017-07-29 or later, the maximum time-to-live can be any positive
       * number, as well as -1 indicating that the message does not expire. If this
       * parameter is omitted, the default time-to-live is 7 days.
       */
      @minValue(-1)
      @query("messagettl")
      messageTimeToLive?: int32;

      ...TimeoutParameter;

      /**
       * The queue message. The message must be in a format that can be included in an XML request with UTF-8
       * encoding. The encoded message can be up to 64 KB in size.
       */
      @bodyRoot
      queueMessage: QueueMessage;
    },
    {
      @statusCode statusCode: 201;
      @bodyRoot body: ListOfSentMessage;
    }
  >;

  /** Retrieves one or more messages from the front of the queue, but does not alter the visibility of the message. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @get
  @route("messages?peekonly=true")
  peekMessages is StorageOperationResponseBody<
    {
      /**
       * A nonzero integer value that specifies the number of messages to
       * retrieve from the queue, up to a maximum of 32. If fewer are visible, the
       * visible messages are returned. By default, a single message is retrieved from
       * the queue with this operation.
       */
      @minValue(1)
      @query("numofmessages")
      numberOfMessages?: int32;

      ...TimeoutParameter;
    },
    {
      @bodyRoot body: PeekedMessages;
    }
  >;

  /** Updates the visibility timeout of a message. This operation can also be used to update the contents of a message. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
  #suppress "@azure-tools/typespec-azure-core/use-standard-names" "Existing API"
  @put
  @route("messages/{messageId}")
  updateMessage is StorageOperationNoBody<
    {
      /** Content-Type header */
      @header("Content-Type")
      contentType?: "application/xml";

      ...MessageIdPathParameter;
      ...PopReceiptQueryParameter;

      /**
       * Specifies the new visibility timeout value, in seconds, relative to server time. A specified value must be
       * larger than or equal to 1 second, and cannot be larger than 7 days. The visibility timeout of a message
       * can be set to a value later than the expiry time.
       */
      @maxValue(604800)
      @query("visibilitytimeout")
      visibilityTimeout: int32;

      ...TimeoutParameter;
      ...QueueMessageBodyParameter;
    },
    {
      @statusCode statusCode: 204;
      ...PopReceiptResponseHeaderPrivate;
      ...TimeNextVisibleResponseHeaderPrivate;
    }
  >;

  /** Deletes the specified message. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Existing API"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "Existing API. Storage API version parameter pre-dates current guidance."
  @delete
  @route("messages/{messageId}")
  deleteMessage is StorageOperationNoBody<
    {
      ...MessageIdPathParameter;
      ...PopReceiptQueryParameter;
      ...TimeoutParameter;
    },
    {
      @statusCode statusCode: 204;
    }
  >;
}
