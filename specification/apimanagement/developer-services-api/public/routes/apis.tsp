import "@typespec/rest";
import "../../models/common.tsp";
import "../../models/api.tsp";
import "../../models/authorizationServer.tsp";
import "../../models/product.tsp";
import "../../models/operation.tsp";
import "../../models/tag.tsp";

using TypeSpec.Http;
using DeveloperServicesAPI.Models;

namespace DeveloperServicesPublicAPI.Routes.Apis;

@route("/apis")
@doc("List a collection of APIs.")
@get
op ListApis(...ListParams): ApiResponse<Collection<Api>>;

@route("/apis/{apiId}")
@doc("Get the details of the API specified by its identifier.")
@get
op GetApi(
  ...CommonParams,
  @header accept?: ContentTypes,
  @query export?: boolean
): ApiResponse<TypedBody<Api, ContentTypes>>;
//application/json should return Api

@route("/apis/{apiId}/schemas")
@doc("List a collection of APIs schemas.")
@get
op ListApiSchemas(
  ...CommonParams,
  ...ListParams
): ApiResponse<Collection<ApiSchema>>;

@route("/apis/{apiId}/schemas/{schemaId}")
@doc("Get the details of the APIs schema specified by its identifier.")
@get
op GetApiSchema(
  ...CommonParams,
  @path schemaId: string
): ApiResponse<ApiSchema>;

@route("/apis/{apiId}/authServers/oauth2")
@doc("List of OAuth 2.0 servers associated with the API.")
@get
op ListApiOAuth2Providers(
  ...CommonParams,
  ...ListParams
): ApiResponse<Collection<AuthorizationServer>>;

@route("/apis/{apiId}/authServers/oauth2/{providerId}")
@doc("Get OAuth 2.0 server specified by its identifier associated with the API.")
@get
op GetApiOAuth2Provider(
  ...CommonParams,
  @path providerId: string
): ApiResponse<AuthorizationServer>;

@route("/apis/{apiId}/authServers/openidconnect")
@doc("List of OpenID Connect servers associated with the API.")
@get
op ListApiOpenidProviders(
  ...CommonParams,
  ...ListParams
): ApiResponse<Collection<AuthorizationServer>>;

@route("/apis/{apiId}/authServers/openidconnect/{providerId}")
@doc("Get OpenID Connect server specified by its identifier associated with the API.")
@get
op GetApiOpenidProvider(
  ...CommonParams,
  @path providerId: string
): ApiResponse<AuthorizationServer>;

@route("/apis/{apiId}/products")
@doc("List of public products associated with the API.")
@get
op ListApiProducts(
  ...CommonParams,
  ...ListParams
): ApiResponse<Collection<Product>>;

@route("/apis/{apiId}/releases")
@doc("List of releases for the API.")
@get
op ListApiReleases(
  ...CommonParams,
  ...ListParams
): ApiResponse<Collection<ApiRelease>>;

@route("/apis/{apiId}/tags")
@doc("Tags of the API.")
@get
op ListApiTags(...CommonParams, ...ListParams): ApiResponse<Collection<Tag>>;

@route("/apis/{apiId}/hostnames")
@doc("Hostnames of the API.")
@get
op ListApiHostnames(
  ...CommonParams,
  ...ListParams
): ApiResponse<Collection<ApiHostname>>;

@route("/apis/{apiId}/operations")
@doc("Operations of the API.")
@get
op ListApiOperations(
  ...CommonParams,
  ...ListParams
): ApiResponse<Collection<Operation>>;

@route("/apis/{apiId}/operations/{operationId}")
@doc("Operation specified by its identifier of the API.")
@get
op GetApiOperation(
  ...CommonParams,
  @path operationId: string
): ApiResponse<Operation>;

@route("/apis/{apiId}/operations/{operationId}/tags")
@doc("Operation tags specified by its identifier of the API.")
@get
op ListApiOperationTags(
  ...CommonParams,
  ...ListParams,
  @path operationId: string
): ApiResponse<Collection<Tag>>;

//Definitions

model CommonParams {
  @path apiId: string;
}

model TypedBody<BodyType, ContentType> {
  @body body: BodyType;
  @header contentType: ContentType;
}

alias ContentTypes =
  | "application/json"
  | "application/vnd.sun.wadl+xml"
  | "application/wsdl+xml"
  | "application/vnd.swagger.doc+json"
  | "application/vnd.oai.openapi"
  | "application/vnd.oai.openapi+json";
