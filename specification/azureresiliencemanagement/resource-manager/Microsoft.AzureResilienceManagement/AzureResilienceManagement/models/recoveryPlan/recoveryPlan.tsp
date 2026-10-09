import "@typespec/http";
import "@typespec/rest";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "../../main.tsp";
import "./recoveryGroup.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

@armProviderNamespace("Microsoft.AzureResilienceManagement")
namespace Microsoft.AzureResilienceManagement;

@doc("Specifies the type of recovery orchestration plan.")
union RecoveryPlanType {
  @doc("A recovery orchestration plan for regional resiliency.")
  Regional: "Regional",

  @doc("A recovery orchestration plan for zonal resiliency.")
  Zonal: "Zonal",

  @added(Versions.v2026_11_30_preview)
  @doc("A recovery orchestration plan for cyber recovery into a clean-room environment.")
  CyberRecovery: "CyberRecovery",

  string,
}

@added(Versions.v2026_11_30_preview)
@doc("Specifies the resiliency type for recovery plan properties.")
union ResiliencyType {
  @added(Versions.v2026_11_30_preview)
  @doc("Infrastructure resiliency properties.")
  InfraResiliency: "InfraResiliency",

  @added(Versions.v2026_11_30_preview)
  @doc("Cyber resiliency properties.")
  CyberResiliency: "CyberResiliency",

  string,
}

@doc("Specifies the operation status for failover and validation.")
union RecoveryOperationStatus {
  @doc("Operation has not started or ran.")
  NotStarted: "NotStarted",

  @doc("Operation is in the process of being validated.")
  ValidationInProgress: "ValidationInProgress",

  @doc("Operation is in progress.")
  InProgress: "InProgress",

  @doc("Operation has completed successfully.")
  Succeeded: "Succeeded",

  @doc("Operation has completed but ran into some warning state.")
  CompletedWithWarning: "CompletedWithWarning",

  @doc("Operation has completed but ran into some validation error state.")
  ValidationFailed: "ValidationFailed",

  @doc("Operation has completed but ran into some error state.")
  Failed: "Failed",

  @doc("Operation has been canceled by the user.")
  Canceled: "Canceled",

  string,
}

@doc("Details of the recovery orchestration plan operation execution.")
model RecoveryPlanOperationStatus {
  @doc("The most recent execution time of the recovery orchestration plan in UTC.")
  @visibility(Lifecycle.Read)
  lastExecutedAt?: utcDateTime;

  @doc("The status of the most recent execution of the recovery orchestration plan.")
  @visibility(Lifecycle.Read)
  operationStatus?: RecoveryOperationStatus;

  @doc("Error details for the most recent execution of the recovery orchestration plan.")
  @visibility(Lifecycle.Read)
  errorDetails?: CommonTypes.ErrorDetail;
}

@doc("Details of the recovery orchestration plan failover operation execution.")
model RecoveryPlanFailoverOperationStatus is RecoveryPlanOperationStatus {
  @doc("The actual recovery time of the most recent recovery orchestration plan.")
  @visibility(Lifecycle.Read)
  recoveryTimeActual?: duration;
}

@doc("Properties of the recovery orchestration plan.")
model RecoveryPlanProperties {
  @doc("The provisioning state of the recovery orchestration plan.")
  @visibility(Lifecycle.Read)
  provisioningState?: ProvisioningState;

  @doc("The type of the recovery orchestration plan, which can be set during creation but cannot be changed afterward.")
  @visibility(Lifecycle.Create)
  planType: RecoveryPlanType;

  @doc("The current state of the recovery orchestration plan.")
  @visibility(Lifecycle.Read)
  planState?: RecoveryPlanState;

  @doc("A description of the recovery orchestration plan.")
  @minLength(5)
  @maxLength(50)
  planDescription: string;

  @doc("Settings for the recovery orchestration groups associated with the recovery orchestration plan.")
  recoveryGroupsSetting: RecoveryGroupsSetting;

  @added(Versions.v2026_11_30_preview)
  @doc("Resiliency-specific properties for the recovery plan.")
  resiliencyPlanProperties?: RecoveryPlanResiliencyProperties;

  @doc("The status of the most recent failover operation executed.")
  @visibility(Lifecycle.Read)
  latestFailoverStatus?: RecoveryPlanFailoverOperationStatus;

  @doc("The status of the most recent validation performed.")
  @visibility(Lifecycle.Read)
  latestValidationStatus?: RecoveryPlanOperationStatus;

  @added(Versions.v2026_03_01_preview)
  @doc("Error details associated with the resource.")
  @visibility(Lifecycle.Read)
  errorDetails?: CommonTypes.ErrorDetail;
}

@added(Versions.v2026_11_30_preview)
@discriminator("resiliencyType")
@doc("Resiliency-specific properties for a recovery plan.")
model RecoveryPlanResiliencyProperties {
  @added(Versions.v2026_11_30_preview)
  @doc("The resiliency type represented by these properties.")
  resiliencyType: ResiliencyType;
}

@added(Versions.v2026_11_30_preview)
@doc("Infrastructure resiliency properties for a recovery plan.")
model InfrastructureResiliencyPlanProperties extends RecoveryPlanResiliencyProperties {
  @added(Versions.v2026_11_30_preview)
  @doc("The resiliency type represented by these properties.")
  resiliencyType: ResiliencyType.InfraResiliency;
}

@added(Versions.v2026_11_30_preview)
@doc("Cyber resiliency properties for a recovery plan.")
model CyberResiliencyPlanProperties extends RecoveryPlanResiliencyProperties {
  @added(Versions.v2026_11_30_preview)
  @doc("The resiliency type represented by these properties.")
  resiliencyType: ResiliencyType.CyberResiliency;

  @added(Versions.v2026_11_30_preview)
  @doc("The subscriptions and locations where recovery is targeted. Applies only to CyberRecovery plans, for which it is required.")
  targetEnvironment?: TargetEnvironment;

  @added(Versions.v2026_11_30_preview)
  @doc("Rules that determine which discovered resources are included. Applies only to CyberRecovery plans.")
  inclusionSettings?: RecoveryResourceInclusionSettings;

  @added(Versions.v2026_11_30_preview)
  @doc("Details that link this plan to a source recovery plan. Applies only to CyberRecovery plans.")
  linkedRecoveryPlanDetails?: LinkedRecoveryPlanDetails;

  @added(Versions.v2026_11_30_preview)
  @doc("Details that map this plan to source tenants. Applies only to CyberRecovery plans.")
  mappedRecoveryPlanDetails?: MappedRecoveryPlanDetails;
}

@added(Versions.v2026_11_30_preview)
@doc("The target subscriptions and locations for cyber recovery.")
model TargetEnvironment {
  @added(Versions.v2026_11_30_preview)
  @minItems(1)
  @doc("The subscription identifiers available as recovery targets.")
  targetSubscriptionList: string[];

  @added(Versions.v2026_11_30_preview)
  @minItems(1)
  @doc("The Azure regions available as recovery targets.")
  targetLocationList: string[];
}

@added(Versions.v2026_11_30_preview)
@doc("The synchronization mode for a linked recovery plan.")
union RecoveryPlanSyncMode {
  @added(Versions.v2026_11_30_preview)
  @doc("Synchronization is started manually.")
  Manual: "Manual",

  @added(Versions.v2026_11_30_preview)
  @doc("Synchronization runs on a service-managed schedule.")
  Scheduled: "Scheduled",

  @doc("Any synchronization mode not currently known to this API version.")
  string,
}

@added(Versions.v2026_11_30_preview)
@doc("Details that link a recovery plan to its source plan.")
model LinkedRecoveryPlanDetails {
  @added(Versions.v2026_11_30_preview)
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("Indicates whether this plan is linked to a source recovery plan. Cannot be changed after creation.")
  isLinkedRecoveryPlan: boolean;

  @added(Versions.v2026_11_30_preview)
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("The Azure resource identifier of the linked source recovery plan. Cannot be changed after creation.")
  linkedSourceRecoveryPlanId?: armResourceIdentifier<[
    {
      type: "Microsoft.AzureResilienceManagement/recoveryPlans";
    }
  ]>;

  @added(Versions.v2026_11_30_preview)
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("The Microsoft Entra tenant identifier of the linked source plan. Cannot be changed after creation.")
  linkedSourceRecoveryPlanTenantId?: string;

  @added(Versions.v2026_11_30_preview)
  @doc("The synchronization mode used for the linked plan. When omitted during creation, the service uses Manual.")
  syncMode?: RecoveryPlanSyncMode;
}

@added(Versions.v2026_11_30_preview)
@doc("Details that map a recovery plan to source tenants.")
model MappedRecoveryPlanDetails {
  @added(Versions.v2026_11_30_preview)
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @doc("Indicates whether this plan is mapped from source tenants. Cannot be changed after creation.")
  isMappedRecoveryPlan: boolean;

  @added(Versions.v2026_11_30_preview)
  @doc("The Microsoft Entra tenant identifiers mapped to this plan.")
  mappedSourceTenantIds?: string[];
}

@added(Versions.v2026_11_30_preview)
@doc("Rules controlling automatic recovery resource inclusion.")
model RecoveryResourceInclusionSettings {
  @added(Versions.v2026_11_30_preview)
  @identifiers(#[])
  @doc("The ordered resource inclusion rules.")
  rules?: RecoveryResourceInclusionRule[];
}

@added(Versions.v2026_11_30_preview)
@doc("A rule controlling automatic inclusion of discovered resources.")
model RecoveryResourceInclusionRule {
  @added(Versions.v2026_11_30_preview)
  @doc("Indicates whether matching resources are included.")
  include: boolean;

  @added(Versions.v2026_11_30_preview)
  @doc("The full Azure resource type matched by this rule.")
  resourceType: string;

  @added(Versions.v2026_11_30_preview)
  @doc("The recovery group identifier assigned to matching resources.")
  recoveryGroupId: string;

  @added(Versions.v2026_11_30_preview)
  @doc("The subscription identifiers matched by this rule.")
  subscriptionIds?: string[];

  @added(Versions.v2026_11_30_preview)
  @doc("The Azure resource identifiers of resource groups matched by this rule.")
  resourceGroupIds?: armResourceIdentifier<[
    {
      type: "Microsoft.Resources/resourceGroups";
    }
  ]>[];

  @added(Versions.v2026_11_30_preview)
  @identifiers(#["key"])
  @doc("The resource tags matched by this rule.")
  tags?: TagFilter[];
}

@added(Versions.v2026_11_30_preview)
@doc("A resource tag key and value used by an inclusion rule.")
model TagFilter {
  @added(Versions.v2026_11_30_preview)
  @doc("The resource tag key.")
  key: string;

  @added(Versions.v2026_11_30_preview)
  @doc("The resource tag value.")
  value: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
@tenantResource
@doc("Represents a recovery orchestration plan resource in the Azure Resilience Management provider namespace.")
model RecoveryPlan is ProxyResource<RecoveryPlanProperties> {
  @doc("The name of the recovery orchestration plan.")
  @pattern("^[a-zA-Z0-9-]{5,24}$")
  @key("recoveryPlanName")
  @segment("recoveryPlans")
  @path
  name: string;

  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "User-determined keys"
  ...ManagedServiceIdentityProperty;
}
