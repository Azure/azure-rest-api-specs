import "@typespec/rest";
import "@typespec/http";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.ResourceManager.Foundations;

namespace ResourceGraph;

/**
 * Enum indicating a type of graph query.
 */
union ResultKind {
  string,

  /**
   * basic
   */
  basic: "basic",
}

/**
 * The type of identity that created the resource.
 */
union CreatedByType {
  string,

  /**
   * User
   */
  User: "User",

  /**
   * Application
   */
  Application: "Application",

  /**
   * ManagedIdentity
   */
  ManagedIdentity: "ManagedIdentity",

  /**
   * Key
   */
  Key: "Key",
}

/**
 * Defines in which format query result returned.
 */
#suppress "@azure-tools/typespec-azure-core/no-enum" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
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
 * Properties that contain a graph query.
 */
#suppress "@azure-tools/typespec-azure-resource-manager/arm-resource-provisioning-state" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
model GraphQueryProperties {
  /**
   * Date and time in UTC of the last modification that was made to this graph query definition.
   */
  @visibility(Lifecycle.Read)
  // FIXME: (utcDateTime) Please double check that this is the correct type for your scenario.
  timeModified?: utcDateTime;

  /**
   * The description of a graph query.
   */
  description?: string;

  /**
   * KQL query that will be graph.
   */
  query: string;

  /**
   * Enum indicating a type of graph query.
   */
  @visibility(Lifecycle.Read)
  resultKind?: ResultKind;
}

/**
 * An azure resource object
 */
model Resource {
  /**
   * Azure resource Id
   */
  @visibility(Lifecycle.Read)
  id?: string;

  /**
   * Azure resource name. This is GUID value. The display name should be assigned within properties field.
   */
  @visibility(Lifecycle.Read)
  name?: string;

  /**
   * The location of the resource
   */
  @visibility(Lifecycle.Read, Lifecycle.Create)
  location?: string;

  /**
   * Azure resource type
   */
  @visibility(Lifecycle.Read)
  type?: string;

  /**
   * This will be used to handle Optimistic Concurrency. If not present, it will always overwrite the existing resource without checking conflict.
   */
  etag?: string;

  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;
}

/**
 * Error message body that will indicate why the operation failed.
 */
@error
model GraphQueryError {
  /**
   * The error object.
   */
  error?: GraphQueryErrorError;
}

/**
 * The error object.
 */
model GraphQueryErrorError {
  /**
   * Service-defined error code. This code serves as a sub-status for the HTTP error code specified in the response.
   */
  code?: string;

  /**
   * Human-readable representation of the error.
   */
  message?: string;

  /**
   * The list of invalid fields send in request, in case of validation error.
   */
  @identifiers(#[])
  details?: ErrorFieldContract[];
}

/**
 * Error Field contract.
 */
model ErrorFieldContract {
  /**
   * Property level error code.
   */
  code?: string;

  /**
   * Human-readable representation of property-level error.
   */
  message?: string;

  /**
   * Property name.
   */
  target?: string;
}

/**
 * The parameters that can be provided when updating workbook properties properties.
 */
model GraphQueryUpdateParameters {
  /**
   * Resource tags
   */
  #suppress "@azure-tools/typespec-azure-resource-manager/arm-no-record" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
  tags?: Record<string>;

  /**
   * This will be used to handle Optimistic Concurrency. If not present, it will always overwrite the existing resource without checking conflict.
   */
  etag?: string;

  /**
   * Metadata describing a graph query for an Azure resource.
   */
  properties?: GraphQueryPropertiesUpdateParameters;
}

/**
 * Properties that contain a workbook for PATCH operation.
 */
model GraphQueryPropertiesUpdateParameters {
  /**
   * The description of a graph query.
   */
  description?: string;

  /**
   * KQL query that will be graph.
   */
  query?: string;
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
  @identifiers(#[])
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
#suppress "@azure-tools/typespec-client-generator-core/legacy-hierarchy-building-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(Facet)
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
#suppress "@azure-tools/typespec-client-generator-core/legacy-hierarchy-building-conflict" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
#suppress "@azure-tools/typespec-azure-core/no-legacy-usage" "FIXME: Update justification, follow aka.ms/tsp/conversion-fix for details"
@Azure.ClientGenerator.Core.Legacy.hierarchyBuilding(Facet)
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

model OperationListResult is Azure.Core.Page<Operation>;
model GraphQueryListResult is Azure.Core.Page<GraphQueryResource>;
@@visibility(GraphQueryListResult.value, Lifecycle.Read);
