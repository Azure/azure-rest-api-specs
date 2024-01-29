import "@typespec/rest";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

#suppress "@azure-tools/typespec-azure-core/casing-style"
@useAuth(AadToken)
@service({
  title: "HealthDataAIServices.Deidentification Service",
})
@server(
  "https://{deid-service-uri}",
  "Azure Health Deidentification Service",
  {
    @doc("Uri of your Deid Service.")
    `deid-service-uri`: string,
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

#suppress "@azure-tools/typespec-azure-core/documentation-required"
@doc("The HealthDataAIServices.Deidentification service versions.")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2024_01_31_preview: "2024-01-31-preview",
}
