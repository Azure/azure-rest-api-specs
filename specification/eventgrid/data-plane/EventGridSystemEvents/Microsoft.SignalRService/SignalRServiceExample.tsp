import "./SignalRService.tsp";

namespace Microsoft.EventGrid.SystemEvents;

const MicrosoftSignalRServiceClientConnectionConnectedExample: SignalRServiceClientConnectionConnectedEventData = #{
  timestamp: utcDateTime.fromISO("2019-06-10T18:41:00.9584103Z"),
  hubName: "chat",
  connectionId: "crH0uxVSvP61p5wkFY1x1A",
  userId: "user-eymwyo23",
};

const MicrosoftSignalRServiceClientConnectionDisconnectedExample: SignalRServiceClientConnectionDisconnectedEventData = #{
  timestamp: utcDateTime.fromISO("2019-06-10T18:41:00.9584103Z"),
  hubName: "chat",
  connectionId: "crH0uxVSvP61p5wkFY1x1A",
  userId: "user-eymwyo23",
  errorMessage: "Internal server error.",
};
