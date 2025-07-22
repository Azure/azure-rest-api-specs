import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;

namespace PurviewDataCatalog;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Searches and retrieves critical data elements based on domain, keyword, and other filters.")
@route("/criticalDataElements")
@get
op getCriticalDataElements is Azure.Core.Foundations.Operation<
  {
    @doc("Whether to return minimal information for referred Domains.")
    @query
    domainId?: string;

    @doc("Search keyword.")
    @query
    keyword?: string;

    @doc("Number of items to skip.")
    @query
    skip?: int32 = 0;

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
op postCriticalDataElement is Azure.Core.Foundations.Operation<
  {
    @doc("The resource associated with the critical data element.")
    @body
    body: CatalogModelCriticalDataElement;
  },
  {
    @statusCode
    statusCode: 201;

    @doc("The body associated with the critical data element output.")
    @body
    body: CatalogModelCriticalDataElement;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Searches and retrieves critical data elements based on Id.")
@route("/criticalDataElements/{criticalDataElementId}")
@get
op getCriticalDataElementCriticalDataElementId is Azure.Core.Foundations.Operation<
  {
    @doc("The criticalDataElementId of data element.")
    @path
    criticalDataElementId: Azure.Core.uuid;
  },
  {
    @statusCode
    statusCode: 200;

    @doc("The body associated with the critical data element output.")
    @body
    body: CatalogModelCriticalDataElement;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Updates an existing critical data element in the catalog.")
@route("/criticalDataElements/{criticalDataElementId}")
@put
op replaceCriticalDataElement is Azure.Core.Foundations.Operation<
  {
    @doc("The unique identifier of the critical data element.")
    @path
    criticalDataElementId: Azure.Core.uuid;

    @doc("The body associated with the critical data element output.")
    @bodyRoot
    body?: CatalogModelCriticalDataElement;
  },
  {
    @statusCode
    statusCode: 200;

    @doc("The body associated with the critical data element output.")
    @body
    body: CatalogModelCriticalDataElement;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Deletes an existing critical data element in the catalog.")
@route("/criticalDataElements/{criticalDataElementId}")
@delete
op deleteCriticalDataElement is Azure.Core.Foundations.Operation<
  {
    @doc("The unique identifier of the critical data element.")
    @path
    criticalDataElementId: Azure.Core.uuid;
  },
  {
    @statusCode
    statusCode: 204;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Retrieves relationships for a critical data element.")
@route("/criticalDataElements/{criticalDataElementId}/relationships")
@get
op getsCriticalDataElement is Azure.Core.Foundations.Operation<
  {
    @doc("The unique identifier of the critical data element.")
    @path
    criticalDataElementId: Azure.Core.uuid;

    @doc("The body associated with the critical data element output.")
    @query("entityType")
    entityType: EntityCategory;
  },
  {
    @statusCode
    statusCode: 200;

    @doc("The body associated with the critical data element output.")
    @body
    body: CatalogModelCriticalDataElement;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Updates relationships for a critical data element.")
@route("/criticalDataElements/{criticalDataElementId}/relationships")
@post
op criticalDataElementCriticalDataElementIdRelationships is Azure.Core.Foundations.Operation<
  {
    @doc("The unique identifier of the critical data element.")
    @path
    criticalDataElementId: Azure.Core.uuid;

    @doc("The body associated with the critical data element output.")
    @query("entityType")
    entityType: EntityCategory;

    @doc("CatalogModelCriticalDataElementRequest")
    @body
    body?: InputProperties;
  },
  {
    @statusCode
    statusCode: 200;

    @doc("The critical data element with updated relationships.")
    @body
    body: CatalogModelCriticalDataElement;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Deletes relationships for a critical data element.")
@route("/criticalDataElements/{criticalDataElementId}/relationships")
@delete
op deletesCriticalDataElement is Azure.Core.Foundations.Operation<
  {
    @doc("The unique identifier of the critical data element.")
    @path
    criticalDataElementId: Azure.Core.uuid;

    @doc("EntityCategory")
    @query
    entityType: EntityCategory;

    @doc("The unique identifier of the critical data element.")
    @query
    entityId: Azure.Core.uuid;
  },
  {
    @statusCode
    statusCode: 204;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("CriticalDataElements")
@doc("Queries critical data elements based on various criteria.")
@route("/criticalDataElements/query")
@post
op criticalDataElementQuery is Azure.Core.Foundations.Operation<
  {
    @doc("The number of duplicate checks to perform.")
    @query("duplicatecheck")
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
op criticalDataElementFacets is Azure.Core.Foundations.Operation<
  CriticalDataElementFacetRequest,
  FacetsResponse,
  {}
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("CriticalDataColumns")
@doc("Creates a new critical data column in the catalog.")
@route("/criticalDataColumns")
@post
op createCriticalDataColumn is Azure.Core.Foundations.Operation<
  {
    @doc("The resource associated with the critical data element.")
    @body
    body: CatalogModelCriticalDataColumn;
  },
  {
    @statusCode
    statusCode: 201;

    @doc("The body associated with the critical data column output.")
    @body
    body: CatalogModelCriticalDataColumn;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("CriticalDataColumns")
@doc("Searches and retrieves critical data columns based on domain, assetId, and other filters.")
@route("/criticalDataColumns")
@get
op getCriticalDataColumns is Azure.Core.Foundations.Operation<
  {
    @doc("The unique identifier of the critical data column.")
    @query("domainId")
    domainId?: Azure.Core.uuid;

    @doc("The unique identifier of the critical data column.")
    @query("assetId")
    assetId?: Azure.Core.uuid;

    @doc("Number of items to skip.")
    @query("skip")
    skip?: int32 = 0;

    @doc("Number of items to top.")
    @query("top")
    top?: int32;

    @doc("Field to sort by.")
    @query("orderby")
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
op getCriticalDataColumnCriticalDataColumnId is Azure.Core.Foundations.Operation<
  {
    @doc("The unique identifier of the critical data column.")
    @path("criticalDataColumnId")
    criticalDataColumnId: Azure.Core.uuid;
  },
  {
    @statusCode
    statusCode: 200;

    @doc("The body associated with the critical data column output.")
    @body
    body: CatalogModelCriticalDataColumn;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("CriticalDataColumns")
@doc("Updates an existing critical data column in the catalog.")
@route("/criticalDataColumns/{criticalDataColumnId}/relationships")
@post
op criticalDataColumnCriticalDataColumnIdRelationships is Azure.Core.Foundations.Operation<
  {
    @doc("The unique identifier of the critical data column.")
    @path("criticalDataColumnId")
    criticalDataColumnId: Azure.Core.uuid;

    @doc("The body associated with the critical data column")
    @query("entityType")
    entityType: EntityCategory;

    @doc("InputbodyProperties")
    @body
    body?: InputbodyProperties;
  },
  {
    @statusCode
    statusCode: 200;

    @doc("RelationshipWrapper.")
    @body
    body: RelationshipWrappersResponse;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("CriticalDataColumns")
@doc("Retrieves relationships for a critical data column.")
@route("/criticalDataColumns/{criticalDataColumnId}/relationships")
@get
op getCriticalDataColumnRelationships is Azure.Core.Foundations.Operation<
  {
    @doc("The unique identifier of the critical data column.")
    @path("criticalDataColumnId")
    criticalDataColumnId: Azure.Core.uuid;

    @doc("The body associated with the critical data column")
    @query("entityType")
    entityType: EntityCategory;
  },
  {
    @statusCode
    statusCode: 200;

    @doc("RelationshipWrapper.")
    @body
    body: RelationshipWrappersResponse;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("CriticalDataColumns")
@doc("Deletes relationships for a critical data column.")
@route("/criticalDataColumns/{criticalDataColumnId}/relationships")
@delete
op deleteCriticalDataColumn is Azure.Core.Foundations.Operation<
  {
    @doc("The unique identifier of the critical data column.")
    @query("criticalDataElementId")
    criticalDataElementId?: Azure.Core.uuid;

    @doc("The body associated with the critical data column")
    @query("entityType")
    entityType: EntityCategory;

    @doc("The unique identifier of the critical data column.")
    @query("entityId")
    entityId: Azure.Core.uuid;

    @doc("The unique identifier of the critical data column.")
    @path
    criticalDataColumnId: string;
  },
  {
    @statusCode
    statusCode: 204;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("DataAsset")
@doc("Retrieves a list of data assets.")
@route("/dataAssets")
@get
op getDataAssets is Azure.Core.Foundations.Operation<
  {
    @doc("Field to sort by.")
    @query
    orderby?: string;

    @doc("Number of items to skip.")
    @query
    skip?: int32 = 0;

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
op postDataAsset is Azure.Core.Foundations.Operation<
  CatalogModelDataAsset,
  {
    @statusCode
    statusCode: 201;

    @doc("RelationshipWrapper.")
    @body
    body: CatalogModelDataAsset;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("DataAsset")
@doc("Creates a new data asset with fileted query inputs.")
@route("/dataAssets/query")
@post
op postDataAssetQuery is Azure.Core.Foundations.Operation<
  DataAssetDataAssetQueryRequest,
  DataAssetsResponse,
  {}
>;
#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("DataAsset")
@doc("Retrieves a data asset by its unique identifier.")
@route("/dataAssets/{dataAssetId}")
@get
op getDataAssetDataAssetId is Azure.Core.Foundations.Operation<
  {
    @doc("The unique identifier of the critical data asset.")
    @path("dataAssetId")
    dataAssetId: Azure.Core.uuid;
  },
  CatalogModelDataAsset,
  {}
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("DataAsset")
@doc("Updates a data asset by its unique identifier.")
@route("/dataAssets/{dataAssetId}")
@put
op replaceDataAsset is Azure.Core.Foundations.Operation<
  {
    @doc("The unique identifier of the critical data asset.")
    @path("dataAssetId")
    dataAssetId: Azure.Core.uuid;

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
op deleteDataAsset is Azure.Core.Foundations.Operation<
  {
    @doc("The unique identifier of the critical data asset.")
    @path("dataAssetId")
    dataAssetId: Azure.Core.uuid;
  },
  {
    @statusCode
    statusCode: 204;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("DataAsset")
@doc("Retrieves relationships for a data asset.")
@route("/dataAssets/{dataAssetId}/relationships")
@get
op getDataAssetRelationships is Azure.Core.Foundations.Operation<
  {
    @doc("The unique identifier of the critical data asset.")
    @path("dataAssetId")
    dataAssetId: Azure.Core.uuid;

    @doc("The type of entity to retrieve relationships for.")
    @query("entityType")
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
op createDataAssetRelationships is Azure.Core.Foundations.Operation<
  {
    @doc("The unique identifier of the critical data asset.")
    @path("dataAssetId")
    dataAssetId: Azure.Core.uuid;

    @doc("The type of entity to retrieve relationships for.")
    @query("entityType")
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
op deleteDataAssetRelationships is Azure.Core.Foundations.Operation<
  {
    @doc("The unique identifier of the critical data asset.")
    @path("dataAssetId")
    dataAssetId: Azure.Core.uuid;

    @doc("The type of entity to retrieve relationships for.")
    @query("entityType")
    entityType: EntityCategory;

    @doc("The unique identifier of the critical data asset.")
    @query("entityId")
    entityId: Azure.Core.uuid;
  },
  {
    @statusCode
    statusCode: 204;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("DataProduct")
@doc("Retrieves a list of data products.")
@route("/dataProducts")
@get
op getDataProduct is Azure.Core.Foundations.Operation<
  {
    @doc("The unique identifier of the domain.")
    @query("domainId")
    domainId?: Azure.Core.uuid;

    @doc("The number of items to skip.")
    @query("skip")
    skip?: int32 = 0;

    @doc("The number of items to return.")
    @query("top")
    top?: int32;

    @doc("The field to order by.")
    @query("orderby")
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
op createDataProduct is Azure.Core.Foundations.Operation<
  CatalogModelDataProduct,
  {
    @statusCode
    statusCode: 201;

    @doc("The created data product.")
    @body
    body: CatalogModelDataProduct;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("DataProduct")
@doc("Queries data products based on specified criteria.")
@route("/dataProducts/query")
@post
op createDataProductQuery is Azure.Core.Foundations.Operation<
  {
    @doc("To check for duplicate data products.")
    @query("duplicatecheck")
    duplicatecheck?: int32;

    @doc("To filter by data product owner.")
    @query("dataProductOwner")
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
op dataProductFacets is Azure.Core.Foundations.Operation<
  DataProductFacetRequest,
  FacetsResponse,
  {}
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("DataProduct")
@doc("Retrieves a data product by its dataProductId.")
@route("/dataProducts/{dataProductId}")
@get
op getDataProductDataProductId is Azure.Core.Foundations.Operation<
  {
    @doc("The unique identifier of the data product.")
    @path
    dataProductId: Azure.Core.uuid;
  },
  CatalogModelDataProduct,
  {}
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("DataProduct")
@doc("Updates a data product by its DataProductId.")
@route("/dataProducts/{dataProductId}")
@put
op replaceDataProductDataProductId is Azure.Core.Foundations.Operation<
  {
    @doc("The unique identifier of the data product.")
    @path
    dataProductId: Azure.Core.uuid;

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
op deleteDataProduct is Azure.Core.Foundations.Operation<
  {
    @doc("The unique identifier of the data product.")
    @path
    dataProductId: Azure.Core.uuid;
  },
  {
    @statusCode
    statusCode: 204;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("DataProduct")
@doc("Retrieves relationships for a data product.")
@route("/dataProducts/{dataProductId}/relationships")
@get
op getDataProductDataProductIdRelationships is Azure.Core.Foundations.Operation<
  {
    @doc("The unique identifier of the data product.")
    @path
    dataProductId: Azure.Core.uuid;

    @doc("The type of entity to retrieve relationships for.")
    @query("entityType")
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
op replaceDataProductRelationships is Azure.Core.Foundations.Operation<
  {
    @doc("The unique identifier of the data product.")
    @path
    dataProductId: Azure.Core.uuid;

    @doc("The type of entity to retrieve relationships for.")
    @query("entityType")
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
op deleteDataProductRelationship is Azure.Core.Foundations.Operation<
  {
    @doc("The unique identifier of the data product.")
    @path
    dataProductId: Azure.Core.uuid;

    @doc("The type of entity to retrieve relationships for.")
    @query("entityType")
    entityType: EntityCategory;

    @doc("The unique identifier of the critical data asset.")
    @query("entityId")
    entityId: Azure.Core.uuid;
  },
  {
    @statusCode
    statusCode: 204;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("BusinessDomain")
@doc("Retrieves a list of business domains.")
@route("/businessdomains")
@get
op getDomain is Azure.Core.Foundations.Operation<
  {
    @doc("skiptoken")
    @query("$skipToken")
    $skipToken?: string;

    @doc("writeOnly")
    @query("writeOnly")
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
op createDomain is Azure.Core.Foundations.Operation<
  CatalogModelDomain,
  {
    @statusCode
    statusCode: 201;

    @doc("The created business domain.")
    @body
    body: CatalogModelDomain;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("BusinessDomain")
@doc("Updates an existing business domain.")
@route("/businessdomains/{domainId}")
@put
op replaceDomainDomainId is Azure.Core.Foundations.Operation<
  {
    @doc("The unique identifier of the business domain.")
    @path
    domainId: Azure.Core.uuid;

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
op getDomainDomainId is Azure.Core.Foundations.Operation<
  {
    @doc("The unique identifier of the business domain.")
    @path
    domainId: Azure.Core.uuid;
  },
  CatalogModelDomain,
  {}
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("BusinessDomain")
@doc("Deletes an existing business domain.")
@route("/businessdomains/{domainId}")
@delete
op deleteDomain is Azure.Core.Foundations.Operation<
  {
    @doc("The unique identifier of the business domain.")
    @path
    domainId: Azure.Core.uuid;
  },
  {
    @statusCode
    statusCode: 204;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("Policy")
@doc("Retrieves a list of policies.")
@route("/policies")
@get
op getPolicy is Azure.Core.Foundations.Operation<
  {
    @doc("skiptoken")
    @query("skipToken")
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
op addPolicyAdministrator is Azure.Core.Foundations.Operation<
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
op createTerm is Azure.Core.Foundations.Operation<
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
op getTerm is Azure.Core.Foundations.Operation<
  {
    @doc("The unique identifier of the domain.")
    @query("domainId")
    domainId?: Azure.Core.uuid;

    @doc("The unique identifier of the parent term.")
    @query("parentId")
    parentId?: Azure.Core.uuid;

    @doc("Search keyword.")
    @query("keyword")
    keyword?: string;

    @doc("Number of items to skip.")
    @query("skip")
    skip?: int32 = 0;

    @doc("Number of items to return.")
    @query("top")
    top?: int32;

    @doc("The depth of the term.")
    @query("depth")
    depth?: int32;

    @doc("Field to sort by.")
    @query("orderby")
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
op createOrReplaceTermId is Azure.Core.Foundations.Operation<
  {
    @doc(".The unique identifier of the term.")
    @path
    termId: Azure.Core.uuid;

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
op getTermWithId is Azure.Core.Foundations.Operation<
  {
    @doc("The unique identifier of the term.")
    @path
    termId: Azure.Core.uuid;
  },
  CatalogModelTerm,
  {}
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("Term")
@doc("Deletes a term by its unique identifier.")
@route("/terms/{termId}")
@delete
op deleteTerm is Azure.Core.Foundations.Operation<
  {
    @doc("The unique identifier of the term.")
    @path
    termId: Azure.Core.uuid;
  },
  {
    @statusCode
    statusCode: 204;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("Term")
@doc("Retrieves terms based on specified criteria.")
@route("/terms/query")
@post
op termQuery is Azure.Core.Foundations.Operation<
  {
    @doc("To check for duplicate terms.")
    @query("duplicatecheck")
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
op replaceTermFacets is Azure.Core.Foundations.Operation<
  TermFacetRequest,
  FacetsResponse,
  {}
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("Term")
@doc("Retrieves hierarchies for a term by its unique identifier.")
@route("/terms/{termId}/hierarchies")
@get
op getTermIdHierarchies is Azure.Core.Foundations.Operation<
  {
    @doc("The unique identifier of the term.")
    @path
    termId: Azure.Core.uuid;
  },
  CatalogModelTermResponse,
  {}
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("Term")
@doc("Retrieves relationships for a term by its unique identifier.")
@route("/terms/{termId}/relationships")
@post
op createOrReplaceTermIdRelationships is Azure.Core.Foundations.Operation<
  {
    @doc("The unique identifier of the term.")
    @path
    termId: Azure.Core.uuid;

    @doc("The type of entity to retrieve relationships for.")
    @query("entityType")
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
op deletesTerm is Azure.Core.Foundations.Operation<
  {
    @doc("The unique identifier of the term.")
    @path
    termId: Azure.Core.uuid;

    @doc("The type of entity to retrieve relationships for.")
    @query("entityType")
    entityType: EntityCategory;

    @doc("The type of relationship to retrieve.")
    @query("relationshipType")
    relationshipType?: TermRelationshipType;

    @doc("The unique identifier of the critical data asset.")
    @query("entityId")
    entityId: Azure.Core.uuid;
  },
  {
    @statusCode
    statusCode: 204;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("Term")
@doc("Retrieves relationships for a term by its unique identifier and specified entity type and relationship type.")
@route("/terms/{termId}/relationships")
@get
op getTermRelationships is Azure.Core.Foundations.Operation<
  {
    @doc("The unique identifier of the term.")
    @path
    termId: Azure.Core.uuid;

    @doc("The type of entity to retrieve relationships for.")
    @query("entityType")
    entityType: EntityCategory;

    @doc("The type of relationship to retrieve.")
    @query("relationshipType")
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
op getTermMigrationState is Azure.Core.Foundations.Operation<
  {},
  TermMigrationState,
  {}
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("Term")
@doc("Retrieves the counts of terms that are in the process of migration.")
@route("/terms/migration/counts")
@get
op getTermMigrationCounts is Azure.Core.Foundations.Operation<
  {},
  TermMigrationCounts,
  {}
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("Term")
@doc("Starts the migration process for terms.")
@route("/terms/migration/start")
@post
op termMigrationStart is Azure.Core.Foundations.Operation<
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
op termMigrationMoveterms is Azure.Core.Foundations.Operation<
  TermsMoveRequest,
  {
    @statusCode
    statusCode: 200;

    @doc("Response message indicating the result of the operation.")
    @body
    body: string;
  },
  {}
>;
