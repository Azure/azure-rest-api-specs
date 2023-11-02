/*
  Definitions of elements defined for different TCP receivers.
*/

using OpenAPI;

namespace Microsoft.Monitor;

@doc("Base receiver using TCP as transport protocol.")
model TcpReceiver {
  @doc("TCP endpoint definition. Example: 0.0.0.0:<port>.")
  @pattern("^[a-zA-Z0-9-\\.]+:[0-9]+$")
  endpoint: string;
}
