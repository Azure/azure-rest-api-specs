import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-azure-core";
import "../../main.tsp";
import "../common/common.tsp";
import "../../recoveryPlans.tsp";

using Azure.Core;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.ResourceManager;
using OpenAPI;

@armProviderNamespace("Microsoft.AzureResilienceManagement")
namespace Microsoft.AzureResilienceManagement;

@doc("Specifies the type of recovery orchestration group actions.")
union RecoveryGroupActionType {
  @doc("A manual action type for the recovery orchestration group.")
  ManualAction: "ManualAction",

  @doc("A custom runbook action type for the recovery orchestration group.")
  CustomRunbook: "CustomRunbook",

  string,
}

@doc("Defines an action for the recovery orchestration group.")
@discriminator("type")
model RecoveryGroupBaseAction {
  @doc("The name of the recovery orchestration group action.")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  name: string;

  @doc("A description of the recovery orchestration group action, containing the instructions to be performed during this action.")
  @maxLength(100)
  description?: string;

  @doc("The type of the recovery orchestration group action.")
  type: RecoveryGroupActionType;

  @doc("The maximum amount of time, in minutes, allowed for the action to complete before it times out.")
  @minValue(0)
  @maxValue(10000)
  timeoutInMinutes: int32;
}

@doc("Defines a manual action for the recovery orchestration group.")
model RecoveryGroupManualAction extends RecoveryGroupBaseAction {
  @doc("The type of the recovery orchestration group action.")
  type: RecoveryGroupActionType.ManualAction;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Need parameter dictionary for custom runbook implementation"
@doc("Defines a custom runbook action for the recovery orchestration group.")
model RecoveryGroupCustomRunbookAction extends RecoveryGroupBaseAction {
  @doc("The type of the recovery orchestration group action.")
  type: RecoveryGroupActionType.CustomRunbook;

  @doc("The ARM Resource ID of the resource that includes the actionable script, such as a Runbook in an Automation Account.")
  actionResourceId?: armResourceIdentifier<[
    {
      type: "Microsoft.Automation/automationAccounts/runbooks";
    }
  ]>;

  @doc("Key-value parameters for the operation.")
  parameters?: Record<string>;

  @doc("The identity associated with actionResourceId for RBAC.")
  associatedIdentity?: AssociatedIdentity;
}

// Define the main model
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "Doesn't need ProvisioningState"
@doc("Properties of the recovery orchestration group.")
model RecoveryGroupProperties {
  @doc("A unique id for the recovery orchestration group, which is a GUID.")
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  groupUniqueId: string;

  @doc("The order ID of the recovery orchestration group.")
  @minValue(0)
  @maxValue(15)
  orderId: int32;

  @doc("A description of the recovery orchestration group.")
  @minLength(5)
  @maxLength(50)
  description: string;

  @doc("Pre-actions for the recovery orchestration group.")
  @identifiers(#[])
  @maxItems(10)
  preActions?: RecoveryGroupBaseAction[];

  @doc("Post-actions for the recovery orchestration group.")
  @identifiers(#[])
  @maxItems(10)
  postActions?: RecoveryGroupBaseAction[];

  @added(Versions.v2026_11_30_preview)
  @doc("Resiliency-specific properties for the recovery orchestration group.")
  resiliencyGroupProperties?: RecoveryGroupResiliencyProperties;
}

@added(Versions.v2026_11_30_preview)
@discriminator("resiliencyType")
@doc("Resiliency-specific properties for a recovery orchestration group.")
model RecoveryGroupResiliencyProperties {
  @added(Versions.v2026_11_30_preview)
  @doc("The resiliency type represented by these properties.")
  resiliencyType: ResiliencyType;
}

@added(Versions.v2026_11_30_preview)
@doc("Infrastructure resiliency properties for a recovery orchestration group.")
model InfrastructureResiliencyGroupProperties extends RecoveryGroupResiliencyProperties {
  @added(Versions.v2026_11_30_preview)
  @doc("The resiliency type represented by these properties.")
  resiliencyType: ResiliencyType.InfraResiliency;
}

@added(Versions.v2026_11_30_preview)
@doc("Cyber resiliency properties for a recovery orchestration group.")
model CyberResiliencyGroupProperties extends RecoveryGroupResiliencyProperties {
  @added(Versions.v2026_11_30_preview)
  @doc("The resiliency type represented by these properties.")
  resiliencyType: ResiliencyType.CyberResiliency;

  @added(Versions.v2026_11_30_preview)
  @identifiers(#["workloadType"])
  @doc("Recovery configuration profiles associated by workload type.")
  recoveryConfigProfileAssociations?: RecoveryConfigProfileAssociation[];
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-providerhub-controller/no-resource-operations" "Operation not supported for it"
@parentResource(RecoveryPlan)
@doc("Represents a recovery orchestration group resource in the Azure Resilience Management provider namespace.")
model RecoveryGroup is ProxyResource<RecoveryGroupProperties> {
  @doc("The unique name (GUID) of the recovery orchestration group.")
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  @key("recoveryGroupName")
  @segment("recoveryGroups")
  @path
  name: string;
}

@doc("Settings for the recovery orchestration groups.")
model RecoveryGroupsSetting {
  @doc("The default recovery orchestration group setting. Every recovery orchestration plan has a default recovery orchestration group.")
  defaultGroup: RecoveryGroup;

  @doc("Additional recovery orchestration group settings.")
  @identifiers(#[])
  @maxItems(14)
  additionalGroups?: RecoveryGroup[];
}

@added(Versions.v2026_11_30_preview)
@doc("Associates a workload type with a plan-scoped recovery configuration profile.")
model RecoveryConfigProfileAssociation {
  @added(Versions.v2026_11_30_preview)
  @doc("The workload type configured by the profile.")
  workloadType: WorkloadType;

  @added(Versions.v2026_11_30_preview)
  @doc("The Azure resource identifier of the plan-scoped recovery configuration profile.")
  recoveryConfigProfileId: armResourceIdentifier<[
    {
      type: "Microsoft.AzureResilienceManagement/recoveryPlans/recoveryConfigProfiles";
    }
  ]>;
}
