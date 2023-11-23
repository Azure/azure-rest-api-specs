import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace Microsoft.SecurityInsights;

interface IPGeodataOperations {
  @doc("Get geodata for a single IP address")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityInsights/enrichment/ip/geodata/")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("IP address (v4 or v6) to be enriched")
      @query("ipAddress")
      ipAddress: string;
    },
    EnrichmentIpGeodata
  >;
}

interface DomainWhoisOperations {
  @doc("Get whois information for a single domain name")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityInsights/enrichment/domain/whois/")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("Domain name to be enriched")
      @query("domain")
      domain: string;
    },
    EnrichmentDomainWhois
  >;
}

interface EntitiesRelationsOperations {
  @doc("Gets all relations of an entity.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/entities/{entityId}/relations")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
      @path
      workspaceName: string;

      @doc("entity ID")
      @path
      entityId: string;

      @doc("Filters the results, based on a Boolean condition. Optional.")
      @query("$filter")
      $filter?: string;

      @doc("Sorts the results. Optional.")
      @query("$orderby")
      $orderby?: string;

      @doc("Returns only the first n results. Optional.")
      @query("$top")
      $top?: int32;

      @doc("Skiptoken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls. Optional.")
      @query("$skipToken")
      $skipToken?: string;
    },
    RelationList
  >;
}

interface EntityRelationsOperations {
  @doc("Gets an entity relation.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/entities/{entityId}/relations/{relationName}")
  @get
  GetRelation is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
      @path
      workspaceName: string;

      @doc("entity ID")
      @path
      entityId: string;

      @doc("Relation Name")
      @path
      relationName: string;
    },
    Relation
  >;
}

interface IncidentRelationsOperations {
  @doc("Gets all incident relations.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/incidents/{incidentId}/relations")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
      @path
      workspaceName: string;

      @doc("Incident ID")
      @path
      incidentId: string;

      @doc("Filters the results, based on a Boolean condition. Optional.")
      @query("$filter")
      $filter?: string;

      @doc("Sorts the results. Optional.")
      @query("$orderby")
      $orderby?: string;

      @doc("Returns only the first n results. Optional.")
      @query("$top")
      $top?: int32;

      @doc("Skiptoken is only used if a previous operation returned a partial result. If a previous response contains a nextLink element, the value of the nextLink element will include a skiptoken parameter that specifies a starting point to use for subsequent calls. Optional.")
      @query("$skipToken")
      $skipToken?: string;
    },
    RelationList
  >;

  @doc("Gets an incident relation.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/incidents/{incidentId}/relations/{relationName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
      @path
      workspaceName: string;

      @doc("Incident ID")
      @path
      incidentId: string;

      @doc("Relation Name")
      @path
      relationName: string;
    },
    Relation
  >;

  @doc("Creates or updates the incident relation.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/incidents/{incidentId}/relations/{relationName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
      @path
      workspaceName: string;

      @doc("Incident ID")
      @path
      incidentId: string;

      @doc("Relation Name")
      @path
      relationName: string;

      @doc("The relation model")
      @body
      relation: Relation;
    },
    Relation
  >;

  @doc("Delete the incident relation.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/incidents/{incidentId}/relations/{relationName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
      @path
      workspaceName: string;

      @doc("Incident ID")
      @path
      incidentId: string;

      @doc("Relation Name")
      @path
      relationName: string;
    },
    void
  >;
}

interface GetRecommendationsOperations {
  @doc("Gets a list of all recommendations.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/recommendations")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
      @path
      workspaceName: string;
    },
    RecommendationList
  >;
}

interface GetOperations {
  @doc("Gets a recommendation by its id.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/recommendations/{recommendationId}")
  @get
  SingleRecommendation is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
      @path
      workspaceName: string;

      @doc("Recommendation Id.")
      @path
      recommendationId: string;
    },
    Recommendation
  >;
}

interface UpdateOperations {
  @doc("Patch a recommendation.")
  // FIXME: (name-collision-error) There is a potential collision with Operation, Parameter and Response names.
  // Problematic names: [Recommendation]
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/recommendations/{recommendationId}")
  @patch
  Recommendation is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
      @path
      workspaceName: string;

      @doc("Recommendation Id.")
      @path
      recommendationId: string;

      @doc("Recommendation Fields to Update.")
      @body
      recommendationPatch: RecommendationPatch[];
    },
    Recommendation
  >;
}

interface SourceControlOperations {
  @doc("Gets a list of repositories metadata.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/listRepositories")
  @post
  listRepositories is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
      @path
      workspaceName: string;

      @doc("The repo type.")
      @body
      repoType: RepoType;
    },
    RepoList
  >;
}

interface ThreatIntelligenceIndicatorMetricsOperations {
  @doc("Get threat intelligence indicators metrics (Indicators counts by Type, Threat Type, Source).")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/threatIntelligence/main/metrics")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
      @path
      workspaceName: string;
    },
    ThreatIntelligenceMetricsList
  >;
}

interface DataConnectorsCheckRequirementsOperations {
  @doc("Get requirements state for a data connector type.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/dataConnectorsCheckRequirements")
  @post
  Post is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @minLength(1)
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @maxLength(90)
      @minLength(1)
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @maxLength(90)
      @minLength(1)
      @pattern("^[A-Za-z0-9][A-Za-z0-9-]+[A-Za-z0-9]$")
      @path
      workspaceName: string;

      @doc("The parameters for requirements check message")
      @body
      DataConnectorsCheckRequirements: DataConnectorsCheckRequirements;
    },
    DataConnectorRequirementsState
  >;
}
