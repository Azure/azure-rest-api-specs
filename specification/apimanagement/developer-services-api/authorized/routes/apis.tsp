import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "../../models/common.tsp";
import "../../models/api.tsp";
import "../../models/authorizationServer.tsp";
import "../../models/product.tsp";
import "../../models/operation.tsp";
import "../../models/tag.tsp";

using TypeSpec.Http;
using Azure.Core;
using DeveloperServicesApi.Models;

namespace DeveloperServicesAuthorizedApi.Routes.Apis;

@route("/users/{userId}/apis")
@doc("List a collection of APIs.")
@get
op ListApis(...UserParams, ...ListParams): ApiResponse<Page<Api>>;

@route("/users/{userId}/apis/{apiId}")
@doc("Get the details of the API specified by its identifier.")
@get
op GetApi(
  ...UserParams,
  ...CommonParams,
  @header accept?: ContentTypes,
  @query export?: boolean
): ApiResponse<TypedBody<Api, ContentTypes>>;

@route("/users/{userId}/apis/{apiId}/schemas")
@doc("List a collection of APIs schemas.")
@get
op ListApiSchemas(
  ...UserParams,
  ...CommonParams,
  ...ListParams
): ApiResponse<Page<ApiSchema>>;

@route("/users/{userId}/apis/{apiId}/schemas/{schemaId}")
@doc("Get the details of the APIs schema specified by its identifier.")
@get
op GetApiSchema(
  ...UserParams,
  ...CommonParams,
  @path schemaId: string
): ApiResponse<ApiSchema>;

@route("/users/{userId}/apis/{apiId}/authServers/oauth2")
@doc("List of OAuth 2.0 servers associated with the API.")
@get
op ListApiOAuth2Providers(
  ...UserParams,
  ...CommonParams,
  ...ListParams
): ApiResponse<Page<AuthorizationServer>>;

@route("/users/{userId}/apis/{apiId}/authServers/oauth2/{providerId}")
@doc("Get OAuth 2.0 server specified by its identifier associated with the API.")
@get
op GetApiOAuth2Provider(
  ...UserParams,
  ...CommonParams,
  @path providerId: string
): ApiResponse<AuthorizationServer>;

@route("/users/{userId}/apis/{apiId}/authServers/openidconnect")
@doc("List of OpenID Connect servers associated with the API.")
@get
op ListApiOpenidProviders(
  ...UserParams,
  ...CommonParams,
  ...ListParams
): ApiResponse<Page<AuthorizationServer>>;

@route("/users/{userId}/apis/{apiId}/authServers/openidconnect/{providerId}")
@doc("Get OpenID Connect server specified by its identifier associated with the API.")
@get
op GetApiOpenidProvider(
  ...UserParams,
  ...CommonParams,
  @path providerId: string
): ApiResponse<AuthorizationServer>;

@route("/users/{userId}/apis/{apiId}/products")
@doc("List of public products associated with the API.")
@get
op ListApiProducts(
  ...UserParams,
  ...CommonParams,
  ...ListParams
): ApiResponse<Page<Product>>;

@route("/users/{userId}/apis/{apiId}/releases")
@doc("List of releases for the API.")
@get
op ListApiReleases(
  ...UserParams,
  ...CommonParams,
  ...ListParams
): ApiResponse<Page<ApiRelease>>;

@route("/users/{userId}/apis/{apiId}/tags")
@doc("Tags of the API.")
@get
op ListApiTags(
  ...UserParams,
  ...CommonParams,
  ...ListParams
): ApiResponse<Page<Tag>>;

@route("/users/{userId}/apis/{apiId}/hostnames")
@doc("Hostnames of the API.")
@get
op ListApiHostnames(
  ...UserParams,
  ...CommonParams,
  ...ListParams
): ApiResponse<Page<ApiHostname>>;

@route("/users/{userId}/apis/{apiId}/operations")
@doc("Operations of the API.")
@get
op ListApiOperations(
  ...UserParams,
  ...CommonParams,
  ...ListParams
): ApiResponse<Page<Operation>>;

@route("/users/{userId}/apis/{apiId}/operations/{operationId}")
@doc("Operation specified by its identifier of the API.")
@get
op GetApiOperation(
  ...UserParams,
  ...CommonParams,

  @doc("The identifier of the operation.")
  @path
  operationId: string
): ApiResponse<Operation>;

@route("/users/{userId}/apis/{apiId}/operations/{operationId}/tags")
@doc("Operation tags specified by its identifier of the API.")
@get
op ListApiOperationTags(
  ...UserParams,
  ...CommonParams,
  ...ListParams,

  @doc("The identifier of the operation.")
  @path
  operationId: string
): ApiResponse<Page<Tag>>;

@doc("Common parameters.")
model CommonParams {
  @doc("The identifier of the API.")
  @path
  apiId: string;
}
