import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@typespec/openapi";
import "@azure-tools/typespec-client-generator-core";

using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Azure.ClientGenerator.Core;

namespace AzureQueueStorage;

interface ServiceOperationGroup {
  /**
   * Sets properties for a storage account's Queue service endpoint, including
   * properties for Storage Analytics and CORS (Cross-Origin Resource Sharing) rules
   */
  @operationId("Service_SetProperties")
  @route("?restype=service&comp=properties")
  @put
  setProperties is Azure.Core.Foundations.Operation<
    {
      /**
       * The The timeout parameter is expressed in seconds. For more information, see <a
       * href="https://learn.microsoft.com/rest/api/storageservices/setting-timeouts-for-queue-service-operations>Setting
       * Timeouts for Queue Service Operations.</a>
       */
      @query("timeout")
      timeout?: int32;

      /**
       * Specifies the version of the operation to use for this request.
       */
      @header("x-ms-version")
      version: Versions;

      /**
       * Provides a client-generated, opaque value with a 1 KB character limit that is
       * recorded in the analytics logs when storage analytics logging is enabled.
       */
      @header
      requestId?: string;

      /**
       * The StorageService properties.
       */
      @bodyRoot
      storageServiceProperties: StorageServiceProperties;
    },
    void
  >;

  /**
   * gets the properties of a storage account's Queue service, including properties
   * for Storage Analytics and CORS (Cross-Origin Resource Sharing) rules.
   */
  @operationId("Service_GetProperties")
  @route("?restype=service&comp=properties")
  @get
  getProperties is Azure.Core.Foundations.Operation<
    {
      /**
       * The The timeout parameter is expressed in seconds. For more information, see <a
       * href="https://learn.microsoft.com/rest/api/storageservices/setting-timeouts-for-queue-service-operations>Setting
       * Timeouts for Queue Service Operations.</a>
       */
      @query("timeout")
      timeout?: int32;

      /**
       * Specifies the version of the operation to use for this request.
       */
      @header("x-ms-version")
      version: Versions;

      /**
       * Provides a client-generated, opaque value with a 1 KB character limit that is
       * recorded in the analytics logs when storage analytics logging is enabled.
       */
      @header
      requestId?: string;
    },
    StorageServiceProperties
  >;

  /**
   * Retrieves statistics related to replication for the Queue service. It is only
   * available on the secondary location endpoint when read-access geo-redundant
   * replication is enabled for the storage account.
   */
  @operationId("Service_GetStatistics")
  @route("?restype=service&comp=stats")
  @get
  getStatistics is Azure.Core.Foundations.Operation<
    {
      /**
       * The The timeout parameter is expressed in seconds. For more information, see <a
       * href="https://learn.microsoft.com/rest/api/storageservices/setting-timeouts-for-queue-service-operations>Setting
       * Timeouts for Queue Service Operations.</a>
       */
      @query("timeout")
      timeout?: int32;

      /**
       * Specifies the version of the operation to use for this request.
       */
      @header("x-ms-version")
      version: Versions;

      /**
       * Provides a client-generated, opaque value with a 1 KB character limit that is
       * recorded in the analytics logs when storage analytics logging is enabled.
       */
      @header
      requestId?: string;
    },
    StorageServiceStats
  >;

  /**
   * The List Queues Segment operation returns a list of the queues under the
   * specified account
   */
  @operationId("Service_ListQueuesSegment")
  @route("?comp=list")
  @get
  listQueuesSegment is Azure.Core.Foundations.Operation<
    {
      /**
       * Filters the results to return only queues whose name begins with the specified
       * prefix.
       */
      @query("prefix")
      prefix?: string;

      /**
       * A string value that identifies the portion of the list of queues to be returned
       * with the next listing operation. The operation returns the NextMarker value
       * within the response body if the listing operation did not return all queues
       * remaining to be listed with the current page. The NextMarker value can be used
       * as the value for the marker parameter in a subsequent call to request the next
       * page of list items. The marker value is opaque to the client.
       */
      @query("marker")
      marker?: string;

      /**
       * Specifies the maximum number of queues to return. If the request does not
       * specify maxresults, or specifies a value greater than 5000, the server will
       * return up to 5000 items. Note that if the listing operation crosses a partition
       * boundary, then the service will return a continuation token for retrieving the
       * remainder of the results. For this reason, it is possible that the service will
       * return fewer results than specified by maxresults, or than the default of 5000.
       */
      @minValue(1)
      @query("maxresults")
      maxresults?: int32;

      /**
       * Include this parameter to specify that the queues' metadata be returned as part
       * of the response body.
       */
      @query("include")
      include?: "metadata"[];

      /**
       * The The timeout parameter is expressed in seconds. For more information, see <a
       * href="https://learn.microsoft.com/rest/api/storageservices/setting-timeouts-for-queue-service-operations>Setting
       * Timeouts for Queue Service Operations.</a>
       */
      @query("timeout")
      timeout?: int32;

      /**
       * Specifies the version of the operation to use for this request.
       */
      @header("x-ms-version")
      version: Versions;

      /**
       * Provides a client-generated, opaque value with a 1 KB character limit that is
       * recorded in the analytics logs when storage analytics logging is enabled.
       */
      @header
      requestId?: string;
    },
    ListQueuesSegmentResponse
  >;
}

interface QueueOperationGroup {
  /**
   * creates a new queue under the given account.
   */
  @operationId("Queue_Create")
  @route("/{queueName}")
  @put
  create is Azure.Core.Foundations.Operation<
    {
      /**
       * The queue name.
       */
      @path
      queueName: string;

      /**
       * The The timeout parameter is expressed in seconds. For more information, see <a
       * href="https://learn.microsoft.com/rest/api/storageservices/setting-timeouts-for-queue-service-operations>Setting
       * Timeouts for Queue Service Operations.</a>
       */
      @query("timeout")
      timeout?: int32;

      /**
       * Optional. Include this parameter to specify that the queue's metadata be
       * returned as part of the response body. Note that metadata requested with this
       * parameter must be stored in accordance with the naming restrictions imposed by
       * the 2009-09-19 version of the Queue service. Beginning with this version, all
       * metadata names must adhere to the naming conventions for C# identifiers.
       */
      @alternateType(Record<string>, "rust")
      @header("x-ms-meta")
      metadata?: string;

      /**
       * Specifies the version of the operation to use for this request.
       */
      @header("x-ms-version")
      version: Versions;

      /**
       * Provides a client-generated, opaque value with a 1 KB character limit that is
       * recorded in the analytics logs when storage analytics logging is enabled.
       */
      @header
      requestId?: string;
    },
    void
  >;

  /**
   * operation permanently deletes the specified queue
   */
  @operationId("Queue_Delete")
  @route("/{queueName}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * The queue name.
       */
      @path
      queueName: string;

      /**
       * The The timeout parameter is expressed in seconds. For more information, see <a
       * href="https://learn.microsoft.com/rest/api/storageservices/setting-timeouts-for-queue-service-operations>Setting
       * Timeouts for Queue Service Operations.</a>
       */
      @query("timeout")
      timeout?: int32;

      /**
       * Specifies the version of the operation to use for this request.
       */
      @header("x-ms-version")
      version: Versions;

      /**
       * Provides a client-generated, opaque value with a 1 KB character limit that is
       * recorded in the analytics logs when storage analytics logging is enabled.
       */
      @header
      requestId?: string;
    },
    void
  >;

  /**
   * Retrieves user-defined metadata and queue properties on the specified queue.
   * Metadata is associated with the queue as name-values pairs.
   */
  @operationId("Queue_GetProperties")
  @route("/{queueName}?comp=metadata")
  @get
  getProperties is Azure.Core.Foundations.Operation<
    {
      /**
       * The queue name.
       */
      @path
      queueName: string;

      /**
       * The The timeout parameter is expressed in seconds. For more information, see <a
       * href="https://learn.microsoft.com/rest/api/storageservices/setting-timeouts-for-queue-service-operations>Setting
       * Timeouts for Queue Service Operations.</a>
       */
      @query("timeout")
      timeout?: int32;

      /**
       * Specifies the version of the operation to use for this request.
       */
      @header("x-ms-version")
      version: Versions;

      /**
       * Provides a client-generated, opaque value with a 1 KB character limit that is
       * recorded in the analytics logs when storage analytics logging is enabled.
       */
      @header
      requestId?: string;
    },
    void
  >;

  /**
   * sets user-defined metadata on the specified queue. Metadata is associated with
   * the queue as name-value pairs.
   */
  @operationId("Queue_SetMetadata")
  @route("/{queueName}?comp=metadata")
  @put
  setMetadata is Azure.Core.Foundations.Operation<
    {
      /**
       * The queue name.
       */
      @path
      queueName: string;

      /**
       * The The timeout parameter is expressed in seconds. For more information, see <a
       * href="https://learn.microsoft.com/rest/api/storageservices/setting-timeouts-for-queue-service-operations>Setting
       * Timeouts for Queue Service Operations.</a>
       */
      @query("timeout")
      timeout?: int32;

      /**
       * Optional. Include this parameter to specify that the queue's metadata be
       * returned as part of the response body. Note that metadata requested with this
       * parameter must be stored in accordance with the naming restrictions imposed by
       * the 2009-09-19 version of the Queue service. Beginning with this version, all
       * metadata names must adhere to the naming conventions for C# identifiers.
       */
      @alternateType(Record<string>, "rust")
      @header("x-ms-meta")
      metadata?: string;

      /**
       * Specifies the version of the operation to use for this request.
       */
      @header("x-ms-version")
      version: Versions;

      /**
       * Provides a client-generated, opaque value with a 1 KB character limit that is
       * recorded in the analytics logs when storage analytics logging is enabled.
       */
      @header
      requestId?: string;
    },
    void
  >;

  /**
   * returns details about any stored access policies specified on the queue that
   * may be used with Shared Access Signatures.
   */
  @operationId("Queue_GetAccessPolicy")
  @route("/{queueName}?comp=acl")
  @get
  getAccessPolicy is Azure.Core.Foundations.Operation<
    {
      /**
       * The queue name.
       */
      @path
      queueName: string;

      /**
       * The The timeout parameter is expressed in seconds. For more information, see <a
       * href="https://learn.microsoft.com/rest/api/storageservices/setting-timeouts-for-queue-service-operations>Setting
       * Timeouts for Queue Service Operations.</a>
       */
      @query("timeout")
      timeout?: int32;

      /**
       * Specifies the version of the operation to use for this request.
       */
      @header("x-ms-version")
      version: Versions;

      /**
       * Provides a client-generated, opaque value with a 1 KB character limit that is
       * recorded in the analytics logs when storage analytics logging is enabled.
       */
      @header
      requestId?: string;
    },
    ListOfSignedIdentifier
  >;

  /**
   * sets stored access policies for the queue that may be used with Shared Access
   * Signatures
   */
  @operationId("Queue_SetAccessPolicy")
  @route("/{queueName}?comp=acl")
  @put
  setAccessPolicy is Azure.Core.Foundations.Operation<
    {
      /**
       * The queue name.
       */
      @path
      queueName: string;

      /**
       * The The timeout parameter is expressed in seconds. For more information, see <a
       * href="https://learn.microsoft.com/rest/api/storageservices/setting-timeouts-for-queue-service-operations>Setting
       * Timeouts for Queue Service Operations.</a>
       */
      @query("timeout")
      timeout?: int32;

      /**
       * Specifies the version of the operation to use for this request.
       */
      @header("x-ms-version")
      version: Versions;

      /**
       * Provides a client-generated, opaque value with a 1 KB character limit that is
       * recorded in the analytics logs when storage analytics logging is enabled.
       */
      @header
      requestId?: string;

      /**
       * the acls for the queue
       */
      @bodyRoot
      listOfSignedIdentifier?: ListOfSignedIdentifier;
    },
    void
  >;
}

interface MessagesOperationGroup {
  /**
   * The Dequeue operation retrieves one or more messages from the front of the
   * queue.
   */
  @operationId("Messages_Dequeue")
  @route("/{queueName}/messages")
  @get
  dequeue is Azure.Core.Foundations.Operation<
    {
      /**
       * The queue name.
       */
      @path
      queueName: string;

      /**
       * Optional. A nonzero integer value that specifies the number of messages to
       * retrieve from the queue, up to a maximum of 32. If fewer are visible, the
       * visible messages are returned. By default, a single message is retrieved from
       * the queue with this operation.
       */
      @minValue(1)
      @query("numofmessages")
      numberOfMessages?: int32;

      /**
       * Optional. Specifies the new visibility timeout value, in seconds, relative to
       * server time. The default value is 30 seconds. A specified value must be larger
       * than or equal to 1 second, and cannot be larger than 7 days, or larger than 2
       * hours on REST protocol versions prior to version 2011-08-18. The visibility
       * timeout of a message can be set to a value later than the expiry time.
       */
      @maxValue(604800)
      @query("visibilityTimeout")
      visibilityTimeout?: int32;

      /**
       * The The timeout parameter is expressed in seconds. For more information, see <a
       * href="https://learn.microsoft.com/rest/api/storageservices/setting-timeouts-for-queue-service-operations>Setting
       * Timeouts for Queue Service Operations.</a>
       */
      @query("timeout")
      timeout?: int32;

      /**
       * Specifies the version of the operation to use for this request.
       */
      @header("x-ms-version")
      version: Versions;

      /**
       * Provides a client-generated, opaque value with a 1 KB character limit that is
       * recorded in the analytics logs when storage analytics logging is enabled.
       */
      @header
      requestId?: string;
    },
    ListOfDequeuedMessageItem
  >;

  /**
   * The Clear operation deletes all messages from the specified queue.
   */
  @operationId("Messages_Clear")
  @route("/{queueName}/messages")
  @delete
  clear is Azure.Core.Foundations.Operation<
    {
      /**
       * The queue name.
       */
      @path
      queueName: string;

      /**
       * The The timeout parameter is expressed in seconds. For more information, see <a
       * href="https://learn.microsoft.com/rest/api/storageservices/setting-timeouts-for-queue-service-operations>Setting
       * Timeouts for Queue Service Operations.</a>
       */
      @query("timeout")
      timeout?: int32;

      /**
       * Specifies the version of the operation to use for this request.
       */
      @header("x-ms-version")
      version: Versions;

      /**
       * Provides a client-generated, opaque value with a 1 KB character limit that is
       * recorded in the analytics logs when storage analytics logging is enabled.
       */
      @header
      requestId?: string;
    },
    void
  >;

  /**
   * The Enqueue operation adds a new message to the back of the message queue. A
   * visibility timeout can also be specified to make the message invisible until
   * the visibility timeout expires. A message must be in a format that can be
   * included in an XML request with UTF-8 encoding. The encoded message can be up
   * to 64 KB in size for versions 2011-08-18 and newer, or 8 KB in size for
   * previous versions.
   */
  @operationId("Messages_Enqueue")
  @route("/{queueName}/messages")
  @post
  enqueue is Azure.Core.Foundations.Operation<
    {
      /**
       * The queue name.
       */
      @path
      queueName: string;

      /**
       * Optional. If specified, the request must be made using an x-ms-version of
       * 2011-08-18 or later. If not specified, the default value is 0. Specifies the
       * new visibility timeout value, in seconds, relative to server time. The new
       * value must be larger than or equal to 0, and cannot be larger than 7 days. The
       * visibility timeout of a message cannot be set to a value later than the expiry
       * time. visibilityTimeout should be set to a value smaller than the time-to-live
       * value.
       */
      @maxValue(604800)
      @query("visibilityTimeout")
      visibilityTimeout?: int32;

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

      /**
       * The The timeout parameter is expressed in seconds. For more information, see <a
       * href="https://learn.microsoft.com/rest/api/storageservices/setting-timeouts-for-queue-service-operations>Setting
       * Timeouts for Queue Service Operations.</a>
       */
      @query("timeout")
      timeout?: int32;

      /**
       * Specifies the version of the operation to use for this request.
       */
      @header("x-ms-version")
      version: Versions;

      /**
       * Provides a client-generated, opaque value with a 1 KB character limit that is
       * recorded in the analytics logs when storage analytics logging is enabled.
       */
      @header
      requestId?: string;

      /**
       * A Message object which can be stored in a Queue
       */
      @bodyRoot
      queueMessage: QueueMessage;
    },
    ListOfEnqueuedMessage
  >;

  /**
   * The Peek operation retrieves one or more messages from the front of the queue,
   * but does not alter the visibility of the message.
   */
  @operationId("Messages_Peek")
  @route("/{queueName}/messages?peekonly=true")
  @get
  peek is Azure.Core.Foundations.Operation<
    {
      /**
       * The queue name.
       */
      @path
      queueName: string;

      /**
       * Optional. A nonzero integer value that specifies the number of messages to
       * retrieve from the queue, up to a maximum of 32. If fewer are visible, the
       * visible messages are returned. By default, a single message is retrieved from
       * the queue with this operation.
       */
      @minValue(1)
      @query("numofmessages")
      numberOfMessages?: int32;

      /**
       * The The timeout parameter is expressed in seconds. For more information, see <a
       * href="https://learn.microsoft.com/rest/api/storageservices/setting-timeouts-for-queue-service-operations>Setting
       * Timeouts for Queue Service Operations.</a>
       */
      @query("timeout")
      timeout?: int32;

      /**
       * Specifies the version of the operation to use for this request.
       */
      @header("x-ms-version")
      version: Versions;

      /**
       * Provides a client-generated, opaque value with a 1 KB character limit that is
       * recorded in the analytics logs when storage analytics logging is enabled.
       */
      @header
      requestId?: string;
    },
    ListOfPeekedMessageItem
  >;
}

interface MessageIdOperationGroup {
  /**
   * The Update operation was introduced with version 2011-08-18 of the Queue
   * service API. The Update Message operation updates the visibility timeout of a
   * message. You can also use this operation to update the contents of a message. A
   * message must be in a format that can be included in an XML request with UTF-8
   * encoding, and the encoded message can be up to 64KB in size.
   */
  @operationId("MessageId_Update")
  @route("/{queueName}/messages/{messageId}")
  @put
  update is Azure.Core.Foundations.Operation<
    {
      /**
       * The queue name.
       */
      @path
      queueName: string;

      /**
       * The container name.
       */
      @path
      messageId: string;

      /**
       * Required. Specifies the valid pop receipt value returned from an earlier call to the Get Messages or Update Message operation.
       */
      @query("popReceipt")
      popReceipt: string;

      /**
       * Optional. Specifies the new visibility timeout value, in seconds, relative to server time. The default value is 30 seconds. A specified value must be larger than or equal to 1 second, and cannot be larger than 7 days, or larger than 2 hours on REST protocol versions prior to version 2011-08-18. The visibility timeout of a message can be set to a value later than the expiry time.
       */
      @maxValue(604800)
      @query("visibilityTimeout")
      visibilityTimeout: int32;

      /**
       * The The timeout parameter is expressed in seconds. For more information, see <a
       * href="https://learn.microsoft.com/rest/api/storageservices/setting-timeouts-for-queue-service-operations>Setting
       * Timeouts for Queue Service Operations.</a>
       */
      @query("timeout")
      timeout?: int32;

      /**
       * Specifies the version of the operation to use for this request.
       */
      @header("x-ms-version")
      version: Versions;

      /**
       * Provides a client-generated, opaque value with a 1 KB character limit that is
       * recorded in the analytics logs when storage analytics logging is enabled.
       */
      @header
      requestId?: string;

      /**
       * A Message object which can be stored in a Queue
       */
      @bodyRoot
      queueMessage?: QueueMessage;
    },
    void
  >;

  /**
   * The Delete operation deletes the specified message.
   */
  @operationId("MessageId_Delete")
  @route("/{queueName}/messages/{messageId}")
  @delete
  delete is Azure.Core.Foundations.Operation<
    {
      /**
       * The queue name.
       */
      @path
      queueName: string;

      /**
       * The container name.
       */
      @path
      messageId: string;

      /**
       * Required. Specifies the valid pop receipt value returned from an earlier call to the Get Messages or Update Message operation.
       */
      @query("popReceipt")
      popReceipt: string;

      /**
       * The The timeout parameter is expressed in seconds. For more information, see <a
       * href="https://learn.microsoft.com/rest/api/storageservices/setting-timeouts-for-queue-service-operations>Setting
       * Timeouts for Queue Service Operations.</a>
       */
      @query("timeout")
      timeout?: int32;

      /**
       * Specifies the version of the operation to use for this request.
       */
      @header("x-ms-version")
      version: Versions;

      /**
       * Provides a client-generated, opaque value with a 1 KB character limit that is
       * recorded in the analytics logs when storage analytics logging is enabled.
       */
      @header
      requestId?: string;
    },
    void
  >;
}
