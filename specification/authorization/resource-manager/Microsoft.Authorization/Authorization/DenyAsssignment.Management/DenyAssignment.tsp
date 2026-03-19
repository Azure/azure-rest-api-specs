import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.Authorization;
/**
 * Deny Assignment
 */
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

    @path
    @segment("subscriptions")
    @key
    subscriptionId: string;

    @path
    @segment("resourceGroups")
    @key
    resourceGroupName: string;

    /**
     * The namespace of the resource provider.
     */
    @path
    @segment("providers")
    @key
    @extension("x-ms-skip-url-encoding", true)
    resourceProviderNamespace: string;

    /**
     * The parent resource identity.
     */
    @path
    @segment("")
    @key
    @extension("x-ms-skip-url-encoding", true)
    parentResourcePath: string;

    /**
     * The resource type of the resource.
     */
    @path
    @segment("")
    @key
    @extension("x-ms-skip-url-encoding", true)
    resourceType: string;

    /**
     * The name of the resource to get deny assignments for.
     */
    @path
    @segment("")
    @key
    resourceName: string;

    @path
    @segment("providers")
    @key
    providerNamespace: "microsoft.Authorization";
  },
  {},
  {
    @path
    @segment("denyAssignments")
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
   * Gets deny assignments for a scope.
   */
  listForScope is Extension.ListByTarget<
    Extension.ScopeParameter,
    DenyAssignment,
    {
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
}

@@doc(DenyAssignment.name, "The ID of the deny assignment to get.");
@@doc(DenyAssignment.properties, "Deny assignment properties.");
