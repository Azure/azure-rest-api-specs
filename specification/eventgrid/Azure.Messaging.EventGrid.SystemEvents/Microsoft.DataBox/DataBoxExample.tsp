import "./DataBox.tsp";
namespace Microsoft.EventGrid.SystemEvents;

const MicrosoftDataBoxCopyStartedExample: DataBoxCopyStartedEventData = #{
  serialNumber: "SampleSerialNumber",
  stageName: "CopyStarted",
  stageTime: utcDateTime.fromISO("2022-10-12T19:38:08.0218897Z"),
};

const MicrosoftDataBoxCopyCompletedExample: DataBoxCopyCompletedEventData = #{
  serialNumber: "SampleSerialNumber",
  stageName: "CopyCompleted",
  stageTime: utcDateTime.fromISO("2022-10-12T19:38:08.0218897Z"),
};

const MicrosoftDataBoxOrderCompletedExample: DataBoxOrderCompletedEventData = #{
  serialNumber: "SampleSerialNumber",
  stageName: "OrderCompleted",
  stageTime: utcDateTime.fromISO("2022-10-12T19:38:08.0218897Z"),
};
