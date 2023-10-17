import "@typespec/rest";
import "../models/definition.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;
using DataApi.Models;
using DataApi.Resources.ApiVersions;

namespace DataApi.Resources.Definitions;

// Models /////////////////////////////////////////////////////////////////////

@doc("API Definition resource model.")
@resource("definitions")
@parentResource(ApiVersionResource)
model ApiDefinitionResource extends ApiDefinition {
  @doc("Definition identifier.")
  @key("apiDefinitionId")
  @visibility("query")
  apiDefinitionId: string;
}

alias ServiceTraits = SupportsRepeatableRequests &
SupportsConditionalRequests &
SupportsClientRequestId;

alias Operations = Azure.Core.ResourceOperations<ServiceTraits>;

interface ApiDefinitions {
  @doc("List a collection of API definitions.")
  listDefinitions is Operations.ResourceList<ApiDefinitionResource, ListQueryParametersTrait<StandardListQueryParameters & SelectQueryParameter>>;

  @doc("Get an API definition.")
  getDefinition is Operations.ResourceRead<ApiDefinitionResource>;

  @doc("Export an API specification.")
  exportSpecification is Operations.ResourceAction<ApiDefinitionResource, {}, TypeSpec.Http.AcceptedResponse>;
}