import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@typespec/http";

using TypeSpec.Http;
using Azure.Core;
using Azure.Core.Traits;

namespace PurviewUnifiedCatalog;

alias ServiceTraits = NoRepeatableRequests &
  NoConditionalRequests &
  NoClientRequestId;
alias UnifiedCatalogOperations = Azure.Core.ResourceOperations<ServiceTraits>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Searches and retrieves critical data elements based on domain, keyword, and other filters.")
@get
op ListCriticalDataElementAsync is UnifiedCatalogOperations.ResourceList<
  CriticalDataElement,
  ListQueryParametersTrait<{
    @doc("Whether to return minimal information for referred Domains.")
    @query
    domainId?: uuid;

    @doc("Search keyword.")
    @query
    keyword: string;
  } & SkipQueryParameter &
    TopQueryParameter &
    OrderByQueryParameter>
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Creates a new critical data element in the catalog.")
@route("/criticalDataElements")
@post
op CreateCriticalDataElementAsync is RpcOperation<
  CriticalDataElement,
  CreateCriticalDataElementResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Searches and retrieves critical data elements based on Id.")
@get
op GetCriticalDataElementByIdAsync is UnifiedCatalogOperations.ResourceRead<CriticalDataElement>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Updates an existing critical data element in the catalog.")
@route("/criticalDataElements/{criticalDataElementId}")
@put
op UpdateCriticalDataElementAsync is RpcOperation<
  CriticalDataElementBody & CriticalDataElementIdParameters,
  CriticalDataElement
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Deletes an existing critical data element in the catalog.")
@delete
op DeleteCriticalDataElementByIdAsync is UnifiedCatalogOperations.ResourceDelete<CriticalDataElement>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Retrieves relationships for a critical data element.")
@get
op ListCriticalDataElementRelationshipsAsync is UnifiedCatalogOperations.ResourceList<
  CdeRelationshipWrapper,
  ListQueryParametersTrait<{
    @doc("The body associated with the critical data element output.")
    @query
    entityType: EntityCategory;
  }>
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Updates relationships for a critical data element.")
@route("/criticalDataElements/{criticalDataElementId}/relationships")
@post
op CreateCriticalDataElementRelationshipAsync is RpcOperation<
  CriticalDataElementIdParameters & {
    @doc("The type of entity for the relationship.")
    @query
    entityType: EntityCategory;

    @doc("The input properties for creating the relationship.")
    @bodyRoot
    relationship: DataElementProperties;
  },
  RelationshipWrapper
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Deletes relationships for a critical data element.")
@route("/criticalDataElements/{criticalDataElementId}/relationships")
@delete
op DeleteCriticalDataElementRelationshipAsync is RpcOperation<
  CriticalDataElementIdParameters & {
    @doc("The type of entity for the relationship.")
    @query
    entityType: EntityCategory;

    @doc("The unique identifier of the related entity.")
    @query
    entityId: uuid;
  },
  DeleteResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Queries critical data elements based on various criteria.")
@route("/criticalDataElements/query")
@post
op QueryCriticalDataElementsAsync is RpcOperation<
  {
    @doc("The request body containing query criteria.")
    @bodyRoot
    body: CriticalDataElementQueryRequest;

    @doc("The number of duplicate checks to perform.")
    @query
    duplicatecheck?: int32;
  },
  CriticalDataElementsResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Retrieves facets for critical data elements.")
@route("/criticalDataElements/facets")
@post
op GetCriticalDataElementFacetsAsync is RpcOperation<
  CriticalDataElementFacetRequest,
  FacetsResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("CriticalDataColumns")
@doc("Creates a new critical data column in the catalog.")
@route("/criticalDataColumns")
@post
op CreateCriticalDataColumnAsync is RpcOperation<
  CriticalDataColumn,
  CreateCriticalDataColumnResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("CriticalDataColumns")
@doc("Searches and retrieves critical data columns based on domain, assetId, and other filters.")
@get
op ListCriticalDataColumnAsync is UnifiedCatalogOperations.ResourceList<
  CriticalDataColumn,
  ListQueryParametersTrait<{
    @doc("The unique identifier of the critical data column.")
    @query
    domainId?: uuid;

    @doc("The unique identifier of the critical data column.")
    @query
    assetId?: uuid;
  } & SkipQueryParameter &
    TopQueryParameter &
    OrderByQueryParameter>
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("CriticalDataColumns")
@doc("Searches and retrieves critical data columns based on Id.")
@get
op GetCriticalDataColumnByIdAsync is UnifiedCatalogOperations.ResourceRead<CriticalDataColumn>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("CriticalDataColumns")
@doc("Updates an existing critical data column in the catalog.")
@route("/criticalDataColumns/{criticalDataColumnId}/relationships")
@post
op CreateCriticalDataColumnRelationshipAsync is RpcOperation<
  CriticalDataColumnIdParameters & {
    @doc("The body associated with the critical data column")
    @query
    entityType: EntityCategory;

    @doc("CriticalDataColumnProperties")
    @bodyRoot
    relationship: CriticalDataColumnProperties;
  },
  RelationshipWrapper
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("CriticalDataColumns")
@doc("Retrieves relationships for a critical data column.")
//@route("/criticalDataColumns/{criticalDataColumnId}/relationships")
@get
op ListCriticalDataColumnRelationshipsAsync is UnifiedCatalogOperations.ResourceList<
  RelationshipWrapper,
  ListQueryParametersTrait<{
    @doc("The body associated with the critical data element output.")
    @query
    entityType: EntityCategory;
  }>
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("CriticalDataColumns")
@doc("Deletes relationships for a critical data column.")
@route("/criticalDataColumns/{criticalDataColumnId}/relationships")
@delete
op DeleteCriticalDataColumnRelationshipAsync is RpcOperation<
  CriticalDataColumnIdParameters & {
    @doc("The body associated with the critical data column")
    @query
    entityType: EntityCategory;

    @doc("The unique identifier of the critical data column.")
    @query
    entityId: uuid;
  },
  DeleteResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataAsset")
@doc("Retrieves a list of data assets.")
@get
op ListDataAssetsAsync is UnifiedCatalogOperations.ResourceList<
  DataAsset,
  ListQueryParametersTrait<SkipQueryParameter &
    TopQueryParameter &
    OrderByQueryParameter>
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataAsset")
@doc("Creates a new data asset.")
@route("/dataAssets")
@post
op CreateDataAssetAsync is RpcOperation<DataAsset, CreateDataAssetResponse>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataAsset")
@doc("Creates a new data asset with fileted query inputs.")
@route("/dataAssets/query")
@post
op QueryDataAssetsAsync is RpcOperation<
  DataAssetQueryRequest,
  DataAssetsResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataAsset")
@doc("Retrieves a data asset by its unique identifier.")
@get
op GetDataAssetByIdAsync is UnifiedCatalogOperations.ResourceRead<DataAsset>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataAsset")
@doc("Updates a data asset by its unique identifier.")
@route("/dataAssets/{dataAssetId}")
@put
op UpdateDataAssetAsync is RpcOperation<
  DataAssetIdParameter & {
    @doc("DataAsset.")
    @bodyRoot
    dataAsset: DataAsset;
  },
  DataAsset
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataAsset")
@doc("Deletes a data asset by its unique identifier.")
@delete
op DeleteDataAssetByIdAsync is UnifiedCatalogOperations.ResourceDelete<DataAsset>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataAsset")
@doc("Retrieves relationships for a data asset.")
@get
op ListDataAssetRelationshipsAsync is UnifiedCatalogOperations.ResourceList<
  DataAssetRelationshipWrapper,
  ListQueryParametersTrait<{
    @doc("The body associated with the critical data element output.")
    @query
    entityType: EntityCategory;
  }>
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataAsset")
@doc("Creates relationships for a data asset.")
@route("/dataAssets/{dataAssetId}/relationships")
@post
op CreateDataAssetRelationshipAsync is RpcOperation<
  DataAssetIdParameter & {
    @doc("The type of entity to retrieve relationships for.")
    @query
    entityType: EntityCategory;

    @doc("The properties of the relationship to create.")
    @bodyRoot
    relationship: CriticalDataColumnRelationshipRequest;
  },
  DataAssetRelationshipWrapper
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataAsset")
@doc("Deletes relationships for a data asset.")
@route("/dataAssets/{dataAssetId}/relationships")
@delete
op DeleteDataAssetRelationshipAsync is RpcOperation<
  DataAssetIdParameter & {
    @doc("The type of entity to retrieve relationships for.")
    @query
    entityType: EntityCategory;

    @doc("The unique identifier of the critical data asset.")
    @query
    entityId: uuid;
  },
  DeleteResponse
>;
