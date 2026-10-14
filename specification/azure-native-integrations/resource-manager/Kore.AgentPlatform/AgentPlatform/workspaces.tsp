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
 * A Workspace resource in the Kore.AgentPlatform provider.
 *
 * Child proxy resource type under an Organization. Workspaces are not tracked
 * (no `location`/`tags`). Lifecycle is managed through the standard ARM verbs
 * on the child URL:
 *
 *   - PUT    .../organizations/{org}/workspaces/{workspaceName}  (create or update)
 *   - DELETE .../organizations/{org}/workspaces/{workspaceName}
 *   - GET    .../organizations/{org}/workspaces/{workspaceName}
 *   - GET    .../organizations/{org}/workspaces                  (list by parent)
 *
 * A default Workspace is also provisioned atomically when the parent
 * Organization is created (see `OrganizationProperties.defaultWorkspace`);
 * additional Workspaces are managed via the operations defined here.
 */
@parentResource(OrganizationResource)
model WorkspaceResource
  is Azure.ResourceManager.ProxyResource<WorkspaceProperties> {
  /** Name of the Workspace. */
  @key("workspaceName")
  @pattern("^[a-zA-Z0-9][a-zA-Z0-9-]{0,98}[a-zA-Z0-9]$")
  @segment("workspaces")
  @minLength(2)
  @maxLength(100)
  @path
  @visibility(Lifecycle.Read)
  name: string;
}

/** Operations on the Workspace child resource type. */
@armResourceOperations
interface Workspaces {
  /** Get a Workspace under an Organization. */
  get is ArmResourceRead<WorkspaceResource>;

  /** Create or update a Workspace under an Organization (long-running). */
  createOrUpdate is ArmResourceCreateOrReplaceAsync<WorkspaceResource>;

  /** Delete a Workspace under an Organization (long-running). */
  delete is ArmResourceDeleteWithoutOkAsync<WorkspaceResource>;

  /** List Workspaces under an Organization. */
  listByOrganization is ArmResourceListByParent<WorkspaceResource>;

  /** Links SaaS resources to the workspace. Accepts the full list of SaaS assets to be linked. */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "void-returning LRO action; 202 + default is sufficient."
  @added(Versions.v2026_07_01_preview)
  @summary("Links SaaS resources to the workspace.")
  linkSaaS is ArmResourceActionAsync<
    WorkspaceResource,
    WorkspaceSaaSData,
    void
  >;

  /** Returns the list of SaaS resources linked to the workspace. */
  @added(Versions.v2026_07_01_preview)
  listLinkedSaaS is ArmResourceActionSync<
    WorkspaceResource,
    void,
    ArmResponse<WorkspaceLinkedSaaSListResponse>
  >;

  /** Returns the complete Workspace details reported by Kore, including its projects. */
  @added(Versions.v2026_07_01_preview)
  @action("getWorkspaceDetails")
  getDetails is ArmResourceActionSync<
    WorkspaceResource,
    void,
    ArmResponse<WorkspaceDetail>
  >;
}
