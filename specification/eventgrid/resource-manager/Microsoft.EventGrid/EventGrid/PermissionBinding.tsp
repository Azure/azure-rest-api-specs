import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Namespace.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.EventGrid;
/**
 * The Permission binding resource.
 */
@parentResource(Namespace)
model PermissionBinding
  is Azure.ResourceManager.ProxyResource<PermissionBindingProperties> {
  ...ResourceNameParameter<
    Resource = PermissionBinding,
    KeyName = "permissionBindingName",
    SegmentName = "permissionBindings",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

@armResourceOperations
interface PermissionBindings {
  /**
   * Get properties of a permission binding.
   */
  @summary("Get a permission binding.")
  get is ArmResourceRead<PermissionBinding>;

  /**
   * Create or update a permission binding with the specified parameters.
   */
  @summary("Create or update a permission binding.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<PermissionBinding>;

  /**
   * Delete an existing permission binding.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete a permission binding.")
  delete is ArmResourceDeleteWithoutOkAsync<
    PermissionBinding,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Get all the permission bindings under a namespace.
   */
  @summary("List all permission bindings under a namespace.")
  listByNamespace is ArmResourceListByParent<
    PermissionBinding,
    Parameters = {
      /**
       * The query used to filter the search results using OData syntax. Filtering is permitted on the 'name' property only and with limited number of OData operations. These operations are: the 'contains' function as well as the following logical operations: not, and, or, eq (for equal), and ne (for not equal). No arithmetic operations are supported. The following is a valid filter example: $filter=contains(namE, 'PATTERN') and name ne 'PATTERN-1'. The following is not a valid filter example: $filter=location eq 'westus'.
       */
      @query("$filter")
      $filter?: string;

      /**
       * The number of results to return per page for the list operation. Valid range for top parameter is 1 to 100. If not specified, the default number of results to be returned is 20 items per page.
       */
      @query("$top")
      $top?: int32;
    },
    Response = ArmResponse<PermissionBindingsListResult>
  >;
}

@@maxLength(PermissionBinding.name, 50);
@@minLength(PermissionBinding.name, 3);
@@doc(PermissionBinding.name, "Name of the permission binding.");
@@doc(PermissionBinding.properties, "The properties of permission binding.");
@@doc(PermissionBindings.createOrUpdate::parameters.resource,
  "Permission binding information."
);
