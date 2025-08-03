import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

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

  /**
   * Disaster recovery system.
   */
  DisasterRecovery: "DisasterRecovery",
}

/**
 * Defines the Virtual Instance compliance state.
 */
union WorkloadComplianceState {
  string,

  /**
   * Not compliant as per the workload definition.
   */
  NonCompliant: "NonCompliant",

  /**
   * Compliant as per the workload definition.
   */
  Compliant: "Compliant",
}

/**
 * Defines the enrollment state of a Virtual Instance / Component as per the workload definition.
 */
union WorkloadEnrollmentState {
  string,

  /**
   * Indicates the state where the VI / Component isn't fully following the workload definition and thus, enrollment needing attention.
   */
  NeedsAttention: "NeedsAttention",

  /**
   * Indicates the state where the VI / Component is fully following the workload definition and thus, enrollment being complete.
   */
  Completed: "Completed",
}

/**
 * Defines the link type applicable for the linked resources.
 */
@added(Versions.v2025_06_01_preview)
union LinkType {
  string,

  /**
   * Indicates the Dependency link type.
   */
  Dependency: "Dependency",

  /**
   * Indicates the Disaster Recovery link type.
   */
  DisasterRecovery: "DisasterRecovery",
}

/**
 * Defines the resource provisioning states.
 */
union ResourceProvisioningState {
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

scalar WorkloadResourceId
  extends Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Workloads/virtualInstances",
    }
  ]>;

/**
 * Defines the Virtual Instance resource properties.
 */
model VirtualInstanceProperties {
  /**
   * The ID corresponding to the deployment architecture of the system.
   * The workload specific information including the workload type, definition ID and version.
   */
  @removed(Versions.v2025_06_01_preview)
  architectureId: string;

  /**
   * The workload specific information including the workload type, definition ID and version.
   */
  @added(Versions.v2025_06_01_preview)
  workloadInfo: WorkloadInfo;

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
  @minValue(0)
  @maxValue(9)
  systemPriority?: int32;

  /**
   * The current stage in the lifecycle of the workload system.
   */
  systemLifecycleStage: SystemLifecycleStage;

  /**
   * Metadata pertaining to the workload system.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Keys of this field are dynamic and vary based on the type of the workload. We cannot use tags here as this field is supposed to be understood by the service and is not for customer usage. Values will always be strings."
  metadata?: Record<string>;

  /**
   * The list of ARM IDs of the virtual instances that the system is dependent on. The ARM IDs must belong to the resources of type 'Microsoft.Workloads/virtualInstances'.
   */
  @removed(Versions.v2025_06_01_preview)
  dependencies?: WorkloadResourceId[];

  /**
   * The list of the linked resource objects.
   */
  @Azure.ResourceManager.identifiers(#[])
  @added(Versions.v2025_06_01_preview)
  linkedResources?: LinkedResource[];

  /**
   * Defines the compliance state of the virtual instance, as per the corresponding workload definition and architecture.
   */
  @visibility(Lifecycle.Read)
  complianceState?: WorkloadComplianceState;

  /**
   * Defines the enrollment state of the virtual instance, as per the corresponding workload definition.
   */
  @visibility(Lifecycle.Read)
  @added(Versions.v2025_06_01_preview)
  enrollmentState?: WorkloadEnrollmentState;

  /**
   * Indicates any enrollment related errors on the Virtual Instance resource.
   */
  @visibility(Lifecycle.Read)
  @added(Versions.v2025_06_01_preview)
  enrollmentErrors?: CommonTypes.ErrorDetail;

  /**
   * Defines the virtual instance provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  /**
   * Indicates any errors on the Virtual Instance resource.
   */
  @visibility(Lifecycle.Read)
  errors?: CommonTypes.ErrorDetail;
}

/**
 * Defines the workload information object.
 */
@added(Versions.v2025_06_01_preview)
model WorkloadInfo {
  /**
   * The type of the workload.
   */
  workloadType: string;

  /**
   * The name of the corresponding workload definition.
   */
  workloadDefinitionName: string;

  /**
   * The version selected for the corresponding workload definition.
   */
  workloadDefinitionVersion?: string;
}

/**
 * Defines the workload information object for update scenarios.
 */
@added(Versions.v2025_06_01_preview)
model UpdateWorkloadInfo {
  /**
   * The version selected for the corresponding workload definition.
   */
  workloadDefinitionVersion?: string;
}

/**
 * Defines the linked Resource class.
 */
@added(Versions.v2025_06_01_preview)
model LinkedResource {
  /**
   * ARM ID of the linked resource. The ARM IDs must belong to the resources of type 'Microsoft.Workloads/virtualInstances'.
   */
  resourceId: WorkloadResourceId;

  /**
   * The type of the link.
   */
  linkType: LinkType;
}

/**
 * Defines the request body for updating the Virtual Instance resource.
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
   * The properties to be updated.
   */
  properties?: UpdateVirtualInstanceProperties;
}

/**
 * Defines the update request body properties for updating the Virtual Instance resource.
 */
model UpdateVirtualInstanceProperties {
  /**
   * The workload specific information including the workload type, definition ID and version.
   */
  @added(Versions.v2025_06_01_preview)
  workloadInfo?: UpdateWorkloadInfo;

  /**
   * The type of environment in which the workload system is deployed - Production / Non Production.
   */
  @added(Versions.v2025_06_01_preview)
  environmentType?: EnvironmentType;

  /**
   * The user defined label indicating the sub category of the environment in which the workload system is deployed.
   */
  environmentLabel?: string;

  /**
   * The priority of the workload system. The value must be an integer between 0 (highest priority) and 9 (lowest priority).
   */
  systemPriority?: int32;

  /**
   * The current stage in the lifecycle of the workload system.
   */
  systemLifecycleStage?: SystemLifecycleStage;

  /**
   * Metadata pertaining to the workload system.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Keys of this field are dynamic and vary based on the type of the workload. We cannot use tags here as this field is supposed to be understood by the service and is not for customer usage. Values will always be strings."
  metadata?: Record<string>;

  /**
   * The list of the linked resource objects.
   */
  @Azure.ResourceManager.identifiers(#[])
  @added(Versions.v2025_06_01_preview)
  linkedResources?: LinkedResource[];
}

/**
 * Defines the workload component properties.
 */
model WorkloadComponentProperties {
  /**
   * Type of the component. Allowed values change based on the workload type and will be defined in the workload definition. Examples include "application", "database", "central" etc.
   */
  componentType: string;

  /**
   * Role of the component. There can be multiple roles for a same component type. Allowed values change based on the workload type and will be defined in the workload definition. Examples of Role for SAP workloads include "pas"/"aas" for application component, "ascs"/"ers" for central component, "backup", etc.
   */
  componentRole?: string;

  /**
   * Resources that are part of the component. The entries in this list should be unique and correspond to a single Azure resource.
   */
  @Azure.ResourceManager.identifiers(#[])
  resources: ResourceConfiguration[];

  /**
   * Metadata pertaining to the component.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Keys of this field are dynamic and vary based on the component, which itself would vary based on the type of the workload. We cannot use tags here as this field is supposed to be understood by the service and is not for customer usage. Values will always be strings."
  metadata?: Record<string>;

  /**
   * Defines the compliance state of the workload component, as per the corresponding workload definition and architecture.
   */
  @visibility(Lifecycle.Read)
  complianceState?: WorkloadComplianceState;

  /**
   * Defines the enrollment state of the workload component, as per the corresponding workload definition.
   */
  @visibility(Lifecycle.Read)
  @added(Versions.v2025_06_01_preview)
  enrollmentState?: WorkloadEnrollmentState;

  /**
   * Indicates any enrollment related errors on the workload component resource.
   */
  @visibility(Lifecycle.Read)
  @added(Versions.v2025_06_01_preview)
  enrollmentErrors?: CommonTypes.ErrorDetail;

  /**
   * Defines the workload component provisioning state.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: ResourceProvisioningState;

  /**
   * Indicates any errors on the workload component resource.
   */
  @visibility(Lifecycle.Read)
  errors?: CommonTypes.ErrorDetail;
}

/**
 * Defines the resource configuration.
 */
model ResourceConfiguration {
  /**
   * ARM ID of the resource.
   */
  resourceId: armResourceIdentifier;
}

/**
 * Defines the request body for updating the workload component resource.
 */
model UpdateWorkloadComponentRequest {
  /**
   * Gets or sets the Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing field"
  tags?: Record<string>;

  /**
   * The properties to be updated.
   */
  properties?: UpdateWorkloadComponentProperties;
}

/**
 * Defines the update request body properties for updating the workload component resource.
 */
model UpdateWorkloadComponentProperties {
  /**
   * Resources that are part of the component.
   */
  @Azure.ResourceManager.identifiers(#[])
  resources?: ResourceConfiguration[];

  /**
   * Metadata pertaining to the component.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Keys of this field are dynamic and vary based on the component, which itself would vary based on the type of the workload. We cannot use tags here as this field is supposed to be understood by the service and is not for customer usage. Values will always be strings."
  metadata?: Record<string>;
}
