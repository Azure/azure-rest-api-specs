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
op ListCriticalDataElement is UnifiedCatalogOperations.ResourceList<
  CriticalDataElement,
  ListQueryParametersTrait<{
    @doc("Whether to return minimal information for referred Domains.")
    @query
    domainId?: uuid;

    @doc("Search keyword.")
    @query
    keyword?: string;

    @doc("Expressions that specify the order of returned results.")
    @query
    orderBy?: string;
  } & SkipQueryParameter &
    TopQueryParameter>
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Creates a new critical data element in the catalog.")
@route("/criticalDataElements")
@post
op CreateCriticalDataElement is RpcOperation<
  {
    @doc("the critical data element to update.")
    @body
    criticalDataElement: CriticalDataElement;
  },
  CreateCriticalDataElementResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Searches and retrieves critical data elements based on Id.")
@get
op GetCriticalDataElementById is UnifiedCatalogOperations.ResourceRead<CriticalDataElement>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Updates an existing critical data element in the catalog.")
@route("/criticalDataElements/{criticalDataElementId}")
@put
op UpdateCriticalDataElement is RpcOperation<
  {
    @doc("the critical data element to update.")
    @body
    criticalDataElement: CriticalDataElement;
  } & CriticalDataElementIdParameters,
  CriticalDataElement
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Deletes an existing critical data element in the catalog.")
@delete
op DeleteCriticalDataElementById is UnifiedCatalogOperations.ResourceDelete<CriticalDataElement>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Lists relationships for the specified CDE and entity category.")
@get
op ListCriticalDataElementRelationships is UnifiedCatalogOperations.ResourceList<
  CdeRelationship,
  ListQueryParametersTrait<{
    @doc("The body associated with the critical data element output.")
    @query
    entityType: EntityCategory;
  }>
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Creates a relationship between the specified CDE and another entity.")
@route("/criticalDataElements/{criticalDataElementId}/relationships")
@post
op CreateCriticalDataElementRelationship is RpcOperation<
  CriticalDataElementIdParameters & {
    @doc("The type of entity for the relationship.")
    @query
    entityType?: EntityCategory;

    @doc("The input properties for creating the relationship.")
    @bodyRoot
    relationship: DataElementProperties;
  },
  CdcRelationship
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Deletes a relationship between the CDE and the specified entity.")
@route("/criticalDataElements/{criticalDataElementId}/relationships")
@delete
op DeleteCriticalDataElementRelationship is RpcOperation<
  CriticalDataElementIdParameters & {
    @doc("The type of entity for the relationship.")
    @query
    entityType?: EntityCategory;

    @doc("The unique identifier of the related entity.")
    @query
    entityId?: uuid;
  },
  DeleteResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Queries critical data elements based on various criteria.")
@route("/criticalDataElements/query")
@list
@post
op QueryCriticalDataElements is RpcOperation<
  {
    @doc("The request body containing query criteria.")
    @bodyRoot
    request: CriticalDataElementQueryRequest;
  },
  CriticalDataElementsResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Retrieves facets for critical data elements.")
@route("/criticalDataElements/facets")
@post
op GetCriticalDataElementFacets is RpcOperation<
  {
    @doc("The request body containing query criteria.")
    @bodyRoot
    request: CriticalDataElementFacetRequest;
  },
  FacetsResponse
>;

// #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
// #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
// @tag("CriticalDataColumns")
// @doc("Creates a new critical data column in the catalog.")
// @route("/criticalDataColumns")
// @post
// op CreateCriticalDataColumn is RpcOperation<
//   CreateCriticalDataColumnRequest,
//   CreateCriticalDataColumnResponse
// >;

// #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
// #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
// @tag("CriticalDataColumns")
// @doc("Searches and retrieves critical data columns based on domain, assetId, and other filters.")
// @get
// op ListCriticalDataColumn is UnifiedCatalogOperations.ResourceList<
//   CriticalDataColumn,
//   ListQueryParametersTrait<{
//     @doc("The unique identifier of the critical data column.")
//     @query
//     domainId?: uuid;

//     @doc("The unique identifier of the critical data column.")
//     @query
//     assetId?: uuid;

//     @doc("Expressions that specify the order of returned results.")
//     @query
//     orderBy?: string;
//   } & SkipQueryParameter &
//     TopQueryParameter>
// >;

// #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
// #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
// @tag("CriticalDataColumns")
// @doc("Searches and retrieves critical data columns based on Id.")
// @get
// op GetCriticalDataColumnById is UnifiedCatalogOperations.ResourceRead<CriticalDataColumn>;

// #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
// #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
// @tag("CriticalDataColumns")
// @doc("Updates an existing critical data column in the catalog.")
// @route("/criticalDataColumns/{criticalDataColumnId}/relationships")
// @post
// op CreateCriticalDataColumnRelationship is RpcOperation<
//   CriticalDataColumnIdParameters & {
//     @doc("The body associated with the critical data column")
//     @query
//     entityType: EntityCategory;

//     @doc("CriticalDataColumnProperties")
//     @bodyRoot
//     relationship: CriticalDataColumnProperties;
//   },
//   CdcRelationship
// >;

// #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
// #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
// @tag("CriticalDataColumns")
// @doc("Retrieves relationships for a critical data column.")
// //@route("/criticalDataColumns/{criticalDataColumnId}/relationships")
// @get
// op ListCriticalDataColumnRelationships is UnifiedCatalogOperations.ResourceList<
//   CdcRelationship,
//   ListQueryParametersTrait<{
//     @doc("The body associated with the critical data element output.")
//     @query
//     entityType: EntityCategory;
//   }>
// >;

// #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
// #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
// @tag("CriticalDataColumns")
// @doc("Deletes relationships for a critical data column.")
// @route("/criticalDataColumns/{criticalDataColumnId}/relationships")
// @delete
// op DeleteCriticalDataColumnRelationship is RpcOperation<
//   CriticalDataColumnIdParameters & {
//     @doc("The body associated with the critical data column")
//     @query
//     entityType: EntityCategory;

//     @doc("The unique identifier of the critical data column.")
//     @query
//     entityId?: uuid;

//     @doc("The identifier of the critical data element.")
//     @query
//     criticalDataElementId?: uuid;
//   },
//   DeleteResponse
// >;

// #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
// #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
// @tag("DataAsset")
// @doc("Lists data assets with optional ordering and pagination.")
// @get
// op ListDataAssets is UnifiedCatalogOperations.ResourceList<
//   DataAsset,
//   ListQueryParametersTrait<{
//     @doc("Expressions that specify the order of returned results.")
//     @query
//     orderBy?: string;
//   } & SkipQueryParameter &
//     TopQueryParameter>
// >;

// #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
// #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
// @tag("DataAsset")
// @doc("Creates a new data asset.")
// @route("/dataAssets")
// @post
// op CreateDataAsset is RpcOperation<
//   {
//     @doc("The data asset payload")
//     @bodyRoot
//     dataAsset: DataAsset;
//   },
//   CreateDataAssetResponse
// >;

// #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
// #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
// @tag("DataAsset")
// @doc("Creates a new data asset with fileted query inputs.")
// @route("/dataAssets/query")
// @list
// @post
// op QueryDataAssets is RpcOperation<
//   {
//     @doc("The data asset payload")
//     @bodyRoot
//     request: DataAssetQueryRequest;
//   },
//   DataAssetsResponse
// >;

// #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
// #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
// @tag("DataAsset")
// @doc("Retrieves a data asset by its unique identifier.")
// @get
// op GetDataAssetById is UnifiedCatalogOperations.ResourceRead<DataAsset>;

// #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
// #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
// @tag("DataAsset")
// @doc("Updates a data asset by its unique identifier.")
// @route("/dataAssets/{dataAssetId}")
// @put
// op UpdateDataAsset is RpcOperation<
//   DataAssetIdParameter & {
//     @doc("Updated data asset payload.")
//     @bodyRoot
//     dataAsset: DataAsset;
//   },
//   DataAsset
// >;

// #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
// #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
// @tag("DataAsset")
// @doc("Deletes a data asset by its unique identifier.")
// @delete
// op DeleteDataAssetById is UnifiedCatalogOperations.ResourceDelete<DataAsset>;

// #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
// #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
// @tag("DataAsset")
// @doc("Lists relationships for a data asset filtered by entity category.")
// @get
// op ListDataAssetRelationships is UnifiedCatalogOperations.ResourceList<
//   DataAssetRelationship,
//   ListQueryParametersTrait<{
//     @doc("Required entity category to list relationships for.")
//     @query
//     entityType: EntityCategory;
//   }>
// >;

// #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
// #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
// @tag("DataAsset")
// @doc("Creates a relationship between the specified data asset and another entity.")
// @route("/dataAssets/{dataAssetId}/relationships")
// @post
// op CreateDataAssetRelationship is RpcOperation<
//   DataAssetIdParameter & {
//     @doc("Category of the entity to relate to (required).")
//     @query
//     entityType: EntityCategory;

//     @doc("Relationship payload as JSON (required).")
//     @bodyRoot
//     relationship: CriticalDataColumnRelationshipRequest;
//   },
//   DataAssetRelationship
// >;

// #suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
// #suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
// @tag("DataAsset")
// @doc("Deletes relationships for a data asset.")
// @route("/dataAssets/{dataAssetId}/relationships")
// @delete
// op DeleteDataAssetRelationship is RpcOperation<
//   DataAssetIdParameter & {
//     @doc("Category of the related entity (required).")
//     @query
//     entityType: EntityCategory;

//     @doc("Identifier of the related entity (required).")
//     @query
//     entityId: uuid;
//   },
//   DeleteResponse
// >;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataProduct")
@doc("Lists data products with optional domain filter, sorting and pagination.")
@get
op ListDataProducts is UnifiedCatalogOperations.ResourceList<
  DataProduct,
  ListQueryParametersTrait<SkipQueryParameter &
    TopQueryParameter & {
      @doc("Optional domain identifier filter.")
      @query
      domainId?: uuid;

      @doc("Expressions that specify the order of returned results.")
      @query
      orderBy?: string;
    }>
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataProduct")
@doc("Creates a new data product.")
@route("/dataProducts")
@post
op CreateDataProduct is RpcOperation<
  {
    @doc("The data product payload.")
    @bodyRoot
    dataProduct: DataProduct;
  },
  CreateDataProductResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataProduct")
@doc("Queries data products using the provided filter payload.")
@route("/dataProducts/query")
@list
@post
op QueryDataProducts is RpcOperation<
  {
    @doc("Optional flag to restrict results to owned data products.")
    @query
    dataProductOwner?: boolean;

    @doc("Query request containing filters and pagination.")
    @bodyRoot
    request: DataProductQueryRequest;
  },
  DataProductResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataProduct")
@doc("Retrieves facets for data products based on the supplied facets request.")
@route("/dataProducts/facets")
@post
op GetDataProductFacets is RpcOperation<
  {
    @doc("Facet request specifying which facets to compute.")
    @bodyRoot
    request: DataProductFacetRequest;
  },
  FacetsResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataProduct")
@doc("Retrieves a data product by its dataProductId.")
@get
op GetDataProductById is UnifiedCatalogOperations.ResourceRead<DataProduct>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataProduct")
@doc("Updates a data product by its DataProductId.")
@route("/dataProducts/{dataProductId}")
@put
op UpdateDataProduct is RpcOperation<
  DataProductIdParameter & {
    @doc("Updated data product payload.")
    @bodyRoot
    dataProduct: DataProduct;
  },
  DataProduct
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataProduct")
@doc("Deletes a data product by its dataProductId.")
@delete
op DeleteDataProductById is UnifiedCatalogOperations.ResourceDelete<DataProduct>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataProduct")
@doc("Lists relationships for a data product filtered by entity category.")
@get
op ListDataProductRelationships is UnifiedCatalogOperations.ResourceList<
  DataProductRelationship,
  ListQueryParametersTrait<{
    @doc("Required entity category to list relationships for.")
    @query
    entityType?: EntityCategory;
  }>
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataProduct")
@doc("Creates a relationship for a data product.")
@route("/dataProducts/{dataProductId}/relationships")
@post
op CreateDataProductRelationship is RpcOperation<
  DataProductIdParameter & {
    @doc("Category of the entity to relate to (required).")
    @query
    entityType: EntityCategory;

    @doc("Relationship payload as JSON.")
    @bodyRoot
    relationship: CriticalDataColumnRelationshipRequest;
  },
  DataProductRelationship
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataProduct")
@doc("Deletes a relationship between the data product and a specified entity.")
@route("/dataProducts/{dataProductId}/relationships")
@delete
op DeleteDataProductRelationship is RpcOperation<
  DataProductIdParameter & {
    @doc("Category of the related entity (required).")
    @query
    entityType: EntityCategory;

    @doc("Identifier of the related entity (required).")
    @query
    entityId: uuid;
  },
  DeleteResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("BusinessDomain")
@doc("Enumerates business domains with optional continuation token and write-obligation filtering.")
@get
op EnumerateDomains is UnifiedCatalogOperations.ResourceList<
  Domain,
  ListQueryParametersTrait<{
    @doc("skiptoken")
    @query("$skipToken")
    skipToken?: string;

    @doc("writeOnly")
    @query
    writeOnly?: boolean;
  }>
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("BusinessDomain")
@doc("Creates a new business domain.")
@route("/businessdomains")
@post
op CreateDomain is RpcOperation<
  {
    @doc("Domain payload to create.")
    @bodyRoot
    domain: Domain;
  },
  CreateDomainResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("BusinessDomain")
@doc("Updates an existing business domain.")
@route("/businessdomains/{domainId}")
@put
op UpdateDomain is RpcOperation<
  DomainIdParameter & {
    @doc("Updated domain payload.")
    @bodyRoot
    domain: Domain;
  },
  Domain
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("BusinessDomain")
@doc("Retrieves a business domain by identifier.")
@get
op GetDomainById is UnifiedCatalogOperations.ResourceRead<Domain>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("BusinessDomain")
@doc("Deletes an existing business domain.")
@delete
op DeleteDomainById is UnifiedCatalogOperations.ResourceDelete<Domain>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("Term")
@doc("Creates a new term in the catalog.")
@route("/terms")
@post
op CreateTerm is RpcOperation<
  {
    @doc("Term payload.")
    @bodyRoot
    term: Term;
  },
  CreateTermResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("Term")
@doc("Lists terms with optional domain/parent/keyword filters and pagination.")
@get
op ListTerm is UnifiedCatalogOperations.ResourceList<
  Term,
  ListQueryParametersTrait<SkipQueryParameter &
    TopQueryParameter & {
      @doc("The unique identifier of the domain.")
      @query
      domainId?: uuid;

      @doc("The unique identifier of the parent term.")
      @query
      parentId?: uuid;

      @doc("Search keyword.")
      @query
      keyword?: string;

      @doc("The depth of the term.")
      @query
      depth?: int32;

      @doc("Expressions that specify the order of returned results.")
      @query
      orderBy?: string;
    }>
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("Term")
@doc("Updates an existing term")
@route("/terms/{termId}")
@put
op UpdateTerm is RpcOperation<
  TermIdParameter & {
    @doc("Updated term payload.")
    @bodyRoot
    term: Term;
  },
  Term
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("Term")
@doc("Retrieves a single term by identifier.")
@get
op GetTerm is UnifiedCatalogOperations.ResourceRead<Term>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("Term")
@doc("Deletes a term by its unique identifier.")
@delete
op DeleteTerm is UnifiedCatalogOperations.ResourceDelete<Term>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("Term")
@doc("Queries terms based on the provided request.")
@route("/terms/query")
@list
@post
op QueryTerms is RpcOperation<
  {
    @doc("The request body containing query criteria.")
    @bodyRoot
    request: TermQueryRequest;
  },
  TermResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("Term")
@doc("Retrieves facets for terms.")
@route("/terms/facets")
@post
op GetTermFacets is RpcOperation<
  {
    @doc("Facet request specifying which facets to compute.")
    @bodyRoot
    request: TermFacetRequest;
  },
  FacetsResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("Term")
@doc("Lists hierarchical terms under the specified term id.")
@route("/terms/{termId}/hierarchies")
@list
@get
op ListHierarchyTerms is RpcOperation<TermIdParameter, TermResponse>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("Term")
@doc("Adds a related entity to a term.")
@route("/terms/{termId}/relationships")
@post
op AddRelatedEntity is RpcOperation<
  TermIdParameter & {
    @doc("The type of entity to retrieve relationships for.")
    @query
    entityType?: EntityCategory;

    @doc("Relationship payload.")
    @bodyRoot
    termRelation: TermRelationship;
  },
  TermRelationship
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("Term")
@doc("Deletes a related entity from a term.")
@route("/terms/{termId}/relationships")
@delete
op DeleteRelatedTerm is RpcOperation<
  TermIdParameter & {
    @doc("The type of entity to retrieve relationships for.")
    @query
    entityType?: EntityCategory;

    @doc("Optional relationship type.")
    @query
    relationshipType?: TermRelationshipType;

    @doc("Related entity identifier.")
    @query
    entityId?: uuid;
  },
  DeleteResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("Term")
@doc("Lists related entities for a term by category and optional relationship type.")
@get
op ListRelatedEntities is UnifiedCatalogOperations.ResourceList<
  TermRelationship,
  ListQueryParametersTrait<{
    @doc("The type of entity to retrieve relationships for.")
    @query
    entityType?: EntityCategory;

    @doc("Optional relationship type.")
    @query
    relationshipType?: TermRelationshipType;
  }>
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("OKR")
@doc("Lists objectives with optional filters, sorting and pagination.")
@get
op ListObjectives is UnifiedCatalogOperations.ResourceList<
  ObjectiveWithAdditionalProperties,
  ListQueryParametersTrait<SkipQueryParameter &
    TopQueryParameter & {
      @doc("Optional search keyword to match objective definition.")
      @query
      keyword?: string;

      @doc("Optional domain identifier filter.")
      @query
      domainId?: string;

      @doc("Expressions that specify the order of returned results.")
      @query
      orderBy?: string;
    }>
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("OKR")
@doc("Creates a new objective (OKR).")
@route("/objectives")
@post
op CreateObjective is RpcOperation<
  {
    @doc("The objective payload, including additional properties.")
    @bodyRoot
    objective: ObjectiveWithAdditionalProperties;
  },
  CreateObjectiveResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("OKR")
@doc("Queries objectives (OKRs) based on specified criteria.")
@route("/objectives/query")
@list
@post
op QueryObjectives is RpcOperation<
  {
    @doc("Query request containing filters and pagination.")
    @bodyRoot
    request: ObjectiveQueryRequest;
  },
  ObjectiveWithAdditionalPropertiesResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("OKR")
@doc("Retrieves the facets for objectives (OKRs).")
@route("/objectives/facets")
@post
op GetObjectiveFacets is RpcOperation<
  {
    @doc("Facet request specifying which facets to compute.")
    @bodyRoot
    request: ObjectiveFacetRequest;
  },
  FacetsResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("OKR")
@doc("Updates an existing objective (OKR) by ID.")
@route("/objectives/{objectiveId}")
@put
op UpdateObjective is RpcOperation<
  ObjectiveIdParameter & {
    @doc("Updated objective payload.")
    @bodyRoot
    objective: ObjectiveQueryAdditionalProperties;
  },
  ObjectiveWithAdditionalProperties
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("OKR")
@doc("Deletes an objective by identifier.")
@delete
op DeleteObjectiveById is UnifiedCatalogOperations.ResourceDelete<ObjectiveWithAdditionalProperties>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("OKR")
@doc("Retrieves an objective by identifier.")
@get
op GetObjectiveById is UnifiedCatalogOperations.ResourceRead<ObjectiveWithAdditionalProperties>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("OKR")
@doc("Lists key results for a given objective.")
@get
op ListKeyResults is UnifiedCatalogOperations.ResourceList<KeyResult>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("OKR")
@doc("Creates a key result under the specified objective.")
@route("/objectives/{objectiveId}/keyResults")
@post
op CreateKeyResult is RpcOperation<
  ObjectiveIdParameter & {
    @doc("Key result payload.")
    @bodyRoot
    keyResult: KeyResult;
  },
  CreateKeyResultResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("OKR")
@doc("Retrieves a key result by its identifier under the specified objective")
@route("/objectives/{objectiveId}/keyResults/{keyResultId}")
@get
op GetKeyResultById is RpcOperation<GetKeyResultParameter, KeyResult>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("OKR")
@doc("Updates a key result under the specified objective.")
@route("/objectives/{objectiveId}/keyResults/{keyResultId}")
@list
@put
op UpdateKeyResult is RpcOperation<
  GetKeyResultParameter & {
    @doc("Updated key result payload.")
    @bodyRoot
    keyResult: CatalogModelKeyResult;
  },
  CatalogModelKeyResultResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("OKR")
@doc("Deletes a key result by its identifier under the specified objective.")
@route("/objectives/{objectiveId}/keyResults/{keyResultId}")
@delete
op DeleteKeyResultById is RpcOperation<GetKeyResultParameter, DeleteResponse>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("Policy")
@route("/policies")
@doc("Lists policies with optional continuation token.")
@get
op ListPolicies is RpcOperation<
  {
    @doc("Optional continuation token.")
    @query
    skipToken?: string;
  },
  CatalogResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("Policy")
@doc("Updates a policy by its identifier.")
@route("/policies/{policyId}")
@put
op UpdatePolicy is RpcOperation<
  PolicyIdParameters & {
    @doc("Updated policy payload.")
    @bodyRoot
    request: CatalogValue;
  },
  CatalogValue
>;
