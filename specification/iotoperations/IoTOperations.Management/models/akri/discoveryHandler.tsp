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
 * AkriDiscoveryHandler resource
 */
@added(Versions.`2025-07-01-preview`)
@parentResource(InstanceResource)
model AkriDiscoveryHandlerResource
  is ProxyResource<AkriDiscoveryHandlerProperties> {
  /**
   * Name of AkriDiscoveryHandler resource
   */
  @pattern("^[a-z0-9][a-z0-9-]*[a-z0-9]$")
  @key("akriDiscoveryHandlerName")
  @path
  @minLength(3)
  @maxLength(63)
  @segment("akriDiscoveryHandlers")
  name: string;

  /**
   * Edge location of the resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property"
  @visibility(Lifecycle.Read, Lifecycle.Create)
  extendedLocation: ExtendedLocation;
}

/**
 * AkriDiscoveryHandler properties
 */
// At the moment, the CRD properties are defined in snake_case. We should change them to camelCase to be consistent with the rest of the API.
@added(Versions.`2025-07-01-preview`)
model AkriDiscoveryHandlerProperties {
  /**
   * The status of the last operation.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * Metadata about AIO.
   */
  aioMetadata?: AkriDiscoveryHandlerAioMetadata;

  /**
   * Additional configuration for the AkriDiscoveryHandler.
   */
  additionalConfiguration?: string;

  /**
   * Diagnostics settings for the AkriDiscoveryHandler.
   */
  diagnostics?: AkriDiscoveryHandlerDiagnostics;

  /**
   * Mode of the AkriDiscoveryHandler.
   */
  mode?: OperationalMode; // Right now in the CRD the property is called `enabled` but it should be `mode`. We should change it in the CRD to be consistent with the rest of the API.

  /**
   * Device inbound endpoint types
   */
  @OpenAPI.extension("x-ms-identifiers", #["endpointType", "version"])
  @minItems(1)
  discoverableDeviceEndpointTypes: AkriDiscoveryHandlerDiscoverableDeviceEndpointType[];

  /**
   * Mqtt connection configuration settings
   */
  mqttConnectionConfiguration?: ConnectorsMqttConnectionConfiguration;

  /**
   * The image configuration for the AkriDiscoveryHandler.
   */
  imageConfiguration: AkriDiscoveryHandlerImageConfiguration;

  /**
   * Schedule for the AkriDiscoveryHandler.
   */
  schedule: AkriDiscoveryHandlerSchedule;
}

/**
 * Metadata about AIO.
 */
@added(Versions.`2025-07-01-preview`)
model AkriDiscoveryHandlerAioMetadata {
  ...AkriAioMetadata;
}
/**
 * AkriDiscoveryHandlerDiagnostics properties
 */
@added(Versions.`2025-07-01-preview`)
model AkriDiscoveryHandlerDiagnostics {
  /**
   * The log settings for the Connector template.
   */
  logs: AkriDiscoveryHandlerLogSettings;
}

/**
 * AkriDiscoveryHandlerLogSettings properties
 */
@added(Versions.`2025-07-01-preview`)
model AkriDiscoveryHandlerLogSettings {
  ...DiagnosticsLogs;
}

/**
 * AkriDiscoveryHandlerDiscoverableDeviceEndpointType properties
 */
@added(Versions.`2025-07-01-preview`)
model AkriDiscoveryHandlerDiscoverableDeviceEndpointType {
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
 * AkriDiscoveryHandler Image configuration
 */
@added(Versions.`2025-07-01-preview`)
model AkriDiscoveryHandlerImageConfiguration {
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
 * AkriDiscoveryHandlerSchedule properties
 */
@added(Versions.`2025-07-01-preview`)
@discriminator("scheduleType")
model AkriDiscoveryHandlerSchedule {
  /**
   * Schedule type
   */
  scheduleType: AkriDiscoveryHandlerScheduleType;
}

/**
 * AkriDiscoveryHandlerScheduleType properties
 */
@added(Versions.`2025-07-01-preview`)
union AkriDiscoveryHandlerScheduleType {
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
 * AkriDiscoveryHandlerScheduleCron properties
 */
@added(Versions.`2025-07-01-preview`)
model AkriDiscoveryHandlerScheduleCron extends AkriDiscoveryHandlerSchedule {
  /**
   * Schedule type
   */
  scheduleType: Cron;

  /**
   * The cron expression for the schedule.
   */
  cron: string; 
}

/**
 * AkriDiscoveryHandlerScheduleRunOnce properties
 */
@added(Versions.`2025-07-01-preview`)
model AkriDiscoveryHandlerScheduleRunOnce extends AkriDiscoveryHandlerSchedule {
  /**
   * Schedule type
   */
  scheduleType: RunOnce;

  /**
   * The time to run the discovery handler.
   */
  runOnce: string; 
}

/**
 * AkriDiscoveryHandlerScheduleContinuous properties
 */
@added(Versions.`2025-07-01-preview`)
model AkriDiscoveryHandlerScheduleContinuous
  extends AkriDiscoveryHandlerSchedule {
  /**
   * Schedule type
   */
  scheduleType: Continuous;

  /**
   * The time to run the discovery handler.
   */
  continuous: string;
}
