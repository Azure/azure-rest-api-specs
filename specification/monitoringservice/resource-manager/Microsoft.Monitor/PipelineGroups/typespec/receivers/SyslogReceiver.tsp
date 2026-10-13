/*
  Definitions of elements defined for different TCP receivers.
*/

using TypeSpec.Versioning;

namespace Microsoft.Monitor;

@doc("Base receiver using TCP as transport protocol.")
model SyslogReceiver {
  @doc("Syslog receiver endpoint definition. Example: 0.0.0.0:<port>.")
  @pattern("^[a-zA-Z0-9-\\.]+:[0-9]+$")
  endpoint: string;

  @doc("Protocol to parse syslog messages. Default rfc3164")
  @removed(Microsoft.Monitor.Versions.v2026_04_01)
  protocol?: SyslogProtocol = "rfc3164";

  @doc("List of allowed message formats for syslog/CEF ingestion. Default 'all'.")
  @added(Microsoft.Monitor.Versions.v2026_04_01)
  allowedFormats?: AllowedFormats[] = #["all"];

  @doc("Transport protocol. Default tcp.")
  @added(Microsoft.Monitor.Versions.v2025_03_01_preview)
  transportProtocol?: TransportProtocol = TransportProtocol.tcp;

  @doc("Configure the receiver to allow parsing of messages without the PRI header. Default false.")
  @added(Microsoft.Monitor.Versions.v2025_03_01_preview)
  allowSkipPriHeader?: boolean = false;
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

@doc("Supported literals for allowed syslog and CEF parsing formats.")
union AllowedFormats {
  string,

  @doc("Allow all supported syslog and CEF formats.")
  all: "all",

  @doc("Allow RFC3164 syslog messages.")
  syslogRfc3164: "syslogRfc3164",

  @doc("Allow RFC5424 syslog messages.")
  syslogRfc5424: "syslogRfc5424",

  @doc("Allow CEF payloads embedded in RFC3164 syslog messages.")
  cefRfc3164: "cefRfc3164",

  @doc("Allow CEF payloads embedded in RFC5424 syslog messages.")
  cefRfc5424: "cefRfc5424",

  @doc("Allow raw CEF payloads without syslog encapsulation.")
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
