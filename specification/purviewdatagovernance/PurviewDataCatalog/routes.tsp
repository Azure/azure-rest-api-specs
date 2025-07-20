import "@azure-tools/typespec-azure-core";
import "@typespec/rest";
import "./models.tsp";
import "./error.tsp";
import "@typespec/http";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.Core;

namespace PurviewDataCatalog;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("CriticalDataElements")
@route("/criticalDataElements")
@get
op getCriticalDataElement is Azure.Core.Foundations.Operation<
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
    orderBy?: string;
  },
  CatalogModelCriticalDataElement[],
  {},
  NotFoundError
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("CriticalDataElements")
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
  {
    @statusCode
    statusCode: 200;
  }
>;

#suppress "@azure-tools/typespec-azure-core/use-standard-operations" "This is an existing service operation."
@tag("CriticalDataElements")
@route("/criticalDataElements/facets")
@post
op criticalDataElementFacets is Azure.Core.Foundations.Operation<
  CriticalDataElementFacetRequest,
  {
    @statusCode
    statusCode: 200;
  }
>;
