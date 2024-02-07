#suppress "@azure-tools/typespec-azure-core/casing-style" "Modeling after service swagger."
/** Describes the schema of the Azure SignalR Service events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent. */
namespace Microsoft.EventGrid.SystemEvents {
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Modeling after service swagger."
  /** Schema of the Data property of an EventGridEvent for a Microsoft.SignalRService.ClientConnectionConnected event. */
  model SignalRServiceClientConnectionConnectedEventData {
    ...SignalRServiceBaseEventdata;
  }

  #suppress "@azure-tools/typespec-azure-core/casing-style" "Modeling after service swagger."
  /** Schema of the Data property of an EventGridEvent for a Microsoft.SignalRService.ClientConnectionDisconnected event. */
  model SignalRServiceClientConnectionDisconnectedEventData {
    ...SignalRServiceBaseEventdata;

    /** The message of error that cause the client connection disconnected. */
    errorMessage?: string;
  }

  alias SignalRServiceBaseEventdata = {
    /** The time at which the event occurred. */
    timestamp?: utcDateTime;

    /** The hub of connected client connection. */
    hubName?: string;

    /** The connection Id of connected client connection. */
    connectionId?: string;

    /** The user Id of connected client connection. */
    userId?: string;
  };
}
