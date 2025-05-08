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
 * AkriConnectorTemplate resource
 */
@parentResource(InstanceResource)
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplateResource
  is ProxyResource<AkriConnectorTemplateProperties> {
  /**
   * Name of AkriConnectorTemplate resource
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
 * AkriConnectorTemplate properties
 */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplateProperties {
  /**
   * The status of the last operation.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Metadata about AIO.
   */
  aioMetadata?: AkriConnectorTemplateAioMetadata;

  /**
   * The runtime configuration for the Connector template.
   */
  runtimeConfiguration: AkriConnectorTemplateRuntimeConfiguration;

  /**
   * Diagnostics settings for the Connector template.
   */
  diagnostics?: AkriConnectorTemplateDiagnostics;

  /**
   * Device inbound endpoint types
   */
  @OpenAPI.extension("x-ms-identifiers", #["endpointType", "version"])
  @minItems(1)
  deviceInboundEndpointTypes: AkriConnectorTemplateDeviceInboundEndpointType[];

  /**
   * Mqtt connection configuration settings
   */
  mqttConnectionConfiguration?: AkriConnectorsMqttConnectionConfiguration;

  /**
   * The version of the Connector template.
   */
  version: string; // Probably not needed.
}

/**
 * AkriConnectorTemplateDeviceInboundEndpointType properties
 */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplateDeviceInboundEndpointType {
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
  configurationSchemaRefs?: AkriConnectorTemplateDeviceInboundEndpointConfigurationSchemaRefs;
}

/**
 * AkriConnectorTemplateDeviceInboundEndpointConfigurationSchemaRefs properties
 */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplateDeviceInboundEndpointConfigurationSchemaRefs {
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

  /**
   * The additional configuration schema reference.
   */
  additionalConfigSchemaRef?: string;

  /**
   * The device endpoint additional configuration schema reference.
   */
  deviceEndpointAdditionalConfigSchemaRef?: string;
}

/**
 * AkriConnectorTemplateAioMetadata properties
 */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplateAioMetadata {
  ...AkriAioMetadata;
}

/**
 * AkriConnectorTemplateRuntimeConfiguration properties
 */
@added(Versions.`2025-07-01-preview`)
@discriminator("runtimeConfigurationType")
model AkriConnectorTemplateRuntimeConfiguration {
  /**
   * Runtime configuration type for the Connector template.
   */
  runtimeConfigurationType: AkriConnectorTemplateRuntimeConfigurationType;
}

/**
 * Runtime configuration types.
 */
@added(Versions.`2025-07-01-preview`)
union AkriConnectorTemplateRuntimeConfigurationType {
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
 * AkriConnectorTemplateHelmConfiguration properties
 */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplateHelmConfiguration
  extends AkriConnectorTemplateRuntimeConfiguration {
  /**
   * The runtime configuration type for the Connector template.
   */
  runtimeConfigurationType: HelmConfiguration;

  /**
   * The Helm configuration settings
   */
  helmConfigurationSettings: AkriConnectorTemplateHelmConfigurationSettings;
}

/**
 * AkriConnectorTemplateHelmConfiguration properties
 */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplateHelmConfigurationSettings {
  /**
   * The registry settings for the helm chart to be used.
   */
  registrySettings?: AkriConnectorsRegistrySettings;

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
  authSecretRef?: AkriConnectorTemplateHelmAuthSecretRef;

  /**
   * Advanced configuration for the Helm chart.
   * install, upgrade, and uninstall options for the helm chart such as atomic, wait, timeout, `wait_for_jobs`, and `disable_hooks`
   */
  advancedConfiguration?: AkriConnectorTemplateHelmAdvancedConfiguration;

  /**
   * A map of values to pass to the helm chart
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Helm values are modeled as record of strings and are not known ahead of time"
  values?: Record<string>;
}

/**
 * AkriConnectorTemplateManagedConfiguration properties
 */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplateManagedConfiguration
  extends AkriConnectorTemplateRuntimeConfiguration {
  /**
   * The runtime configuration type for the Connector template.
   */
  runtimeConfigurationType: ManagedConfiguration;

  /**
   * The managed configuration settings
   */
  managedConfigurationSettings: AkriConnectorTemplateManagedConfigurationSettings;
}

/**
 * AkriConnectorTemplateManagedConfiguration properties
 */
@added(Versions.`2025-07-01-preview`)
@discriminator("managedConfigurationType")
model AkriConnectorTemplateManagedConfigurationSettings {
  /**
   * The type of the managed configuration.
   */
  managedConfigurationType: AkriConnectorTemplateManagedConfigurationType; // Property could be called `type` instead of `managedConfigurationType`

  /**
   * Allocation settings for the managed configuration.
   */
  allocation?: AkriConnectorTemplateAllocation;

  /**
   * The persistent volume claims for the managed configuration.
   */
  @OpenAPI.extension("x-ms-identifiers", #["claimName"])
  persistentVolumeClaims?: AkriConnectorTemplatePersistentVolumeClaim[];

  /**
   * Additional configuration for the image of the managed configuration.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "CRD type is modeled as record of strings"
  additionalConfiguration?: Record<string>;

  /**
   * The persistent volume claim templates for the managed configuration.
   * See https://raw.githubusercontent.com/kubernetes/kubernetes/refs/heads/master/api/openapi-spec/v3/apis__apps__v1_openapi.json
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "This is a Kubernetes resource type"
  @extension("x-ms-identifiers", #[])
  persistentVolumeClaimTemplates?: Record<unknown>[];

  /**
   * Connector secrets that will be mounted onto all connector instances.
   */
  @extension("x-ms-identifiers", #["secretAlias"])
  secrets?: AkriConnectorsSecret[];

  /**
   * Trust list for the connector. This is used to specify the certificates that all connector instances should trust.
   */
  trustSettings?: AkriConnectorTemplateTrustList;
}

/**
 * AkriConnectorTemplateTrustList properties
 */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplateTrustList {
  /**
   * The secret reference for certificates to trust.
   */
  secretRef: string;
}

/**
 * AkriConnectorTemplateAllocation properties
 */
@added(Versions.`2025-07-01-preview`)
@discriminator("policy")
model AkriConnectorTemplateAllocation {
  /**
   * The allocation policy type
   */
  policy: AkriConnectorTemplateAllocationPolicy;
}

/**
 * AkriConnectorTemplateBucketizedAllocation properties
 */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplateBucketizedAllocation
  extends AkriConnectorTemplateAllocation {
  /**
   * The allocation policy type
   */
  policy: Bucketized;

  /**
   * TThe bucketized allocation of AEPs for connectors
   */
  @minValue(1)
  @maxValue(100)
  bucketSize: int32;
}

/**
 * AkriConnectorTemplateAllocationPolicy properties
 */
@added(Versions.`2025-07-01-preview`)
union AkriConnectorTemplateAllocationPolicy {
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
union AkriConnectorTemplateManagedConfigurationType {
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
 * AkriConnectorTemplateRuntimeImageConfiguration properties
 */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplateRuntimeImageConfiguration
  extends AkriConnectorTemplateManagedConfigurationSettings {
  /**
   * The managed configuration type for the Connector template.
   */
  managedConfigurationType: ImageConfiguration;

  /**
   * The image configuration settings
   */
  imageConfigurationSettings: AkriConnectorTemplateRuntimeImageConfigurationSettings;
}

/**
 * AkriConnectorTemplateRuntimeStatefulSetConfiguration properties
 */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplateRuntimeStatefulSetConfiguration
  extends AkriConnectorTemplateManagedConfigurationSettings {
  /**
   * The managed configuration type for the Connector template.
   */
  managedConfigurationType: StatefulSetConfiguration;

  /**
   * The stateful set configuration settings
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "This is a Kubernetes resource type"
  statefulSetConfigurationSettings: Record<unknown>;
}

/**
 * AkriConnectorTemplateRuntimeImageConfiguration properties
 */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplateRuntimeImageConfigurationSettings {
  /**
   * The image name without any registry reference, tag or digest.
   */
  imageName: string;

  /**
   * The pull policy of the image
   */
  imagePullPolicy?: AkriConnectorsImagePullPolicy;

  /**
   * The number of replicas to be set up.
   */
  replicas?: int32;

  /**
   * The registry settings for the image. You can omit this field if using the default docker hub repository or using a local image.
   */
  registrySettings?: AkriConnectorsRegistrySettings;

  /**
   * Optional image tag or digest. If not specified, the default tag is `latest`.
   */
  tagDigestSettings?: AkriConnectorsTagDigestSettings;
}

/**
 * AkriConnectorTemplatePersistentVolumeClaim properties
 */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplatePersistentVolumeClaim {
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
 * AkriConnectorTemplateHelmAdvancedConfiguration properties
 */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplateHelmAdvancedConfiguration {
  /**
   * Delete operation configuration for the Helm chart.
   */
  delete?: AkriConnectorTemplateHelmDeleteConfiguration;

  /**
   * Install operation configuration for the Helm chart.
   */
  install?: AkriConnectorTemplateHelmInstallConfiguration;

  /**
   * Upgrade operation configuration for the Helm chart.
   */
  upgrade?: AkriConnectorTemplateHelmUpgradeConfiguration;
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
 * AkriConnectorTemplateHelmDeleteConfiguration properties
 */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplateHelmDeleteConfiguration {
  ...HelmOperationConfiguration;
}

/**
 * AkriConnectorTemplateHelmInstallConfiguration properties
 */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplateHelmInstallConfiguration {
  ...HelmOperationConfiguration;
}

/**
 * AkriConnectorTemplateHelmUpgradeConfiguration properties
 */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplateHelmUpgradeConfiguration {
  ...HelmOperationConfiguration;
}

/**
 * AkriConnectorTemplateHelmAuthSecretRef properties
 */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplateHelmAuthSecretRef {
  /**
   * The name of the secret.
   */
  secretRef: string;

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
 * AkriConnectorTemplateDiagnostics properties
 */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplateDiagnostics {
  /**
   * The log settings for the Connector template.
   */
  logs: AkriConnectorTemplateLogSettings;
}

/**
 * AkriConnectorTemplateLogSettings properties
 */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplateLogSettings {
  ...DiagnosticsLogs;
}
