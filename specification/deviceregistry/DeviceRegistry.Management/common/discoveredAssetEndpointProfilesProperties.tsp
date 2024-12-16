import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./extendedLocation.tsp";
import "./provisioningState.tsp";
import "./authenticationMethod.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

namespace Microsoft.DeviceRegistry;

@doc("Defines the Discovered Asset Endpoint Profile properties.")
@added(Versions.v2024_07_01_preview)
model DiscoveredAssetEndpointProfileProperties {
  @doc("The local valid URI specifying the network address/DNS name of a southbound device. The scheme part of the targetAddress URI specifies the type of the device. The additionalConfiguration field holds further connector type specific configuration.")
  targetAddress: url;

  @doc("Stringified JSON that contains connectivity type specific further configuration (e.g. OPC UA, Modbus, ONVIF).")
  additionalConfiguration?: string;

  @doc("List of supported authentication methods supported by the target server.")
  @extension("x-ms-identifiers", [])
  supportedAuthenticationMethods?: AuthenticationMethod[];

  @doc("Defines the configuration for the connector type that is being used with the endpoint profile.")
  endpointProfileType: string;

  @doc("Identifier used to detect changes in the asset endpoint profile.")
  discoveryId: string;

  @doc("An integer that is incremented each time the resource is modified.")
  version: int64;

  @doc("Provisioning state of the resource.")
  @visibility("read")
  provisioningState?: ProvisioningState;
}
