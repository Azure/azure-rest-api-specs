import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";
import "@typespec/openapi";
import "@typespec/rest";
import "./models.tsp";

using TypeSpec.Rest;
using Azure.ResourceManager;
using TypeSpec.Http;
using TypeSpec.OpenAPI;

namespace Microsoft.AlertsManagement;
/**
 * An alert created in alert management service.
 */
model Alert is Azure.ResourceManager.ProxyResource<AlertProperties> {
  ...ResourceNameParameter<
    Resource = Alert,
    KeyName = "alertId",
    SegmentName = "alerts",
    NamePattern = ""
  >;
}

alias AlertIdParameter = {
  /** Unique ID of an alert instance. */
  @path
  @segment("alerts")
  @key
  alertId: string;
};

alias AlertOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.AlertsManagement";
  },
  {},
  AlertIdParameter,
  "ServiceAlertTenant"
>;

@armResourceOperations
interface Alerts {
  /**
   * Get information related to a specific alert.
   */
  @summary("Get a specific alert.")
  getByIdTenant is AlertOps.Read<
    Alert,
    ErrorType = AlertsManagementErrorResponse
  >;

  /**
   * Get the history of an alert, which captures any monitor condition changes (Fired/Resolved), alert state changes (New/Acknowledged/Closed) and applied action rules for that particular alert.
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/list-operation-missing-pageable" "Existing getHistoryTenant retains its response and SDK paging behavior; preserve published compatibility."
  @get
  @action("history")
  getHistoryTenant is AlertOps.ActionSync<
    Alert,
    void,
    ArmResponse<AlertModification>,
    ErrorType = AlertsManagementErrorResponse
  >;

  /**
   * Change the state of an alert.
   */
  @action("changestate")
  changeStateTenant is AlertOps.ActionSync<
    Alert,
    Comments,
    ArmResponse<Alert>,
    Parameters = {
      /**
       * New state of the alert.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-post" "Existing changeStateTenant POST contract uses newState in the query; preserve wire compatibility."
      @query("newState")
      newState: AlertState;
    },
    OptionalRequestBody = true,
    ErrorType = AlertsManagementErrorResponse
  >;
}

// Multi-scope route `/{scope}/providers/Microsoft.AlertsManagement/alerts/{alertId}`
// (subscription / RG / resource / management group). 4th template arg "ServiceAlert"
// names the C# resource class to preserve the v1.1.x autorest GA `ServiceAlertResource`.
alias AlertOperationGroupOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** undefined */
    @path(#{ allowReserved: true })
    @segment("")
    @key
    scope: string;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.AlertsManagement";
  },
  {},
  AlertIdParameter,
  "ServiceAlert"
>;

alias GetAllTenantOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** the provider namespace */
    @path
    @segment("providers")
    @key
    providerNamespace: "Microsoft.AlertsManagement";
  },
  {},
  AlertIdParameter,
  "ServiceAlertTenant"
>;
@armResourceOperations
interface AlertGetAllTenantOperation {
  /**
   * List all existing alerts, where the results can be filtered on the basis of multiple parameters (e.g. time range). The results can then be sorted on the basis specific fields, with the default being lastModifiedDateTime.
   */
  getAllTenant is GetAllTenantOps.List<
    Alert,
    Parameters = {
      /**
       * Filter by target resource( which is full ARM ID) Default value is select all.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing getAllTenant.targetResource retains the targetResource query parameter; preserve wire compatibility."
      @query("targetResource")
      targetResource?: string;

      /**
       * Filter by target resource type. Default value is select all.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing getAllTenant.targetResourceType retains the targetResourceType query parameter; preserve wire compatibility."
      @query("targetResourceType")
      targetResourceType?: string;

      /**
       * Filter by target resource group name. Default value is select all.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing getAllTenant.targetResourceGroup retains the targetResourceGroup query parameter; preserve wire compatibility."
      @query("targetResourceGroup")
      targetResourceGroup?: string;

      /**
       * Filter by monitor service which generates the alert instance. Default value is select all.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing getAllTenant.monitorService retains the monitorService query parameter; preserve wire compatibility."
      @query("monitorService")
      monitorService?: MonitorService;

      /**
       * Filter by monitor condition which is either 'Fired' or 'Resolved'. Default value is to select all.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing getAllTenant.monitorCondition retains the monitorCondition query parameter; preserve wire compatibility."
      @query("monitorCondition")
      monitorCondition?: MonitorCondition;

      /**
       * Filter by severity.  Default value is select all.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing getAllTenant.severity retains the severity query parameter; preserve wire compatibility."
      @query("severity")
      severity?: Severity;

      /**
       * Filter by state of the alert instance. Default value is to select all.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing getAllTenant.alertState retains the alertState query parameter; preserve wire compatibility."
      @query("alertState")
      alertState?: AlertState;

      /**
       * Filter by specific alert rule.  Default value is to select all.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing getAllTenant.alertRule retains the alertRule query parameter; preserve wire compatibility."
      @query("alertRule")
      alertRule?: string;

      /**
       * Filter the alerts list by the Smart Group Id. Default value is none.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing getAllTenant.smartGroupId retains the smartGroupId query parameter; preserve wire compatibility."
      @query("smartGroupId")
      smartGroupId?: string;

      /**
       * Include context which has contextual data specific to the monitor service. Default value is false'
       */
      #suppress "@azure-tools/typespec-azure-core/no-boolean" "Existing getAllTenant.includeContext has a boolean wire value; preserve the published property contract."
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing getAllTenant.includeContext retains the includeContext query parameter; preserve wire compatibility."
      @query("includeContext")
      includeContext?: boolean;

      /**
       * Include egress config which would be used for displaying the content in portal.  Default value is 'false'.
       */
      #suppress "@azure-tools/typespec-azure-core/no-boolean" "Existing getAllTenant.includeEgressConfig has a boolean wire value; preserve the published property contract."
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing getAllTenant.includeEgressConfig retains the includeEgressConfig query parameter; preserve wire compatibility."
      @query("includeEgressConfig")
      includeEgressConfig?: boolean;

      /**
       * Determines number of alerts returned per page in response. Permissible value is between 1 to 250. When the "includeContent"  filter is selected, maximum value allowed is 25. Default value is 25.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing getAllTenant.pageCount retains the pageCount query parameter; preserve wire compatibility."
      @query("pageCount")
      pageCount?: int64;

      /**
       * Sort the query results by input field,  Default value is 'lastModifiedDateTime'.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing getAllTenant.sortBy retains the sortBy query parameter; preserve wire compatibility."
      @query("sortBy")
      sortBy?: AlertsSortByFields;

      /**
       * Sort the query results order in either ascending or descending.  Default value is 'desc' for time fields and 'asc' for others.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing getAllTenant.sortOrder retains the sortOrder query parameter; preserve wire compatibility."
      @query("sortOrder")
      sortOrder?: SortOrder;

      /**
       * This filter allows to selection of the fields(comma separated) which would  be part of the essential section. This would allow to project only the  required fields rather than getting entire content.  Default is to fetch all the fields in the essentials section.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing getAllTenant.select retains the select query parameter; preserve wire compatibility."
      @query("select")
      select?: string;

      /**
       * Filter by time range by below listed values. Default value is 1 day.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing getAllTenant.timeRange retains the timeRange query parameter; preserve wire compatibility."
      @query("timeRange")
      timeRange?: TimeRange;

      /**
       * Filter by custom time range in the format <start-time>/<end-time>  where time is in (ISO-8601 format)'. Permissible values is within 30 days from  query time. Either timeRange or customTimeRange could be used but not both. Default is none.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing getAllTenant.customTimeRange retains the customTimeRange query parameter; preserve wire compatibility."
      @query("customTimeRange")
      customTimeRange?: string;
    },
    Response = ArmResponse<AlertsList>,
    ErrorType = AlertsManagementErrorResponse
  >;
}

@armResourceOperations
interface AlertOperationGroup {
  /**
   * Get information related to a specific alert. If scope is a deleted resource then please use scope as parent resource of the delete resource. For example if my alert id is '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Compute/virtualMachines/vm1/providers/Microsoft.AlertsManagement/alerts/{alertId}' and 'vm1' is deleted then if you want to get alert by id then use parent resource of scope. So in this example get alert by id call will look like this: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.AlertsManagement/alerts/{alertId}'.
   */
  @summary("Get a specific alert.")
  getById is AlertOperationGroupOps.Read<
    Alert,
    ErrorType = AlertsManagementErrorResponse
  >;

  /**
   * List all existing alerts, where the results can be filtered on the basis of multiple parameters (e.g. time range). The results can then be sorted on the basis specific fields, with the default being lastModifiedDateTime.
   */
  getAll is AlertOperationGroupOps.List<
    Alert,
    Parameters = {
      /**
       * Filter by target resource( which is full ARM ID) Default value is select all.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing getAll.targetResource retains the targetResource query parameter; preserve wire compatibility."
      @query("targetResource")
      targetResource?: string;

      /**
       * Filter by target resource type. Default value is select all.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing getAll.targetResourceType retains the targetResourceType query parameter; preserve wire compatibility."
      @query("targetResourceType")
      targetResourceType?: string;

      /**
       * Filter by target resource group name. Default value is select all.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing getAll.targetResourceGroup retains the targetResourceGroup query parameter; preserve wire compatibility."
      @query("targetResourceGroup")
      targetResourceGroup?: string;

      /**
       * Filter by monitor service which generates the alert instance. Default value is select all.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing getAll.monitorService retains the monitorService query parameter; preserve wire compatibility."
      @query("monitorService")
      monitorService?: MonitorService;

      /**
       * Filter by monitor condition which is either 'Fired' or 'Resolved'. Default value is to select all.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing getAll.monitorCondition retains the monitorCondition query parameter; preserve wire compatibility."
      @query("monitorCondition")
      monitorCondition?: MonitorCondition;

      /**
       * Filter by severity.  Default value is select all.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing getAll.severity retains the severity query parameter; preserve wire compatibility."
      @query("severity")
      severity?: Severity;

      /**
       * Filter by state of the alert instance. Default value is to select all.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing getAll.alertState retains the alertState query parameter; preserve wire compatibility."
      @query("alertState")
      alertState?: AlertState;

      /**
       * Filter by specific alert rule.  Default value is to select all.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing getAll.alertRule retains the alertRule query parameter; preserve wire compatibility."
      @query("alertRule")
      alertRule?: string;

      /**
       * Filter the alerts list by the Smart Group Id. Default value is none.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing getAll.smartGroupId retains the smartGroupId query parameter; preserve wire compatibility."
      @query("smartGroupId")
      smartGroupId?: string;

      /**
       * Include context which has contextual data specific to the monitor service. Default value is false'
       */
      #suppress "@azure-tools/typespec-azure-core/no-boolean" "Existing getAll.includeContext has a boolean wire value; preserve the published property contract."
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing getAll.includeContext retains the includeContext query parameter; preserve wire compatibility."
      @query("includeContext")
      includeContext?: boolean;

      /**
       * Include egress config which would be used for displaying the content in portal.  Default value is 'false'.
       */
      #suppress "@azure-tools/typespec-azure-core/no-boolean" "Existing getAll.includeEgressConfig has a boolean wire value; preserve the published property contract."
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing getAll.includeEgressConfig retains the includeEgressConfig query parameter; preserve wire compatibility."
      @query("includeEgressConfig")
      includeEgressConfig?: boolean;

      /**
       * Determines number of alerts returned per page in response. Permissible value is between 1 to 250. When the "includeContent"  filter is selected, maximum value allowed is 25. Default value is 25.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing getAll.pageCount retains the pageCount query parameter; preserve wire compatibility."
      @query("pageCount")
      pageCount?: int64;

      /**
       * Sort the query results by input field,  Default value is 'lastModifiedDateTime'.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing getAll.sortBy retains the sortBy query parameter; preserve wire compatibility."
      @query("sortBy")
      sortBy?: AlertsSortByFields;

      /**
       * Sort the query results order in either ascending or descending.  Default value is 'desc' for time fields and 'asc' for others.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing getAll.sortOrder retains the sortOrder query parameter; preserve wire compatibility."
      @query("sortOrder")
      sortOrder?: SortOrder;

      /**
       * This filter allows to selection of the fields(comma separated) which would  be part of the essential section. This would allow to project only the  required fields rather than getting entire content.  Default is to fetch all the fields in the essentials section.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing getAll.select retains the select query parameter; preserve wire compatibility."
      @query("select")
      select?: string;

      /**
       * Filter by time range by below listed values. Default value is 1 day.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing getAll.timeRange retains the timeRange query parameter; preserve wire compatibility."
      @query("timeRange")
      timeRange?: TimeRange;

      /**
       * Filter by custom time range in the format <start-time>/<end-time>  where time is in (ISO-8601 format)'. Permissible values is within 30 days from  query time. Either timeRange or customTimeRange could be used but not both. Default is none.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Existing getAll.customTimeRange retains the customTimeRange query parameter; preserve wire compatibility."
      @query("customTimeRange")
      customTimeRange?: string;
    },
    Response = ArmResponse<AlertsList>,
    ErrorType = AlertsManagementErrorResponse
  >;

  /**
   * Change the state of an alert. If scope is a deleted resource then please use scope as parent resource of the delete resource. For example if my alert id is '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Compute/virtualMachines/vm1/providers/Microsoft.AlertsManagement/alerts/{alertId}' and 'vm1' is deleted then if you want to change state of this particular alert then use parent resource of scope. So in this example change state call will look like this: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.AlertsManagement/alerts/{alertId}'.
   */
  #suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" "Tenant variant uses same C# name; resolved by separate resource class"
  @action("changestate")
  changeState is AlertOperationGroupOps.ActionSync<
    Alert,
    Comments,
    ArmResponse<Alert>,
    Parameters = {
      /**
       * New state of the alert.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-post" "Existing changeState POST contract uses newState in the query; preserve wire compatibility."
      @query("newState")
      newState: AlertState;
    },
    OptionalRequestBody = true,
    ErrorType = AlertsManagementErrorResponse
  >;

  /**
   * Get the history of an alert, which captures any monitor condition changes (Fired/Resolved), alert state changes (New/Acknowledged/Closed) and applied action rules for that particular alert. If scope is a deleted resource then please use scope as parent resource of the delete resource. For example if my alert id is '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Compute/virtualMachines/vm1/providers/Microsoft.AlertsManagement/alerts/{alertId}' and 'vm1' is deleted then if you want to get history of this particular alert then use parent resource of scope. So in this example get history call will look like this: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.AlertsManagement/alerts/{alertId}/history'.
   */
  #suppress "@azure-tools/typespec-client-generator-core/duplicate-client-name-warning" "Tenant variant uses same C# name; resolved by separate resource class"
  #suppress "@azure-tools/typespec-azure-resource-manager/list-operation-missing-pageable" "Existing getHistory retains its response and SDK paging behavior; preserve published compatibility."
  @get
  @action("history")
  getHistory is AlertOperationGroupOps.ActionSync<
    Alert,
    void,
    ArmResponse<AlertModification>,
    ErrorType = AlertsManagementErrorResponse
  >;

  /**
   * Get the enrichments of an alert. It returns a collection of one object named default.
   */
  @list
  @get
  @action("enrichments")
  getEnrichments is AlertOperationGroupOps.ActionSync<
    Alert,
    void,
    ArmResponse<AlertEnrichmentsList>
  >;
}

@@doc(Alert.name, "Unique ID of an alert instance.");
@@doc(Alert.properties, "Alert property bag");
@@doc(
  Alerts.changeStateTenant::parameters.body,
  "reason of change alert state"
);
@@doc(
  AlertOperationGroup.changeState::parameters.body,
  "reason of change alert state"
);
