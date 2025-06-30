import "@azure-tools/typespec-azure-core";
import "./models.tsp";

using TypeSpec.Http;

namespace MonitorQueryLogs;

interface QueryOperationGroup {
  /** Executes an Analytics query for data. */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @summary("Execute an Analytics query")
  @route("/workspaces/{workspaceId}/query")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Primary Workspace ID of the query. This is the Workspace ID from the Properties
       * blade in the Azure portal.
       */
      @path
      workspaceId: string;

      /**
       * The Analytics query. Learn more about the [Analytics query
       * syntax](https://azure.microsoft.com/documentation/articles/app-insights-analytics-reference/)
       */
      @query("query")
      query: string;

      /**
       * Optional. The timespan over which to query data. This is an ISO8601 time period
       * value.  This timespan is applied in addition to any that are specified in the
       * query expression.
       */
      @query("timespan")
      timespan?: duration;
    },
    QueryResults
  >;

  /**
   * Executes an Analytics query for data.
   * [Here](https://learn.microsoft.com/azure/azure-monitor/logs/api/request-format)
   * is an example for using POST with an Analytics query.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @summary("Execute an Analytics query")
  @route("/workspaces/{workspaceId}/query")
  @post
  execute is Azure.Core.Foundations.Operation<
    {
      /**
       * Primary Workspace ID of the query. This is the Workspace ID from the Properties
       * blade in the Azure portal.
       */
      @path
      workspaceId: string;

      /** Optional. The prefer header to set server timeout, query statistics and visualization information. */
      @header("Prefer")
      prefer?: string;

      /** Body Parameter content-type */
      @header("content-type")
      contentType: "application/json";

      /**
       * The Analytics query. Learn more about the [Analytics query
       * syntax](https://azure.microsoft.com/documentation/articles/app-insights-analytics-reference/)
       */
      @bodyRoot
      body: QueryBody;
    },
    QueryResults
  >;

  /**
   * Executes an Analytics query for data in the context of a resource.
   * [Here](https://learn.microsoft.com/azure/azure-monitor/logs/api/azure-resource-queries)
   * is an example for using POST with an Analytics query.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @summary("Execute an Analytics query using resource URI")
  @route("/{resourceId}/query")
  @get
  getWithResourceId is Azure.Core.Foundations.Operation<
    {
      /** The identifier of the resource. */
      @path
      resourceId: string;

      /**
       * The Analytics query. Learn more about the [Analytics query
       * syntax](https://azure.microsoft.com/documentation/articles/app-insights-analytics-reference/)
       */
      @query("query")
      query: string;

      /**
       * Optional. The timespan over which to query data. This is an ISO8601 time period
       * value.  This timespan is applied in addition to any that are specified in the
       * query expression.
       */
      @query("timespan")
      timespan?: duration;
    },
    QueryResults
  >;

  /**
   * Executes an Analytics query for data in the context of a resource.
   * [Here](https://learn.microsoft.com/azure/azure-monitor/logs/api/azure-resource-queries)
   * is an example for using POST with an Analytics query.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @summary("Execute an Analytics query using resource ID")
  @route("/{resourceId}/query")
  @post
  executeWithResourceId is Azure.Core.Foundations.Operation<
    {
      /** The identifier of the resource. */
      @path
      resourceId: string;

      /**
       * Optional. The prefer header to set server timeout, query statistics and
       * visualization information.
       */
      @header("Prefer")
      prefer?: string;

      /** Body Parameter content-type */
      @header("content-type")
      contentType: "application/json";

      /**
       * The Analytics query. Learn more about the [Analytics query
       * syntax](https://azure.microsoft.com/documentation/articles/app-insights-analytics-reference/)
       */
      @bodyRoot
      body: QueryBody;
    },
    QueryResults
  >;

  /**
   * Executes a batch of Analytics queries for data.
   * [Here](https://learn.microsoft.com/azure/azure-monitor/logs/api/batch-queries)
   * is an example for using POST with an Analytics query.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @summary("Execute a batch of Analytics queries")
  @route("/$batch")
  @post
  batch is Azure.Core.Foundations.Operation<
    {
      /** Body Parameter content-type */
      @header("content-type")
      contentType: "application/json";

      /** The batch request body */
      @bodyRoot
      body: BatchRequest;
    },
    BatchResponse
  >;
}

interface MetadataOperationGroup {
  /**
   * Retrieve the metadata information for the workspace, including its schema,
   * functions, workspace info, categories etc.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @summary("Gets metadata information")
  @route("/workspaces/{workspaceId}/metadata")
  @get
  get is Azure.Core.Foundations.Operation<
    {
      /**
       * Primary Workspace ID of the query. This is the Workspace ID from the Properties
       * blade in the Azure portal.
       */
      @path
      workspaceId: string;
    },
    MetadataResults
  >;

  /**
   * Retrieve the metadata information for the workspace, including its schema,
   * functions, workspace info, categories etc.
   */
  #suppress "@azure-tools/typespec-azure-core/use-standard-operations" "Doesn't fit standard ops"
  @summary("Gets metadata information")
  @route("/workspaces/{workspaceId}/metadata")
  @post
  post is Azure.Core.Foundations.Operation<
    {
      /**
       * Primary Workspace ID of the query. This is the Workspace ID from the Properties
       * blade in the Azure portal.
       */
      @path
      workspaceId: string;
    },
    MetadataResults
  >;
}
