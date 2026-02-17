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
// ManagedNamespace resource and operations
// =============================================================================

/**
 * Namespace managed by ARM.
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@parentResource(ManagedCluster)
model ManagedNamespace
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<NamespaceProperties> {
  ...ResourceNameParameter<
    Resource = ManagedNamespace,
    KeyName = "managedNamespaceName",
    SegmentName = "managedNamespaces",
    NamePattern = "[a-z0-9]([-a-z0-9]*[a-z0-9])?"
  >;
  ...Azure.ResourceManager.EntityTagProperty;
}

@@maxLength(ManagedNamespace.name, 63);
@@minLength(ManagedNamespace.name, 1);
@@doc(ManagedNamespace.name, "The name of the managed namespace.");
@@doc(ManagedNamespace.properties, "Properties of a namespace.");
@@doc(ManagedNamespaces.createOrUpdate::parameters.resource,
  "The namespace to create or update."
);
@@doc(ManagedNamespaces.update::parameters.properties,
  "Parameters supplied to the patch namespace operation, we only support patch tags for now."
);

@armResourceOperations
interface ManagedNamespaces {
  /**
   * Gets the specified namespace of a managed cluster.
   */
  get is ArmResourceRead<ManagedNamespace>;

  /**
   * Creates or updates a namespace managed by ARM for the specified managed cluster. Users can configure aspects like resource quotas, network ingress/egress policies, and more. See aka.ms/aks/managed-namespaces for more details.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ManagedNamespace>;

  /**
   * Updates tags on a managed namespace.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<ManagedNamespace, PatchModel = TagsObject>;

  /**
   * Deletes a namespace.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    ManagedNamespace,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Gets a list of managed namespaces in the specified managed cluster.
   */
  listByManagedCluster is ArmResourceListByParent<ManagedNamespace>;

  /**
   * Lists the credentials of a namespace.
   */
  listCredential is ArmResourceActionSync<
    ManagedNamespace,
    void,
    ArmResponse<CredentialResults>
  >;
}

// =============================================================================
// ManagedNamespace models
// =============================================================================

/**
 * The current provisioning state of the namespace.
 */
union NamespaceProvisioningState {
  string,

  /** The namespace is being updated. */
  Updating: "Updating",

  /** The namespace is being deleted. */
  Deleting: "Deleting",

  /** The namespace is being created. */
  Creating: "Creating",

  /** The namespace provisioning succeeded. */
  Succeeded: "Succeeded",

  /** The namespace provisioning failed. */
  Failed: "Failed",

  /** The namespace provisioning was canceled. */
  Canceled: "Canceled",
}

/**
 * Enum representing different network policy rules.
 */
union PolicyRule {
  string,

  /**
   * Deny all network traffic.
   */
  DenyAll: "DenyAll",

  /**
   * Allow all network traffic.
   */
  AllowAll: "AllowAll",

  /**
   * Allow traffic within the same namespace.
   */
  AllowSameNamespace: "AllowSameNamespace",
}

/**
 * Action if Kubernetes namespace with same name already exists.
 */
union AdoptionPolicy {
  string,

  /**
   * If the namespace already exists in Kubernetes, attempts to create that same namespace in ARM will fail.
   */
  Never: "Never",

  /**
   * Take over the existing namespace to be managed by ARM, if there is no difference.
   */
  IfIdentical: "IfIdentical",

  /**
   * Always take over the existing namespace to be managed by ARM, some fields might be overwritten.
   */
  Always: "Always",
}

/**
 * Delete options of a namespace.
 */
union DeletePolicy {
  string,

  /**
   * Only delete the ARM resource, keep the Kubernetes namespace. Also delete the ManagedByARM label.
   */
  Keep: "Keep",

  /**
   * Delete both the ARM resource and the Kubernetes namespace together.
   */
  Delete: "Delete",
}

/**
 * Properties of a namespace managed by ARM
 */
model NamespaceProperties {
  /**
   * The current provisioning state of the namespace.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: NamespaceProvisioningState;

  /**
   * The labels of managed namespace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  labels?: Record<string>;

  /**
   * The annotations of managed namespace.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  annotations?: Record<string>;

  /**
   * The special FQDN used by the Azure Portal to access the Managed Cluster. This FQDN is for use only by the Azure Portal and should not be used by other clients. The Azure Portal requires certain Cross-Origin Resource Sharing (CORS) headers to be sent in some responses, which Kubernetes APIServer doesn't handle by default. This special FQDN supports CORS, allowing the Azure Portal to function properly.
   */
  @visibility(Lifecycle.Read)
  portalFqdn?: string;

  /**
   * The default resource quota enforced upon the namespace. Customers can have other Kubernetes resource quota objects under the namespace. Resource quotas are additive; if multiple resource quotas are applied to a given namespace, then the effective limit will be one such that all quotas on the namespace can be satisfied.
   */
  defaultResourceQuota?: ResourceQuota;

  /**
   * The default network policy enforced upon the namespace. Customers can have other Kubernetes network policy objects under the namespace. Network policies are additive; if a policy or policies apply to a given pod for a given direction, the connections allowed in that direction for the pod is the union of what all applicable policies allow.
   */
  defaultNetworkPolicy?: NetworkPolicies;

  /**
   * Action if Kubernetes namespace with same name already exists.
   */
  adoptionPolicy?: AdoptionPolicy;

  /**
   * Delete options of a namespace.
   */
  deletePolicy?: DeletePolicy;
}

/**
 * Resource quota for the namespace.
 */
model ResourceQuota {
  /**
   * CPU request of the namespace in one-thousandth CPU form. See [CPU resource units](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#meaning-of-cpu) for more details.
   */
  cpuRequest?: string;

  /**
   * CPU limit of the namespace in one-thousandth CPU form. See [CPU resource units](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#meaning-of-cpu) for more details.
   */
  cpuLimit?: string;

  /**
   * Memory request of the namespace in the power-of-two equivalents form: Ei, Pi, Ti, Gi, Mi, Ki. See [Memory resource units](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#meaning-of-memory) for more details.
   */
  memoryRequest?: string;

  /**
   * Memory limit of the namespace in the power-of-two equivalents form: Ei, Pi, Ti, Gi, Mi, Ki. See [Memory resource units](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#meaning-of-memory) for more details.
   */
  memoryLimit?: string;
}

/**
 * Default network policy of the namespace, specifying ingress and egress rules.
 */
model NetworkPolicies {
  /**
   * Enum representing different network policy rules.
   */
  ingress?: PolicyRule = PolicyRule.AllowSameNamespace;

  /**
   * Enum representing different network policy rules.
   */
  egress?: PolicyRule = PolicyRule.AllowAll;
}
