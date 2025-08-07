import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
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
  @visibility(Lifecycle.Read, Lifecycle.Create)
  extendedLocation: ExtendedLocation;

  ...ManagedServiceIdentityProperty;
}

@doc("The Instance update model.")
model InstancePatchModel {
  ...Azure.ResourceManager.Foundations.ArmTagsProperty;
  ...ManagedServiceIdentityProperty;
}

@doc("The properties of the Instance resource.")
model InstanceProperties {
  @doc("Detailed description of the Instance.")
  description?: string;

  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("The Azure IoT Operations version.")
  @visibility(Lifecycle.Read)
  version?: string;

  @doc("The reference to the Schema Registry for this AIO Instance.")
  schemaRegistryRef: SchemaRegistryRef;

  @doc("The reference to the AIO Secret provider class.")
  @added(Versions.`2025-07-01-preview`)
  defaultSecretProviderClassRef?: SecretProviderClassRef;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  @doc("The features of the AIO Instance.")
  @added(Versions.`2025-04-01`)
  features?: Record<InstanceFeature>;

  @doc("The Azure Device Registry Namespace used by Assets, Discovered Assets and devices")
  @added(Versions.`2025-07-01-preview`)
  adrNamespaceRef?: AzureDeviceRegistryNamespaceRef;
}

@doc("The reference to the AIO Secret provider class.")
@added(Versions.`2025-07-01-preview`)
model SecretProviderClassRef {
  @doc("The resource ID of the AIO Secret provider class.")
  resourceId: SecretProviderClassID;
}

@doc("The features of the AIO Instance.")
@added(Versions.`2025-04-01`)
model InstanceFeature {
  @doc("The state of the feature.")
  mode?: InstanceFeatureMode;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  @doc("The settings of the feature.")
  settings?: Record<OperationalMode>;
}

@doc("The enum defining mode of a feature.")
@added(Versions.`2025-04-01`)
union InstanceFeatureMode {
  string,

  @doc("Opt in to enable a stable feature")
  "Stable",

  @doc("Opt in to enable a preview feature")
  "Preview",

  @doc("Opt out of a feature")
  "Disabled",
}

@doc("The reference to the Schema Registry for this AIO Instance.")
model SchemaRegistryRef {
  @doc("The resource ID of the Schema Registry.")
  resourceId: SchemaRegistryID;
}

@doc("Azure Device Registry Namespace reference.")
@added(Versions.`2025-07-01-preview`)
model AzureDeviceRegistryNamespaceRef {
  @doc("The resource ID of the Azure Device Registry Namespace.")
  resourceId: AzureDeviceRegistryNamespaceID;
}
