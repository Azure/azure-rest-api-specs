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
 * Partner configuration information
 */
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@singleton("default")
model PartnerConfiguration
  is Azure.ResourceManager.Legacy.TrackedResourceWithOptionalLocation<PartnerConfigurationProperties> {
  ...ResourceNameParameter<
    Resource = PartnerConfiguration,
    KeyName = "partnerConfiguration",
    SegmentName = "partnerConfigurations",
    NamePattern = ""
  >;
}

@armResourceOperations
interface PartnerConfigurations {
  /**
   * Get properties of a partner configuration.
   */
  @summary("Get a partner configuration.")
  get is ArmResourceRead<PartnerConfiguration>;

  /**
   * Synchronously creates or updates a partner configuration with the specified parameters.
   */
  @summary("Create or update a partner configuration.")
  createOrUpdate is ArmResourceCreateOrReplaceAsync<
    PartnerConfiguration,
    LroHeaders = ArmLroLocationHeader<FinalResult = PartnerConfiguration> &
      Azure.Core.Foundations.RetryAfterHeader
  >;

  /**
   * Synchronously updates a partner configuration with the specified parameters.
   */
  @summary("Update a partner configuration.")
  @patch(#{ implicitOptionality: false })
  update is ArmCustomPatchAsync<
    PartnerConfiguration,
    PatchModel = PartnerConfigurationUpdateParameters,
    Response = PartnerConfiguration | ArmResourceCreatedResponse<PartnerConfiguration>
  >;

  /**
   * Delete existing partner configuration.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-delete-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Delete a partner configuration.")
  delete is ArmResourceDeleteWithoutOkAsync<
    PartnerConfiguration,
    Response = ArmDeletedResponse | ArmDeleteAcceptedLroResponse | ArmDeletedNoContentResponse
  >;

  /**
   * List all the partner configurations under a resource group.
   */
  @summary("List partner configurations under a resource group.")
  listByResourceGroup is ArmResourceListByParent<
    PartnerConfiguration,
    Response = ArmResponse<PartnerConfigurationsListResult>
  >;

  /**
   * List all the partner configurations under an Azure subscription.
   */
  @summary("List partner configurations under an Azure subscription.")
  listBySubscription is ArmListBySubscription<
    PartnerConfiguration,
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
    Response = ArmResponse<PartnerConfigurationsListResult>
  >;

  /**
   * Authorize a single partner either by partner registration immutable Id or by partner name.
   */
  @summary("Authorize a partner.")
  authorizePartner is ArmResourceActionSync<
    PartnerConfiguration,
    Partner,
    PartnerConfiguration
  >;

  /**
   * Unauthorize a single partner either by partner registration immutable Id or by partner name.
   */
  @summary("Unauthorize a partner.")
  unauthorizePartner is ArmResourceActionSync<
    PartnerConfiguration,
    Partner,
    PartnerConfiguration
  >;
}

@@doc(PartnerConfiguration.name, "");
@@doc(PartnerConfiguration.properties,
  "Properties of the partner configuration."
);
@@doc(PartnerConfigurations.createOrUpdate::parameters.resource,
  "Partner configuration information."
);
@@doc(PartnerConfigurations.update::parameters.properties,
  "Partner configuration update information."
);
@@doc(PartnerConfigurations.authorizePartner::parameters.body,
  "The information of the partner to be authorized."
);
@@doc(PartnerConfigurations.unauthorizePartner::parameters.body,
  "The information of the partner to be unauthorized."
);
