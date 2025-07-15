import "@azure-tools/typespec-azure-core";
import "@typespec/versioning";

using TypeSpec.Versioning;

namespace Microsoft.DeviceRegistry;

@doc("Topic retain types.")
@added(Versions.v2024_07_01_preview)
union TopicRetainType {
  @doc("Retain messages.")
  Keep: "Keep",

  @doc("Never retain messages.")
  Never: "Never",

  string,
}

@doc("Object that describes the topic information.")
@added(Versions.v2024_07_01_preview)
@removed(Versions.v2025_07_01_preview)
model Topic {
  @doc("The topic path for messages published to an MQTT broker.")
  path: string;

  @doc("When set to 'Keep', messages published to an MQTT broker will have the retain flag set. Default: 'Never'.")
  retain?: TopicRetainType = TopicRetainType.Never;
}
