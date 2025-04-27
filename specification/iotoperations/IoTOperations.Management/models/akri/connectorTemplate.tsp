import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;
namespace Microsoft.IoTOperations;

/**
 * ConnectorTemplate resource
 */
@parentResource(InstanceResource)
@added(Versions.`2025-07-01-preview`)
model ConnectorTemplateResource is ProxyResource<ConnectorTemplateProperties> {
  /**
   * Name of ConnectorTemplate resource
   */
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @key("connectorConfigInstanceName")
  @path
  @minLength(3)
  @maxLength(63)
  @segment("connectorConfigInstances")
  name: string;

  /**
   * Edge location of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  extendedLocation: ExtendedLocation;
}

/**
 * ConnectorTemplate properties
 */
@added(Versions.`2025-07-01-preview`)
model ConnectorTemplateProperties {
  /**
   * The status of the last operation.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Metadata about AIO.
   */
  aioMetadata?: ConnectorTemplateAioMetadata;

  /**
   * The runtime configuration for the Connector template.
   */
  runtimeConfiguration: ConnectorTemplateRuntimeConfiguration;

  /**
   * Diagnostics settings for the Connector template.
   */
  diagnostics?: ConnectorTemplateDiagnostics;

  /**
   * Device inbound endpoint types
   */
  @OpenAPI.extension("x-ms-identifiers", #["endpointType", "version"])
  @minItems(1)
  deviceInboundEndpointTypes: ConnectorTemplateDeviceInboundEndpointType[];

  /**
   * Mqtt connection configuration settings
   */
  mqttConnectionConfiguration?: ConnectorTemplateMqttConnectionConfiguration;

  /**
   * The version of the Connector template.
   */
  version: string; // Probably not needed.
}

/**
 * ConnectorTemplateMqttConnectionConfiguration properties
 */
//- This doesn't have the `cloudEventAttributes` property like DataflowEnpoints has
//- This doesn't have the `retain` property like DataflowEnpoints has
//- This doesn't have the `clientIdPrefix` property like DataflowEnpoints has
//- This doesn't have the `retain` property like DataflowEnpoints has
//- This doesn't have the `qos` property like DataflowEnpoints has
//- The only supported protocol is `mqtt`
//- `host` is a required property in DataflowEnpoints but optional here
@added(Versions.`2025-07-01-preview`)
model ConnectorTemplateMqttConnectionConfiguration {
  /**
   * Authentication properties.
   */
  authentication?: ConnectorTemplateMqttAuthentication;

  /**
   * Host of the Broker in the form of <hostname>:<port>.
   */
  host?: string;

  /**
   * The protocol to use for the connection. Currently only `mqtt` is supported.
   */
  protocol?: ConnectorTemplateMqttProtocolType;

  /**
   * KeepAlive for connection in seconds.
   */
  @minValue(0)
  keepAliveSeconds?: int32;

  /**
   * The max number of messages to keep in flight. For subscribe, this is the receive maximum. For publish, this is the maximum number of messages to send before waiting for an ack.
   */
  @minValue(0)
  maxInflightMessages?: int32;

  /**
   * Session expiry in seconds.
   */
  @minValue(0)
  sessionExpirySeconds?: int32;

  /**
   * TLS configuration.
   */
  tls?: TlsProperties;
}

/**
 * ConnectorTemplateMqttAuthentication properties
 */
@added(Versions.`2025-07-01-preview`)
@discriminator("method")
model ConnectorTemplateMqttAuthentication {
  /**
   * The authentication method for the MQTT connection.
   */
  method: ConnectorTemplateMqttAuthenticationMethod;
}

/**
 * ConnectorTemplateMqttAuthenticationMethod properties
 */
@added(Versions.`2025-07-01-preview`)
union ConnectorTemplateMqttAuthenticationMethod {
  string,

  /**
   * Service Account Token authentication
   */
  ServiceAccountToken,
}

/**
 * Mqtt protocol types.
 */
@added(Versions.`2025-07-01-preview`)
union ConnectorTemplateMqttProtocolType {
  string,

  /**
   * Mqtt protocol
   */
  Mqtt,
}

/**
 * ConnectorTemplateServiceAccountAuthentication properties
 */
@added(Versions.`2025-07-01-preview`)
model ConnectorTemplateServiceAccountAuthentication
  extends ConnectorTemplateMqttAuthentication {
  /**
   * The authentication method for the MQTT connection.
   */
  method: ServiceAccountToken;

  /**
   * The service account token for the MQTT connection.
   */
  serviceAccountTokenSettings: ConnectorTemplateServiceAccountTokenSettings;
}

/**
 * ConnectorTemplateServiceAccountTokenSettings properties
 */
@added(Versions.`2025-07-01-preview`)
model ConnectorTemplateServiceAccountTokenSettings {
  /**
   * The audience for the service account token.
   */
  audience: string;
}

/**
 * ConnectorTemplateDeviceInboundEndpointType properties
 */
@added(Versions.`2025-07-01-preview`)
model ConnectorTemplateDeviceInboundEndpointType {
  /**
   * The type of the device inbound endpoint.
   */
  endpointType: NonEmptyString;

  /**
   * The version of the device inbound endpoint.
   */
  version: NonEmptyString;

  /**
   * The configuration schema references for the device inbound endpoint.
   */
  configurationSchemaRefs?: ConnectorTemplateDeviceInboundEndpointConfigurationSchemaRefs;
}

/**
 * ConnectorTemplateDeviceInboundEndpointConfigurationSchemaRefs properties
 */
@added(Versions.`2025-07-01-preview`)
model ConnectorTemplateDeviceInboundEndpointConfigurationSchemaRefs {
  /**
   * The default configuration schema reference for datasets.
   */
  defaultDatasetConfigSchemaRef?: string;

  /**
   * The default configuration schema reference for events.
   */
  defaultEventsConfigSchemaRef?: string;

  /**
   * The default configuration schema reference for process control.
   */
  defaultProcessControlConfigSchemaRef?: string;

  /**
   * The default configuration schema reference for streams.
   */
  defaultStreamsConfigSchemaRef?: string;
}

/**
 * ConnectorTemplateAioMetadata properties
 */
@added(Versions.`2025-07-01-preview`)
model ConnectorTemplateAioMetadata {
  /**
   * The minimum version of AIO required for the connector.
   */
  aioMinVersion?: string;

  /**
   * The maximum version of AIO required for the connector.
   */
  aioMaxVersion?: string;
}

/**
 * ConnectorTemplateRuntimeConfiguration properties
 */
@added(Versions.`2025-07-01-preview`)
@discriminator("runtimeConfigurationType")
model ConnectorTemplateRuntimeConfiguration {
  /**
   * Runtime configuration type for the Connector template.
   */
  runtimeConfigurationType: ConnectorTemplateRuntimeConfigurationType;
}

/**
 * Runtime configuration types.
 */
@added(Versions.`2025-07-01-preview`)
union ConnectorTemplateRuntimeConfigurationType {
  string,

  /**
   * Helm Configuration Type
   */
  HelmConfiguration,

  /**
   * Managed Configuration Type
   */
  ManagedConfiguration,
}

/**
 * ConnectorTemplateHelmConfiguration properties
 */
@added(Versions.`2025-07-01-preview`)
model ConnectorTemplateHelmConfiguration
  extends ConnectorTemplateRuntimeConfiguration {
  /**
   * The runtime configuration type for the Connector template.
   */
  runtimeConfigurationType: HelmConfiguration;

  /**
   * The Helm configuration settings
   */
  helmConfigurationSettings: ConnectorTemplateHelmConfigurationSettings;
}

/**
 * ConnectorTemplateHelmConfiguration properties
 */
@added(Versions.`2025-07-01-preview`)
model ConnectorTemplateHelmConfigurationSettings {
  /**
   * The registry of the Helm chart.
   */
  registry: string;

  /**
   * The repoistory of the Helm chart.
   */
  repository: string;

  /**
   * The release name of the Helm chart.
   */
  releaseName: string;

  /**
   * The version of the Helm chart.
   */
  version: string;

  /**
   * Authentication secret reference for the Helm chart.
   */
  authSecretRef?: ConnectorTemplateHelmAuthSecretRef;

  /**
   * Advanced configuration for the Helm chart.
   * install, upgrade, and uninstall options for the helm chart such as atomic, wait, timeout, `wait_for_jobs`, and `disable_hooks`
   */
  advancedConfiguration?: ConnectorTemplateHelmAdvancedConfiguration;

  /**
   * A map of values to pass to the helm chart
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Helm values are modeled as record of strings and are not known ahead of time"
  values?: Record<string>;
}

/**
 * ConnectorTemplateManagedConfiguration properties
 */
@added(Versions.`2025-07-01-preview`)
model ConnectorTemplateManagedConfiguration
  extends ConnectorTemplateRuntimeConfiguration {
  /**
   * The runtime configuration type for the Connector template.
   */
  runtimeConfigurationType: ManagedConfiguration;

  /**
   * The managed configuration settings
   */
  managedConfigurationSettings: ConnectorTemplateManagedConfigurationSettings;
}

/**
 * ConnectorTemplateManagedConfiguration properties
 */
@added(Versions.`2025-07-01-preview`)
@discriminator("managedConfigurationType")
model ConnectorTemplateManagedConfigurationSettings {
  /**
   * The type of the managed configuration.
   */
  managedConfigurationType: ConnectorTemplateManagedConfigurationType; // Property could be called `type` instead of `managedConfigurationType`

  /**
   * Allocation settings for the managed configuration.
   */
  allocation?: ConnectorTemplateAllocation;

  /**
   * The persistent volume claim templates for the managed configuration.
   */
  @OpenAPI.extension("x-ms-identifiers", #["mountPath"])
  persistentVolumeClaimTemplates?: ConnectorTemplatePersistentVolumeClaimTemplate[];
}

/**
 * ConnectorTemplatePersistentVolumeClaimTemplate properties
 */
// This differes slightly from the VolumeClaimSpec used by Mq broker. Perhaps we should allign with that.
// Some of the differences are:
// 1. This doesn't have a `selector` property.
// 2. This has a `volumeAttributesClassName` property.
// 3. This has a `mountPath` property.
// 4. This has a `volumeMode` property.
// 5. This doesn't have a `resources.limits` and `resource.claims` property.
// 6. `resource.requests` only has `storage` property but the Mq broker `resource.requests` is defined as `Record<string>`.
@added(Versions.`2025-07-01-preview`)
model ConnectorTemplatePersistentVolumeClaimTemplate {
  /**
   * The mount path for the persistent volume claim.
   */
  mountPath: string;

  /**
   * VolumeName is the binding reference to the PersistentVolume backing this claim.
   */
  volumeName?: string;

  /**
   * volumeMode defines what type of volume is required by the claim. Value of Filesystem is implied when not included in claim spec. This is a beta feature.
   */
  volumeMode?: ConnectorTemplatePersistentVolumeClaimVolumeMode;

  /**
   * A custom volume class name for specific volume attributes or configurations. This can be used to define custom settings for volume provisioning.
   */
  volumeAttributesClassName?: string;

  /**
   * Name of the StorageClass required by the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1
   */
  storageClassName?: string;

  /**
   * AccessModes contains the desired access modes the volume should have. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  accessModes?: string[];

  /**
   * This field can be used to specify either: 
   * - An existing VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot)
   * - An existing PVC (PersistentVolumeClaim) If the provisioner or an external controller can support the specified data source, it will create a new volume based on the contents of the specified data source. 
   * 
   * If the AnyVolumeDataSource feature gate is enabled, this field will always have the same contents as the DataSourceRef field.
   */
  dataSource?: LocalKubernetesReference;

  /**
   * Specifies the object from which to populate the volume with data, if a non-empty volume is desired. 
   * This may be any local object from a non-empty API group (non core object) or a PersistentVolumeClaim object. 
   * When this field is specified, volume binding will only succeed if the type of the specified object matches some installed volume populator or dynamic provisioner. 
   * This field will replace the functionality of the DataSource field and as such if both fields are non-empty, they must have the same value. 
   * For backwards compatibility, both fields (DataSource and DataSourceRef) will be set to the same value automatically if one of them is empty and the other is non-empty. 
   * 
   * There are two important differences between DataSource and DataSourceRef:
   * - While DataSource only allows two specific types of objects, DataSourceRef allows any non-core object, as well as PersistentVolumeClaim objects.
   * - While DataSource ignores disallowed values (dropping them), DataSourceRef preserves all values, and generates an error if a disallowed value is specified. 
   */
  dataSourceRef?: KubernetesReference;

  /**
   * The resource requests for the PVC, such as storage size.
   */
  resources: ConnectorTemplatePersistentVolumeClaimResourceRequirements;
}

/**
 * Volume mode types.
 */
@added(Versions.`2025-07-01-preview`)
union ConnectorTemplatePersistentVolumeClaimVolumeMode {
  string,

  /**
   * Filesystem volume mode
   */
  Filesystem,

  /**
   * Block volume mode
   */
  Block,
}

/**
 * ConnectorTemplatePersistentVolumeClaimResourceRequirements properties
 */
@added(Versions.`2025-07-01-preview`)
model ConnectorTemplatePersistentVolumeClaimResourceRequirements {
  /**
   * Requests represents the minimum amount of compute resources required.
   * If Requests is omitted for any container, the Kubelet will enforce that the container has at least as much CPU/Memory as requested. 
   * If it is omitted for all containers, the Kubelet will enforce that the Pod has at least as much CPU/Memory as requested. More info: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
   */
  requests: ConnectorTemplatePersistentVolumeClaimResourceRequests;
}

/**
 * ConnectorTemplatePersistentVolumeClaimResourceRequests properties
 */
@added(Versions.`2025-07-01-preview`)
model ConnectorTemplatePersistentVolumeClaimResourceRequests {
  /**
   * The storage resource request for the PVC.
   */
  storage: string;
}

/**
 * ConnectorTemplateAllocation properties
 */
@added(Versions.`2025-07-01-preview`)
model ConnectorTemplateAllocation {
  /**
   * The allocation policy type
   */
  policy: ConnectorTemplateAllocationPolicy;

  /**
   * TThe bucketized allocation of AEPs for connectors
   */
  @minValue(1)
  @maxValue(100)
  bucketSize?: int32;
}

/**
 * ConnectorTemplateAllocationPolicy properties
 */
@added(Versions.`2025-07-01-preview`)
union ConnectorTemplateAllocationPolicy {
  string,

  /**
   * Bucketized allocation policy
   */
  Bucketized,
}

/**
 * Managed configuration types.
 */
@added(Versions.`2025-07-01-preview`)
union ConnectorTemplateManagedConfigurationType {
  string,

  /**
   * Image Configuration Type
   */
  ImageConfiguration,

  /**
   * StatefulSet Configuration Type
   */
  StatefulSetConfiguration,
}

/**
 * ConnectorTemplateRuntimeImageConfiguration properties
 */
@added(Versions.`2025-07-01-preview`)
model ConnectorTemplateRuntimeImageConfiguration
  extends ConnectorTemplateManagedConfigurationSettings {
  /**
   * The managed configuration type for the Connector template.
   */
  managedConfigurationType: ImageConfiguration;

  /**
   * The image configuration settings
   */
  imageConfigurationSettings: ConnectorTemplateRuntimeImageConfigurationSettings;
}

/**
 * ConnectorTemplateRuntimeStatefulSetConfiguration properties
 */
@added(Versions.`2025-07-01-preview`)
model ConnectorTemplateRuntimeStatefulSetConfiguration
  extends ConnectorTemplateManagedConfigurationSettings {
  /**
   * The managed configuration type for the Connector template.
   */
  managedConfigurationType: StatefulSetConfiguration;

  /**
   * The stateful set configuration settings
   */
  statefulSetConfigurationSettings: string;
}

/**
 * ConnectorTemplateRuntimeImageConfiguration properties
 */
@added(Versions.`2025-07-01-preview`)
model ConnectorTemplateRuntimeImageConfigurationSettings {
  /**
   * Additional configuration for the image of the managed configuration.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "CRD type is modeled as record of strings"
  additionalConfiguration?: Record<string>;

  /**
   * The image of the managed configuration.
   */
  image: string;

  /**
   * The tag of the image
   */
  imageTag?: string;

  /**
   * The pull policy of the image
   */
  imagePullPolicy?: ConnectorImagePullPolicy;

  /**
   * The digest of the image
   */
  imageDigest?: string;

  /**
   * Image pull secret for the image.
   */
  imagePullSecrets?: ConnectorTemplateImagePullSecret[];

  /**
   * The number of replicas for the managed configuration.
   */
  replicas?: int32;

  /**
   * The persistent volume claims for the managed configuration.
   */
  @OpenAPI.extension("x-ms-identifiers", #["claimName"])
  persistentVolumeClaims?: ConnectorTemplatePersistentVolumeClaim[];
}

/**
 * ConnectorTemplatePersistentVolumeClaim properties
 */
@added(Versions.`2025-07-01-preview`)
model ConnectorTemplatePersistentVolumeClaim {
  /**
   * The name of the persistent volume claim.
   */
  claimName: string;

  /**
   * The mount path for the persistent volume claim.
   */
  mountPath: string;
}

/**
 * ConnectorTemplateImagePullSecret properties
 */
@added(Versions.`2025-07-01-preview`)
model ConnectorTemplateImagePullSecret {
  /**
   * The name of the image pull secret.
   */
  name: string;
}

/**
 * Image pull policy.
 */
@added(Versions.`2025-07-01-preview`)
union ConnectorImagePullPolicy {
  string,

  /**
   * Always pull the image.
   */
  Always,

  /**
   * IfNotPresent pull the image.
   */
  IfNotPresent,

  /**
   * Never pull the image.
   */
  Never,
}

/**
 * ConnectorTemplateHelmAdvancedConfiguration properties
 */
@added(Versions.`2025-07-01-preview`)
model ConnectorTemplateHelmAdvancedConfiguration {
  /**
   * Delete operation configuration for the Helm chart.
   */
  delete?: ConnectorTemplateHelmDeleteConfiguration;

  /**
   * Install operation configuration for the Helm chart.
   */
  install?: ConnectorTemplateHelmInstallConfiguration;

  /**
   * Upgrade operation configuration for the Helm chart.
   */
  upgrade?: ConnectorTemplateHelmUpgradeConfiguration;
}

alias HelmOperationConfiguration = {
  /**
   * The timeout for the operation in seconds.
   */
  timeout?: int32;

  /**
   * The wait for jobs flag.
   */
  waitForJobs?: boolean;

  /**
   * Atomic flag for the operation.
   */
  atomic?: boolean;

  /**
   * Disable hooks flag for the operation.
   */
  disableHooks?: boolean;

  /**
   * The wait flag for the operation.
   */
  wait?: boolean;
};

/**
 * ConnectorTemplateHelmDeleteConfiguration properties
 */
@added(Versions.`2025-07-01-preview`)
model ConnectorTemplateHelmDeleteConfiguration {
  ...HelmOperationConfiguration;
}

/**
 * ConnectorTemplateHelmInstallConfiguration properties
 */
@added(Versions.`2025-07-01-preview`)
model ConnectorTemplateHelmInstallConfiguration {
  ...HelmOperationConfiguration;
}

/**
 * ConnectorTemplateHelmUpgradeConfiguration properties
 */
@added(Versions.`2025-07-01-preview`)
model ConnectorTemplateHelmUpgradeConfiguration {
  ...HelmOperationConfiguration;
}

/**
 * ConnectorTemplateHelmAuthSecretRef properties
 */
@added(Versions.`2025-07-01-preview`)
model ConnectorTemplateHelmAuthSecretRef {
  /**
   * The name of the secret.
   */
  name: string;

  /**
   * The key of the password in the secret.
   */
  passwordKey: string;

  /**
   * The key of the username in the secret.
   */
  usernameKey: string;
}

/**
 * ConnectorTemplateDiagnostics properties
 */
@added(Versions.`2025-07-01-preview`)
model ConnectorTemplateDiagnostics {
  /**
   * The log settings for the Connector template.
   */
  logs: ConnectorTemplateLogSettings;
}

/**
 * ConnectorTemplateLogSettings properties
 */
@added(Versions.`2025-07-01-preview`)
model ConnectorTemplateLogSettings {
  ...DiagnosticsLogs;
}
