import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using OpenAPI;
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
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

@doc("Defines a Broker listener. A listener is a collection of ports on which the broker accepts connections from clients.")
model BrokerListenerProperties {
  @doc("Kubernetes Service name of this listener.")
  serviceName?: string = "aio-mq-dmqtt-frontend";

  @doc("Ports on which this listener accepts client connections.")
  @OpenAPI.extension("x-ms-identifiers", ["port"])
  ports: ListenerPort[];

  @doc("Kubernetes Service type of this listener.")
  serviceType?: ServiceType = ServiceType.ClusterIp;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
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

@doc("Collection of different TLS types, NOTE- Enum at a time only one of them needs to be supported")
model TlsCertMethod {
  @doc("Mode of TLS server certificate management.")
  mode: TlsCertMethodMode;

  @doc("Option 1 - Automatic TLS server certificate management with cert-manager.")
  certManagerCertificateSpec?: CertManagerCertificateSpec;

  @doc("Option 2 - Manual TLS server certificate management through a defined secret.")
  manual?: X509ManualCertificate;
}

@doc("Broker Authentication Mode")
union TlsCertMethodMode {
  string,

  @doc("Automatic TLS server certificate configuration.")
  Automatic: "Automatic",

  @doc("Manual TLS server certificate configuration.")
  Manual: "Manual",
}

@doc("Automatic TLS server certificate management with cert-manager")
model CertManagerCertificateSpec {
  @doc("Lifetime of certificate. Must be specified using a Go time.Duration format (h|m|s). E.g. 240h for 240 hours and 45m for 45 minutes.")
  duration?: string;

  @doc("Secret for storing server certificate. Any existing data will be overwritten. This is a reference to the secret through an identifying name, not the secret itself.")
  secretName?: string;

  @doc("When to begin renewing certificate. Must be specified using a Go time.Duration format (h|m|s). E.g. 240h for 240 hours and 45m for 45 minutes.")
  renewBefore?: string;

  @doc("cert-manager issuerRef.")
  issuerRef: CertManagerIssuerRef;

  @doc("Type of certificate private key.")
  privateKey?: CertManagerPrivateKey;

  @doc("Additional Subject Alternative Names (SANs) to include in the certificate.")
  san?: SanForCert;
}

@doc("Subject Alternative Names (SANs) for certificate.")
model SanForCert {
  @doc("DNS SANs.")
  dns: string[] = #[];

  @doc("IP address SANs.")
  ip: string[] = #[];
}
