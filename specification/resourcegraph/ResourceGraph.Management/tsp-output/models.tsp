import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace ResourceGraphClient;

interface Operations extends Azure.ResourceManager.Operations {}

/**
 * Defines in which format query result returned.
 */
@fixed
enum ResultFormat {
  table,
  objectArray,
}

/**
 * Defines what level of authorization resources should be returned based on the which subscriptions and management groups are passed as scopes.
 */
@fixed
enum AuthorizationScopeFilter {
  AtScopeAndBelow,
  AtScopeAndAbove,
  AtScopeExact,
  AtScopeAboveAndBelow,
}

/**
 * The sorting order by the selected column (count by default).
 */
@fixed
enum FacetSortOrder {
  asc,
  desc,
}

/**
 * Indicates whether the query results are truncated.
 */
@fixed
enum ResultTruncated {
  `true`,
  `false`,
}

/**
 * Data type of a column in a table.
 */
@fixed
enum ColumnDataType {
  string,
  integer,
  number,
  boolean,
  object,
  datetime,
}

/**
 * Describes a query to be executed.
 */
model QueryRequest {
  /**
   * Azure subscriptions against which to execute the query.
   */
  subscriptions?: string[];

  /**
   * Azure management groups against which to execute the query. Example: [ 'mg1', 'mg2' ]
   */
  managementGroups?: string[];

  /**
   * The resources query.
   */
  query: string;

  /**
   * The query evaluation options
   */
  options?: QueryRequestOptions;

  /**
   * An array of facet requests to be computed against the query result.
   */
  facets?: FacetRequest[];
}

/**
 * The options for query evaluation
 */
model QueryRequestOptions {
  /**
   * Continuation token for pagination, capturing the next page size and offset, as well as the context of the query.
   */
  @projectedName("json", "$skipToken")
  skipToken?: string;

  /**
   * The maximum number of rows that the query should return. Overrides the page size when ```$skipToken``` property is present.
   */
  @maxValue(1000)
  @minValue(1)
  @projectedName("json", "$top")
  top?: int32;

  /**
   * The number of rows to skip from the beginning of the results. Overrides the next page offset when ```$skipToken``` property is present.
   */
  @projectedName("json", "$skip")
  skip?: int32;

  /**
   * Defines in which format query result returned.
   */
  resultFormat?: ResultFormat;

  /**
   * Only applicable for tenant and management group level queries to decide whether to allow partial scopes for result in case the number of subscriptions exceed allowed limits.
   */
  allowPartialScopes?: boolean;

  /**
   * Defines what level of authorization resources should be returned based on the which subscriptions and management groups are passed as scopes.
   */
  authorizationScopeFilter?: AuthorizationScopeFilter = AuthorizationScopeFilter.AtScopeAndBelow;
}

/**
 * A request to compute additional statistics (facets) over the query results.
 */
model FacetRequest {
  /**
   * The column or list of columns to summarize by
   */
  expression: string;

  /**
   * The options for facet evaluation
   */
  options?: FacetRequestOptions;
}

/**
 * The options for facet evaluation
 */
model FacetRequestOptions {
  /**
   * The column name or query expression to sort on. Defaults to count if not present.
   */
  sortBy?: string;

  /**
   * The sorting order by the selected column (count by default).
   */
  sortOrder?: FacetSortOrder = FacetSortOrder.desc;

  /**
   * Specifies the filter condition for the 'where' clause which will be run on main query's result, just before the actual faceting.
   */
  filter?: string;

  /**
   * The maximum number of facet rows that should be returned.
   */
  @maxValue(1000)
  @minValue(1)
  @projectedName("json", "$top")
  top?: int32;
}

/**
 * Query result.
 */
model QueryResponse {
  /**
   * Number of total records matching the query.
   */
  totalRecords: int64;

  /**
   * Number of records returned in the current response. In the case of paging, this is the number of records in the current page.
   */
  count: int64;

  /**
   * Indicates whether the query results are truncated.
   */
  resultTruncated: ResultTruncated;

  /**
   * When present, the value can be passed to a subsequent query call (together with the same query and scopes used in the current request) to retrieve the next page of data.
   */
  @projectedName("json", "$skipToken")
  skipToken?: string;

  /**
   * Query output in JObject array or Table format.
   */
  data: Record<unknown>;

  /**
   * Query facets.
   */
  facets?: Facet[];
}

/**
 * A facet containing additional statistics on the response of a query. Can be either FacetResult or FacetError.
 */
@discriminator("resultType")
model Facet {
  /**
   * Facet expression, same as in the corresponding facet request.
   */
  expression: string;
}

/**
 * Error details.
 */
model Error {
  /**
   * Error code identifying the specific error.
   */
  code: string;

  /**
   * A human readable error message.
   */
  message: string;

  /**
   * Error details
   */
  details?: ErrorDetails[];
}

/**
 * Error details.
 */
model ErrorDetails extends Record<Record<unknown>> {
  /**
   * Error code identifying the specific error.
   */
  code: string;

  /**
   * A human readable error message.
   */
  message: string;
}

/**
 * Describes a history request to be executed.
 */
model ResourcesHistoryRequest {
  /**
   * Azure subscriptions against which to execute the query.
   */
  subscriptions?: string[];

  /**
   * The resources query.
   */
  query?: string;

  /**
   * The history request evaluation options
   */
  options?: ResourcesHistoryRequestOptions;

  /**
   * Azure management groups against which to execute the query. Example: [ 'mg1', 'mg2' ]
   */
  managementGroups?: string[];
}

/**
 * The options for history request evaluation
 */
model ResourcesHistoryRequestOptions {
  /**
   * The time interval used to fetch history.
   */
  interval?: DateTimeInterval;

  /**
   * The maximum number of rows that the query should return. Overrides the page size when ```$skipToken``` property is present.
   */
  @maxValue(1000)
  @minValue(1)
  @projectedName("json", "$top")
  top?: int32;

  /**
   * The number of rows to skip from the beginning of the results. Overrides the next page offset when ```$skipToken``` property is present.
   */
  @projectedName("json", "$skip")
  skip?: int32;

  /**
   * Continuation token for pagination, capturing the next page size and offset, as well as the context of the query.
   */
  @projectedName("json", "$skipToken")
  skipToken?: string;

  /**
   * Defines in which format query result returned.
   */
  resultFormat?: ResultFormat;
}

/**
 * An interval in time specifying the date and time for the inclusive start and exclusive end, i.e. `[start, end)`.
 */
model DateTimeInterval {
  /**
   * A datetime indicating the inclusive/closed start of the time interval, i.e. `[`**`start`**`, end)`. Specifying a `start` that occurs chronologically after `end` will result in an error.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  start: utcDateTime;

  /**
   * A datetime indicating the exclusive/open end of the time interval, i.e. `[start, `**`end`**`)`. Specifying an `end` that occurs chronologically before `start` will result in an error.
   */
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  end: utcDateTime;
}

/**
 * Query output in tabular format.
 */
model Table {
  /**
   * Query result column descriptors.
   */
  columns: Column[];

  /**
   * Query result rows.
   */
  rows: Record<unknown>[][];
}

/**
 * Query result column descriptor.
 */
model Column {
  /**
   * Column name.
   */
  name: string;

  /**
   * Column data type.
   */
  type: ColumnDataType;
}

/**
 * Successfully executed facet containing additional statistics on the response of a query.
 */
model FacetResult extends Facet {
  /**
   * Number of total records in the facet results.
   */
  totalRecords: int64;

  /**
   * Number of records returned in the facet response.
   */
  count: int32;

  /**
   * A JObject array or Table containing the desired facets. Only present if the facet is valid.
   */
  data: Record<unknown>;

  /**
   * Result type
   */
  resultType: "FacetResult";
}

/**
 * A facet whose execution resulted in an error.
 */
model FacetError extends Facet {
  /**
   * An array containing detected facet errors with details.
   */
  errors: ErrorDetails[];

  /**
   * Result type
   */
  resultType: "FacetError";
}
