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
 * Verified partner information
 */
@tenantResource
model VerifiedPartner
  is Azure.ResourceManager.ProxyResource<VerifiedPartnerProperties> {
  ...ResourceNameParameter<
    Resource = VerifiedPartner,
    KeyName = "verifiedPartnerName",
    SegmentName = "verifiedPartners",
    NamePattern = ""
  >;
}

@armResourceOperations
interface VerifiedPartners {
  /**
   * Get properties of a verified partner.
   */
  @summary("Get a verified partner.")
  get is ArmResourceRead<
    VerifiedPartner,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters
  >;

  /**
   * Get a list of all verified partners.
   */
  @summary("List all verified partners.")
  list is ArmResourceListByParent<
    VerifiedPartner,
    BaseParameters = Azure.ResourceManager.Foundations.TenantBaseParameters,
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
    Response = ArmResponse<VerifiedPartnersListResult>
  >;
}

@@doc(VerifiedPartner.name, "Name of the verified partner.");
@@doc(VerifiedPartner.properties, "Properties of the verified partner.");
