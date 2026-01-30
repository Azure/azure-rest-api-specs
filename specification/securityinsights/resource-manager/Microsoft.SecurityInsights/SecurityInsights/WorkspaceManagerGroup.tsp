import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.SecurityInsights;
/**
 * The workspace manager group
 */
model WorkspaceManagerGroup
  is Azure.ResourceManager.ProxyResource<WorkspaceManagerGroupProperties> {
  ...ResourceNameParameter<
    Resource = WorkspaceManagerGroup,
    KeyName = "workspaceManagerGroupName",
    SegmentName = "workspaceManagerGroups",
    NamePattern = "^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$"
  >;
}

@armResourceOperations
interface WorkspaceManagerGroups {
  /**
   * Gets a workspace manager group
   */
  get is Extension.Read<workspaceExternalResource, WorkspaceManagerGroup>;

  /**
   * Creates or updates a workspace manager group.
   */
  createOrUpdate is Extension.CreateOrReplaceSync<
    workspaceExternalResource,
    WorkspaceManagerGroup
  >;

  /**
   * Deletes a workspace manager group
   */
  delete is Extension.DeleteSync<
    workspaceExternalResource,
    WorkspaceManagerGroup
  >;

  /**
   * Gets all workspace manager groups in the Sentinel workspace manager
   */
  list is Extension.ListByTarget<
    workspaceExternalResource,
    WorkspaceManagerGroup,
    Parameters = {
      /**
       * Sorts the results. Optional.
       */
      @query("$orderby")
      $orderby?: string;

      /**
       * Returns only the first n results. Optional.
       */
      @query("$top")
      $top?: int32;

      /**
       * Skiptoken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls. Optional.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Response = ArmResponse<WorkspaceManagerGroupList>
  >;
}

@@doc(WorkspaceManagerGroup.name, "The name of the workspace manager group");
@@doc(WorkspaceManagerGroup.properties, "The workspace manager group object");
@@doc(WorkspaceManagerGroups.createOrUpdate::parameters.resource,
  "The workspace manager group object"
);
