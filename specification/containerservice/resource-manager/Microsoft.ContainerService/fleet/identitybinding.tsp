import "@azure-tools/typespec-azure-core";
import "./selector.tsp";

using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;

namespace Microsoft.ContainerService;

@doc("A fleet identity binding binds a user-assigned managed identity across the fleet members selected by its member selector.")
@added(Versions.v2026_11_02_preview)
@resource("identityBindings")
@parentResource(Fleet)
model FleetIdentityBinding
  is Azure.ResourceManager.ProxyResource<FleetIdentityBindingProperties> {
  @doc("The name of the fleet identity binding resource.")
  @pattern("^[a-z][a-z0-9]{0,63}$")
  @minLength(1)
  @maxLength(63)
  @path
  @segment("identityBindings")
  @key("identityBindingName")
  @visibility(Lifecycle.Create, Lifecycle.Read)
  name: string;

  ...EntityTagProperty;
}

@doc("The properties of a fleet identity binding.")
@added(Versions.v2026_11_02_preview)
model FleetIdentityBindingProperties {
  @doc("The status of the last operation.")
  @visibility(Lifecycle.Read)
  provisioningState?: FleetIdentityBindingProvisioningState;

  @doc("""
    Select the fleet members that this identity binding is applied to.
      * Only key/value pairs with the `=` operator are accepted in the label selector.
      * If empty or not specified, no fleet members will be selected.
    """)
  @visibility(Lifecycle.Read, Lifecycle.Create)
  memberSelector?: MemberSelector;

  @doc("Managed identity profile for the identity binding.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  managedIdentity: FleetIdentityBindingManagedIdentityProfile;

  @doc("""
    Optional list of subjects authorized to use this identity binding for
    token exchange. Each entry pairs a required namespace label selector
    with an optional service account label selector; selectors within an
    entry are AND'd, and multiple entries are OR'd. When omitted or empty,
    authorization falls back exclusively to ClusterRole/ClusterRoleBinding
    evaluation. Maximum 100 entries.
    """)
  @identifiers(#[])
  @maxItems(100)
  allowedSubjects?: FleetAllowedSubject[];

  @doc("The OIDC issuer URL of the IdentityBinding.")
  @visibility(Lifecycle.Read)
  oidcIssuer?: FleetIdentityBindingOidcIssuerProfile;

  @doc("The fleet identity binding status.")
  @visibility(Lifecycle.Read)
  status?: FleetIdentityBindingStatus;
}

@doc("The provisioning state of the fleet identity binding resource.")
@added(Versions.v2026_11_02_preview)
@Azure.Core.lroStatus
union FleetIdentityBindingProvisioningState {
  string,
  ResourceProvisioningState,

  @doc("The identity binding is being applied to the selected fleet members.")
  Applying: "Applying",
}

@doc("Status of the fleet identity binding.")
@added(Versions.v2026_11_02_preview)
model FleetIdentityBindingStatus {
  @doc("The last operation ID for the fleet identity binding.")
  @visibility(Lifecycle.Read)
  lastOperationId?: string;

  @doc("The last operation error of the fleet identity binding.")
  @visibility(Lifecycle.Read)
  lastOperationError?: Azure.ResourceManager.Foundations.ErrorDetail;
}

@doc("Managed identity profile for the identity binding.")
@added(Versions.v2026_11_02_preview)
model FleetIdentityBindingManagedIdentityProfile {
  @doc("The resource ID of the managed identity.")
  @visibility(Lifecycle.Read, Lifecycle.Create)
  @pattern("^/subscriptions/[a-zA-Z0-9-]+/resourceGroups/[a-zA-Z0-9-]+/providers/Microsoft.ManagedIdentity/userAssignedIdentities/[a-zA-Z0-9-]+$")
  resourceId: Azure.Core.armResourceIdentifier;

  @doc("The object ID of the managed identity.")
  @visibility(Lifecycle.Read)
  @maxLength(36)
  @minLength(36)
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  objectId?: string;

  @doc("The client ID of the managed identity.")
  @visibility(Lifecycle.Read)
  @maxLength(36)
  @minLength(36)
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  clientId?: string;

  @doc("The tenant ID of the managed identity.")
  @visibility(Lifecycle.Read)
  @maxLength(36)
  @minLength(36)
  @pattern("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$")
  tenantId?: string;
}

@doc("IdentityBinding OIDC issuer profile.")
@added(Versions.v2026_11_02_preview)
model FleetIdentityBindingOidcIssuerProfile {
  #suppress "@azure-tools/typespec-client-generator-core/csharp-no-url-suffix" "Name kept for backward compatibility"
  @doc("The OIDC issuer URL of the IdentityBinding.")
  @visibility(Lifecycle.Read)
  oidcIssuerUrl?: url;
}

@doc("""
  A subject authorized to use the identity binding for token exchange.
  The namespace selector is required and must be non-empty. The service
  account selector is optional; when omitted, all service accounts in
  matching namespaces are authorized. Selectors within a single
  AllowedSubject are AND'd; multiple AllowedSubjects on an
  IdentityBinding are OR'd.
  """)
@added(Versions.v2026_11_02_preview)
model FleetAllowedSubject {
  @doc("""
    Label selector matching the namespaces in which this identity may be
    used. Must be non-empty: an empty selector would match every namespace
    and is rejected to prevent overly permissive bindings. Use the built-in
    `kubernetes.io/metadata.name` label to target specific namespaces by
    name.
    """)
  namespaceSelector: FleetIdentityBindingLabelSelector;

  @doc("""
    Optional label selector matching the service accounts (within the
    namespaces matched by `namespaceSelector`) that may use this identity.
    When omitted, all service accounts in matching namespaces are
    authorized. When provided, it must be non-empty.
    """)
  serviceAccountSelector?: FleetIdentityBindingLabelSelector;
}

@doc("A label selector is a label query over a set of resources. The result of matchLabels and matchExpressions are ANDed. An empty label selector matches all objects. A null label selector matches no objects.")
@added(Versions.v2026_11_02_preview)
model FleetIdentityBindingLabelSelector {
  @doc("matchLabels is an array of {key=value} pairs. A single {key=value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is `key`, the operator is `In`, and the values array contains only `value`. The requirements are ANDed.")
  matchLabels?: string[];

  @doc("matchExpressions is a list of label selector requirements. The requirements are ANDed.")
  @identifiers(#[])
  matchExpressions?: FleetIdentityBindingLabelSelectorRequirement[];
}

@doc("A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values.")
@added(Versions.v2026_11_02_preview)
model FleetIdentityBindingLabelSelectorRequirement {
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "The 'key' property refers to a Kubernetes label selector key, not a secret or credential."
  @doc("key is the label key that the selector applies to.")
  key?: string;

  @doc("operator represents a key's relationship to a set of values. Valid operators are In and NotIn")
  operator?: FleetIdentityBindingLabelSelectorOperator;

  @doc("values is an array of string values, the values array must be non-empty.")
  values?: string[];
}

@doc("operator represents a key's relationship to a set of values. Valid operators are In and NotIn")
@added(Versions.v2026_11_02_preview)
union FleetIdentityBindingLabelSelectorOperator {
  string,

  @doc("The value of the key should be in the given list.")
  In: "In",

  @doc("The value of the key should not be in the given list.")
  NotIn: "NotIn",

  @doc("The value of the key should exist.")
  Exists: "Exists",

  @doc("The value of the key should not exist.")
  DoesNotExist: "DoesNotExist",
}

@added(Versions.v2026_11_02_preview)
@armResourceOperations
interface FleetIdentityBindings {
  get is ArmResourceRead<FleetIdentityBinding>;

  createOrUpdate is ArmResourceCreateOrUpdateAsync<
    FleetIdentityBinding,
    Azure.ResourceManager.Foundations.BaseParameters<FleetIdentityBinding> &
      IfMatchParameters<FleetIdentityBinding> &
      IfNoneMatchParameters<FleetIdentityBinding>,
    LroHeaders = Azure.Core.Foundations.RetryAfterHeader
  >;

  delete is ArmResourceDeleteWithoutOkAsync<
    FleetIdentityBinding,
    Azure.ResourceManager.Foundations.BaseParameters<FleetIdentityBinding> &
      IfMatchParameters<FleetIdentityBinding>
  >;

  listByFleet is ArmResourceListByParent<FleetIdentityBinding>;

  @doc("Applies the fleet identity binding to the selected fleet members, creating, updating or deleting the corresponding managedCluster/identityBinding resources.")
  apply is Azure.ResourceManager.ArmResourceActionAsync<
    FleetIdentityBinding,
    void,
    FleetIdentityBinding,
    BaseParameters<FleetIdentityBinding> &
      IfMatchParameters<FleetIdentityBinding>
  >;
}
