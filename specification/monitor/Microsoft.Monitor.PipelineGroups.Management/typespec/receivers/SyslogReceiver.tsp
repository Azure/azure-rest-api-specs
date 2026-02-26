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
  protocol?: SyslogProtocol = SyslogProtocol.rfc3164;

  @doc("Transport protocol. Default tcp.")
  @added(Microsoft.Monitor.Versions.v2025_03_01_preview)
  transportProtocol?: TransportProtocol = TransportProtocol.tcp;

  @doc("Configure the receiver to allow parsing of messages without the PRI header. Default false.")
  @added(Microsoft.Monitor.Versions.v2025_03_01_preview)
  allowSkipPriHeader?: boolean = false;
}

@doc("The syslog protocol to parse messages.")
union SyslogProtocol {
  string,

  @doc("rfc3164 protocol.")
  rfc3164: "rfc3164",

  @doc("rfc5424 protocol.")
  rfc5424: "rfc5424",
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
