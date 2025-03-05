import "@typespec/http";
import "@typespec/openapi3";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./resources/queryApi.tsp";
import "./resources/operationsApi.tsp";
import "./resources/instructionsApi.tsp";
import "./resources/exampleQueryApi.tsp";
import "./resources/aliasDictionaryApi.tsp";
import "./resources/healthApi.tsp";
import "./resources/validateQueryApi.tsp";
import "./resources/feedbackApi.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

//#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" ""
//#suppress "@azure-tools/typespec-azure-core/documentation-required" ""
//#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""

@service(#{ title: "Microsoft.Industry.Manufacturing.MDS.Copilot" })

@server(
  "https://mds-{mdsUniqueId}.{location}.cloudapp.azure.com/",
  "Manufacturing Data Solution global endpoint.",
  {
    mdsUniqueId: string,
    location: string = "mds.azure.com",
  }
)

@useAuth(AadOauth2Auth<["https://azure-mds-service/.default"]>)

// as per doc https://azure.github.io/typespec-azure/docs/getstarted/azure-core/step10/#versioning-your-service
@versioned(MdsSolution.CopilotService.Versions)
namespace MdsSolution.CopilotService;

// API versions
enum Versions {
  // azure core version - Change if we are using a different version
  @useDependency(Azure.Core.Versions.v1_0_Preview_2)
  v2025_03_01: "2025-03-01",
}
