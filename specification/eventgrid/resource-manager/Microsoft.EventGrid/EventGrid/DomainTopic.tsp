import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";
import "./Domain.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.EventGrid;
/**
 * Domain Topic.
 */
@parentResource(Domain)
model DomainTopic
  is Azure.ResourceManager.ProxyResource<DomainTopicProperties> {
  ...ResourceNameParameter<
    Resource = DomainTopic,
    KeyName = "domainTopicName",
    SegmentName = "topics",
    NamePattern = ""
  >;
}

@armResourceOperations
interface DomainTopics {
  /**
   * Get properties of a domain topic.
   */
  @summary("Get a domain topic.")
  get is ArmResourceRead<DomainTopic>;

  /**
   * Asynchronously creates or updates a new domain topic with the specified parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Create or update a domain topic.")
  createOrUpdate is Azure.ResourceManager.Legacy.CreateOrUpdateAsync<
    DomainTopic,
    Request = void,
    Response = ArmResourceCreatedResponse<
      DomainTopic,
      ArmLroLocationHeader & Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * Delete existing domain topic.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete a domain topic.")
  delete is ArmResourceDeleteWithoutOkAsync<
    DomainTopic,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all the topics in a domain.
   */
  @summary("List domain topics.")
  listByDomain is ArmResourceListByParent<
    DomainTopic,
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
    Response = ArmResponse<DomainTopicsListResult>
  >;
}

@@doc(DomainTopic.name, "Name of the topic.");
@@doc(DomainTopic.properties, "Properties of the Domain Topic.");
