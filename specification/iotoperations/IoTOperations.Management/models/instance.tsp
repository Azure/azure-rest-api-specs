import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Microsoft.IoTOperations;

@doc("A Instance resource is a logical container for a set of child resources.")
model InstanceResource is TrackedResource<InstanceProperties> {
  @doc("Name of instance.")
  @key("instanceName")
  @segment("instances")
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @path
  @minLength(3)
  @maxLength(63)
  name: string;

  // Extended location is not included in TrackedResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;

  ...ManagedServiceIdentityProperty;
}

@doc("The Instance update model.")
model InstancePatchModel {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;

  // Ideally we should spread the ManagedServiceIdentityProperty here, but
  // the generated schema defines this as a new definition which the ARM
  // specs don't like very much.
  ...ManagedServiceIdentityUpdate;
}

model ManagedServiceIdentityUpdate
  is OptionalProperties<UpdateableProperties<PickProperties<
    InstanceResource,
    "identity"
  >>>;
@doc("The properties of the Instance resource.")
model InstanceProperties {
  @doc("Detailed description of the Instance.")
  description?: string;

  @doc("The status of the last operation.")
  @visibility("read")
  provisioningState?: ProvisioningState;

  @doc("The Azure IoT Operations version.")
  @visibility("read")
  version?: string;

  @doc("The reference to the Schema Registry for this AIO Instance.")
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  schemaRegistryNamespace: string;

  @doc("The service accounts to be used for federated credentials.")
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", [])
  serviceAccounts?: ServiceAccountProperties[] = #[];

  @doc("The configuration for components of the AIO Instance.")
  components?: Components = #{};
}

@doc("The configuration for components of the AIO Instance.")
model Components {
  @doc("The properties of the ADR instance.")
  adr?: AdrProperties = #{ enabled: true };

  @doc("The properties of the AKRI instance.")
  akri?: AkriInstanceProperties = #{ enabled: true };

  @doc("The properties of the connectors instance.")
  connectors?: ConnectorInstanceProperties = #{ enabled: true };

  @doc("The properties of the dataflows instance.")
  dataflows?: DataFlowInstanceProperties = #{ enabled: true };

  @doc("The properties of the device provisioning instance.")
  mqttbroker?: MqttBrokerInstanceProperties = #{ enabled: true };

  @doc("The properties of the device provisioning instance.")
  schemaregistry?: SchemaRegistryInstanceProperties = #{ enabled: true };
}

@doc("The properties of a Service Account.")
model ServiceAccountProperties {
  @doc("The name of the service account.")
  name: string;

  @doc("The namespace of the service account.")
  `namespace`: string;
}

@doc("The properties of an ADR instance.")
model AdrProperties {
  @doc("This determines if the ADR service is enabled.")
  enabled: boolean;
}
@doc("The properties of an AKRI instance.")
model AkriInstanceProperties {
  @doc("This determines if the AKRI service is enabled.")
  enabled: boolean;
}

@doc("The properties of a  Connector instance.")
model ConnectorInstanceProperties {
  @doc("This determines if the Connector service is enabled.")
  enabled: boolean;
}

@doc("The properties of an DataFlow instance.")
model DataFlowInstanceProperties {
  @doc("This determines if the DataFlow service is enabled.")
  enabled: boolean;
}

@doc("The properties of an MQTT Broker instance.")
model MqttBrokerInstanceProperties {
  @doc("This determines if the MQTT Broker service is enabled.")
  enabled: boolean;
}

@doc("The properties of a Schema Registry instance.")
model SchemaRegistryInstanceProperties {
  @doc("This determines if the Schema Registry service is enabled.")
  enabled: boolean;
}
