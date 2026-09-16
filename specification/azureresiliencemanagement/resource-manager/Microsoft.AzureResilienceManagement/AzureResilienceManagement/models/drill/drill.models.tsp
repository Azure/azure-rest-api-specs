import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

import "./enums.tsp";
import "./common.tsp";
import "../common/common.tsp";
import "../common/Job.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;

namespace Microsoft.AzureResilienceManagement;

/**
 * Resource definition for the Drill Object.
 */
@tenantResource
@doc("Drill resource")
model Drill is ProxyResource<DrillProperties> {
  @doc("The name of the Drill")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("drillName")
  @segment("drills")
  @path
  name: string;

  ...ManagedServiceIdentityProperty;
}

@doc("Properties of the Resiliency Drill.")
@discriminator("drillType")
model DrillProperties {
  @doc("Status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("Parent SG resource.")
  @visibility(Lifecycle.Read)
  serviceGroupId?: armResourceIdentifier<[
    {
      type: "Microsoft.Management/serviceGroups";
    }
  ]>;

  @doc("ROPlan properties.")
  recoveryPlanProperties?: RecoveryPlanPropertiesOfDrill;

  @doc("Goal Assignment properties.")
  @added(Versions.v2026_09_30_preview)
  goalAssignmentProperties?: GoalAssignmentPropertiesOfDrill;

  @doc("Properties for internal resources that are created for the Drill.")
  drillAssetProperties?: AssetPropertiesOfDrill;

  @doc("Chaos Resource properties.")
  chaosResourceProperties?: ChaosResourcePropertiesOfDrill;

  @doc("Execution state of the Drill. Whether it is currently running or not.")
  @visibility(Lifecycle.Read)
  executionState?: ExecutionState;

  @doc("Readiness state of the Drill.")
  @visibility(Lifecycle.Read)
  executionReadinessState?: ExecutionReadinessState;

  @doc("RBAC setup mode.")
  rbacSetupMode?: RBACSetupMode;

  @doc("Attention reason if the ReadinessState is 'NeedsAttention'.")
  @visibility(Lifecycle.Read)
  attentionReason?: AttentionReason;

  @doc("Internal System Metadata, to be used by internal components only.")
  @visibility(Lifecycle.Read)
  systemMetadata?: SystemMetadata;

  @doc("Last run properties.")
  @visibility(Lifecycle.Read)
  lastRunProperties?: LastRunProperties;

  @doc("Last sync time.")
  @visibility(Lifecycle.Read)
  lastSyncTime?: utcDateTime;

  @doc("Last resync and readiness check time.")
  @visibility(Lifecycle.Read)
  lastResyncReadinessCheckTime?: utcDateTime;

  @doc("The discriminator for the Drill object hierarchy.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  drillType: DrillType;

  @doc("Monitoring properties of the Drill.")
  monitoringProperties?: MonitoringPropertiesOfDrill;

  @doc("Azure Health Model monitoring properties of the Drill.")
  healthModelMonitoringProperties?: HealthModelMonitoringProperties;

  @doc("SLI monitoring properties of the Drill.")
  sliMonitoringProperties?: SliMonitoringProperties;

  @doc("Error details associated with the resource.")
  @visibility(Lifecycle.Read)
  errorDetails?: CommonTypes.ErrorDetail;
}

/**
 * Last run details.
 */
@doc("Definition of Last Run properties.")
model LastRunProperties {
  @doc("Timestamp of the last run of this Drill.")
  @visibility(Lifecycle.Read)
  lastRunTime?: utcDateTime;

  @doc("Status of the last run of this Drill.")
  @visibility(Lifecycle.Read)
  lastRunState?: JobStatus;

  @doc("Timespan of the last run of this Drill.")
  @visibility(Lifecycle.Read)
  lastRunDuration?: duration;

  @doc("Attestation state of the last run of this Drill.")
  @visibility(Lifecycle.Read)
  lastRunAttestation?: DrillAttestation;

  @doc("Actual recovery time of the last run of this Drill.")
  @added(Versions.v2026_09_30_preview)
  @visibility(Lifecycle.Read)
  lastRunRecoveryTimeActual?: duration;
}

@doc("Definition of Zonal Drill properties.")
model ZonalDrillProperties extends DrillProperties {
  @doc("The discriminator for the Drill object hierarchy.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  drillType: DrillType.Zonal;

  @doc("An indication whether a VM is included in this Zonal Drill. If not, RO is not needed.")
  @visibility(Lifecycle.Read)
  vmsPresent?: VMPresent;
}

/**
 * Resource definition for the ZonalDrill Object.
 */
@tenantResource
@doc("Zonal Drill resource")
model ZonalDrill is ProxyResource<ZonalDrillProperties> {
  @doc("The name of the Zonal Drill")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("drillName")
  @segment("drills")
  @path
  name: string;

  ...ManagedServiceIdentityProperty;
}

@doc("Definition of Regional Drill properties.")
model RegionalDrillProperties extends DrillProperties {
  @doc("The discriminator for the Drill object hierarchy.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  drillType: DrillType.Regional;
}

/**
 * Resource definition for the RegionalDrill Object.
 */
@tenantResource
@doc("Regional Drill resource")
model RegionalDrill is ProxyResource<RegionalDrillProperties> {
  @doc("The name of the Regional Drill")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @key("drillName")
  @segment("drills")
  @path
  name: string;

  ...ManagedServiceIdentityProperty;
}

/**
 * Model that represents the metric properties
 */
/**
 * Model that represents the Health Model properties
 */
/**
 * Model that represents the Monitoring properties of Drill
 */
@doc("Drill monitoring properties.")
model MonitoringPropertiesOfDrill {
  @doc("Identity to use for Drill monitoring operations.")
  identity?: AssociatedIdentity;

  @doc("Full ARM Id of the Log analytics workspace created by Resiliency service where health data is collected.")
  @visibility(Lifecycle.Read)
  logAnalyticsWorkspaceId?: armResourceIdentifier<[
    {
      type: "Microsoft.OperationalInsights/workspaces";
    }
  ]>;

  @doc("Full ARM Id of the Data collection rule created by Resiliency service which will route data for RAW health data for service group resources.")
  @visibility(Lifecycle.Read)
  rawMetricsDataCollectionRuleId?: armResourceIdentifier<[
    {
      type: "Microsoft.Insights/datacollectionrules";
    }
  ]>;

  @doc("Full ARM Id of the Data collection rule created by Resiliency service which will route data for Aggregate health data of service group.")
  @visibility(Lifecycle.Read)
  serviceGroupMetricsDataCollectionRuleId?: armResourceIdentifier<[
    {
      type: "Microsoft.Insights/datacollectionrules";
    }
  ]>;

  @doc("Full ARM Id of the Data collection endpoint created by Resiliency service which will route data for service group and its resources.")
  @visibility(Lifecycle.Read)
  dataCollectionEndpointId?: armResourceIdentifier<[
    {
      type: "Microsoft.Insights/dataCollectionEndpoints";
    }
  ]>;
}

/**
 * Model that represents the Azure Health Model monitoring properties of a Drill.
 */
@doc("Azure Health Model monitoring properties of a Drill. Exactly one Health Model may be selected per Drill.")
model HealthModelMonitoringProperties {
  @doc("Identity that the Drill uses to read the Azure Health Model. The Drill is granted Reader on the Health Model for this identity.")
  identity: AssociatedIdentity;

  @doc("Full ARM Id of the discovery rule inside the Azure Health Model. The parent Health Model is derived from this Id; it is the only identifier accepted on the wire.")
  discoveryRuleId: armResourceIdentifier<[
    {
      type: "Microsoft.CloudHealth/healthmodels/discoveryrules";
    }
  ]>;
}

/**
 * Model that represents the SLI monitoring properties of a Drill.
 */
@doc("SLI monitoring properties of a Drill. At most two SLIs may be selected: at most one Availability and one Latency.")
model SliMonitoringProperties {
  @doc("Identity that the Drill uses to read evaluated SLI results from each SLI's destination Azure Monitor Workspace. The Drill is granted Monitoring Reader on every destination AMW of every selected SLI for this identity.")
  identity: AssociatedIdentity;

  @doc("The SLIs selected for Drill monitoring. Maximum of two entries: at most one Availability and one Latency. Duplicate types or duplicate SLI Ids are rejected.")
  @identifiers(#[])
  @minItems(1)
  @maxItems(2)
  slis: SliSelection[];
}

/**
 * Model that represents a single SLI selected for Drill monitoring.
 */
@doc("A single SLI selected for Drill monitoring.")
model SliSelection {
  @doc("Full ARM Id of the SLI.")
  sliId: armResourceIdentifier<[
    {
      type: "Microsoft.Monitor/slis";
    }
  ]>;

  @doc("User-declared category of the SLI. Must be unique across the selected SLIs.")
  type: SliType;
}

/**
 * Model that represents the per-SLI attention status of a Drill.
 */
@doc("Per-SLI attention status of a Drill.")
model SliAttentionStatus {
  @doc("Full ARM Id of the SLI this status refers to.")
  sliId: armResourceIdentifier<[
    {
      type: "Microsoft.Monitor/slis";
    }
  ]>;

  @doc("User-declared category of the SLI.")
  type: SliType;

  @doc("Whether the selected SLI still exists.")
  @visibility(Lifecycle.Read)
  exists?: ExtensionObjectState;

  @doc("Whether the user-declared SLI type matches the SLI's actual category.")
  @visibility(Lifecycle.Read)
  typeMatch?: SliTypeMatchState;

  @doc("Rolled-up RBAC state: NotSet if the Drill identity is missing Monitoring Reader on any of the SLI's destination Azure Monitor Workspaces.")
  @visibility(Lifecycle.Read)
  drillRbacOnDestinationAmw?: RBACState;

  @doc("The destination Azure Monitor Workspaces that are still missing the Monitoring Reader grant for the Drill identity.")
  @visibility(Lifecycle.Read)
  rbacNeededOnDestinationAmws?: string[];
}

/**
 * Model that represents the metric to use
 */
/**
 * Model that represents the RecoveryPlan properties
 */
@doc("RecoveryPlan properties.")
model RecoveryPlanPropertiesOfDrill {
  @doc("Identity to use for RecoveryPlan operations.")
  identity: AssociatedIdentity;

  @doc("Recovery Orchestration plan associated with this Drill.")
  @visibility(Lifecycle.Read)
  recoveryPlanId?: armResourceIdentifier<[
    {
      type: "Microsoft.AzureResilienceManagement/recoveryPlans";
    }
  ]>;

  @doc("Excluded resource count in RecoveryPlan.")
  @visibility(Lifecycle.Read)
  recoveryPlanResourceExcludedCount?: int32;
}

/**
 * Model that represents the Goal Assignment properties
 */
@doc("Goal assignment properties.")
@added(Versions.v2026_09_30_preview)
model GoalAssignmentPropertiesOfDrill {
  @doc("Identity to use for goal assignment operations.")
  identity: AssociatedIdentity;

  @doc("Goal assignment id.")
  @visibility(Lifecycle.Read)
  goalAssignmentId?: armResourceIdentifier<[
    {
      type: "Microsoft.AzureResilienceManagement/goalAssignments";
    }
  ]>;
}

/**
 * Model that represents the Chaos Experiment properties
 */
/**
 * Model that represents the Chaos Resource properties
 */
@doc("Chaos Resource properties.")
model ChaosResourcePropertiesOfDrill {
  @doc("Identity to use for Chaos Resource operations.")
  identity: AssociatedIdentity;

  @doc("Identity to be used by the Chaos Resource for invoking faults on resources.")
  chaosResourceIdentityForFaults: AssociatedIdentity;

  @doc("Chaos Resource created for this Drill")
  @visibility(Lifecycle.Read)
  chaosResourceId?: armResourceIdentifier<[
    {
      type: "Microsoft.Chaos/workspaces";
    }
  ]>;

  @doc("Duration of faults.")
  @visibility(Lifecycle.Read)
  @minValue(0)
  faultDurationInMin?: int32;
}

@doc("Drill asset properties.")
model AssetPropertiesOfDrill {
  @doc("Subscription where Drill's internal resources will be created.")
  subscription: string;

  @doc("Region where Drill's internal resources will be created.")
  region: string;

  @doc("Resource group where Drill's internal resources will be created. If not specified, defaults to 'AzureResilienceManagementDrills'. This value is immutable after drill creation.")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  @pattern("^[-\\w\\._\\(\\)]+$")
  @minLength(1)
  @maxLength(90)
  resourceGroup?: string;
}

@doc("Reason why the Drill is in NeedsAttention state, and not ready to run.")
model AttentionReason {
  @doc("Drill object does not have the necessary RBAC to run the chaos resource.")
  drillRbacOnChaosResource?: RBACState;

  @doc("Permissions needed by the Drill MSI to run the chaos resource.")
  rbacNeededForDrillOnChaosResource?: string[];

  @doc("Drill object does not have the necessary RBAC to run the Recovery Plan.")
  drillRbacOnRecoveryPlan?: RBACState;

  @doc("Permissions needed by the Drill MSI to run the Recovery Plan.")
  rbacNeededForDrillOnRecoveryPlan?: string[];

  @doc("Associated RO ready or not.")
  roReadiness?: RecoveryPlanState;

  @doc("RBAC required by Chaos Resource MSI not setup on the target resources.")
  rbacOnTargetResources?: RBACState;

  @doc("RBAC required by AutomationAccount for runbook MSI not setup on the target resources.")
  runbookFaultRbacOnTargets?: RBACState;

  @doc("Chaos resource for faulting exists or not.")
  chaosResource?: ExtensionObjectState;

  @doc("Reason for Chaos Resource Creation failure")
  chaosResourceCreationFailureReasons?: string[];

  @doc("Resources associated in Recovery Plan and Drill are out of sync.")
  recoveryPlanAndDrillResourcesState?: RelativeResourceCompositionState;

  @doc("Resources in Service Group and Drill are out of sync.")
  serviceGroupAndDrillResourcesState?: RelativeResourceCompositionState;

  @doc("User MSI associated with Drill object is deleted.")
  drillUserMsi?: ExtensionObjectState;

  @doc("User MSI associated with chaos resource object is deleted.")
  chaosResourceUserMsi?: ExtensionObjectState;

  @doc("Included resource in Drill.")
  includedResourceInDrill?: ExtensionObjectState;

  @doc("Drill MSI does not have the necessary RBAC to read the Drill Monitoring resources.")
  drillRbacOnMonitoringResources?: RBACState;

  @doc("Errors related to Drill Monitoring resources.")
  @identifiers(#[])
  drillMonitoringErrors?: ErrorDetails[];

  @doc("Monitoring Resources created for Drill")
  @visibility(Lifecycle.Read)
  drillMonitoringResources?: ExtensionObjectState;

  @doc("Monitoring RBAC required by Drill MSI not setup on the target resources.")
  monitoringRbacOnDrillResources?: RBACState;

  @doc("Permissions needed by the Drill MSI to Upload service group health data for monitoring.")
  rbacNeededForDrillOnDrillMonitoringResources?: string[];

  @doc("Permissions needed by the Drill MSI to read health metrics data for resources in service group.")
  rbacNeededForDrillOnDrillResources?: string[];

  @doc("List of required required Azure resource providers that are not registered in the subscription specified for chaos resource.")
  missingRequiredResourceProviders?: string[];

  @doc("Neither an Azure Health Model nor an SLI is configured for the Drill. Execution is blocked until a monitoring source is configured.")
  monitoringSourceNotConfigured?: boolean;

  @doc("Whether the selected Azure Health Model still exists.")
  healthModelExists?: ExtensionObjectState;

  @doc("Whether the selected discovery rule still exists.")
  discoveryRuleExists?: ExtensionObjectState;

  @doc("Whether the Drill identity has the necessary RBAC (Reader) to read the selected Azure Health Model.")
  drillRbacOnHealthModel?: RBACState;

  @doc("Permissions needed by the Drill identity to read the selected Azure Health Model.")
  rbacNeededForDrillOnHealthModel?: string[];

  @doc("Rolled-up RBAC state: NotSet if the Drill identity is missing the necessary RBAC to read any selected SLI.")
  drillRbacOnSli?: RBACState;

  @doc("Per-SLI attention status for each SLI selected for Drill monitoring.")
  @identifiers(#[])
  sliAttentionStatuses?: SliAttentionStatus[];

  @doc("Drill object does not have the necessary RBAC on Goal Assignment.")
  @added(Versions.v2026_09_30_preview)
  drillRbacOnGoalAssignment?: RBACState;

  @doc("Permissions needed by the Drill MSI on Goal Assignment.")
  @added(Versions.v2026_09_30_preview)
  rbacNeededForDrillOnGoalAssignment?: string[];

  @doc("Goal Assignment not present.")
  @added(Versions.v2026_09_30_preview)
  goalAssignment?: ExtensionObjectState;

  @doc("Recovery plan not present.")
  @added(Versions.v2026_09_30_preview)
  recoveryPlan?: ExtensionObjectState;
}

@doc("Internal System Metadata, to be used by internal components only.")
model SystemMetadata {
  @doc("Indicates if the Initial system configuration of the Drill is complete or not.")
  initialConfig: InitialConfig;

  @doc("An indication whether a intrested resource type is present in drill resource.")
  @visibility(Lifecycle.Read)
  resourceTypeCategories?: ResourceTypeCategories[];
}

@doc("Request body of the Start Action of Drill.")
model DrillStartRequest {
  @doc("Mode of starting the Drill")
  mode: DrillMode;
}

@doc("Request body of the End Action of Drill.")
model DrillEndRequest {
  @doc("Attestation Status")
  attestation: DrillAttestation;

  @doc("Notes")
  attestationNotes: string;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("Response body of Drill actions")
model DrillActionResponse {
  @doc("JobId of the Drill")
  @visibility(Lifecycle.Read)
  jobId?: armResourceIdentifier<[
    {
      type: "Microsoft.AzureResilienceManagement/drills/drillRuns";
    }
  ]>;
}

@doc("Request body of the AddOrUpdateResources API.")
model AddOrUpdateResourcesRequest {
  @doc("Duration of faults.")
  @minValue(0)
  faultDurationInMin: int32;

  @doc("Add, Update, Delete resource lists")
  resourceLists?: ResourceLists;

  @doc("Whether to allow inclusion and update despite attention reasons.")
  forceInclusionAndUpdate?: ForceInclusionAndUpdate;
}

@doc("Add, Update, Delete resource lists")
model ResourceLists {
  @doc("Include resource")
  @identifiers(#[])
  includeResources?: IncludeOrUpdateResource[];

  @doc("Excluded resource")
  excludeResources?: armResourceIdentifier<[]>[];

  @doc("Update resource")
  @identifiers(#[])
  updateResources?: IncludeOrUpdateResource[];
}

@doc("Include or Update resource")
model IncludeOrUpdateResource {
  @doc("Id of the DrillResource to be included (NOT the ARM Id of the underlying resource).")
  id: armResourceIdentifier<[
    {
      type: "microsoft.azureresiliencemanagement/drills/drillresources";
    }
  ]>;

  @doc("Fault properties.")
  faultProperties?: FaultProperties;
}

@doc("Failed Include, Exclude or Update resource.")
model FailedDrillResource {
  @doc("Id of the failed drill resource.")
  id: armResourceIdentifier<[
    {
      type: "microsoft.azureresiliencemanagement/drills/drillresources";
    }
  ]>;

  @doc("Resource Id of the underlying resource of the failed Drill resource.")
  resourceId: armResourceIdentifier<[]>;

  @doc("RBAC assignment error.")
  @visibility(Lifecycle.Read)
  rbacAssignmentError?: ErrorDetails;
}

@doc("PATCH properties for Drill.")
model DrillPatchProperties {
  @doc("Recovery Plan properties.")
  recoveryPlanProperties?: RecoveryPlanPropertiesOfDrill;

  @doc("Goal Assignment properties.")
  @added(Versions.v2026_09_30_preview)
  goalAssignmentProperties?: GoalAssignmentPropertiesOfDrill;

  @doc("Properties for internal resources that are created for the Drill.")
  drillAssetProperties?: AssetPropertiesOfDrill;

  @doc("Chaos Resource properties.")
  chaosResourceProperties?: ChaosResourcePropertiesOfDrill;

  @doc("RBAC setup mode.")
  rbacSetupMode?: RBACSetupMode;

  @doc("Monitoring properties of the Drill.")
  monitoringProperties?: MonitoringPropertiesOfDrill;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Explicit null is required so a PATCH can clear the Health Model monitoring selection."
  @doc("Azure Health Model monitoring properties of the Drill. Send null to clear the selection.")
  healthModelMonitoringProperties?: HealthModelMonitoringProperties | null;

  #suppress "@azure-tools/typespec-azure-core/no-nullable" "Explicit null is required so a PATCH can clear the SLI monitoring selection."
  @doc("SLI monitoring properties of the Drill. Send null to clear the selection; the submitted slis array is the new desired state.")
  sliMonitoringProperties?: SliMonitoringProperties | null;
}

@doc("Additional properties for Failover.")
model ValidateForExecutionProperties {
  @doc("Operation name for which the validation is being done. This is needed to determine the set of validations to be done for the operation.")
  operationName?: DrillRunTasks;

  @doc("Physiscal Source locations from where resources to be failed-over or faulted.")
  sourceLocations?: string[];
}

@doc("Request body of the Validate For Execute Action of Drill.")
model ValidateForExecutionRequest {
  @doc("Additional properties for Validate for execute.")
  validateForExecutionProperties?: ValidateForExecutionProperties;
}

@doc("Qualified resource.")
model DrillsQualifiedResource {
  @doc("ARM Resource ID of the Azure resource.")
  @visibility(Lifecycle.Read)
  resourceId: armResourceIdentifier;

  @doc("Drill Resource ID of the Azure resource.")
  @visibility(Lifecycle.Read)
  drillResourceId?: armResourceIdentifier;

  @doc("Active Resource location and zones of Azure Resource.")
  @visibility(Lifecycle.Read)
  activeLocations?: string[];

  @doc("Recovery Resource location and zones of HA Azure Resource.")
  @visibility(Lifecycle.Read)
  recoveryLocations?: string[];

  @doc("Active Resource location and physical zones of Azure Resource.")
  @visibility(Lifecycle.Read)
  activePhysicalZones?: string[];

  @doc("Recovery Resource location and physical zones of HA Azure Resource.")
  @visibility(Lifecycle.Read)
  recoveryPhysicalZones?: string[];

  @doc("Inclusion State of the Drill resource in Drill")
  @visibility(Lifecycle.Read)
  drillInclusionState?: DrillResourceInclusionState;

  @doc("A state that indicates the resource status with respect to the recovery orchestration plan.")
  @visibility(Lifecycle.Read)
  recoveryInclusionState?: ResourceInclusionState;

  @doc("A status that indicates the protection status of a resource with an Azure solution for regional or zonal recovery.")
  @visibility(Lifecycle.Read)
  protectionStatus?: ResourceProtectionStatus;

  @doc("A setting that indicates the protection solution selected.")
  @visibility(Lifecycle.Read)
  selectedProtectionSolutionType?: ResourceProtectionSolutionType;

  @doc("A list of ResourceProtectionSolutions with which the recovery orchestration resource is protected.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  resourceProtectionSolutions?: ResourceProtectionSolutionSettings[];

  @doc("Resource protection solution settings of the protection solutions recovery orchestration resource is protected with.")
  @visibility(Lifecycle.Read)
  selectedProtectionSolutionSetting?: ResourceBaseProtectionSolutionSetting;

  @doc("Fault State of the Drill resource")
  @visibility(Lifecycle.Read)
  faultState?: DrillResourceFaultState;

  @doc("Fault Properties")
  @visibility(Lifecycle.Read)
  faultProperties?: FaultProperties;

  @doc("Resource Protection Solution Display Name")
  @visibility(Lifecycle.Read)
  resourceProtectionSolutionDisplayName?: string;
}

@doc("Details of qualification for an operation.")
model ResourceQualificationDetails {
  @doc("Resource qualification state for the operation.")
  @visibility(Lifecycle.Read)
  drillQualificationState: QualificationState;

  @doc("Resource qualification state for the operation.")
  @visibility(Lifecycle.Read)
  recoveryQualificationState: QualificationState;

  @doc("Reasons for resource not qualified for the recovery operation.")
  @visibility(Lifecycle.Read)
  recoveryNotQualifiedReasons?: string[];

  @doc("Reasons for resource not qualified for the drills operation.")
  @visibility(Lifecycle.Read)
  drillsNotQualifiedReasons?: DrillResourceNonQualificationReasons[];
}

@doc("Details of qualified resources for validateForExecution operation.")
model DrillResourceQualification {
  @doc("Drill resource.")
  @visibility(Lifecycle.Read)
  drillsQualifiedResource: DrillsQualifiedResource;

  @doc("Details of qualification for the operation.")
  @visibility(Lifecycle.Read)
  resourceQualificationDetails: ResourceQualificationDetails;
}

#suppress "@azure-tools/typespec-client-generator-core/csharp-model-suffix" "Name kept for backward compatibility"
@doc("ValidateForExecution post action response.")
model ValidateForExecutionResponse {
  @doc("Qualification details of resources for the operation.")
  @identifiers(#[])
  @visibility(Lifecycle.Read)
  drillResourceQualifications: DrillResourceQualification[];
}
