import "@azure-tools/typespec-azure-core";

using Azure.Core;
using TypeSpec.Rest;

namespace QueryModels;

@doc("Represents the count of models with a specific ID.")
model ModelCount {
  @doc("The unique identifier of the model.")
  modelId: string;

  @doc("The count associated with the model.")
  count: int32;
}

@doc("The count of relationships per source and target model ID.")
model RelationshipPerSourceTargetModelId {
  @doc("The source model ID.")
  sourceModelId: string;

  @doc("The target model ID.")
  targetModelId: string;

  @doc("The count associated with the relationship.")
  count: int32;
}

@doc("Summary of the Twins ingestion status.")
model TwinsIngestionData {
  @doc("The count of twins.")
  twinsCount: int32;

  @doc("The count of twins per model ID.")
  twinsPerEntity: ModelCount[];
}

@doc("Summary of the Relationships ingestion status.")
model RelationshipsIngestionData {
  @doc("The count of relationships.")
  relationshipsCount: int32;

  @doc("The count of relationships per source and target model ID.")
  relationshipsPerSourceTargetModelId: RelationshipPerSourceTargetModelId[];
}

@doc("Represents the response containing the ingestion status.")
model IngestionStatusResponse {
  @doc("Ingestion status for twins.")
  twinsData: TwinsIngestionData;

  @doc("Ingestion status for relationships.")
  relationshipsData: RelationshipsIngestionData;

  #suppress "@azure-tools/typespec-azure-core/bad-record-type" "JsonObject array is not supported"
  @doc("The count of vectorization data.")
  vectorizationDataCount: Record<unknown>;
}

@doc("Represents a basic query request.")
@resource("query")
model BasicQueryRequest {
  @doc("The name of the entity.")
  @key
  @visibility(Lifecycle.Read, Lifecycle.Update)
  entityName: string;

  @doc("The filters for the query.")
  filters?: Filter[];
}

@doc("Represents a query request.")
model QueryRequest is BasicQueryRequest {
  @doc("The sort options for the query.")
  sort?: Sort[];

  @doc("The projected fields for the query.")
  projectedFields?: string[];

  @doc("The time series for the query.")
  timeRange?: TimeSeries;

  @doc("The maximum number of records for the query.")
  maxRecords?: int32;
}

model PagedQueryRequest is QueryRequest {
  @doc("The page index.")
  @pageIndex
  pageIndex: int32 = 1;
}

@doc("Represents a paged result of query results.")
@pagedResult
model PagedQueryResult {
  @doc("The list of query results.")
  @pageItems
  value: QueryResult[];
}

@doc("Represents the result of a query.")
model QueryResult {
  @doc("The unique identifier for the entity.")
  @key
  @visibility(Lifecycle.Read)
  id: string;

  @doc("Description of the query entity.")
  @visibility(Lifecycle.Read)
  description?: string;

  @doc("Hierarchy scope of the entity.")
  @visibility(Lifecycle.Read)
  hierarchyScope?: string;

  @doc("Equipment level.")
  @visibility(Lifecycle.Read)
  equipmentLevel?: string;

  @doc("Location of the operation ")
  @visibility(Lifecycle.Read)
  operationLocation?: string;

  @doc("Location type of the operation.")
  @visibility(Lifecycle.Read)
  operationLocationType?: string;

  @doc("Asset ID for the HR system.")
  @visibility(Lifecycle.Read)
  assetsystemrefid?: string;

  @doc("Reference ID for the HR system.")
  @visibility(Lifecycle.Read)
  hrsystemrefid?: string;

  @doc("Reference ID for the MES system.")
  @visibility(Lifecycle.Read)
  messystemrefid?: string;

  @doc("Digital twin ID.")
  @visibility(Lifecycle.Read)
  dtId: string;

  @doc("Timestamp of the entity.")
  @visibility(Lifecycle.Read)
  timestamp: utcDateTime;
}

@doc("Represents a query request for related nodes.")
model QueryRequestRelatedNodes is BasicQueryRequest {
  @doc("The time series for the query.")
  timeRange?: TimeSeries;

  @doc("The maximum number of records for the query.")
  maxRecords?: int32;

  @doc("The page index.")
  @pageIndex
  pageIndex: int32 = 1;
}

@doc("Represents a paged result of related entity data.")
@pagedResult
model PagedRelatedEntityData {
  @doc("The list of related entity data.")
  @pageItems
  value: RelatedEntityData[];
}

@doc("Represents a related entity data.")
model RelatedEntityData {
  @doc("The unique identifier of the related entity.")
  id: string;

  @doc("Model ID of the related entity.")
  modelId: string;

  @doc("The source entity.")
  source: string;

  @doc("The target entity.")
  target: string;

  @doc("Number of hops.")
  noOfHops?: int32;

  @doc("The path of the relationship.")
  path?: string[];

  @doc("Timestamp of the entity data.")
  timestamp: utcDateTime[];

  @doc("The identifier for the equipment.")
  equipmentId?: string;

  @doc("The level of the equipment.")
  equipmentLevel?: string;
}

@doc("Represents a paged result of related node results.")
@pagedResult
model PagedRelatedNodeResult {
  @doc("The list of related node results.")
  @pageItems
  value: RelatedNodeResult[];
}

@doc("Represents a related node result.")
model RelatedNodeResult {
  @doc("The source entity.")
  source: string;

  @doc("The target entity.")
  target: string;

  @doc("The name of the relationship.")
  relationshipName: string;

  @doc("Relationship ID.")
  relationshipId: string;

  @doc("Relationship creation timestamp.")
  timestamp: utcDateTime;
}

@doc("Represents a query request for related entities data.")
model QueryRequestRelatedEntitiesData is BasicQueryRequest {
  @doc("The related entities for the query.")
  relatedEntities: QueryRequest[];

  @doc("The time series for the query.")
  timeRange?: TimeSeries;

  @doc("The path entity list for the query.")
  pathEntityList?: string[];

  @doc("The maximum number of hops for the query.")
  maxHops: int32;

  @doc("The maximum number of records for the query.")
  maxRecords?: int32;

  @doc("The page index.")
  @pageIndex
  pageIndex: int32 = 1;
}

@doc("Represents a filter for a query.")
model Filter {
  @doc("The name of the field to filter.")
  fieldName: string = "";

  @doc("The operator to use for the filter.")
  operator: QueryOperator = QueryOperator.EQ;

  @doc("The value to filter by.")
  value: string = "";

  @doc("The next operator to use for the filter.")
  nextOperator?: QueryNextOperator;
}

@doc("Represents a sort option for a query.")
model Sort {
  @doc("The name of the field to sort by.")
  fieldName: string;

  @doc("Indicates if the sort is ascending.")
  asc: boolean;
}

@doc("Represents a time series for a query.")
model TimeSeries {
  @doc("The operator to use for the time series.")
  operator: TimeSeriesOperator;

  @doc("The parameters for the time series.")
  parameters: string[];
}

@doc("Represents a query operator.")
union QueryOperator {
  @doc("Equal to operator.")
  EQ: "EQ",

  @doc("Not equal to operator.")
  NEQ: "NEQ",

  @doc("Less than or equal to operator.")
  LEQ: "LEQ",

  @doc("Less than operator.")
  LT: "LT",

  @doc("Greater than or equal to operator.")
  GEQ: "GEQ",

  @doc("Greater than operator.")
  GT: "GT",

  @doc("Contains operator.")
  CONTAINS: "CONTAINS",

  @doc("Not contains operator.")
  NCONTAINS: "NCONTAINS",

  @doc("Starts with operator.")
  STARTSWITH: "STARTSWITH",

  @doc("Not starts with operator.")
  NSTARTSWITH: "NSTARTSWITH",

  @doc("Ends with operator.")
  ENDSWITH: "ENDSWITH",

  @doc("Not ends with operator.")
  NENDSWITH: "NENDSWITH",

  @doc("In operator.")
  IN: "IN",

  @doc("Not in operator.")
  NIN: "NIN",

  @doc("Between operator.")
  BETWEEN: "BETWEEN",

  @doc("Not between operator.")
  NBETWEEN: "NBETWEEN",

  @doc("Has operator.")
  HAS: "HAS",

  @doc("Not has operator.")
  NHAS: "NHAS",

  @doc("Regex match operator.")
  REGEXMATCH: "REGEXMATCH",

  string,
}

@doc("Represents the next operator in a query.")
union QueryNextOperator {
  @doc("Logical AND operator.")
  AND: "AND",

  @doc("Logical OR operator.")
  OR: "OR",

  @doc("Any other next operator.")
  string,
}

@doc("Represents time series operators.")
union TimeSeriesOperator {
  @doc("Between operator.")
  BETWEEN: "BETWEEN",

  @doc("Equal to operator.")
  EQ: "EQ",

  @doc("Less than operator.")
  LT: "LT",

  @doc("Greater than operator.")
  GT: "GT",

  string,
}
