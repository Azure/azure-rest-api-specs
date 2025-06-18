import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "../common/extendedLocation.tsp";
import "../common/provisioningState.tsp";
import "../common/authenticationMethod.tsp";

using TypeSpec.Versioning;

namespace Microsoft.DeviceRegistry;

@doc("Defines the discovered device properties.")
@added(Versions.v2025_07_01_preview)
model NamespaceDiscoveredDeviceProperties {
  @doc("A device ID that represents the device in a system external to Azure. Unique within scope of an Azure tenant.")
  externalDeviceId?: string;

  @doc("Endpoints for discovered devices.")
  endpoints?: DiscoveredMessagingEndpoints;

  @doc("Device manufacturer.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  manufacturer?: string;

  @doc("Device model.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  `model`?: string;

  @doc("Device operating system name.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  operatingSystem?: string;

  @doc("Device operating system version.")
  operatingSystemVersion?: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  @doc("A set of key-value pairs that contain custom attributes.")
  attributes?: Record<unknown>;

  @doc("Identifier used to detect changes in the discovered device.")
  discoveryId: string;

  @doc("An integer that is incremented each time the resource is modified.")
  version: int64;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

@added(Versions.v2025_07_01_preview)
@doc("Connection endpoint URL a device can use to connect to a service.")
model DiscoveredMessagingEndpoints {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  @doc("Set of endpoints to connect to the device.")
  inbound?: Record<DiscoveredInboundEndpoints>;

  @doc("Set of endpoints a device can connect to.")
  outbound?: DiscoveredOutboundEndpoints;
}

@doc("Property bag contains the device's outbound endpoints")
@added(Versions.v2025_07_01_preview)
model DiscoveredOutboundEndpoints {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  @doc("Endpoints the device can connect to.")
  assigned: Record<DeviceMessagingEndpoint>;
}

@doc("An endpoint to connect to the device.")
@added(Versions.v2025_07_01_preview)
model DiscoveredInboundEndpoints {
  @doc("Type of connection endpoint.")
  endpointType: string;

  @doc("The endpoint address & port. This can be either an IP address (e.g., 192.168.1.1) or a fully qualified domain name (FQDN, e.g., server.example.com).")
  address: string;

  @doc("Protocol version associated with the endpoint e.g. 1 or 2 for endpointType Microsoft.HTTP, and 3.5 or 5.0 for endpointType Microsoft.Mqtt etc.")
  version?: string;

  @doc("List of supported authentication methods supported by device for Inbound connections.")
  supportedAuthenticationMethods?: AuthenticationMethod[];

  @doc("Stringified JSON that contains configuration to be used by the connector (e.g., OPC UA, ONVIF).")
  additionalConfiguration?: string;

  @doc("The timestamp (in UTC) when the endpoint was discovered.")
  lastUpdatedOn?: utcDateTime;
}
