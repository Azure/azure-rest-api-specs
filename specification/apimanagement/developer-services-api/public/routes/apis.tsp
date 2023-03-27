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

namespace DeveloperServicesPublicApi.Routes.Apis;

@route("/apis")
@doc("List a collection of APIs.")
@get
op ListApis(...ListParams): ApiResponse<Page<Api>>;

@route("/apis/{apiId}")
@doc("Get the details of the API specified by its identifier.")
@get
op GetApi(
  ...CommonParams,

  @doc("If sent, the API will be exported in the specified format.")
  @header
  accept?: ContentTypes,

  @doc("If true, the API will be exported in the specified format.")
  @query
  export?: boolean
): ApiResponse<TypedBody<Api, ContentTypes>>;

@route("/apis/{apiId}/schemas")
@doc("List a collection of APIs schemas.")
@get
op ListApiSchemas(...CommonParams, ...ListParams): ApiResponse<Page<ApiSchema>>;

@route("/apis/{apiId}/schemas/{schemaId}")
@doc("Get the details of the APIs schema specified by its identifier.")
@get
op GetApiSchema(
  ...CommonParams,

  @doc("Schema identifier.")
  @path
  schemaId: string
): ApiResponse<ApiSchema>;

@route("/apis/{apiId}/authServers/oauth2")
@doc("List of OAuth 2.0 servers associated with the API.")
@get
op ListApiOAuth2Providers(
  ...CommonParams,
  ...ListParams
): ApiResponse<Page<AuthorizationServer>>;

@route("/apis/{apiId}/authServers/oauth2/{providerId}")
@doc("Get OAuth 2.0 server specified by its identifier associated with the API.")
@get
op GetApiOAuth2Provider(
  ...CommonParams,

  @doc("OAuth 2.0 server identifier.")
  @path
  providerId: string
): ApiResponse<AuthorizationServer>;

@route("/apis/{apiId}/authServers/openidconnect")
@doc("List of OpenID Connect servers associated with the API.")
@get
op ListApiOpenidProviders(
  ...CommonParams,
  ...ListParams
): ApiResponse<Page<AuthorizationServer>>;

@route("/apis/{apiId}/authServers/openidconnect/{providerId}")
@doc("Get OpenID Connect server specified by its identifier associated with the API.")
@get
op GetApiOpenidProvider(
  ...CommonParams,

  @doc("OpenID Connect server identifier.")
  @path
  providerId: string
): ApiResponse<AuthorizationServer>;

@route("/apis/{apiId}/products")
@doc("List of public products associated with the API.")
@get
op ListApiProducts(...CommonParams, ...ListParams): ApiResponse<Page<Product>>;

@route("/apis/{apiId}/releases")
@doc("List of releases for the API.")
@get
op ListApiReleases(
  ...CommonParams,
  ...ListParams
): ApiResponse<Page<ApiRelease>>;

@route("/apis/{apiId}/tags")
@doc("Tags of the API.")
@get
op ListApiTags(...CommonParams, ...ListParams): ApiResponse<Page<Tag>>;

@route("/apis/{apiId}/hostnames")
@doc("Hostnames of the API.")
@get
op ListApiHostnames(
  ...CommonParams,
  ...ListParams
): ApiResponse<Page<ApiHostname>>;

@route("/apis/{apiId}/operations")
@doc("Operations of the API.")
@get
op ListApiOperations(
  ...CommonParams,
  ...ListParams
): ApiResponse<Page<Operation>>;

@route("/apis/{apiId}/operations/{operationId}")
@doc("Operation specified by its identifier of the API.")
@get
op GetApiOperation(
  ...CommonParams,

  @doc("Operation identifier.")
  @path
  operationId: string
): ApiResponse<Operation>;

@route("/apis/{apiId}/operations/{operationId}/tags")
@doc("Operation tags specified by its identifier of the API.")
@get
op ListApiOperationTags(
  ...CommonParams,
  ...ListParams,

  @doc("Operation identifier.")
  @path
  operationId: string
): ApiResponse<Page<Tag>>;

@doc("Common parameters.")
model CommonParams {
  @doc("API identifier.")
  @path
  apiId: string;
}
