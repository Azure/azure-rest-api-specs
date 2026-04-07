// FIXME: Operations in this file are not detected as a resource operation, please confirm the conversion result manually

import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "./VirtualResource.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using TypeSpec.OpenAPI;

namespace Microsoft.SecurityInsights;

/** Entity resource model */
@armVirtualResource
model EntityResource {
  ...ResourceNameParameter<
    Resource = EntityResource,
    KeyName = "entityIdentifier",
    SegmentName = "entities",
    NamePattern = ""
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface DataConnectorsCheckRequirementsOperationGroup {
  /**
   * Get requirements state for a data connector type.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/dataConnectorsCheckRequirements")
  @post
  @tag("Check Data Connector Requirements")
  post(
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
     * The parameters for requirements check message
     */
    #suppress "@azure-tools/typespec-azure-core/casing-style" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
    @bodyRoot
    DataConnectorsCheckRequirements: DataConnectorsCheckRequirements,
  ): ArmResponse<DataConnectorRequirementsState> | CloudError;
}

/**
 * Get geodata for a single IP address
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/enrichment/{enrichmentType}/listGeodataByIp")
@post
@tag("Enrichment")
op listGeodataByIp(
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
   * Enrichment type
   */
  @path
  enrichmentType: EnrichmentType,

  /**
   * IP address (v4 or v6) to be enriched
   */
  @bodyRoot
  ipAddressBody: EnrichmentIpAddressBody,
): ArmResponse<EnrichmentIpGeodata> | CloudError;

/**
 * Get whois information for a single domain name
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/enrichment/{enrichmentType}/listWhoisByDomain")
@post
@tag("Enrichment")
op listWhoisByDomain(
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
   * Enrichment type
   */
  @path
  enrichmentType: EnrichmentType,

  /**
   * Domain name to be enriched. Only domain name is accepted
   */
  @bodyRoot
  domainBody: EnrichmentDomainBody,
): ArmResponse<EnrichmentDomainWhois> | CloudError;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface SourceControlOperationGroup {
  /**
   * Gets a list of repositories metadata.
   */
  // Due to TypeSpec provider action limitation: https://github.com/Azure/typespec-azure/issues/3224#issuecomment-3257368342
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @autoRoute
  @list
  @post
  @operationId("SourceControl_listRepositories")
  @tag("Repositories")
  listRepositories(
    ...ApiVersionParameter,
    ...SubscriptionIdParameter,
    ...ResourceGroupParameter,

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    operationalInsights: "Microsoft.OperationalInsights",

    /**
     * The name of the workspace.
     */
    @maxLength(90)
    @minLength(1)
    @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
    @segment("workspaces")
    @key
    @path
    workspaceName: string,

    /**
     * the provider namespace
     */
    @path
    @segment("providers")
    @key
    securityInsights: "Microsoft.SecurityInsights",

    /**
     * The source control name.
     */
    @path
    route: "listRepositories",

    @doc("The content of the action request")
    @body
    repositoryAccess: RepositoryAccessProperties,
  ): RepoList | CloudError;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ThreatIntelligenceIndicatorOperationGroup {
  /**
   * Create a new threat intelligence indicator.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  @autoRoute
  @action("createIndicator")
  @tag("ThreatIntelligence")
  createIndicator is Extension.ActionSync<
    OperationalInsights,
    ThreatIntelligenceMain,
    Request = ThreatIntelligenceIndicatorModel,
    Response = ArmResourceUpdatedResponse<ThreatIntelligenceInformation> | ArmResourceCreatedResponse<
      ThreatIntelligenceInformation,
      {}
    >,
    Error = CloudError
  >;
  /**
   * Query threat intelligence indicators as per filtering criteria.
   */
  @autoRoute
  @action("queryIndicators")
  @list
  @tag("ThreatIntelligence")
  queryIndicators is Extension.ActionSync<
    OperationalInsights,
    ThreatIntelligenceMain,
    Request = ThreatIntelligenceFilteringCriteria,
    Response = ThreatIntelligenceInformationList,
    Error = CloudError
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ThreatIntelligenceIndicatorMetricsOperationGroup {
  /**
   * Get threat intelligence indicators metrics (Indicators counts by Type, Threat Type, Source).
   */
  @autoRoute
  @get
  @action("metrics")
  @tag("ThreatIntelligence")
  list is Extension.ActionSync<
    OperationalInsights,
    ThreatIntelligenceMain,
    Request = void,
    Response = ThreatIntelligenceMetricsList,
    Error = CloudError
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface ThreatIntelligenceOperationGroup {
  /**
   * Gets the count of all TI objects for the workspace.
   */
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/threatIntelligence/{tiType}/count")
  @post
  @tag("ThreatIntelligence")
  count(
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
     * TI type
     */
    @path
    tiType: TiType,

    /**
     * The query to run on the TI objects in the workspace.
     */
    @bodyRoot
    query?: CountQuery,
  ): ArmResponse<ThreatIntelligenceCount> | CloudError;

  /**
   * Gets all TI objects for the workspace.
   */
  @list
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/threatIntelligence/{tiType}/query")
  @post
  @tag("ThreatIntelligence")
  query(
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
     * TI type
     */
    @path
    tiType: TiType,

    /**
     * The query to run on the TI objects in the workspace.
     */
    @bodyRoot
    query?: Query,
  ): ArmResponse<ThreatIntelligenceList> | CloudError;
}
