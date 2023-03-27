import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";

//Routes
import "./routes/users.tsp";
import "./routes/confirmations.tsp";
import "./routes/delegation.tsp";
import "./routes/identities.tsp";
import "./routes/products.tsp";
import "./routes/apiVersionSets.tsp";
import "./routes/apis.tsp";
import "./routes/tags.tsp";
import "./routes/reports.tsp";
import "./routes/subscriptions.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;
using Azure.Core;

@useAuth(ApiKeyAuth<ApiKeyLocation.header, "Authorization">)
@service({
  title: "Developer Services API - Authorized",
  version: "2022-04-01-preview",
})
@useDependency(Azure.Core.Versions.v1_0_Preview_2)
@doc("Developer Services API - Everything you need to display your APIs.")
namespace DeveloperServicesAuthorizedApi;
