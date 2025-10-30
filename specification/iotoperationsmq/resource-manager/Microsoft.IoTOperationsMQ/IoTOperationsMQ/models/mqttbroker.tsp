import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";

import "./base.tsp";
import "./mq.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using OpenAPI;
using Azure.ResourceManager;

namespace Microsoft.IoTOperationsMQ;

/**
 * MQ broker resource type model details.
 *
 * Azure Resource - mq/broker
 * CRD - Broker
 * CRD Version - v1alpha4
 */
@doc("MQ broker resource")
@parentResource(MqResource)
model BrokerResource is TrackedResource<BrokerProperties> {
  @doc("Name of MQ broker resource")
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

  @doc("The settings of the disk-backed message buffer.")
  diskBackedMessageBufferSettings?: DiskBackedMessageBufferSettings;

  @doc("The setting to enable or disable encryption of internal Traffic.")
  encryptInternalTraffic?: boolean = true;

  @doc("The details of Health Manager Docker Image.")
  healthManagerImage: ContainerImage;

  @doc("The details of Node Tolerations for Health Manager Pods.")
  healthManagerNodeTolerations?: NodeTolerations;

  @doc("Details of the internal CA cert that will be used to secure communication between pods.")
  internalCerts?: CertManagerCertOptions;

  @doc("Memory profile of broker.")
  memoryProfile?: BrokerMemoryProfile = BrokerMemoryProfile.medium;

  @doc("The Running Mode of the Broker Deployment.")
  mode: RunMode;

  @visibility(Lifecycle.Read)
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

  @doc("Redundancy Factor is desired numbers of broker instances in one chain.")
  @minValue(0)
  @maxValue(65535)
  redundancyFactor: int32;

  @doc("Defines whether disk transfer is enabled or not.")
  temporaryDiskTransferEnabled?: boolean;

  @doc("Defines the percentage usage of buffer pool above which disk transfer will start.")
  @minValue(0)
  @maxValue(100)
  temporaryDiskTransferHighWatermarkPercent?: int32;

  @doc("Defines the percentage usage of buffer pool below which disk transfer will stop.")
  @minValue(0)
  @maxValue(100)
  temporaryDiskTransferLowWatermarkPercent?: int32;

  @doc("Defines the limits for memory usage percent of the backend instances of the MQTT broker.")
  @minValue(0)
  @maxValue(100)
  temporaryMaxBackendMemUsagePercent?: int32;

  @doc("Defines the limits for resources of the backend instances of the MQTT broker.")
  temporaryResourceLimits?: TemporaryResourceLimitsConfig;

  @doc("Number of logical backend workers per pod.")
  @minValue(0)
  @maxValue(65535)
  workers?: int32 = 1;
}

@doc("Desired properties of the Frontend Instances of the DMQTT Broker")
model Frontend {
  @doc("Replicas is desired number of frontend replicas of the given distributed MQTT broker.")
  @minValue(0)
  @maxValue(65535)
  replicas: int32;

  @doc("Defines the limits for resources of the frontend instances of the MQTT broker.")
  temporaryResourceLimits?: TemporaryResourceLimitsConfig;

  @doc("Number of logical frontend workers per pod.")
  @minValue(0)
  @maxValue(65535)
  workers?: int32 = 2;
}

@doc("Internal knobs of Resource Limits for FE and BE")
model TemporaryResourceLimitsConfig {
  @doc("Maximum number of messages a client can have inflight.")
  @minValue(0)
  @maxValue(65535)
  maxInflightMessages: int32;

  @doc("Maximum number of patch inflight per node.")
  @minValue(0)
  @maxValue(65535)
  maxInflightPatches: int32;

  @doc("Maximum number of patch a client can have in flight.")
  @minValue(0)
  @maxValue(65535)
  maxInflightPatchesPerClient: int32;

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

@doc("DiskBackedMessageBufferSettings properties")
model DiskBackedMessageBufferSettings {
  @doc("Use the specified persistent volume claim template to mount a \"generic ephemeral volume\" for the message buffer. See <https://kubernetes.io/docs/concepts/storage/ephemeral-volumes/#generic-ephemeral-volumes> for details.")
  ephemeralVolumeClaimSpec?: VolumeClaimSpec;

  @doc("The max size of the message buffer on disk. If a PVC template is specified using one of ephemeralVolumeClaimSpec or persistentVolumeClaimSpec, then this size is used as the request and limit sizes of that template. If neither ephemeralVolumeClaimSpec nor persistentVolumeClaimSpec are specified, then an emptyDir volume is mounted with this size as its limit. See <https://kubernetes.io/docs/concepts/storage/volumes/#emptydir> for details.")
  maxSize: string;

  @doc("Use the specified persistent volume claim template to mount a persistent volume for the message buffer.")
  persistentVolumeClaimSpec?: VolumeClaimSpec;
}

// Add VolumeClaimSpec model
@doc("VolumeClaimSpec properties")
model VolumeClaimSpec {
  @doc("AccessModes contains the desired access modes the volume should have. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1")
  accessModes?: string[];

  @doc("This field can be used to specify either: * An existing VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot) * An existing PVC (PersistentVolumeClaim) If the provisioner or an external controller can support the specified data source, it will create a new volume based on the contents of the specified data source. If the AnyVolumeDataSource feature gate is enabled, this field will always have the same contents as the DataSourceRef field.")
  dataSource?: VolumeClaimDataSource;

  @doc("Specifies the object from which to populate the volume with data, if a non-empty volume is desired. This may be any local object from a non-empty API group (non core object) or a PersistentVolumeClaim object. When this field is specified, volume binding will only succeed if the type of the specified object matches some installed volume populator or dynamic provisioner. This field will replace the functionality of the DataSource field and as such if both fields are non-empty, they must have the same value. For backwards compatibility, both fields (DataSource and DataSourceRef) will be set to the same value automatically if one of them is empty and the other is non-empty. There are two important differences between DataSource and DataSourceRef: * While DataSource only allows two specific types of objects, DataSourceRef allows any non-core object, as well as PersistentVolumeClaim objects. * While DataSource ignores disallowed values (dropping them), DataSourceRef preserves all values, and generates an error if a disallowed value is specified. (Alpha) Using this field requires the AnyVolumeDataSource feature gate to be enabled.")
  dataSourceRef?: VolumeClaimDataSourceRef;

  @doc("Resources represents the minimum resources the volume should have. If RecoverVolumeExpansionFailure feature is enabled users are allowed to specify resource requirements that are lower than previous value but must still be higher than capacity recorded in the status field of the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources")
  resources?: VolumeClaimResourceRequirements;

  @doc("A label query over volumes to consider for binding.")
  selector?: VolumeClaimSpecSelector;

  @doc("Name of the StorageClass required by the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1")
  storageClassName?: string;

  @doc("volumeMode defines what type of volume is required by the claim. Value of Filesystem is implied when not included in claim spec. This is a beta feature.")
  volumeMode?: string;

  @doc("VolumeName is the binding reference to the PersistentVolume backing this claim.")
  volumeName?: string;
}

// Add VolumeClaimDataSource model
@doc("VolumeClaimDataSource properties")
model VolumeClaimDataSource {
  @doc("APIGroup is the group for the resource being referenced. If APIGroup is not specified, the specified Kind must be in the core API group. For any other third-party types, APIGroup is required.")
  apiGroup?: string;

  @doc("Kind is the type of resource being referenced")
  kind: string;

  @doc("Name is the name of resource being referenced")
  name: string;
}

// Add VolumeClaimDataSourceRef model
@doc("VolumeClaimDataSourceRef properties")
model VolumeClaimDataSourceRef {
  @doc("APIGroup is the group for the resource being referenced. If APIGroup is not specified, the specified Kind must be in the core API group. For any other third-party types, APIGroup is required.")
  apiGroup?: string;

  @doc("Kind is the type of resource being referenced")
  kind: string;

  @doc("Name is the name of resource being referenced")
  name: string;
}

// Add VolumeClaimResourceRequirements model
@doc("VolumeClaimResourceRequirements properties")
model VolumeClaimResourceRequirements {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  @doc("Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/")
  limits?: Record<string>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  @doc("Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/")
  requests?: Record<string>;
}

// Add VolumeClaimSpecSelector model
@doc("VolumeClaimSpecSelector properties")
model VolumeClaimSpecSelector {
  @doc("MatchExpressions is a list of label selector requirements. The requirements are ANDed.")
  @identifiers(#[])
  matchExpressions?: VolumeClaimSpecSelectorMatchExpressions[];

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  @doc("MatchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.")
  matchLabels?: Record<string>;
}

// Add VolumeClaimSpecSelectorMatchExpressions model
@doc("VolumeClaimSpecSelectorMatchExpressions properties")
model VolumeClaimSpecSelectorMatchExpressions {
  @doc("key is the label key that the selector applies to.")
  key: string;

  @doc("operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.")
  operator: string;

  @doc("values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.")
  values?: string[];
}

@doc("The enum defining run mode of the broker deployment")
union RunMode {
  string,

  @doc("Automatically provision Frontend and Backend pods.")
  "auto",

  @doc("Use Cardinality to set Frontend and Backend pods.")
  "distributed",
}

@doc("The memory profile settings of the Broker")
union BrokerMemoryProfile {
  string,

  @doc("Tiny memory profile.")
  tiny: "tiny",

  @doc("Low memory profile.")
  low: "low",

  @doc("Medium memory profile.")
  medium: "medium",

  @doc("High memory profile.")
  high: "high",
}

/** ******************* */
/**
 * MQ broker/listener resource type model details.
 *
 * Azure Resource - mq/broker/listener
 * CRD - BrokerListener
 * CRD Version - v1alpha4
 */
@doc("MQ broker/listener resource")
@parentResource(BrokerResource)
model BrokerListenerResource is TrackedResource<BrokerListenerProperties> {
  @doc("Name of MQ broker/listener resource")
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

  @doc("The k8s cr/resource reference of mq/broker.")
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
  serviceName?: string = "aio-mq-dmqtt-frontend";

  @doc("The Kubernetes Service type to deploy for Listener.")
  serviceType?: ServiceType = ServiceType.clusterIp;

  // GENERATION FIX TEMP - add "minProperties": 1 and "maxProperties": 1 to this property after creation.

  @doc("Defines configuration of a TLS server certificate. NOTE Enum - Only one TLS Cert method is supported")
  tls?: TlsCertMethod;

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("Kubernetes Service Types supported by Listener")
union ServiceType {
  string,

  @doc("Cluster IP Service.")
  clusterIp: "clusterIp",

  @doc("Load Balancer Service.")
  loadBalancer: "loadBalancer",

  @doc("Node Port Service.")
  nodePort: "nodePort",
}

@doc("Collection of different TLS types, NOTE- Enum at a time only one of them needs to be supported")
model TlsCertMethod {
  @doc("Option 1 - Automatic TLS server certificate management with cert-manager.")
  automatic?: AutomaticCertMethod;

  @doc("Option 2 - Manual TLS server certificate management through a defined secret.")
  manual?: ManualCertMethod;

  @doc("Option 3 - TLS server certificate retrieved from Key Vault..")
  keyVault?: KeyVaultCertificateProperties;
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
 * MQ broker/authentication resource type model details.
 *
 * Azure Resource - mq/broker/authentication
 * CRD - BrokerAuthentication
 * CRD Version - v1alpha4
 */
@doc("MQ broker/authentication resource")
@parentResource(BrokerResource)
model BrokerAuthenticationResource
  is TrackedResource<BrokerAuthenticationProperties> {
  @doc("Name of MQ broker/authentication resource")
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
  @identifiers(#[])
  authenticationMethods: BrokerAuthenticatorMethods[];

  @doc("The array of listener Resources it supports.")
  listenerRef: string[];

  @visibility(Lifecycle.Read)
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

  @doc("CA cert config map to use.")
  caCertConfigMap?: string;

  @doc("Endpoint to connect to.")
  endpoint: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  @doc("Configuration Headers to use.")
  headers?: Record<string>;
}

@doc("Custom Authentication properties")
model BrokerAuthenticatorCustomAuth {
  @doc("X509 Custom Auth type details.")
  x509: BrokerAuthenticatorCustomAuthX509;
}

@doc("X509 Custom Authentication properties. NOTE - Enum only authenticator type supported at a time.")
model BrokerAuthenticatorCustomAuthX509 {
  @doc("Keyvault X509 secret properties.")
  keyVault?: KeyVaultCertificateProperties;

  @doc("Secret where cert details are stored.")
  secretName?: string;
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
  identityMaxRetry?: int64 = 3;

  @doc("Maximum time to wait before fetching identity again.")
  @minValue(0)
  @maxValue(9223372036854000000)
  identityWaitRetryMs?: int64 = 5000;
}

@doc("UsernamePassword for BrokerAuthentication")
model BrokerAuthenticatorMethodUsernamePassword {
  @doc("Keyvault username password secret properties.")
  keyVault?: KeyVaultSecretProperties;

  @doc("Secret where username and password are stored.")
  secretName?: string;
}

@doc("X509 for BrokerAuthentication.")
model BrokerAuthenticatorMethodX509 {
  @doc("K8S Secret name to mount for username and password.")
  attributes?: BrokerAuthenticatorMethodX509Attributes;

  @doc("Trusted client ca cert config map.")
  trustedClientCaCertConfigMap?: string = "client-ca";
}

// Add BrokerAuthenticatorMethodX509Attributes model
@doc("BrokerAuthenticatorMethodX509Attributes properties. NOTE - Enum only type supported at a time.")
model BrokerAuthenticatorMethodX509Attributes {
  @doc("Keyvault x509 attributes secret properties.")
  keyVault?: KeyVaultSecretProperties;

  @doc("Secret where x509 attributes are stored.")
  secretName?: string;
}

/** ******************* */
/**
 * MQ broker/authorization resource type model details.
 *
 * Azure Resource - mq/broker/authorization
 * CRD - BrokerAuthorization
 * CRD Version - v1alpha4
 */
@doc("MQ broker/authorization resource")
@parentResource(BrokerResource)
model BrokerAuthorizationResource
  is TrackedResource<BrokerAuthorizationProperties> {
  @doc("Name of MQ broker/authorization resource")
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

  @visibility(Lifecycle.Read)
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("Broker AuthorizationConfig properties")
model AuthorizationConfig {
  @doc("Enable caching of the authorization rules.")
  enableCache?: boolean = true;

  @doc("Authorization Rules to be used. If no rule is set, but Authorization Resource is used that would mean DenyAll.")
  @identifiers(#[])
  rules?: AuthorizationBasicRule[];
}

@doc("BasicRules of AuthorizationConfig Polar rules are not supported")
model AuthorizationBasicRule {
  @doc("This subfield defines the broker resources that the Basic Rule is applied on.")
  @identifiers(#[])
  brokerResources: ResourceInfoDefinition[];

  @doc("This subfield defines the identities that represent the clients.")
  principals: PrincipalDefinition;
}

@doc("PrincipalDefinition properties of Basic Rule")
model PrincipalDefinition {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  @doc("A list of key-value pairs that match the attributes of the clients. The attributes are case-sensitive and must match the attributes provided by the clients during authentication.")
  @identifiers(#[])
  attributes?: Record<string>[] = #[];

  @doc("A list of client IDs that match the clients. The client IDs are case-sensitive and must match the client IDs provided by the clients during connection.")
  clientids?: string[];

  @doc("A list of usernames that match the clients. The usernames are case-sensitive and must match the usernames provided by the clients during authentication.")
  usernames?: string[];
}

@doc("ResourceInfoDefinition properties of Basic Rule. This defines the objects that represent the actions or topics, such as - method.Connect, method.Publish, etc.")
model ResourceInfoDefinition {
  @doc("The type of action that the clients can perform on the broker: Connect, Publish or Subscribe.")
  method: ResourceInfoDefinitionMethods;

  @doc("A list of topics or topic patterns that match the topics that the clients can publish or subscribe to. This subfield is required if the method is Publish or Subscribe.")
  topics?: string[];
}

@doc("ResourceInfoDefinition methods allowed")
union ResourceInfoDefinitionMethods {
  string,

  @doc("Allowed Connecting to Broker")
  "Connect",

  @doc("Allowed Publishing to Broker")
  "Publish",

  @doc("Allowed Subscribing to Broker")
  "Subscribe",
}
