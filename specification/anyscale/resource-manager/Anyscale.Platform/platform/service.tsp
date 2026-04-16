import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "./versions.tsp";
import "./project.tsp";
import "./computeConfig.tsp";

using Rest;
using Http;
using Azure.ResourceManager;
using TypeSpec.Versioning;

namespace Anyscale.Platform;

/** An Anyscale service that serves Ray Serve applications. */
@added(Versions.v2026_02_01_preview)
@parentResource(Project)
@resource("services")
model Service is ProxyResource<ServiceProperties> {
  /** The name of the Anyscale service. */
  @pattern("^[a-zA-Z0-9_-]*$")
  @key("serviceName")
  @path
  @segment("services")
  name: string;
}

/** The properties of the Anyscale service. */
@added(Versions.v2026_02_01_preview)
model ServiceProperties {
  /** Deployment config of the Anyscale service. */
  deploymentConfig?: ServiceDeploymentConfig;

  /** The current running state of the service. */
  @visibility(Lifecycle.Read)
  currentState?: ServiceCurrentState;

  /** The hostname of the service endpoint. */
  @visibility(Lifecycle.Read)
  hostname?: string;

  /** The base URL of the service endpoint. */
  @visibility(Lifecycle.Read)
  baseUrl?: string;

  /** Whether the service has auto-rollout enabled. */
  @visibility(Lifecycle.Read)
  autoRolloutEnabled?: boolean;

  /** The primary (stable) version of the service. If the service is terminated, this refers to the most recently active version. */
  @visibility(Lifecycle.Read)
  primaryVersion?: ServiceVersionDetail;

  /** The canary version of the service. Present only during a rolling out state. */
  @visibility(Lifecycle.Read)
  canaryVersion?: ServiceVersionDetail;

  /** The URL link to the service in the Anyscale console. */
  @visibility(Lifecycle.Read)
  url?: string;

  /** The provisioning state of the Anyscale service. */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;
}

/** Configurable deployment properties for a service. These fields are user-writable on create and update. */
@added(Versions.v2026_02_01_preview)
model ServiceDeploymentConfig {
  /** Optional description of the service. */
  description?: string;

  /** The compute config to use for the service. */
  computeConfig?: ComputeConfigSpecOrReference;

  /** The URI of the container image to use for the service. */
  imageUri?: string;

  /** List of Ray Serve applications to run. At least one application must be specified. Each application must include an 'importPath'. See https://docs.ray.io/en/latest/serve/production-guide/config.html for the Ray Serve config format. */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Ray serve config format"
  @identifiers(#[])
  applications?: {}[];

  /** The deployment rollout strategy. Defaults to Rollout. */
  rolloutStrategy?: RolloutStrategy;

  /** The version identifier for this deployment. Auto-generated if not provided. */
  version?: string;

  /** The percentage of traffic to route to the canary version during rollout (0-100). If not set, the service will automatically roll out. */
  @minValue(0)
  @maxValue(100)
  canaryPercent?: int32;

  /** The maximum percentage of excess capacity allowed during rollout (0-100). */
  @minValue(0)
  @maxValue(100)
  maxSurgePercent?: int32;

  /** Whether to automatically complete the rollout when the canary version reaches 100% traffic. Defaults to true. */
  autoCompleteRollout?: boolean;

  /** The traffic percentage for this version in a multi-version deployment (0-100). All version weights must sum to 100. */
  @minValue(0)
  @maxValue(100)
  trafficPercent?: int32;

  /** HTTP protocol configuration. */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Existing use case"
  httpConfig?: {};

  /** gRPC protocol configuration. */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Existing use case"
  grpcConfig?: {};

  /** Auto-termination timeout in seconds. The service will be unconditionally terminated after this period. Setting to 0 disables auto-termination (default). */
  @minValue(0)
  maxUptimeTimeoutSec?: int32;

  /** Environment variables to set on the service cluster. */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Intended to be key value pairs."
  envVars?: {};

  /** Tracing configuration for distributed tracing. */
  tracingConfig?: TracingConfig;

  /** External storage configuration for Ray GCS head node fault tolerance. If populated, head node fault tolerance will be enabled. */
  rayGcsExternalStorageConfig?: RayGcsExternalStorageConfig;

  /** List of connection IDs to associate with the service for third-party integrations. */
  connectionIds?: string[];
}

/** The deployment rollout strategy for a service. */
@added(Versions.v2026_02_01_preview)
union RolloutStrategy {
  /** Deploy to a new cluster and gradually shift traffic via canary deployment. */
  Rollout: "Rollout",

  /** Update the existing cluster in-place via Ray Serve. Only ray_serve_config changes are allowed. */
  InPlace: "InPlace",

  /** Deploy multiple versions simultaneously with explicit traffic allocation. */
  MultiVersion: "MultiVersion",

  string,
}

/** The current running state of a service. */
@added(Versions.v2026_02_01_preview)
union ServiceCurrentState {
  /** The service is initializing. */
  Starting: "Starting",

  /** The service is healthy and running. */
  Running: "Running",

  /** The service has errors but is still running. */
  Unhealthy: "Unhealthy",

  /** Infrastructure or system error. */
  SystemFailure: "SystemFailure",

  /** User configuration error. */
  UserErrorFailure: "UserErrorFailure",

  /** The service configuration is updating. */
  Updating: "Updating",

  /** The service is in the process of rolling out a new version. */
  RollingOut: "RollingOut",

  /** The service is rolling back to a previous version. */
  RollingBack: "RollingBack",

  /** The service is shutting down. */
  Terminating: "Terminating",

  /** The service is fully stopped. */
  Terminated: "Terminated",

  string,
}

/** The state of an individual service version. */
@added(Versions.v2026_02_01_preview)
union ServiceVersionState {
  /** The version state is unknown. */
  Unknown: "Unknown",

  /** The version is initializing. */
  Starting: "Starting",

  /** The version is updating. */
  Updating: "Updating",

  /** The version is running. */
  Running: "Running",

  /** The version has issues. */
  Unhealthy: "Unhealthy",

  /** System failure. */
  SystemFailure: "SystemFailure",

  /** The version is shutting down. */
  Terminating: "Terminating",

  /** The version is stopped. */
  Terminated: "Terminated",

  string,
}

// ==================== Supporting Models ====================

/** Inline summary of a service version, returned as part of the service response. */
@added(Versions.v2026_02_01_preview)
model ServiceVersionDetail {
  /** The version string identifier. */
  version: string;

  /** The target percentage of traffic sent to this version (0-100). */
  @minValue(0)
  @maxValue(100)
  weight: int32;

  /** The current percentage of traffic sent to this version (0-100). */
  @minValue(0)
  @maxValue(100)
  currentWeight?: int32;

  /** The current state of this version. */
  currentState: ServiceVersionState;

  /** The URI of the container image used by this version. */
  imageUri: string;

  /** The ID of the compute configuration used by this version. */
  computeConfig: ComputeConfigSpecOrReference;

  /** List of Ray Serve applications for this version. */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-empty-model" "Ray serve config format"
  @identifiers(#[])
  applications?: {}[];

  /** External storage configuration for Ray GCS head node fault tolerance. If populated, head node fault tolerance will be enabled. */
  rayGcsExternalStorageConfig?: RayGcsExternalStorageConfig;

  /** Tracing configuration for distributed tracing. */
  tracingConfig?: TracingConfig;

  /** The time this version was created. */
  createdAt?: utcDateTime;
}

/** Tracing configuration for distributed tracing. */
@added(Versions.v2026_02_01_preview)
model TracingConfig {
  /** Whether tracing is enabled. If enabled and no exporterImportPath is defined, the default tracing exporter will be used. Defaults to true. */
  enabled?: boolean;

  /** Custom tracing exporter import path. Should be of the form 'module.submodule.export_tracing'. */
  exporterImportPath?: string;

  /** The sampling ratio for tracing (0.0 to 1.0). Reducing the ratio minimizes serving latency and storage overhead. Defaults to 1.0. */
  @minValue(0)
  @maxValue(1)
  samplingRatio?: float64;
}

/** External storage configuration for Ray GCS fault tolerance. */
@added(Versions.v2026_02_01_preview)
model RayGcsExternalStorageConfig {
  /** Address of the external storage (e.g., Redis). Must be accessible from instances in the cloud. */
  address?: string;

  /** Path to the TLS certificate file to use for authentication when using secure connections. Defaults to the cloud-wide configuration. */
  certificatePath?: string;
}

// ==================== Operations ====================

@added(Versions.v2026_02_01_preview)
@armResourceOperations
interface Services {
  get is ArmResourceRead<Service>;
  createOrUpdate is ArmResourceCreateOrReplaceAsync<Service>;
  update is ArmCustomPatchSync<
    Service,
    Azure.ResourceManager.Foundations.ResourceUpdateModel<
      Service,
      ServiceProperties
    >
  >;
  delete is ArmResourceDeleteWithoutOkAsync<Service>;
  listByResourceGroup is ArmResourceListByParent<Service>;
  listBySubscription is ArmListBySubscription<Service>;
}
