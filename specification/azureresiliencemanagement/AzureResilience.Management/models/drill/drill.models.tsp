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

  @doc("Metric properties.")
  metricsProperties?: MetricsPropertiesOfDrill;

  @doc("HealthModel properties.")
  healthModelProperties?: HealthModelPropertiesOfDrill;

  @doc("ROPlan properties.")
  recoveryPlanProperties: RecoveryPlanPropertiesOfDrill;

  @doc("Properties for internal resources that are created for the Drill.")
  drillAssetProperties: AssetPropertiesOfDrill;

  @doc("Chaos Experiment properties.")
  chaosExperimentProperties: ChaosExperimentPropertiesOfDrill;

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

  @doc("Managed RG v2 properties.")
  @visibility(Lifecycle.Read)
  managedOnBehalfOfConfiguration?: ManagedOnBehalfOfConfiguration;

  @doc("The discriminator for the Drill object hierarchy.")
  @visibility(Lifecycle.Create)
  drillType: DrillType;

  @doc("Monitoring properties of the Drill.")
  @visibility(Lifecycle.Read)
  monitoringProperties?: MonitoringPropertiesOfDrill;
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
}

@doc("Definition of Zonal Drill properties.")
model ZonalDrillProperties extends DrillProperties {
  @doc("The discriminator for the Drill object hierarchy.")
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
@doc("Metrics properties.")
model MetricsPropertiesOfDrill {
  @doc("Identity to use for metrics operations.")
  identity: AssociatedIdentity;

  @doc("Metrics associated with this Drill. These will be tracked through the Drill Run.")
  @identifiers(#[])
  metricsToTrack: MetricsToTrack[];
}

/**
 * Model that represents the Health Model properties
 */
@doc("Health Model properties.")
model HealthModelPropertiesOfDrill {
  @doc("Identity to use for Health Model operations.")
  identity: AssociatedIdentity;

  @doc("Full ARM Id of the Health Model.")
  healthModelId: armResourceIdentifier<[
    {
      type: "Microsoft.CloudHealth/healthmodels";
    }
  ]>;
}

/**
 * Model that represents the Health Model properties
 */
@doc("Drill monitoring properties.")
model MonitoringPropertiesOfDrill {
  @doc("Identity to use for Health Model operations.")
  identity: AssociatedIdentity;

  @doc("Full ARM Id of the Log analytics workspace created by Resiliency service where health data is collected.")
  logAnalyticsWorkspaceId: armResourceIdentifier<[
    {
      type: "Microsoft.OperationalInsights/workspaces";
    }
  ]>;

  @doc("Full ARM Id of the Data collection rule created by Resiliency service which will route data for RAW health data for service group resources.")
  rawMetricsDataCollectionRuleId: armResourceIdentifier<[
    {
      type: "Microsoft.Insights/datacollectionrules";
    }
  ]>;

  @doc("Full ARM Id of the Data collection rule created by Resiliency service which will route data for Aggregate health data of service group.")
  serviceGroupMetricsDataCollectionRuleId: armResourceIdentifier<[
    {
      type: "Microsoft.Insights/datacollectionrules";
    }
  ]>;

  @doc("Full ARM Id of the Data collection endpoint created by Resiliency service which will route data for service group and its resources.")
  dataCollectionEndpointId: armResourceIdentifier<[
    {
      type: "Microsoft.Insights/dataCollectionEndpoints";
    }
  ]>;
}

/**
 * Model that represents the metric to use
 */
@doc("Metrics object")
model MetricsToTrack {
  @doc("Name of the metric.")
  @minLength(1)
  metricName: string;

  @doc("Full url of the metric.")
  metricId: armResourceIdentifier<[
    {
      type: "Microsoft.Monitor/slos";
    }
  ]>;

  @doc("Destination AMW account where the time-series data of the metric lives.")
  destinationAmwAccountUrl: armResourceIdentifier<[
    {
      type: "Microsoft.Automation/automationAccounts";
    }
  ]>;
}

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
 * Model that represents the Chaos Experiment properties
 */
@doc("Chaos Experiment properties.")
model ChaosExperimentPropertiesOfDrill {
  @doc("Subscription for chaosExperiment resource.")
  subscription: string;

  @doc("Region for chaosExperiment resource.")
  region: string;

  @doc("Identity to use for Chaos Experiment operations.")
  identity: AssociatedIdentity;

  @doc("Identity to be used by the Chaos Experiment for invoking faults on resources.")
  chaosExperimentIdentityForFaults: AssociatedIdentity;

  @doc("Chaos Experiment resource created for this Drill")
  @visibility(Lifecycle.Read)
  chaosExperimentId?: armResourceIdentifier<[
    {
      type: "Microsoft.Chaos/experiments";
    }
  ]>;

  @doc("Duration of faults.")
  @visibility(Lifecycle.Read)
  @minValue(0)
  faultDurationInMin?: int32;
}

/**
 * Model that represents the properties for resources that are created for Drill
 */
@doc("Drill asset properties.")
model AssetPropertiesOfDrill {
  @doc("Subscription where Drill's internal resources will be created.")
  subscription: string;

  @doc("Region where Drill's internal resources will be created.")
  region: string;
}

@doc("Reason why the Drill is in NeedsAttention state, and not ready to run.")
model AttentionReason {
  @doc("Drill object does not have the necessary RBAC to run the chaos experiment.")
  drillRbacOnExperiment?: RBACState;

  @doc("Permissions needed by the Drill MSI to run the chaos experiment.")
  rbacNeededForDrillOnExperiment?: string[];

  @doc("Drill object does not have the necessary RBAC to run the Recovery Plan.")
  drillRbacOnRecoveryPlan?: RBACState;

  @doc("Permissions needed by the Drill MSI to run the Recovery Plan.")
  rbacNeededForDrillOnRecoveryPlan?: string[];

  @doc("Drill object does not have the necessary RBAC to read the Azure Monitoring Workspace account.")
  drillRbacOnAzureMonitoringWorkspace?: RBACState;

  @doc("Permissions needed by the Drill MSI to read Azure Monitoring Workspace account.")
  rbacNeededForDrillOnAzureMonitoringWorkspace?: string[];

  @doc("Drill object does not have the necessary RBAC to read the SLO object.")
  drillRbacOnSlo?: RBACState;

  @doc("Permissions needed by the Drill MSI to read SLO object.")
  rbacNeededForDrillOnSlo?: string[];

  @doc("Drill object does not have the necessary RBAC to read the Azure Health Model.")
  drillRbacOnAzureHealthModel?: RBACState;

  @doc("Permissions needed by the Drill MSI to read Azure Health Model.")
  rbacNeededForDrillOnAzureHealthModel?: string[];

  @doc("Associated RO ready or not.")
  roReadiness?: RecoveryPlanState;

  @doc("RBAC required by Experiment MSI not setup on the target resources.")
  faultRbacOnTargets?: RBACState;

  @doc("RBAC required by AutomationAccount for runbook MSI not setup on the target resources.")
  runbookFaultRbacOnTargets?: RBACState;

  @doc("One or more Target or Capability object is deleted.")
  targets?: ExtensionObjectState;

  @doc("Resources associated in Recovery Plan and Drill are out of sync.")
  recoveryPlanAndDrillResourcesState?: RelativeResourceCompositionState;

  @doc("Resources in Service Group and Drill are out of sync.")
  serviceGroupAndDrillResourcesState?: RelativeResourceCompositionState;

  @doc("User MSI associated with Drill object is deleted.")
  drillUserMsi?: ExtensionObjectState;

  @doc("User MSI associated with chaos experiment object is deleted.")
  chaosExperimentUserMsi?: ExtensionObjectState;

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

  @doc("List of required required Azure resource providers that are not registered in the subscription specified for chaos experiment.")
  missingRequiredResourceProviders?: string[];

  @doc("Permissions needed by the Drill MSI to Upload service group health data for monitoring.")
  rbacNeededForDrillOnDrillMonitoringResources?: string[];
}

@doc("Internal System Metadata, to be used by internal components only.")
model SystemMetadata {
  @doc("Indicates if the Initial system configuration of the Drill is complete or not.")
  initialConfig: InitialConfig;
}

@doc("Request body of the Start Action of Drill.")
model DrillStartRequest {
  @doc("Mode of starting the Drill")
  mode: DrillMode;

  #suppress "@azure-tools/typespec-client-generator-core/no-unnamed-types" "Maintaining compatibility with current SDKs."
  @doc("Inputs needed for the Recovery Orchestration Plan")
  recoveryPlanInputs: {
    @doc("Direction of the failover")
    failoverDirection: string;
  };
}

@doc("Request body of the End Action of Drill.")
model DrillEndRequest {
  @doc("Attestation Status")
  attestation: DrillAttestation;

  @doc("Notes")
  attestationNotes: string;
}

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

@doc("Response body of the AddOrUpdateResources API.")
model AddOrUpdateResourcesResponse {
  @doc("Failed Include resources.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  failedIncludeResourceList?: FailedDrillResource[];

  @doc("Failed Exclude resources.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  failedExcludeResourceList?: FailedDrillResource[];

  @doc("Failed Update resources.")
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  failedUpdateResourceList?: FailedDrillResource[];
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

  @doc("Target and Capability assignment error.")
  @visibility(Lifecycle.Read)
  targetAndCapabilityAssignmentError?: ErrorDetails;

  @doc("RBAC assignment error.")
  @visibility(Lifecycle.Read)
  rbacAssignmentError?: ErrorDetails;
}

@doc("PATCH properties for Drill.")
model DrillPatchProperties {
  @doc("Metric properties.")
  metricsProperties?: MetricsPropertiesOfDrill;

  @doc("Recovery Plan properties.")
  recoveryPlanProperties?: RecoveryPlanPropertiesOfDrill;

  @doc("Chaos Experiment properties.")
  chaosExperimentProperties?: ChaosExperimentPropertiesOfDrill;

  @doc("HealthModel properties.")
  healthModelProperties?: HealthModelPropertiesOfDrill;

  @doc("RBAC setup mode.")
  rbacSetupMode?: RBACSetupMode;

  @doc("Properties for internal resources that are created for the Drill.")
  drillAssetProperties?: AssetPropertiesOfDrill;
}

@doc("Configuration of the managed on behalf of resource.")
model ManagedOnBehalfOfConfiguration {
  @visibility(Lifecycle.Read)
  @doc("Associated MoboBrokerResources.")
  moboBrokerResources?: MoboBrokerResource[];
}

@doc("MoboBroker resource.")
model MoboBrokerResource {
  /**
   * The fully qualified resource ID of the MoboBroker resource.
   * Example: `/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/{resourceProviderNamespace}/{resourceType}/{resourceName}`
   */
  @visibility(Lifecycle.Read)
  id?: string;
}
