import "@typespec/rest";
import "@typespec/openapi3";

//Resources
import "./routes/users.tsp";
import "./routes/confirmations.tsp";
import "./routes/delegation.tsp";

using TypeSpec.Http;

@useAuth(ApiKeyAuth<ApiKeyLocation.header, "Authorization">)
@service({
    title: "Developer Services API - Authorized",
    version: "2022-04-01-preview",
})
@doc("Developer Services API - Everything you need to display your APIs.")
namespace DeveloperServicesAuthorizedAPI;
