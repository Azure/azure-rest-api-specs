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
 * The Topic space resource.
 */
@parentResource(Namespace)
model TopicSpace is Azure.ResourceManager.ProxyResource<TopicSpaceProperties> {
  ...ResourceNameParameter<
    Resource = TopicSpace,
    KeyName = "topicSpaceName",
    SegmentName = "topicSpaces",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

@armResourceOperations
interface TopicSpaces {
  /**
   * Get properties of a topic space.
   */
  @summary("Get a topic space.")
  get is ArmResourceRead<TopicSpace>;

  /**
   * Create or update a topic space with the specified parameters.
   */
  @summary("Create or update a topic space.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<TopicSpace>;

  /**
   * Delete an existing topic space.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete a topic space.")
  delete is ArmResourceDeleteWithoutOkAsync<
    TopicSpace,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * Get all the topic spaces under a namespace.
   */
  @summary("List all topic spaces under a namespace.")
  listByNamespace is ArmResourceListByParent<
    TopicSpace,
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
    Response = ArmResponse<TopicSpacesListResult>
  >;
}

@@maxLength(TopicSpace.name, 50);
@@minLength(TopicSpace.name, 3);
@@doc(TopicSpace.name, "Name of the Topic space.");
@@doc(TopicSpace.properties, "The properties of topic space.");
@@doc(TopicSpaces.createOrUpdate::parameters.resource,
  "Topic space information."
);
