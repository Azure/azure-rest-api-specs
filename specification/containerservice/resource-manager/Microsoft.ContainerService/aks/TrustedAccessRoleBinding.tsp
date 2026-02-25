import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./CommonModels.tsp";
import "./ManagedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;

namespace Microsoft.ContainerService;

// =============================================================================
// TrustedAccessRoleBinding resource and operations
// =============================================================================

/**
 * Defines binding between a resource and role
 */
@parentResource(ManagedCluster)
model TrustedAccessRoleBinding
  is Azure.ResourceManager.ProxyResource<
    TrustedAccessRoleBindingProperties,
    false
  > {
  ...ResourceNameParameter<
    Resource = TrustedAccessRoleBinding,
    KeyName = "trustedAccessRoleBindingName",
    SegmentName = "trustedAccessRoleBindings",
    NamePattern = "^([A-Za-z0-9-])+$"
  >;
}

@@maxLength(TrustedAccessRoleBinding.name, 24);
@@minLength(TrustedAccessRoleBinding.name, 1);
@@doc(TrustedAccessRoleBinding.name,
  "The name of trusted access role binding."
);
@@doc(TrustedAccessRoleBinding.properties,
  "Properties for trusted access role binding"
);
@@doc(TrustedAccessRoleBindings.createOrUpdate::parameters.resource,
  "A trusted access role binding"
);

@armResourceOperations(#{ omitTags: true })
interface TrustedAccessRoleBindings {
  /**
   * Get a trusted access role binding.
   */
  @tag("TrustedAccess")
  get is ArmResourceRead<TrustedAccessRoleBinding>;

  /**
   * Create or update a trusted access role binding
   */
  @tag("TrustedAccess")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<TrustedAccessRoleBinding>;

  /**
   * Delete a trusted access role binding.
   */
  @tag("TrustedAccess")
  delete is ArmResourceDeleteWithoutOkAsync<
    TrustedAccessRoleBinding,
    LroHeaders = ArmAsyncOperationHeaderWithLocation &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * List trusted access role bindings.
   */
  @tag("TrustedAccess")
  list is ArmResourceListByParent<TrustedAccessRoleBinding>;
}

// =============================================================================
// TrustedAccessRoleBinding models
// =============================================================================

/**
 * The current provisioning state of trusted access role binding.
 */
union TrustedAccessRoleBindingProvisioningState {
  string,

  /** Trusted access role binding provisioning was canceled. */
  Canceled: "Canceled",

  /** Trusted access role binding is being deleted. */
  Deleting: "Deleting",

  /** Trusted access role binding provisioning failed. */
  Failed: "Failed",

  /** Trusted access role binding provisioning succeeded. */
  Succeeded: "Succeeded",

  /** Trusted access role binding is being updated. */
  Updating: "Updating",
}

/**
 * Properties for trusted access role binding
 */
model TrustedAccessRoleBindingProperties {
  /**
   * The current provisioning state of trusted access role binding.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: TrustedAccessRoleBindingProvisioningState;

  /**
   * The ARM resource ID of source resource that trusted access is configured for.
   */
  sourceResourceId: Azure.Core.armResourceIdentifier;

  /**
   * A list of roles to bind, each item is a resource type qualified role name. For example: 'Microsoft.MachineLearningServices/workspaces/reader'.
   */
  roles: string[];
}

/**
 * List of trusted access roles
 */
model TrustedAccessRoleListResult is Azure.Core.Page<TrustedAccessRole>;

/**
 * Trusted access role definition.
 */
model TrustedAccessRole {
  /**
   * Resource type of Azure resource
   */
  @visibility(Lifecycle.Read)
  sourceResourceType?: string;

  /**
   * Name of role, name is unique under a source resource type
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * List of rules for the role. This maps to 'rules' property of [Kubernetes Cluster Role](https://kubernetes.io/docs/reference/kubernetes-api/authorization-resources/cluster-role-v1/#ClusterRole).
   */
  @visibility(Lifecycle.Read)
  @identifiers(#[])
  rules?: TrustedAccessRoleRule[];
}

/**
 * Rule for trusted access role
 */
model TrustedAccessRoleRule {
  /**
   * List of allowed verbs
   */
  @visibility(Lifecycle.Read)
  verbs?: string[];

  /**
   * List of allowed apiGroups
   */
  @visibility(Lifecycle.Read)
  apiGroups?: string[];

  /**
   * List of allowed resources
   */
  @visibility(Lifecycle.Read)
  resources?: string[];

  /**
   * List of allowed names
   */
  @visibility(Lifecycle.Read)
  resourceNames?: string[];

  /**
   * List of allowed nonResourceURLs
   */
  #suppress "@azure-tools/typespec-azure-core/casing-style" "Property name maintained for backward compatibility with existing API versions"
  @visibility(Lifecycle.Read)
  nonResourceURLs?: string[];
}
