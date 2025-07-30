import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@typespec/http";

using TypeSpec.Http;
using Azure.Core;

namespace PurviewUnifiedCatalog;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Searches and retrieves critical data elements based on domain, keyword, and other filters.")
@route("/criticalDataElements")
@get
op ListCriticalDataElementAsync is Foundations.Operation<
  {
    @doc("Whether to return minimal information for referred Domains.")
    @query
    domainId?: uuid;

    @doc("Search keyword.")
    @query
    keyword: string;

    ...SkipQueryParameter;
    ...TopQueryParameter;
    ...OrderByQueryParameter;
  },
  CriticalDataElementsResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Creates a new critical data element in the catalog.")
@route("/criticalDataElements")
@post
op CreateCriticalDataElementAsync is Foundations.Operation<
  {
    @doc("The critical data element to create.")
    @bodyRoot
    body: CriticalDataElement;
  },
  {
    @statusCode
    statusCode: 201;

    @doc("The created critical data element.")
    @bodyRoot
    body: CriticalDataElement;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Searches and retrieves critical data elements based on Id.")
@route("/criticalDataElements/{criticalDataElementId}")
@get
op GetCriticalDataElementByIdAsync is Foundations.Operation<
  {
    @doc("The unique identifier of the critical data element.")
    @path
    criticalDataElementId: uuid;
  },
  CriticalDataElement
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Updates an existing critical data element in the catalog.")
@route("/criticalDataElements/{criticalDataElementId}")
@put
op UpdateCriticalDataElementAsync is Foundations.Operation<
  {
    @doc("The unique identifier of the critical data element.")
    @path
    criticalDataElementId: uuid;

    @doc("The updated critical data element data.")
    @bodyRoot
    body: CriticalDataElement;
  },
  CriticalDataElement
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Deletes an existing critical data element in the catalog.")
@route("/criticalDataElements/{criticalDataElementId}")
@delete
op DeleteCriticalDataElementByIdAsync is Foundations.Operation<
  {
    @doc("The unique identifier of the critical data element.")
    @path
    criticalDataElementId: uuid;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Retrieves relationships for a critical data element.")
@route("/criticalDataElements/{criticalDataElementId}/relationships")
@get
op ListCriticalDataElementRelationshipsAsync is Foundations.Operation<
  {
    @doc("The unique identifier of the critical data element.")
    @path
    criticalDataElementId: uuid;

    @doc("The body associated with the critical data element output.")
    @query
    entityType: EntityCategory;
  },
  CriticalDataElement
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Updates relationships for a critical data element.")
@route("/criticalDataElements/{criticalDataElementId}/relationships")
@post
op CreateCriticalDataElementRelationshipAsync is Foundations.Operation<
  {
    @doc("The unique identifier of the critical data element.")
    @path
    criticalDataElementId: uuid;

    @doc("The type of entity for the relationship.")
    @query
    entityType: EntityCategory;

    @doc("The input properties for creating the relationship.")
    @bodyRoot
    body: InputProperties;
  },
  CriticalDataElement
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Deletes relationships for a critical data element.")
@route("/criticalDataElements/{criticalDataElementId}/relationships")
@delete
op DeleteCriticalDataElementRelationshipAsync is Foundations.Operation<
  {
    @doc("The unique identifier of the critical data element.")
    @path
    criticalDataElementId: uuid;

    @doc("The type of entity for the relationship.")
    @query
    entityType: EntityCategory;

    @doc("The unique identifier of the related entity.")
    @query
    entityId: uuid;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Queries critical data elements based on various criteria.")
@route("/criticalDataElements/query")
@post
op QueryCriticalDataElementsAsync is Foundations.Operation<
  {
    @doc("The number of duplicate checks to perform.")
    @query
    duplicatecheck?: int32;

    @doc("The request body containing query criteria.")
    @bodyRoot
    body: CriticalDataElementQueryRequest;
  },
  CriticalDataElement
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Retrieves facets for critical data elements.")
@route("/criticalDataElements/facets")
@post
op GetCriticalDataElementFacetsAsync is Foundations.Operation<
  CriticalDataElementFacetRequest,
  FacetsResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("CriticalDataColumns")
@doc("Creates a new critical data column in the catalog.")
@route("/criticalDataColumns")
@post
op CreateCriticalDataColumnAsync is Foundations.Operation<
  {
    @doc("The resource associated with the critical data element.")
    @bodyRoot
    body: CatalogModelCriticalDataColumn;
  },
  {
    @statusCode
    statusCode: 201;

    @doc("The body associated with the critical data column output.")
    @bodyRoot
    body: CatalogModelCriticalDataColumn;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("CriticalDataColumns")
@doc("Searches and retrieves critical data columns based on domain, assetId, and other filters.")
@route("/criticalDataColumns")
@get
op ListCriticalDataColumnAsync is Foundations.Operation<
  {
    @doc("The unique identifier of the critical data column.")
    @query
    domainId?: uuid;

    @doc("The unique identifier of the critical data column.")
    @query
    assetId?: uuid;

    ...SkipQueryParameter;
    ...TopQueryParameter;
    ...OrderByQueryParameter;
  },
  CriticalDataColumnsResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("CriticalDataColumns")
@doc("Searches and retrieves critical data columns based on Id.")
@route("/criticalDataColumns/{criticalDataColumnId}")
@get
op GetCriticalDataColumnByIdAsync is Foundations.Operation<
  {
    @doc("The unique identifier of the critical data column.")
    @path
    criticalDataColumnId: uuid;
  },
  CatalogModelCriticalDataColumn
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("CriticalDataColumns")
@doc("Updates an existing critical data column in the catalog.")
@route("/criticalDataColumns/{criticalDataColumnId}/relationships")
@post
op CreateCriticalDataColumnRelationshipAsync is Foundations.Operation<
  {
    @doc("The unique identifier of the critical data column.")
    @path
    criticalDataColumnId: uuid;

    @doc("The body associated with the critical data column")
    @query
    entityType: EntityCategory;

    @doc("CriticalDataColumnProperties")
    @bodyRoot
    relationship: CriticalDataColumnProperties;
  },
  RelationshipWrappersResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("CriticalDataColumns")
@doc("Retrieves relationships for a critical data column.")
@route("/criticalDataColumns/{criticalDataColumnId}/relationships")
@get
op ListCriticalDataColumnRelationshipsAsync is Foundations.Operation<
  {
    @doc("The unique identifier of the critical data column.")
    @path
    criticalDataColumnId: uuid;

    @doc("The body associated with the critical data column")
    @query
    entityType: EntityCategory;
  },
  RelationshipWrappersResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("CriticalDataColumns")
@doc("Deletes relationships for a critical data column.")
@route("/criticalDataColumns/{criticalDataColumnId}/relationships")
@delete
op DeleteCriticalDataColumnRelationshipAsync is Foundations.Operation<
  {
    @doc("The unique identifier of the critical data column.")
    @query
    criticalDataElementId?: uuid;

    @doc("The body associated with the critical data column")
    @query
    entityType: EntityCategory;

    @doc("The unique identifier of the critical data column.")
    @query
    entityId: uuid;

    @doc("The unique identifier of the critical data column.")
    @path
    criticalDataColumnId: uuid;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataAsset")
@doc("Retrieves a list of data assets.")
@route("/dataAssets")
@get
op ListDataAssetsAsync is Foundations.Operation<
  {
    ...OrderByQueryParameter;
    ...SkipQueryParameter;
    ...TopQueryParameter;
  },
  DataAssetsResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataAsset")
@doc("Creates a new data asset.")
@route("/dataAssets")
@post
op CreateDataAssetAsync is Foundations.Operation<
  CatalogModelDataAsset,
  {
    @statusCode
    statusCode: 201;

    @doc("RelationshipWrapper.")
    @bodyRoot
    body: CatalogModelDataAsset;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataAsset")
@doc("Creates a new data asset with fileted query inputs.")
@route("/dataAssets/query")
@post
op QueryDataAssetsAsync is Foundations.Operation<
  DataAssetDataAssetQueryRequest,
  DataAssetsResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataAsset")
@doc("Retrieves a data asset by its unique identifier.")
@route("/dataAssets/{dataAssetId}")
@get
op GetDataAssetByIdAsync is Foundations.Operation<
  {
    @doc("The unique identifier of the critical data asset.")
    @path
    dataAssetId: uuid;
  },
  CatalogModelDataAsset
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataAsset")
@doc("Updates a data asset by its unique identifier.")
@route("/dataAssets/{dataAssetId}")
@put
op UpdateDataAssetAsync is Foundations.Operation<
  {
    @doc("The unique identifier of the critical data asset.")
    @path
    dataAssetId: uuid;

    @doc("CatalogModelDataAsset.")
    @bodyRoot
    dataAsset: CatalogModelDataAsset;
  },
  CatalogModelDataAsset
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataAsset")
@doc("Deletes a data asset by its unique identifier.")
@route("/dataAssets/{dataAssetId}")
@delete
op DeleteDataAssetByIdAsync is Foundations.Operation<
  {
    @doc("The unique identifier of the critical data asset.")
    @path
    dataAssetId: uuid;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataAsset")
@doc("Retrieves relationships for a data asset.")
@route("/dataAssets/{dataAssetId}/relationships")
@get
op ListDataAssetRelationshipsAsync is Foundations.Operation<
  {
    @doc("The unique identifier of the critical data asset.")
    @path
    dataAssetId: uuid;

    @doc("The type of entity to retrieve relationships for.")
    @query
    entityType: EntityCategory;
  },
  RelationshipWrappersResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataAsset")
@doc("Creates relationships for a data asset.")
@route("/dataAssets/{dataAssetId}/relationships")
@post
op CreateDataAssetRelationshipAsync is Foundations.Operation<
  {
    @doc("The unique identifier of the critical data asset.")
    @path
    dataAssetId: uuid;

    @doc("The type of entity to retrieve relationships for.")
    @query
    entityType: EntityCategory;

    @doc("The properties of the relationship to create.")
    @bodyRoot
    relationship: CriticalDataColumnRelationshipRequest;
  },
  RelationshipWrappersResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataAsset")
@doc("Deletes relationships for a data asset.")
@route("/dataAssets/{dataAssetId}/relationships")
@delete
op DeleteDataAssetRelationshipAsync is Foundations.Operation<
  {
    @doc("The unique identifier of the critical data asset.")
    @path
    dataAssetId: uuid;

    @doc("The type of entity to retrieve relationships for.")
    @query
    entityType: EntityCategory;

    @doc("The unique identifier of the critical data asset.")
    @query
    entityId: uuid;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataProduct")
@doc("Retrieves a list of data products.")
@route("/dataProducts")
@get
op ListDataProductsAsync is Foundations.Operation<
  {
    @doc("The unique identifier of the domain.")
    @query
    domainId?: uuid;

    ...SkipQueryParameter;
    ...TopQueryParameter;
    ...OrderByQueryParameter;
  },
  DataProductResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataProduct")
@doc("Creates a new data product.")
@route("/dataProducts")
@post
op CreateDataProductAsync is Foundations.Operation<
  DataProduct,
  {
    @statusCode
    statusCode: 201;

    @doc("The created data product.")
    @bodyRoot
    body: DataProduct;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataProduct")
@doc("Queries data products based on specified criteria.")
@route("/dataProducts/query")
@post
op QueryDataProductsAsync is Foundations.Operation<
  {
    @doc("To check for duplicate data products.")
    @query
    duplicatecheck?: int32;

    @doc("To filter by data product owner.")
    @query
    dataProductOwner: boolean;

    @doc("The request body for the query.")
    @bodyRoot
    request: DataProductQueryRequest;
  },
  DataProductResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataProduct")
@doc("Retrieves facets for data products.")
@route("/dataProducts/facets")
@post
op GetDataProductFacetsAsync is Foundations.Operation<
  DataProductFacetRequest,
  FacetsResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataProduct")
@doc("Retrieves a data product by its dataProductId.")
@route("/dataProducts/{dataProductId}")
@get
op GetDataProductByIdAsync is Foundations.Operation<
  {
    @doc("The unique identifier of the data product.")
    @path
    dataProductId: uuid;
  },
  DataProduct
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataProduct")
@doc("Updates a data product by its DataProductId.")
@route("/dataProducts/{dataProductId}")
@put
op UpdateDataProductAsync is Foundations.Operation<
  {
    @doc("The unique identifier of the data product.")
    @path
    dataProductId: uuid;

    @doc("The updated data product.")
    @bodyRoot
    body: DataProduct;
  },
  DataProduct
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataProduct")
@doc("Deletes a data product by its dataProductId.")
@route("/dataProducts/{dataProductId}")
@delete
op DeleteDataProductByIdAsync is Foundations.Operation<
  {
    @doc("The unique identifier of the data product.")
    @path
    dataProductId: uuid;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataProduct")
@doc("Retrieves relationships for a data product.")
@route("/dataProducts/{dataProductId}/relationships")
@get
op ListDataProductRelationshipsAsync is Foundations.Operation<
  {
    @doc("The unique identifier of the data product.")
    @path
    dataProductId: uuid;

    @doc("The type of entity to retrieve relationships for.")
    @query
    entityType: EntityCategory;
  },
  RelationshipWrappersResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataProduct")
@doc("Creates a relationship for a data product.")
@route("/dataProducts/{dataProductId}/relationships")
@post
op CreateDataProductRelationshipAsync is Foundations.Operation<
  {
    @doc("The unique identifier of the data product.")
    @path
    dataProductId: uuid;

    @doc("The type of entity to retrieve relationships for.")
    @query
    entityType: EntityCategory;

    @doc("The properties of the relationship to create.")
    @bodyRoot
    relationship: CriticalDataColumnRelationshipRequest;
  },
  RelationshipWrappersResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataProduct")
@doc("Deletes a relationship for a data product.")
@route("/dataProducts/{dataProductId}/relationships")
@delete
op DeleteDataProductRelationshipAsync is Foundations.Operation<
  {
    @doc("The unique identifier of the data product.")
    @path
    dataProductId: uuid;

    @doc("The type of entity to retrieve relationships for.")
    @query
    entityType: EntityCategory;

    @doc("The unique identifier of the critical data asset.")
    @query
    entityId: uuid;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("BusinessDomain")
@doc("Retrieves a list of business domains.")
@route("/businessdomains")
@get
op EnumerateDomainsAsync is Foundations.Operation<
  {
    @doc("skiptoken")
    @query
    $skipToken?: string;

    @doc("writeOnly")
    @query
    writeOnly: boolean;
  },
  DomainResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("BusinessDomain")
@doc("Creates a new business domain.")
@route("/businessdomains")
@post
op CreateDomainAsync is Foundations.Operation<
  Domain,
  {
    @statusCode
    statusCode: 201;

    @doc("The created business domain.")
    @bodyRoot
    body: Domain;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("BusinessDomain")
@doc("Updates an existing business domain.")
@route("/businessdomains/{domainId}")
@put
op UpdateDomainAsync is Foundations.Operation<
  {
    @doc("The unique identifier of the business domain.")
    @path
    domainId: uuid;

    @doc("The updated business domain.")
    @bodyRoot
    body: Domain;
  },
  Domain
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("BusinessDomain")
@doc("Retrieves an existing business domain.")
@route("/businessdomains/{domainId}")
@get
op GetDomainByIdAsync is Foundations.Operation<
  {
    @doc("The unique identifier of the business domain.")
    @path
    domainId: uuid;
  },
  Domain
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("BusinessDomain")
@doc("Deletes an existing business domain.")
@route("/businessdomains/{domainId}")
@delete
op DeleteDomainByIdAsync is Foundations.Operation<
  {
    @doc("The unique identifier of the business domain.")
    @path
    domainId: uuid;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("Term")
@doc("Creates a new term in the catalog.")
@route("/terms")
@post
op CreateTermAsync is Foundations.Operation<
  Term,
  {
    @statusCode
    statusCode: 201;

    @doc("The created term.")
    @bodyRoot
    body: Term;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("Term")
@doc("Retrieves a list of terms based on domain, parentId, keyword, and other filters.")
@route("/terms")
@get
op ListTermAsync is Foundations.Operation<
  {
    @doc("The unique identifier of the domain.")
    @query
    domainId?: uuid;

    @doc("The unique identifier of the parent term.")
    @query
    parentId?: uuid;

    @doc("Search keyword.")
    @query
    keyword: string;

    ...SkipQueryParameter;
    ...TopQueryParameter;

    @doc("The depth of the term.")
    @query
    depth?: int32;

    ...OrderByQueryParameter;
  },
  TermResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("Term")
@doc("Retrieves a term by its unique identifier.")
@route("/terms/{termId}")
@put
op UpdateTermAsync is Foundations.Operation<
  {
    @doc("The unique identifier of the term.")
    @path
    termId: uuid;

    @doc("The updated term data.")
    @bodyRoot
    term: Term;
  },
  Term
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("Term")
@doc("Retrieves a term by its unique identifier.")
@route("/terms/{termId}")
@get
op GetTermAsync is Foundations.Operation<
  {
    @doc("The unique identifier of the term.")
    @path
    termId: uuid;
  },
  Term
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("Term")
@doc("Deletes a term by its unique identifier.")
@route("/terms/{termId}")
@delete
op DeleteTermAsync is Foundations.Operation<
  {
    @doc("The unique identifier of the term.")
    @path
    termId: uuid;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("Term")
@doc("Retrieves terms based on specified criteria.")
@route("/terms/query")
@post
op QueryTermsAsync is Foundations.Operation<
  {
    @doc("To check for duplicate terms.")
    @query
    duplicatecheck?: int32;

    @doc("The request body containing query criteria.")
    @bodyRoot
    request: TermQueryRequest;
  },
  TermResponse
>;
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("Term")
@doc("Retrieves facets for terms.")
@route("/terms/facets")
@post
op GetTermFacetsAsync is Foundations.Operation<
  TermFacetRequest,
  FacetsResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("Term")
@doc("Retrieves hierarchies for a term by its unique identifier.")
@route("/terms/{termId}/hierarchies")
@get
op ListHierarchyTermsAsync is Foundations.Operation<
  {
    @doc("The unique identifier of the term.")
    @path
    termId: uuid;
  },
  TermResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("Term")
@doc("Retrieves relationships for a term by its unique identifier.")
@route("/terms/{termId}/relationships")
@post
op AddRelatedEntityAsync is Foundations.Operation<
  {
    @doc("The unique identifier of the term.")
    @path
    termId: uuid;

    @doc("The type of entity to retrieve relationships for.")
    @query
    entityType: EntityCategory;

    @doc("The type of relationship to retrieve.")
    @bodyRoot
    termRelation: TermRelationship;
  },
  TermRelationship
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("Term")
@doc("Deletes relationships for a term by its unique identifier and specified entity type and relationship type.")
@route("/terms/{termId}/relationships")
@delete
op DeleteRelatedTermAsync is Foundations.Operation<
  {
    @doc("The unique identifier of the term.")
    @path
    termId: uuid;

    @doc("The type of entity to retrieve relationships for.")
    @query
    entityType: EntityCategory;

    @doc("The type of relationship to retrieve.")
    @query
    relationshipType?: TermRelationshipType;

    @doc("The unique identifier of the critical data asset.")
    @query
    entityId: uuid;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("Term")
@doc("Retrieves relationships for a term by its unique identifier and specified entity type and relationship type.")
@route("/terms/{termId}/relationships")
@get
op ListRelatedEntitiesAsync is Foundations.Operation<
  {
    @doc("The unique identifier of the term.")
    @path
    termId: uuid;

    @doc("The type of entity to retrieve relationships for.")
    @query
    entityType: EntityCategory;

    @doc("The type of relationship to retrieve.")
    @query
    relationshipType?: TermRelationshipType;
  },
  TermRelationshipResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("OKR")
@doc("Retrieves a list of objectives (OKRs) based on keyword, domainId, and other filters.")
@route("/objectives")
@get
op ListObjectivesAsync is Foundations.Operation<
  {
    @doc("Search keyword for OKRs.")
    @query
    keyword: string;

    @doc("The unique identifier of the domain.")
    @query
    domainId: string;

    ...OrderByQueryParameter;
    ...SkipQueryParameter;
    ...TopQueryParameter;
  },
  ObjectiveWithAdditionalPropertiesResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("OKR")
@doc("Creates a new objective (OKR).")
@route("/objectives")
@post
op CreateObjectiveAsync is Foundations.Operation<
  ObjectiveWithAdditionalProperties,
  {
    @statusCode
    statusCode: 201;

    @doc("The body associated with the objective output.")
    @bodyRoot
    body: ObjectiveWithAdditionalProperties;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("OKR")
@doc("Queries objectives (OKRs) based on specified criteria.")
@route("/objectives/query")
@post
op QueryObjectivesAsync is Foundations.Operation<
  {
    @doc("Checks for duplicate OKRs.")
    @query
    duplicatecheck?: int32;

    @doc("The request body for querying OKRs.")
    @bodyRoot
    body: ObjectiveQueryRequest;
  },
  ObjectiveWithAdditionalPropertiesResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("OKR")
@doc("Retrieves the facets for objectives (OKRs).")
@route("/objectives/facets")
@post
op GetObjectiveFacetsAsync is Foundations.Operation<
  ObjectiveFacetRequest,
  FacetsResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("OKR")
@doc("Updates an existing objective (OKR) by ID.")
@route("/objectives/{objectiveId}")
@put
op UpdateObjectiveAsync is Foundations.Operation<
  {
    @doc("The unique identifier of the objective (OKR).")
    @path
    objectiveId: uuid;

    @doc("The additional properties for the objective query.")
    @bodyRoot
    objective: ObjectiveQueryAdditionalProperties;
  },
  ObjectiveWithAdditionalProperties
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("OKR")
@doc("Deletes an existing objective (OKR) by ID.")
@route("/objectives/{objectiveId}")
@delete
op DeleteObjectiveByIdAsync is Foundations.Operation<
  {
    @doc("The unique identifier of the objective (OKR).")
    @path
    objectiveId: uuid;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("OKR")
@doc("Retrieves an existing objective (OKR) by ID.")
@route("/objectives/{objectiveId}")
@get
op GetObjectiveByIdAsync is Foundations.Operation<
  {
    @doc("The unique identifier of the objective (OKR).")
    @path
    objectiveId: uuid;
  },
  ObjectiveWithAdditionalProperties
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("OKR")
@doc("Retrieves key results for a specific objective (OKR) by its ID.")
@route("/objectives/{objectiveId}/keyResults")
@get
op ListKeyResultsAsync is Foundations.Operation<
  {
    @doc("The unique identifier of the objective (OKR).")
    @path
    objectiveId: uuid;
  },
  ModelKeyResultResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("OKR")
@doc("Creates a new key result for a specific objective (OKR) by its ID.")
@route("/objectives/{objectiveId}/keyResults")
@post
op CreateKeyResultAsync is Foundations.Operation<
  {
    @doc("The unique identifier of the objective (OKR).")
    @path
    objectiveId: uuid;

    @doc("The body associated with the key result.")
    @bodyRoot
    keyResult: ModelKeyResult;
  },
  {
    @statusCode
    statusCode: 201;

    @doc("The body associated with the key result output.")
    @bodyRoot
    body: ModelKeyResult;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("OKR")
@doc("Retrieves a specific key result (OKR) by its ID.")
@route("/objectives/{objectiveId}/keyResults/{keyResultId}")
@get
op GetKeyResultByIdAsync is Foundations.Operation<
  {
    @doc("The unique identifier of the objective (OKR).")
    @path
    objectiveId: uuid;

    @doc("The unique identifier of the key result (OKR).")
    @path
    keyResultId: uuid;
  },
  CatalogModelKeyResult
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("OKR")
@doc("Updates an existing key result (OKR) by its ID.")
@route("/objectives/{objectiveId}/keyResults/{keyResultId}")
@put
op UpdateKeyResultAsync is Foundations.Operation<
  {
    @doc("The unique identifier of the objective (OKR).")
    @path
    objectiveId: uuid;

    @doc("The unique identifier of the key result (OKR).")
    @path
    keyResultId: uuid;

    @doc("The body associated with the key result output.")
    @bodyRoot
    keyResult: CatalogModelKeyResult;
  },
  CatalogModelKeyResultResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("OKR")
@doc("Deletes an existing key result (OKR) by ID.")
@route("/objectives/{objectiveId}/keyResults/{keyResultId}")
@delete
op DeleteKeyResultByIdAsync is Foundations.Operation<
  {
    @doc("The unique identifier of the objective (OKR).")
    @path
    objectiveId: uuid;

    @doc("The unique identifier of the key result (OKR).")
    @path
    keyResultId: uuid;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("OKR")
@doc("Deletes an existing relationship for a specific objective (OKR) by its ID.")
@route("/objectives/{objectiveId}/relationships")
@delete
op deleteOkrObjectiveIdRelationships is Foundations.Operation<
  {
    @doc("The unique identifier of the objective (OKR).")
    @path
    objectiveId: string;

    @doc("The type of entity to retrieve relationships for.")
    @query
    entityType: string;

    @doc("The unique identifier of the entity.")
    @query
    entityId: EntityCategory;

    @doc("The type of relationship to delete.")
    @query
    relationshipType: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("OKR")
@doc("Retrieves all relationships for a specific objective (OKR) by its ID.")
@route("/objectives/{objectiveId}/relationships")
@get
op listOkrRelationships is Foundations.Operation<
  {
    @doc("Retrieves all relationships for a specific objective (OKR) by its ID.")
    @path
    objectiveId: string;

    @doc("The type of entity to retrieve relationships for.")
    @query
    entityType: EntityCategory;
  },
  RelationshipWrappersResponse
>;
