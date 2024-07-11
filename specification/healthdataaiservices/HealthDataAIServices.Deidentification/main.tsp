import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

@useAuth(AadToken)
@service({
  title: "HealthDataAIServices.Deidentification Service",
})
@server(
  "https://{endpoint}",
  "Azure Health Deidentification Service",
  {
    @doc("Url of your Deid Service.")
    endpoint: string,
  }
)
@versioned(HealthDataAIServices.Deidentification.Versions)
namespace HealthDataAIServices.Deidentification;

@doc("The Azure Active Directory OAuth2 Flow")
model AadToken
  is OAuth2Auth<[
    {
      type: OAuth2FlowType.authorizationCode;
      authorizationUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/authorize";
      tokenUrl: "https://login.microsoftonline.com/common/oauth2/token";
      scopes: ["https://deid.azure.com/.default"];
    }
  ]>;

@doc("The HealthDataAIServices.Deidentification service versions.")
enum Versions {
  @doc("Public preview release version.")
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2024_07_12_preview: "2024-07-12-preview",
}
