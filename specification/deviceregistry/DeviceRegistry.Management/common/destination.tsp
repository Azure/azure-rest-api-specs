import "@azure-tools/typespec-azure-core";
import "@typespec/versioning";
import "./topic.tsp";

using TypeSpec.Versioning;

namespace Microsoft.DeviceRegistry;

// Polymorphic Destinations
@discriminator("target")
@added(Versions.v2025_07_01_preview)
@doc("The type of the destination.")
model DatasetDestination {
  @doc("Target destination.")
  target?: DatasetDestinationTarget;
}

@discriminator("target")
@added(Versions.v2025_07_01_preview)
@doc("The type of the destination.")
model EventDestination {
  @doc("Target destination.")
  target?: EventDestinationTarget;
}

@discriminator("target")
@added(Versions.v2025_07_01_preview)
@doc("The type of the destination.")
model StreamDestination {
  @doc("Target destination.")
  target?: StreamDestinationTarget;
}

@doc("The set of supported dataset destinations for an asset.")
@added(Versions.v2025_07_01_preview)
union DatasetDestinationTarget {
  @doc("MQTT target.")
  Mqtt: "Mqtt",

  @doc("Broker State Store target.")
  BrokerStateStore: "BrokerStateStore",

  @doc("Storage target.")
  Storage: "Storage",

  string,
}

@doc("The set of supported event destinations for an asset.")
@added(Versions.v2025_07_01_preview)
union EventDestinationTarget {
  @doc("MQTT target.")
  Mqtt: "Mqtt",

  @doc("Storage target.")
  Storage: "Storage",

  string,
}

@doc("The set of supported stream destinations for an asset.")
@added(Versions.v2025_07_01_preview)
union StreamDestinationTarget {
  @doc("MQTT target.")
  Mqtt: "Mqtt",

  @doc("Storage target.")
  Storage: "Storage",

  string,
}

@doc("The type for a MQTT destination.")
@added(Versions.v2025_07_01_preview)
model DatasetMqttDestination extends DatasetDestination {
  @doc("The MQTT destination type.")
  target: DatasetDestinationTarget.Mqtt;

  @doc("The MQTT destination configuration.")
  configuration: MqttDestinationConfiguration;
}

@doc("The type for a MQTT destination.")
@added(Versions.v2025_07_01_preview)
model EventMqttDestination extends EventDestination {
  @doc("The MQTT destination type.")
  target: EventDestinationTarget.Mqtt;

  @doc("The MQTT destination configuration.")
  configuration: MqttDestinationConfiguration;
}

@doc("The type for a MQTT destination.")
@added(Versions.v2025_07_01_preview)
model StreamMqttDestination extends StreamDestination {
  @doc("The MQTT destination type.")
  target: StreamDestinationTarget.Mqtt;

  @doc("The MQTT destination configuration.")
  configuration: MqttDestinationConfiguration;
}

@doc("The configuration for a MQTT destination.")
@added(Versions.v2025_07_01_preview)
model MqttDestinationConfiguration {
  @doc("The MQTT topic.")
  topic: string;

  @doc("When set to 'Keep', messages published to an MQTT broker will have the retain flag set. Default: 'Never'.")
  retain?: TopicRetainType = TopicRetainType.Never;

  @doc("The MQTT QoS setting. Defaults to QoS 1.")
  qos?: MqttDestinationQos = MqttDestinationQos.Qos1;

  @doc("The MQTT TTL setting.")
  ttl?: int64;
}

@doc("The configuration for a storage destination.")
@added(Versions.v2025_07_01_preview)
model StorageDestinationConfiguration {
  @doc("The storage destination path.")
  path: string;
}

@doc("The configuration for a MQTT broker state store destination.")
@added(Versions.v2025_07_01_preview)
model BrokerStateStoreDestinationConfiguration {
  @doc("The MQTT broker state store destination key.")
  key: string;
}

@doc("The set of supported QoS types for a MQTT destination.")
@added(Versions.v2025_07_01_preview)
union MqttDestinationQos {
  @doc("QoS 0.")
  Qos0: "Qos0",

  @doc("QoS 1.")
  Qos1: "Qos1",

  string,
}

@doc("The type for a MQTT broker state store destination.")
@added(Versions.v2025_07_01_preview)
model DatasetBrokerStateStoreDestination extends DatasetDestination {
  @doc("The MQTT broker state store destination target.")
  target: DatasetDestinationTarget.BrokerStateStore;

  @doc("The MQTT broker state store destination configuration.")
  configuration: BrokerStateStoreDestinationConfiguration;
}

@doc("The type for a storage destination.")
@added(Versions.v2025_07_01_preview)
model DatasetStorageDestination extends DatasetDestination {
  @doc("The storage destination type.")
  target: DatasetDestinationTarget.Storage;

  @doc("The storage destination configuration.")
  configuration: StorageDestinationConfiguration;
}

@doc("The type for a storage destination.")
@added(Versions.v2025_07_01_preview)
model EventStorageDestination extends EventDestination {
  @doc("The storage destination type.")
  target: EventDestinationTarget.Storage;

  @doc("The storage destination configuration.")
  configuration: StorageDestinationConfiguration;
}

@doc("The type for a storage destination.")
@added(Versions.v2025_07_01_preview)
model StreamStorageDestination extends StreamDestination {
  @doc("The storage destination type.")
  target: StreamDestinationTarget.Storage;

  @doc("The storage destination configuration.")
  configuration: StorageDestinationConfiguration;
}
