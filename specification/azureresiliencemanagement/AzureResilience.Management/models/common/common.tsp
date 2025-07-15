import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using Azure.Core;

@service(#{ title: "Microsoft.AzureResilienceManagement" })
@armCommonTypesVersion(Azure.ResourceManager.CommonTypes.Versions.v5)
namespace Microsoft.AzureResilienceManagement;

alias ServiceGroupRoute = "/providers/Microsoft.Management/serviceGroups";

@doc("Definition of associated identity linked with the various resources.")
model AssociatedIdentity {
  @doc("Identity type linked with the resource")
  type: Azure.ResourceManager.CommonTypes.ManagedServiceIdentityType;

  @doc("User assigned identity id linked with the resource")
  userAssignedIdentity?: armResourceIdentifier<[
    {
      type: "Microsoft.ManagedIdentity/userAssignedIdentities";
    }
  ]>;
}

@doc("The status of the current operation.")
@Azure.Core.lroStatus
union ProvisioningState {
  ResourceProvisioningState,

  @doc("Initial provisioning in progress")
  Provisioning: "Provisioning",

  @doc("Update in progress")
  Updating: "Updating",

  @doc("Deletion in progress")
  Deleting: "Deleting",

  @doc("Change accepted for processing")
  Accepted: "Accepted",
}

/**
 * Query parameters for list operations.
 */
model QueryParameters {
  /**
   * Skip over when retrieving results.
   */
  @query("$skipToken")
  skipToken?: string;

  /**
   * Number of elements to return when retrieving results.
   */
  @maxValue(100)
  @minValue(1)
  @query("$top")
  top?: int32;
}

@doc("ServiceGroup as parameter")
model ServiceGroupBaseParameters {
  @path
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  @doc("The name of the service group.")
  serviceGroupName: string;
}

@doc("ServiceGroup as parameter")
model ServiceGroupParameters is ServiceGroupBaseParameters {
  ...Azure.ResourceManager.CommonTypes.ApiVersionParameter;
}

@doc("ServiceGroup tenant as parameter")
model ServiceGroupTenantParameters is ServiceGroupBaseParameters {
  ...TenantBaseParameters;
  ...QueryParameters;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-path-segment-invalid-chars" "Existing Template"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-key-invalid-chars" "Existing template"
@doc("Mandatory request headers.")
model RequiredRequestHeaders {
  @header
  @doc("A GUID that represents the Long Running OperationId.")
  operationId: string;
}

@doc("ServiceGroup tenant and request headers as parameter")
model ServiceGroupAndRequestHeadersParameters is ServiceGroupParameters {
  ...RequiredRequestHeaders;
}

@doc("Definition of Name Value collection.")
model AdditionalParameter {
  @doc("Name of the key")
  @pattern("^[a-zA-Z0-9-]{3,24}$")
  key: string;

  @doc("Value of the key")
  value: string;
}

@doc("Specifies the state of the recovery orchestration plan.")
union RecoveryPlanState {
  @doc("The recovery orchestration plan is currently being edited.")
  UnderEdit: "UnderEdit",

  @doc("The recovery orchestration plan is in a warning state.")
  Warning: "Warning",

  @doc("The recovery orchestration plan is ready.")
  Ready: "Ready",

  string,
}

// These are the common types used across the resource types in the Microsoft.AzureResilienceManagement namespace.
@doc("A state type that indicates inclusion of the resource with respect to the resiliency support.")
union ResourceInclusionState {
  @doc("A state that indicates the resource is included.")
  Included: "Included",

  @doc("A state that indicates the resource is excluded.")
  Excluded: "Excluded",

  string,
}

@doc("A state type that indicates the protection status of a resource with an Azure solution for regional or zonal recovery.")
union ResourceProtectionStatus {
  @doc("The protection status of the resource is unknown.")
  Unknown: "Unknown",

  @doc("A state indicating that the resource is protected by the recovery solution.")
  Protected: "Protected",

  @doc("A state indicating that the resource is not protected by any recovery solution.")
  NotProtected: "NotProtected",

  string,
}

@doc("A job type indicates the kind of job.")
union JobType {
  @doc("Abstract job - invalid.")
  Invalid: "Invalid",

  @doc("Recovery Orchestration Plan created job.")
  RecoveryPlan: "RecoveryPlan",

  @doc("Recovery Orchestration Plan child created job.")
  RecoveryPlanChild: "RecoveryPlanChild",

  @doc("Drill Oober job which represents a given instance of Drill.")
  DrillRun: "DrillRun",

  @doc("Drill Run child job.")
  DrillRunChild: "DrillRunChild",

  @doc("Chaos job created by Drill to represent a Experiment Run.")
  ChaosExperiment: "ChaosExperiment",

  @doc("Chaos job's child job.")
  ChaosExperimentChild: "ChaosExperimentChild",

  string,
}

@doc("A job resource type indicates the kind of jobresource.")
union JobResourceType {
  @doc("Abstract job resource - invalid.")
  Invalid: "Invalid",

  @doc("Recovery Orchestration Plan created job resource.")
  RecoveryPlan: "RecoveryPlan",

  @doc("Recovery Orchestration Plan child created job resource.")
  RecoveryPlanChild: "RecoveryPlanChild",

  @doc("Drill Run job resource.")
  DrillRun: "DrillRun",

  @doc("Chaos job resource created by Drill to represent a Experiment Run.")
  ChaosExperiment: "ChaosExperiment",

  string,
}

@doc("Types of Failover directions.")
union FailoverDirectionTypes {
  @doc("Failover resources from specific locations.")
  FromSpecificLocations: "FromSpecificLocations",

  string,
}

@doc("Additional properties for Failover.")
model FailoverRequestProperties {
  @OpenAPI.extension("x-ms-identifiers", #[])
  @doc("Source locations from where resources to be failed-over.")
  sourceLocations: string[];
}

@doc("Failover post action request.")
model FailoverRequest {
  @doc("Type of Failover direction.")
  failoverDirection: FailoverDirectionTypes;

  @doc("Additional properties for Failover.")
  failoverRequestProperties?: FailoverRequestProperties;
}

@doc("Protection solution type for the resources by which recovery takes place")
union ResourceProtectionSolutionType {
  @doc("Resource is not protected with any protection solution.")
  None: "None",

  @doc("Resource is protected with the Azure native solution provided by the native Azure service.")
  AzureNative: "AzureNative",

  @doc("Resource protected with the Azure solution provided by the native Azure Site Service for Azure VMs.")
  AzureSiteRecovery: "AzureSiteRecovery",

  @doc("Cross zone recovery enabled Azure VMs.")
  CrossZoneVMRecovery: "CrossZoneVMRecovery",

  @doc("Resource is not protected with native solution and using custom runbook automation scripts for recovery verbs.")
  CustomRunbook: "CustomRunbook",

  string,
}
