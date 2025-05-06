import "@typespec/http";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "@azure-tools/typespec-autorest";
import "./routes.tsp";
import "./models/emissioncalculation.tsp";
import "./models/factorlibrary.tsp";
import "./models/referencedata.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;

@useAuth(
  OAuth2Auth<[
    {
      type: OAuth2FlowType.clientCredentials,
      tokenUrl: "https://login.microsoftonline.com/common/oauth2/v2.0/token",
    }
  ]>
)
@service(#{ title: "Microsoft.SustainabilityServices" })
@versioned(Versions)
@server(
  "{endpoint}",
  "These APIs allow end users to run the calculate the carbon emissions for the activities.",
  {
    endpoint: url,
  }
)
@versioned(Microsoft.SustainabilityServices.Versions)
namespace Microsoft.SustainabilityServices;

@doc("Supported API versions for the Microsoft.SustainabilityServices.")
enum Versions {
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  @doc("The 2025-01-01-preview version of the Microsoft.SustainabilityServices.")
  v2025_01_01_preview: "2025-01-01-preview",
}
