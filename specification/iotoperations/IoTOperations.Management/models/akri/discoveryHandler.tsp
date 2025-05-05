import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "./common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

using Azure.ResourceManager;

namespace Microsoft.IoTOperations;

/**
 * DiscoveryHandler resource
 */
@added(Versions.`2025-07-01-preview`)
@parentResource(ConnectorTemplateResource)
model DiscoveryHandlerResource is ProxyResource<DiscoveryHandlerProperties> {
  /**
   * Name of DiscoveryHandler resource
   */
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @key("discoveryHandlerName")
  @path
  @minLength(3)
  @maxLength(63)
  @segment("discoveryHandlers")
  name: string;

  /**
   * Edge location of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  extendedLocation: ExtendedLocation;
}

/**
 * DiscoveryHandler properties
 */
// At the moment, the CRD properties are defined in snake_case. We should change them to camelCase to be consistent with the rest of the API.
@added(Versions.`2025-07-01-preview`)
model DiscoveryHandlerProperties {
  /**
   * The status of the last operation.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Metadata about AIO.
   */
  aioMetadata?: DiscoveryHandlerAioMetadata;

  /**
   * Additional configuration for the DiscoveryHandler.
   */
  additionalConfiguration?: string;

  /**
   * Diagnostics settings for the DiscoveryHandler.
   */
  diagnostics?: DiscoveryHandlerDiagnostics;

  /**
   * Mode of the DiscoveryHandler.
   */
  mode?: OperationalMode; // Right now in the CRD the property is called `enabled` but it should be `mode`. We should change it in the CRD to be consistent with the rest of the API.

  /**
   * Device inbound endpoint types
   */
  @OpenAPI.extension("x-ms-identifiers", #["endpointType", "version"])
  @minItems(1)
  discoverableDeviceEndpointTypes: DiscoveryHandlerDiscoverableDeviceEndpointType[];

  /**
   * Mqtt connection configuration settings
   */
  mqttConnectionConfiguration?: ConnectorsMqttConnectionConfiguration;

  /**
   * The image configuration for the DiscoveryHandler.
   */
  imageConfiguration: DiscoveryHandlerImageConfiguration;

  /**
   * Schedule for the DiscoveryHandler.
   */
  schedule: DiscoveryHandlerSchedule;
}

/**
 * Metadata about AIO.
 */
@added(Versions.`2025-07-01-preview`)
model DiscoveryHandlerAioMetadata {
  ...AkriAioMetadata;
}
/**
 * DiscoveryHandlerDiagnostics properties
 */
@added(Versions.`2025-07-01-preview`)
model DiscoveryHandlerDiagnostics {
  /**
   * The log settings for the Connector template.
   */
  logs: DiscoveryHandlerLogSettings;
}

/**
 * DiscoveryHandlerLogSettings properties
 */
@added(Versions.`2025-07-01-preview`)
model DiscoveryHandlerLogSettings {
  ...DiagnosticsLogs;
}

/**
 * DiscoveryHandlerDiscoverableDeviceEndpointType properties
 */
@added(Versions.`2025-07-01-preview`)
model DiscoveryHandlerDiscoverableDeviceEndpointType {
  /**
   * The type of the endpoint.
   */
  endpointType: NonEmptyString;

  /**
   * The version of the endpoint.
   */
  version: NonEmptyString;
}

/**
 * DiscoveryHandler Image configuration
 */
@added(Versions.`2025-07-01-preview`)
model DiscoveryHandlerImageConfiguration {
  /**
   * The image of the managed configuration.
   */
  image: string;

  /**
   * The pull policy of the image
   */
  imagePullPolicy: ConnectorsImagePullPolicy;

  /**
   * Image pull secret for the image.
   */
  imagePullSecrets?: ConnectorsImagePullSecret[];

  /**
   * The number of replicas for the managed configuration.
   */
  replicas?: int32;
}

/**
 * DiscoveryHandlerSchedule properties
 */
@added(Versions.`2025-07-01-preview`)
@discriminator("scheduleType")
model DiscoveryHandlerSchedule {
  /**
   * Schedule type
   */
  scheduleType: DiscoveryHandlerScheduleType;
}

/**
 * DiscoveryHandlerScheduleType properties
 */
@added(Versions.`2025-07-01-preview`)
union DiscoveryHandlerScheduleType {
  string,

  /**
   * The schedule is a cron expression.
   */
  Cron,

  /**
   * The discovery handler should run once.
   */
  RunOnce,

  /**
   * The discovery handler should run continuously.
   */
  Continuous,
}

/**
 * DiscoveryHandlerScheduleCron properties
 */
@added(Versions.`2025-07-01-preview`)
model DiscoveryHandlerScheduleCron extends DiscoveryHandlerSchedule {
  /**
   * Schedule type
   */
  scheduleType: Cron;

  /**
   * The cron expression for the schedule.
   */
  cron?: string; // Should this be required?
}

/**
 * DiscoveryHandlerScheduleRunOnce properties
 */
@added(Versions.`2025-07-01-preview`)
model DiscoveryHandlerScheduleRunOnce extends DiscoveryHandlerSchedule {
  /**
   * Schedule type
   */
  scheduleType: RunOnce;

  /**
   * The time to run the discovery handler.
   */
  // Is this description correct?
  runOnce?: string; // Should this be required?
}

/**
 * DiscoveryHandlerScheduleContinuous properties
 */
@added(Versions.`2025-07-01-preview`)
model DiscoveryHandlerScheduleContinuous extends DiscoveryHandlerSchedule {
  /**
   * Schedule type
   */
  scheduleType: Continuous;

  /**
   * The time to run the discovery handler.
   */
  // Is this description correct?
  continuous?: string; // Should this be required?
}
