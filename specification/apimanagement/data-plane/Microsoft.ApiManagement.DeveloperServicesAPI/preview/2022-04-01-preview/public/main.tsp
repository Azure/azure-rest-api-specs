import "@typespec/rest";
import "@typespec/openapi3";

//Resources
import "../resources/apis.tsp";
import "../resources/apiVersionSets.tsp";
import "../resources/configuration.tsp";
import "../resources/confirmations.tsp";
import "../resources/delegation.tsp";
import "../resources/identity.tsp";
import "../resources/products.tsp";
import "../resources/tags.tsp";
import "../resources/users.tsp";

using TypeSpec.Http;

@service({
    title: "Developer Services API - Public",
    version: "2022-04-01-preview",
})
@doc("Developer Services API - Everything you need to display your APIs.")
namespace DeveloperServicesPublicAPI;
