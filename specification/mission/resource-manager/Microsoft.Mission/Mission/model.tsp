import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/http";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";

import "./resourcetypes/approvals/approvals.tsp";
import "./resourcetypes/community/community.tsp";
import "./resourcetypes/communityEndpoint/communityEndpoint.tsp";
import "./resourcetypes/enclaveConnection/enclaveConnection.tsp";
import "./resourcetypes/enclaveEndpoint/enclaveEndpoint.tsp";
import "./resourcetypes/postActions/approvalspostactions.tsp";
import "./resourcetypes/postActions/checkaddressspaceavailability.tsp";
import "./resourcetypes/dedicatedHub/dedicatedHub.tsp";
import "./resourcetypes/transitHub/transitHub.tsp";
import "./resourcetypes/virtualEnclave/virtualenclave.tsp";
import "./resourcetypes/workload/workload.tsp";

import "./resourcetypes/shared/endpointrulebase.tsp";
import "./resourcetypes/shared/governedserviceitem.tsp";
import "./resourcetypes/shared/maintenancemodeconfiguration.tsp";
import "./resourcetypes/shared/monitoring.tsp";
import "./resourcetypes/shared/managedresourcegroupconfiguration.tsp";
import "./resourcetypes/shared/principal.tsp";
import "./resourcetypes/shared/provisioningstate.tsp";
import "./resourcetypes/shared/resourceid.tsp";
import "./resourcetypes/shared/roleassignmentitem.tsp";
import "./resourcetypes/shared/updatemode.tsp";

using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

@doc("Microsoft Mission Resource Provider management API.")
namespace Microsoft.Mission;

@doc("The governance option for a governed service.")
union VirtualEnclaveGovernedServiceItemOption {
  string,

  @doc("Allow the governed service.")
  Allow: "Allow",

  @doc("Deny the governed service.")
  Deny: "Deny",

  @doc("Allow only configured exceptions for the governed service.")
  ExceptionOnly: "ExceptionOnly",

  @doc("The governance option does not apply to the governed service.")
  NotApplicable: "NotApplicable",
}

@doc("The enforcement state for a governed service.")
union VirtualEnclaveGovernedServiceItemEnforcement {
  string,

  @doc("Enforcement is enabled.")
  Enabled: "Enabled",

  @doc("Enforcement is disabled.")
  Disabled: "Disabled",
}

@doc("The policy action for a governed service.")
union VirtualEnclaveGovernedServiceItemPolicyAction {
  string,

  @doc("Audit policy violations without enforcing the policy.")
  AuditOnly: "AuditOnly",

  @doc("Enforce the policy.")
  Enforce: "Enforce",

  @doc("Do not apply a policy action.")
  None: "None",
}

@doc("The maintenance mode for a virtual enclave.")
union VirtualEnclaveMaintenanceModeConfigurationMode {
  string,

  @doc("Maintenance mode is on.")
  On: "On",

  @doc("Resources cannot be deleted while maintenance mode is active.")
  CannotDelete: "CanNotDelete",

  @doc("Maintenance mode is off.")
  Off: "Off",

  @doc("General maintenance mode is active.")
  General: "General",

  @doc("Advanced maintenance mode is active.")
  Advanced: "Advanced",
}

@doc("The justification for entering or exiting virtual enclave maintenance mode.")
union VirtualEnclaveMaintenanceModeJustification {
  string,

  @doc("Maintenance mode is required for networking changes.")
  Networking: "Networking",

  @doc("Maintenance mode is required for governance changes.")
  Governance: "Governance",

  @doc("No maintenance mode justification applies.")
  Off: "Off",
}

@doc("The type of a virtual enclave principal.")
union VirtualEnclavePrincipalType {
  string,

  @doc("A user principal.")
  User: "User",

  @doc("A group principal.")
  Group: "Group",

  @doc("A service principal.")
  ServicePrincipal: "ServicePrincipal",
}

@doc("The resource action for an approval callback.")
union VirtualEnclaveApprovalCallbackResourceAction {
  string,

  @doc("Create the resource.")
  Create: "Create",

  @doc("Delete the resource.")
  Delete: "Delete",

  @doc("Update the resource.")
  Update: "Update",

  @doc("Reset the resource.")
  Reset: "Reset",
}

@doc("The resource action for an approval deletion callback.")
union VirtualEnclaveApprovalDeletionCallbackResourceAction {
  string,

  @doc("Create the resource.")
  Create: "Create",

  @doc("Delete the resource.")
  Delete: "Delete",

  @doc("Update the resource.")
  Update: "Update",
}

@doc("Arm resource update successful")
model ArmUpdatedResponse<TResource extends Azure.ResourceManager.Foundations.Resource>
  is ArmResponse<TResource>;

@doc("Community Model Resource")
model CommunityResource is TrackedResource<CommunityProperties> {
  @key("communityName")
  @segment("communities")
  @pattern("^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @path
  @doc("The name of the communityResource Resource")
  name: string;

  /** The managed service identity for this resource */
  ...ManagedServiceIdentityProperty;
}

@@added(
  CommunityResource.identity,
  Microsoft.Mission.Versions.v2024_06_01_preview
);

@doc("Virtual Enclave Model Resource")
model EnclaveResource is TrackedResource<VirtualEnclaveProperties> {
  @key("virtualEnclaveName")
  @segment("virtualEnclaves")
  @pattern("^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @doc("The name of the enclaveResource Resource")
  @path
  name: string;

  /** The managed service identity for this resource */
  ...ManagedServiceIdentityProperty;
}

@@added(
  EnclaveResource.identity,
  Microsoft.Mission.Versions.v2024_06_01_preview
);

@doc("Workload Model Resource")
@parentResource(EnclaveResource)
model WorkloadResource is TrackedResource<WorkloadProperties> {
  @key("workloadName")
  @segment("workloads")
  @pattern("^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @path
  @doc("The name of the workloadResource Resource")
  name: string;
}

@doc("TransitHub Model Resource")
@parentResource(CommunityResource)
model TransitHubResource is TrackedResource<TransitHubProperties> {
  @key("transitHubName")
  @segment("transitHubs")
  @path
  @pattern("^[a-zA-Z][a-zA-Z0-9-_]*[a-zA-Z0-9]$")
  @doc("The name of the TransitHub Resource")
  name: string;
}

@added(Microsoft.Mission.Versions.v2025_11_01_preview)
@doc("DedicatedHub Model Resource")
@parentResource(CommunityResource)
model DedicatedHubResource is TrackedResource<DedicatedHubProperties> {
  @key("dedicatedHubName")
  @segment("dedicatedHubs")
  @path
  @pattern("^[a-zA-Z][a-zA-Z0-9-_]*[a-zA-Z0-9]$")
  @doc("The name of the Dedicated Hub Resource")
  name: string;
}

@doc("EnclaveConnection Model Resource")
model EnclaveConnectionResource
  is TrackedResource<EnclaveConnectionProperties> {
  @key("enclaveConnectionName")
  @segment("enclaveConnections")
  @path
  @pattern("^[a-zA-Z][a-zA-Z0-9-_]*[a-zA-Z0-9]$")
  @doc("The name of the Enclave Connection Resource")
  name: string;
}

@doc("EnclaveEndpoint Model Resource")
@parentResource(EnclaveResource)
model EnclaveEndpointResource is TrackedResource<EnclaveEndpointProperties> {
  @key("enclaveEndpointName")
  @segment("enclaveEndpoints")
  @path
  @pattern("^[a-zA-Z][a-zA-Z0-9-_]*[a-zA-Z0-9]$")
  @doc("The name of the Enclave Endpoint Resource")
  name: string;
}

@doc("CommunityEndpoint Model Resource")
@parentResource(CommunityResource)
model CommunityEndpointResource
  is TrackedResource<CommunityEndpointProperties> {
  @key("communityEndpointName")
  @segment("communityEndpoints")
  @path
  @pattern("^[a-zA-Z][a-zA-Z0-9-_]*[a-zA-Z0-9]$")
  @doc("The name of the Community Endpoint Resource")
  name: string;
}

@doc("Approval Model Resource")
model ApprovalResource is ExtensionResource<ApprovalProperties> {
  @key("approvalName")
  @segment("approvals")
  @path
  @pattern("^[a-zA-Z][a-zA-Z0-9-]*[a-zA-Z0-9]$")
  @doc("The name of the approvals resource.")
  name: string;
}
