import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "../Common/main.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using Microsoft.Common;

namespace Microsoft.Authorization;
/**
 * Role management policy
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@extensionResource
model RoleManagementPolicyAssignment
  is Azure.ResourceManager.ExtensionResource<RoleManagementPolicyAssignmentProperties> {
  ...ResourceNameParameter<
    Resource = RoleManagementPolicyAssignment,
    KeyName = "roleManagementPolicyAssignmentName",
    SegmentName = "roleManagementPolicyAssignments",
    NamePattern = ""
  >;
}

@armResourceOperations(#{ omitTags: true })
interface RoleManagementPolicyAssignments {
  /**
   * Get the specified role management policy assignment for a resource scope
   */
  @tag("roleManagementPolicyAssignments")
  get is Extension.Read<
    Extension.ScopeParameter,
    RoleManagementPolicyAssignment,
    Error = CloudError
  >;

  /**
   * Create a role management policy assignment
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @tag("roleManagementPolicyAssignments")
  create is Extension.CreateOrReplaceSync<
    Extension.ScopeParameter,
    RoleManagementPolicyAssignment,
    Response = ArmResourceCreatedSyncResponse<RoleManagementPolicyAssignment>,
    Error = CloudError
  >;

  /**
   * Delete a role management policy assignment
   */
  @tag("roleManagementPolicyAssignments")
  delete is Extension.DeleteSync<
    Extension.ScopeParameter,
    RoleManagementPolicyAssignment,
    Error = CloudError
  >;

  /**
   * Gets role management assignment policies for a resource scope.
   */
  @tag("roleManagementPolicyAssignments")
  listForScope is Extension.ListByTarget<
    Extension.ScopeParameter,
    RoleManagementPolicyAssignment,
    Error = CloudError
  >;
}

@@doc(RoleManagementPolicyAssignment.name,
  "The name of format {guid_guid} the role management policy assignment to get."
);
@@doc(RoleManagementPolicyAssignment.properties,
  "Role management policy properties."
);
@@doc(RoleManagementPolicyAssignments.create::parameters.resource,
  "Parameters for the role management policy assignment."
);
