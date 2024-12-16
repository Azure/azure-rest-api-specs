import "@azure-tools/typespec-azure-core";
import "@typespec/versioning";
import "./topic.tsp";

using Azure.Core;
using TypeSpec.Versioning;

namespace Microsoft.DeviceRegistry;

@doc("Object that describes the topic update information.")
@added(Versions.v2024_10_01_preview)
model TopicUpdate {
  @doc("The topic path for messages published to an MQTT broker.")
  path: string;

  @doc("When set to 'Keep', messages published to an MQTT broker will have the retain flag set. Default: 'Never'.")
  retain?: TopicRetainType;
}
