import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Versioning;
using TypeSpec.Rest;
using Azure.ResourceManager;

namespace Microsoft.IoTOperations;
/**
 * broker listener resource type model details.
 */
@doc("Instance broker resource")
@parentResource(BrokerResource)
model BrokerListenerResource is ProxyResource<BrokerListenerProperties> {
  @doc("Name of Instance broker listener resource")
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @key("listenerName")
  @path
  @minLength(3)
  @maxLength(63)
  @segment("listeners")
  name: string;

  // Extended location is not included in ProxyResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @madeOptional(Versions.`2025-07-01-preview`)
  extendedLocation?: ExtendedLocation;
}

@doc("Defines a Broker listener. A listener is a collection of ports on which the broker accepts connections from clients.")
model BrokerListenerProperties {
  @doc("Kubernetes Service name of this listener.")
  serviceName?: string;

  @doc("Ports on which this listener accepts client connections.")
  @identifiers(#["port"])
  ports: ListenerPort[];

  @doc("Kubernetes Service type of this listener.")
  serviceType?: ServiceType = ServiceType.ClusterIp;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;

  #suppress "deprecated" "ResourceHealth is deprecated, use 'status.healthState' instead."
  ...ResourceHealth;
}

@doc("Kubernetes Service Types supported by Listener")
union ServiceType {
  string,

  @doc("Cluster IP Service.")
  ClusterIp: "ClusterIp",

  @doc("Load Balancer Service.")
  LoadBalancer: "LoadBalancer",

  @doc("Node Port Service.")
  NodePort: "NodePort",
}

@doc("Defines a TCP port on which a `BrokerListener` listens.")
model ListenerPort {
  @doc("Reference to client authentication settings. Omit to disable authentication.")
  authenticationRef?: string;

  @doc("Reference to client authorization settings. Omit to disable authorization.")
  authorizationRef?: string;

  @doc("Kubernetes node port. Only relevant when this port is associated with a `NodePort` listener.")
  @minValue(0)
  @maxValue(65535)
  nodePort?: int32;

  @doc("TCP port for accepting client connections.")
  @minValue(0)
  @maxValue(65535)
  port: int32;

  @doc("Protocol to use for client connections.")
  protocol?: BrokerProtocolType = BrokerProtocolType.Mqtt;

  @doc("TLS server certificate settings for this port. Omit to disable TLS.")
  tls?: TlsCertMethod;
}
