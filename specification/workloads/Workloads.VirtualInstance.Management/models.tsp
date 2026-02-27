import "@typespec/http";

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
 * Defines the state of change detection functionality.
 */
@added(Versions.v2026_02_01_preview)
union ChangeDetectionState {
  string,

  /** Change detection is enabled and will run based on the configured frequency. */
  Enabled: "Enabled",

  /** Change detection is disabled and will not run. */
  Disabled: "Disabled",
}

/**
 * Defines the execution mode for discovery operations.
 */
@added(Versions.v2026_02_01_preview)
union DiscoveryExecutionMode {
  string,

  /** Execute the discovery process as part of this request. */
  Execute: "Execute",

  /** Skip the discovery process; only update configuration without running discovery. */
  Skip: "Skip",
}

/**
 * Defines the configuration settings for change detection functionality.
 */
@added(Versions.v2026_02_01_preview)
model ChangeDetectionConfiguration {
  /**
   * The state of the Change Detection (CD) functionality.
   * When set to 'Enabled', the system will execute CD based on the configured frequency.
   * When set to 'Disabled', CD processing will be skipped entirely.
   * Required on create, optional on update. Defaults to 'Disabled' if not provided on create.
   */
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  state?: ChangeDetectionState;

  /**
   * Specifies how frequently the Change Detection (CD) process should run.
   * The value must be an ISO 8601 duration string between 1 hour (PT1H) and 1 day (P1D).
   * Examples: "PT1H" (1 hour), "PT6H" (6 hours), "P1D" (1 day).
   * Defaults to "PT1H" if not provided.
   */
  frequency?: string;
}

/**
 * Defines the change detection information including configuration and errors.
 */
@added(Versions.v2026_02_01_preview)
model ChangeDetection {
  /**
   * The configuration settings for change detection functionality.
   * If not provided, the service automatically enables change detection with default settings
   * (state: Enabled, frequency: PT1H) and returns the configuration in the response.
   */
  configuration?: ChangeDetectionConfiguration;

  /**
   * Indicates any change detection related errors on the Virtual Instance resource.
   */
  @visibility(Lifecycle.Read)
  errors?: CommonTypes.ErrorDetail;
}

/**
 * Defines the type of discovery configuration.
 */
@added(Versions.v2026_02_01_preview)
union DiscoveryConfigurationType {
  string,

  /** SAP API discovery type for discovering SAP systems via API calls. */
  SAPAPI: "SAPAPI",
}

/**
 * Defines the base configuration for automated discovery. The discovery type determines
 * the specific configuration properties available for each discovery workflow.
 */
@discriminator("discoveryType")
@added(Versions.v2026_02_01_preview)
model DiscoveryConfiguration {
  /**
   * The type of discovery to execute. This value determines the expected structure
   * of the configuration and must be compatible with the workloadType specified in workloadInfo.
   */
  discoveryType: DiscoveryConfigurationType;

  /**
   * The execution mode for the discovery process.
   * When set to 'Execute', the discovery process will be executed as part of this request.
   * When set to 'Skip', only the configuration is updated without running discovery.
   * Defaults to 'Execute' if not provided.
   */
  mode?: DiscoveryExecutionMode;
}

/**
 * The type of auxiliary resource configuration. Determines how auxiliary resources
 * are specified for workload operations.
 */
@added(Versions.v2026_02_01_preview)
union AuxiliaryResourceConfigurationType {
  string,

  /** User provides all required auxiliary resource IDs explicitly. */
  Manual: "Manual",
}

/**
 * Defines the configuration for auxiliary resources required by workload platform services.
 * Use 'Manual' to explicitly specify resource IDs.
 */
@discriminator("configurationType")
@added(Versions.v2026_02_01_preview)
model AuxiliaryResourceConfiguration {
  /**
   * The type of auxiliary resource configuration.
   */
  configurationType: AuxiliaryResourceConfigurationType;
}

/**
 * Defines the storage account configuration for auxiliary resources.
 */
@added(Versions.v2026_02_01_preview)
model AuxiliaryStorageAccountConfiguration {
  /**
   * The Azure resource ID of the storage account.
   * Required on create, optional on update.
   */
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  storageAccountId?: Azure.Core.armResourceIdentifier<[
    {
      type: "Microsoft.Storage/storageAccounts";
    }
  ]>;
}

/**
 * Defines the manual auxiliary resource configuration where the user explicitly
 * provides all required resource IDs such as storage accounts.
 */
@added(Versions.v2026_02_01_preview)
model ManualAuxiliaryResourceConfiguration
  extends AuxiliaryResourceConfiguration {
  /**
   * The configuration type.
   */
  configurationType: AuxiliaryResourceConfigurationType.Manual;

  /**
   * The storage account to use for workload operations such as discovery and change detection.
   * Required on create, optional on update.
   */
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  storageAccount?: AuxiliaryStorageAccountConfiguration;
}

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
   * Required on create, optional on update.
   */
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  @added(Versions.v2025_06_01_preview)
  workloadInfo?: WorkloadInfo;

  /**
   * The type of environment in which the workload system is deployed - Production / Non Production.
   * Required on create, optional on update.
   */
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  environmentType?: EnvironmentType;

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
   * Required on create, optional on update.
   */
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  systemLifecycleStage?: SystemLifecycleStage;

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
   * Defines the automated discovery input configuration.
   */
  @added(Versions.v2026_02_01_preview)
  discoveryConfiguration?: DiscoveryConfiguration;

  /**
   * Defines the change detection information including configuration and errors.
   */
  @added(Versions.v2026_02_01_preview)
  changeDetection?: ChangeDetection;

  /**
   * Defines the configuration for auxiliary resource that will be used for mission critical workload platform services.
   */
  @added(Versions.v2026_02_01_preview)
  auxiliaryResourceConfiguration?: AuxiliaryResourceConfiguration;

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
   * The type of the workload. Required on create, read-only thereafter.
   */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  workloadType?: string;

  /**
   * The name of the corresponding workload definition. Required on create, read-only thereafter.
   */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  workloadDefinitionName?: string;

  /**
   * The version selected for the corresponding workload definition. Can be updated.
   */
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
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
model VirtualInstanceUpdate {
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
  properties?: VirtualInstanceProperties;
}

/**
 * Defines the workload component properties.
 */
model WorkloadComponentProperties {
  /**
   * Type of the component. Allowed values change based on the workload type and will be defined in the workload definition. Examples include "application", "database", "central" etc.
   * Required on create, read-only thereafter.
   */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  componentType?: string;

  /**
   * Role of the component. There can be multiple roles for a same component type. Allowed values change based on the workload type and will be defined in the workload definition. Examples of Role for SAP workloads include "pas"/"aas" for application component, "ascs"/"ers" for central component, "backup", etc.
   * Required on create, read-only thereafter.
   */
  @visibility(Lifecycle.Create, Lifecycle.Read)
  componentRole?: string;

  /**
   * Resources that are part of the component. The entries in this list should be unique and correspond to a single Azure resource.
   * Required on create, optional on update.
   */
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  @Azure.ResourceManager.identifiers(#[])
  resources?: ResourceConfiguration[];

  /**
   * Metadata pertaining to the component.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Keys of this field are dynamic and vary based on the component, which itself would vary based on the type of the workload. We cannot use tags here as this field is supposed to be understood by the service and is not for customer usage. Values will always be strings."
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  metadata?: Record<string>;

  /**
   * The component profile containing workload-specific configuration details.
   * The profile type varies based on the workload and component type.
   */
  @visibility(Lifecycle.Create, Lifecycle.Read, Lifecycle.Update)
  @added(Versions.v2026_02_01_preview)
  componentProfile?: ComponentProfile;

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
model WorkloadComponentUpdate {
  /**
   * Gets or sets the Resource tags.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Existing field"
  tags?: Record<string>;

  /**
   * The properties to be updated.
   */
  properties?: WorkloadComponentProperties;
}

/**
 * Defines the type of component profile.
 */
@added(Versions.v2026_02_01_preview)
union ComponentProfileType {
  string,

  /** SAP Central Services component profile. */
  SAP_CentralServices_Default: "SAP-CentralServices-Default",

  /** SAP Application Server component profile. */
  SAP_ApplicationServer_Default: "SAP-ApplicationServer-Default",

  /** SAP Database Server component profile. */
  SAP_DatabaseServer_Default: "SAP-DatabaseServer-Default",
}

/**
 * Defines the base component profile. The profile type determines the specific
 * configuration properties available for each workload component type.
 */
@discriminator("profileType")
@added(Versions.v2026_02_01_preview)
model ComponentProfile {
  /**
   * The type of the component profile. This value determines the expected structure
   * of the profile properties and must be compatible with the componentType.
   */
  profileType: ComponentProfileType;
}
