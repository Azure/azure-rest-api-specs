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
 * The workspace manager member
 */
model WorkspaceManagerMember
  is Azure.ResourceManager.ProxyResource<WorkspaceManagerMemberProperties> {
  ...ResourceNameParameter<
    Resource = WorkspaceManagerMember,
    KeyName = "workspaceManagerMemberName",
    SegmentName = "workspaceManagerMembers",
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
interface WorkspaceManagerMembers {
  /**
   * Gets a workspace manager member
   */
  @tag("workspaceManagerMember")
  get is Extension.Read<workspaceExternalResource, WorkspaceManagerMember>;

  /**
   * Creates or updates a workspace manager member
   */
  @tag("workspaceManagerMember")
  createOrUpdate is Extension.CreateOrReplaceSync<
    workspaceExternalResource,
    WorkspaceManagerMember
  >;

  /**
   * Deletes a workspace manager member
   */
  @tag("workspaceManagerMember")
  delete is Extension.DeleteSync<
    workspaceExternalResource,
    WorkspaceManagerMember
  >;

  /**
   * Gets all workspace manager members that exist for the given Sentinel workspace manager
   */
  @tag("workspaceManagerMember")
  list is Extension.ListByTarget<
    workspaceExternalResource,
    WorkspaceManagerMember,
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
    Response = ArmResponse<WorkspaceManagerMembersList>
  >;
}

@@doc(WorkspaceManagerMember.name, "The name of the workspace manager member");
@@doc(WorkspaceManagerMember.properties, "The workspace manager member object");
@@doc(WorkspaceManagerMembers.createOrUpdate::parameters.resource,
  "The workspace manager member object"
);
