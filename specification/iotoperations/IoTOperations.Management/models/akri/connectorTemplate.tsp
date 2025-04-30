import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;
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
  mqttConnectionConfiguration?: ConnectorsMqttConnectionConfiguration;

  /**
   * The version of the Connector template.
   */
  version: string; // Probably not needed.
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
  ...AkriAioMetadata;
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
   * The repository of the Helm chart.
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
   * See https://raw.githubusercontent.com/kubernetes/kubernetes/refs/heads/master/api/openapi-spec/v3/apis__apps__v1_openapi.json
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "This is a Kuberntes resource type"
  @extension("x-ms-identifiers", #[])
  persistentVolumeClaimTemplates?: Record<unknown>[];
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
  imagePullPolicy?: ConnectorsImagePullPolicy;

  /**
   * The digest of the image
   */
  imageDigest?: string;

  /**
   * Image pull secret for the image.
   */
  imagePullSecrets?: ConnectorsImagePullSecret[];

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
