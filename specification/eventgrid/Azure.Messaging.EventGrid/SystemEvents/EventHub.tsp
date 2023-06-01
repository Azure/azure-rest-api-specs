@doc("Describes the schema of the Azure EventHub events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent.")
namespace EventGrid.EventHub;

@doc("Schema of the Data property of an EventGridEvent for a Microsoft.EventHub.CaptureFileCreated event.")
model EventHubCaptureFileCreatedEventData {
  @doc("The path to the capture file.")
  fileUrl?: string;

  @doc("The file type of the capture file.")
  fileType?: string;

  @doc("The shard ID.")
  partitionId?: string;

  @doc("The file size.")
  sizeInBytes?: int64;

  @doc("The number of events in the file.")
  eventCount?: int64;

  @doc("The smallest sequence number from the queue.")
  firstSequenceNumber?: int64;

  @doc("The last sequence number from the queue.")
  lastSequenceNumber?: int64;

  @doc("The first time from the queue.")
  firstEnqueueTime?: utcDateTime;

  @doc("The last time from the queue.")
  lastEnqueueTime?: utcDateTime;
}
