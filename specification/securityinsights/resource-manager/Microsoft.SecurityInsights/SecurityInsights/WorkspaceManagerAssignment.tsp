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
 * The workspace manager assignment
 */
model WorkspaceManagerAssignment
  is Azure.ResourceManager.ProxyResource<WorkspaceManagerAssignmentProperties> {
  ...ResourceNameParameter<
    Resource = WorkspaceManagerAssignment,
    KeyName = "workspaceManagerAssignmentName",
    SegmentName = "workspaceManagerAssignments",
    NamePattern = "^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$"
  >;

  /**
   * Resource Etag.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @visibility(Lifecycle.Read)
  etag?: string;
}

@armResourceOperations(#{ omitTags: true })
interface WorkspaceManagerAssignments {
  /**
   * Gets a workspace manager assignment
   */
  @tag("workspaceManagerAssignments")
  get is Extension.Read<workspaceExternalResource, WorkspaceManagerAssignment>;

  /**
   * Creates or updates a workspace manager assignment.
   */
  @tag("workspaceManagerAssignments")
  createOrUpdate is Extension.CreateOrReplaceSync<
    workspaceExternalResource,
    WorkspaceManagerAssignment
  >;

  /**
   * Deletes a workspace manager assignment
   */
  @tag("workspaceManagerAssignments")
  delete is Extension.DeleteSync<
    workspaceExternalResource,
    WorkspaceManagerAssignment
  >;

  /**
   * Get all workspace manager assignments for the Sentinel workspace manager.
   */
  @tag("workspaceManagerAssignments")
  list is Extension.ListByTarget<
    workspaceExternalResource,
    WorkspaceManagerAssignment,
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
    Response = ArmResponse<WorkspaceManagerAssignmentList>
  >;

  /**
   * Create a job for the specified workspace manager assignment
   */
  @action("jobs")
  @tag("workspaceManagerAssignments")
  create is Extension.ActionSync<
    workspaceExternalResource,
    WorkspaceManagerAssignment,
    void,
    ArmResponse<Job>
  >;
}

@@doc(WorkspaceManagerAssignment.name,
  "The name of the workspace manager assignment"
);
@@doc(WorkspaceManagerAssignment.properties,
  "The workspace manager assignment object"
);
@@doc(WorkspaceManagerAssignments.createOrUpdate::parameters.resource,
  "The workspace manager assignment"
);
