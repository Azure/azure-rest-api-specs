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
 * Event Grid Partner Destination.
 */
model PartnerDestination
  is Azure.ResourceManager.TrackedResource<PartnerDestinationProperties> {
  ...ResourceNameParameter<
    Resource = PartnerDestination,
    KeyName = "partnerDestinationName",
    SegmentName = "partnerDestinations",
    NamePattern = "^[a-zA-Z0-9-]*$"
  >;
}

@armResourceOperations
interface PartnerDestinations {
  /**
   * Get properties of a partner destination.
   */
  @summary("Get a partner destination.")
  get is ArmResourceRead<PartnerDestination>;

  /**
   * Asynchronously creates a new partner destination with the specified parameters.
   */
  @summary("Create a partner destination.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<PartnerDestination>;

  /**
   * Asynchronously updates a partner destination with the specified parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @Azure.Core.useFinalStateVia("azure-async-operation")
  @summary("Update a partner destination.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    PartnerDestination,
    PatchModel = PartnerDestinationUpdateParameters,
    Response = ArmResponse<PartnerDestination> | ArmResourceCreatedResponse<PartnerDestination> | (ArmAcceptedLroResponse<LroHeaders = ArmCombinedLroHeaders<FinalResult = PartnerDestination> &
      Azure.Core.Foundations.RetryAfterHeader> & {
      @bodyRoot
      _: PartnerDestination;
    })
  >;

  /**
   * Delete existing partner destination.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete a partner destination.")
  delete is ArmResourceDeleteWithoutOkAsync<
    PartnerDestination,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all the partner destinations under a resource group.
   */
  @summary("List partner destinations under a resource group.")
  listByResourceGroup is ArmResourceListByParent<
    PartnerDestination,
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
    Response = ArmResponse<PartnerDestinationsListResult>
  >;

  /**
   * List all the partner destinations under an Azure subscription.
   */
  @summary("List partner destinations under an Azure subscription.")
  listBySubscription is ArmListBySubscription<
    PartnerDestination,
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
    Response = ArmResponse<PartnerDestinationsListResult>
  >;

  /**
   * Activate a newly created partner destination.
   */
  @summary("Activate a partner destination.")
  activate is ArmResourceActionSync<
    PartnerDestination,
    void,
    ArmResponse<PartnerDestination>
  >;
}

@@maxLength(PartnerDestination.name, 50);
@@minLength(PartnerDestination.name, 3);
@@doc(PartnerDestination.name, "Name of the partner destination.");
@@doc(PartnerDestination.properties, "Properties of the Partner Destination.");
@@doc(PartnerDestinations.createOrUpdate::parameters.resource,
  "Partner destination create information."
);
@@doc(PartnerDestinations.update::parameters.properties,
  "Partner destination update information."
);
