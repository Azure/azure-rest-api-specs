import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Microsoft.IoTOperations;

/** AioApplicationConfiguration resource. */
@parentResource(AioApplicationProfileResource)
@added(Versions.`2026-11-01-preview`)
@renamedFrom(
  Versions.`2026-11-01-preview`,
  "AioApplicationConfigurationResource"
)
model AioApplicationConfigurationV1Resource
  is ProxyResource<AioApplicationConfigurationProperties> {
  /** Name of the AioApplicationConfiguration resource. */
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @key("aioApplicationConfigurationName")
  @path
  @minLength(3)
  @maxLength(63)
  @segment("akriEdgeApplicationConfigurations")
  name: string;

  /** Edge location of the resource. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "This Arc-hosted resource supports and advertises only the CustomLocation extended-location type. The standard ExtendedLocationProperty also advertises EdgeZone, which this service does not support. The custom model retains string extensibility for forward compatibility."
  @visibility(Lifecycle.Read, Lifecycle.Create)
  extendedLocation?: ExtendedLocation;
}

/** AioApplicationConfiguration resource. */
@parentResource(AioApplicationDefinitionResource)
@added(Versions.`2026-11-01-preview`)
model AioApplicationConfigurationResource
  is ProxyResource<AioApplicationConfigurationProperties> {
  /** Name of the AioApplicationConfiguration resource. */
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @key("aioApplicationConfigurationName")
  @path
  @minLength(3)
  @maxLength(63)
  @segment("aioApplicationConfigurations")
  name: string;

  /** Edge location of the resource. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "This Arc-hosted resource supports and advertises only the CustomLocation extended-location type. The standard ExtendedLocationProperty also advertises EdgeZone, which this service does not support. The custom model retains string extensibility for forward compatibility."
  @visibility(Lifecycle.Read, Lifecycle.Create)
  extendedLocation?: ExtendedLocation;
}

/** Operator-authored configuration for an edge application. */
@added(Versions.`2026-11-01-preview`)
model AioApplicationConfigurationProperties {
  /** The status of the last operation. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /** Application-defined configuration supplied to every application instance. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Customers bring their own applications and define each application's configuration parameters and structure, so the resource provider cannot define a fixed schema."
  configuration?: Record<unknown>;

  /** Diagnostics settings for the application. */
  diagnostics?: AioApplicationConfigurationDiagnostics;

  /**
   * The network services that expose the application inside the cluster. The
   * operator creates a Kubernetes service for each entry.
   */
  @identifiers(#["name"])
  services?: AioApplicationExposedService[];

  /** Access to customer-defined MQTT topics and State Store keys. */
  aioIntegration?: AioApplicationIntegration;

  /** The runtime configuration for the application. */
  runtimeConfiguration: AioApplicationRuntimeConfiguration;
}

/** Configurable access to customer-defined AIO resources. */
@added(Versions.`2026-11-01-preview`)
model AioApplicationIntegration {
  /**
   * Access to MQTT topics beyond the topics that are implicitly available to
   * the application.
   */
  mqttBroker?: AioApplicationMqttBrokerAccess;

  /**
   * Access to State Store keys beyond the keys that are implicitly available
   * to the application.
   */
  stateStore?: AioApplicationStateStoreAccess;
}

/** The level of access granted to an application. */
@added(Versions.`2026-11-01-preview`)
union AioApplicationAccessMode {
  string,

  /** No access is granted beyond the application's implicit access. */
  NotAllowed: "NotAllowed",

  /** Access is granted to all resources. */
  All: "All",

  /** Access is granted only to the resources listed in the configuration. */
  Specific: "Specific",
}

/** Configurable access to customer-defined MQTT topics. */
@added(Versions.`2026-11-01-preview`)
@discriminator("accessMode")
model AioApplicationMqttBrokerAccess {
  /** The level of access granted to customer-defined MQTT topics. */
  accessMode: AioApplicationAccessMode;
}

/** Configuration that grants no access to additional MQTT topics. */
@added(Versions.`2026-11-01-preview`)
model AioApplicationMqttBrokerNotAllowedAccess
  extends AioApplicationMqttBrokerAccess {
  /** The level of access granted to customer-defined MQTT topics. */
  accessMode: "NotAllowed";
}

/** Configuration that grants access to all MQTT topics. */
@added(Versions.`2026-11-01-preview`)
model AioApplicationMqttBrokerAllAccess extends AioApplicationMqttBrokerAccess {
  /** The level of access granted to customer-defined MQTT topics. */
  accessMode: "All";
}

/** Configuration that grants access to specific MQTT topics. */
@added(Versions.`2026-11-01-preview`)
model AioApplicationMqttBrokerSpecificAccess
  extends AioApplicationMqttBrokerAccess {
  /** The level of access granted to customer-defined MQTT topics. */
  accessMode: "Specific";

  /** The MQTT topic filters that the application can access. */
  @minItems(1)
  allowedTopics: NonEmptyString[];
}

/** Configurable access to customer-defined State Store keys. */
@added(Versions.`2026-11-01-preview`)
@discriminator("accessMode")
model AioApplicationStateStoreAccess {
  /** The level of access granted to customer-defined State Store keys. */
  accessMode: AioApplicationAccessMode;
}

/** Configuration that grants no access to additional State Store keys. */
@added(Versions.`2026-11-01-preview`)
model AioApplicationStateStoreNotAllowedAccess
  extends AioApplicationStateStoreAccess {
  /** The level of access granted to customer-defined State Store keys. */
  accessMode: "NotAllowed";
}

/** Configuration that grants access to all State Store keys. */
@added(Versions.`2026-11-01-preview`)
model AioApplicationStateStoreAllAccess extends AioApplicationStateStoreAccess {
  /** The level of access granted to customer-defined State Store keys. */
  accessMode: "All";
}

/** Configuration that grants access to specific State Store keys. */
@added(Versions.`2026-11-01-preview`)
model AioApplicationStateStoreSpecificAccess
  extends AioApplicationStateStoreAccess {
  /** The level of access granted to customer-defined State Store keys. */
  accessMode: "Specific";

  /** The State Store key names or patterns that the application can access. */
  @minItems(1)
  allowedKeys: NonEmptyString[];
}

/** Runtime configuration for the application. */
@added(Versions.`2026-11-01-preview`)
@discriminator("runtimeConfigurationType")
model AioApplicationRuntimeConfiguration {
  /** The runtime configuration type. */
  runtimeConfigurationType: AioApplicationRuntimeConfigurationType;
}

/** Runtime configuration types. */
@added(Versions.`2026-11-01-preview`)
union AioApplicationRuntimeConfigurationType {
  string,

  /** Image configuration type. */
  ImageConfiguration,
}

/** Image runtime configuration for the application. */
@added(Versions.`2026-11-01-preview`)
model AioApplicationImageConfiguration
  extends AioApplicationRuntimeConfiguration {
  /** The runtime configuration type. */
  runtimeConfigurationType: ImageConfiguration;

  /** The image configuration settings for the application. */
  imageConfigurationSettings: AioApplicationImageConfigurationSettings;
}

/** Image configuration settings for the application. */
@added(Versions.`2026-11-01-preview`)
model AioApplicationImageConfigurationSettings {
  /** The pull policy of the image. */
  imagePullPolicy?: AkriConnectorsImagePullPolicy;

  /**
   * The persistent volume claim templates for the application.
   * See https://raw.githubusercontent.com/kubernetes/kubernetes/refs/heads/master/api/openapi-spec/v3/apis__apps__v1_openapi.json.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "The resource provider forwards complete Kubernetes PersistentVolumeClaim templates without interpreting their contents. The schema varies across supported Kubernetes versions and may contain Kubernetes extension fields, so the API must preserve fields that are not known when this API version is authored."
  @identifiers(#[])
  persistentVolumeClaimTemplates?: Record<unknown>[];

  /** The persistent volume claims mounted onto all application instances. */
  @identifiers(#["claimName"])
  persistentVolumeClaims?: AioApplicationPersistentVolumeClaim[];

  /** Optional readiness probe for the application container. */
  readinessProbe?: AkriConnectorTemplateReadinessProbe;

  /** The number of application replicas. */
  replicas?: int32 = 1;

  /** The compute resources for the application container. */
  @added(Versions.`2026-11-01-preview`)
  resources?: AioApplicationConfigurationResources;

  /** Secrets mounted onto all application instances. */
  @identifiers(#["secretAlias"])
  secrets?: AkriConnectorsSecret[];

  /** Certificates trusted by all application instances. */
  trustSettings?: AioApplicationTrustList;
}

/** Compute resources for the application container. */
@added(Versions.`2026-11-01-preview`)
model AioApplicationConfigurationResources {
  /** The maximum compute resources the application container may use. */
  limits?: AioApplicationResourceQuantities;
}

/** A persistent volume claim mounted by the application. */
@added(Versions.`2026-11-01-preview`)
model AioApplicationPersistentVolumeClaim {
  /** The name of the persistent volume claim. */
  claimName: string;

  /** The mount path for the persistent volume claim. */
  mountPath: string;
}

/** Certificates trusted by the application. */
@added(Versions.`2026-11-01-preview`)
model AioApplicationTrustList {
  /** The secret reference for certificates to trust. */
  trustListSecretRef: string;
}
