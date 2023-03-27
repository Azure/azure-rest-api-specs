import "@typespec/rest";
import "@typespec/openapi3";

//Routes
import "./routes/apis.tsp";
import "./routes/apiVersionSets.tsp";
import "./routes/configuration.tsp";
import "./routes/confirmations.tsp";
import "./routes/delegation.tsp";
import "./routes/identity.tsp";
import "./routes/products.tsp";
import "./routes/tags.tsp";
import "./routes/users.tsp";

using TypeSpec.Http;

@service({
  title: "Developer Services API - Public",
  version: "2022-04-01-preview",
})
@doc("Developer Services API - Everything you need to display your APIs.")
namespace DeveloperServicesPublicAPI;
