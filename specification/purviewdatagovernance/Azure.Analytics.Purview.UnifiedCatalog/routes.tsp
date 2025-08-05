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
  CriticalDataElementBody & UpdateCriticalDataElementParameters,
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
  UpdateCriticalDataElementParameters & {
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
  UpdateCriticalDataElementParameters & {
    @doc("The type of entity for the relationship.")
    @query
    entityType: EntityCategory;

    @doc("The unique identifier of the related entity.")
    @query
    entityId: uuid;
  },
  DeleteCriticalDataElementResponse
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
