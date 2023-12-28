import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace Azure.ResourceManager.ResourceGraph;

interface Operations extends Azure.ResourceManager.Operations {}

@Azure.Core.fixed
enum ResultFormat {
  table,
  objectArray,
}
@Azure.Core.fixed
enum AuthorizationScopeFilter {
  AtScopeAndBelow,
  AtScopeAndAbove,
  AtScopeExact,
  AtScopeAboveAndBelow,
}
@Azure.Core.fixed
enum FacetSortOrder {
  asc,
  desc,
}
@Azure.Core.fixed
enum ResultTruncated {
  `true`,
  `false`,
}
@Azure.Core.fixed
enum ColumnDataType {
  string,
  integer,
  number,
  boolean,
  object,
  datetime,
}

@doc("Describes a query to be executed.")
model QueryRequest {
  @doc("Azure subscriptions against which to execute the query.")
  subscriptions?: string[];

  @doc("Azure management groups against which to execute the query. Example: [ 'mg1', 'mg2' ]")
  managementGroups?: string[];

  @doc("The resources query.")
  query: string;

  @doc("The query evaluation options")
  options?: QueryRequestOptions;

  @doc("An array of facet requests to be computed against the query result.")
  facets?: FacetRequest[];
}

@doc("The options for query evaluation")
model QueryRequestOptions {
  @doc("Continuation token for pagination, capturing the next page size and offset, as well as the context of the query.")
  @projectedName("json", "$skipToken")
  skipToken?: string;

  @doc("The maximum number of rows that the query should return. Overrides the page size when ```$skipToken``` property is present.")
  @maxValue(1000)
  @minValue(1)
  @projectedName("json", "$top")
  top?: int32;

  @doc("The number of rows to skip from the beginning of the results. Overrides the next page offset when ```$skipToken``` property is present.")
  @projectedName("json", "$skip")
  skip?: int32;

  @doc("Defines in which format query result returned.")
  resultFormat?: ResultFormat;

  @doc("Only applicable for tenant and management group level queries to decide whether to allow partial scopes for result in case the number of subscriptions exceed allowed limits.")
  allowPartialScopes?: boolean;

  @doc("Defines what level of authorization resources should be returned based on the which subscriptions and management groups are passed as scopes.")
  authorizationScopeFilter?: AuthorizationScopeFilter;
}

@doc("A request to compute additional statistics (facets) over the query results.")
model FacetRequest {
  @doc("The column or list of columns to summarize by")
  expression: string;

  @doc("The options for facet evaluation")
  options?: FacetRequestOptions;
}

@doc("The options for facet evaluation")
model FacetRequestOptions {
  @doc("The column name or query expression to sort on. Defaults to count if not present.")
  sortBy?: string;

  @doc("The sorting order by the selected column (count by default).")
  sortOrder?: FacetSortOrder;

  @doc("Specifies the filter condition for the 'where' clause which will be run on main query's result, just before the actual faceting.")
  filter?: string;

  @doc("The maximum number of facet rows that should be returned.")
  @maxValue(1000)
  @minValue(1)
  @projectedName("json", "$top")
  top?: int32;
}

@doc("Query result.")
model QueryResponse {
  @doc("Number of total records matching the query.")
  totalRecords: int32;

  @doc("Number of records returned in the current response. In the case of paging, this is the number of records in the current page.")
  count: int32;

  @doc("Indicates whether the query results are truncated.")
  resultTruncated: ResultTruncated;

  @doc("When present, the value can be passed to a subsequent query call (together with the same query and scopes used in the current request) to retrieve the next page of data.")
  @projectedName("json", "$skipToken")
  skipToken?: string;

  @doc("Query output in JObject array or Table format.")
  data: Record<unknown>;

  @doc("Query facets.")
  facets?: Facet[];
}

@doc("A facet containing additional statistics on the response of a query. Can be either FacetResult or FacetError.")
@discriminator("resultType")
model Facet {
  @doc("Facet expression, same as in the corresponding facet request.")
  expression: string;
}

@doc("Error details.")
model Error {
  @doc("Error code identifying the specific error.")
  code: string;

  @doc("A human readable error message.")
  message: string;

  @doc("Error details")
  details?: ErrorDetails[];
}

@doc("Error details.")
model ErrorDetails extends Record<Record<unknown>> {
  @doc("Error code identifying the specific error.")
  code: string;

  @doc("A human readable error message.")
  message: string;
}

@doc("Describes a history request to be executed.")
model ResourcesHistoryRequest {
  @doc("Azure subscriptions against which to execute the query.")
  subscriptions?: string[];

  @doc("The resources query.")
  query?: string;

  @doc("The history request evaluation options")
  options?: ResourcesHistoryRequestOptions;

  @doc("Azure management groups against which to execute the query. Example: [ 'mg1', 'mg2' ]")
  managementGroups?: string[];
}

@doc("The options for history request evaluation")
model ResourcesHistoryRequestOptions {
  @doc("The time interval used to fetch history.")
  interval?: DateTimeInterval;

  @doc("The maximum number of rows that the query should return. Overrides the page size when ```$skipToken``` property is present.")
  @maxValue(1000)
  @minValue(1)
  @projectedName("json", "$top")
  top?: int32;

  @doc("The number of rows to skip from the beginning of the results. Overrides the next page offset when ```$skipToken``` property is present.")
  @projectedName("json", "$skip")
  skip?: int32;

  @doc("Continuation token for pagination, capturing the next page size and offset, as well as the context of the query.")
  @projectedName("json", "$skipToken")
  skipToken?: string;

  @doc("Defines in which format query result returned.")
  resultFormat?: ResultFormat;
}

@doc("An interval in time specifying the date and time for the inclusive start and exclusive end, i.e. `[start, end)`.")
model DateTimeInterval {
  @doc("A datetime indicating the inclusive/closed start of the time interval, i.e. `[`**`start`**`, end)`. Specifying a `start` that occurs chronologically after `end` will result in an error.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  start: utcDateTime;

  @doc("A datetime indicating the exclusive/open end of the time interval, i.e. `[start, `**`end`**`)`. Specifying an `end` that occurs chronologically before `start` will result in an error.")
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  end: utcDateTime;
}

@doc("Query output in tabular format.")
model Table {
  @doc("Query result column descriptors.")
  columns: Column[];

  @doc("Query result rows.")
  rows: Record<unknown>[][];
}

@doc("Query result column descriptor.")
model Column {
  @doc("Column name.")
  name: string;

  @doc("Column data type.")
  type: ColumnDataType;
}

@doc("Successfully executed facet containing additional statistics on the response of a query.")
model FacetResult extends Facet {
  @doc("Number of total records in the facet results.")
  totalRecords: int32;

  @doc("Number of records returned in the facet response.")
  count: int32;

  @doc("A JObject array or Table containing the desired facets. Only present if the facet is valid.")
  data: Record<unknown>;

  @doc("Result type")
  resultType: "FacetResult";
}

@doc("A facet whose execution resulted in an error.")
model FacetError extends Facet {
  @doc("An array containing detected facet errors with details.")
  errors: ErrorDetails[];

  @doc("Result type")
  resultType: "FacetError";
}
