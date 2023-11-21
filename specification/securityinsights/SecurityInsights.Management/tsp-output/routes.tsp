import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using TypeSpec.Http;

namespace SecurityInsights;

interface AlertRulesOperations {
  @doc("Gets all alert rules.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/alertRules")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;
    },
    AlertRulesList
  >;

  @doc("Gets the alert rule.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/alertRules/{ruleId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Alert rule ID")
      @path
      ruleId: string;
    },
    AlertRule
  >;

  @doc("Creates or updates the alert rule.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/alertRules/{ruleId}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Alert rule ID")
      @path
      ruleId: string;

      @doc("The alert rule")
      @body
      alertRule: AlertRule;
    },
    AlertRule
  >;

  @doc("Delete the alert rule.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/alertRules/{ruleId}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Alert rule ID")
      @path
      ruleId: string;
    },
    void
  >;
}

interface ActionsOperations {
  @doc("Gets all actions of alert rule.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/alertRules/{ruleId}/actions")
  @get
  ListByAlertRule is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Alert rule ID")
      @path
      ruleId: string;
    },
    ActionsList
  >;

  @doc("Gets the action of alert rule.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/alertRules/{ruleId}/actions/{actionId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Alert rule ID")
      @path
      ruleId: string;

      @doc("Action ID")
      @path
      actionId: string;
    },
    ActionResponse
  >;

  @doc("Creates or updates the action of alert rule.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/alertRules/{ruleId}/actions/{actionId}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Alert rule ID")
      @path
      ruleId: string;

      @doc("Action ID")
      @path
      actionId: string;

      @doc("The action")
      @body
      action: ActionRequest;
    },
    ActionResponse
  >;

  @doc("Delete the action of alert rule.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/alertRules/{ruleId}/actions/{actionId}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Alert rule ID")
      @path
      ruleId: string;

      @doc("Action ID")
      @path
      actionId: string;
    },
    void
  >;
}

interface AlertRuleTemplatesOperations {
  @doc("Gets all alert rule templates.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/alertRuleTemplates")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;
    },
    AlertRuleTemplatesList
  >;

  @doc("Gets the alert rule template.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/alertRuleTemplates/{alertRuleTemplateId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Alert rule template ID")
      @path
      alertRuleTemplateId: string;
    },
    AlertRuleTemplate
  >;
}

interface AutomationRulesOperations {
  @doc("Gets the automation rule.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/automationRules/{automationRuleId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Automation rule ID")
      @path
      automationRuleId: string;
    },
    AutomationRule
  >;

  @doc("Creates or updates the automation rule.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/automationRules/{automationRuleId}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Automation rule ID")
      @path
      automationRuleId: string;

      @doc("The automation rule")
      @body
      automationRuleToUpsert: AutomationRule;
    },
    AutomationRule
  >;

  @doc("Delete the automation rule.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/automationRules/{automationRuleId}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Automation rule ID")
      @path
      automationRuleId: string;
    },
    void
  >;

  @doc("Gets all automation rules.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/automationRules")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;
    },
    AutomationRulesList
  >;
}

interface IncidentsOperations {
  @doc("Triggers playbook on a specific incident")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/incidents/{incidentIdentifier}/runPlaybook")
  @post
  RunPlaybook is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @path incidentIdentifier: string;
      @body requestBody: ManualTriggerRequestBody;
    },
    void
  >;

  @doc("Gets all incidents.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/incidents")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Filters the results, based on a Boolean condition. Optional.")
      @query
      $filter: string;

      @doc("Sorts the results. Optional.")
      @query
      $orderby: string;

      @doc("Returns only the first n results. Optional.")
      @query
      $top: int32;

      @doc("""
Skiptoken is only used if a previous operation returned a partial result. If a
previous response contains a nextLink element, the value of the nextLink
element will include a skiptoken parameter that specifies a starting point to
use for subsequent calls. Optional.
""")
      @query
      $skipToken: string;
    },
    IncidentList
  >;

  @doc("Gets an incident.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/incidents/{incidentId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Incident ID")
      @path
      incidentId: string;
    },
    Incident
  >;

  @doc("Creates or updates the incident.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/incidents/{incidentId}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Incident ID")
      @path
      incidentId: string;

      @doc("The incident")
      @body
      incident: Incident;
    },
    Incident
  >;

  @doc("Delete the incident.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/incidents/{incidentId}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Incident ID")
      @path
      incidentId: string;
    },
    void
  >;

  @doc("""
Creates a Microsoft team to investigate the incident by sharing information and
insights between participants.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/incidents/{incidentId}/createTeam")
  @post
  CreateTeam is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Incident ID")
      @path
      incidentId: string;

      @doc("Team properties")
      @body
      teamProperties: TeamInformation;
    },
    TeamInformation
  >;

  @doc("Gets all incident alerts.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/incidents/{incidentId}/alerts")
  @post
  ListAlerts is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Incident ID")
      @path
      incidentId: string;
    },
    IncidentAlertList
  >;

  @doc("Gets all incident bookmarks.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/incidents/{incidentId}/bookmarks")
  @post
  ListBookmarks is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Incident ID")
      @path
      incidentId: string;
    },
    IncidentBookmarkList
  >;

  @doc("Gets all incident related entities.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/incidents/{incidentId}/entities")
  @post
  ListEntities is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Incident ID")
      @path
      incidentId: string;
    },
    IncidentEntitiesResponse
  >;
}

interface BookmarksOperations {
  @doc("Gets all bookmarks.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/bookmarks")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;
    },
    BookmarkList
  >;

  @doc("Gets a bookmark.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/bookmarks/{bookmarkId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Bookmark ID")
      @path
      bookmarkId: string;
    },
    Bookmark
  >;

  @doc("Creates or updates the bookmark.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/bookmarks/{bookmarkId}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Bookmark ID")
      @path
      bookmarkId: string;

      @doc("The bookmark")
      @body
      bookmark: Bookmark;
    },
    Bookmark
  >;

  @doc("Delete the bookmark.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/bookmarks/{bookmarkId}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Bookmark ID")
      @path
      bookmarkId: string;
    },
    void
  >;
}

interface BookmarkRelationsOperations {
  @doc("Gets all bookmark relations.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/bookmarks/{bookmarkId}/relations")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Bookmark ID")
      @path
      bookmarkId: string;

      @doc("Filters the results, based on a Boolean condition. Optional.")
      @query
      $filter: string;

      @doc("Sorts the results. Optional.")
      @query
      $orderby: string;

      @doc("Returns only the first n results. Optional.")
      @query
      $top: int32;

      @doc("""
Skiptoken is only used if a previous operation returned a partial result. If a
previous response contains a nextLink element, the value of the nextLink
element will include a skiptoken parameter that specifies a starting point to
use for subsequent calls. Optional.
""")
      @query
      $skipToken: string;
    },
    RelationList
  >;

  @doc("Gets a bookmark relation.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/bookmarks/{bookmarkId}/relations/{relationName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Bookmark ID")
      @path
      bookmarkId: string;

      @doc("Relation Name")
      @path
      relationName: string;
    },
    Relation
  >;

  @doc("Creates the bookmark relation.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/bookmarks/{bookmarkId}/relations/{relationName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Bookmark ID")
      @path
      bookmarkId: string;

      @doc("Relation Name")
      @path
      relationName: string;

      @doc("The relation model")
      @body
      relation: Relation;
    },
    Relation
  >;

  @doc("Delete the bookmark relation.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/bookmarks/{bookmarkId}/relations/{relationName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Bookmark ID")
      @path
      bookmarkId: string;

      @doc("Relation Name")
      @path
      relationName: string;
    },
    void
  >;
}

interface BookmarkOperations {
  @doc("Expand an bookmark")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/bookmarks/{bookmarkId}/expand")
  @post
  Expand is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Bookmark ID")
      @path
      bookmarkId: string;

      @doc("The parameters required to execute an expand operation on the given bookmark.")
      @body
      parameters: BookmarkExpandParameters;
    },
    BookmarkExpandResponse
  >;
}

interface IPGeodataOperations {
  @doc("Get geodata for a single IP address")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.SecurityInsights/enrichment/ip/geodata/")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("IP address (v4 or v6) to be enriched")
      @query
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
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("Domain name to be enriched")
      @query
      domain: string;
    },
    EnrichmentDomainWhois
  >;
}

interface EntitiesOperations {
  @doc("Gets all entities.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/entities")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;
    },
    EntityList
  >;

  @doc("Gets an entity.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/entities/{entityId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("entity ID")
      @path
      entityId: string;
    },
    Entity
  >;

  @doc("Expands an entity.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/entities/{entityId}/expand")
  @post
  Expand is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("entity ID")
      @path
      entityId: string;

      @doc("The parameters required to execute an expand operation on the given entity.")
      @body
      parameters: EntityExpandParameters;
    },
    EntityExpandResponse
  >;

  @doc("Get Insights and Activities for an entity.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/entities/{entityId}/queries")
  @get
  Queries is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("entity ID")
      @path
      entityId: string;

      @doc("The Kind parameter for queries")
      @query
      kind: EntityItemQueryKind;
    },
    GetQueriesResponse
  >;

  @doc("Execute Insights for an entity.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/entities/{entityId}/getInsights")
  @post
  GetInsights is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("entity ID")
      @path
      entityId: string;

      @doc("The parameters required to execute insights on the given entity.")
      @body
      parameters: EntityGetInsightsParameters;
    },
    EntityGetInsightsResponse
  >;
}

interface EntitiesGetTimelineOperations {
  @doc("Timeline for an entity.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/entities/{entityId}/getTimeline")
  @post
  list is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("entity ID")
      @path
      entityId: string;

      @doc("The parameters required to execute an timeline operation on the given entity.")
      @body
      parameters: EntityTimelineParameters;
    },
    EntityTimelineResponse
  >;
}

interface EntitiesRelationsOperations {
  @doc("Gets all relations of an entity.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/entities/{entityId}/relations")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("entity ID")
      @path
      entityId: string;

      @doc("Filters the results, based on a Boolean condition. Optional.")
      @query
      $filter: string;

      @doc("Sorts the results. Optional.")
      @query
      $orderby: string;

      @doc("Returns only the first n results. Optional.")
      @query
      $top: int32;

      @doc("""
Skiptoken is only used if a previous operation returned a partial result. If a
previous response contains a nextLink element, the value of the nextLink
element will include a skiptoken parameter that specifies a starting point to
use for subsequent calls. Optional.
""")
      @query
      $skipToken: string;
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
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
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

interface EntityQueriesOperations {
  @doc("Gets all entity queries.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/entityQueries")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The entity query kind we want to fetch")
      @query
      kind: ComponentsL8W718ParametersEntityquerykindSchema;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;
    },
    EntityQueryList
  >;

  @doc("Gets an entity query.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/entityQueries/{entityQueryId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("entity query ID")
      @path
      entityQueryId: string;
    },
    EntityQuery
  >;

  @doc("Creates or updates the entity query.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/entityQueries/{entityQueryId}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("entity query ID")
      @path
      entityQueryId: string;

      @doc("The entity query we want to create or update")
      @body
      entityQuery: CustomEntityQuery;
    },
    EntityQuery
  >;

  @doc("Delete the entity query.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/entityQueries/{entityQueryId}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("entity query ID")
      @path
      entityQueryId: string;
    },
    void
  >;
}

interface EntityQueryTemplatesOperations {
  @doc("Gets all entity query templates.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/entityQueryTemplates")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The entity template query kind we want to fetch")
      @query
      kind: Components9D9QekParametersEntityquerytemplatekindSchema;

      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;
    },
    EntityQueryTemplateList
  >;

  @doc("Gets an entity query.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/entityQueryTemplates/{entityQueryTemplateId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("entity query template ID")
      @path
      entityQueryTemplateId: string;
    },
    EntityQueryTemplate
  >;
}

interface FileImportsOperations {
  @doc("Gets all file imports.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/fileImports")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Filters the results, based on a Boolean condition. Optional.")
      @query
      $filter: string;

      @doc("Sorts the results. Optional.")
      @query
      $orderby: string;

      @doc("Returns only the first n results. Optional.")
      @query
      $top: int32;

      @doc("""
Skiptoken is only used if a previous operation returned a partial result. If a
previous response contains a nextLink element, the value of the nextLink
element will include a skiptoken parameter that specifies a starting point to
use for subsequent calls. Optional.
""")
      @query
      $skipToken: string;
    },
    FileImportList
  >;

  @doc("Gets a file import.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/fileImports/{fileImportId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("File import ID")
      @path
      fileImportId: string;
    },
    FileImport
  >;

  @doc("Creates the file import.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/fileImports/{fileImportId}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("File import ID")
      @path
      fileImportId: string;

      @doc("The file import")
      @body
      fileImport: FileImport;
    },
    FileImport
  >;

  @doc("Delete the file import.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/fileImports/{fileImportId}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("File import ID")
      @path
      fileImportId: string;
    },
    FileImport | void
  >;
}

interface IncidentCommentsOperations {
  @doc("Gets all incident comments.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/incidents/{incidentId}/comments")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Incident ID")
      @path
      incidentId: string;

      @doc("Filters the results, based on a Boolean condition. Optional.")
      @query
      $filter: string;

      @doc("Sorts the results. Optional.")
      @query
      $orderby: string;

      @doc("Returns only the first n results. Optional.")
      @query
      $top: int32;

      @doc("""
Skiptoken is only used if a previous operation returned a partial result. If a
previous response contains a nextLink element, the value of the nextLink
element will include a skiptoken parameter that specifies a starting point to
use for subsequent calls. Optional.
""")
      @query
      $skipToken: string;
    },
    IncidentCommentList
  >;

  @doc("Gets an incident comment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/incidents/{incidentId}/comments/{incidentCommentId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Incident ID")
      @path
      incidentId: string;

      @doc("Incident comment ID")
      @path
      incidentCommentId: string;
    },
    IncidentComment
  >;

  @doc("Creates or updates the incident comment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/incidents/{incidentId}/comments/{incidentCommentId}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Incident ID")
      @path
      incidentId: string;

      @doc("Incident comment ID")
      @path
      incidentCommentId: string;

      @doc("The incident comment")
      @body
      incidentComment: IncidentComment;
    },
    IncidentComment
  >;

  @doc("Delete the incident comment.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/incidents/{incidentId}/comments/{incidentCommentId}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Incident ID")
      @path
      incidentId: string;

      @doc("Incident comment ID")
      @path
      incidentCommentId: string;
    },
    void
  >;
}

interface IncidentRelationsOperations {
  @doc("Gets all incident relations.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/incidents/{incidentId}/relations")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Incident ID")
      @path
      incidentId: string;

      @doc("Filters the results, based on a Boolean condition. Optional.")
      @query
      $filter: string;

      @doc("Sorts the results. Optional.")
      @query
      $orderby: string;

      @doc("Returns only the first n results. Optional.")
      @query
      $top: int32;

      @doc("""
Skiptoken is only used if a previous operation returned a partial result. If a
previous response contains a nextLink element, the value of the nextLink
element will include a skiptoken parameter that specifies a starting point to
use for subsequent calls. Optional.
""")
      @query
      $skipToken: string;
    },
    RelationList
  >;

  @doc("Gets an incident relation.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/incidents/{incidentId}/relations/{relationName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
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
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
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
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
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

interface IncidentTasksOperations {
  @doc("Gets all incident tasks.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/incidents/{incidentId}/tasks")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Incident ID")
      @path
      incidentId: string;
    },
    IncidentTaskList
  >;

  @doc("Gets an incident task.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/incidents/{incidentId}/tasks/{incidentTaskId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Incident ID")
      @path
      incidentId: string;

      @doc("Incident task ID")
      @path
      incidentTaskId: string;
    },
    IncidentTask
  >;

  @doc("Creates or updates the incident task.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/incidents/{incidentId}/tasks/{incidentTaskId}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Incident ID")
      @path
      incidentId: string;

      @doc("Incident task ID")
      @path
      incidentTaskId: string;

      @doc("The incident task")
      @body
      incidentTask: IncidentTask;
    },
    IncidentTask
  >;

  @doc("Delete the incident task.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/incidents/{incidentId}/tasks/{incidentTaskId}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Incident ID")
      @path
      incidentId: string;

      @doc("Incident task ID")
      @path
      incidentTaskId: string;
    },
    void
  >;
}

interface MetadataOperations {
  @doc("List of all metadata")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/metadata")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Filters the results, based on a Boolean condition. Optional.")
      @query
      $filter: string;

      @doc("Sorts the results. Optional.")
      @query
      $orderby: string;

      @doc("Returns only the first n results. Optional.")
      @query
      $top: int32;

      @doc("""
Used to skip n elements in the OData query (offset). Returns a nextLink to the
next page of results if there are any left.
""")
      @query
      $skip: int32;
    },
    MetadataList
  >;

  @doc("Get a Metadata.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/metadata/{metadataName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("The Metadata name.")
      @path
      metadataName: string;
    },
    MetadataModel
  >;

  @doc("Delete a Metadata.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/metadata/{metadataName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("The Metadata name.")
      @path
      metadataName: string;
    },
    void
  >;

  @doc("Create a Metadata.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/metadata/{metadataName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("The Metadata name.")
      @path
      metadataName: string;

      @doc("Metadata resource.")
      @body
      metadata: MetadataModel;
    },
    MetadataModel
  >;

  @doc("Update an existing Metadata.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/metadata/{metadataName}")
  @patch
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("The Metadata name.")
      @path
      metadataName: string;

      @doc("Partial metadata request.")
      @body
      metadataPatch: MetadataPatch;
    },
    MetadataModel
  >;
}

interface OfficeConsentsOperations {
  @doc("Gets all office365 consents.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/officeConsents")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;
    },
    OfficeConsentList
  >;

  @doc("Gets an office365 consent.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/officeConsents/{consentId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("consent ID")
      @path
      consentId: string;
    },
    OfficeConsent
  >;

  @doc("Delete the office365 consent.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/officeConsents/{consentId}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("consent ID")
      @path
      consentId: string;
    },
    void
  >;
}

interface SentinelOnboardingStatesOperations {
  @doc("Get Sentinel onboarding state")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/onboardingStates/{sentinelOnboardingStateName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("The Sentinel onboarding state name. Supports - default")
      @path
      sentinelOnboardingStateName: string;
    },
    SentinelOnboardingState
  >;

  @doc("Create Sentinel onboarding state")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/onboardingStates/{sentinelOnboardingStateName}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("The Sentinel onboarding state name. Supports - default")
      @path
      sentinelOnboardingStateName: string;

      @doc("The Sentinel onboarding state parameter")
      @body
      sentinelOnboardingStateParameter: SentinelOnboardingState;
    },
    SentinelOnboardingState
  >;

  @doc("Delete Sentinel onboarding state")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/onboardingStates/{sentinelOnboardingStateName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("The Sentinel onboarding state name. Supports - default")
      @path
      sentinelOnboardingStateName: string;
    },
    void
  >;

  @doc("Gets all Sentinel onboarding states")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/onboardingStates")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;
    },
    SentinelOnboardingStatesList
  >;
}

interface GetRecommendationsOperations {
  @doc("Gets a list of all recommendations.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/recommendations")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
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
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
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
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
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

interface SecurityMLAnalyticsSettingsOperations {
  @doc("Gets all Security ML Analytics Settings.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/securityMLAnalyticsSettings")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;
    },
    SecurityMLAnalyticsSettingsList
  >;

  @doc("Gets the Security ML Analytics Settings.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/securityMLAnalyticsSettings/{settingsResourceName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Security ML Analytics Settings resource name")
      @path
      settingsResourceName: string;
    },
    SecurityMLAnalyticsSetting
  >;

  @doc("Creates or updates the Security ML Analytics Settings.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/securityMLAnalyticsSettings/{settingsResourceName}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Security ML Analytics Settings resource name")
      @path
      settingsResourceName: string;

      @doc("The security ML Analytics setting")
      @body
      securityMLAnalyticsSetting: SecurityMLAnalyticsSetting;
    },
    SecurityMLAnalyticsSetting
  >;

  @doc("Delete the Security ML Analytics Settings.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/securityMLAnalyticsSettings/{settingsResourceName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Security ML Analytics Settings resource name")
      @path
      settingsResourceName: string;
    },
    void
  >;
}

interface ProductSettingsOperations {
  @doc("List of all the settings")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/settings")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;
    },
    SettingList
  >;

  @doc("Gets a setting.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/settings/{settingsName}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("The setting name. Supports - Anomalies, EyesOn, EntityAnalytics, Ueba")
      @path
      settingsName: string;
    },
    Settings
  >;

  @doc("Delete setting of the product.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/settings/{settingsName}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("The setting name. Supports - Anomalies, EyesOn, EntityAnalytics, Ueba")
      @path
      settingsName: string;
    },
    void
  >;

  @doc("Updates setting.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/settings/{settingsName}")
  @put
  Update is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("The setting name. Supports - Anomalies, EyesOn, EntityAnalytics, Ueba")
      @path
      settingsName: string;

      @doc("The setting")
      @body
      settings: Settings;
    },
    Settings
  >;
}

interface SourceControlOperations {
  @doc("Gets a list of repositories metadata.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/listRepositories")
  @post
  listRepositories is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("The repo type.")
      @body
      repoType: RepoType;
    },
    RepoList
  >;
}

interface SourceControlsOperations {
  @doc("Gets all source controls, without source control items.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/sourcecontrols")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;
    },
    SourceControlList
  >;

  @doc("Gets a source control byt its identifier.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/sourcecontrols/{sourceControlId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Source control Id")
      @path
      sourceControlId: string;
    },
    SourceControl
  >;

  @doc("Delete a source control.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/sourcecontrols/{sourceControlId}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Source control Id")
      @path
      sourceControlId: string;
    },
    void
  >;

  @doc("Creates a source control.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/sourcecontrols/{sourceControlId}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Source control Id")
      @path
      sourceControlId: string;

      @doc("The SourceControl")
      @body
      sourceControl: SourceControl;
    },
    SourceControl
  >;
}

interface ThreatIntelligenceIndicatorOperations {
  @doc("Create a new threat intelligence indicator.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/threatIntelligence/main/createIndicator")
  @post
  CreateIndicator is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Properties of threat intelligence indicators to create and update.")
      @body
      ThreatIntelligenceProperties: ThreatIntelligenceIndicatorModel;
    },
    ThreatIntelligenceInformation
  >;

  @doc("View a threat intelligence indicator by name.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/threatIntelligence/main/indicators/{name}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Threat intelligence indicator name field.")
      @path
      name: string;
    },
    ThreatIntelligenceInformation
  >;

  @doc("Update a threat Intelligence indicator.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/threatIntelligence/main/indicators/{name}")
  @put
  Create is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Threat intelligence indicator name field.")
      @path
      name: string;

      @doc("Properties of threat intelligence indicators to create and update.")
      @body
      ThreatIntelligenceProperties: ThreatIntelligenceIndicatorModel;
    },
    ThreatIntelligenceInformation
  >;

  @doc("Delete a threat intelligence indicator.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/threatIntelligence/main/indicators/{name}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Threat intelligence indicator name field.")
      @path
      name: string;
    },
    void
  >;

  @doc("Query threat intelligence indicators as per filtering criteria.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/threatIntelligence/main/queryIndicators")
  @post
  QueryIndicators is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Filtering criteria for querying threat intelligence indicators.")
      @body
      ThreatIntelligenceFilteringCriteria: ThreatIntelligenceFilteringCriteria;
    },
    ThreatIntelligenceInformationList
  >;

  @doc("Append tags to a threat intelligence indicator.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/threatIntelligence/main/indicators/{name}/appendTags")
  @post
  AppendTags is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Threat intelligence indicator name field.")
      @path
      name: string;

      @doc("The threat intelligence append tags request body")
      @body
      ThreatIntelligenceAppendTags: ThreatIntelligenceAppendTags;
    },
    void
  >;

  @doc("Replace tags added to a threat intelligence indicator.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/threatIntelligence/main/indicators/{name}/replaceTags")
  @post
  ReplaceTags is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Threat intelligence indicator name field.")
      @path
      name: string;

      @doc("Tags in the threat intelligence indicator to be replaced.")
      @body
      ThreatIntelligenceReplaceTags: ThreatIntelligenceIndicatorModel;
    },
    ThreatIntelligenceInformation
  >;
}

interface ThreatIntelligenceIndicatorsOperations {
  @doc("Get all threat intelligence indicators.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/threatIntelligence/main/indicators")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Filters the results, based on a Boolean condition. Optional.")
      @query
      $filter: string;

      @doc("Sorts the results. Optional.")
      @query
      $orderby: string;

      @doc("Returns only the first n results. Optional.")
      @query
      $top: int32;

      @doc("""
Skiptoken is only used if a previous operation returned a partial result. If a
previous response contains a nextLink element, the value of the nextLink
element will include a skiptoken parameter that specifies a starting point to
use for subsequent calls. Optional.
""")
      @query
      $skipToken: string;
    },
    ThreatIntelligenceInformationList
  >;
}

interface ThreatIntelligenceIndicatorMetricsOperations {
  @doc("""
Get threat intelligence indicators metrics (Indicators counts by Type, Threat
Type, Source).
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/threatIntelligence/main/metrics")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;
    },
    ThreatIntelligenceMetricsList
  >;
}

interface WatchlistsOperations {
  @doc("Gets all watchlists, without watchlist items.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/watchlists")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("""
Skiptoken is only used if a previous operation returned a partial result. If a
previous response contains a nextLink element, the value of the nextLink
element will include a skiptoken parameter that specifies a starting point to
use for subsequent calls. Optional.
""")
      @query
      $skipToken: string;
    },
    WatchlistList
  >;

  @doc("Gets a watchlist, without its watchlist items.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/watchlists/{watchlistAlias}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Watchlist Alias")
      @path
      watchlistAlias: string;
    },
    Watchlist
  >;

  @doc("Delete a watchlist.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/watchlists/{watchlistAlias}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Watchlist Alias")
      @path
      watchlistAlias: string;
    },
    void
  >;

  @doc("""
Create or update a Watchlist and its Watchlist Items (bulk creation, e.g.
through text/csv content type). To create a Watchlist and its Items, we should
call this endpoint with either rawContent or a valid SAR URI and contentType
properties. The rawContent is mainly used for small watchlist (content size
below 3.8 MB). The SAS URI enables the creation of large watchlist, where the
content size can go up to 500 MB. The status of processing such large file can
be polled through the URL returned in Azure-AsyncOperation header.
""")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/watchlists/{watchlistAlias}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Watchlist Alias")
      @path
      watchlistAlias: string;

      @doc("The watchlist")
      @body
      watchlist: Watchlist;
    },
    Watchlist
  >;
}

interface WatchlistItemsOperations {
  @doc("Gets all watchlist Items.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/watchlists/{watchlistAlias}/watchlistItems")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("""
Skiptoken is only used if a previous operation returned a partial result. If a
previous response contains a nextLink element, the value of the nextLink
element will include a skiptoken parameter that specifies a starting point to
use for subsequent calls. Optional.
""")
      @query
      $skipToken: string;

      @doc("Watchlist Alias")
      @path
      watchlistAlias: string;
    },
    WatchlistItemList
  >;

  @doc("Gets a watchlist, without its watchlist items.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/watchlists/{watchlistAlias}/watchlistItems/{watchlistItemId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Watchlist Alias")
      @path
      watchlistAlias: string;

      @doc("Watchlist Item Id (GUID)")
      @path
      watchlistItemId: string;
    },
    WatchlistItem
  >;

  @doc("Delete a watchlist item.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/watchlists/{watchlistAlias}/watchlistItems/{watchlistItemId}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Watchlist Alias")
      @path
      watchlistAlias: string;

      @doc("Watchlist Item Id (GUID)")
      @path
      watchlistItemId: string;
    },
    void
  >;

  @doc("Creates or updates a watchlist item.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/watchlists/{watchlistAlias}/watchlistItems/{watchlistItemId}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Watchlist Alias")
      @path
      watchlistAlias: string;

      @doc("Watchlist Item Id (GUID)")
      @path
      watchlistItemId: string;

      @doc("The watchlist item")
      @body
      watchlistItem: WatchlistItem;
    },
    WatchlistItem
  >;
}

interface DataConnectorsOperations {
  @doc("Gets all data connectors.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/dataConnectors")
  @get
  List is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;
    },
    DataConnectorList
  >;

  @doc("Gets a data connector.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/dataConnectors/{dataConnectorId}")
  @get
  Get is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Connector ID")
      @path
      dataConnectorId: string;
    },
    DataConnector
  >;

  @doc("Creates or updates the data connector.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/dataConnectors/{dataConnectorId}")
  @put
  CreateOrUpdate is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Connector ID")
      @path
      dataConnectorId: string;

      @doc("The data connector")
      @body
      dataConnector: DataConnector;
    },
    DataConnector
  >;

  @doc("Delete the data connector.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/dataConnectors/{dataConnectorId}")
  @delete
  Delete is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Connector ID")
      @path
      dataConnectorId: string;
    },
    void
  >;

  @doc("Connects a data connector.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/dataConnectors/{dataConnectorId}/connect")
  @post
  Connect is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Connector ID")
      @path
      dataConnectorId: string;

      @doc("The data connector")
      @body
      connectBody: DataConnectorConnectBody;
    },
    void
  >;

  @doc("Disconnect a data connector.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/dataConnectors/{dataConnectorId}/disconnect")
  @post
  Disconnect is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("Connector ID")
      @path
      dataConnectorId: string;
    },
    void
  >;
}

interface DataConnectorsCheckRequirementsOperations {
  @doc("Get requirements state for a data connector type.")
  @route("/subscriptions/{subscriptionId}/resourceGroups/{resourceGroupName}/providers/Microsoft.OperationalInsights/workspaces/{workspaceName}/providers/Microsoft.SecurityInsights/dataConnectorsCheckRequirements")
  @post
  Post is Azure.Core.Foundations.Operation<
    {
      @doc("The ID of the target subscription.")
      @path
      subscriptionId: string;

      @doc("The name of the resource group. The name is case insensitive.")
      @path
      resourceGroupName: string;

      @doc("The name of the workspace.")
      @path
      workspaceName: string;

      @doc("The parameters for requirements check message")
      @body
      DataConnectorsCheckRequirements: DataConnectorsCheckRequirements;
    },
    DataConnectorRequirementsState
  >;
}

interface OperationsOperations {
  @doc("Lists all operations available Azure Security Insights Resource Provider.")
  @route("/providers/Microsoft.SecurityInsights/operations")
  @get
  List is Azure.Core.Foundations.Operation<{}, OperationsList>;
}
