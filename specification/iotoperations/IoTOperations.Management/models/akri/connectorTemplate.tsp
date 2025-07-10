import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;
using TypeSpec.OpenAPI;
using Azure.ClientGenerator.Core;

namespace Microsoft.IoTOperations;

/** AkriConnectorTemplate resource. */
@parentResource(InstanceResource)
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplateResource
  is ProxyResource<AkriConnectorTemplateProperties> {
  /** Name of AkriConnectorTemplate resource. */
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @key("akriConnectorTemplateName")
  @path
  @minLength(3)
  @maxLength(63)
  @segment("akriConnectorTemplates")
  name: string;

  /** Edge location of the resource. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  extendedLocation?: ExtendedLocation;
}

/** AkriConnectorTemplate properties. */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplateProperties {
  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /** Metadata about AIO. */
  aioMetadata?: AkriConnectorTemplateAioMetadata;

  /** The runtime configuration for the Connector template. */
  runtimeConfiguration: AkriConnectorTemplateRuntimeConfiguration;

  /** Diagnostics settings for the Connector template. */
  diagnostics?: AkriConnectorTemplateDiagnostics;

  /** Device inbound endpoint types. */
  @identifiers(#["endpointType", "version"])
  @minItems(1)
  deviceInboundEndpointTypes: AkriConnectorTemplateDeviceInboundEndpointType[];

  /** Mqtt connection configuration settings. */
  mqttConnectionConfiguration?: AkriConnectorsMqttConnectionConfiguration;
}

/** AkriConnectorTemplateDeviceInboundEndpointType properties. */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplateDeviceInboundEndpointType {
  /** A description of the device inbound endpoint. */
  description?: string;

  /** The type of the device inbound endpoint. */
  endpointType: NonEmptyString;

  /** The version of the device inbound endpoint. */
  version?: NonEmptyString;

  /** The configuration schema references for the device inbound endpoint. */
  configurationSchemaRefs?: AkriConnectorTemplateDeviceInboundEndpointConfigurationSchemaRefs;
}

/** AkriConnectorTemplateDeviceInboundEndpointConfigurationSchemaRefs properties. */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplateDeviceInboundEndpointConfigurationSchemaRefs {
  /** The default configuration schema reference for datasets. */
  defaultDatasetConfigSchemaRef?: string;

  /** The default configuration schema reference for events. */
  defaultEventsConfigSchemaRef?: string;

  /** The default configuration schema reference for process control. */
  defaultProcessControlConfigSchemaRef?: string;

  /** The default configuration schema reference for streams. */
  defaultStreamsConfigSchemaRef?: string;

  /** The additional configuration schema reference. */
  additionalConfigSchemaRef?: string;
}

/** AkriConnectorTemplateAioMetadata properties. */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplateAioMetadata {
  ...AkriAioMetadata;
}

/** AkriConnectorTemplateRuntimeConfiguration properties. */
@added(Versions.`2025-07-01-preview`)
@discriminator("runtimeConfigurationType")
model AkriConnectorTemplateRuntimeConfiguration {
  /** Runtime configuration type for the Connector template. */
  runtimeConfigurationType: AkriConnectorTemplateRuntimeConfigurationType;
}

/** Runtime configuration types. */
@added(Versions.`2025-07-01-preview`)
union AkriConnectorTemplateRuntimeConfigurationType {
  string,

  /** Helm Configuration Type. */
  HelmConfiguration,

  /** Managed Configuration Type. */
  ManagedConfiguration,
}

/** AkriConnectorTemplateHelmConfiguration properties. */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplateHelmConfiguration
  extends AkriConnectorTemplateRuntimeConfiguration {
  /** The runtime configuration type for the Connector template. */
  runtimeConfigurationType: HelmConfiguration;

  /** The Helm configuration settings. */
  helmConfigurationSettings: AkriConnectorTemplateHelmConfigurationSettings;
}

/** AkriConnectorTemplateHelmConfiguration properties. */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplateHelmConfigurationSettings {
  /** The registry settings for the helm chart to be used. */
  registrySettings?: AkriConnectorTemplateHelmRegistrySettings;

  /** The release name of the Helm chart. */
  releaseName: string;

  /** The name of the repository */
  repositoryName: string;

  /** The version of the Helm chart. */
  version: string;

  /**
   * Advanced configuration for the Helm chart.
   * Install, upgrade, and uninstall options for the helm chart such as atomic, wait, timeout, `wait_for_jobs`, and `disable_hooks`.
   */
  advancedConfiguration?: AkriConnectorTemplateHelmAdvancedConfiguration;

  /** A map of values to pass to the helm chart. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Helm values are modeled as record of strings and are not known ahead of time"
  values?: Record<string>;
}

/** AkriConnectorTemplateHelmRegistrySettings properties. */
@added(Versions.`2025-07-01-preview`)
@discriminator("registrySettingsType")
model AkriConnectorTemplateHelmRegistrySettings {
  registrySettingsType: AkriConnectorTemplateHelmRegistrySettingsType;
}

/** AkriConnectorTemplateHelmRegistrySettingsType values. */
@added(Versions.`2025-07-01-preview`)
union AkriConnectorTemplateHelmRegistrySettingsType {
  string,

  /** A Registry Endpoint reference. */
  RegistryEndpointRef,

  /** A Container Registry reference. */
  ContainerRegistry,
}

/** AkriConnectorTemplateHelmRegistryEndpointRef properties. */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplateHelmRegistryEndpointRef
  extends AkriConnectorTemplateHelmRegistrySettings {
  /** The registry endpoint reference. */
  registrySettingsType: RegistryEndpointRef;

  /** The name of the registry endpoint. */
  registryEndpointRef: string;
}

/** AkriConnectorTemplateHelmContainerRegistry properties. */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplateHelmContainerRegistry
  extends AkriConnectorTemplateHelmRegistrySettings {
  /** The container registry reference. */
  registrySettingsType: ContainerRegistry;

  /** The registry settings for the container registry. */
  containerRegistrySettings: AkriConnectorTemplateHelmContainerRegistrySettings;
}

/** AkriConnectorTemplateHelmContainerRegistrySettings properties. */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplateHelmContainerRegistrySettings {
  /** The registry to use for the Helm chart. */
  registry: string;

  /** Optional reference to a secret in the same namespace to use for pulling the Helm chart. */
  authSecretRef?: AkriConnectorTemplateHelmAuthSecretRef;
}

/** AkriConnectorTemplateHelmAuthSecretRef properties. */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplateHelmAuthSecretRef {
  /** The name of the secret. */
  secretRef: string;

  /** The key of the password in the secret. */
  passwordKey: string;

  /** The key of the username in the secret. */
  usernameKey: string;
}

/** AkriConnectorTemplateManagedConfiguration properties. */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplateManagedConfiguration
  extends AkriConnectorTemplateRuntimeConfiguration {
  /** The runtime configuration type for the Connector template. */
  runtimeConfigurationType: ManagedConfiguration;

  /** The managed configuration settings. */
  managedConfigurationSettings: AkriConnectorTemplateManagedConfigurationSettings;
}

/** AkriConnectorTemplateManagedConfiguration properties. */
@added(Versions.`2025-07-01-preview`)
@discriminator("managedConfigurationType")
model AkriConnectorTemplateManagedConfigurationSettings {
  /** The type of the managed configuration. */
  managedConfigurationType: AkriConnectorTemplateManagedConfigurationType;

  /** Allocation settings for the managed configuration. */
  allocation?: AkriConnectorTemplateAllocation;

  /** The persistent volume claims for the managed configuration. */
  @identifiers(#["claimName"])
  persistentVolumeClaims?: AkriConnectorTemplatePersistentVolumeClaim[];

  /** Additional configuration for the image of the managed configuration. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "CRD type is modeled as record of strings"
  additionalConfiguration?: Record<string>;

  /**
   * The persistent volume claim templates for the managed configuration.
   * See https://raw.githubusercontent.com/kubernetes/kubernetes/refs/heads/master/api/openapi-spec/v3/apis__apps__v1_openapi.json.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "This is a Kubernetes resource type"
  @identifiers(#[])
  persistentVolumeClaimTemplates?: Record<unknown>[];

  /** Connector secrets that will be mounted onto all connector instances. */
  @identifiers(#["secretAlias"])
  secrets?: AkriConnectorsSecret[];

  /** Trust list for the connector. This is used to specify the certificates that all connector instances should trust. */
  trustSettings?: AkriConnectorTemplateTrustList;
}

/** AkriConnectorTemplateTrustList properties. */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplateTrustList {
  /** The secret reference for certificates to trust. */
  trustListSecretRef: string;
}

/** AkriConnectorTemplateAllocation properties. */
@added(Versions.`2025-07-01-preview`)
@discriminator("policy")
model AkriConnectorTemplateAllocation {
  /** The allocation policy type. */
  policy: AkriConnectorTemplateAllocationPolicy;
}

/** AkriConnectorTemplateBucketizedAllocation properties. */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplateBucketizedAllocation
  extends AkriConnectorTemplateAllocation {
  /** The allocation policy type. */
  policy: Bucketized;

  /** The bucketized allocation of AEPs for connectors. */
  @minValue(1)
  @maxValue(100)
  bucketSize: int32;
}

/** AkriConnectorTemplateAllocationPolicy properties. */
@added(Versions.`2025-07-01-preview`)
union AkriConnectorTemplateAllocationPolicy {
  string,

  /** Bucketized allocation policy. */
  Bucketized,
}

/** Managed configuration types. */
@added(Versions.`2025-07-01-preview`)
union AkriConnectorTemplateManagedConfigurationType {
  string,

  /** Image Configuration Type. */
  ImageConfiguration,

  /** StatefulSet Configuration Type. */
  StatefulSetConfiguration,
}

/** AkriConnectorTemplateRuntimeImageConfiguration properties. */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplateRuntimeImageConfiguration
  extends AkriConnectorTemplateManagedConfigurationSettings {
  /** The managed configuration type for the Connector template. */
  managedConfigurationType: ImageConfiguration;

  /** The image configuration settings. */
  imageConfigurationSettings: AkriConnectorTemplateRuntimeImageConfigurationSettings;
}

/** AkriConnectorTemplateRuntimeStatefulSetConfiguration properties. */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplateRuntimeStatefulSetConfiguration
  extends AkriConnectorTemplateManagedConfigurationSettings {
  /** The managed configuration type for the Connector template. */
  managedConfigurationType: StatefulSetConfiguration;

  /**
   * The stateful set configuration settings. This corresponds to the Kubernetes StatefulSet resource.
   * See https://raw.githubusercontent.com/kubernetes/kubernetes/refs/heads/master/api/openapi-spec/v3/apis__apps__v1_openapi.json#/components/schemas/io.k8s.api.apps.v1.StatefulSetSpec
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "This is a Kubernetes resource type"
  statefulSetConfigurationSettings: Record<unknown>;
}

/** AkriConnectorTemplateRuntimeImageConfiguration properties. */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplateRuntimeImageConfigurationSettings {
  /** The image name without any registry reference, tag or digest. */
  imageName: string;

  /** The pull policy of the image. */
  imagePullPolicy?: AkriConnectorsImagePullPolicy;

  /** The number of replicas to be set up. */
  replicas?: int32;

  /** The registry settings for the image. You can omit this field if using the default docker hub repository or using a local image. */
  registrySettings?: AkriConnectorsRegistrySettings;

  /** Optional image tag or digest. If not specified, the default tag is `latest`. */
  tagDigestSettings?: AkriConnectorsTagDigestSettings;
}

/** AkriConnectorTemplatePersistentVolumeClaim properties. */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplatePersistentVolumeClaim {
  /** The name of the persistent volume claim. */
  claimName: string;

  /** The mount path for the persistent volume claim. */
  mountPath: string;
}

/** AkriConnectorTemplateHelmAdvancedConfiguration properties. */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplateHelmAdvancedConfiguration {
  /** Delete operation configuration for the Helm chart. */
  delete?: AkriConnectorTemplateHelmDeleteConfiguration;

  /** Install operation configuration for the Helm chart. */
  install?: AkriConnectorTemplateHelmInstallConfiguration;

  /** Upgrade operation configuration for the Helm chart. */
  upgrade?: AkriConnectorTemplateHelmUpgradeConfiguration;
}

alias HelmOperationConfiguration = {
  /** Time to wait for any individual Kubernetes operation (like `Jobs` for hooks). */
  timeout?: int32;

  /** If set, the operation will wait for jobs to complete before marking the release as successful. */
  waitForJobs?: boolean;

  /** If set, the operation will be atomic. If the operation fails, all changes will be rolled back. */
  atomic?: boolean;

  /** Disable pre/post upgrade hooks for the operation. */
  disableHooks?: boolean;

  /** If set, the operation will wait until all Pods, PVCs, Services, and minimum number of Pods of a `Deployment`, `StatefulSet`, or `ReplicaSet` are in a ready state before marking the release as successful. */
  wait?: boolean;
};

/** AkriConnectorTemplateHelmDeleteConfiguration properties. */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplateHelmDeleteConfiguration {
  ...HelmOperationConfiguration;
}

/** AkriConnectorTemplateHelmInstallConfiguration properties. */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplateHelmInstallConfiguration {
  ...HelmOperationConfiguration;
}

/** AkriConnectorTemplateHelmUpgradeConfiguration properties. */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplateHelmUpgradeConfiguration {
  ...HelmOperationConfiguration;
}

/** AkriConnectorTemplateDiagnostics properties. */
@added(Versions.`2025-07-01-preview`)
model AkriConnectorTemplateDiagnostics {
  /** The log settings for the Connector template. */
  logs: AkriConnectorsDiagnosticsLogs;
}
