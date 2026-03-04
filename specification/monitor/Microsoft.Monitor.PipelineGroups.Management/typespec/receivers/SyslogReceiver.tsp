/*
  Definitions of elements defined for different TCP receivers.
*/

using TypeSpec.Versioning;
using OpenAPI;

namespace Microsoft.Monitor;

@doc("Base receiver using TCP as transport protocol.")
model SyslogReceiver {
  @doc("Syslog receiver endpoint definition. Example: 0.0.0.0:<port>.")
  @pattern("^[a-zA-Z0-9-\\.]+:[0-9]+$")
  endpoint: string;

  @doc("Protocol to parse syslog messages. Default rfc3164")
  @removed(Microsoft.Monitor.Versions.v2026_04_01)
  protocol?: SyslogProtocol = "rfc3164";

  @doc("List of allowed message parsing types. Use this to restrict ingestion to specific RFC formats (for example, rfc5424 only) or allow a controlled migration (for example, rfc3164 + rfc5424). Default all.")
  @added(Microsoft.Monitor.Versions.v2026_04_01)
  allowedParsingTypes?: ParsingTypeKey[] = #["all"];

  @doc("Transport protocol. Default tcp.")
  @added(Microsoft.Monitor.Versions.v2025_03_01_preview)
  transportProtocol?: TransportProtocol = TransportProtocol.tcp;

  @doc("Configure the receiver to allow parsing of messages without the PRI header. Default false.")
  @added(Microsoft.Monitor.Versions.v2025_03_01_preview)
  @removed(Microsoft.Monitor.Versions.v2026_04_01)
  allowSkipPriHeader?: boolean = false;

  @doc("Control whether rfc3164-based messages without the PRI header are accepted. Set to false to enforce stricter ingestion and reject malformed or legacy messages without PRI. Only applicable when allowed parsing types include rfc3164-based formats. Default true.")
  @added(Microsoft.Monitor.Versions.v2026_04_01)
  allow3164WithoutPriHeader?: boolean = true;
}

@doc("The syslog protocol to parse messages.")
@removed(Microsoft.Monitor.Versions.v2026_04_01)
union SyslogProtocol {
  string,

  @doc("rfc3164 protocol.")
  rfc3164: "rfc3164",

  @doc("rfc5424 protocol.")
  rfc5424: "rfc5424",
}

@doc("Supported keys for allowed syslog/CEF parsing types.")
union ParsingTypeKey {
  string,

  @doc("Allow all supported syslog and CEF message formats.")
  all: "all",

  @doc("Allow rfc3164 messages.")
  rfc3164: "rfc3164",

  @doc("Allow rfc5424 messages.")
  rfc5424: "rfc5424",

  @doc("Allow CEF messages embedded in rfc3164 messages.")
  cefRfc3164: "cefRfc3164",

  @doc("Allow CEF messages embedded in rfc5424 messages.")
  cefRfc5424: "cefRfc5424",

  @doc("Allow raw CEF messages without syslog encapsulation.")
  rawCef: "rawCef",
}

@doc("The syslog receiver’s underlying transport protocol.")
@added(Microsoft.Monitor.Versions.v2025_03_01_preview)
union TransportProtocol {
  string,

  @doc("tcp protocol.")
  tcp: "tcp",

  @doc("udp protocol.")
  udp: "udp",
}
