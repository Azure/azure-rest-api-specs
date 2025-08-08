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
@list
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
@list
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

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataProduct")
@doc("Retrieves a list of data products.")
@get
op ListDataProductsAsync is UnifiedCatalogOperations.ResourceList<
  DataProduct,
  ListQueryParametersTrait<SkipQueryParameter &
    TopQueryParameter &
    OrderByQueryParameter & {
      @doc("The unique identifier of the domain.")
      @query
      domainId?: uuid;
    }>
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataProduct")
@doc("Creates a new data product.")
@route("/dataProducts")
@post
op CreateDataProductAsync is RpcOperation<
  DataProduct,
  CreateDataProductResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataProduct")
@doc("Queries data products based on specified criteria.")
@route("/dataProducts/query")
@list
@post
op QueryDataProductsAsync is RpcOperation<
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

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataProduct")
@doc("Retrieves facets for data products.")
@route("/dataProducts/facets")
@post
op GetDataProductFacetsAsync is RpcOperation<
  DataProductFacetRequest,
  FacetsResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataProduct")
@doc("Retrieves a data product by its dataProductId.")
@get
op GetDataProductByIdAsync is UnifiedCatalogOperations.ResourceRead<DataProduct>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataProduct")
@doc("Updates a data product by its DataProductId.")
@route("/dataProducts/{dataProductId}")
@put
op UpdateDataProductAsync is RpcOperation<
  DataProductIdParameter & {
    @doc("The updated data product.")
    @bodyRoot
    body: DataProduct;
  },
  DataProduct
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataProduct")
@doc("Deletes a data product by its dataProductId.")
@delete
op DeleteDataProductByIdAsync is UnifiedCatalogOperations.ResourceDelete<DataProduct>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataProduct")
@doc("Retrieves relationships for a data product.")
@get
op ListDataProductRelationshipsAsync is UnifiedCatalogOperations.ResourceList<
  DataProductRelationshipWrapper,
  ListQueryParametersTrait<{
    @doc("The type of entity to retrieve relationships for.")
    @query
    entityType: EntityCategory;
  }>
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataProduct")
@doc("Creates a relationship for a data product.")
@route("/dataProducts/{dataProductId}/relationships")
@post
op CreateDataProductRelationshipAsync is RpcOperation<
  DataProductIdParameter & {
    @doc("The type of entity to retrieve relationships for.")
    @query
    entityType: EntityCategory;

    @doc("The properties of the relationship to create.")
    @bodyRoot
    relationship: CriticalDataColumnRelationshipRequest;
  },
  DataProductRelationshipWrapper
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("DataProduct")
@doc("Deletes a relationship for a data product.")
@route("/dataProducts/{dataProductId}/relationships")
@delete
op DeleteDataProductRelationshipAsync is RpcOperation<
  DataProductIdParameter & {
    @doc("The type of entity to retrieve relationships for.")
    @query
    entityType: EntityCategory;

    @doc("The unique identifier of the critical data asset.")
    @query
    entityId: uuid;
  },
  DeleteResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("BusinessDomain")
@doc("Retrieves a list of business domains.")
@get
op EnumerateDomainsAsync is UnifiedCatalogOperations.ResourceList<
  Domain,
  ListQueryParametersTrait<{
    @doc("skiptoken")
    @query("$skipToken")
    skipToken?: string;

    @doc("writeOnly")
    @query
    writeOnly: boolean;
  }>
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("BusinessDomain")
@doc("Creates a new business domain.")
@route("/businessdomains")
@post
op CreateDomainAsync is RpcOperation<Domain, CreateDomainResponse>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("BusinessDomain")
@doc("Updates an existing business domain.")
@route("/businessdomains/{domainId}")
@put
op UpdateDomainAsync is RpcOperation<
  DomainIdParameter & {
    @doc("The updated business domain.")
    @bodyRoot
    body: Domain;
  },
  Domain
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("BusinessDomain")
@doc("Retrieves an existing business domain.")
@get
op GetDomainByIdAsync is UnifiedCatalogOperations.ResourceRead<Domain>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("BusinessDomain")
@doc("Deletes an existing business domain.")
@delete
op DeleteDomainByIdAsync is UnifiedCatalogOperations.ResourceDelete<Domain>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("Term")
@doc("Creates a new term in the catalog.")
@route("/terms")
@post
op CreateTermAsync is RpcOperation<Term, CreateTermResponse>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("Term")
@doc("Retrieves a list of terms based on domain, parentId, keyword, and other filters.")
@get
op ListTermAsync is UnifiedCatalogOperations.ResourceList<
  Term,
  ListQueryParametersTrait<SkipQueryParameter &
    TopQueryParameter &
    OrderByQueryParameter & {
      @doc("The unique identifier of the domain.")
      @query
      domainId?: uuid;

      @doc("The unique identifier of the parent term.")
      @query
      parentId?: uuid;

      @doc("Search keyword.")
      @query
      keyword: string;

      @doc("The depth of the term.")
      @query
      depth?: int32;
    }>
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("Term")
@doc("Retrieves a term by its unique identifier.")
@route("/terms/{termId}")
@put
op UpdateTermAsync is RpcOperation<
  TermIdParameter & {
    @doc("The updated term data.")
    @bodyRoot
    term: Term;
  },
  Term
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("Term")
@doc("Retrieves a term by its unique identifier.")
@get
op GetTermAsync is UnifiedCatalogOperations.ResourceRead<Term>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("Term")
@doc("Deletes a term by its unique identifier.")
@delete
op DeleteTermAsync is UnifiedCatalogOperations.ResourceDelete<Term>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("Term")
@doc("Retrieves terms based on specified criteria.")
@route("/terms/query")
@list
@post
op QueryTermsAsync is RpcOperation<
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

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("Term")
@doc("Retrieves facets for terms.")
@route("/terms/facets")
@post
op GetTermFacetsAsync is RpcOperation<TermFacetRequest, FacetsResponse>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("Term")
@doc("Retrieves hierarchies for a term by its unique identifier.")
@route("/terms/{termId}/hierarchies")
@list
@get
op ListHierarchyTermsAsync is RpcOperation<TermIdParameter, TermResponse>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("Term")
@doc("Retrieves relationships for a term by its unique identifier.")
@route("/terms/{termId}/relationships")
@post
op AddRelatedEntityAsync is RpcOperation<
  TermIdParameter & {
    @doc("The type of entity to retrieve relationships for.")
    @query
    entityType: EntityCategory;

    @doc("The type of relationship to retrieve.")
    @bodyRoot
    termRelation: TermRelationship;
  },
  TermRelationship
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("Term")
@doc("Deletes relationships for a term by its unique identifier and specified entity type and relationship type.")
@route("/terms/{termId}/relationships")
@delete
op DeleteRelatedTermAsync is RpcOperation<
  TermIdParameter & {
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
  DeleteResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("Term")
@doc("Retrieves relationships for a term by its unique identifier and specified entity type and relationship type.")
@get
op ListRelatedEntitiesAsync is UnifiedCatalogOperations.ResourceList<
  TermRelationship,
  ListQueryParametersTrait<{
    @doc("The type of entity to retrieve relationships for.")
    @query
    entityType: EntityCategory;

    @doc("The type of relationship to retrieve.")
    @query
    relationshipType?: TermRelationshipType;
  }>
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("OKR")
@doc("Retrieves a list of objectives (OKRs) based on keyword, domainId, and other filters.")
@get
op ListObjectivesAsync is UnifiedCatalogOperations.ResourceList<
  ObjectiveWithAdditionalProperties,
  ListQueryParametersTrait<SkipQueryParameter &
    TopQueryParameter &
    OrderByQueryParameter & {
      @doc("Search keyword for OKRs.")
      @query
      keyword: string;

      @doc("The unique identifier of the domain.")
      @query
      domainId?: string;
    }>
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("OKR")
@doc("Creates a new objective (OKR).")
@route("/objectives")
@post
op CreateObjectiveAsync is RpcOperation<
  ObjectiveWithAdditionalProperties,
  CreateObjectiveResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("OKR")
@doc("Queries objectives (OKRs) based on specified criteria.")
@route("/objectives/query")
@list
@post
op QueryObjectivesAsync is RpcOperation<
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

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("OKR")
@doc("Retrieves the facets for objectives (OKRs).")
@route("/objectives/facets")
@post
op GetObjectiveFacetsAsync is RpcOperation<
  ObjectiveFacetRequest,
  FacetsResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("OKR")
@doc("Updates an existing objective (OKR) by ID.")
@route("/objectives/{objectiveId}")
@put
op UpdateObjectiveAsync is RpcOperation<
  ObjectiveIdParameter & {
    @doc("The additional properties for the objective query.")
    @bodyRoot
    objective: ObjectiveQueryAdditionalProperties;
  },
  ObjectiveWithAdditionalProperties
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("OKR")
@doc("Deletes an existing objective (OKR) by ID.")
@delete
op DeleteObjectiveByIdAsync is UnifiedCatalogOperations.ResourceDelete<ObjectiveWithAdditionalProperties>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("OKR")
@doc("Retrieves an existing objective (OKR) by ID.")
@get
op GetObjectiveByIdAsync is UnifiedCatalogOperations.ResourceRead<ObjectiveWithAdditionalProperties>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("OKR")
@doc("Retrieves key results for a specific objective (OKR) by its ID.")
@get
op ListKeyResultsAsync is UnifiedCatalogOperations.ResourceList<KeyResult>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("OKR")
@doc("Creates a new key result for a specific objective (OKR) by its ID.")
@route("/objectives/{objectiveId}/keyResults")
@post
op CreateKeyResultAsync is RpcOperation<
  ObjectiveIdParameter & {
    @doc("The body associated with the key result.")
    @bodyRoot
    keyResult: KeyResult;
  },
  CreateKeyResultResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("OKR")
@doc("Retrieves a specific key result (OKR) by its ID.")
@route("/objectives/{objectiveId}/keyResults/{keyResultId}")
@get
op GetKeyResultByIdAsync is RpcOperation<GetKeyResultParameter, KeyResult>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("OKR")
@doc("Updates an existing key result (OKR) by its ID.")
@route("/objectives/{objectiveId}/keyResults/{keyResultId}")
@list
@put
op UpdateKeyResultAsync is RpcOperation<
  GetKeyResultParameter & {
    @doc("The body associated with the key result output.")
    @bodyRoot
    keyResult: CatalogModelKeyResult;
  },
  CatalogModelKeyResultResponse
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-names" "This is an existing service operation."
#suppress "@azure-tools/typespec-azure-core/casing-style" "This is an existing service operation."
@tag("OKR")
@doc("Deletes an existing key result (OKR) by ID.")
@route("/objectives/{objectiveId}/keyResults/{keyResultId}")
@delete
op DeleteKeyResultByIdAsync is RpcOperation<
  GetKeyResultParameter,
  DeleteResponse
>;
