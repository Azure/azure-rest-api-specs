namespace MonitorQueryLogs;

/** The data type of a column. */
union ColumnDataType {
  string,

  /** Boolean data type */
  bool: "bool",

  /** DateTime data type */
  datetime: "datetime",

  /** Dynamic data type */
  dynamic: "dynamic",

  /** Integer data type */
  int: "int",

  /** Long integer data type */
  long: "long",

  /** Real/floating point data type */
  real: "real",

  /** String data type */
  string: "string",

  /** GUID data type */
  guid: "guid",

  /** Decimal data type */
  decimal: "decimal",

  /** Timespan data type */
  timespan: "timespan",
}

/** Contains the tables, columns & rows resulting from a query. */
model QueryResults {
  /** The results of the query in tabular format. */
  tables: Table[];

  /** Statistics represented in JSON format. */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "This is an arbitrary object"
  statistics?: Record<unknown>;

  /** Visualization data in JSON format. */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "This is an arbitrary object"
  render?: Record<unknown>;

  /** The code and message for an error. */
  error?: ErrorInfo;
}

/** Contains the columns and rows for one table in a query response. */
model Table {
  /** The name of the table. */
  name: string;

  /** The list of columns in this table. */
  columns: Column[];

  /** The resulting rows from this query. */
  rows: unknown[][];
}

/** A column in a table. */
model Column {
  /** The name of this column. */
  name: string;

  /** The data type of this column. */
  type: ColumnDataType;
}

/** The code and message for an error. */
model ErrorInfo {
  /** A machine readable error code. */
  code: string;

  /** A human readable error message. */
  message: string;

  /** error details. */
  details?: ErrorDetail[];

  /** Inner error details if they exist. */
  innererror?: ErrorInfo;

  /** Additional properties that can be provided on the error info object */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "This is an arbitrary object"
  additionalProperties?: Record<unknown>;
}

/** Error details. */
model ErrorDetail {
  /** The error's code. */
  code: string;

  /** A human readable error message. */
  message: string;

  /** Indicates which property in the request is responsible for the error. */
  target?: string;

  /** Indicates which value in 'target' is responsible for the error. */
  value?: string;

  /** Indicates resources which were responsible for the error. */
  resources?: string[];

  /** Additional properties that can be provided on the error details object */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "This is an arbitrary object"
  additionalProperties?: Record<unknown>;
}

/** Contains details when the response code indicates an error. */
@error
model ErrorResponse {
  /** The error details. */
  error: ErrorInfo;
}

/**
 * The Analytics query. Learn more about the
 * [Analytics query syntax](https://azure.microsoft.com/documentation/articles/app-insights-analytics-reference/)
 */
model QueryBody {
  /** The query to execute. */
  query: string;

  /**
   * Optional. The timespan over which to query data. This is an ISO8601 time period
   * value.  This timespan is applied in addition to any that are specified in the
   * query expression.
   */
  timespan?: string;

  /** A list of workspaces to query in addition to the primary workspace. */
  workspaces?: string[];
}

/** The metadata response for the app, including available tables, etc. */
model MetadataResults {
  /** The list of categories that are referenced in this metadata response. */
  categories?: MetadataCategory[];

  /** The list of resource types that are referenced in this metadata response. */
  resourceTypes?: MetadataResourceType[];

  /** The list of Log Analytics solutions installed on the workspace. */
  solutions?: MetadataSolution[];

  /** The list of tables and columns that comprise the schema of the workspace. */
  tables?: MetadataTable[];

  /** The list of functions stored on the workspace, or introduced by solutions etc. */
  functions?: MetadataFunction[];

  /**
   * The list of saved queries stored on the workspace, or introduced by solutions,
   * resource types, etc.
   */
  queries?: MetadataQuery[];

  /**
   * The list of Application Insights apps that were referenced in the metadata
   * request.
   */
  applications?: MetadataApplication[];

  /**
   * The list of Log Analytics workspaces that were referenced in the metadata
   * request.
   */
  workspaces?: MetadataWorkspace[];

  /** The list of Azure resources that were referenced in the metadata request. */
  resources?: string[];

  /** The list of permission rules that affected the metadata request. */
  permissions?: MetadataPermissions[];
}

/** Categories are used to group other metadata entities. */
model MetadataCategory {
  /** The ID of the category */
  id: string;

  /** The display name of the category */
  displayName: string;

  /** The description of the category */
  description?: string;

  /** The related metadata items for the category */
  related?: MetadataCategoryRelated;
}

/** The related metadata items for the category */
model MetadataCategoryRelated {
  /** The tables related to the category */
  tables?: string[];

  /** The functions related to the category */
  functions?: string[];

  /** The resource types related to the category */
  resourceTypes?: string[];

  /** The saved queries related to the category */
  queries?: string[];

  /** The Log Analytics solutions related to the category */
  solutions?: string[];
}

/**
 * Metadata about types of Azure resources, containing relevant tables, functions,
 * etc.
 */
model MetadataResourceType {
  /** The ID of the resource-type */
  id: string;

  /** The type of the resource-type */
  type: string;

  /** The display name of the resource-type */
  displayName?: string;

  /** The description of the resource-type */
  description?: string;

  /** The user-defined labels of the resource-type */
  labels?: string[];

  /** The tags associated with the resource-type */
  tags?: Record<string>;

  /** The properties of the resource-type */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "This is an arbitrary object"
  properties?: Record<unknown>;

  /** The related metadata items for the resource-type */
  related?: MetadataResourceTypeRelated;
}

/** The related metadata items for the resource-type */
model MetadataResourceTypeRelated {
  /** The tables related to the resource-type */
  tables?: string[];

  /** The functions related to the resource-type */
  functions?: string[];

  /** The categories related to the resource-type */
  categories?: string[];

  /** The queries related to the resource-type */
  queries?: string[];

  /** The Log Analytics workspaces related to the resource-type */
  workspaces?: string[];

  /** The Azure resources related to the resource-type */
  resources?: string[];
}

/**
 * Solutions can group tables and functions that are associated with a certain
 * Azure Log Analytics offering.
 */
model MetadataSolution {
  /** The ID of the Log Analytics solution */
  id: string;

  /** The name of the Log Analytics solution */
  name: string;

  /** The display name of the Log Analytics solution */
  displayName?: string;

  /** The description of the Log Analytics solution */
  description?: string;

  /** The tags that are associated with the Log Analytics solution */
  tags?: Record<string>;

  /** The properties of the Log Analytics solution */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "This is an arbitrary object"
  properties?: Record<unknown>;

  /** The related metadata items for the Log Analytics solution */
  related: MetadataSolutionRelated;
}

/** The related metadata items for the Log Analytics solution */
model MetadataSolutionRelated {
  /** The tables related to the Log Analytics solution */
  tables: string[];

  /** The functions related to the Log Analytics solution */
  functions?: string[];

  /** The categories related to the Log Analytics solution */
  categories?: string[];

  /** The saved queries related to the Log Analytics solution */
  queries?: string[];

  /**
   * The Workspaces referenced in the metadata request that are related to the Log
   * Analytics solution
   */
  workspaces?: string[];
}

/**
 * Tables are part of the workspace schema, and contain a list of columns and a
 * reference to other relevant metadata items.
 */
model MetadataTable {
  /** The ID of the table */
  id: string;

  /** The name of the table */
  name: string;

  /** The description of the table */
  description?: string;

  /** The column associated with the timespan query parameter for the table */
  timespanColumn?: string;

  /** The user defined labels of the table */
  labels?: string[];

  /** The tags associated with the table */
  tags?: Record<string>;

  /** The properties of the table */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "This is an arbitrary object"
  properties?: Record<unknown>;

  /** The list of columns defined on the table */
  columns?: MetadataTableColumnsItem[];

  /** The related metadata items for the table */
  related?: MetadataTableRelated;
}

/** A column in a metadata table. */
model MetadataTableColumnsItem {
  /** The name of the column */
  name: string;

  /** The description of the column */
  description?: string;

  /** The data type of the column */
  type: ColumnDataType;

  /** A flag indicating this column is a preferred facet */
  isPreferredFacet?: boolean;

  /**
   * An indication of the source of the column, used only when multiple workspaces
   * have conflicting definition for the column
   */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "This is an arbitrary object"
  source?: Record<unknown>;
}

/** The related metadata items for the table */
model MetadataTableRelated {
  /** The related categories for the table */
  categories?: string[];

  /** The related Log Analytics solutions for the table */
  solutions?: string[];

  /** The related resource types for the table */
  resourceTypes?: string[];

  /** The related Log Analytics workspaces for the table */
  workspaces?: string[];

  /** The related functions for the table */
  functions?: string[];

  /** The related saved queries for the table */
  queries?: string[];
}

/**
 * Functions are stored Kusto queries that can be specified as part of queries by
 * using their name.
 */
model MetadataFunction {
  /** The ID of the function. */
  id: string;

  /** The name of the function, to be used in queries. */
  name: string;

  /** The parameters/arguments of the function, if any. */
  parameters?: string;

  /** The display name of the function. */
  displayName?: string;

  /** The description of the function. */
  description?: string;

  /** The KQL body of the function. */
  body: string;

  /** The tags associated with the function. */
  tags?: Record<string>;

  /** The properties of the function. */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "This is an arbitrary object"
  properties?: Record<unknown>;

  /** The related metadata items for the function. */
  related?: MetadataFunctionRelated;
}

/** The related metadata items for the function. */
model MetadataFunctionRelated {
  /** The related tables for the function. */
  tables?: string[];

  /** The related Log Analytics solutions for the function. */
  solutions?: string[];

  /** The related resource types for the function. */
  resourceTypes?: string[];

  /** The related categories for the function. */
  categories?: string[];

  /** The related workspaces for the function. */
  workspaces?: string[];
}

/** Queries are stored pieces of KQL, along with a list of relevant metadata items. */
model MetadataQuery {
  /** The ID of the query. */
  id: string;

  /** The display name of the query. */
  displayName?: string;

  /** The description of the query. */
  description?: string;

  /** The KQL body of the query. */
  body: string;

  /** The user defined labels associated with the query. */
  labels?: string[];

  /** The tags associated with the query. */
  tags?: Record<string>;

  /** The properties of the query. */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "This is an arbitrary object"
  properties?: Record<unknown>;

  /** The related metadata items for the query. */
  related?: MetadataQueryRelated;
}

/** The related metadata items for the query. */
model MetadataQueryRelated {
  /** The related categories for the query. */
  categories?: string[];

  /** The related Log Analytics solutions for the query. */
  solutions?: string[];

  /** The related resource types for the query. */
  resourceTypes?: string[];

  /** The related tables for the query. */
  tables?: string[];
}

/**
 * Application Insights apps that were part of the metadata request and that the
 * user has access to.
 */
model MetadataApplication {
  /** The ID of the Application Insights app. */
  id: string;

  /** The ARM resource ID of the Application Insights app. */
  resourceId: string;

  /** The name of the Application Insights app. */
  name: string;

  /** The Azure region of the Application Insights app. */
  region: string;

  /** The related metadata items for the Application Insights app. */
  related?: MetadataApplicationRelated;
}

/** The related metadata items for the Application Insights app. */
model MetadataApplicationRelated {
  /** The related tables for the Application Insights app. */
  tables?: string[];

  /** The related functions for the Application Insights app. */
  functions?: string[];
}

/**
 * Log Analytics workspaces that were part of the metadata request and that the
 * user has access to.
 */
model MetadataWorkspace {
  /** The ID of the Log Analytics workspace. */
  id: string;

  /** The ARM resource ID of the Log Analytics workspace. */
  resourceId: string;

  /** The name of the Log Analytics workspace. */
  name: string;

  /** The Azure region of the Log Analytics workspace. */
  region: string;

  /** The related metadata items for the Log Analytics workspace. */
  related?: MetadataWorkspaceRelated;
}

/** The related metadata items for the Log Analytics workspace. */
model MetadataWorkspaceRelated {
  /** The related tables for the Log Analytics workspace. */
  tables?: string[];

  /** The related Log Analytics solutions for the Log Analytics workspace. */
  solutions?: string[];

  /** The related resource types for the Log Analytics workspace. */
  resourceTypes?: string[];

  /** The related functions for the Log Analytics workspace. */
  functions?: string[];

  /** The related Azure resources for the Log Analytics workspace. */
  resources?: string[];
}

/**
 * Permission information for the metadata call, includes apps/workspaces/resource
 * the user didn't have access to.
 */
model MetadataPermissions {
  /** The permission indication for the workspaces on the metadata request. */
  workspaces: MetadataPermissionsWorkspacesItem[];

  /** The permission indication for the Azure resources on the metadata request. */
  resources?: MetadataPermissionsResourcesItem[];

  /**
   * The permission indication for the Application Insights apps on the metadata
   * request.
   */
  applications?: MetadataPermissionsApplicationsItem[];
}

/** The permission indication for the workspaces on the metadata request. */
model MetadataPermissionsWorkspacesItem {
  /** The resource ID on the permission indication. */
  resourceId: string;

  /** The list of tables that were denied access for the resource ID. */
  denyTables?: string[];
}

/** The permission indication for the Azure resources on the metadata request. */
model MetadataPermissionsResourcesItem {
  /** The resource ID on the permission indication. */
  resourceId: string;

  /** The list of tables that were denied access for the resource ID. */
  denyTables?: string[];
}

/** The permission indication for the Application Insights apps on the metadata request. */
model MetadataPermissionsApplicationsItem {
  /** The resource ID on the permission indication. */
  resourceId: string;
}

/** An array of requests. */
model BatchRequest {
  /** An single request in a batch. */
  requests: BatchQueryRequest[];
}

/** A single request in a batch. */
model BatchQueryRequest {
  /** Unique ID corresponding to each request in the batch. */
  id: string;

  /**
   * Headers of the request. Can use prefer header to set server timeout and to
   * query statistics and visualization information.
   */
  headers?: Record<string>;

  /**
   * The Analytics query. Learn more about the
   * [Analytics query syntax](https://azure.microsoft.com/documentation/articles/app-insights-analytics-reference/)
   */
  body: QueryBody;

  /** The query path of a single request in a batch. */
  path: string;

  /** The method of a single request in a batch, defaults to GET */
  method: string = "GET";

  /**
   * Primary Workspace ID of the query. This is the Workspace ID from the Properties
   * blade in the Azure portal.
   */
  workspace: string;
}

/** Response to a batch query. */
model BatchResponse {
  /** An array of responses corresponding to each individual request in a batch. */
  responses?: BatchQueryResponse[];
}

/** Contains the batch query response and the headers, id, and status of the request */
model BatchQueryResponse {
  /** Unique ID corresponding to each request in the batch. */
  id?: string;

  /** The HTTP status code of the response. */
  status?: int32;

  /** Contains the tables, columns & rows resulting from a query. */
  body?: BatchQueryResults;

  /** Dictionary of <string> */
  headers?: Record<string>;
}

/** Contains the tables, columns & rows resulting from a query. */
model BatchQueryResults {
  /** The results of the query in tabular format. */
  tables?: Table[];

  /** Statistics represented in JSON format. */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "This is an arbitrary object"
  statistics?: Record<unknown>;

  /** Visualization data in JSON format. */
  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "This is an arbitrary object"
  render?: Record<unknown>;

  /** The code and message for an error. */
  error?: ErrorInfo;
}
