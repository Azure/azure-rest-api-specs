import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;
using Azure.Core.Foundations;

namespace PurviewDataCatalog;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Searches and retrieves critical data elements based on domain, keyword, and other filters.")
@route("/criticalDataElements")
@get
op getCriticalDataElements is Foundations.Operation<
  {
    @doc("Whether to return minimal information for referred Domains.")
    @query
    domainId?: string;

    @doc("Search keyword.")
    @query
    keyword?: string;

    @doc("Number of items to skip.")
    @query
    skip?: int32;

    @doc("Number of items to return.")
    @query
    top?: int32;

    @doc("Field to sort by.")
    @query
    orderby?: string;
  },
  CriticalDataElementsResponse,
  {}
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Creates a new critical data element in the catalog.")
@route("/criticalDataElements")
@post
op postCriticalDataElement is Foundations.Operation<
  {
    @doc("The resource associated with the critical data element.")
    @bodyRoot
    body: CatalogModelCriticalDataElement;
  },
  {
    @statusCode
    statusCode: 201;

    @doc("The body associated with the critical data element output.")
    @bodyRoot
    body: CatalogModelCriticalDataElement;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Searches and retrieves critical data elements based on Id.")
@route("/criticalDataElements/{criticalDataElementId}")
@get
op getCriticalDataElementCriticalDataElementId is Foundations.Operation<
  {
    @doc("The criticalDataElementId of data element.")
    @path
    criticalDataElementId: uuid;
  },
  CatalogModelCriticalDataElement,
  {}
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Updates an existing critical data element in the catalog.")
@route("/criticalDataElements/{criticalDataElementId}")
@put
op replaceCriticalDataElement is Foundations.Operation<
  {
    @doc("The unique identifier of the critical data element.")
    @path
    criticalDataElementId: uuid;

    @doc("The body associated with the critical data element output.")
    @bodyRoot
    body?: CatalogModelCriticalDataElement;
  },
  CatalogModelCriticalDataElement,
  {}
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Deletes an existing critical data element in the catalog.")
@route("/criticalDataElements/{criticalDataElementId}")
@delete
op deleteCriticalDataElement is Foundations.Operation<
  {
    @doc("The unique identifier of the critical data element.")
    @path
    criticalDataElementId: uuid;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Retrieves relationships for a critical data element.")
@route("/criticalDataElements/{criticalDataElementId}/relationships")
@get
op getsCriticalDataElement is Foundations.Operation<
  {
    @doc("The unique identifier of the critical data element.")
    @path
    criticalDataElementId: uuid;

    @doc("The body associated with the critical data element output.")
    @query
    entityType: EntityCategory;
  },
  CatalogModelCriticalDataElement,
  {}
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Updates relationships for a critical data element.")
@route("/criticalDataElements/{criticalDataElementId}/relationships")
@post
op criticalDataElementCriticalDataElementIdRelationships is Foundations.Operation<
  {
    @doc("The unique identifier of the critical data element.")
    @path
    criticalDataElementId: uuid;

    @doc("The body associated with the critical data element output.")
    @query
    entityType: EntityCategory;

    @doc("CatalogModelCriticalDataElementRequest")
    @bodyRoot
    body?: InputProperties;
  },
  CatalogModelCriticalDataElement,
  {}
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Deletes relationships for a critical data element.")
@route("/criticalDataElements/{criticalDataElementId}/relationships")
@delete
op deletesCriticalDataElement is Foundations.Operation<
  {
    @doc("The unique identifier of the critical data element.")
    @path
    criticalDataElementId: uuid;

    @doc("EntityCategory")
    @query
    entityType: EntityCategory;

    @doc("The unique identifier of the critical data element.")
    @query
    entityId: uuid;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Queries critical data elements based on various criteria.")
@route("/criticalDataElements/query")
@post
op criticalDataElementQuery is Foundations.Operation<
  {
    @doc("The number of duplicate checks to perform.")
    @query
    duplicatecheck?: int32;

    @doc("body")
    @bodyRoot
    body?: CriticalDataElementQueryRequest;
  },
  CatalogModelCriticalDataElement,
  {}
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Retrieves facets for critical data elements.")
@route("/criticalDataElements/facets")
@post
op criticalDataElementFacets is Foundations.Operation<
  CriticalDataElementFacetRequest,
  FacetsResponse,
  {}
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("CriticalDataColumns")
@doc("Creates a new critical data column in the catalog.")
@route("/criticalDataColumns")
@post
op createCriticalDataColumn is Foundations.Operation<
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
@tag("CriticalDataColumns")
@doc("Searches and retrieves critical data columns based on domain, assetId, and other filters.")
@route("/criticalDataColumns")
@get
op getCriticalDataColumns is Foundations.Operation<
  {
    @doc("The unique identifier of the critical data column.")
    @query
    domainId?: uuid;

    @doc("The unique identifier of the critical data column.")
    @query
    assetId?: uuid;

    @doc("Number of items to skip.")
    @query
    skip?: int32;

    @doc("Number of items to top.")
    @query
    top?: int32;

    @doc("Field to sort by.")
    @query
    orderby?: string;
  },
  CriticalDataColumnsResponse,
  {}
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("CriticalDataColumns")
@doc("Searches and retrieves critical data columns based on Id.")
@route("/criticalDataColumns/{criticalDataColumnId}")
@get
op getCriticalDataColumnCriticalDataColumnId is Foundations.Operation<
  {
    @doc("The unique identifier of the critical data column.")
    @path
    criticalDataColumnId: uuid;
  },
  CatalogModelCriticalDataColumn,
  {}
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("CriticalDataColumns")
@doc("Updates an existing critical data column in the catalog.")
@route("/criticalDataColumns/{criticalDataColumnId}/relationships")
@post
op criticalDataColumnCriticalDataColumnIdRelationships is Foundations.Operation<
  {
    @doc("The unique identifier of the critical data column.")
    @path
    criticalDataColumnId: uuid;

    @doc("The body associated with the critical data column")
    @query
    entityType: EntityCategory;

    @doc("InputbodyProperties")
    @bodyRoot
    body?: InputbodyProperties;
  },
  RelationshipWrappersResponse,
  {}
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("CriticalDataColumns")
@doc("Retrieves relationships for a critical data column.")
@route("/criticalDataColumns/{criticalDataColumnId}/relationships")
@get
op getCriticalDataColumnRelationships is Foundations.Operation<
  {
    @doc("The unique identifier of the critical data column.")
    @path
    criticalDataColumnId: uuid;

    @doc("The body associated with the critical data column")
    @query
    entityType: EntityCategory;
  },
  RelationshipWrappersResponse,
  {}
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("CriticalDataColumns")
@doc("Deletes relationships for a critical data column.")
@route("/criticalDataColumns/{criticalDataColumnId}/relationships")
@delete
op deleteCriticalDataColumn is Foundations.Operation<
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
    criticalDataColumnId: string;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("DataAsset")
@doc("Retrieves a list of data assets.")
@route("/dataAssets")
@get
op getDataAssets is Foundations.Operation<
  {
    @doc("Field to sort by.")
    @query
    orderby?: string;

    @doc("Number of items to skip.")
    @query
    skip?: int32;

    @doc("Number of items to return.")
    @query
    top?: int32;
  },
  DataAssetsResponse,
  {}
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("DataAsset")
@doc("Creates a new data asset.")
@route("/dataAssets")
@post
op postDataAsset is Foundations.Operation<
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
@tag("DataAsset")
@doc("Creates a new data asset with fileted query inputs.")
@route("/dataAssets/query")
@post
op postDataAssetQuery is Foundations.Operation<
  DataAssetDataAssetQueryRequest,
  DataAssetsResponse,
  {}
>;
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("DataAsset")
@doc("Retrieves a data asset by its unique identifier.")
@route("/dataAssets/{dataAssetId}")
@get
op getDataAssetDataAssetId is Foundations.Operation<
  {
    @doc("The unique identifier of the critical data asset.")
    @path
    dataAssetId: uuid;
  },
  CatalogModelDataAsset,
  {}
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("DataAsset")
@doc("Updates a data asset by its unique identifier.")
@route("/dataAssets/{dataAssetId}")
@put
op replaceDataAsset is Foundations.Operation<
  {
    @doc("The unique identifier of the critical data asset.")
    @path
    dataAssetId: uuid;

    @doc("CatalogModelDataAsset.")
    @bodyRoot
    body?: CatalogModelDataAsset;
  },
  CatalogModelDataAsset,
  {}
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("DataAsset")
@doc("Deletes a data asset by its unique identifier.")
@route("/dataAssets/{dataAssetId}")
@delete
op deleteDataAsset is Foundations.Operation<
  {
    @doc("The unique identifier of the critical data asset.")
    @path
    dataAssetId: uuid;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("DataAsset")
@doc("Retrieves relationships for a data asset.")
@route("/dataAssets/{dataAssetId}/relationships")
@get
op getDataAssetRelationships is Foundations.Operation<
  {
    @doc("The unique identifier of the critical data asset.")
    @path
    dataAssetId: uuid;

    @doc("The type of entity to retrieve relationships for.")
    @query
    entityType: EntityCategory;
  },
  RelationshipWrappersResponse,
  {}
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("DataAsset")
@doc("Creates relationships for a data asset.")
@route("/dataAssets/{dataAssetId}/relationships")
@post
op createDataAssetRelationships is Foundations.Operation<
  {
    @doc("The unique identifier of the critical data asset.")
    @path
    dataAssetId: uuid;

    @doc("The type of entity to retrieve relationships for.")
    @query
    entityType: EntityCategory;

    @doc("The properties of the relationship to create.")
    @bodyRoot
    body: Record<InputbodyProperties>;
  },
  RelationshipWrappersResponse,
  {}
>;
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("DataAsset")
@doc("Deletes relationships for a data asset.")
@route("/dataAssets/{dataAssetId}/relationships")
@delete
op deleteDataAssetRelationships is Foundations.Operation<
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
@tag("DataProduct")
@doc("Retrieves a list of data products.")
@route("/dataProducts")
@get
op getDataProduct is Foundations.Operation<
  {
    @doc("The unique identifier of the domain.")
    @query
    domainId?: uuid;

    @doc("The number of items to skip.")
    @query
    skip?: int32;

    @doc("The number of items to return.")
    @query
    top?: int32;

    @doc("The field to order by.")
    @query
    orderby?: string;
  },
  DataProductResponse,
  {}
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("DataProduct")
@doc("Creates a new data product.")
@route("/dataProducts")
@post
op createDataProduct is Foundations.Operation<
  CatalogModelDataProduct,
  {
    @statusCode
    statusCode: 201;

    @doc("The created data product.")
    @bodyRoot
    body: CatalogModelDataProduct;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("DataProduct")
@doc("Queries data products based on specified criteria.")
@route("/dataProducts/query")
@post
op createDataProductQuery is Foundations.Operation<
  {
    @doc("To check for duplicate data products.")
    @query
    duplicatecheck?: int32;

    @doc("To filter by data product owner.")
    @query
    dataProductOwner?: boolean;

    @doc("The request body for the query.")
    @bodyRoot
    body?: DataProductQueryRequest;
  },
  DataProductResponse,
  {}
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("DataProduct")
@doc("Retrieves facets for data products.")
@route("/dataProducts/facets")
@post
op dataProductFacets is Foundations.Operation<
  DataProductFacetRequest,
  FacetsResponse,
  {}
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("DataProduct")
@doc("Retrieves a data product by its dataProductId.")
@route("/dataProducts/{dataProductId}")
@get
op getDataProductDataProductId is Foundations.Operation<
  {
    @doc("The unique identifier of the data product.")
    @path
    dataProductId: uuid;
  },
  CatalogModelDataProduct,
  {}
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("DataProduct")
@doc("Updates a data product by its DataProductId.")
@route("/dataProducts/{dataProductId}")
@put
op replaceDataProductDataProductId is Foundations.Operation<
  {
    @doc("The unique identifier of the data product.")
    @path
    dataProductId: uuid;

    @doc("The updated data product.")
    @bodyRoot
    body?: CatalogModelDataProduct;
  },
  CatalogModelDataProduct,
  {}
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("DataProduct")
@doc("Deletes a data product by its dataProductId.")
@route("/dataProducts/{dataProductId}")
@delete
op deleteDataProduct is Foundations.Operation<
  {
    @doc("The unique identifier of the data product.")
    @path
    dataProductId: uuid;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("DataProduct")
@doc("Retrieves relationships for a data product.")
@route("/dataProducts/{dataProductId}/relationships")
@get
op getDataProductDataProductIdRelationships is Foundations.Operation<
  {
    @doc("The unique identifier of the data product.")
    @path
    dataProductId: uuid;

    @doc("The type of entity to retrieve relationships for.")
    @query
    entityType: EntityCategory;
  },
  RelationshipWrappersResponse,
  {}
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("DataProduct")
@doc("Creates a relationship for a data product.")
@route("/dataProducts/{dataProductId}/relationships")
@post
op replaceDataProductRelationships is Foundations.Operation<
  {
    @doc("The unique identifier of the data product.")
    @path
    dataProductId: uuid;

    @doc("The type of entity to retrieve relationships for.")
    @query
    entityType: EntityCategory;

    @doc("The properties of the relationship to create.")
    @bodyRoot
    body: Record<InputbodyProperties>;
  },
  RelationshipWrappersResponse,
  {}
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("DataProduct")
@doc("Deletes a relationship for a data product.")
@route("/dataProducts/{dataProductId}/relationships")
@delete
op deleteDataProductRelationship is Foundations.Operation<
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
@tag("BusinessDomain")
@doc("Retrieves a list of business domains.")
@route("/businessdomains")
@get
op getDomain is Foundations.Operation<
  {
    @doc("skiptoken")
    @query
    $skipToken?: string;

    @doc("writeOnly")
    @query
    writeOnly?: boolean;
  },
  CatalogModelDomainResponse,
  {}
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("BusinessDomain")
@doc("Creates a new business domain.")
@route("/businessdomains")
@post
op createDomain is Foundations.Operation<
  CatalogModelDomain,
  {
    @statusCode
    statusCode: 201;

    @doc("The created business domain.")
    @bodyRoot
    body: CatalogModelDomain;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("BusinessDomain")
@doc("Updates an existing business domain.")
@route("/businessdomains/{domainId}")
@put
op replaceDomainDomainId is Foundations.Operation<
  {
    @doc("The unique identifier of the business domain.")
    @path
    domainId: uuid;

    @doc("The updated business domain.")
    @bodyRoot
    body?: CatalogModelDomain;
  },
  CatalogModelDomain,
  {}
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("BusinessDomain")
@doc("Retrieves an existing business domain.")
@route("/businessdomains/{domainId}")
@get
op getDomainDomainId is Foundations.Operation<
  {
    @doc("The unique identifier of the business domain.")
    @path
    domainId: uuid;
  },
  CatalogModelDomain,
  {}
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("BusinessDomain")
@doc("Deletes an existing business domain.")
@route("/businessdomains/{domainId}")
@delete
op deleteDomain is Foundations.Operation<
  {
    @doc("The unique identifier of the business domain.")
    @path
    domainId: uuid;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("Policy")
@doc("Retrieves a list of policies.")
@route("/policies")
@get
op getPolicy is Foundations.Operation<
  {
    @doc("skiptoken")
    @query
    skipToken?: string;
  },
  {
    @statusCode
    statusCode: 200;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("Policy")
@doc("Adds an administrator to a policy.")
@route("/policies/addAdministrator")
@post
op addPolicyAdministrator is Foundations.Operation<
  ControllersModelsPolicyAddAdminRequest,
  {
    @statusCode
    statusCode: 200;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("Term")
@doc("Adds an administrator to a policy.")
@route("/terms")
@post
op createTerm is Foundations.Operation<
  CatalogModelTerm,
  {
    @statusCode
    statusCode: 201;

    @doc("The body associated with the term output.")
    @bodyRoot
    body: CatalogModelTerm;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("Term")
@doc("Retrieves a list of terms based on domain, parentId, keyword, and other filters.")
@route("/terms")
@get
op getTerm is Foundations.Operation<
  {
    @doc("The unique identifier of the domain.")
    @query
    domainId?: uuid;

    @doc("The unique identifier of the parent term.")
    @query
    parentId?: uuid;

    @doc("Search keyword.")
    @query
    keyword?: string;

    @doc("Number of items to skip.")
    @query
    skip?: int32;

    @doc("Number of items to return.")
    @query
    top?: int32;

    @doc("The depth of the term.")
    @query
    depth?: int32;

    @doc("Field to sort by.")
    @query
    orderby?: string;
  },
  CatalogModelTermResponse,
  {}
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("Term")
@doc("Retrieves a term by its unique identifier.")
@route("/terms/{termId}")
@put
op createOrReplaceTermId is Foundations.Operation<
  {
    @doc(".The unique identifier of the term.")
    @path
    termId: uuid;

    @doc("The body associated with the term output.")
    @bodyRoot
    body?: CatalogModelTerm;
  },
  CatalogModelTerm,
  {}
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("Term")
@doc("Retrieves a term by its unique identifier.")
@route("/terms/{termId}")
@get
op getTermWithId is Foundations.Operation<
  {
    @doc("The unique identifier of the term.")
    @path
    termId: uuid;
  },
  CatalogModelTerm,
  {}
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("Term")
@doc("Deletes a term by its unique identifier.")
@route("/terms/{termId}")
@delete
op deleteTerm is Foundations.Operation<
  {
    @doc("The unique identifier of the term.")
    @path
    termId: uuid;
  },
  void
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("Term")
@doc("Retrieves terms based on specified criteria.")
@route("/terms/query")
@post
op termQuery is Foundations.Operation<
  {
    @doc("To check for duplicate terms.")
    @query
    duplicatecheck?: int32;

    @doc("the body associated with the term output.")
    @bodyRoot
    body?: TermTermQueryRequest;
  },
  CatalogModelTermResponse,
  {}
>;
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("Term")
@doc("Retrieves facets for terms.")
@route("/terms/facets")
@post
op replaceTermFacets is Foundations.Operation<
  TermFacetRequest,
  FacetsResponse,
  {}
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("Term")
@doc("Retrieves hierarchies for a term by its unique identifier.")
@route("/terms/{termId}/hierarchies")
@get
op getTermIdHierarchies is Foundations.Operation<
  {
    @doc("The unique identifier of the term.")
    @path
    termId: uuid;
  },
  CatalogModelTermResponse,
  {}
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("Term")
@doc("Retrieves relationships for a term by its unique identifier.")
@route("/terms/{termId}/relationships")
@post
op createOrReplaceTermIdRelationships is Foundations.Operation<
  {
    @doc("The unique identifier of the term.")
    @path
    termId: uuid;

    @doc("The type of entity to retrieve relationships for.")
    @query
    entityType: EntityCategory;

    @doc("The type of relationship to retrieve.")
    @bodyRoot
    body?: TermRelationship;
  },
  TermRelationshipResponse,
  {}
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("Term")
@doc("Deletes relationships for a term by its unique identifier and specified entity type and relationship type.")
@route("/terms/{termId}/relationships")
@delete
op deletesTerm is Foundations.Operation<
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
@tag("Term")
@doc("Retrieves relationships for a term by its unique identifier and specified entity type and relationship type.")
@route("/terms/{termId}/relationships")
@get
op getTermRelationships is Foundations.Operation<
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
  TermRelationshipResponse,
  {}
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("Term")
@doc("Retrieves the state of term migration.")
@route("/terms/migration/state")
@get
op getTermMigrationState is Foundations.Operation<{}, TermMigrationState, {}>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("Term")
@doc("Retrieves the counts of terms that are in the process of migration.")
@route("/terms/migration/counts")
@get
op getTermMigrationCounts is Foundations.Operation<{}, TermMigrationCounts, {}>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("Term")
@doc("Starts the migration process for terms.")
@route("/terms/migration/start")
@post
op termMigrationStart is Foundations.Operation<
  {},
  {
    @statusCode
    statusCode: 202;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("Term")
@doc("Moves terms from the old glossary to the new glossary.")
@route("/terms/migration/moveterms")
@post
op termMigrationMoveterms is Foundations.Operation<
  TermsMoveRequest,
  string,
  {}
>;
