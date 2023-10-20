/*
  Definitions of elements defined for different TCP receivers.
*/

using OpenAPI;

namespace Microsoft.Monitor;

@doc("Base receiver using TCP as transport protocol.")
model TcpReceiver {
  @doc("TCP port to listen for packages.")
  port: int32;
}
