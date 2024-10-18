/*
  Definitions of elements defined for OTLP receiver.
*/

using OpenAPI;

namespace Microsoft.Monitor;

@doc("OTLP Receiver.")
model OtlpReceiver {
  @doc("OTLP GRPC endpoint definition. Example: 0.0.0.0:<port>.")
  @pattern("^[a-zA-Z0-9-\\.]+:[0-9]+$")
  endpoint: string;
}
