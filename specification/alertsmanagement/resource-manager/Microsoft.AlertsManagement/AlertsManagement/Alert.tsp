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
@tenantResource
model Alert is Azure.ResourceManager.ProxyResource<AlertProperties> {
  ...ResourceNameParameter<
    Resource = Alert,
    KeyName = "alertId",
    SegmentName = "alerts",
    NamePattern = ""
  >;
}

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
  {
    /** Unique ID of an alert instance. */
    @path
    @segment("alerts")
    @key
    alertId: string;
  }
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
      @query("newState")
      newState: AlertState;
    },
    OptionalRequestBody = true,
    ErrorType = AlertsManagementErrorResponse
  >;
}
alias AlertOperationGroupOps = Azure.ResourceManager.Legacy.ExtensionOperations<
  {
    ...ApiVersionParameter;

    /** undefined */
    @path
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
  {
    /** Unique ID of an alert instance. */
    @path
    @segment("alerts")
    @key
    alertId: string;
  }
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
  {
    /** Unique ID of an alert instance. */
    @path
    @segment("alerts")
    @key
    alertId: string;
  }
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
      @query("targetResource")
      targetResource?: string;

      /**
       * Filter by target resource type. Default value is select all.
       */
      @query("targetResourceType")
      targetResourceType?: string;

      /**
       * Filter by target resource group name. Default value is select all.
       */
      @query("targetResourceGroup")
      targetResourceGroup?: string;

      /**
       * Filter by monitor service which generates the alert instance. Default value is select all.
       */
      @query("monitorService")
      monitorService?: MonitorService;

      /**
       * Filter by monitor condition which is either 'Fired' or 'Resolved'. Default value is to select all.
       */
      @query("monitorCondition")
      monitorCondition?: MonitorCondition;

      /**
       * Filter by severity.  Default value is select all.
       */
      @query("severity")
      severity?: Severity;

      /**
       * Filter by state of the alert instance. Default value is to select all.
       */
      @query("alertState")
      alertState?: AlertState;

      /**
       * Filter by specific alert rule.  Default value is to select all.
       */
      @query("alertRule")
      alertRule?: string;

      /**
       * Filter the alerts list by the Smart Group Id. Default value is none.
       */
      @query("smartGroupId")
      smartGroupId?: string;

      /**
       * Include context which has contextual data specific to the monitor service. Default value is false'
       */
      @query("includeContext")
      includeContext?: boolean;

      /**
       * Include egress config which would be used for displaying the content in portal.  Default value is 'false'.
       */
      @query("includeEgressConfig")
      includeEgressConfig?: boolean;

      /**
       * Determines number of alerts returned per page in response. Permissible value is between 1 to 250. When the "includeContent"  filter is selected, maximum value allowed is 25. Default value is 25.
       */
      @query("pageCount")
      pageCount?: int64;

      /**
       * Sort the query results by input field,  Default value is 'lastModifiedDateTime'.
       */
      @query("sortBy")
      sortBy?: AlertsSortByFields;

      /**
       * Sort the query results order in either ascending or descending.  Default value is 'desc' for time fields and 'asc' for others.
       */
      @query("sortOrder")
      sortOrder?: SortOrder;

      /**
       * This filter allows to selection of the fields(comma separated) which would  be part of the essential section. This would allow to project only the  required fields rather than getting entire content.  Default is to fetch all the fields in the essentials section.
       */
      @query("select")
      select?: string;

      /**
       * Filter by time range by below listed values. Default value is 1 day.
       */
      @query("timeRange")
      timeRange?: TimeRange;

      /**
       * Filter by custom time range in the format <start-time>/<end-time>  where time is in (ISO-8601 format)'. Permissible values is within 30 days from  query time. Either timeRange or customTimeRange could be used but not both. Default is none.
       */
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
      @query("targetResource")
      targetResource?: string;

      /**
       * Filter by target resource type. Default value is select all.
       */
      @query("targetResourceType")
      targetResourceType?: string;

      /**
       * Filter by target resource group name. Default value is select all.
       */
      @query("targetResourceGroup")
      targetResourceGroup?: string;

      /**
       * Filter by monitor service which generates the alert instance. Default value is select all.
       */
      @query("monitorService")
      monitorService?: MonitorService;

      /**
       * Filter by monitor condition which is either 'Fired' or 'Resolved'. Default value is to select all.
       */
      @query("monitorCondition")
      monitorCondition?: MonitorCondition;

      /**
       * Filter by severity.  Default value is select all.
       */
      @query("severity")
      severity?: Severity;

      /**
       * Filter by state of the alert instance. Default value is to select all.
       */
      @query("alertState")
      alertState?: AlertState;

      /**
       * Filter by specific alert rule.  Default value is to select all.
       */
      @query("alertRule")
      alertRule?: string;

      /**
       * Filter the alerts list by the Smart Group Id. Default value is none.
       */
      @query("smartGroupId")
      smartGroupId?: string;

      /**
       * Include context which has contextual data specific to the monitor service. Default value is false'
       */
      @query("includeContext")
      includeContext?: boolean;

      /**
       * Include egress config which would be used for displaying the content in portal.  Default value is 'false'.
       */
      @query("includeEgressConfig")
      includeEgressConfig?: boolean;

      /**
       * Determines number of alerts returned per page in response. Permissible value is between 1 to 250. When the "includeContent"  filter is selected, maximum value allowed is 25. Default value is 25.
       */
      @query("pageCount")
      pageCount?: int64;

      /**
       * Sort the query results by input field,  Default value is 'lastModifiedDateTime'.
       */
      @query("sortBy")
      sortBy?: AlertsSortByFields;

      /**
       * Sort the query results order in either ascending or descending.  Default value is 'desc' for time fields and 'asc' for others.
       */
      @query("sortOrder")
      sortOrder?: SortOrder;

      /**
       * This filter allows to selection of the fields(comma separated) which would  be part of the essential section. This would allow to project only the  required fields rather than getting entire content.  Default is to fetch all the fields in the essentials section.
       */
      @query("select")
      select?: string;

      /**
       * Filter by time range by below listed values. Default value is 1 day.
       */
      @query("timeRange")
      timeRange?: TimeRange;

      /**
       * Filter by custom time range in the format <start-time>/<end-time>  where time is in (ISO-8601 format)'. Permissible values is within 30 days from  query time. Either timeRange or customTimeRange could be used but not both. Default is none.
       */
      @query("customTimeRange")
      customTimeRange?: string;
    },
    Response = ArmResponse<AlertsList>,
    ErrorType = AlertsManagementErrorResponse
  >;

  /**
   * Change the state of an alert. If scope is a deleted resource then please use scope as parent resource of the delete resource. For example if my alert id is '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Compute/virtualMachines/vm1/providers/Microsoft.AlertsManagement/alerts/{alertId}' and 'vm1' is deleted then if you want to change state of this particular alert then use parent resource of scope. So in this example change state call will look like this: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.AlertsManagement/alerts/{alertId}'.
   */
  @action("changestate")
  changeState is AlertOperationGroupOps.ActionSync<
    Alert,
    Comments,
    ArmResponse<Alert>,
    Parameters = {
      /**
       * New state of the alert.
       */
      @query("newState")
      newState: AlertState;
    },
    OptionalRequestBody = true,
    ErrorType = AlertsManagementErrorResponse
  >;

  /**
   * Get the history of an alert, which captures any monitor condition changes (Fired/Resolved), alert state changes (New/Acknowledged/Closed) and applied action rules for that particular alert. If scope is a deleted resource then please use scope as parent resource of the delete resource. For example if my alert id is '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.Compute/virtualMachines/vm1/providers/Microsoft.AlertsManagement/alerts/{alertId}' and 'vm1' is deleted then if you want to get history of this particular alert then use parent resource of scope. So in this example get history call will look like this: '/subscriptions/{subscriptionId}/resourceGroups/{resourceGroup}/providers/Microsoft.AlertsManagement/alerts/{alertId}/history'.
   */
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
@@doc(Alerts.changeStateTenant::parameters.body,
  "reason of change alert state"
);
@@doc(AlertOperationGroup.changeState::parameters.body,
  "reason of change alert state"
);
