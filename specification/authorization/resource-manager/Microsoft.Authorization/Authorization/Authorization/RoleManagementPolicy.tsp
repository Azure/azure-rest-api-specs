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
model RoleManagementPolicy
  is Azure.ResourceManager.ExtensionResource<RoleManagementPolicyProperties> {
  ...ResourceNameParameter<
    Resource = RoleManagementPolicy,
    KeyName = "roleManagementPolicyName",
    SegmentName = "roleManagementPolicies",
    NamePattern = ""
  >;
}

@armResourceOperations(#{ omitTags: true })
interface RoleManagementPolicies {
  /**
   * Get the specified role management policy for a resource scope
   */
  @tag("roleManagementPolicies")
  get is Extension.Read<
    Extension.ScopeParameter,
    RoleManagementPolicy,
    Error = CloudError
  >;

  /**
   * Update a role management policy
   */
  @tag("roleManagementPolicies")
  @patch(#{ implicitOptionality: false })
  update is Extension.CustomPatchSync<
    Extension.ScopeParameter,
    RoleManagementPolicy,
    PatchModel = RoleManagementPolicy,
    Error = CloudError
  >;

  /**
   * Delete a role management policy
   */
  @tag("roleManagementPolicies")
  delete is Extension.DeleteSync<
    Extension.ScopeParameter,
    RoleManagementPolicy,
    Error = CloudError
  >;

  /**
   * Gets role management policies for a resource scope.
   */
  @tag("roleManagementPolicies")
  listForScope is Extension.ListByTarget<
    Extension.ScopeParameter,
    RoleManagementPolicy,
    Error = CloudError
  >;
}

@@doc(RoleManagementPolicy.name,
  "The name (guid) of the role management policy to get."
);
@@doc(RoleManagementPolicy.properties, "Role management policy properties.");
@@doc(RoleManagementPolicies.update::parameters.properties,
  "Parameters for the role management policy."
);
