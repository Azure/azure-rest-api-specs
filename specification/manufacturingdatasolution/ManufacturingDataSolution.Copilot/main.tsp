import "@typespec/http";
import "@typespec/openapi3";
import "@typespec/versioning";
import "@azure-tools/typespec-azure-core";
import "./resources/query.tsp";
import "./resources/Operations.tsp";
import "./resources/Instructions.tsp";
import "./resources/ExampleQuery.tsp";
import "./resources/AliasDictionary.tsp";
import "./resources/Health.tsp";
import "./resources/TestQuery.tsp";
import "./resources/Feedback.tsp";

using TypeSpec.Http;
using TypeSpec.Rest;
using TypeSpec.Versioning;
using Azure.Core;
using Azure.Core.Traits;

//using MdsSolution.CopilotService.Health;
using MdsSolution.CopilotService.QueryService;
using MdsSolution.CopilotService.OperationStatus;
using MdsSolution.CopilotService.Instructions;
//using MdsSolution.CopilotService.ExampleQueryService;
using MdsSolution.CopilotService.AliasDictionary;
using MdsSolution.CopilotService.TestQueryService;

//#suppress "@azure-tools/typespec-azure-core/operation-missing-api-version" ""
//#suppress "@azure-tools/typespec-azure-core/documentation-required" ""
//#suppress "@azure-tools/typespec-azure-core/use-standard-operations" ""

@service({
  title: "Microsoft.Industry.Manufacturing.MDS.Copilot",
})
@server("https://localhost:8002") //TODO: Add the correct url
//TODO: Add the correct url
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
