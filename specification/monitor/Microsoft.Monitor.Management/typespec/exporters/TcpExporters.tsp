/*
  Definitions of elements defined for different TCP exporters.
*/

using OpenAPI;

namespace Microsoft.Monitor;

@doc("Base exporter using TCP as transport protocol.")
model TcpExporter {
  @doc("TCP url to export.")
  @pattern("^(https?)://[a-zA-Z0-9-]+(\\.[a-zA-Z0-9-]+)*$")
  url: string;
}
