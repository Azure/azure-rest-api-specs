import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "@typespec/versioning";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;
using TypeSpec.Versioning;

namespace Microsoft.DenyAssignment;
/**
 * Deny Assignment
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-duplicate-base-parameter" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@extensionResource
model DenyAssignment
  is Azure.ResourceManager.ExtensionResource<DenyAssignmentProperties> {
  ...ResourceNameParameter<
    Resource = DenyAssignment,
    KeyName = "denyAssignmentId",
    SegmentName = "denyAssignments",
    NamePattern = ""
  >;
}

alias DenyAssignmentForResourceOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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
     * The parent resource identity.
     */
    @path(#{ allowReserved: true })
    @segment("")
    @key
    parentResourcePath: string;

    /**
     * The resource type of the resource.
     */
    @path(#{ allowReserved: true })
    @segment("")
    @key
    resourceType: string;

    /**
     * The name of the resource to get deny assignments for.
     */
    @path
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
  {
    @path
    @segment("denyAssignments")
    @key
    denyAssignmentId: string;
  }
>;

alias DenyAssignmentIdByIdOps = Azure.ResourceManager.Legacy.ExtensionOperations<
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
    denyAssignmentId: string;
  }
>;

@armResourceOperations
interface DenyAssignments {
  /**
   * Get the specified deny assignment.
   */
  get is Extension.Read<Extension.ScopeParameter, DenyAssignment>;

  /**
   * Create or update the specified deny assignment.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "operationId required for backward compatibility with existing SDK"
  @added(Versions.v2024_07_01_preview)
  @operationId("DenyAssignments_CreateOrUpdate")
  create is Extension.CreateOrReplaceSync<
    Extension.ScopeParameter,
    DenyAssignment
  >;

  /**
   * Delete the specified deny assignment.
   */
  @added(Versions.v2024_07_01_preview)
  delete is Extension.DeleteSync<Extension.ScopeParameter, DenyAssignment>;

  /**
   * Gets deny assignments for a scope.
   */
  listForScope is Extension.ListByTarget<
    Extension.ScopeParameter,
    DenyAssignment,
    {
      /**
       * The filter to apply on the operation. Use $filter=atScope() to return all deny assignments at or above the scope. Use $filter=denyAssignmentName eq '{name}' to search deny assignments by name at specified scope. Use $filter=principalId eq '{id}' to return all deny assignments at, above and below the scope for the specified principal. Use $filter=gdprExportPrincipalId eq '{id}' to return all deny assignments at, above and below the scope for the specified principal. This filter is different from the principalId filter as it returns not only those deny assignments that contain the specified principal is the Principals list but also those deny assignments that contain the specified principal is the ExcludePrincipals list. Additionally, when gdprExportPrincipalId filter is used, only the deny assignment name and description properties are returned.
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Gets all deny assignments for the subscription.
   */
  list is ArmListBySubscription<
    DenyAssignment,
    Parameters = {
      /**
       * The filter to apply on the operation. Use $filter=atScope() to return all deny assignments at or above the scope. Use $filter=denyAssignmentName eq '{name}' to search deny assignments by name at specified scope. Use $filter=principalId eq '{id}' to return all deny assignments at, above and below the scope for the specified principal. Use $filter=gdprExportPrincipalId eq '{id}' to return all deny assignments at, above and below the scope for the specified principal. This filter is different from the principalId filter as it returns not only those deny assignments that contain the specified principal is the Principals list but also those deny assignments that contain the specified principal is the ExcludePrincipals list. Additionally, when gdprExportPrincipalId filter is used, only the deny assignment name and description properties are returned.
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Gets deny assignments for a resource group.
   */
  listForResourceGroup is Extension.ListByTarget<
    Extension.ResourceGroup,
    DenyAssignment,
    {
      /**
       * The filter to apply on the operation. Use $filter=atScope() to return all deny assignments at or above the scope. Use $filter=denyAssignmentName eq '{name}' to search deny assignments by name at specified scope. Use $filter=principalId eq '{id}' to return all deny assignments at, above and below the scope for the specified principal. Use $filter=gdprExportPrincipalId eq '{id}' to return all deny assignments at, above and below the scope for the specified principal. This filter is different from the principalId filter as it returns not only those deny assignments that contain the specified principal is the Principals list but also those deny assignments that contain the specified principal is the ExcludePrincipals list. Additionally, when gdprExportPrincipalId filter is used, only the deny assignment name and description properties are returned.
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Gets deny assignments for a resource.
   */
  listForResource is DenyAssignmentForResourceOps.List<
    DenyAssignment,
    Parameters = {
      /**
       * The filter to apply on the operation. Use $filter=atScope() to return all deny assignments at or above the scope. Use $filter=denyAssignmentName eq '{name}' to search deny assignments by name at specified scope. Use $filter=principalId eq '{id}' to return all deny assignments at, above and below the scope for the specified principal. Use $filter=gdprExportPrincipalId eq '{id}' to return all deny assignments at, above and below the scope for the specified principal. This filter is different from the principalId filter as it returns not only those deny assignments that contain the specified principal is the Principals list but also those deny assignments that contain the specified principal is the ExcludePrincipals list. Additionally, when gdprExportPrincipalId filter is used, only the deny assignment name and description properties are returned.
       */
      @query("$filter")
      $filter?: string;
    }
  >;

  /**
   * Gets a deny assignment by ID.
   */
  @tag("DenyAssignments")
  getById is DenyAssignmentIdByIdOps.Read<DenyAssignment>;
}

@@doc(DenyAssignment.name, "The ID of the deny assignment to get.");
@@doc(DenyAssignment.properties, "Deny assignment properties.");
