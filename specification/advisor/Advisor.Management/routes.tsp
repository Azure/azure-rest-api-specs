// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;

namespace Microsoft.Advisor;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ConfigurationsOperationGroup {
  /**
   * Retrieve Azure Advisor configurations and also retrieve configurations of contained resource groups.
   */
  #suppress "@azure-tools/typespec-azure-core/response-schema-problem" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Retrieve Azure Advisor configurations.")
  @autoRoute
  @list
  @get
  @action("configurations")
  listBySubscription is ArmProviderActionSync<
    Response = ArmResponse<ConfigurationListResult>,
    Scope = SubscriptionActionScope,
    Parameters = {},
    Error = ArmDefaultErrorResponse
  >;
  /**
   * Create/Overwrite Azure Advisor configuration and also delete all configurations of contained resource groups.
   */
  #suppress "@azure-tools/typespec-azure-core/response-schema-problem" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Create/Overwrite Azure Advisor configuration and also delete all configurations of contained resource groups.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/configurations/{configurationName}")
  @put
  createInSubscription(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /**
     * Advisor configuration name. Value must be 'default'
     */
    @path
    configurationName: ConfigurationName,

    /**
     * The Azure Advisor configuration data structure.
     */
    @bodyRoot
    configContract: ConfigData,
  ): ArmResponse<ConfigData> | ArmDefaultErrorResponse;

  /**
   * Retrieve Azure Advisor configurations.
   */
  #suppress "@azure-tools/typespec-azure-core/response-schema-problem" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Retrieve Azure Advisor configurations and also retrieve configurations of contained resource groups.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Advisor/configurations")
  @list
  @get
  listByResourceGroup(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /**
     * The name of the Azure resource group.
     */
    @path
    resourceGroup: string,
  ): ArmResponse<ConfigurationListResult> | ArmDefaultErrorResponse;

  /**
   * Create/Overwrite Azure Advisor configuration.
   */
  #suppress "@azure-tools/typespec-azure-core/response-schema-problem" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Create/Overwrite Azure Advisor configuration.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Advisor/configurations/{configurationName}")
  @put
  createInResourceGroup(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /**
     * Advisor configuration name. Value must be 'default'
     */
    @path
    configurationName: ConfigurationName,

    /**
     * The name of the Azure resource group.
     */
    @path
    resourceGroup: string,

    /**
     * The Azure Advisor configuration data structure.
     */
    @bodyRoot
    configContract: ConfigData,
  ): ArmResponse<ConfigData> | ArmDefaultErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface RecommendationsOperationGroup {
  /**
   * Initiates the recommendation generation or computation process for a subscription. This operation is asynchronous. The generated recommendations are stored in a database so they can be retrieved later.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Initiates the recommendation generation or computation process for a subscription. This operation is asynchronous. The generated recommendations are stored in a database so they can be retrieved later.")
  @autoRoute
  @action("generateRecommendations")
  generate is ArmProviderActionSync<
    Scope = SubscriptionActionScope,
    Parameters = {},
    Response = ArmAcceptedResponse & {
      /**
       * The URL where the status of the asynchronous operation can be checked.
       */
      @header("Location")
      Location: string;
    },
    Error = ArmDefaultErrorResponse
  >;
  /**
   * Retrieves the status of the recommendation computation or generation process. Invoke this API after calling the generation recommendation. The URI of this API is returned in the Location field of the response header.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/lro-location-header" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @summary("Retrieves the status of the recommendation computation or generation process. Invoke it after calling the generation recommendation. The URI of this API is returned in the Location field of the response header.")
  @route("/subscriptions/{subscriptionId}/providers/Microsoft.Advisor/generateRecommendations/{operationId}")
  @get
  getGenerateStatus(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,

    /**
     * The operation ID, which can be found from the Location field in the generate recommendation response header.
     */
    #suppress "@azure-tools/typespec-azure-core/no-format" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @format("uuid")
    @path
    operationId: string,
  ): ArmAcceptedResponse | NoContentResponse | ArmDefaultErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface SuppressionsOperationGroup {
  /**
   * Retrieves the list of snoozed or dismissed suppressions for a subscription. The snoozed or dismissed attribute of a recommendation is referred to as a suppression.
   */
  #suppress "@azure-tools/typespec-azure-core/response-schema-problem" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @autoRoute
  @list
  @get
  @action("suppressions")
  list is ArmProviderActionSync<
    Response = ResourceListResult<SuppressionContract>,
    Scope = SubscriptionActionScope,
    Parameters = {
      /**
       * The number of suppressions per page if a paged version of this API is being used.
       */
      @query("$top")
      $top?: int32;

      /**
       * The page-continuation token to use with a paged version of this API.
       */
      @query("$skipToken")
      $skipToken?: string;
    },
    Error = ArmDefaultErrorResponse
  >;
}

/**
 * Predicts a recommendation.
 */
#suppress "@azure-tools/typespec-azure-core/response-schema-problem" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@summary("Predicts Microsoft.Advisor services.")
@autoRoute
op predict is ArmProviderActionSync<
  Request = PredictionRequest,
  Response = PredictionResponse,
  Scope = SubscriptionActionScope,
  Parameters = {},
  Error = ArmDefaultErrorResponse
>;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface AssessmentTypesOperationGroup {
  /**
   * Get list of Azure Advisor assessment types.
   */
  @summary("Get assessment types list.")
  @autoRoute
  @list
  @get
  @action("assessmentTypes")
  list is ArmProviderActionSync<
    Response = AssessmentTypeListResult,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface WorkloadsOperationGroup {
  /**
   * Get list of Workloads.
   */
  @summary("Get Workloads list.")
  @autoRoute
  @list
  @get
  @action("workloads")
  list is ArmProviderActionSync<
    Response = WorkloadListResult,
    Scope = SubscriptionActionScope,
    Parameters = {}
  >;
}
