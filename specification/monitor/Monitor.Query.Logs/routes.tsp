import "@azure-tools/typespec-azure-core";
import "./models.tsp";
import "@azure-tools/typespec-client-generator-core";

using Azure.ClientGenerator.Core;
using TypeSpec.Http;

namespace MonitorQueryLogs;

interface Query {
  /** Executes an Analytics query for data. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This service uses path param to specify API version"
  @summary("Execute an Analytics query")
  @route("/workspaces/{workspaceId}/query")
  @get
  get(
    /**
     * Primary Workspace ID of the query. This is the Workspace ID from the Properties
     * blade in the Azure portal.
     */
    @path
    workspaceId: string,

    /**
     * The Analytics query. Learn more about the
     * [Analytics query syntax](https://azure.microsoft.com/documentation/articles/app-insights-analytics-reference/)
     */
    @query("query")
    query: string,

    /**
     * Optional. The timespan over which to query data. This is an ISO8601 time period
     * value.  This timespan is applied in addition to any that are specified in the
     * query expression.
     */
    @query("timespan")
    timespan?: duration,
  ): QueryResults | MonitorQueryLogs.ErrorResponse;

  /**
   * Executes an Analytics query for data.
   * [Here](https://learn.microsoft.com/azure/azure-monitor/logs/api/request-format)
   * is an example for using POST with an Analytics query.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This service uses path param to specify API version"
  @summary("Execute an Analytics query")
  @route("/workspaces/{workspaceId}/query")
  @post
  execute(
    /**
     * Primary Workspace ID of the query. This is the Workspace ID from the Properties
     * blade in the Azure portal.
     */
    @path
    workspaceId: string,

    /** Optional. The prefer header to set server timeout, query statistics and visualization information. */
    @header("Prefer")
    @clientName("options", "go")
    prefer?: string,

    /** Body Parameter content-type */
    @header("content-type")
    contentType: "application/json",

    /**
     * The Analytics query. Learn more about the
     * [Analytics query syntax](https://azure.microsoft.com/documentation/articles/app-insights-analytics-reference/)
     */
    @bodyRoot
    body: QueryBody,
  ): QueryResults | MonitorQueryLogs.ErrorResponse;

  /**
   * Executes an Analytics query for data in the context of a resource.
   * [Here](https://learn.microsoft.com/azure/azure-monitor/logs/api/azure-resource-queries)
   * is an example for using POST with an Analytics query.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This service uses path param to specify API version"
  @summary("Execute an Analytics query using resource URI")
  @route("/{+resourceId}/query")
  @get
  getWithResourceId(
    /** The identifier of the resource. */
    @path
    resourceId: string,

    /**
     * The Analytics query. Learn more about the
     * [Analytics query syntax](https://azure.microsoft.com/documentation/articles/app-insights-analytics-reference/)
     */
    @query("query")
    query: string,

    /**
     * Optional. The timespan over which to query data. This is an ISO8601 time period
     * value.  This timespan is applied in addition to any that are specified in the
     * query expression.
     */
    @query("timespan")
    timespan?: duration,
  ): QueryResults | MonitorQueryLogs.ErrorResponse;

  /**
   * Executes an Analytics query for data in the context of a resource.
   * [Here](https://learn.microsoft.com/azure/azure-monitor/logs/api/azure-resource-queries)
   * is an example for using POST with an Analytics query.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This service uses path param to specify API version"
  @summary("Execute an Analytics query using resource ID")
  @route("/{+resourceId}/query")
  @post
  executeWithResourceId(
    /** The identifier of the resource. */
    @path
    resourceId: string,

    /**
     * Optional. The prefer header to set server timeout, query statistics and
     * visualization information.
     */
    @header("Prefer")
    @clientName("options", "go")
    prefer?: string,

    /** Body Parameter content-type */
    @header("content-type")
    contentType: "application/json",

    /**
     * The Analytics query. Learn more about the
     * [Analytics query syntax](https://azure.microsoft.com/documentation/articles/app-insights-analytics-reference/)
     */
    @bodyRoot
    body: QueryBody,
  ): QueryResults | MonitorQueryLogs.ErrorResponse;

  /**
   * Executes a batch of Analytics queries for data.
   * [Here](https://learn.microsoft.com/azure/azure-monitor/logs/api/batch-queries)
   * is an example for using POST with an Analytics query.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This service uses path param to specify API version"
  @summary("Execute a batch of Analytics queries")
  @route("/$batch")
  @post
  batch(
    /** Body Parameter content-type */
    @header("content-type")
    contentType: "application/json",

    /** The batch request body */
    @bodyRoot
    body: BatchRequest,
  ): BatchResponse | MonitorQueryLogs.ErrorResponse;
}

interface Metadata {
  /**
   * Retrieve the metadata information for the workspace, including its schema,
   * functions, workspace info, categories etc.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This service uses path param to specify API version"
  @summary("Gets metadata information")
  @route("/workspaces/{workspaceId}/metadata")
  @get
  get(
    /**
     * Primary Workspace ID of the query. This is the Workspace ID from the Properties
     * blade in the Azure portal.
     */
    @path
    workspaceId: string,
  ): MetadataResults | MonitorQueryLogs.ErrorResponse;

  /**
   * Retrieve the metadata information for the workspace, including its schema,
   * functions, workspace info, categories etc.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  #suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" "This service uses path param to specify API version"
  @summary("Gets metadata information")
  @route("/workspaces/{workspaceId}/metadata")
  @post
  post(
    /**
     * Primary Workspace ID of the query. This is the Workspace ID from the Properties
     * blade in the Azure portal.
     */
    @path
    workspaceId: string,
  ): MetadataResults | MonitorQueryLogs.ErrorResponse;
}
