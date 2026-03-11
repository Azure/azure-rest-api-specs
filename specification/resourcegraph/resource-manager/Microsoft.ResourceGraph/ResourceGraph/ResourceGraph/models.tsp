import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace ResourceGraph;

/**
 * Defines in which format query result returned.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
enum ResultFormat {
  /**
   * table
   */
  table,

  /**
   * objectArray
   */
  objectArray,
}

/**
 * Defines what level of authorization resources should be returned based on the which subscriptions and management groups are passed as scopes.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
@Versioning.added(Versions.v2023_09_01_preview)
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
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
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
#suppress "@azure-tools/typespec-azure-core/no-enum" "For backward compatibility"
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
 * An error response from the API.
 */
@error
model ErrorResponse {
  /**
   * Error information.
   */
  error: Error;
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
  @identifiers(#[])
  details?: ErrorDetails[];
}

/**
 * Error details.
 */
model ErrorDetails {
  ...Record<unknown>;

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
 * Describes a query to be executed.
 */
model QueryRequest {
  /**
   * Azure subscriptions against which to execute the query.
   */
  @Versioning.madeOptional(Versions.v2020_04_01_preview)
  subscriptions?: string[];

  /**
   * Azure management groups against which to execute the query. Example: [ 'mg1', 'mg2' ]
   */
  
  @Versioning.added(Versions.v2020_04_01_preview)
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
  $skip?: int32;

  /**
   * Defines in which format query result returned.
   */
  resultFormat?: ResultFormat = ResultFormat.objectArray;

  /**
   * Only applicable for tenant and management group level queries to decide whether to allow partial scopes for result in case the number of subscriptions exceed allowed limits.
   */
  @Versioning.added(Versions.v2021_03_01)
  allowPartialScopes?: boolean;

  /**
   * Defines what level of authorization resources should be returned based on the which subscriptions and management groups are passed as scopes.
   */
  @Versioning.added(Versions.v2023_09_01_preview)
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
  #suppress "@azure-tools/typespec-azure-resource-manager/secret-prop" ""
  $skipToken?: string;

  /**
   * Query output in JObject array or Table format.
   */
  #suppress "@azure-tools/typespec-azure-core/no-unknown" ""
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
  #suppress "@azure-tools/typespec-azure-core/no-string-discriminator" ""
  resultType: string;
}

/**
 * Result of the request to list Resource Graph operations. It contains a list of operations and a URL link to get the next set of results.
 */
model OperationListResult {
  /**
   * List of Resource Graph operations supported by the Resource Graph resource provider.
   */
  @pageItems
  value?: Operation[];

  /**
   * The link to the next page of items
   */
  @nextLink
  nextLink?: string;
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
  #suppress "@azure-tools/typespec-azure-core/no-unknown" ""
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
  errors: ErrorDetails[];

  /**
   * Result type
   */
  resultType: "FacetError";
}
