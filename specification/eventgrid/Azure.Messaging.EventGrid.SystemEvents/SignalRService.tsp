/** Describes the schema of the Azure SignalR Service events published to Azure Event Grid. This corresponds to the Data property of an EventGridEvent. */
#suppress "@azure-tools/typespec-azure-core/casing-style" "Modeling after service swagger."
namespace Microsoft.EventGrid.SystemEvents {
  /** Schema of the Data property of an EventGridEvent for a Microsoft.SignalRService.ClientConnectionConnected event. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Modeling after service swagger."
  model SignalRServiceClientConnectionConnectedEventData {
    ...SignalRServiceBaseEventdata;
  }

  /** Schema of the Data property of an EventGridEvent for a Microsoft.SignalRService.ClientConnectionDisconnected event. */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Modeling after service swagger."
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
