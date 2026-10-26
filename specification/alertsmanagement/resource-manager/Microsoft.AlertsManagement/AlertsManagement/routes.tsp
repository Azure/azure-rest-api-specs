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

namespace Microsoft.AlertsManagement;

#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-interface-requires-decorator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
interface AlertsOperationGroup {
  /**
   * List alerts meta data information based on value of identifier parameter.
   */
  @autoRoute
  @get
  @action("alertsMetaData")
  metaData is ArmProviderActionSync<
    Response = AlertsMetaData,
    Parameters = {
      /**
       * Identification of the information to be retrieved by API call.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing metaData.identifier retains the identifier query parameter; preserve wire compatibility."
      @query("identifier")
      identifier: Identifier;
    },
    Error = AlertsManagementErrorResponse
  >;
  /**
   * Get a summarized count of your alerts grouped by various parameters (e.g. grouping by 'Severity' returns the count of alerts for each severity).
   */
  @autoRoute
  @get
  @action("alertsSummary")
  getSummary is ArmProviderActionSync<
    Response = AlertsSummary,
    Scope = ExtensionActionScope,
    Parameters = {
      /**
       * This parameter allows the result set to be grouped by input fields. For example, groupby=severity,alertstate.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing getSummary.groupby retains the groupby query parameter; preserve wire compatibility."
      @query("groupby")
      groupby: AlertsSummaryGroupByFields;

      /**
       * Include count of the SmartGroups as part of the summary. Default value is 'false'.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing getSummary.includeSmartGroupsCount retains the includeSmartGroupsCount query parameter; preserve wire compatibility."
      @query("includeSmartGroupsCount")
      includeSmartGroupsCount?: boolean;

      /**
       * Filter by target resource( which is full ARM ID) Default value is select all.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing getSummary.targetResource retains the targetResource query parameter; preserve wire compatibility."
      @query("targetResource")
      targetResource?: string;

      /**
       * Filter by target resource type. Default value is select all.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing getSummary.targetResourceType retains the targetResourceType query parameter; preserve wire compatibility."
      @query("targetResourceType")
      targetResourceType?: string;

      /**
       * Filter by target resource group name. Default value is select all.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing getSummary.targetResourceGroup retains the targetResourceGroup query parameter; preserve wire compatibility."
      @query("targetResourceGroup")
      targetResourceGroup?: string;

      /**
       * Filter by monitor service which generates the alert instance. Default value is select all.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing getSummary.monitorService retains the monitorService query parameter; preserve wire compatibility."
      @query("monitorService")
      monitorService?: MonitorService;

      /**
       * Filter by monitor condition which is either 'Fired' or 'Resolved'. Default value is to select all.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing getSummary.monitorCondition retains the monitorCondition query parameter; preserve wire compatibility."
      @query("monitorCondition")
      monitorCondition?: MonitorCondition;

      /**
       * Filter by severity.  Default value is select all.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing getSummary.severity retains the severity query parameter; preserve wire compatibility."
      @query("severity")
      severity?: Severity;

      /**
       * Filter by state of the alert instance. Default value is to select all.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing getSummary.alertState retains the alertState query parameter; preserve wire compatibility."
      @query("alertState")
      alertState?: AlertState;

      /**
       * Filter by specific alert rule.  Default value is to select all.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing getSummary.alertRule retains the alertRule query parameter; preserve wire compatibility."
      @query("alertRule")
      alertRule?: string;

      /**
       * Filter by time range by below listed values. Default value is 1 day.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing getSummary.timeRange retains the timeRange query parameter; preserve wire compatibility."
      @query("timeRange")
      timeRange?: TimeRange;

      /**
       * Filter by custom time range in the format <start-time>/<end-time>  where time is in (ISO-8601 format)'. Permissible values is within 30 days from  query time. Either timeRange or customTimeRange could be used but not both. Default is none.
       */
      #suppress "@azure-tools/typespec-azure-resource-manager/no-query-in-collection" "Back compat: Existing getSummary.customTimeRange retains the customTimeRange query parameter; preserve wire compatibility."
      @query("customTimeRange")
      customTimeRange?: string;
    },
    Error = AlertsManagementErrorResponse
  >;
}
