import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";

//Resources
import "./resources/users.tsp";
import "./resources/confirmations.tsp";
import "./resources/delegations.tsp";
import "./resources/identities.tsp";
import "./resources/products.tsp";
import "./resources/apiVersionSets.tsp";
import "./resources/apis.tsp";
import "./resources/tags.tsp";
import "./resources/reports.tsp";
import "./resources/subscriptions.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;

@useAuth(ApiKeyAuth<ApiKeyLocation.header, "Authorization">)
@service({
  title: "Developer Services API - Authorized",
  version: "2022-04-01-preview",
})
@server(
  "https://{serviceName}.data.azure-api.net",
  "Developer Services API service endpoint",
  {
    @doc("Service name")
    serviceName: string,
  }
)
@useDependency(Azure.Core.Versions.v1_0_Preview_2)
@doc("Developer Services API introduces endpoints to manage your developer portal APIs, users, subscriptions and more.")
namespace DeveloperServicesAuthorizedApi;
