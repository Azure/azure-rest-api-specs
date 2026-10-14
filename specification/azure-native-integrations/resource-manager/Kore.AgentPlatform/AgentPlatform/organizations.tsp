import "@typespec/http";
import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.ResourceManager;

namespace Kore.AgentPlatform;

/**
 * An Organization resource in the Kore.AgentPlatform provider.
 *
 * Top-level tracked ARM resource. Each Organization is provisioned with a default
 * Workspace atomically; additional Workspaces are managed via the
 * `createWorkspace` and `deleteWorkspace` actions defined below.
 */
model OrganizationResource
  is Azure.ResourceManager.TrackedResource<OrganizationProperties> {
  /** Name of the Organization. */
  @key("organizationName")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]{0,48}[a-zA-Z0-9]$")
  @segment("organizations")
  @minLength(2)
  @maxLength(50)
  @path
  @visibility(Lifecycle.Read, Lifecycle.Create)
  name: string;
}

/** Provider-level common operations (Operations_List). */
interface Operations extends Azure.ResourceManager.Operations {}

/** Operations on the Organization resource type. */
@armResourceOperations
interface Organizations {
  /** Get an Organization. */
  get is ArmResourceRead<OrganizationResource>;

  /** Create or update an Organization (long-running). */
  create is ArmResourceCreateOrReplaceAsync<OrganizationResource>;

  /** Update mutable properties of an Organization (long-running). */
  #suppress "@typespec/http/deprecated-implicit-optionality" "PATCH reuses create-side models containing fields that are required at create time (notably the spread of LiftrBase.UserDetails and items of LiftrBase.MarketplaceDetails[]). implicitOptionality flattens those nested required fields to optional in the PATCH schema to preserve partial-update semantics without duplicating every model as a *ForUpdate variant."
  @patch(#{ implicitOptionality: true })
  update is ArmCustomPatchAsync<
    OrganizationResource,
    OrganizationResourceUpdate
  >;

  /**
   * Delete an Organization (long-running).
   *
   * Permanently removes the Organization and cascades the deletion to all
   * child Workspaces at the partner. This operation is irreversible.
   */
  delete is ArmResourceDeleteWithoutOkAsync<OrganizationResource>;

  /** List Organizations in a Resource Group. */
  listByResourceGroup is ArmResourceListByParent<OrganizationResource>;

  /** List Organizations in a Subscription. */
  listBySubscription is ArmListBySubscription<OrganizationResource>;

  /**
   * Lists all Workspaces in the Kore Organization, including Workspaces not managed through Liftr.
   *
   * This discovery operation uses POST because its response combines ARM-tracked
   * Workspaces with Kore-only Workspaces that have no ARM resource ID and cannot
   * be represented by the standard Workspaces collection GET.
   */
  @added(Versions.v2026_07_01_preview)
  listWorkspaces is ArmResourceActionSync<
    OrganizationResource,
    void,
    ArmResponse<ListWorkspacesResponse>
  >;

  /** Links SaaS resources to the organization. Accepts the full list of SaaS assets to be linked. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "void-returning LRO action; 202 + default is sufficient."
  @removed(Versions.v2026_07_01_preview)
  @summary("Links SaaS resources to the organization.")
  linkSaaS is ArmResourceActionAsync<OrganizationResource, SaaSData, void>;

  /** Returns the list of SaaS resources linked to the organization. */
  @removed(Versions.v2026_07_01_preview)
  listLinkedSaaS is ArmResourceActionSync<
    OrganizationResource,
    void,
    ArmResponse<LinkedSaaSListResponse>
  >;
}

// =============================================================================
// Subscription-level SaaS operations
//
// "SaaS" is the industry-standard abbreviation for Software as a Service and is
// retained verbatim in model, interface, and operation names for consistency
// with the Liftr/marketplace ecosystem. Per-statement #suppress directives
// below silence the casing-style linter; TypeSpec requires one per declaration.
// =============================================================================

/** Subscription-level SaaS activation operations. */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "Subscription-level SaaS operation"
#suppress "@azure-tools/typespec-azure-core/casing-style" "SaaS abbreviation."
interface SaaSOperationGroup {
  /** Resolve the token to get the SaaS resource ID and activate the SaaS resource. */
  @autoRoute
  @post
  @action("activateSaaS")
  activateResource is ArmProviderActionAsync<
    Request = ActivateSaaSParameterRequest,
    Response = SaaSResourceDetailsResponse,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}
