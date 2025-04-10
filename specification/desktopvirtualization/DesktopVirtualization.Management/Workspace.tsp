import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DesktopVirtualization;
/**
 * Represents a Workspace definition.
 */
model Workspace is Azure.ResourceManager.TrackedResource<WorkspaceProperties> {
  ...ResourceNameParameter<
    Resource = Workspace,
    KeyName = "workspaceName",
    SegmentName = "workspaces",
    NamePattern = "^[A-Za-z0-9@.\\-_ ]*$"
  >;
}

@armResourceOperations
interface Workspaces {
  /**
   * Get a workspace.
   */
  get is ArmResourceRead<Workspace>;

  /**
   * Create or update a workspace.
   */
  createOrUpdate is ArmResourceCreateOrReplaceSync<Workspace>;

  /**
   * Update a workspace.
   */
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<Workspace, PatchModel = WorkspacePatch>;

  /**
   * Remove a workspace.
   */
  delete is ArmResourceDeleteSync<Workspace>;

  /**
   * List workspaces.
   */
  listByResourceGroup is ArmResourceListByParent<
    Workspace,
    Parameters = {
      /**
       * Number of items per page.
       */
      @query("pageSize")
      pageSize?: int32;

      /**
       * Indicates whether the collection is descending.
       */
      @query("isDescending")
      isDescending?: boolean;

      /**
       * Initial number of items to skip.
       */
      @query("initialSkip")
      initialSkip?: int32;
    },
    Response = ArmResponse<WorkspaceList>
  >;

  /**
   * List workspaces in subscription.
   */
  listBySubscription is ArmListBySubscription<
    Workspace,
    Response = ArmResponse<WorkspaceList>
  >;

  /**
   * List the private link resources available for this workspace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @get
  @action("privateLinkResources")
  @operationId("PrivateLinkResources_ListByWorkspace")
  listByWorkspace is ArmResourceActionSync<
    Workspace,
    void,
    ArmResponse<ResourceListResult<PrivateLinkResource>>,
    Parameters = {
      /**
       * Number of items per page.
       */
      @query("pageSize")
      pageSize?: int32;

      /**
       * Indicates whether the collection is descending.
       */
      @query("isDescending")
      isDescending?: boolean;

      /**
       * Initial number of items to skip.
       */
      @query("initialSkip")
      initialSkip?: int32;
    }
  >;
}

@@maxLength(Workspace.name, 255);
@@minLength(Workspace.name, 1);
@@doc(Workspace.name, "The name of the workspace");
@@doc(Workspace.properties, "Detailed properties for Workspace");
@@doc(Workspaces.createOrUpdate::parameters.resource,
  "Object containing Workspace definitions."
);
@@doc(Workspaces.update::parameters.properties,
  "Object containing Workspace definitions."
);
