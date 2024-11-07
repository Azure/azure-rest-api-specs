import "@typespec/versioning";
using TypeSpec.Versioning;
/** Describes the schema of the Azure SignalR Service events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent. */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Modeling after service swagger."
namespace Microsoft.EventGrid.SystemEvents {
  const MicrosoftSignalRServiceClientConnectionConnectedExample: SignalRServiceClientConnectionConnectedEventData = #{
    timestamp: utcDateTime.fromISO("2019-06-10T18:41:00.9584103Z"),
    hubName: "chat",
    connectionId: "crH0uxVSvP61p5wkFY1x1A",
    userId: "user-eymwyo23",
  };
  /** Schema of the Data property of an EventGridEvent for a Microsoft.SignalRService.ClientConnectionConnected event. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Modeling after service swagger."
  @example(MicrosoftSignalRServiceClientConnectionConnectedExample)
  model SignalRServiceClientConnectionConnectedEventData {
    ...SignalRServiceBaseEventdata;
  }

  const MicrosoftSignalRServiceClientConnectionDisconnectedExample: SignalRServiceClientConnectionDisconnectedEventData = #{
    timestamp: utcDateTime.fromISO("2019-06-10T18:41:00.9584103Z"),
    hubName: "chat",
    connectionId: "crH0uxVSvP61p5wkFY1x1A",
    userId: "user-eymwyo23",
    errorMessage: "Internal server error.",
  };
  /** Schema of the Data property of an EventGridEvent for a Microsoft.SignalRService.ClientConnectionDisconnected event. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Modeling after service swagger."
  @example(MicrosoftSignalRServiceClientConnectionDisconnectedExample)
  model SignalRServiceClientConnectionDisconnectedEventData {
    ...SignalRServiceBaseEventdata;

    /** The message of error that cause the client connection disconnected. */
    errorMessage?: string;
  }

  alias SignalRServiceBaseEventdata = {
    /** The time at which the event occurred. */
    @madeRequired(ServiceApiVersions.v2024_01_01)
    timestamp: utcDateTime;

    /** The hub of connected client connection. */
    hubName: string;

    /** The connection Id of connected client connection. */
    connectionId: string;

    /** The user Id of connected client connection. */
    userId?: string;
  };
}
