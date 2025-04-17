import "@typespec/versioning";
import "./routes.tsp";

using TypeSpec.Http;
using TypeSpec.Versioning;

// Official Name: Azure Health Data Services de-identification service
@useAuth(AadToken)
@service(#{ title: "Azure Health Data Services de-identification service" })
@server(
  "{endpoint}",
  "De-identification Service service endpoint",
  {
    @doc("Url of your De-identification Service.")
    endpoint: url,
  }
)
@versioned(HealthDataAIServices.DeidServices.Versions)
namespace HealthDataAIServices.DeidServices;

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

@doc("Azure Health Data Services de-identification service versions.")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2024_11_15: "2024-11-15",
}
