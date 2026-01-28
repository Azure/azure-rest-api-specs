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
 * Information about a partner registration.
 */
model PartnerRegistration
  is Azure.ResourceManager.TrackedResource<PartnerRegistrationProperties> {
  ...ResourceNameParameter<
    Resource = PartnerRegistration,
    KeyName = "partnerRegistrationName",
    SegmentName = "partnerRegistrations",
    NamePattern = ""
  >;
}

@armResourceOperations
interface PartnerRegistrations {
  /**
   * Gets a partner registration with the specified parameters.
   */
  @summary("Get a partner registration.")
  get is ArmResourceRead<PartnerRegistration>;

  /**
   * Creates a new partner registration with the specified parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-put-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Create a partner registration.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    PartnerRegistration,
    Response = ArmResourceUpdatedResponse<PartnerRegistration> | (ArmAcceptedLroResponse & {
      @bodyRoot
      _: PartnerRegistration;
    }),
    LroHeaders = ArmLroLocationHeader<FinalResult = PartnerRegistration> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Updates a partner registration with the specified parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/no-response-body" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Update a partner registration.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    PartnerRegistration,
    PatchModel = PartnerRegistrationUpdateParameters,
    Response = {
      @body body: void;
    } | ArmResourceCreatedResponse<
      PartnerRegistration,
      LroHeaders = ArmLroLocationHeader &
        Azure.Core.Foundations.RetryAfterHeader
    >
  >;

  /**
   * Deletes a partner registration with the specified parameters.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete a partner registration.")
  delete is ArmResourceDeleteWithoutOkAsync<
    PartnerRegistration,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all the partner registrations under a resource group.
   */
  @summary("List partner registrations under a resource group.")
  listByResourceGroup is ArmResourceListByParent<
    PartnerRegistration,
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
    Response = ArmResponse<PartnerRegistrationsListResult>
  >;

  /**
   * List all the partner registrations under an Azure subscription.
   */
  @summary("List partner registrations under an Azure subscription.")
  listBySubscription is ArmListBySubscription<
    PartnerRegistration,
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
    Response = ArmResponse<PartnerRegistrationsListResult>
  >;
}

@@doc(PartnerRegistration.name, "Name of the partner registration.");
@@doc(PartnerRegistration.properties,
  "Properties of the partner registration."
);
@@doc(PartnerRegistrations.createOrUpdate::parameters.resource,
  "PartnerRegistration information."
);
@@doc(PartnerRegistrations.update::parameters.properties,
  "Partner registration update information."
);
