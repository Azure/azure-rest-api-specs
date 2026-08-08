import "./Storage.tsp";

namespace Microsoft.EventGrid.SystemEvents;

const MicrosoftStorageDeltaSnapSnapshotGenerationSucceededExample: StorageDeltaSnapSnapshotGenerationSucceededEventData = #{
  jobId: "",
  accountName: "deltasnapstorageaccount",
  status: "Succeeded",
  dataRecordCount: "81",
  totalSizeBytes: "27459",
  snapshotCommitDurationMs: "670848",
  snapshotCreateTime: utcDateTime.fromISO("2026-07-23T19:06:24.0794200Z"),
  snapshotFinalizeTime: utcDateTime.fromISO("2026-07-23T19:17:34.9283110Z"),
  snapshotId: "130",
  operationType: "FULL_OVERWRITE",
  dataFileCount: "1",
  manifestCount: "1",
};
