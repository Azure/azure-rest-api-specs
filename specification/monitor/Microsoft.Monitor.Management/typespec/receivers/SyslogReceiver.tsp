/*
  Definitions of elements defined for different TCP receivers.
*/

using OpenAPI;

namespace Microsoft.Monitor;

@doc("Base receiver using TCP as transport protocol.")
model SyslogReceiver {
  @doc("Syslog receiver endpoint definition. Example: 0.0.0.0:<port>.")
  @pattern("^[a-zA-Z0-9-\\.]+:[0-9]+$")
  endpoint: string;

  @doc("Protocol to parse syslog messages. Default rfc3164")
  protocol?: SyslogProtocol = SyslogProtocol.rfc3164;
}

@doc("The syslog protocol to parse messages.")
union SyslogProtocol {
  string,

  @doc("rfc3164 protocol.")
  rfc3164: "rfc3164",

  @doc("rfc5424 protocol.")
  rfc5424: "rfc5424",
}
