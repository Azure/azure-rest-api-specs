import "./ServerHardware.tsp";
import "./Manager.tsp";

@doc("The hardware information about the server")
model HardwareInfo {
  @visibility(Lifecycle.Read)
  @doc("Information about the hardware components")
  server?: ServerHardware;

  @visibility(Lifecycle.Read)
  @doc("Information about the BMC")
  manager?: Manager;

  @visibility(Lifecycle.Read)
  @doc("The time at which the hardware information was refreshed")
  refreshedAt?: utcDateTime;
}
