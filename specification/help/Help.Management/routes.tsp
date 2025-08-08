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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@autoRoute
interface CheckNameAvailabilityOperationGroup {
  /**
   * This API is used to check the uniqueness of a resource name used for a diagnostic, troubleshooter or solutions
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  checkNameAvailability is ArmProviderActionSync<
    CommonTypes.CheckNameAvailabilityRequest,
    CheckNameAvailabilityResponse,
    ExtensionActionScope,
    OptionalRequestBody = true
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface DiscoverySolutionOperationGroup {
  /**
   * Lists the relevant Azure Diagnostics, Solutions and Troubleshooters using [problemClassification API](https://learn.microsoft.com/rest/api/support/problem-classifications/list?tabs=HTTP)) AND  resourceUri or resourceType.<br/> Discovery Solutions is the initial entry point within Help API, which identifies relevant Azure diagnostics and solutions. <br/><br/> Required Input :  problemClassificationId (Use the [problemClassification API](https://learn.microsoft.com/rest/api/support/problem-classifications/list?tabs=HTTP)) <br/>Optional input: resourceUri OR resource Type <br/><br/> <b>Note: </b>  ‘requiredInputs’ from Discovery solutions response must be passed via ‘additionalParameters’ as an input to Diagnostics and Solutions API.
   */
  @autoRoute
  @get
  @action("discoverySolutions")
  @list
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface DiscoverySolutionNLPOperationGroup {
  /**
   * Search for relevant Azure Diagnostics, Solutions and Troubleshooters using a natural language issue summary.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @autoRoute
  @operationId("DiscoverySolutionNLP_DiscoverSolutions")
  discoverSolutions is ArmProviderActionSync<
    Request = DiscoveryNlpRequest,
    Response = DiscoveryNlpResponse,
    OptionalRequestBody = true
  >;
  /**
   * Search for relevant Azure Diagnostics, Solutions and Troubleshooters using a natural language issue summary and subscription.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @autoRoute
  @action("discoverSolutions")
  @operationId("DiscoverySolutionNLP_DiscoverSolutionsBySubscription")
  discoverSolutionsBySubscription is ArmProviderActionSync<
    Request = DiscoveryNlpRequest,
    Response = DiscoveryNlpResponse,
    Scope = SubscriptionActionScope,
    Parameters = {},
    OptionalRequestBody = true
  >;
}

@@doc(CheckNameAvailabilityOperationGroup.checkNameAvailability::parameters.body,
  "The required parameters for availability check."
);
