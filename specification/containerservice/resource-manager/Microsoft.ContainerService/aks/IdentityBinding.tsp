import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/rest";
import "./CommonModels.tsp";
import "./ManagedCluster.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using Versioning;

namespace Microsoft.ContainerService;

// =============================================================================
// IdentityBinding resource and operations
// =============================================================================

/**
 * The IdentityBinding resource.
 */
@parentResource(ManagedCluster)
@added(Versions.v2026_04_01)
model IdentityBinding
  is Azure.ResourceManager.ProxyResource<IdentityBindingProperties> {
  ...ResourceNameParameter<
    Resource = IdentityBinding,
    KeyName = "identityBindingName",
    SegmentName = "identityBindings",
    NamePattern = "^[a-z][a-z0-9]{0,63}$"
  >;
  ...Azure.ResourceManager.EntityTagProperty;
}

@@maxLength(IdentityBinding.name, 63);
@@minLength(IdentityBinding.name, 1);
@@doc(IdentityBinding.name, "The name of the identity binding.");
@@doc(
  IdentityBinding.properties,
  "The resource-specific properties for this resource."
);
@@doc(
  IdentityBindings.createOrUpdate::parameters.resource,
  "The identity binding to create or update."
);

@armResourceOperations
@added(Versions.v2026_04_01)
interface IdentityBindings {
  /**
   * Gets the specified Identity Binding.
   */
  get is ArmResourceRead<IdentityBinding>;

  /**
   * Creates or updates an identity binding in the specified managed cluster.
   */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    IdentityBinding,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = IdentityBinding> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Deletes an identity binding in the specified managed cluster.
   */
  delete is ArmResourceDeleteWithoutOkAsync<
    IdentityBinding,
    LroHeaders = ArmCombinedLroHeaders<FinalResult = void> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Gets a list of identity bindings in the specified managed cluster.
   */
  listByManagedCluster is ArmResourceListByParent<IdentityBinding>;
}

// =============================================================================
// IdentityBinding models
// =============================================================================

/**
 * The provisioning state of the last accepted operation.
 */
@Azure.Core.lroStatus
@added(Versions.v2026_04_01)
union IdentityBindingProvisioningState {
  string,

  /**
   * Resource has been created.
   */
  Succeeded: "Succeeded",

  /**
   * Resource creation failed.
   */
  Failed: "Failed",

  /**
   * Resource creation was canceled.
   */
  Canceled: "Canceled",

  /**
   * The identity binding is being created.
   */
  Creating: "Creating",

  /**
   * The identity binding is being updated.
   */
  Updating: "Updating",

  /**
   * The identity binding is being deleted.
   */
  Deleting: "Deleting",
}

/**
 * IdentityBinding properties.
 */
@added(Versions.v2026_04_01)
model IdentityBindingProperties {
  /**
   * Managed identity profile for the identity binding.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  managedIdentity: IdentityBindingManagedIdentityProfile;

  /**
   * The OIDC issuer URL of the IdentityBinding.
   */
  @visibility(Lifecycle.Read)
  oidcIssuer?: IdentityBindingOidcIssuerProfile;

  /**
   * The status of the last operation.
   */
  @visibility(Lifecycle.Read)
  provisioningState?: IdentityBindingProvisioningState;

  /**
   * Optional list of subjects authorized to use this identity binding for
   * token exchange. Each entry pairs a required namespace label selector
   * with an optional service account label selector; selectors within an
   * entry are AND'd, and multiple entries are OR'd. When omitted or empty,
   * authorization falls back exclusively to ClusterRole/ClusterRoleBinding
   * evaluation. Maximum 100 entries.
   */
  @added(Versions.v2026_05_02_preview)
  @identifiers(#[])
  @maxItems(100)
  allowedSubjects?: AllowedSubject[];
}

/**
 * A subject authorized to use the identity binding for token exchange.
 * The namespace selector is required and must be non-empty. The service
 * account selector is optional; when omitted, all service accounts in
 * matching namespaces are authorized. Selectors within a single
 * AllowedSubject are AND'd; multiple AllowedSubjects on an
 * IdentityBinding are OR'd.
 */
@added(Versions.v2026_05_02_preview)
model AllowedSubject {
  /**
   * Label selector matching the namespaces in which this identity may be
   * used. Must be non-empty: an empty selector would match every namespace
   * and is rejected to prevent overly permissive bindings. Use the built-in
   * `kubernetes.io/metadata.name` label to target specific namespaces by
   * name.
   */
  namespaceSelector: IdentityBindingLabelSelector;

  /**
   * Optional label selector matching the service accounts (within the
   * namespaces matched by `namespaceSelector`) that may use this identity.
   * When omitted, all service accounts in matching namespaces are
   * authorized. When provided, it must be non-empty.
   */
  serviceAccountSelector?: IdentityBindingLabelSelector;
}

/**
 * A Kubernetes-style label selector. Mirrors
 * k8s.io/apimachinery/pkg/apis/meta/v1.LabelSelector. The resulting
 * selector matches an object if and only if all `matchLabels` entries
 * match and all `matchExpressions` requirements are satisfied.
 */
@added(Versions.v2026_05_02_preview)
model IdentityBindingLabelSelector {
  /**
   * Map of key-value pairs that must all match (equality-based). Up to 10
   * keys are permitted per selector. Keys and values must conform to
   * Kubernetes label syntax (RFC 1123).
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "Record<> is used for dynamic key-value structures where keys cannot be pre-defined (e.g., tags, addon names, version numbers)."
  matchLabels?: Record<string>;

  /**
   * Set-based match requirements. Up to 10 requirements are permitted per
   * selector.
   */
  @identifiers(#["key"])
  @maxItems(10)
  matchExpressions?: IdentityBindingLabelSelectorRequirement[];
}

/**
 * A single set-based requirement on a label key. Mirrors
 * k8s.io/apimachinery/pkg/apis/meta/v1.LabelSelectorRequirement.
 */
@added(Versions.v2026_05_02_preview)
model IdentityBindingLabelSelectorRequirement {
  /**
   * The label key the requirement applies to.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "The 'key' property refers to a Kubernetes label selector key, not a secret or credential."
  key: string;

  /**
   * The relationship of the key to a set of values. Must be one of
   * `In`, `NotIn`, `Exists`, or `DoesNotExist`. For `In` and `NotIn`,
   * `values` must be non-empty. For `Exists` and `DoesNotExist`,
   * `values` must be empty.
   */
  operator: Operator;

  /**
   * An array of string values, with semantics defined by `operator`. Up
   * to 50 values are permitted per requirement.
   */
  @maxItems(50)
  values?: string[];
}

/**
 * Managed identity profile for the identity binding.
 */
@added(Versions.v2026_04_01)
model IdentityBindingManagedIdentityProfile {
  /**
   * The resource ID of the managed identity.
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("^/subscriptions/[a-zA-Z0-9-]+/resourceGroups/[a-zA-Z0-9-]+/providers/Microsoft.ManagedIdentity/userAssignedIdentities/[a-zA-Z0-9-]+$")
  resourceId: Azure.Core.armResourceIdentifier;

  /**
   * The object ID of the managed identity.
   */
  @visibility(Lifecycle.Read)
  @maxLength(36)
  @minLength(36)
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  objectId?: string;

  /**
   * The client ID of the managed identity.
   */
  @visibility(Lifecycle.Read)
  @maxLength(36)
  @minLength(36)
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  clientId?: string;

  /**
   * The tenant ID of the managed identity.
   */
  @visibility(Lifecycle.Read)
  @maxLength(36)
  @minLength(36)
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  tenantId?: string;
}

/**
 * IdentityBinding OIDC issuer profile.
 */
@added(Versions.v2026_04_01)
model IdentityBindingOidcIssuerProfile {
  /**
   * The OIDC issuer URL of the IdentityBinding.
   */
  @visibility(Lifecycle.Read)
  oidcIssuerUrl?: url;
}
