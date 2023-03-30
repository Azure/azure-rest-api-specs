import "@typespec/rest";
import "@azure-tools/typespec-azure-core";
import "../../models/common.tsp";
import "../../models/api.tsp";
import "../../models/authorizationServer.tsp";
import "../../models/product.tsp";
import "../../models/operation.tsp";
import "../../models/tag.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using Azure.Core;
using Azure.Core.Traits;
using DeveloperServicesApi.Models;

namespace DeveloperServicesPublicApi.Routes.Apis;

@doc("Apis resource model.")
@resource("apis")
model ApiResource extends Api {
  @doc("API identifier.")
  @key("apiId")
  @visibility("query")
  apiId: string;
}
interface Apis {
  @doc("List a collection of APIs.")
  listApis is ResourceList<
    ApiResource,
    ListQueryParametersTrait<DefaultListQueryParameters>
  >;

  @doc("Get the details of the API specified by its identifier.")
  getApi is ResourceRead<ApiResource>;
}

// @route("/apis/{apiId}")
// @doc("Get the details of the API specified by its identifier.")
// @get
// op GetApi(
//   ...CommonParams,

//   @doc("If sent, the API will be exported in the specified format.")
//   @header
//   accept?: ContentTypes,

//   @doc("If true, the API will be exported in the specified format.")
//   @query
//   export?: boolean
// ): ApiResponse<TypedBody<Api, ContentTypes>>;

@doc("Api schemas resource model.")
@resource("schemas")
@parentResource(ApiResource)
model ApiSchemaResource extends ApiSchema {
  @doc("Api schema identifier.")
  @key("schemaId")
  @visibility("query")
  schemaId: string;
}

interface ApiSchemas {
  @doc("List a collection of APIs schemas.")
  listApiSchemas is ResourceList<
    ApiSchemaResource,
    ListQueryParametersTrait<DefaultListQueryParameters>
  >;

  @doc("Get the details of the APIs schema specified by its identifier.")
  getApiSchema is ResourceRead<ApiSchemaResource>;
}

@doc("Api OAuth 2.0 servers resource model.")
@resource("authServers/oauth2")
@parentResource(ApiResource)
model ApiAuthServersOauth2Resource extends AuthorizationServer {
  @doc("OAuth 2.0 server identifier.")
  @key("providerId")
  @visibility("query")
  providerId: string;
}

interface ApiAuthServersOauth2 {
  @doc("List a collection of APIs OAuth 2.0 servers.")
  listApiAuthServersOauth2 is ResourceList<
    ApiAuthServersOauth2Resource,
    ListQueryParametersTrait<DefaultListQueryParameters>
  >;

  @doc("Get the details of the APIs OAuth 2.0 server specified by its identifier.")
  getApiAuthServersOauth2 is ResourceRead<ApiAuthServersOauth2Resource>;
}

@doc("Api OpenID Connect servers resource model.")
@resource("authServers/openidconnect")
@parentResource(ApiResource)
model ApiAuthServersOpenidconnectResource extends AuthorizationServer {
  @doc("OpenID Connect server identifier.")
  @key("providerId")
  @visibility("query")
  providerId: string;
}

interface ApiAuthServersOpenidconnect {
  @doc("List a collection of APIs OpenID Connect servers.")
  listApiAuthServersOpenidconnect is ResourceList<
    ApiAuthServersOpenidconnectResource,
    ListQueryParametersTrait<DefaultListQueryParameters>
  >;

  @doc("Get the details of the APIs OpenID Connect server specified by its identifier.")
  getApiAuthServersOpenidconnect is ResourceRead<ApiAuthServersOpenidconnectResource>;
}

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
