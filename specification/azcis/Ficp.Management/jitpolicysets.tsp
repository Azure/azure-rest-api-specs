import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;
using Autorest;

namespace Microsoft.AzureCis;

@doc("Ficp JIT Policy Set properties")
model JitPolicySetProperties {
  @doc("Cloud identifier")
  cloudId: string;

  @doc("List of Jit policies")
  @identifiers(#[])
  policies: Array<JitPolicy>;

  @doc("The Azure location.")
  azureLocation?: azureLocation;

  @doc("Provisioning status of the resource.")
  @visibility(Lifecycle.Read)
  provisioningState?: FicpProvisioningState;
}

@doc("Ficp Jit policy")
model JitPolicy {
  @doc("Unique policy Identifier for a service tree id.")
  policyInvariableId: int64;

  @doc("Define the execution sequence in belonging policy set.")
  executionSequence: int64;

  @doc("The type of approval for the policy. Available values are \"AutoApproval\", \"ManualApproval\" and \"ExplicitlyDeny\".")
  policyType: PolicyType;

  @doc("Jit Resource that was created and available for your service.")
  resourceType: string;

  @doc("JIT Available policy flags. ")
  extendedFlags: ExtendedFlags;

  @doc("Policy condition is a Property-Value set. The evaluation is based on the policy condition.")
  @identifiers(#[])
  policyConditions: Array<PolicyCondition>;

  @doc("After policy condition match is evaluated and matched, an equivalent action need to be performed.")
  @identifiers(#[])
  policyActions: Array<PolicyAction>;

  @doc("Provisioning mode type.")
  provisioningMode: ProvisioningMode;
}

@doc("JIT Extended policy flags")
model ExtendedFlags {
  @doc("Flag indicating if it is MS Employee Direct Access Policy or not")
  msEmployeeDirectAccessPolicy: boolean;

  @doc("Flag indicating if it is Global Policy or not")
  globalPolicy: boolean;

  @doc("Flag indicating if the policy should be displayed or not")
  noDisplay: boolean;
}

@doc("FICP Policy Condition")
model PolicyCondition {
  @doc("Property of the policy condition")
  property: string;

  @doc("Value of the policy condition")
  value: string;
}

@doc("FICP Policy Action")
model PolicyAction {
  @doc("Property of the policy action")
  property: string;

  @doc("Value of the policy action")
  value: string;
}

@doc("Provisioning Mode")
model ProvisioningMode {
  #suppress "@azure-tools/typespec-azure-core/no-unnamed-union" "Maintaining compatibility with current SDKs."
  @doc("Type of the provisioning mode, either \"Create\" or \"Delete\".")
  mode: "Create" | "Delete" | string;
}

@doc("Policy Type")
union PolicyType {
  @doc("Auto Approval")
  AutoApproval: "AutoApproval",

  @doc("Manual Approval")
  ManualApproval: "ManualApproval",

  @doc("Explicitly Deny")
  ExplicitlyDeny: "ExplicitlyDeny",

  string,
}

@doc("FicpJitPolicySet Resource")
model JitPolicySetResource
  is ProxyResource<JitPolicySetProperties> { // this can be TrackedResource based on resourcetype
  @doc("The name of resource.")
  @pattern("^[a-zA-Z0-9-]{3,80}$")
  @key("resourceName")
  @segment("jitPolicySets") // Start with lower case. Should be plural
  @visibility(Lifecycle.Read)
  @path
  name: string;
}

#suppress "@azure-tools/typespec-azure-resource-manager/no-resource-delete-operation" "The resource must have a delete operation.TypeSpec"
@armResourceOperations
interface JitPolicySet {
  createOrUpdate is ArmResourceCreateOrUpdateAsync<JitPolicySetResource>;
  listBySubscription is ArmListBySubscription<JitPolicySetResource>;
  listByResourceGroup is ArmResourceListByParent<JitPolicySetResource>;
  get is ArmResourceRead<JitPolicySetResource>;
}
