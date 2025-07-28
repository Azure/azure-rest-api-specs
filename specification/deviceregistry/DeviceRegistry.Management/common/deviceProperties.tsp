import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./provisioningState.tsp";
import "./status.tsp";

using TypeSpec.Versioning;
using Azure.Core;

namespace Microsoft.DeviceRegistry;

@added(Versions.v2024_10_01_preview)
@doc("Defines the device properties.")
model DeviceBaseProperties {
  @doc("A unique identifier for the device.")
  @visibility(Lifecycle.Read)
  uuid?: string;

  @doc("Indicates if the resource is enabled or not.")
  enabled?: boolean = true;

  @doc("The Device ID provided by the customer.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  externalDeviceId?: string;

  @doc("Device Template Id used to create a device.")
  @removed(Versions.v2025_07_01_preview)
  @visibility(Lifecycle.Read, Lifecycle.Create)
  deviceTemplateId?: string;

  @doc("The Microsoft Entra ID group the device is a member of.")
  @removed(Versions.v2025_07_01_preview)
  deviceGroupId?: string;

  @doc("Device manufacturer.")
  @visibility(Lifecycle.Read)
  manufacturer?: string;

  @doc("Device model.")
  @visibility(Lifecycle.Read)
  `model`?: string;

  @doc("Device operating system.")
  @visibility(Lifecycle.Read)
  operatingSystem?: string;

  @doc("Device operating system version.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  operatingSystemVersion?: string;

  @doc("Identity for the resource.")
  @removed(Versions.v2025_07_01_preview)
  @visibility(Lifecycle.Read, Lifecycle.Create)
  identity?: DeviceIdentity;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  @doc("A set of key-value pairs that contain custom attributes set by the customer.")
  attributes?: Record<unknown>;

  @doc("Provisioning state of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

#suppress "@azure-tools/typespec-azure-core/casing-style" ""
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" ""
@added(Versions.v2024_10_01_preview)
@doc("Defines the device properties.")
model NamespaceDeviceProperties extends DeviceBaseProperties {
  @doc("Property bag containing the device's unassigned and assigned endpoints.")
  endpoints?: MessagingEndpoints;

  @added(Versions.v2025_07_01_preview)
  @doc("Reference to a device. Populated only if the device had been created from discovery flow. Discovered device name must be provided.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  discoveredDeviceRef?: string;

  @doc("Device manufacturer.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @added(Versions.v2025_07_01_preview)
  manufacturer?: string;

  @added(Versions.v2025_07_01_preview)
  @doc("Device model.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  `model`?: string;

  @added(Versions.v2025_07_01_preview)
  @doc("Device operating system name.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  operatingSystem?: string;

  @doc("Device operating system version.")
  @added(Versions.v2025_07_01_preview)
  operatingSystemVersion?: string;

  @doc("Device status updates.")
  @visibility(Lifecycle.Read)
  @added(Versions.v2025_07_01_preview)
  status?: DeviceStatus;

  @doc("An integer that is incremented each time the resource is modified.")
  @visibility(Lifecycle.Read)
  @added(Versions.v2025_07_01_preview)
  version?: int64;

  @doc("A timestamp (in UTC) that is updated each time the resource is modified.")
  @visibility(Lifecycle.Read)
  @added(Versions.v2025_07_01_preview)
  lastTransitionTime?: utcDateTime;

  @added(Versions.v2025_08_01_preview)
  @doc("Policy used to issue device certificates.")
  policy?: DeviceCredentialPolicy;
}

@added(Versions.v2025_08_01_preview)
@doc("Defines the Policy used to issue device certificates if any.")
model DeviceCredentialPolicy {
  @doc("Resource Id of the Policy.")
  resourceId?: armResourceIdentifier<[
    {
      type: "Microsoft.DeviceRegistry/namespaces/credentials/policies";
    }
  ]>;
}
@added(Versions.v2024_10_01_preview)
@doc("Connection endpoint URL a device can use to connect to a service.")
model MessagingEndpoints {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  @doc("Actively used endpoints a device can use to connect to several services.")
  @removed(Versions.v2025_07_01_preview)
  assigned: Record<DeviceMessagingEndpoint>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  @doc("List of most recently removed endpoints.")
  @removed(Versions.v2025_07_01_preview)
  unassigned?: Record<DeviceMessagingEndpoint>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  @doc("Set of endpoints to connect to the device.")
  @added(Versions.v2025_07_01_preview)
  inbound?: Record<InboundEndpoints>;

  @doc("Set of endpoints a device can connect to.")
  @added(Versions.v2025_07_01_preview)
  outbound?: OutboundEndpoints;
}

@doc("Property bag contains the device's outbound endpoints")
@added(Versions.v2025_07_01_preview)
model OutboundEndpoints {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  @doc("Endpoints the device can connect to.")
  assigned: Record<DeviceMessagingEndpoint>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  @doc("Set of most recently removed endpoints.")
  unassigned?: Record<DeviceMessagingEndpoint>;
}

@doc("An endpoint to connect to the device.")
@added(Versions.v2025_07_01_preview)
model InboundEndpoints {
  @doc("Type of connection endpoint.")
  endpointType: string;

  @doc("The endpoint address & port. This can be either an IP address (e.g., 192.168.1.1) or a fully qualified domain name (FQDN, e.g., server.example.com).")
  address: string;

  @doc("Protocol version associated with the endpoint e.g. 1 or 2 for endpointType Microsoft.HTTP, and 3.5 or 5.0 for endpointType Microsoft.Mqtt etc.")
  version?: string;

  @doc("Defines the client authentication mechanism to the server.")
  authentication?: HostAuthentication;

  @doc("Defines server trust settings for the endpoint.")
  trustSettings?: TrustSettings;

  @doc("Stringified JSON that contains configuration to be used by the connector (e.g., OPC UA, ONVIF).")
  additionalConfiguration?: string;
}

@doc("Defines server trust settings for an endpoint.")
@added(Versions.v2025_07_01_preview)
model TrustSettings {
  @doc("Defines a secret reference for certificates to trust.")
  trustList?: string;
}

@doc("Definition of the client authentication mechanism to the host.")
@added(Versions.v2025_07_01_preview)
model HostAuthentication {
  @doc("Defines the method to authenticate the user of the client at the server.")
  // Default mode is Certificate
  method: AuthenticationMethod = AuthenticationMethod.Certificate;

  @doc("Defines the username and password references when UsernamePassword user authentication mode is selected.")
  usernamePasswordCredentials?: UsernamePasswordCredentials;

  @doc("Defines the certificate reference when Certificate user authentication mode is selected.")
  x509Credentials?: X509Credentials;
}

@doc("Defines the device status properties.")
@added(Versions.v2025_07_01_preview)
model DeviceStatus {
  @doc("Defines the device status config properties.")
  @visibility(Lifecycle.Read)
  @added(Versions.v2025_07_01_preview)
  config?: StatusConfig;

  @doc("Defines the device status for inbound/outbound endpoints.")
  @visibility(Lifecycle.Read)
  @added(Versions.v2025_07_01_preview)
  endpoints?: DeviceStatusEndpoints;
}

@doc("Defines the device status for inbound/outbound endpoints.")
@added(Versions.v2025_07_01_preview)
model DeviceStatusEndpoints {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record"
  @doc("KeyValue pair representing status of inbound endpoints.")
  @visibility(Lifecycle.Read)
  @added(Versions.v2025_07_01_preview)
  inbound?: Record<DeviceStatusEndpoint>;
}

@doc("Defines the device status properties.")
@added(Versions.v2025_07_01_preview)
model DeviceStatusEndpoint {
  @doc("Defines the error related to this endpoint.")
  @visibility(Lifecycle.Read)
  @added(Versions.v2025_07_01_preview)
  error?: StatusError;
}

@added(Versions.v2024_10_01_preview)
@doc("Device messaging endpoint model.")
model DeviceMessagingEndpoint {
  @doc("Type of connection used for the messaging endpoint.")
  @removed(Versions.v2025_07_01_preview)
  type?: string;

  @doc("Type of connection used for the messaging endpoint.")
  @added(Versions.v2025_07_01_preview)
  endpointType?: string;

  @added(Versions.v2025_07_01_preview)
  @doc("The endpoint address to connect to.")
  address: string;
}
