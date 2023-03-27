import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@azure-tools/typespec-azure-core";

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
using TypeSpec.Versioning;
using Azure.Core;

@service({
  title: "Developer Services API - Public",
  version: "2022-04-01-preview",
})
@useDependency(Azure.Core.Versions.v1_0_Preview_2)
@doc("Developer Services API - Everything you need to display your APIs.")
namespace DeveloperServicesPublicApi;
