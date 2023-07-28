import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-providerhub";
import "@azure-tools/typespec-azure-resource-manager";

import "./base.tsp";
import "./e4k.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using OpenAPI;
using Azure.ResourceManager;

namespace Microsoft.AlicespringsDataplane;

/**
 * E4K broker resource type model details.
 *
 * Azure Resource - e4k/broker
 * CRD - Broker
 * CRD Version - v1alpha2
 */
@doc("E4K broker resource")
@parentResource(E4kResource)
model BrokerResource is TrackedResource<BrokerProperties> {
  @doc("Name of E4K broker resource")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("brokerName")
  @path
  @segment("broker")
  name: string;

  ...ExtendedLocation;
}

@doc("Broker Resource properties")
model BrokerProperties {
  @doc("The details of Authentication Docker Image.")
  authImage: ContainerImage;

  @doc("The details of Broker Docker Image.")
  brokerImage: ContainerImage;

  @doc("The details of Node Tolerations for Broker Pods.")
  brokerNodeTolerations?: NodeTolerations;

  @doc("The cardinality details of the broker.")
  cardinality?: Cardinality;

  @doc("The diagnostic details of the broker deployment.")
  diagnostics?: BrokerDiagnostics;

  @doc("The details of Health Manager Docker Image.")
  healthManagerImage: ContainerImage;

  @doc("The details of Node Tolerations for Health Manager Pods.")
  healthManagerNodeTolerations?: NodeTolerations;

  @doc("Details of the internal CA cert that will be used to secure communication between pods.")
  internalCerts?: CertManagerCertOptions;

  @doc("The Running Mode of the Broker Deployment.")
  mode: RunMode;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("Cardinality properties")
model Cardinality {
  @doc("The backend broker desired properties")
  backendChain: BackendChain;

  @doc("The frontend broker desired properties")
  frontend: Frontend;
}

@doc("Desired properties of the Frontend Instances of the DMQTT Broker")
model BackendChain {
  @doc("Partitions is desired number of physical backend chains of the given distributed MQTT broker.")
  @minValue(0)
  @maxValue(65535)
  partitions: int32;

  @doc("Replicas is desired numbers of broker instances in one chain.")
  @minValue(0)
  @maxValue(65535)
  replicas: int32;

  @doc("Defines the limits for memory usage percent of the backend instances of the MQTT broker.")
  @minValue(0)
  @maxValue(100)
  temporaryMaxBackendMemUsagePercent?: int32;

  @doc("Defines the limits for resources of the backend instances of the MQTT broker.")
  temporaryResourceLimits?: TemporaryResourceLimitsConfig;

  @doc("Number of logical backend workers per pod.")
  @minValue(0)
  @maxValue(65535)
  workers: int32;
}

@doc("Desired properties of the Frontend Instances of the DMQTT Broker")
model Frontend {
  @doc("Replicas is desired number of frontend replicas of the given distributed MQTT broker.")
  @minValue(0)
  @maxValue(65535)
  replicas: int32;

  @doc("Defines the limits for resources of the frontend instances of the MQTT broker.")
  temporaryResourceLimits?: TemporaryResourceLimitsConfig;
}

@doc("Internal knobs of Resource Limits for FE and BE")
model TemporaryResourceLimitsConfig {
  @doc("Maximum number of messages a client can have inflight.")
  @minValue(0)
  @maxValue(65535)
  maxInflightMessages: int32;

  @doc("Maximum number of patch inflight per node.")
  @minValue(0)
  @maxValue(9223372036854000000)
  maxInflightPatches: int64;

  @doc("Maximum number of patch a client can have in flight.")
  @minValue(0)
  @maxValue(9223372036854000000)
  maxInflightPatchesPerClient: int64;

  @doc("Maximum message expiry interval, in seconds.")
  @minValue(0)
  @maxValue(4294967295)
  maxMessageExpirySecs?: int64;

  @doc("Maximum receive for external clients.")
  @minValue(0)
  @maxValue(9223372036854000000)
  maxQueuedMessages: int64;

  @doc("Maximum receive QoS0 for external clients.")
  @minValue(0)
  @maxValue(9223372036854000000)
  maxQueuedQos0Messages: int64;

  @doc("Maximum session expiry interval, in seconds.")
  @minValue(0)
  @maxValue(4294967295)
  maxSessionExpirySecs: int64;
}

@doc("Diagnostics setting specific to Broker")
model BrokerDiagnostics {
  @doc("Diagnostic Service endpoint")
  diagnosticServiceEndpoint?: string;

  @doc("Knob to enable/disable metrics. Default = true")
  enableMetrics?: boolean = true;

  @doc("Enable self check on Broker via Probe.")
  enableSelfCheck?: boolean = true;

  @doc("Enable self tracing on the Broker so that every selfCheckFrequencySeconds a random message is traced even if it didn't have trace context.")
  enableSelfTracing?: boolean = true;

  @doc("Knob to enable/disable entire tracing infrastructure.")
  enableTracing?: boolean = true;

  @doc("Format for the logs generated.")
  logFormat?: string = "text";

  @doc("Log level for the Broker.")
  logLevel?: string = "info,hyper=off,kube_client=off,tower=off,conhash=off,h2=off";

  @doc("Maximum time for the CellMap to live.")
  @minValue(0)
  @maxValue(9223372036854000000)
  maxCellMapLifetime?: int64 = 60;

  @doc("Metric update frequency in seconds.")
  @minValue(0)
  @maxValue(9223372036854000000)
  metricUpdateFrequencySeconds?: int64 = 30;

  @doc("Probe Image to run.")
  probeImage?: string = "sample.azurecr.io/diagnostics-probe:0.5.0";

  @doc("Frequency for the self check to run.")
  @minValue(0)
  @maxValue(9223372036854000000)
  selfCheckFrequencySeconds?: int64 = 30;

  @doc("Time out period of the self check.")
  @minValue(0)
  @maxValue(9223372036854000000)
  selfCheckTimeoutSeconds?: int64 = 15;

  @doc("The frequency at which selfTrace should run.")
  @minValue(0)
  @maxValue(9223372036854000000)
  selfTraceFrequencySeconds?: int64 = 30;

  @doc("The number of the spans generated by the Tracing.")
  @minValue(0)
  @maxValue(9223372036854000000)
  spanChannelCapacity?: int64 = 1000;
}

@doc("The enum defining run mode of the broker deployment")
enum RunMode {
  @doc("Automatically provision Frontend and Backend pods.")
  auto,

  @doc("Use Cardinality to set Frontend and Backend pods.")
  distributed,
}
/** ******************* */
/**
 * E4K broker/listener resource type model details.
 *
 * Azure Resource - e4k/broker/listener
 * CRD - BrokerListener
 * CRD Version - v1alpha2
 */
@doc("E4K broker/listener resource")
@parentResource(BrokerResource)
model BrokerListenerResource is TrackedResource<BrokerListenerProperties> {
  @doc("Name of E4K broker/listener resource")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("listenerName")
  @path
  @segment("listener")
  name: string;

  ...ExtendedLocation;
}

@doc("Broker Listener Resource properties")
model BrokerListenerProperties {
  @doc("The flag for enabling Authentication rules on Listener Port.")
  authenticationEnabled?: boolean = false;

  @doc("The flag for enabling Authorization policies on Listener Port. false - AllowAll, true - Use Authorization resource rules if present.")
  authorizationEnabled?: boolean = false;

  @doc("The k8s cr/resource reference of e4k/broker.")
  brokerRef: string;

  @doc("The node port to use on the Host node.")
  @minValue(0)
  @maxValue(65535)
  nodePort?: int32;

  @doc("The port to start Listening for connections on.")
  @minValue(0)
  @maxValue(65535)
  port: int32;

  @doc("The service name to expose Listener port on.")
  serviceName?: string = "azedge-dmqtt-frontend";

  @doc("The Kubernetes Service type to deploy for Listener.")
  serviceType?: ServiceType = ServiceType.loadBalancer;

  // GENERATION FIX TEMP - add "minProperties": 1 and "maxProperties": 1 to this property after creation.

  @doc("Defines configuration of a TLS server certificate. NOTE Enum - Only one TLS Cert method is supported")
  tls?: TlsCertMethod;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("Kubernetes Service Types supported by Listener")
enum ServiceType {
  @doc("Cluster IP Service.")
  clusterIp,

  @doc("Load Balancer Service.")
  loadBalancer,

  @doc("Node Port Service.")
  nodePort,
}

@doc("Collection of different TLS types, NOTE- Enum at a time only one of them needs to be supported")
model TlsCertMethod {
  @doc("Option 1 - Automatic TLS server certificate management with cert-manager.")
  automatic?: AutomaticCertMethod;

  @doc("Option 2 - Manual TLS server certificate management through a defined secret.")
  manual?: ManualCertMethod;
}

@doc("Automatic TLS server certificate management with cert-manager")
model AutomaticCertMethod {
  @doc("Lifetime of automatically-managed certificate.")
  duration?: string = "720h";

  @doc("cert-manager issuerRef.")
  issuerRef: CertManagerIssuerRef;

  @doc("Cert Manager private key.")
  privateKey?: CertManagerPrivateKey;

  @doc("When to begin renewing automatically-managed certificate.")
  renewBefore?: string = "240h";

  @doc("Additional SANs to include in the certificate.")
  san?: SanForCert;

  @doc("Secret for storing server certificate. Any existing data will be overwritten.")
  secretName?: string;

  @doc("Certificate K8S namespace. Omit to use default namespace.")
  secretNamespace?: string;
}

@doc("Manual TLS server certificate management through a defined secret")
model ManualCertMethod {
  @doc("secret containing TLS cert.")
  secretName: string;

  @doc("namespace of secret; omit to use default namespace.")
  secretNamespace?: string;
}

/** ******************* */
/**
 * E4K broker/authentication resource type model details.
 *
 * Azure Resource - e4k/broker/authentication
 * CRD - BrokerAuthentication
 * CRD Version - v1alpha2
 */
@doc("E4K broker/authentication resource")
@parentResource(BrokerResource)
model BrokerAuthenticationResource
  is TrackedResource<BrokerAuthenticationProperties> {
  @doc("Name of E4K broker/authentication resource")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("authenticationName")
  @path
  @segment("authentication")
  name: string;

  ...ExtendedLocation;
}

@doc("Broker Resource properties")
model BrokerAuthenticationProperties {
  // GENERATION FIX TEMP - add "minProperties": 1 and "maxProperties": 1 to this property after creation.
  @doc("The list of authentication methods supported by the Authentication Resource. For each array element, NOTE - Enum only authenticator type supported.")
  @OpenAPI.extension("x-ms-identifiers", [])
  authenticationMethods: BrokerAuthenticatorMethods[];

  @doc("The array of listener Resources it supports.")
  listenerRef: string[];

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("Collection of different CrdAuthenticator methods of Broker Resource. NOTE Enum - Only one method is supported for each entry.")
model BrokerAuthenticatorMethods {
  @doc("Custom Authentication Method.")
  custom?: BrokerAuthenticatorMethodCustom;

  @doc("Service Account Token Method.")
  sat?: BrokerAuthenticatorMethodSat;

  @doc("Service Account Token Method.")
  svid?: BrokerAuthenticatorMethodSvid;

  @doc("UsernamePassword Method.")
  usernamePassword?: BrokerAuthenticatorMethodUsernamePassword;

  @doc("X509 Method.")
  x509?: BrokerAuthenticatorMethodX509;
}

@doc("Custom method for BrokerAuthentication")
model BrokerAuthenticatorMethodCustom {
  @doc("Custom Broker Authentication Method.")
  auth?: BrokerAuthenticatorCustomAuth;

  @doc("CA cert to use.")
  caCert?: string;

  @doc("Endpoint to connect to.")
  endpoint: string;

  @doc("Configuration Headers to use.")
  headers?: Record<string>;
}

@doc("Custom Authentication properties")
model BrokerAuthenticatorCustomAuth {
  @doc("X509 Custom Auth type details.")
  x509: BrokerAuthenticatorCustomAuthX509;
}

@doc("X509 Custom Authentication properties")
model BrokerAuthenticatorCustomAuthX509 {
  @doc("Secret where cert details are stored.")
  secretName: string;

  @doc("K8S Secret namespace. Omit to use default namespace.")
  secretNamespace?: string;
}

@doc("Service Account Token for BrokerAuthentication")
model BrokerAuthenticatorMethodSat {
  @doc("List of allowed audience.")
  audiences: string[];
}

@doc("SVID for BrokerAuthentication")
model BrokerAuthenticatorMethodSvid {
  @doc("Mounted socket path for spiffe agent.")
  agentSocketPath: string;

  @doc("Maximum number of re-tries to fetch identity.")
  @minValue(0)
  @maxValue(4294967295)
  identityMaxRetry?: int32 = 3;

  @doc("Maximum time to wait before fetching identity again.")
  @minValue(0)
  @maxValue(9223372036854000000)
  identityWaitRetryMs?: int64 = 5000;
}

@doc("UsernamePassword for BrokerAuthentication")
model BrokerAuthenticatorMethodUsernamePassword {
  @doc("K8S Secret name to mount for username and password.")
  passwordDatabase?: string = "credentials";
}

@doc("X509 for BrokerAuthentication")
model BrokerAuthenticatorMethodX509 {
  @doc("K8S Secret name to mount for username and password.")
  attributes?: string;

  @doc("Trusted client ca cert.")
  trustedClientCaCert?: string = "client-ca";
}

/** ******************* */
/**
 * E4K broker/authorization resource type model details.
 *
 * Azure Resource - e4k/broker/authorization
 * CRD - BrokerAuthorization
 * CRD Version - v1alpha2
 */
@doc("E4K broker/authorization resource")
@parentResource(BrokerResource)
model BrokerAuthorizationResource
  is TrackedResource<BrokerAuthorizationProperties> {
  @doc("Name of E4K broker/authorization resource")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("authorizationName")
  @path
  @segment("authorization")
  name: string;

  ...ExtendedLocation;
}

@doc("Broker Resource properties")
model BrokerAuthorizationProperties {
  @doc("The list of authorization policies supported by the Authorization Resource.")
  authorizationPolicies: AuthorizationConfig;

  @doc("The array of listener Resources it supports.")
  listenerRef: string[];

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("Broker AuthorizationConfig properties")
model AuthorizationConfig {
  @doc("Enable caching of the authorization rules.")
  enableCache?: boolean = true;

  @doc("Authorization Rules to be used. If no rule is set, but Authorization Resource is used that would mean DenyAll.")
  @OpenAPI.extension("x-ms-identifiers", [])
  rules?: AuthorizationBasicRule[];
}

@doc("BasicRules of AuthorizationConfig Polar rules are not supported")
model AuthorizationBasicRule {
  @doc("This subfield defines the identities that represent the clients.")
  principals: PrincipalDefinition;

  @doc("This subfield defines the objects that represent the actions or topics. Such as - method.Connect, method.Publish etc.")
  @OpenAPI.extension("x-ms-identifiers", [])
  resources: ResourceInfoDefinition[];
}

@doc("PrincipalDefinition properties of Basic Rule")
model PrincipalDefinition {
  @doc("A list of key-value pairs that match the attributes of the clients. The attributes are case-sensitive and must match the attributes provided by the clients during authentication.")
  @OpenAPI.extension("x-ms-identifiers", [])
  attributes?: Record<string>[] = [];

  @doc("A list of client IDs that match the clients. The client IDs are case-sensitive and must match the client IDs provided by the clients during connection.")
  clientids?: string[];

  @doc("A list of usernames that match the clients. The usernames are case-sensitive and must match the usernames provided by the clients during authentication.")
  usernames?: string[];
}

@doc("ResourceInfoDefinition properties of Basic Rule")
model ResourceInfoDefinition {
  @doc("The type of action that the clients can perform on the broker. Connect, Publish or Subscribe")
  method: ResourceInfoDefinitionMethods;

  @doc("A list of topics or topic patterns that match the topics that the clients can publish or subscribe to. This subfield is required if the method is Connect or Publish.")
  topics?: string[];
}

@doc("ResourceInfoDefinition methods allowed")
enum ResourceInfoDefinitionMethods {
  @doc("Allowed Connecting to Broker")
  Connect,

  @doc("Allowed Publishing to Broker")
  Publish,

  @doc("Allowed Subscribing to Broker")
  Subscribe,
}
