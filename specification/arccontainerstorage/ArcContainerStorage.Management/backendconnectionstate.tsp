@doc("States of backend connection")
union BackendConnectionState {
  @doc("The backend connection is not initialized")
  Unknown: "Unknown",

  @doc("The backend connection is established")
  Connected: "Connected",

  @doc("The backend connection disconnected due to network error")
  Disconnected: "Disconnected due to network error",

  @doc("The backend connection disconnected due to auth error")
  AuthError: "Disconnected due to auth error",

  string,
}
