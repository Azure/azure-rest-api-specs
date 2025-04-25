import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Versioning;
namespace Microsoft.IoTOperations;

alias OneToOneAllocation = "OneToOneAllocation";
alias BucketizedAllocation = "BucketizedAllocation";

/**
 * ConnectorConfigInstance resource
 */
@parentResource(InstanceResource)
@added(Versions.`2025-07-01-preview`)
model ConnectorConfigInstanceResource is ProxyResource<ConnectorConfigInstanceProperties> {
  /** 
   * Name of ConnectorConfigInstance resource
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
 * ConnectorConfigInstance properties
 */
@added(Versions.`2025-07-01-preview`)
model ConnectorConfigInstanceProperties {
  /**
   * The status of the last operation.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  /**
   * The allocation for the Connector profile.
   */
  allocation?: ConnectorConfigInstanceAllocation;

  /**
   * The asset endpoints assigned to this connector.
   */
  @OpenAPI.extension("x-ms-identifiers", #[])
  assetEndpointProfiless?: ConnectorConfigInstanceAssetEndpointProfiles[];

  /**
   * The runtime configuration for the Connector profile.
   */
  runtimeConfiguration?: ConnectorConfigInstanceRuntimeConfiguration;

  /**
   * Diagnostics settings for the Connector profile.
   */
  diagnostics?: ConnectorConfigInstanceDiagnostics;
}

/**
 * ConnectorConfigInstanceAllocation properties
 */
@added(Versions.`2025-07-01-preview`)
model ConnectorConfigInstanceAllocation {
  /**
   * The allocation type for the Connector profile.
   */
  allocationType?: ConnectorConfigInstanceAllocationType;

  /**
   * The size of the allocation for the Connector Instance when created.
   */
  size?: int32;
}

/**
 * ConnectorConfigInstanceAllocationType properties
 */
@added(Versions.`2025-07-01-preview`)
union ConnectorConfigInstanceAllocationType {
  string,
  /**
   * OneToOneAllocation
   */
  OneToOneAllocation,

  /**
   * BucketizedAllocation
   */
  BucketizedAllocation,
}

/**
 * ConnectorConfigInstanceAssetEndpointProfiles properties
 */
@added(Versions.`2025-07-01-preview`)
model ConnectorConfigInstanceAssetEndpointProfiles {
  /**
   * The asset endpoint profile name.
   */
  aepName?: string;

  /**
   * detection settings for the connector profile
   */
  detectionConfiguration?: ConnectorConfigInstanceDetectionConfiguration;

  /**
   * Stringified JSON for AEP UX
   */
  jsonForm?: string;

  /**
   * Reference to the schema for the additional configuration for the AEP
   */
  aepAdditionalConfigurationSchemaRef?: string;
}

/**
 * ConnectorConfigInstanceDetectionConfiguration properties
 */
@added(Versions.`2025-07-01-preview`)
model ConnectorConfigInstanceDetectionConfiguration {
  /**
   * The operational mode for detection.
   */
  enabled?: OperationalMode;

  /**
   * Limits how many dassets can be created.
   */
  limit?: int32;

  /**
   * Additional configuration for the asset detection
   */
  dassetAdditionalConfiguration?: string; // Is this meant to be assetAdditionalConfigurationSchemaRef?
}

/**
 * ConnectorConfigInstanceRuntimeConfiguration properties
 */
@added(Versions.`2025-07-01-preview`)
model ConnectorConfigInstanceRuntimeConfiguration {
  /**
   * The number of replicas for the connector.
   */
  @minValue(1)
  replicas?: int32;

  /**
   * The resources for the connector.
   */
  resources?: ConnectorConfigInstanceResources;
}

/**
 * ConnectorConfigInstanceResources properties
 */
@added(Versions.`2025-07-01-preview`)
model ConnectorConfigInstanceResources {
  /**
   * The limits for the connector.
   */
  limits?: ConnectorConfigInstanceResourceLimits;

  /**
   * The requests for the connector.
   */
  requests?: ConnectorConfigInstanceResourceRequests;
}

/**
 * ConnectorConfigInstanceResourceLimits properties
 */
@added(Versions.`2025-07-01-preview`)
model ConnectorConfigInstanceResourceLimits {
  /**
   * The CPU limit for the connector.
   */
  cpu?: string;

  /**
   * The memory limit for the connector.
   */
  memory?: string;
}

/**
 * ConnectorConfigInstanceResourceRequests properties
 */
@added(Versions.`2025-07-01-preview`)
model ConnectorConfigInstanceResourceRequests {
  /**
   * The CPU request for the connector.
   */
  cpu?: string;

  /**
   * The memory request for the connector.
   */
  memory?: string;
}

/**
 * ConnectorConfigInstanceDiagnostics properties
 */
@added(Versions.`2025-07-01-preview`)
model ConnectorConfigInstanceDiagnostics {
  /**
   * The log settings for the Connector profile.
   */
  logs?: ConnectorConfigInstanceLogSettings;
}

/**
 * ConnectorConfigInstanceLogSettings properties
 */
@added(Versions.`2025-07-01-preview`)
model ConnectorConfigInstanceLogSettings {
  ...DiagnosticsLogs;
}

