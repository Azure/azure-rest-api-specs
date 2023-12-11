@doc("Describes the schema of the Azure Storage events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent.")
namespace EventGrid {
  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.Storage.BlobCreated event.")
  model StorageBlobCreatedEventData {
    @doc("The etag of the blob at the time this event was triggered.")
    eTag?: string;

    @doc("The offset of the blob in bytes.")
    contentOffset?: int64;

    ...StorageBaseEventData;

    @doc("An opaque string value representing the logical sequence of events for any particular blob name. Users can use standard string comparison to understand the relative sequence of two events on the same blob name.")
    sequencer?: string;

    ...StorageUrlBaseEventData;
    ...StorageBaseTypeData;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.Storage.BlobDeleted event.")
  model StorageBlobDeletedEventData {
    @doc("The path to the blob.")
    url?: string;

    ...StorageBaseEventData;

    @doc("An opaque string value representing the logical sequence of events for any particular blob name. Users can use standard string comparison to understand the relative sequence of two events on the same blob name.")
    sequencer?: string;

    ...StorageBaseTypeData;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.Storage.DirectoryCreated event.")
  model StorageDirectoryCreatedEventData {
    @doc("The etag of the directory at the time this event was triggered.")
    eTag?: string;

    @doc("The path to the directory.")
    url?: string;

    ...StorageBaseEventData;

    @doc("An opaque string value representing the logical sequence of events for any particular directory name. Users can use standard string comparison to understand the relative sequence of two events on the same directory name.")
    sequencer?: string;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.Storage.DirectoryDeleted event.")
  model StorageDirectoryDeletedEventData {
    @doc("The path to the deleted directory.")
    url?: string;

    @doc("Is this event for a recursive delete operation.")
    recursive?: string;

    ...StorageBaseEventData;

    @doc("An opaque string value representing the logical sequence of events for any particular directory name. Users can use standard string comparison to understand the relative sequence of two events on the same directory name.")
    sequencer?: string;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.Storage.BlobRenamed event.")
  model StorageBlobRenamedEventData {
    @doc("The path to the blob that was renamed.")
    sourceUrl?: string;

    @doc("The new path to the blob after the rename operation.")
    destinationUrl?: string;

    ...StorageBaseEventData;

    @doc("An opaque string value representing the logical sequence of events for any particular blob name. Users can use standard string comparison to understand the relative sequence of two events on the same blob name.")
    sequencer?: string;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.Storage.DirectoryRenamed event.")
  model StorageDirectoryRenamedEventData {
    @doc("The path to the directory that was renamed.")
    sourceUrl?: string;

    @doc("The new path to the directory after the rename operation.")
    destinationUrl?: string;

    ...StorageBaseEventData;

    @doc("An opaque string value representing the logical sequence of events for any particular directory name. Users can use standard string comparison to understand the relative sequence of two events on the same directory name.")
    sequencer?: string;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.Storage.LifecyclePolicyCompleted event.")
  model StorageLifecyclePolicyCompletedEventData {
    @doc("The time the policy task was scheduled.")
    scheduleTime?: string;

    @doc("Execution statistics of a specific policy action in a Blob Management cycle.")
    deleteSummary?: StorageLifecyclePolicyActionSummaryDetail;

    @doc("Execution statistics of a specific policy action in a Blob Management cycle.")
    tierToCoolSummary?: StorageLifecyclePolicyActionSummaryDetail;

    @doc("Execution statistics of a specific policy action in a Blob Management cycle.")
    tierToArchiveSummary?: StorageLifecyclePolicyActionSummaryDetail;
  }

  @doc("Execution statistics of a specific policy action in a Blob Management cycle.")
  model StorageLifecyclePolicyActionSummaryDetail {
    @doc("Total number of objects to be acted on by this action.")
    totalObjectsCount?: int64;

    @doc("Number of success operations of this action.")
    successCount?: int64;

    @doc("Error messages of this action if any.")
    errorList?: string;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.Storage.BlobTierChanged event.")
  model StorageBlobTierChangedEventData {
    ...StorageBaseEventData;

    @doc("An opaque string value representing the logical sequence of events for any particular blob name. Users can use standard string comparison to understand the relative sequence of two events on the same blob name.")
    sequencer?: string;

    ...StorageUrlBaseEventData;
    ...StorageBaseTypeData;
  }

  @doc("Schema of the Data property of an EventGridEvent for a Microsoft.Storage.AsyncOperationInitiated event.")
  model StorageAsyncOperationInitiatedEventData {
    ...StorageBaseEventData;

    @doc("An opaque string value representing the logical sequence of events for any particular blob name. Users can use standard string comparison to understand the relative sequence of two events on the same blob name.")
    sequencer?: string;

    ...StorageUrlBaseEventData;
    ...StorageBaseTypeData;
  }

  @doc("Schema of the Data property of an EventGridEvent for an Microsoft.Storage.BlobInventoryPolicyCompleted event.")
  model StorageBlobInventoryPolicyCompletedEventData {
    @doc("The time at which inventory policy was scheduled.")
    scheduleDateTime?: utcDateTime;

    @doc("The account name for which inventory policy is registered.")
    accountName?: string;

    @doc("The rule name for inventory policy.")
    ruleName?: string;

    @doc("The status of inventory run, it can be Succeeded/PartiallySucceeded/Failed.")
    policyRunStatus?: string;

    @doc("The status message for inventory run.")
    policyRunStatusMessage?: string;

    @doc("The policy run id for inventory run.")
    policyRunId?: string;

    @doc("The blob URL for manifest file for inventory run.")
    manifestBlobUrl?: string;
  }

  @doc("Schema of the Data property of an EventGridEvent for an Microsoft.Storage.StorageTaskCompleted event.")
  model StorageTaskCompletedEventData {
    @doc("The time at which a storage task was completed.")
    completedDateTime: utcDateTime;

    @doc("The status for a storage task.")
    status: StorageTaskCompletedStatus;

    @doc("The summary report blob url for a storage task")
    summaryReportBlobUrl: url;

    @doc("The execution id for a storage task.")
    taskExecutionId: string;

    @doc("The task name for a storage task.")
    taskName: string;
  }

  @doc("Schema of the Data property of an EventGridEvent for an Microsoft.Storage.StorageTaskQueued event.")
  model StorageTaskQueuedEventData {
    @doc("The time at which a storage task was queued.")
    queuedDateTime: utcDateTime;

    @doc("The execution id for a storage task.")
    taskExecutionId: string;
  }

  @doc("The status for a storage task.")
  enum StorageTaskCompletedStatus {
    @doc("Succeeded")
    Succeeded,

    @doc("Failed")
    Failed,
  }

  alias StorageBaseEventData = {
    @doc("The name of the API/operation that triggered this event.")
    api?: string;

    @doc("A request id provided by the client of the storage API operation that triggered this event.")
    clientRequestId?: string;

    @doc("The request id generated by the storage service for the storage API operation that triggered this event.")
    requestId?: string;

    @doc("The identity of the requester that triggered this event.")
    identity?: string;

    @doc("For service use only. Diagnostic data occasionally included by the Azure Storage service. This property should be ignored by event consumers.")
    storageDiagnostics?: Record<string>;
  };

  alias StorageBaseTypeData = {
    @doc("The content type of the blob. This is the same as what would be returned in the Content-Type header from the blob.")
    contentType?: string;

    @doc("The type of blob.")
    blobType?: string;
  };

  alias StorageUrlBaseEventData = {
    @doc("The size of the blob in bytes. This is the same as what would be returned in the Content-Length header from the blob.")
    contentLength?: int64;

    @doc("The path to the blob.")
    url?: string;
  };
}
