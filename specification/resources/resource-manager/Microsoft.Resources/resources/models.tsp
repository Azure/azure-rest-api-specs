import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-azure-resource-manager";

using TypeSpec.Rest;
using TypeSpec.Http;
using Azure.ResourceManager;
using Azure.Core;

// ================================
// HTTP METHOD ENUMS
// ================================

/** HTTP method enumeration for batch requests */
@doc("The HTTP method associated with the request.")
union HttpMethod {
  string,
  /** HTTP GET method */
  GET: "GET",
  /** HTTP PUT method */
  PUT: "PUT",
  /** HTTP PATCH method */
  PATCH: "PATCH",
  /** HTTP DELETE method */
  DELETE: "DELETE",
  /** HTTP POST method */
  POST: "POST",
}

// ================================
// BATCH API MODELS (Preview)
// ================================

/** Specifications for all of the requests that will be invoked as part of the batch. */
@doc("Specifications for all of the requests that will be invoked as part of the batch.")
model BatchRequests {
  /** The requests that will be invoked. */
  @doc("The requests that will be invoked.")
  requests: BatchRequest[];
}

/** The specification for one request that will be part of a larger batch. */
@doc("The specification for one request that will be part of a larger batch.")
model BatchRequest {
  /** The identifier for the request. Must be unique within a batch. */
  @doc("The identifier for the request. Must be unique within a batch.")
  id: string;

  /** The HTTP method associated with the request. */
  @doc("The HTTP method associated with the request.")
  method: HttpMethod;

  /** The request's absolute path. */
  @doc("The request's absolute path.")
  url: string;

  /** Headers that are specific to the request. */
  @doc("Headers that are specific to the request.")
  headers?: Record<string>;

  /** The body of the request. Not allowed for requests with an method of GET or DELETE. */
  @doc("The body of the request. Not allowed for requests with an method of GET or DELETE.")
  body?: unknown;
}

/** Responses for all requests contained in the batch. */
@doc("Responses for all requests contained in the batch.")
model BatchResponses {
  /** Responses for all requests contained in the batch. */
  @doc("Responses for all requests contained in the batch.")
  responses?: BatchResponse[];
}

/** The response received for one request in the batch. */
@doc("The response received for one request in the batch.")
model BatchResponse {
  /** The identifier of the request that generated the response. */
  @doc("The identifier of the request that generated the response.")
  id?: string;

  /** The HTTP status code of the response. */
  @doc("The HTTP status code of the response.")
  httpStatusCode?: int32;

  /** The status of the batch request. */
  @doc("The status of the batch request. The request is complete when the status is set to Succeeded, Failed, or Canceled.")
  status?: string;

  /** Headers that are specific to this response. */
  @doc("Headers that are specific to this response.")
  headers?: Record<string>;

  /** The body of the response. */
  @doc("The body of the response.")
  body?: unknown;
}

/** The result of the batch operation and each request within it. */
@doc("The result of the batch operation and each request within it.")
model BatchResponseStatus {
  ...Azure.Core.Foundations.OperationStatus;

  /** The final result of the batch operation. */
  @doc("The final result of the batch operation.")
  batchResult?: BatchResponses;

  /** If present, a GET on this URL will return the next page of results. */
  @doc("If present, a GET on this URL will return the next page of results.")
  nextLink?: string;
}

// ================================
// RESOURCE MODELS (Stable)
// ================================

/** Generic resource information. */
@doc("Common fields that are returned in the response for all Azure Resource Manager resources")
model GenericResource is Azure.ResourceManager.TrackedResource<GenericResourceProperties> {
  /** The name of the resource */
  @doc("The name of the resource")
  @path
  @key("resourceName")
  @segment("resources")
  name: string;
}

/** The resource properties. */
@doc("The resource properties.")
model GenericResourceProperties {
  /** The resource properties. */
  @doc("The resource properties.")
  properties?: unknown;
}

/** Resource group information. */
@doc("Resource group information.")
model ResourceGroup is Azure.ResourceManager.TrackedResource<ResourceGroupProperties> {
  /** The name of the resource group. */
  @doc("The name of the resource group.")
  @path
  @key("resourceGroupName")
  @segment("resourceGroups")
  name: string;

  /** The ID of the resource that manages this resource group. */
  @doc("The ID of the resource that manages this resource group.")
  managedBy?: string;
}

/** The resource group properties. */
@doc("The resource group properties.")
model ResourceGroupProperties {
  /** The provisioning state. */
  @doc("The provisioning state.")
  provisioningState?: string;
}

/** List of resource groups. */
@doc("List of resource groups.")
model ResourceGroupListResult is Azure.Core.Page<ResourceGroup>;

/** List of resources. */
@doc("List of resources.")  
model ResourceListResult is Azure.Core.Page<GenericResource>;