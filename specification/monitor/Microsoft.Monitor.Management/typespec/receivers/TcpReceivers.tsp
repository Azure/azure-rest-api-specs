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

@doc("Receiver using UDP as transport protocol.")
model UdpReceiver is TcpReceiver {
  @doc("The encoding of the stream being received.")
  encoding?: StreamEncodingType = StreamEncodingType.nop;

  @doc("Max read queue length.")
  @minValue(100)
  @maxValue(100000)
  readQueueLength?: int32 = 1000;
}

@doc("Encoding types for streams.")
union StreamEncodingType {
  string,

  @doc("No encoding validation. Treats the file as a stream of raw bytes.")
  nop: "nop",

  @doc("UTF-8 encoding.")
  utf_8: "utf-8",

  @doc("UTF-16 encoding with little-endian byte order.")
  utf_16le: "utf-16le",

  @doc("UTF-16 encoding with little-endian byte order.")
  utf_16be: "utf-16be",

  @doc("ASCII encoding.")
  ascii: "ascii",

  @doc("The Big5 Chinese character encoding.")
  big5: "big5",
}
