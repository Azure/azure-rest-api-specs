import "@typespec/rest";
import "../../models/common.tsp";
import "../../models/api.tsp";
import "../../models/authorizationServer.tsp";
import "../../models/product.tsp";
import "../../models/operation.tsp";
import "../../models/tag.tsp";
import "../common.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using DeveloperServicesApi.Models;
using DeveloperServicesAuthorizedApi.Common;

namespace DeveloperServicesAuthorizedApi.Resources.Apis;

interface Apis {
  @doc("List a collection of APIs.")
  listApis is ResourceList<
    ApiResource,
    ListQueryParametersTrait<DefaultListQueryParameters>
  >;

  @doc("Get the details of the API specified by its identifier.")
  getApi is ResourceRead<
    ApiResource,
    ParametersTrait<{
      @doc("If true, the API will be exported in the specified format.")
      @query
      export?: boolean;

      @doc("If sent, the API will be exported in the specified format.")
      @header
      accept?: ContentTypes;
    }>
  >;
  //TODO: is it correct?

  @doc("List a collection of APIs schemas.")
  listApiSchemas is ResourceList<
    ApiSchemaResource,
    ListQueryParametersTrait<DefaultListQueryParameters>
  >;

  @doc("Get the details of the APIs schema specified by its identifier.")
  getApiSchema is ResourceRead<ApiSchemaResource>;

  @doc("List a collection of APIs OAuth 2.0 servers.")
  listApiAuthServersOauth2 is ResourceList<
    ApiAuthServersOauth2Resource,
    ListQueryParametersTrait<DefaultListQueryParameters>
  >;

  @doc("Get the details of the APIs OAuth 2.0 server specified by its identifier.")
  getApiAuthServersOauth2 is ResourceRead<ApiAuthServersOauth2Resource>;

  @doc("List a collection of APIs OpenID Connect servers.")
  listApiAuthServersOpenidconnect is ResourceList<
    ApiAuthServersOpenidconnectResource,
    ListQueryParametersTrait<DefaultListQueryParameters>
  >;

  @doc("Get the details of the APIs OpenID Connect server specified by its identifier.")
  getApiAuthServersOpenidconnect is ResourceRead<ApiAuthServersOpenidconnectResource>;

  @doc("List a collection of APIs products.")
  listApiProducts is ResourceList<
    ApiProductResource,
    ListQueryParametersTrait<DefaultListQueryParameters>
  >;

  @doc("List a collection of APIs releases.")
  listApiReleases is ResourceList<
    ApiReleaseResource,
    ListQueryParametersTrait<DefaultListQueryParameters>
  >;

  @doc("List a collection of APIs tags.")
  listApiTags is ResourceList<
    ApiTagResource,
    ListQueryParametersTrait<DefaultListQueryParameters>
  >;

  @doc("List a collection of APIs hostnames.")
  listApiHostnames is ResourceList<
    ApiHostnameResource,
    ListQueryParametersTrait<DefaultListQueryParameters>
  >;

  @doc("List a collection of APIs operations.")
  listApiOperations is ResourceList<
    ApiOperationResource,
    ListQueryParametersTrait<DefaultListQueryParameters>
  >;

  @doc("Get the details of the APIs operation specified by its identifier.")
  getApiOperation is ResourceRead<ApiOperationResource>;

  @doc("List a collection of APIs operation tags.")
  listApiOperationTags is ResourceList<
    ApiOperationTagResource,
    ListQueryParametersTrait<DefaultListQueryParameters>
  >;
}

@doc("Apis resource model.")
@resource("apis")
@parentResource(UserResource)
model ApiResource extends Api {
  @doc("API identifier.")
  @key("apiId")
  @visibility("query")
  apiId: string;
}

@doc("Api schemas resource model.")
@resource("schemas")
@parentResource(ApiResource)
model ApiSchemaResource extends ApiSchema {
  @doc("Api schema identifier.")
  @key("schemaId")
  @visibility("query")
  schemaId: string;
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

@doc("Api OpenID Connect servers resource model.")
@resource("authServers/openidconnect")
@parentResource(ApiResource)
model ApiAuthServersOpenidconnectResource extends AuthorizationServer {
  @doc("OpenID Connect server identifier.")
  @key("providerId")
  @visibility("query")
  providerId: string;
}

@doc("Api products resource model.")
@resource("products")
@parentResource(ApiResource)
model ApiProductResource extends Product {
  @doc("Product identifier.")
  @key("productId")
  @visibility("query")
  productId: string;
}

@doc("Api releases resource model.")
@resource("releases")
@parentResource(ApiResource)
model ApiReleaseResource extends ApiRelease {
  @doc("Release identifier.")
  @key("releaseId")
  @visibility("query")
  releaseId: string;
}

@doc("Api tags resource model.")
@resource("tags")
@parentResource(ApiResource)
model ApiTagResource extends Tag {
  @doc("Tag identifier.")
  @key("tagId")
  @visibility("query")
  tagId: string;
}

@doc("Api hostnames resource model.")
@resource("hostnames")
@parentResource(ApiResource)
model ApiHostnameResource extends ApiHostname {
  @doc("Hostname identifier.")
  @key("hostnameId")
  @visibility("query")
  hostnameId: string;
}

@doc("Api operations resource model.")
@resource("operations")
@parentResource(ApiResource)
model ApiOperationResource extends Operation {
  @doc("Operation identifier.")
  @key("operationId")
  @visibility("query")
  operationId: string;
}

@doc("Api operation tags resource model.")
@resource("tags")
@parentResource(ApiOperationResource)
model ApiOperationTagResource extends Tag {
  @doc("Tag identifier.")
  @key("tagId")
  @visibility("query")
  tagId: string;
}
