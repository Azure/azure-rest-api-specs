import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace ResourceGraphApi;

alias ResultFormat = ResourceGraphCommon.ResultFormat;

/**
 * Defines what level of authorization resources should be returned based on the which subscriptions and management groups are passed as scopes.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum AuthorizationScopeFilter {
  /**
   * AtScopeAndBelow
   */
  AtScopeAndBelow,

  /**
   * AtScopeAndAbove
   */
  AtScopeAndAbove,

  /**
   * AtScopeExact
   */
  AtScopeExact,

  /**
   * AtScopeAboveAndBelow
   */
  AtScopeAboveAndBelow,
}

/**
 * The sorting order by the selected column (count by default).
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum FacetSortOrder {
  /**
   * asc
   */
  asc,

  /**
   * desc
   */
  desc,
}

/**
 * Indicates whether the query results are truncated.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ResultTruncated {
  /**
   * true
   */
  `true`,

  /**
   * false
   */
  `false`,
}

/**
 * Data type of a column in a table.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
enum ColumnDataType {
  /**
   * string
   */
  string,

  /**
   * integer
   */
  integer,

  /**
   * number
   */
  number,

  /**
   * boolean
   */
  boolean,

  /**
   * object
   */
  object,

  /**
   * datetime
   */
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
  @identifiers(#[])
  facets?: FacetRequest[];
}

/**
 * The options for query evaluation
 */
model QueryRequestOptions {
  /**
   * Continuation token for pagination, capturing the next page size and offset, as well as the context of the query.
   */
  $skipToken?: string;

  /**
   * The maximum number of rows that the query should return. Overrides the page size when ```$skipToken``` property is present.
   */
  @maxValue(1000)
  @minValue(1)
  $top?: int32;

  /**
   * The number of rows to skip from the beginning of the results. Overrides the next page offset when ```$skipToken``` property is present.
   */
  @minValue(0)
  $skip?: int32;

  /**
   * Defines in which format query result returned.
   */
  resultFormat?: ResultFormat = ResultFormat.objectArray;

  /**
   * Only applicable for tenant and management group level queries to decide whether to allow partial scopes for result in case the number of subscriptions exceed allowed limits.
   */
  allowPartialScopes?: boolean = false;

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
  $top?: int32;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  $skipToken?: string;

  /**
   * Query output in JObject array or Table format.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  data: unknown;

  /**
   * Query facets.
   */
  @identifiers(#[])
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

  /**
   * Result type
   */
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  resultType: string;
}

/**
 * Resource Graph REST API operation definition.
 */
model Operation {
  /**
   * Operation name: {provider}/{resource}/{operation}
   */
  name?: string;

  /**
   * Display metadata associated with the operation.
   */
  display?: OperationDisplay;

  /**
   * The origin of operations.
   */
  origin?: string;
}

/**
 * Display metadata associated with the operation.
 */
model OperationDisplay {
  /**
   * Service provider: Microsoft Resource Graph.
   */
  provider?: string;

  /**
   * Resource on which the operation is performed etc.
   */
  resource?: string;

  /**
   * Type of operation: get, read, delete, etc.
   */
  operation?: string;

  /**
   * Description for the operation.
   */
  description?: string;
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
  #suppress "@azure-tools/typespec-azure-resource-manager/missing-x-ms-identifiers" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  rows: unknown[][];
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  data: unknown;

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
  @identifiers(#[])
  errors: ResourceGraphCommon.ErrorDetails[];

  /**
   * Result type
   */
  resultType: "FacetError";
}

model OperationListResult is Azure.Core.Page<Operation>;
