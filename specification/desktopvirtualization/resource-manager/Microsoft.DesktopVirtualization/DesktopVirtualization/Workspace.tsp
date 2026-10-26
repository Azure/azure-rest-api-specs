import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@azure-tools/typespec-client-generator-core";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./CustomOperations.tsp";

using Azure.ClientGenerator.Core;
using Azure.ResourceManager;
using TypeSpec.Http;

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
  ...ManagedServiceIdentityProperty;
  ...etagProperty;
  ...ResourceKindProperty;
  ...ManagedByProperty;
  ...ResourcePlanProperty;
  ...ResourceSkuProperty;
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
  update is ArmCustomPatchSyncWithOptionalBody<Workspace, WorkspacePatch>;

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
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing listByResourceGroup.pageSize retains the pageSize query parameter; preserve wire compatibility."
      @query("pageSize")
      pageSize?: int32;

      /**
       * Indicates whether the collection is descending.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing listByResourceGroup.isDescending retains the isDescending query parameter; preserve wire compatibility."
      @query("isDescending")
      isDescending?: boolean;

      /**
       * Initial number of items to skip.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing listByResourceGroup.initialSkip retains the initialSkip query parameter; preserve wire compatibility."
      @query("initialSkip")
      initialSkip?: int32;
    },
    Response = WorkspaceList
  >;

  /**
   * List workspaces in subscription.
   */
  listBySubscription is ArmListBySubscription<
    Workspace,
    Response = WorkspaceList
  >;
}

@@maxLength(Workspace.name, 64);
@@minLength(Workspace.name, 3);
@@doc(Workspace.name, "The name of the workspace");
@@doc(Workspace.properties, "Detailed properties for Workspace");
@@doc(
  Workspaces.createOrUpdate::parameters.resource,
  "Object containing Workspace definitions."
);
@@clientName(Workspaces.update::parameters.body, "workspace");
