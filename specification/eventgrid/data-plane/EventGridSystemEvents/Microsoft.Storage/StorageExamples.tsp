import "./Storage.tsp";

namespace Microsoft.EventGrid.SystemEvents;

const StorageOperationFailedForReplicationExample: StorageOperationFailedForReplicationEventData = #{
  api: "PutBlob",
  eventType: "BlobCreated",
  timestamp: utcDateTime.fromISO("2026-09-03T22:30:00Z"),
  blobVersion: "2026-09-03T22:30:00.0000000Z",
  policyId: "2a65f2bb-0d93-465a-a189-96e3e7127c8f",
  destinationBlob: "destinationaccount/destinationcontainer/path/to/blob.txt",
  failureReason: "DstBlobImmutable",
};
