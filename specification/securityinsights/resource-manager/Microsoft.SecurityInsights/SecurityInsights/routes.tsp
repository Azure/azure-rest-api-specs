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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface DataConnectorsCheckRequirementsOperationGroup {
  /**
   * Get requirements state for a data connector type.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("DataConnectorsCheckRequirements_Post")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/dataConnectorsCheckRequirements")
  @post
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
    @bodyRoot
    DataConnectorsCheckRequirements: DataConnectorsCheckRequirements,
  ): ArmResponse<DataConnectorRequirementsState> | CloudError;
}

/**
 * Get geodata for a single IP address
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/enrichment/{enrichmentType}/listGeodataByIp")
@post
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
@route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/enrichment/{enrichmentType}/listWhoisByDomain")
@post
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface SourceControlOperationGroup {
  /**
   * Gets a list of repositories metadata.
   */
  // Due to TypeSpec provider action limitation: https://github.com/Azure/typespec-azure/issues/3224#issuecomment-3257368342
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-operation" "For backward compatibility"
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @autoRoute
  @list
  @post
  @operationId("SourceControl_listRepositories")
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

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ThreatIntelligenceIndicatorOperationGroup {
  /**
   * Create a new threat intelligence indicator.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-post-operation-response-codes" "For backward compatibility"
  @autoRoute
  @action("createIndicator")
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
  queryIndicators is Extension.ActionSync<
    OperationalInsights,
    ThreatIntelligenceMain,
    Request = ThreatIntelligenceFilteringCriteria,
    Response = ThreatIntelligenceInformationList,
    Error = CloudError
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ThreatIntelligenceIndicatorMetricsOperationGroup {
  /**
   * Get threat intelligence indicators metrics (Indicators counts by Type, Threat Type, Source).
   */
  @autoRoute
  @get
  @action("metrics")
  list is Extension.ActionSync<
    OperationalInsights,
    ThreatIntelligenceMain,
    Request = void,
    Response = ThreatIntelligenceMetricsList,
    Error = CloudError
  >;
}

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "For backward compatibility"
interface ThreatIntelligenceOperationGroup {
  /**
   * Gets the count of all TI objects for the workspace.
   */
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ThreatIntelligence_Count")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/threatIntelligence/{tiType}/count")
  @post
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
  #suppress "@azure-tools/typespec-azure-core/no-openapi" "non-standard operations"
  @operationId("ThreatIntelligence_Query")
  @list
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/threatIntelligence/{tiType}/query")
  @post
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
