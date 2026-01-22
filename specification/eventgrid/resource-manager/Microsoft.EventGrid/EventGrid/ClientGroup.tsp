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
 * The Client group resource.
 */
@parentResource(Namespace)
model ClientGroup
  is Azure.ResourceManager.ProxyResource<ClientGroupProperties> {
  ...ResourceNameParameter<
    Resource = ClientGroup,
    KeyName = "clientGroupName",
    SegmentName = "clientGroups",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

@armResourceOperations
interface ClientGroups {
  /**
   * Get properties of a client group.
   */
  @summary("Get a client group.")
  get is ArmResourceRead<ClientGroup>;

  /**
   * Create or update a client group with the specified parameters.
   */
  @summary("Create or update a client group.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<ClientGroup>;

  /**
   * Delete an existing client group.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete a client group.")
  delete is ArmResourceDeleteWithoutOkAsync<
    ClientGroup,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Get all the client groups under a namespace.
   */
  @summary("List all client groups under a namespace.")
  listByNamespace is ArmResourceListByParent<
    ClientGroup,
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
    Response = ArmResponse<ClientGroupsListResult>
  >;
}

@@maxLength(ClientGroup.name, 50);
@@minLength(ClientGroup.name, 3);
@@doc(ClientGroup.name, "Name of the client group.");
@@doc(ClientGroup.properties, "The properties of client group.");
@@doc(ClientGroups.createOrUpdate::parameters.resource,
  "Client group information."
);
