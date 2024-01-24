import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.DesktopVirtualization;
/**
 * Represents a Workspace definition.
 */
#suppress "@azure-tools/typespec-azure-core/composition-over-inheritance" "For backward compatibility"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "For backward compatibility"
@Azure.ResourceManager.Private.armResourceInternal(WorkspaceProperties)
@includeInapplicableMetadataInPayload(false)
model Workspace extends TrackedResourceBase {
  /**
   * The name of the workspace
   */
  @maxLength(64)
  @minLength(3)
  @path
  @key("workspaceName")
  @segment("workspaces")
  name: string;

  /**
   * Detailed properties for Workspace
   */
  @extension("x-ms-client-flatten", true)
  properties?: WorkspaceProperties;
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
  @parameterVisibility("read")
  update is ArmCustomPatchSync<Workspace, WorkspacePatch>;

  /**
   * Remove a workspace.
   */
  delete is ArmResourceDeleteSync<Workspace>;

  /**
   * List workspaces.
   */
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("Workspaces_ListByResourceGroup")
  listByResourceGroup is ArmResourceListByParent<
    Workspace,
    {
      ...BaseParameters<Workspace>;

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

  /**
   * List workspaces in subscription.
   */
  listBySubscription is ArmListBySubscription<Workspace>;

  /**
   * List the private link resources available for this workspace.
   */
  // FIXME: PrivateLinkResources_ListByWorkspace could not be converted to a resource operation
  #suppress "@azure-tools/typespec-azure-core/no-operation-id" "For backward compatibility"
  @operationId("PrivateLinkResources_ListByWorkspace")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.DesktopVirtualization/workspaces/{workspaceName}/privateLinkResources")
  @get
  listByWorkspace is Azure.Core.Foundations.Operation<
    {
      /**
       * The ID of the target subscription.
       */
      @minLength(1)
      @path
      subscriptionId: string;

      /**
       * The name of the resource group. The name is case insensitive.
       */
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      /**
       * The name of the workspace
       */
      @maxLength(64)
      @minLength(3)
      @path
      workspaceName: string;

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
    PrivateLinkResourceListResult
  >;
}

@@projectedName(Workspaces.createOrUpdate::parameters.resource,
  "json",
  "workspace"
);
@@extension(Workspaces.createOrUpdate::parameters.resource,
  "x-ms-client-name",
  "workspace"
);
@@doc(Workspaces.createOrUpdate::parameters.resource,
  "Object containing Workspace definitions."
);
@@projectedName(Workspaces.update::parameters.properties, "json", "workspace");
@@extension(Workspaces.update::parameters.properties,
  "x-ms-client-name",
  "workspace"
);
@@doc(Workspaces.update::parameters.properties,
  "Object containing Workspace definitions."
);
