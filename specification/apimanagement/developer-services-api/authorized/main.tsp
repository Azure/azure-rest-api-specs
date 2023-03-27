import "@typespec/rest";
import "@typespec/openapi3";

//Routes
import "./routes/users.tsp";
import "./routes/confirmations.tsp";
import "./routes/delegation.tsp";
import "./routes/identities.tsp";
import "./routes/products.tsp";
import "./routes/apiVersionSets.tsp";
import "./routes/apis.tsp";
import "./routes/tags.tsp";

using TypeSpec.Http;

@useAuth(ApiKeyAuth<ApiKeyLocation.header, "Authorization">)
@service({
  title: "Developer Services API - Authorized",
  version: "2022-04-01-preview",
})
@doc("Developer Services API - Everything you need to display your APIs.")
namespace DeveloperServicesAuthorizedAPI;
