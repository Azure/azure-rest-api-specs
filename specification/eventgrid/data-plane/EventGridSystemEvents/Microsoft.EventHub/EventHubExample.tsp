import "./EventHub.tsp";
namespace Microsoft.EventGrid.SystemEvents;

const MicrosoftEventHubCaptureFileCreatedExample: EventHubCaptureFileCreatedEventData = #{
  fileUrl: "https://tf0831datamigrate.blob.core.windows.net/windturbinecapture/tfdatamigratens/hubdatamigration/1/2017/08/31/19/11/45.avro",
  fileType: "AzureBlockBlob",
  partitionId: "1",
  sizeInBytes: 249168,
  eventCount: 1500,
  firstSequenceNumber: 2400,
  lastSequenceNumber: 3899,
  firstEnqueueTime: utcDateTime.fromISO("2017-08-31T19:12:14.674Z"),
  lastEnqueueTime: utcDateTime.fromISO("2017-08-31T19:12:44.309Z"),
};
