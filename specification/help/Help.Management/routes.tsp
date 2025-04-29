// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "@typespec/http";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.Help;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface CheckNameAvailabilityOperationGroup {
  /**
   * This API is used to check the uniqueness of a resource name used for a diagnostic, troubleshooter or solutions
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("CheckNameAvailability_CheckAvailability")
  @route("/{scope}/providers/Microsoft.Help/checkNameAvailability")
  @post
  checkAvailability(
    ...ApiVersionParameter,

    /**
     * scope = resourceUri of affected resource.<br/> For example: /subscriptions/0d0fcd2e-c4fd-4349-8497-200edb3923c6/resourcegroups/myresourceGroup/providers/Microsoft.KeyVault/vaults/test-keyvault-non-read
     */
    @path
    scope: string,

    /**
     * The required parameters for availability check.
     */
    @bodyRoot
    CheckNameAvailabilityRequest?: CommonTypes.CheckNameAvailabilityRequest,
  ): ArmResponse<CheckNameAvailabilityResponse> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface DiscoverySolutionOperationGroup {
  /**
   * Lists the relevant Azure Diagnostics, Solutions and Troubleshooters using [problemClassification API](https://learn.microsoft.com/rest/api/support/problem-classifications/list?tabs=HTTP)) AND  resourceUri or resourceType.<br/> Discovery Solutions is the initial entry point within Help API, which identifies relevant Azure diagnostics and solutions. <br/><br/> Required Input :  problemClassificationId (Use the [problemClassification API](https://learn.microsoft.com/rest/api/support/problem-classifications/list?tabs=HTTP)) <br/>Optional input: resourceUri OR resource Type <br/><br/> <b>Note: </b>  ‘requiredInputs’ from Discovery solutions response must be passed via ‘additionalParameters’ as an input to Diagnostics and Solutions API.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DiscoverySolution_List")
  @autoRoute
  @get
  @action("discoverySolutions")
  list is ArmProviderActionSync<
    Response = DiscoveryResponse,
    Parameters = {
      /**
       * 'ProblemClassificationId' is a mandatory filter to get solutions ids. It also supports optional 'ResourceType' and 'SolutionType' filters. The [$filter](https://learn.microsoft.com/en-us/odata/webapi/first-odata-api#filter) supports only 'and', 'or' and 'eq' operators. Example: $filter=ProblemClassificationId eq '1ddda5b4-cf6c-4d4f-91ad-bc38ab0e811e'
       */
      @query("$filter")
      $filter?: string;

      /**
       * Skiptoken is only used if a previous operation returned a partial result.
       */
      @query("$skiptoken")
      $skiptoken?: string;
    }
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface DiscoverySolutionNLPOperationGroup {
  /**
   * Search for relevant Azure Diagnostics, Solutions and Troubleshooters using a natural language issue summary.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DiscoverySolutionNLP_DiscoverSolutions")
  @autoRoute
  discoverSolutions is ArmProviderActionSync<
    Request = DiscoveryNlpRequest,
    Response = DiscoveryNlpResponse
  >;
  /**
   * Search for relevant Azure Diagnostics, Solutions and Troubleshooters using a natural language issue summary and subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DiscoverySolutionNLP_DiscoverSolutionsBySubscription")
  @autoRoute
  @action("discoverSolutions")
  discoverSolutionsBySubscription is ArmProviderActionSync<
    Request = DiscoveryNlpRequest,
    Response = DiscoveryNlpResponse,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}

@@path(CheckNameAvailabilityOperationGroup.checkAvailability::parameters.scope,
  #{ allowReserved: true }
);
