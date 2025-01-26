import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using OpenAPI;
using Azure.ResourceManager;

namespace Microsoft.IoTOperations;

/**
 * broker resource type model details.
 */
@doc("Instance broker resource")
@parentResource(InstanceResource)
model BrokerResource is ProxyResource<BrokerProperties> {
  @doc("Name of broker.")
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @key("brokerName")
  @path
  @minLength(3)
  @maxLength(63)
  @segment("brokers")
  name: string;

  // Extended location is not included in ProxyResource yet
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @doc("Edge location of the resource.")
  @visibility("read", "create")
  extendedLocation: ExtendedLocation;
}

@doc("Broker Resource properties")
model BrokerProperties {
  @visibility("read", "create")
  @doc("Advanced settings of Broker.")
  advanced?: AdvancedSettings;

  @visibility("read", "create")
  @doc("The cardinality details of the broker.")
  cardinality?: Cardinality;

  @doc("Spec defines the desired identities of Broker diagnostics settings.")
  diagnostics?: BrokerDiagnostics;

  @visibility("read", "create")
  @doc("Settings of Disk Backed Message Buffer.")
  diskBackedMessageBuffer?: DiskBackedMessageBuffer;

  @visibility("read", "create")
  @doc("This setting controls whether Kubernetes CPU resource limits are requested. Increasing the number of replicas or workers proportionally increases the amount of CPU resources requested. If this setting is enabled and there are insufficient CPU resources, an error will be emitted.")
  generateResourceLimits?: GenerateResourceLimits;

  @visibility("read", "create")
  @doc("Memory profile of Broker.")
  memoryProfile?: BrokerMemoryProfile = BrokerMemoryProfile.Medium;

  @visibility("read")
  @doc("The status of the last operation.")
  provisioningState?: ProvisioningState;
}

@doc("Broker Advanced Settings")
model AdvancedSettings {
  @doc("Configurations related to All Clients.")
  clients?: ClientConfig;

  @doc("The setting to enable or disable encryption of internal Traffic.")
  encryptInternalTraffic?: OperationalMode = OperationalMode.Enabled;

  @doc("Certificate rotation and private key configuration.")
  internalCerts?: CertManagerCertOptions;
}

@doc("Cardinality properties")
model Cardinality {
  @doc("The backend broker desired properties")
  backendChain: BackendChain;

  @doc("The frontend desired properties")
  frontend: Frontend;
}

@doc("Desired properties of the backend instances of the broker")
model BackendChain {
  @doc("The desired number of physical backend partitions.")
  @minValue(1)
  @maxValue(16)
  partitions: int32;

  @doc("The desired numbers of backend replicas (pods) in a physical partition.")
  @minValue(1)
  @maxValue(5)
  redundancyFactor: int32;

  @doc("Number of logical backend workers per replica (pod).")
  @minValue(1)
  @maxValue(16)
  workers?: int32 = 1;
}

@doc("The desired properties of the frontend instances of the Broker")
model Frontend {
  @doc("The desired number of frontend instances (pods).")
  @minValue(1)
  @maxValue(16)
  replicas: int32;

  @doc("Number of logical frontend workers per instance (pod).")
  @minValue(1)
  @maxValue(16)
  workers?: int32 = 2;
}

@doc("Broker Diagnostic Setting properties")
model BrokerDiagnostics {
  ...MetricProperties;

  @doc("The self check properties.")
  selfCheck?: SelfCheck;

  @doc("The trace properties.")
  traces?: Traces;
}

@doc("Broker Diagnostic Self check properties")
model SelfCheck {
  @doc("The toggle to enable/disable self check.")
  mode?: OperationalMode = OperationalMode.Enabled;

  @doc("The self check interval.")
  @minValue(30)
  @maxValue(300)
  intervalSeconds?: int32 = 30;

  @doc("The timeout for self check.")
  @minValue(5)
  @maxValue(120)
  timeoutSeconds?: int32 = 15;
}

@doc("Broker Diagnostic Trace properties")
model Traces {
  @doc("The toggle to enable/disable traces.")
  mode?: OperationalMode = OperationalMode.Enabled;

  @doc("The cache size in megabytes.")
  @minValue(1)
  @maxValue(128)
  cacheSizeMegabytes?: int32 = 16;

  @doc("The self tracing properties.")
  selfTracing?: SelfTracing;

  @doc("The span channel capacity.")
  @minValue(1000)
  @maxValue(100000)
  spanChannelCapacity?: int32 = 1000;
}

@doc("DiskBackedMessageBuffer properties")
model DiskBackedMessageBuffer {
  @doc("The max size of the message buffer on disk. If a PVC template is specified using one of ephemeralVolumeClaimSpec or persistentVolumeClaimSpec, then this size is used as the request and limit sizes of that template. If neither ephemeralVolumeClaimSpec nor persistentVolumeClaimSpec are specified, then an emptyDir volume is mounted with this size as its limit. See <https://kubernetes.io/docs/concepts/storage/volumes/#emptydir> for details.")
  @pattern("^[0-9]+[KMGTPE]$")
  maxSize: string;

  @doc("Use the specified persistent volume claim template to mount a \"generic ephemeral volume\" for the message buffer. See <https://kubernetes.io/docs/concepts/storage/ephemeral-volumes/#generic-ephemeral-volumes> for details.")
  ephemeralVolumeClaimSpec?: VolumeClaimSpec;

  @doc("Use the specified persistent volume claim template to mount a persistent volume for the message buffer.")
  persistentVolumeClaimSpec?: VolumeClaimSpec;
}

@doc("VolumeClaimSpec properties")
model VolumeClaimSpec {
  @doc("VolumeName is the binding reference to the PersistentVolume backing this claim.")
  volumeName?: string;

  @doc("volumeMode defines what type of volume is required by the claim. Value of Filesystem is implied when not included in claim spec. This is a beta feature.")
  volumeMode?: string;

  @doc("Name of the StorageClass required by the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1")
  storageClassName?: string;

  @doc("AccessModes contains the desired access modes the volume should have. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1")
  @OpenAPI.extension("x-ms-identifiers", [])
  accessModes?: string[];

  @doc("This field can be used to specify either: * An existing VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot) * An existing PVC (PersistentVolumeClaim) If the provisioner or an external controller can support the specified data source, it will create a new volume based on the contents of the specified data source. If the AnyVolumeDataSource feature gate is enabled, this field will always have the same contents as the DataSourceRef field.")
  dataSource?: LocalKubernetesReference;

  @doc("Specifies the object from which to populate the volume with data, if a non-empty volume is desired. This may be any local object from a non-empty API group (non core object) or a PersistentVolumeClaim object. When this field is specified, volume binding will only succeed if the type of the specified object matches some installed volume populator or dynamic provisioner. This field will replace the functionality of the DataSource field and as such if both fields are non-empty, they must have the same value. For backwards compatibility, both fields (DataSource and DataSourceRef) will be set to the same value automatically if one of them is empty and the other is non-empty. There are two important differences between DataSource and DataSourceRef: * While DataSource only allows two specific types of objects, DataSourceRef allows any non-core object, as well as PersistentVolumeClaim objects. * While DataSource ignores disallowed values (dropping them), DataSourceRef preserves all values, and generates an error if a disallowed value is specified. (Beta) Using this field requires the AnyVolumeDataSource feature gate to be enabled.")
  dataSourceRef?: KubernetesReference;

  @doc("Resources represents the minimum resources the volume should have. If RecoverVolumeExpansionFailure feature is enabled users are allowed to specify resource requirements that are lower than previous value but must still be higher than capacity recorded in the status field of the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources")
  resources?: VolumeClaimResourceRequirements;

  @doc("A label query over volumes to consider for binding.")
  selector?: VolumeClaimSpecSelector;
}

@doc("VolumeClaimResourceRequirements properties")
model VolumeClaimResourceRequirements {
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  @doc("Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/")
  limits?: Record<string>;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  @doc("Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/")
  requests?: Record<string>;
}

@doc("VolumeClaimSpecSelector properties")
model VolumeClaimSpecSelector {
  @doc("MatchExpressions is a list of label selector requirements. The requirements are ANDed.")
  @OpenAPI.extension("x-ms-identifiers", [])
  matchExpressions?: VolumeClaimSpecSelectorMatchExpressions[];

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "existing API"
  @doc("MatchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.")
  matchLabels?: Record<string>;
}

@doc("VolumeClaimSpecSelectorMatchExpressions properties")
model VolumeClaimSpecSelectorMatchExpressions {
  @doc("key is the label key that the selector applies to.")
  key: string;

  @doc("operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.")
  operator: OperatorValues;

  @doc("values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.")
  values?: string[];
}

@doc("Valid operators are In, NotIn, Exists and DoesNotExist.")
union OperatorValues {
  string,

  @doc("In operator.")
  In: "In",

  @doc("NotIn operator.")
  NotIn: "NotIn",

  @doc("Exists operator.")
  Exists: "Exists",

  @doc("DoesNotExist operator.")
  DoesNotExist: "DoesNotExist",
}

@doc("GenerateResourceLimits properties")
model GenerateResourceLimits {
  @doc("The toggle to enable/disable cpu resource limits.")
  cpu?: OperationalMode = OperationalMode.Enabled;
}

@doc("Cert Manager Cert properties")
model CertManagerCertOptions {
  @doc("Lifetime of certificate. Must be specified using a Go time.Duration format (h|m|s). E.g. 240h for 240 hours and 45m for 45 minutes.")
  duration: string;

  @doc("When to begin renewing certificate. Must be specified using a Go time.Duration format (h|m|s). E.g. 240h for 240 hours and 45m for 45 minutes.")
  renewBefore: string;

  @doc("Configuration of certificate private key.")
  privateKey: CertManagerPrivateKey;
}

@doc("Cert Manager private key properties")
model CertManagerPrivateKey {
  @doc("algorithm for private key.")
  algorithm: PrivateKeyAlgorithm;

  @doc("cert-manager private key rotationPolicy.")
  rotationPolicy: PrivateKeyRotationPolicy;
}

@doc("Private key algorithm types.")
union PrivateKeyAlgorithm {
  string,

  @doc("Algorithm - ec256.")
  Ec256: "Ec256",

  @doc("Algorithm - ec384.")
  Ec384: "Ec384",

  @doc("Algorithm - ec521.")
  Ec521: "Ec521",

  @doc("Algorithm - ed25519.")
  Ed25519: "Ed25519",

  @doc("Algorithm - rsa2048.")
  Rsa2048: "Rsa2048",

  @doc("Algorithm - rsa4096.")
  Rsa4096: "Rsa4096",

  @doc("Algorithm - rsa8192.")
  Rsa8192: "Rsa8192",
}

@doc("Private key rotation policy.")
union PrivateKeyRotationPolicy {
  string,

  @doc("Rotation Policy - Always.")
  Always: "Always",

  @doc("Rotation Policy - Never.")
  Never: "Never",
}

@doc("The memory profile settings of the Broker")
union BrokerMemoryProfile {
  string,

  @doc("Tiny memory profile.")
  Tiny: "Tiny",

  @doc("Low memory profile.")
  Low: "Low",

  @doc("Medium memory profile.")
  Medium: "Medium",

  @doc("High memory profile.")
  High: "High",
}

@doc("The settings of Client Config.")
model ClientConfig {
  @doc("Upper bound of Session Expiry Interval, in seconds.")
  @minValue(1)
  @maxValue(4294967295)
  maxSessionExpirySeconds?: int32;

  @doc("Upper bound of Message Expiry Interval, in seconds.")
  @minValue(1)
  @maxValue(4294967295)
  maxMessageExpirySeconds?: int32;

  @doc("Max message size for a packet in Bytes.")
  @minValue(1)
  @maxValue(268435456)
  maxPacketSizeBytes?: int32;

  @doc("The limit on the number of queued messages for a subscriber.")
  subscriberQueueLimit?: SubscriberQueueLimit;

  @doc("Upper bound of Receive Maximum that a client can request in the CONNECT packet.")
  @minValue(1)
  @maxValue(65535)
  maxReceiveMaximum?: int32;

  @doc("Upper bound of a client's Keep Alive, in seconds.")
  @minValue(0)
  @maxValue(65535)
  maxKeepAliveSeconds?: int32;
}

@doc("The settings of Subscriber Queue Limit.")
model SubscriberQueueLimit {
  @doc("The maximum length of the queue before messages start getting dropped.")
  @minValue(1)
  @maxValue(9223372036854775807)
  length?: int64;

  @doc("The strategy to use for dropping messages from the queue.")
  strategy?: SubscriberMessageDropStrategy = SubscriberMessageDropStrategy.None;
}

@doc("The enum defining strategies for dropping messages from the subscriber queue.")
union SubscriberMessageDropStrategy {
  string,

  @doc("Messages are never dropped.")
  None: "None",

  @doc("The oldest message is dropped.")
  DropOldest: "DropOldest",
}
