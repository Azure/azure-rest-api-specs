import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.EventGrid;
/**
 * Event Grid Partner Topic.
 */
model PartnerTopic
  is Azure.ResourceManager.TrackedResource<PartnerTopicProperties> {
  ...ResourceNameParameter<
    Resource = PartnerTopic,
    KeyName = "partnerTopicName",
    SegmentName = "partnerTopics",
    NamePattern = ""
  >;

  /**
   * Identity information for the Partner Topic resource.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-invalid-envelope-property" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  identity?: IdentityInfo;
}

@armResourceOperations
interface PartnerTopics {
  /**
   * Get properties of a partner topic.
   */
  @summary("Get a partner topic.")
  get is ArmResourceRead<PartnerTopic>;

  /**
   * Asynchronously creates a new partner topic with the specified parameters.
   */
  @summary("Create a partner topic.")
  @summary("Create a partner topic.")
  createOrUpdate is ArmResourceCreateOrReplaceSync<PartnerTopic>;

  /**
   * Asynchronously updates a partner topic with the specified parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Update a partner topic.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchSync<
    PartnerTopic,
    PatchModel = PartnerTopicUpdateParameters,
    Response = OkResponse | ArmResourceCreatedSyncResponse<PartnerTopic>
  >;

  /**
   * Delete existing partner topic.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete a partner topic.")
  delete is ArmResourceDeleteWithoutOkAsync<
    PartnerTopic,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all the partner topics under a resource group.
   */
  @summary("List partner topics under a resource group.")
  listByResourceGroup is ArmResourceListByParent<
    PartnerTopic,
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
    Response = ArmResponse<PartnerTopicsListResult>
  >;

  /**
   * List all the partner topics under an Azure subscription.
   */
  @summary("List partner topics under an Azure subscription.")
  listBySubscription is ArmListBySubscription<
    PartnerTopic,
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
    Response = ArmResponse<PartnerTopicsListResult>
  >;

  /**
   * Activate a newly created partner topic.
   */
  @summary("Activate a partner topic.")
  activate is ArmResourceActionSync<
    PartnerTopic,
    void,
    ArmResponse<PartnerTopic>
  >;

  /**
   * Deactivate specific partner topic.
   */
  @summary("Deactivate a partner topic.")
  deactivate is ArmResourceActionSync<
    PartnerTopic,
    void,
    ArmResponse<PartnerTopic>
  >;
}

@@doc(PartnerTopic.name, "Name of the partner topic.");
@@doc(PartnerTopic.properties, "Properties of the Partner Topic.");
@@doc(PartnerTopics.createOrUpdate::parameters.resource,
  "Partner Topic information."
);
@@doc(PartnerTopics.update::parameters.properties,
  "PartnerTopic update information."
);
