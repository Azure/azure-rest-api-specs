/*
  Definitions of elements defined for different TCP receivers.
*/

using OpenAPI;

namespace Microsoft.Monitor;

@doc("OTLP Receiver.")
model OtlpReceiver {
  @doc("OTLP GRPC endpoint definition. Example: 0.0.0.0:<port>")
  endpoint: string;
}
