import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Help;

interface CheckNameAvailabilityOperations {
  /**
   * This API is used to check the uniqueness of a resource name used for a diagnostic, troubleshooter or solutions
   */
  @route("/{scope}/providers/Microsoft.Help/checkNameAvailability")
  @post
  post is Azure.Core.Foundations.Operation<
    {
      /**
       * This is an extension resource provider and only resource level extension is supported at the moment.
       */
      @path
      scope: string;

      /**
       * The required parameters for availability check.
       */
      @body
      CheckNameAvailabilityRequest?: CheckNameAvailabilityRequest;
    },
    CheckNameAvailabilityResponse
  >;
}

interface DiscoverySolutionOperations {
  /**
   * Lists the relevant Azure diagnostics and solutions using [problemClassification API](https://learn.microsoft.com/rest/api/support/problem-classifications/list?tabs=HTTP)) AND  resourceUri or resourceType.<br/> Discovery Solutions is the initial entry point within Help API, which identifies relevant Azure diagnostics and solutions. We will do our best to return the most effective solutions based on the type of inputs, in the request URL  <br/><br/> Mandatory input :  problemClassificationId (Use the [problemClassification API](https://learn.microsoft.com/rest/api/support/problem-classifications/list?tabs=HTTP)) <br/>Optional input: resourceUri OR resource Type <br/><br/> <b>Note: </b>  ‘requiredInputs’ from Discovery solutions response must be passed via ‘additionalParameters’ as an input to Diagnostics and Solutions API.
   */
  @route("/{scope}/providers/Microsoft.Help/discoverySolutions")
  @get
  list is Azure.Core.Foundations.Operation<
    {
      /**
       * This is an extension resource provider and only resource level extension is supported at the moment.
       */
      @path
      scope: string;

      /**
       * 'ProblemClassificationId' or 'Id' is a mandatory filter to get solutions ids. It also supports optional 'ResourceType' and 'SolutionType' filters. The filter supports only 'and', 'or' and 'eq' operators. Example: $filter=ProblemClassificationId eq '1ddda5b4-cf6c-4d4f-91ad-bc38ab0e811e'
       */
      @query("$filter")
      $filter?: string;

      /**
       * Skiptoken is only used if a previous operation returned a partial result.
       */
      @query("$skiptoken")
      $skiptoken?: string;
    },
    DiscoveryResponse
  >;
}
