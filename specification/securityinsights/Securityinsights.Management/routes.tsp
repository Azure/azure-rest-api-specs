// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.SecurityInsights;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface EntitiesOperationGroup {
  /**
   * Triggers playbook on a specific entity.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("Entities_RunPlaybook")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/entities/{entityIdentifier}/runPlaybook")
  @post
  runPlaybook(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the workspace.
     */
    @maxLength(90)
    @minLength(1)
    @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
    @path
    workspaceName: string,

    /**
     * Entity ID
     */
    @path
    entityIdentifier: string,

    /**
     * Describes the request body for triggering a playbook on an entity.
     */
    @bodyRoot
    requestBody?: EntityManualTriggerRequestBody,
  ): ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface SourceControlOperationGroup {
  /**
   * Gets a list of repositories metadata.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("SourceControl_listRepositories")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/listRepositories")
  @post
  listRepositories(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the workspace.
     */
    @maxLength(90)
    @minLength(1)
    @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
    @path
    workspaceName: string,

    /**
     * The repository access credentials.
     */
    @bodyRoot
    repositoryAccess: RepositoryAccessProperties,
  ): ArmResponse<RepoList> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ThreatIntelligenceIndicatorOperationGroup {
  /**
   * Create a new threat intelligence indicator.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ThreatIntelligenceIndicator_CreateIndicator")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/threatIntelligence/main/createIndicator")
  @post
  createIndicator(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the workspace.
     */
    @maxLength(90)
    @minLength(1)
    @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
    @path
    workspaceName: string,

    /**
     * Properties of threat intelligence indicators to create and update.
     */
    @bodyRoot
    ThreatIntelligenceProperties: ThreatIntelligenceIndicatorModel,
  ): ArmResponse<ThreatIntelligenceInformation> | ErrorResponse;

  /**
   * Query threat intelligence indicators as per filtering criteria.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ThreatIntelligenceIndicator_QueryIndicators")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/threatIntelligence/main/queryIndicators")
  @post
  queryIndicators(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the workspace.
     */
    @maxLength(90)
    @minLength(1)
    @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
    @path
    workspaceName: string,

    /**
     * Filtering criteria for querying threat intelligence indicators.
     */
    @bodyRoot
    ThreatIntelligenceFilteringCriteria: ThreatIntelligenceFilteringCriteria,
  ): ArmResponse<ThreatIntelligenceInformationList> | ErrorResponse;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ThreatIntelligenceIndicatorMetricsOperationGroup {
  /**
   * Get threat intelligence indicators metrics (Indicators counts by Type, Threat Type, Source).
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ThreatIntelligenceIndicatorMetrics_List")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/threatIntelligence/main/metrics")
  @get
  list(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /**
     * The name of the workspace.
     */
    @maxLength(90)
    @minLength(1)
    @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
    @path
    workspaceName: string,
  ): ArmResponse<ThreatIntelligenceMetricsList> | ErrorResponse;
}
