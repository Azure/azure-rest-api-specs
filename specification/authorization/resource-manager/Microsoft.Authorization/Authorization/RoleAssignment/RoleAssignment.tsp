import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.RoleAssignment;
/**
 * Role Assignments
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@extensionResource
model RoleAssignment
  is Azure.ResourceManager.ExtensionResource<RoleAssignmentProperties> {
  ...ResourceNameParameter<
    Resource = RoleAssignment,
    KeyName = "roleAssignmentName",
    SegmentName = "roleAssignments",
    NamePattern = ""
  >;
}

alias RoleAssignmentsOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** The fully qualified Azure Resource manager identifier of the resource. */
    @path(#{ allowReserved: true })
    @segment("")
    @key
    scope: string;

    /**
     * The provider namespace. Always "Microsoft.Authorization".
     */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Authorization";
  },
  {},
  {
    /**
     * The name of the role assignment. It can be any valid GUID.
     */
    @path(#{ allowReserved: true })
    @key
    @segment("roleAssignments")
    @pattern("")
    roleAssignmentName: string;
  }
>;

alias RoleAssignmentQuerysOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** The fully qualified Azure Resource manager identifier of the resource. */
    @path(#{ allowReserved: true })
    @segment("")
    @key
    scope: string;

    /**
     * The provider namespace. Always "Microsoft.Authorization".
     */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Authorization";
  },
  {},
  {
    /**
     * Tenant ID for cross-tenant request
     */
    @query("tenantId")
    tenantId?: string;

    /**
     * The name of the role assignment. It can be any valid GUID.
     */
    @path(#{ allowReserved: true })
    @segment("roleAssignments")
    @pattern("")
    roleAssignmentName: string;
  }
>;

alias RoleAssignmentsForResourceOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /**
     * The ID of the target subscription.
     */
    @path
    @segment("subscriptions")
    @key
    subscriptionId: string;

    /**
     * The name of the resource group. The name is case insensitive.
     */
    @path
    @segment("resourceGroups")
    @key
    resourceGroupName: string;

    /**
     * The namespace of the resource provider.
     */
    @path(#{ allowReserved: true })
    @segment("providers")
    @key
    resourceProviderNamespace: string;

    /**
     * The resource type of the resource.
     */
    @path(#{ allowReserved: true })
    @segment("")
    @key
    resourceType: string;

    /**
     * The name of the resource to get role assignments for.
     */
    @path(#{ allowReserved: true })
    @segment("")
    @key
    resourceName: string;

    /**
     * The provider namespace. Always "Microsoft.Authorization".
     */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.Authorization";
  },
  {},
  {}
>;

@armResourceOperations
interface RoleAssignments {
  /**
   * Get a role assignment by scope and name.
   */
  get is RoleAssignmentQuerysOps.Read<RoleAssignment>;

  /**
   * Create or update a role assignment by scope and name.
   */
  create is RoleAssignmentsOps.CreateOrUpdateSync<
    RoleAssignment,
    Request = RoleAssignmentCreateParameters
  >;

  /**
   * Delete a role assignment by scope and name.
   */
  delete is RoleAssignmentQuerysOps.DeleteSync<
    RoleAssignment,
    Response = ArmResponse<RoleAssignment> | ArmDeletedNoContentResponse
  >;

  /**
   * List all role assignments that apply to a scope.
   */
  listForScope is Extension.ListByTarget<
    Extension.ScopeParameter,
    RoleAssignment,
    Parameters = {
      /**
       * The filter to apply on the operation. Use $filter=atScope() to return all role assignments at or above the scope. Use $filter=principalId eq {id} to return all role assignments at, above or below the scope for the specified principal.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Tenant ID for cross-tenant request
       */
      @query("tenantId")
      tenantId?: string;

      /**
       * The skipToken to apply on the operation. Use $skipToken={skiptoken} to return paged role assignments following the skipToken passed. Only supported on provider level calls.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Response = RoleAssignmentListResult
  >;

  /**
   * List all role assignments that apply to a subscription.
   */
  listForSubscription is ArmListBySubscription<
    RoleAssignment,
    Parameters = {
      /**
       * The filter to apply on the operation. Use $filter=atScope() to return all role assignments at or above the scope. Use $filter=principalId eq {id} to return all role assignments at, above or below the scope for the specified principal.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Tenant ID for cross-tenant request
       */
      @query("tenantId")
      tenantId?: string;
    },
    Response = RoleAssignmentListResult
  >;

  /**
   * List all role assignments that apply to a resource group.
   */
  listForResourceGroup is Extension.ListByTarget<
    Extension.ResourceGroup,
    RoleAssignment,
    {
      /**
       * The filter to apply on the operation. Use $filter=atScope() to return all role assignments at or above the scope. Use $filter=principalId eq {id} to return all role assignments at, above or below the scope for the specified principal.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Tenant ID for cross-tenant request
       */
      @query("tenantId")
      tenantId?: string;
    },
    Response = RoleAssignmentListResult
  >;

  /**
   * List all role assignments that apply to a resource.
   */
  listForResource is RoleAssignmentsForResourceOps.List<
    RoleAssignment,
    Parameters = {
      /**
       * The filter to apply on the operation. Use $filter=atScope() to return all role assignments at or above the scope. Use $filter=principalId eq {id} to return all role assignments at, above or below the scope for the specified principal.
       */
      @query("$filter")
      $filter?: string;

      /**
       * Tenant ID for cross-tenant request
       */
      @query("tenantId")
      tenantId?: string;
    },
    Response = RoleAssignmentListResult
  >;
}

@@doc(RoleAssignment.properties, "Role assignment properties.");
@@doc(RoleAssignments.create::parameters.resource,
  "Parameters for the role assignment."
);

alias RoleAssignmentByIdOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;
  },
  {},
  {
    /**
     * The fully qualified ID of the role assignment including scope, resource name, and resource type. Format: /{scope}/providers/Microsoft.Authorization/roleAssignments/{roleAssignmentName}. Example: /subscriptions/<SUB_ID>/resourcegroups/<RESOURCE_GROUP>/providers/Microsoft.Authorization/roleAssignments/<ROLE_ASSIGNMENT_NAME>
     */
    @path(#{ allowReserved: true })
    @key
    roleAssignmentId: string;
  }
>;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface RoleAssignmentsByIdOperations {
  /**
   * Get a role assignment by ID.
   */
  @tag("RoleAssignments")
  getById is RoleAssignmentByIdOps.Read<
    RoleAssignment,
    Parameters = {
      /**
       * Tenant ID for cross-tenant request
       */
      @query("tenantId")
      tenantId?: string;
    }
  >;

  /**
   * Create or update a role assignment by ID.
   */
  @tag("RoleAssignments")
  createById is RoleAssignmentByIdOps.CreateOrUpdateSync<
    RoleAssignment,
    Request = RoleAssignmentCreateParameters
  >;

  /**
   * Delete a role assignment by ID.
   */
  @tag("RoleAssignments")
  deleteById is RoleAssignmentByIdOps.DeleteSync<
    RoleAssignment,
    Parameters = {
      /**
       * Tenant ID for cross-tenant request
       */
      @query("tenantId")
      tenantId?: string;
    },
    Response = ArmResponse<RoleAssignment> | ArmDeletedNoContentResponse
  >;
}
