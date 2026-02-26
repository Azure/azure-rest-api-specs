/*
  Definitions of elements defined for different TCP exporters.
*/

using TypeSpec.Versioning;

namespace Microsoft.Monitor;

// Unsupported exporter type
@doc("Base exporter using TCP as transport protocol.")
@removed(Microsoft.Monitor.Versions.v2025_03_01_preview)
model TcpExporter {
  @doc("TCP url to export.")
  @pattern("^(https?)://[a-zA-Z0-9-]+(\\.[a-zA-Z0-9-]+)*$")
  url: string;
}
