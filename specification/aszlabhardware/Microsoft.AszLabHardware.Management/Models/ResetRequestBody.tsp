@doc("The commands relating to power state")
union ResetType {
  @doc("Gracefully restart server")
  GracefulRestart: "GracefulRestart",

  @doc("Gracefully shut down server")
  GracefulShutdown: "GracefulShutdown",

  @doc("Force shut down server")
  ForceOff: "ForceOff",

  @doc("Turn server on")
  On: "On",

  @doc("Force restart server")
  ForceRestart: "ForceRestart",

  string,
}

@doc("The request body model of a reset POST call")
model ResetRequestBody {
  @doc("The enum describing the power state")
  resetType: ResetType;
}
