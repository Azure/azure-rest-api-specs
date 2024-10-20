import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using Azure.ResourceManager.CommonTypes;

namespace Microsoft.Workloads;

/**
 * Defines the possible values for system lifecycle stage.
 */
union SystemLifecycleStage {
  string,

  /**
   * The stage indicating that the workload system is fully built, and is up & running.
   */
  Active: "Active",

  /**
   * The stage indicating that the workload system is fully built but either not running or being decommissioned.
   */
  InActive: "InActive",

  /**
   * The stage indicating that the workload system is being built.
   */
  InBuild: "InBuild",
}

/**
 * Defines the environment type.
 */
union EnvironmentType {
  string,

  /**
   * Non Production system.
   */
  NonProduction: "NonProduction",

  /**
   * Production system.
   */
  Production: "Production",
}

/**
 * Defines the workload component.
 */
model WorkloadComponent {
  /**
   * Name of the component.
   */
  name: string;

  /**
   * Role of the component.
   */
  role: string;

  /**
   * Resources that are part of the component.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  resources: ResourceConfiguration[];

  /**
   * Metadata pertaining to the component.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Keys of this field are dynamic and vary based on the component, which itself would vary based on the type of the workload (kind of the virtual instance). We cannot use tags here as this field is supposed to be understood by the service and is not for customer usage. Values will always be strings."
  metadata?: Record<string>;
}

/**
 * Defines the resource configuration.
 */
model ResourceConfiguration {
  /**
   * ARM ID of the resource.
   */
  resourceId: string;
}

/**
 * Defines the managed resource group configuration
 */
model ManagedResourceGroupConfiguration {
  /**
   * Name of the managed resource group.
   */
  name?: string;
}

/**
 * Defines the Virtual Instance resource properties.
 */
model VirtualInstanceProperties {
  /**
   * The ID corresponding to the deployment architecture of the system.
   */
  architectureId: string;

  /**
   * The type of environment in which the workload system is deployed - Production / Non Production.
   */
  environmentType: EnvironmentType;

  /**
   * The user defined label indicating the sub category of the environment in which the workload system is deployed.
   */
  environmentLabel?: string;

  /**
   * The priority of the workload system. The value must be an integer between 0 (highest priority) and 9 (lowest priority).
   */
  systemPriority: int32;

  /**
   * The current stage in the lifecycle of the workload system.
   */
  systemLifecycleStage: SystemLifecycleStage;

  /**
   * Components that are part of the workload system.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  components: WorkloadComponent[];

  /**
   * Metadata pertaining to the workload system.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Keys of this field are dynamic and vary based on the type of the workload (kind of the virtual instance). We cannot use tags here as this field is supposed to be understood by the service and is not for customer usage. Values will always be strings."
  metadata?: Record<string>;

  /**
   * The list of ARM IDs of the virtual instances that the system is dependent on. The ARM IDs must belong to the resources of type 'Microsoft.Workloads/virtualInstances'.
   */
  dependsOn?: string[];

  /**
   * Managed resource group configuration
   */
  managedResourceGroupConfiguration?: ManagedResourceGroupConfiguration;

  /**
   * Defines the state of the virtual instance.
   */
  @visibility("read")
  state?: VirtualInstanceState;

  /**
   * Defines the virtual instance provisioning states.
   */
  @visibility("read")
  provisioningState?: VirtualInstanceProvisioningState;

  /**
   * Indicates any errors on the Virtual Instance resource.
   */
  @visibility("read")
  errors?: VirtualInstanceError;
}

/**
 * Defines the Virtual Instance state.
 */
union VirtualInstanceState {
  string,

  /**
   * Registration is in progress.
   */
  DiscoveryInProgress: "DiscoveryInProgress",

  /**
   * Registration has failed.
   */
  DiscoveryFailed: "DiscoveryFailed",

  /**
   * Registration is complete.
   */
  RegistrationComplete: "RegistrationComplete",
}

/**
 * Defines the Virtual Instance provisioning states.
 */
union VirtualInstanceProvisioningState {
  string,

  /**
   * The succeeded provisioning state.
   */
  Succeeded: "Succeeded",

  /**
   * The updating provisioning state.
   */
  Updating: "Updating",

  /**
   * The Creating provisioning state.
   */
  Creating: "Creating",

  /**
   * The Failed provisioning state.
   */
  Failed: "Failed",

  /**
   * The Deleting provisioning state.
   */
  Deleting: "Deleting",

  /**
   * The Canceled provisioning state.
   */
  Canceled: "Canceled",
}

/**
 * An error response from the Workload Center service.
 */
model VirtualInstanceError {
  /**
   * The Virtual Instance error body.
   */
  properties?: ErrorDefinition;
}

/**
 * Error definition.
 */
model ErrorDefinition {
  /**
   * Service specific error code which serves as the substatus for the HTTP error code.
   */
  @visibility("read")
  code?: string;

  /**
   * Description of the error.
   */
  @visibility("read")
  message?: string;

  /**
   * Internal error details.
   */
  @visibility("read")
  @OpenAPI.extension("x-ms-identifiers", [])
  details?: ErrorDefinition[];
}

/**
 * Defines the request body for updating the Virtual Instance.
 */
model UpdateVirtualInstanceRequest {
  /**
   * Gets or sets the Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing field"
  tags?: Record<string>;

  /**
   * Managed service identity (user assigned identities)
   */
  identity?: CommonTypes.ManagedServiceIdentity;

  /**
   * The update properties.
   */
  properties?: UpdateVirtualInstanceProperties;
}

/**
 * Defines the update request body properties for updating the Virtual Instance.
 */
#suppress "@azure-tools/typespec-azure-core/casing-style" "SAP is used for representing the company product."
model UpdateVirtualInstanceProperties {
  /**
   * Components that are part of the workload system.
   */
  @OpenAPI.extension("x-ms-identifiers", [])
  components?: WorkloadComponent[];

  /**
   * Metadata pertaining to the workload system.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Keys of this field are dynamic and vary based on the type of the workload (kind of the virtual instance). We cannot use tags here as this field is supposed to be understood by the service and is not for customer usage. Values will always be strings."
  metadata?: Record<string>;
}
