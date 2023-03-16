import "@typespec/rest";
import "@typespec/openapi3";
import "./resources/apis.tsp";

@service({
  title: "Developer Services API",
  version: "2022-04-01-preview",
})
@doc("Developer Services API - Everything you need to display your APIs.")
namespace DeveloperServicesAPI;
