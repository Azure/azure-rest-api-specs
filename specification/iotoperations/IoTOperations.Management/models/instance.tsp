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

@doc("The properties of a Instance resource.")
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
  serviceAccounts?: ServiceAccountProperties[];
}

@doc("The properties of a Service Account.")
model ServiceAccountProperties {
  @doc("The name of the service account.")
  name: string;

  @doc("The namespace of the service account.")
  `namespace`: string;
}
