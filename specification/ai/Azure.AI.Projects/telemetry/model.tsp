import "@typespec/rest";
import "@azure-tools/typespec-autorest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@typespec/openapi";
import "@typespec/versioning";

using TypeSpec.OpenAPI;
using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

namespace Azure.AI.Projects;

@doc("Response from getting properties of the Application Insights resource")
model GetAppInsightsResponse {
  @doc("A unique identifier for the resource")
  id: string;

  @doc("The name of the resource")
  name: string;

  @doc("The properties of the resource")
  properties: AppInsightsProperties;
}

@doc("The properties of the Application Insights resource")
model AppInsightsProperties {
  @doc("Authentication type of the connection target")
  ConnectionString: string;
}
