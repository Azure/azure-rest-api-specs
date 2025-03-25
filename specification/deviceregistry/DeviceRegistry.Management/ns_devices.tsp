import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./common/provisioningState.tsp";
import "./common/deviceProperties.tsp";
import "./common/namespaceDevicePropertiesUpdate.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.DeviceRegistry;

@added(Versions.v2024_10_01_preview)
@parentResource(Namespace)
@doc("Namespace Devices Azure resource.")
model NamespaceDevice is TrackedResource<NamespaceDeviceProperties> {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-name-pattern" "existing api spec"
  @doc("Name of the device.")
  @key("deviceName")
  @segment("devices")
  @pattern("^[0-9a-zA-Z][a-zA-Z0-9-]*$")
  @path
  @minLength(3)
  @maxLength(64)
  name: string;

  // etag not included in TrackedResource
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Resource Tag.")
  @visibility(Lifecycle.Read)
  etag?: string;
}

@added(Versions.v2024_10_01_preview)
@doc("Device messaging endpoint model.")
model DeviceMessagingEndpoint {
  @doc("Type of connection used for the messaging endpoint.")
  type?: string;
}

@added(Versions.v2024_10_01_preview)
@doc("Device messaging endpoints collections model.")
model MessagingEndpoints {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  @doc("Dictionary of actively used messaging endpoints a used to connect to services.")
  assigned: Record<DeviceMessagingEndpoint>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  @doc("Dictionary of most recently removed messaging endpoints.")
  unassigned?: Record<DeviceMessagingEndpoint>;
}

@added(Versions.v2024_10_01_preview)
@armResourceOperations
interface NamespaceDevices {
  get is ArmResourceRead<NamespaceDevice>;
  createOrReplace is ArmResourceCreateOrReplaceAsync<NamespaceDevice>;
  update is ArmCustomPatchAsync<
    NamespaceDevice,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      NamespaceDevice,
      NamespaceDevicePropertiesUpdate
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<NamespaceDevice>;
  listByResourceGroup is ArmResourceListByParent<NamespaceDevice>;
  listBySubscription is ArmListBySubscription<NamespaceDevice>;
}
